
/// List of all teleport runes
GLOBAL_LIST(teleport_runes)
/// Assoc list of every rune that can be drawn by ritual daggers. [rune_name] = [typepath]
GLOBAL_LIST_INIT(rune_types, generate_cult_rune_types())

/// Returns an associated list of rune types. [rune.cultist_name] = [typepath]
/proc/generate_cult_rune_types()
	RETURN_TYPE(/list)

	var/list/runes = list()
	for(var/obj/effect/rune/rune as anything in subtypesof(/obj/effect/rune))
		if(!initial(rune.can_be_scribed))
			continue
		runes[initial(rune.cultist_name)] = rune // Uses the cultist name for displaying purposes

	return runes

/*

This file contains runes.
Runes are used by the cult to cause many different effects and are paramount to their success.
They are drawn with a ritual dagger in blood, and are distinguishable to cultists and normal crew by examining.
Fake runes can be drawn in crayon to fool people.
Runes can either be invoked by one's self or with many different cultists. Each rune has a specific incantation that the cultists will say when invoking it.


*/

/obj/effect/rune
	name = "符文"
	desc = "一堆奇怪的符号，看上去像是用血画成的。"
	anchored = TRUE
	icon = 'icons/obj/antags/cult/rune.dmi'
	icon_state = "1"
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	plane = FLOOR_PLANE
	layer = RUNE_LAYER
	color = RUNE_COLOR_RED

	/// The name of the rune to cultists
	var/cultist_name = "basic rune"
	/// The description of the rune shown to cultists who examine it
	var/cultist_desc = "一枚没有任何功能的基础符文。"
	/// This is said by cultists when the rune is invoked.
	var/invocation = "Aiy ele-mayo!"
	/// The amount of cultists required around the rune to invoke it.
	var/req_cultists = 1
	/// If we have a description override for required cultists to invoke
	var/req_cultists_text
	/// Used for some runes, this is for when you want a rune to not be usable when in use.
	var/rune_in_use = FALSE
	/// Used when you want to keep track of who erased the rune
	var/log_when_erased = FALSE
	/// Whether this rune can be scribed or if it's admin only / special spawned / whatever
	var/can_be_scribed = TRUE
	/// How long the rune takes to erase
	var/erase_time = 1.5 SECONDS
	/// How long the rune takes to create
	var/scribe_delay = 4 SECONDS
	/// If a rune cannot be speed boosted while scribing on certain turfs
	var/no_scribe_boost = FALSE
	/// Hhow much damage you take doing it
	var/scribe_damage = 0.1
	/// How much damage invokers take when invoking it
	var/invoke_damage = 0
	/// If constructs can invoke it
	var/construct_invoke = TRUE
	/// If the rune requires a keyword when scribed
	var/req_keyword = FALSE
	/// The actual keyword for the rune
	var/keyword
	/// Global proc to call while the rune is being created
	var/started_creating
	/// Global proc to call if the rune fails to be created
	var/failed_to_create

/obj/effect/rune/Initialize(mapload, set_keyword)
	. = ..()
	if(set_keyword)
		keyword = set_keyword
	var/image/I = image(icon = 'icons/effects/blood.dmi', icon_state = null, loc = src)
	I.override = TRUE
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/silicons, "cult_runes", I)
	ADD_TRAIT(src, TRAIT_MOPABLE, INNATE_TRAIT)

/obj/effect/rune/examine(mob/user)
	. = ..()
	if(IS_CULTIST(user) || user.stat == DEAD) //If they're a cultist or a ghost, tell them the effects
		. += "<b>名称：</b> [cultist_name]\n"+\
		"<b>效果：</b> [capitalize(cultist_desc)]\n"+\
		"<b>所需侍僧：</b> [req_cultists_text ? "[req_cultists_text]":"[req_cultists]"]"
		if(req_keyword && keyword)
			. += "<b>关键词：</b> [keyword]"

/obj/effect/rune/attack_paw(mob/living/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/effect/rune/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!IS_CULTIST_OR_CULTIST_MOB(user))
		to_chat(user, span_warning("你无法理解[src]上的文字。"))
		return
	var/list/invokers = can_invoke(user)
	if(length(invokers) >= req_cultists)
		invoke(invokers)
		SSblackbox.record_feedback("tally", "cult_rune_invoke", 1, "[name]")
	else
		to_chat(user, span_danger("你还需要 [req_cultists - length(invokers)] 名相邻的血教徒，才能以这种方式使用这枚符文。"))
		fail_invoke()

/obj/effect/rune/attack_animal(mob/living/user, list/modifiers)
	if(!isshade(user) && !isconstruct(user))
		return
	if(HAS_TRAIT(user, TRAIT_ANGELIC))
		to_chat(user, span_warning("你净化了这枚符文！"))
		qdel(src)
	else if(construct_invoke || !IS_CULTIST(user)) //if you're not a cult construct we want the normal fail message
		attack_hand(user)
	else
		to_chat(user, span_warning("你无法激活这枚符文！"))

/obj/effect/rune/proc/conceal() //for talisman of revealing/hiding
	visible_message(span_danger("[src]渐渐消散。"))
	SetInvisibility(INVISIBILITY_OBSERVER, id=type)
	alpha = 100 //To help ghosts distinguish hidden runes

/obj/effect/rune/proc/reveal() //for talisman of revealing/hiding
	RemoveInvisibility(type)
	visible_message(span_danger("[src]突然显现！"))
	alpha = initial(alpha)

/*

There are a few different procs each rune runs through when a cultist activates it.
can_invoke() is called when a cultist activates the rune with an empty hand. If there are multiple cultists, this rune determines if the required amount is nearby.
invoke() is the rune's actual effects.
fail_invoke() is called when the rune fails, via not enough people around or otherwise. Typically this just has a generic 'fizzle' effect.
structure_check() searches for nearby cultist structures required for the invocation. Proper structures are pylons, forges, archives, and altars.

*/

/obj/effect/rune/proc/can_invoke(mob/living/user=null)
	//This proc determines if the rune can be invoked at the time. If there are multiple required cultists, it will find all nearby cultists.
	var/list/invokers = list() //people eligible to invoke the rune
	if(user)
		invokers += user
	if(req_cultists > 1 || istype(src, /obj/effect/rune/convert))
		for(var/mob/living/cultist in range(1, src))
			if(!IS_CULTIST(cultist))
				continue
			var/datum/antagonist/cult/cultist_datum = locate(/datum/antagonist/cult) in cultist.mind.antag_datums
			if(!cultist_datum.check_invoke_validity()) //We can assume there's a datum here since we can't get past the previous check otherwise.
				continue
			if(cultist == user)
				continue
			if(!cultist.can_speak(allow_mimes = TRUE))
				continue
			if(IS_UNCONSCIOUS_OR_CRIT(cultist))
				continue
			invokers += cultist

	return invokers

/obj/effect/rune/proc/invoke(list/invokers)
	//This proc contains the effects of the rune as well as things that happen afterwards. If you want it to spawn an object and then delete itself, have both here.
	for(var/atom/invoker in invokers)
		if(istype(invoker, /obj/item/toy/plush/narplush))
			invoker.visible_message(span_cult_italic("[src]发出响亮的吱吱声！"))
			continue
		if(!isliving(invoker))
			continue
		var/mob/living/living_invoker = invoker
		if(invocation)
			living_invoker.say(invocation, language = /datum/language/common, ignore_spam = TRUE, forced = "cult invocation")
		if(invoke_damage)
			living_invoker.apply_damage(invoke_damage, BRUTE)
			to_chat(living_invoker,  span_cult_italic("[src]抽走了你的力量！"))

	do_invoke_glow()

/obj/effect/rune/proc/do_invoke_glow()
	set waitfor = FALSE
	animate(src, transform = matrix()*2, alpha = 0, time = 5, flags = ANIMATION_END_NOW) //fade out
	sleep(0.5 SECONDS)
	animate(src, transform = matrix(), alpha = 255, time = 0, flags = ANIMATION_END_NOW)

/obj/effect/rune/proc/fail_invoke()
	//This proc contains the effects of a rune if it is not invoked correctly, through either invalid wording or not enough cultists. By default, it's just a basic fizzle.
	visible_message(span_warning("符文纹路闪了一下红光，随即暗淡下去。"))
	var/oldcolor = color
	color = rgb(255, 0, 0)
	animate(src, color = oldcolor, time = 5)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom, update_atom_colour)), 0.5 SECONDS)

//Malformed Rune: This forms if a rune is not drawn correctly. Invoking it does nothing but hurt the user.
/obj/effect/rune/malformed
	cultist_name = "malformed rune"
	cultist_desc = "一枚用胡言乱语写成的无意义符文。激活它不会有什么好结果。"
	invocation = "Ra'sha yoka!"
	invoke_damage = 30
	can_be_scribed = FALSE
	var/randomized = TRUE

/obj/effect/rune/malformed/Initialize(mapload, set_keyword)
	. = ..()
	if(!randomized)
		return
	icon_state = "[rand(1,7)]"
	color = rgb(rand(0,255), rand(0,255), rand(0,255))

/obj/effect/rune/malformed/invoke(list/invokers)
	..()
	qdel(src)

/obj/effect/rune/malformed/norandom
	randomized = FALSE

//Rite of Offering: Converts or sacrifices a target.
/obj/effect/rune/convert
	cultist_name = "Offer"
	cultist_desc = "将它上方的非教徒献给纳尔西，或将其转化，或将其献祭。"
	req_cultists_text = "转化需要 2 人，献祭活人与献祭目标需要 3 人。"
	invocation = "Mah'weyh pleggh at e'ntrath!"
	icon_state = "3"
	color = RUNE_COLOR_OFFER
	req_cultists = 1
	rune_in_use = FALSE

/obj/effect/rune/convert/do_invoke_glow()
	return

/obj/effect/rune/convert/invoke(list/invokers)
	if(rune_in_use)
		return

	var/list/myriad_targets = list()
	for(var/mob/living/non_cultist in loc)
		if(!IS_CULTIST(non_cultist))
			myriad_targets += non_cultist

	if(!length(myriad_targets) && !try_sacrifice_item())
		fail_invoke()
		return

	rune_in_use = TRUE
	visible_message(span_warning("[src]泛起血红色的脉动！"))
	color = RUNE_COLOR_DARKRED

	if(length(myriad_targets))
		var/mob/living/new_convertee = pick(myriad_targets)
		var/mob/living/first_invoker = invokers[1]
		var/datum/antagonist/cult/first_invoker_datum = first_invoker.mind.has_antag_datum(/datum/antagonist/cult)
		var/datum/team/cult/cult_team = first_invoker_datum.get_team()

		var/is_convertable = is_convertable_to_cult(new_convertee, cult_team)
		if(new_convertee.stat != DEAD && is_convertable)
			invocation = "Mah'weyh pleggh at e'ntrath!"
			..()
			do_convert(new_convertee, invokers, cult_team)

		else
			invocation = "Barhah hra zar'garis!"
			..()
			do_sacrifice(new_convertee, invokers, cult_team)

		cult_team.check_size() // Triggers the eye glow or aura effects if the cult has grown large enough relative to the crew

	else
		do_invoke_glow()

	animate(src, color = initial(color), time = 0.5 SECONDS)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom, update_atom_colour)), 0.5 SECONDS)
	rune_in_use = FALSE
	return ..()

/obj/effect/rune/convert/proc/do_convert(mob/living/convertee, list/invokers, datum/team/cult/cult_team)
	ASSERT(convertee.mind)

	if(length(invokers) < 2)
		for(var/invoker in invokers)
			to_chat(invoker, span_warning("至少需要两名激活者才能转化[convertee]！"))
		return FALSE

	if(convertee.can_block_magic(MAGIC_RESISTANCE|MAGIC_RESISTANCE_HOLY, charge_cost = 0)) //No charge_cost because it can be spammed
		for(var/invoker in invokers)
			to_chat(invoker, span_warning("有什么东西在庇护[convertee]的心智！"))
		return FALSE

	var/brutedamage = convertee.get_brute_loss()
	var/burndamage = convertee.get_fire_loss()
	if(brutedamage || burndamage)
		convertee.adjust_brute_loss(-(brutedamage * 0.75))
		convertee.adjust_fire_loss(-(burndamage * 0.75))

	convertee.visible_message(
		span_warning("[convertee]痛苦地扭动着，[(brutedamage || burndamage) \
			? "身上的伤口正在愈合收拢" \
			: "脚下的符文泛着血红色的光"]！"),
		span_cult_large("<i>AAAAAAAAAAAAAA-</i>"),
	)

	// We're not guaranteed to be a human but we'll cast here since we use it in a few branches
	var/mob/living/carbon/human/human_convertee = convertee

	if(istype(human_convertee)) //remove the slurring/stuttering/silence before the april fools punch line reference
		human_convertee.uncuff()
		human_convertee.remove_status_effect(/datum/status_effect/silenced)
		human_convertee.remove_status_effect(/datum/status_effect/speech/slurring/cult)
		human_convertee.remove_status_effect(/datum/status_effect/speech/stutter)

	if(check_holidays(APRIL_FOOLS) && prob(10))
		convertee.Paralyze(10 SECONDS)
		convertee.say("你这狗娘养的！我入伙了。", forced = "That son of a bitch! They're in. (April Fools)")

	else
		convertee.Unconscious(10 SECONDS)

	new /obj/item/melee/cultblade/dagger(get_turf(src))
	convertee.mind.add_antag_datum(/datum/antagonist/cult, cult_team)

	to_chat(convertee, span_cult_bold_italic("你的血液在跳动。你的头颅在悸动。世界变成一片赤红。\
		刹那之间，你意识到一个无比可怕的真相。现实的帷幕已被撕开，\
		某种邪恶之物正在扎根。"))
	to_chat(convertee, span_cult_bold_italic("协助你的新同伴进行他们的黑暗交易。\
		你的目标就是他们的目标，他们的目标也是你的。你首先效忠于几何之神。把它带回来。"))

	if(isshade(convertee))
		convertee.icon_state = "shade_cult"
		convertee.name = convertee.real_name
	return TRUE

/obj/effect/rune/convert/proc/do_sacrifice(mob/living/sacrificial, list/invokers, datum/team/cult/cult_team)
	var/target_sac = FALSE
	if((((ishuman(sacrificial) || iscyborg(sacrificial)) && sacrificial.stat != DEAD) || cult_team.is_sacrifice_target(sacrificial.mind)) && length(invokers) < 3)
		for(var/invoker in invokers)
			to_chat(invoker, span_cult_italic("[sacrificial]与现世的联系过于紧密！你需要三名侍僧！"))
		return FALSE

	if(sacrificial.mind)
		LAZYADD(GLOB.sacrificed, WEAKREF(sacrificial.mind))
		for(var/datum/objective/sacrifice/sac_objective in cult_team.objectives)
			if(sac_objective.target == sacrificial.mind)
				sac_objective.sacced = TRUE
				sac_objective.clear_sacrifice()
				sac_objective.update_explanation_text()
				target_sac = TRUE
	else
		LAZYADD(GLOB.sacrificed, WEAKREF(sacrificial))

	new /obj/effect/temp_visual/cult/sac(loc)

	var/signal_result = SEND_SIGNAL(sacrificial, COMSIG_LIVING_CULT_SACRIFICED, invokers, cult_team)

	var/do_message = TRUE
	if(signal_result & SILENCE_SACRIFICE_MESSAGE)
		do_message = FALSE
	if((signal_result & SILENCE_NONTARGET_SACRIFICE_MESSAGE) && !(target_sac))
		do_message = FALSE

	if(do_message)
		for(var/invoker in invokers)
			if(target_sac)
				to_chat(invoker, span_cult_large("\"好！这正是我渴望的那一个！你做得很好。\""))
				continue
			if(ishuman(sacrificial) || iscyborg(sacrificial))
				to_chat(invoker, span_cult_large("\"我接受这份献祭。\""))
			else
				to_chat(invoker, span_cult_large("\"我接受这份微薄的献祭。\""))

	// post-message
	if(signal_result & STOP_SACRIFICE)
		return FALSE

	if(iscyborg(sacrificial))
		var/construct_class = show_radial_menu(invokers[1], sacrificial, GLOB.construct_radial_images, require_near = TRUE, tooltips = TRUE)
		if(QDELETED(sacrificial) || !construct_class)
			return FALSE
		sacrificial.grab_ghost()
		make_new_construct_from_class(construct_class, THEME_CULT, sacrificial, invokers[1], TRUE, get_turf(src))
		var/mob/living/silicon/robot/sacriborg = sacrificial
		sacrificial.log_message("was sacrificed as a cyborg.", LOG_GAME)
		sacriborg.mmi = null
		qdel(sacrificial)
		return TRUE
	if(sacrificial && (signal_result & DUST_SACRIFICE)) // No soulstone when dusted
		playsound(sacrificial, 'sound/effects/magic/teleport_diss.ogg', 100, TRUE)
		sacrificial.investigate_log("has been sacrificially dusted by the cult.", INVESTIGATE_DEATHS)
		sacrificial.dust(TRUE, FALSE, TRUE)
	else if (sacrificial)
	//BUBBER EDIT BEGIN: removes force gib from cult
		if(!HAS_TRAIT(sacrificial, TRAIT_HAS_BEEN_CULT_SACRIFICED))
			ADD_TRAIT(sacrificial, TRAIT_HAS_BEEN_CULT_SACRIFICED, MAGIC_TRAIT)
			var/obj/item/soulstone/stone = new(loc)

			var/shard_choice = tgui_alert(
				user = sacrificial,
				message = "你愿意成为血教的灵魂碎片吗？选择“是”会让你被粉碎，之后你将作为灵魂碎片行动；选择“否”会让你化为干尸，但身体会保持完整。",
				title = "选择你的命运",
				buttons = list("Decline", "Accept"),
				timeout = 10 SECONDS,
				autofocus = TRUE
				)
			if(shard_choice == "Accept")
				if(sacrificial.mind && !HAS_TRAIT(sacrificial, TRAIT_SUICIDED))
					stone.capture_soul(sacrificial,  invokers[1], forced = TRUE)
				playsound(sacrificial, 'sound/effects/magic/disintegrate.ogg', 100, TRUE)
				sacrificial.investigate_log("has been sacrificially gibbed by the cult.", INVESTIGATE_DEATHS)
				sacrificial.gib(DROP_ALL_REMAINS)
			else
				sacrificial.death(FALSE)
				sacrificial.become_husk(BURN)
				sacrificial.investigate_log("has been sacrificially husked by the cult.", INVESTIGATE_DEATHS)
				stone.capture_ghost(sacrificial, invokers[1])
		else
			sacrificial.death(FALSE)
			sacrificial.become_husk(BURN)
			sacrificial.investigate_log("has been sacrificially husked by the cult.", INVESTIGATE_DEATHS)
		//BUBBER EDIT END

	try_sacrifice_item() // after sharding and gibbing, which potentially dropped a sacrificable item

	return TRUE

/// Tries to convert a valid item over the rune to something else
/obj/effect/rune/convert/proc/try_sacrifice_item()
	for(var/obj/item/checked_item in loc)
		if(checked_item.anchored || (checked_item.resistance_flags & INDESTRUCTIBLE))
			continue

		if(SEND_SIGNAL(checked_item, COMSIG_ITEM_CULT_SACRIFICE, src) & COMPONENT_SACRIFICE_SUCCESSFUL)
			return TRUE

	return FALSE

/// Does an animation of a sacrificable item transforming into something else
/obj/effect/rune/convert/proc/animate_convert_item(obj/item/old_item, new_movable_typepath)
	playsound(src, 'sound/effects/magic.ogg', 33, vary = TRUE, extrarange = SILENCED_SOUND_EXTRARANGE, frequency = 0.66)
	old_item.anchored = TRUE
	old_item.Shake()
	animate(old_item, alpha = 0, transform = matrix(old_item.transform).Scale(0.01), time = 2 SECONDS, easing = BOUNCE_EASING, flags = ANIMATION_PARALLEL)
	QDEL_IN(old_item, 2 SECONDS)

	var/atom/movable/new_movable = new new_movable_typepath(loc)
	var/matrix/matrix_on_spawn = matrix(new_movable.transform)
	new_movable.name = "被转化的[new_movable.name]"
	new_movable.anchored = TRUE
	new_movable.alpha = 0
	new_movable.transform = matrix(new_movable.transform).Scale(0.01)
	new_movable.Shake()
	animate(new_movable, alpha = 255, transform = matrix_on_spawn, time = 2 SECONDS, easing = BOUNCE_EASING, flags = ANIMATION_PARALLEL)
	addtimer(VARSET_CALLBACK(new_movable, anchored, FALSE), 2 SECONDS)

/obj/effect/rune/empower
	cultist_name = "Empower"
	cultist_desc = "使血教徒能以远低于平常的代价准备更多血魔法。"
	invocation = "H'drak v'loso, mir'kanas verbot!"
	icon_state = "3"
	color = RUNE_COLOR_TALISMAN
	construct_invoke = FALSE

/obj/effect/rune/empower/invoke(list/invokers)
	. = ..()
	var/mob/living/user = invokers[1] //the first invoker is always the user
	for(var/datum/action/innate/cult/blood_magic/BM in user.actions)
		BM.Activate()

/obj/effect/rune/teleport
	cultist_name = "Teleport"
	cultist_desc = "将它上方的一切传送到另一枚选定的传送符文。"
	invocation = "Sas'so c'arta forbici!"
	icon_state = "2"
	color = RUNE_COLOR_TELEPORT
	req_keyword = TRUE
	light_power = 4
	var/obj/effect/temp_visual/cult/portal/inner_portal //The portal "hint" for off-station teleportations
	var/obj/effect/temp_visual/cult/rune_spawn/rune2/outer_portal
	var/listkey


/obj/effect/rune/teleport/Initialize(mapload, set_keyword)
	. = ..()
	var/area/A = get_area(src)
	var/locname = initial(A.name)
	listkey = set_keyword ? "[set_keyword] [locname]":"[locname]"
	LAZYADD(GLOB.teleport_runes, src)

/obj/effect/rune/teleport/Destroy()
	LAZYREMOVE(GLOB.teleport_runes, src)
	if(inner_portal)
		QDEL_NULL(inner_portal)
	if(outer_portal)
		QDEL_NULL(outer_portal)
	return ..()

/obj/effect/rune/teleport/invoke(list/invokers)
	var/mob/living/user = invokers[1] //the first invoker is always the user
	var/list/potential_runes = list()
	var/list/teleportnames = list()
	for(var/obj/effect/rune/teleport/teleport_rune as anything in GLOB.teleport_runes)
		if(teleport_rune != src && !is_away_level(teleport_rune.z))
			potential_runes[avoid_assoc_duplicate_keys(teleport_rune.listkey, teleportnames)] = teleport_rune

	if(!length(potential_runes))
		to_chat(user, span_warning("没有可供传送的有效符文！"))
		log_game("Teleport rune activated by [user] at [COORD(src)] failed - no other teleport runes.")
		fail_invoke()
		return

	var/turf/T = get_turf(src)
	if(is_away_level(T.z))
		to_chat(user, span_cult_italic("你不在正确的维度中！"))
		log_game("Teleport rune activated by [user] at [COORD(src)] failed - [user] is in away mission.")
		fail_invoke()
		return

	var/input_rune_key = tgui_input_list(user, "要传送到哪枚符文", "传送目标", potential_runes) //we know what key they picked
	if(isnull(input_rune_key))
		return
	if(isnull(potential_runes[input_rune_key]))
		fail_invoke()
		return
	var/obj/effect/rune/teleport/actual_selected_rune = potential_runes[input_rune_key] //what rune does that key correspond to?
	if(!Adjacent(user) || QDELETED(src) || user.incapacitated || !actual_selected_rune)
		fail_invoke()
		return

	var/turf/target = get_turf(actual_selected_rune)
	if(target.is_blocked_turf(TRUE))
		to_chat(user, span_warning("目标符文被阻挡。试图传送过去将极其不明智。"))
		log_game("Teleport rune activated by [user] at [COORD(src)] failed - destination blocked.")
		fail_invoke()
		return
	var/movedsomething = FALSE
	var/moveuserlater = FALSE
	var/movesuccess = FALSE
	for(var/atom/movable/A in T)
		if(istype(A, /obj/effect/dummy/phased_mob))
			continue
		if(ismob(A))
			if(!isliving(A)) //Let's not teleport ghosts and AI eyes.
				continue
			if(ishuman(A))
				new /obj/effect/temp_visual/dir_setting/cult/phase/out(T, A.dir)
				new /obj/effect/temp_visual/dir_setting/cult/phase(target, A.dir)
		if(A == user)
			moveuserlater = TRUE
			movedsomething = TRUE
			continue
		if(!A.anchored)
			movedsomething = TRUE
			if(do_teleport(A, target, channel = TELEPORT_CHANNEL_CULT))
				movesuccess = TRUE
	if(movedsomething)
		..()
		playsound(src, SFX_PORTAL_ENTER, 50, TRUE)
		playsound(target, SFX_PORTAL_ENTER, 50, TRUE)
		if(moveuserlater)
			if(do_teleport(user, target, channel = TELEPORT_CHANNEL_CULT))
				movesuccess = TRUE
		if(movesuccess)
			visible_message(span_warning("一声尖锐的破空声响起，符文上方的一切都消失了！"), null, "<i>你听到一声尖锐的爆裂声。</i>")
			to_chat(user, span_cult("你[moveuserlater ? "的视野一阵模糊，随即突然出现在别处" : "把符文上方的一切都送走了"]。"))
		else
			to_chat(user, span_cult("你[moveuserlater ? "的视野短暂模糊，但什么也没有发生" : "试图把符文上方的一切送走，但传送失败了"]。"))
		if(is_mining_level(z) && !is_mining_level(target.z)) //No effect if you stay on lavaland
			actual_selected_rune.handle_portal("lava")
		else
			var/area/A = get_area(T)
			if(initial(A.name) == "Space")
				actual_selected_rune.handle_portal("space", T)
		if(movesuccess)
			target.visible_message(span_warning("一声闷响，空气向外涌出，有东西出现在符文上方！"), null, "<i>你听到一声闷响。</i>")
	else
		fail_invoke()

/obj/effect/rune/teleport/proc/handle_portal(portal_type, turf/origin)
	var/turf/T = get_turf(src)
	close_portal() // To avoid stacking descriptions/animations
	playsound(T, SFX_PORTAL_CREATED, 100, TRUE, 14)
	inner_portal = new /obj/effect/temp_visual/cult/portal(T)
	if(portal_type == "space")
		set_light_color(color)
		desc += "<br><b>现实的裂口露出一片漆黑的虚空，点缀着点点光芒……不久前有东西从太空传送到了这里。<br><u>那片虚空似乎在试图把你拉向[dir2text(get_dir(T, origin))]！</u></b>"
	else
		inner_portal.icon_state = "lava"
		set_light_color(LIGHT_COLOR_FIRE)
		desc += "<br><b>现实的裂口露出一条奔腾的熔岩之河……不久前有东西从熔岩地带矿场传送到了这里！</b>"
	outer_portal = new(T, 600, color)
	set_light_range(4)
	update_light()
	addtimer(CALLBACK(src, PROC_REF(close_portal)), 600, TIMER_UNIQUE)

/obj/effect/rune/teleport/proc/close_portal()
	QDEL_NULL(inner_portal)
	QDEL_NULL(outer_portal)
	desc = initial(desc)
	set_light_range(0)
	update_light()

//Ritual of Dimensional Rending: Calls forth the avatar of Nar'Sie upon the station.
/obj/effect/rune/narsie
	cultist_name = "Nar'Sie"
	cultist_desc = "撕开维度屏障，召唤几何之神。需要 9 名激活者。"
	invocation = "TOK-LYR RQA-NAP G'OLT-ULOFT!!"
	req_cultists = 9
	icon = 'icons/effects/96x96.dmi'
	color = RUNE_COLOR_DARKRED
	icon_state = "rune_large"
	pixel_x = -32 //So the big ol' 96x96 sprite shows up right
	pixel_y = 16
	pixel_z = -48
	scribe_delay = 50 SECONDS //how long the rune takes to create
	scribe_damage = 40.1 //how much damage you take doing it
	log_when_erased = TRUE
	no_scribe_boost = TRUE
	erase_time = 5 SECONDS
	// We're gonna do some effects with starlight and parallax to make things... spooky
	started_creating = /proc/started_narsie_summon
	failed_to_create = /proc/failed_narsie_summon
	///Has the rune been used already?
	var/used = FALSE

/obj/effect/rune/narsie/Initialize(mapload, set_keyword)
	. = ..()
	SSpoints_of_interest.make_point_of_interest(src)

/obj/effect/rune/narsie/conceal() //can't hide this, and you wouldn't want to
	return

GLOBAL_VAR_INIT(narsie_effect_last_modified, 0)
GLOBAL_VAR_INIT(narsie_summon_count, 0)
/proc/set_narsie_count(new_count)
	GLOB.narsie_summon_count = new_count
	SEND_GLOBAL_SIGNAL(COMSIG_NARSIE_SUMMON_UPDATE, GLOB.narsie_summon_count)

/// When narsie begins to be summoned, slowly dim the saturation of parallax and starlight
/proc/started_narsie_summon()
	set waitfor = FALSE

	set_narsie_count(GLOB.narsie_summon_count + 1)
	if(GLOB.narsie_summon_count > 1)
		return

	var/started = world.time
	GLOB.narsie_effect_last_modified = started

	var/starting_color = GLOB.starlight_color
	var/list/target_color = rgb2hsv(starting_color)
	target_color[2] = target_color[2] * 0.4
	target_color[3] = target_color[3] * 0.5
	var/mid_color = hsv2rgb(target_color)
	var/end_color = "#c21d57"
	for(var/i in 1 to 9)
		if(GLOB.narsie_effect_last_modified > started)
			return
		var/starlight_color = hsv_gradient(i, 1, starting_color, 3, mid_color, 6, mid_color, 9, end_color)
		set_starlight(starlight_color)
		sleep(8 SECONDS)

/// Summon failed, time to work backwards
/proc/failed_narsie_summon()
	set waitfor = FALSE
	set_narsie_count(GLOB.narsie_summon_count - 1)

	if(GLOB.narsie_summon_count > 1)
		return
	var/started = world.time
	GLOB.narsie_effect_last_modified = started
	var/starting_color = GLOB.starlight_color
	var/end_color = GLOB.base_starlight_color
	// We get 4 steps to fade in
	for(var/i in 1 to 4)
		if(GLOB.narsie_effect_last_modified > started)
			return
		var/starlight_color = BlendHSV(i / 4, starting_color, end_color)
		set_starlight(starlight_color)
		sleep(8 SECONDS)

/obj/effect/rune/narsie/invoke(list/invokers)
	if(used)
		return
	if(!is_station_level(z))
		return
	var/mob/living/user = invokers[1]
	var/datum/antagonist/cult/user_antag = user.mind.has_antag_datum(/datum/antagonist/cult, TRUE)
	var/datum/objective/eldergod/summon_objective = locate() in user_antag.cult_team.objectives
	var/area/place = get_area(src)
	if(!(place in summon_objective.summon_spots))
		to_chat(user, span_cult_large("只能在帷幕薄弱之处召唤几何之神——即[english_list(summon_objective.summon_spots)]！"))
		return
	if(locate(/obj/narsie) in SSpoints_of_interest.narsies)
		for(var/invoker in invokers)
			to_chat(invoker, span_warning("纳尔西已经在这个位面上了！"))
		log_game("Nar'Sie rune activated by [user] at [COORD(src)] failed - already summoned.")
		return

	//BEGIN THE SUMMONING
	used = TRUE
	var/datum/team/cult/cult_team = user_antag.cult_team
	if (cult_team.narsie_summoned)
		for (var/datum/mind/cultist_mind in cult_team.members)
			var/mob/living/cultist_mob = cultist_mind.current
			cultist_mob.client?.give_award(/datum/award/achievement/misc/narsupreme, cultist_mob)

	cult_team.narsie_summoned = TRUE
	..()
	sound_to_playing_players('sound/effects/dimensional_rend.ogg')
	var/turf/rune_turf = get_turf(src)
	for(var/datum/mind/cult_mind as anything in cult_team.members)
		cult_team.true_cultists += cult_mind
	sleep(4 SECONDS)
	if(src)
		color = RUNE_COLOR_RED

	var/obj/narsie/harbinger = new /obj/narsie(rune_turf) //Causes Nar'Sie to spawn even if the rune has been removed
	harbinger.start_ending_the_round()

//Rite of Resurrection: Requires a dead or inactive cultist. When reviving the dead, you can only perform one revival for every three sacrifices your cult has carried out.
/obj/effect/rune/raise_dead
	cultist_name = "Revive"
	cultist_desc = "需要将一名死亡、无意识或无响应的血教徒放在符文上。每向黑暗主君献祭三具身体，就能修复一具身体并唤醒其心智"
	invocation = "Pasnar val'keriam usinar. Savrae ines amutan. Yam'toth remium il'tarat!" //Depends on the name of the user - see below
	icon_state = "1"
	color = RUNE_COLOR_MEDIUMRED

/obj/effect/rune/raise_dead/examine(mob/user)
	. = ..()
	if(IS_CULTIST(user) || user.stat == DEAD)
		. += "<b>未获回报的献祭：</b> [LAZYLEN(GLOB.sacrificed) - GLOB.sacrifices_used]"

/obj/effect/rune/raise_dead/invoke(list/invokers)
	if(rune_in_use)
		return
	rune_in_use = TRUE
	var/mob/living/mob_to_revive
	var/list/potential_revive_mobs = list()
	var/mob/living/user = invokers[1]

	for(var/mob/living/target in loc)
		if(IS_CULTIST(target) && (target.stat == DEAD || isnull(target.client) || target.client.is_afk()))
			potential_revive_mobs += target

	if(!length(potential_revive_mobs))
		to_chat(user, span_cult_italic("符文上没有死亡的血教徒！"))
		log_game("Raise Dead rune activated by [user] at [COORD(src)] failed - no cultists to revive.")
		fail_invoke()
		return

	if(length(potential_revive_mobs) > 1 && user.mind)
		mob_to_revive = tgui_input_list(user, "要复活的血教徒", "复活血教徒", potential_revive_mobs)
		if(isnull(mob_to_revive))
			return
	else
		mob_to_revive = potential_revive_mobs[1]

	if(QDELETED(src) || !validness_checks(mob_to_revive, user))
		fail_invoke()
		return

	invocation = (user.name == "Herbert West") ? "To life, to life, I bring them!" : initial(invocation)

	if(mob_to_revive.stat == DEAD)
		var/diff = LAZYLEN(GLOB.sacrificed) - SOULS_TO_REVIVE - GLOB.sacrifices_used
		if(diff < 0)
			to_chat(user, span_warning("你的血教还必须再进行 [abs(diff)] 次献祭，才能复活另一名教徒！"))
			fail_invoke()
			return
		GLOB.sacrifices_used += SOULS_TO_REVIVE
		mob_to_revive.revive(ADMIN_HEAL_ALL) //This does remove traits and such, but the rune might actually see some use because of it! //Why did you think this was a good idea

	if(!mob_to_revive.client || mob_to_revive.client.is_afk())
		set waitfor = FALSE
		var/mob/chosen_one = SSpolling.poll_ghosts_for_target("你愿意扮演[span_danger(mob_to_revive.real_name)]，一名[span_notice("无响应的血教徒")]吗？", check_jobban = ROLE_CULTIST, role = ROLE_CULTIST, poll_time = 5 SECONDS, checked_target = mob_to_revive, alert_pic = mob_to_revive, role_name_text = "inactive cultist")
		if(chosen_one)
			to_chat(mob_to_revive.mind, "由于你长时间无响应，你的肉身已被另一个灵魂接管！若想取回身体，请使用 Ahelp。")
			message_admins("[key_name_admin(chosen_one)]接管了（[key_name_admin(mob_to_revive)]），以替代一名 AFK 玩家。")
			mob_to_revive.ghostize(FALSE)
			mob_to_revive.PossessByPlayer(chosen_one.key)
		else
			fail_invoke()
			return
	SEND_SOUND(mob_to_revive, 'sound/music/antag/bloodcult/bloodcult_gain.ogg')
	to_chat(mob_to_revive, span_cult_large("\"PASNAR SAVRAE YAM'TOTH。苏醒吧。\""))
	mob_to_revive.visible_message(span_warning("[mob_to_revive]深吸一口气，眼中闪着红光。"), \
		span_cult_large("你突然从虚空中苏醒。你活过来了！"))
	rune_in_use = FALSE
	return ..()

/obj/effect/rune/raise_dead/proc/validness_checks(mob/living/target_mob, mob/living/user)
	if(QDELETED(user))
		return FALSE
	if(!Adjacent(user) || user.incapacitated)
		return FALSE
	if(QDELETED(target_mob))
		return FALSE
	if(!(target_mob in loc))
		to_chat(user, span_cult_italic("要复活的血教徒已被移开！"))
		log_game("Raise Dead rune activated by [user] at [COORD(src)] failed - revival target moved.")
		return FALSE
	return TRUE

/obj/effect/rune/raise_dead/fail_invoke()
	..()
	rune_in_use = FALSE
	for(var/mob/living/cultist in loc)
		if(IS_CULTIST(cultist) && cultist.stat == DEAD)
			cultist.visible_message(span_warning("[cultist]抽搐了一下。"))

//Rite of the Corporeal Shield: When invoked, becomes solid and cannot be passed. Invoke again to undo.
/obj/effect/rune/wall
	cultist_name = "Barrier"
	cultist_desc = "激活后生成一堵临时隐形墙阻挡通行。再次激活即可解除。"
	invocation = "Khari'd! Eske'te tannin!"
	icon_state = "4"
	color = RUNE_COLOR_DARKRED
	///The barrier summoned by the rune when invoked. Tracked as a variable to prevent refreshing the barrier's integrity.
	var/obj/structure/emergency_shield/cult/barrier/barrier //barrier is the path and variable name.... i am not a clever man

/obj/effect/rune/wall/Destroy()
	if(barrier)
		if(!QDELING(barrier))
			qdel(barrier)
		barrier = null
	return ..()

/obj/effect/rune/wall/invoke(list/invokers)
	var/mob/living/user = invokers[1]
	..()
	if(!barrier)
		barrier = new /obj/structure/emergency_shield/cult/barrier(src.loc)
		barrier.parent_rune = src
	barrier.Toggle()
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.apply_damage(2, BRUTE, pick(GLOB.arm_zones))

//Rite of Joined Souls: Summons a single cultist.
/obj/effect/rune/summon
	cultist_name = "Summon Cultist"
	cultist_desc = "将一名血教徒召唤到符文处。需要 2 名激活者。"
	invocation = "N'ath reth sh'yro eth d'rekkathnor!"
	req_cultists = 2
	invoke_damage = 10
	icon_state = "3"
	color = RUNE_COLOR_SUMMON

/obj/effect/rune/summon/invoke(list/invokers)
	var/mob/living/user = invokers[1]
	var/list/cultists = list()
	for(var/datum/mind/M as anything in get_antag_minds(/datum/antagonist/cult))
		if(!(M.current in invokers) && M.current && M.current.stat != DEAD)
			cultists |= M.current
	if(length(cultists) <= 1)
		to_chat(user, span_warning("没有可召唤的血教徒！"))
		fail_invoke()
		return
	var/mob/living/cultist_to_summon = tgui_input_list(user, "你想把谁召唤到[src]？", "几何之神的追随者", cultists)
	var/fail_logmsg = "Summon Cultist rune activated by [user] at [COORD(src)] failed - "
	if(!Adjacent(user) || !src || QDELETED(src) || user.incapacitated)
		return
	if(isnull(cultist_to_summon))
		to_chat(user, span_cult_italic("你需要一个召唤目标！"))
		fail_logmsg += "no target."
		log_game(fail_logmsg)
		fail_invoke()
		return
	if(cultist_to_summon.stat == DEAD)
		to_chat(user, span_cult_italic("[cultist_to_summon]已经死了！"))
		fail_logmsg += "target died."
		log_game(fail_logmsg)
		fail_invoke()
		return
	if(cultist_to_summon.pulledby || cultist_to_summon.buckled)
		to_chat(user, span_cult_italic("[cultist_to_summon]正被固定在原地！"))
		fail_logmsg += "target restrained."
		log_game(fail_logmsg)
		fail_invoke()
		return
	if(!IS_CULTIST(cultist_to_summon))
		to_chat(user, span_cult_italic("[cultist_to_summon]不是几何之神的追随者！"))
		fail_logmsg += "target deconverted."
		log_game(fail_logmsg)
		fail_invoke()
		return
	if(is_away_level(cultist_to_summon.z))
		to_chat(user, span_cult_italic("[cultist_to_summon]不在我们的维度！"))
		fail_logmsg += "target is in away mission."
		log_game(fail_logmsg)
		fail_invoke()
		return
	cultist_to_summon.visible_message(span_warning("[cultist_to_summon]在一道红光中突然消失了！"), \
									  span_cult_italic("<b>你被抛过空中，铺天盖地的眩晕将你吞没！</b>"))
	..()
	visible_message(span_warning("一团雾状形体在[src]上方凝聚，并固化成[cultist_to_summon]！"))
	var/turf/old_turf = get_turf(cultist_to_summon)
	if(!do_teleport(cultist_to_summon, get_turf(src)))
		to_chat(user, span_warning("[cultist_to_summon]的召唤彻底失败了！"))
		fail_logmsg += "target failed criteria to teleport." //catch-all term, just means they failed do_teleport somehow. The most common reasons why someone should fail to be summoned already have verbose messages.
		log_game(fail_logmsg)
		fail_invoke()
		return
	playsound(src, SFX_PORTAL_ENTER, 100, TRUE, SILENCED_SOUND_EXTRARANGE)
	playsound(old_turf, SFX_PORTAL_ENTER, 100, TRUE, SILENCED_SOUND_EXTRARANGE)
	qdel(src)

//Rite of Boiling Blood: Deals extremely high amounts of damage to non-cultists nearby
/obj/effect/rune/blood_boil
	cultist_name = "Boil Blood"
	cultist_desc = "煮沸能看到此符文的非信徒的血液，迅速造成极高伤害。需要 3 名激活者。"
	invocation = "Dedo ol'btoh!"
	icon_state = "4"
	color = RUNE_COLOR_BURNTORANGE
	light_color = LIGHT_COLOR_LAVA
	req_cultists = 3
	invoke_damage = 10
	construct_invoke = FALSE
	var/tick_damage = 25
	rune_in_use = FALSE

/obj/effect/rune/blood_boil/do_invoke_glow()
	return

/obj/effect/rune/blood_boil/invoke(list/invokers)
	if(rune_in_use)
		return
	..()
	rune_in_use = TRUE
	var/turf/T = get_turf(src)
	visible_message(span_warning("[src]变成明亮的炽橙色！"))
	color = "#FC9B54"
	set_light(6, 1, color)
	for(var/mob/living/target in viewers(T))
		if(!IS_CULTIST(target) && CAN_HAVE_BLOOD(target))
			if(target.can_block_magic(charge_cost = 0))
				continue
			to_chat(target, span_cult_large("你的血液在血管中沸腾！"))
	animate(src, color = "#FCB56D", time = 4)
	sleep(0.4 SECONDS)
	if(QDELETED(src))
		return
	do_area_burn(T, 0.5)
	animate(src, color = "#FFDF80", time = 5)
	sleep(0.5 SECONDS)
	if(QDELETED(src))
		return
	do_area_burn(T, 1)
	animate(src, color = "#FFFDF4", time = 6)
	sleep(0.6 SECONDS)
	if(QDELETED(src))
		return
	do_area_burn(T, 1.5)
	new /obj/effect/hotspot(T)
	qdel(src)

/obj/effect/rune/blood_boil/proc/do_area_burn(turf/T, multiplier)
	set_light(6, 1, color)
	for(var/mob/living/target in viewers(T))
		if(!IS_CULTIST(target) && target.get_blood_volume())
			if(target.can_block_magic(charge_cost = 0))
				continue
			target.take_overall_damage(tick_damage*multiplier, tick_damage*multiplier)

//Rite of Spectral Manifestation: Summons a ghost on top of the rune as a cultist human with no items. User must stand on the rune at all times, and takes damage for each summoned ghost.
/obj/effect/rune/manifest
	cultist_name = "Spirit Realm"
	cultist_desc = "显现一名几何之神的灵体仆从，并允许你自身升格为灵体。激活者必须始终站在符文上方不得移动，且每召唤一名灵体都会受到伤害。"
	invocation = "Gal'h'rfikk harfrandid mud'gib!" //how the fuck do you pronounce this
	icon_state = "7"
	invoke_damage = 10
	construct_invoke = FALSE
	color = RUNE_COLOR_DARKRED
	var/mob/living/affecting = null
	var/ghost_limit = 3
	var/ghosts = 0

/obj/effect/rune/manifest/can_invoke(mob/living/user)
	if(!(user in get_turf(src)))
		to_chat(user, span_cult_italic("你必须站在[src]上！"))
		fail_invoke()
		log_game("Manifest rune failed - user not standing on rune")
		return list()
	if(user.has_status_effect(/datum/status_effect/cultghost))
		to_chat(user, span_cult_italic("幽灵无法再召唤更多幽灵！"))
		fail_invoke()
		log_game("Manifest rune failed - user is a ghost")
		return list()
	return ..()

/obj/effect/rune/manifest/invoke(list/invokers)
	. = ..()
	var/mob/living/user = invokers[1]
	var/turf/T = get_turf(src)
	var/choice = tgui_alert(user, "你撕开了一条通往灵界的通路……", "灵界", list("Summon a Cult Ghost", "Ascend as a Dark Spirit"))
	if(choice == "Summon a Cult Ghost")
		if(!is_station_level(T.z))
			to_chat(user, span_cult_italic("<b>此处的帷幕不够薄弱，无法显现灵体，你必须在空间站上！</b>"))
			return
		if(ghosts >= ghost_limit)
			to_chat(user, span_cult_italic("你维持的幽灵太多，无法再召唤更多！"))
			fail_invoke()
			log_game("Manifest rune failed - too many summoned ghosts")
			return list()
		notify_ghosts(
			"显灵符文在[get_area(src)]被激活。",
			source = src,
			header = "显灵符文",
			ghost_sound = 'sound/effects/ghost2.ogg',
		)
		var/list/ghosts_on_rune = list()
		for(var/mob/dead/observer/O in T)
			if(O.client && !is_banned_from(O.ckey, ROLE_CULTIST) && !QDELETED(src) && !(isAdminObserver(O) && (O.client.prefs.toggles & ADMIN_IGNORE_CULT_GHOST)) && !QDELETED(O))
				ghosts_on_rune += O
		if(!length(ghosts_on_rune))
			to_chat(user, span_cult_italic("[src]附近没有灵体！"))
			fail_invoke()
			log_game("Manifest rune failed - no nearby ghosts")
			return list()
		var/mob/dead/observer/ghost_to_spawn = pick(ghosts_on_rune)

		// Dear god, why is /mob/living/carbon/human/cult_ghost not a simple mob or species
		// someone please fix this at some point -TimT August 2022
		var/mob/living/carbon/human/cult_ghost/new_human = new(T)
		new_human.real_name = ghost_to_spawn.real_name
		new_human.alpha = 150 //Makes them translucent
		new_human.equipOutfit(/datum/outfit/ghost_cultist) //give them armor
		new_human.apply_status_effect(/datum/status_effect/cultghost) //ghosts can't summon more ghosts
		new_human.set_invis_see(SEE_INVISIBLE_OBSERVER)
		new_human.add_traits(list(TRAIT_NOBREATH, TRAIT_SPAWNED_MOB, TRAIT_PERMANENTLY_MORTAL), INNATE_TRAIT) // permanently mortal can be removed once this is a bespoke kind of mob
		ghosts++
		playsound(src, 'sound/effects/magic/exit_blood.ogg', 50, TRUE)
		visible_message(span_warning("一团红雾在[src]上方凝聚，从中走出……一个[new_human.gender == FEMALE ? "女" : "男"]人。"))
		to_chat(user, span_cult_italic("你的血液开始流入[src]。你必须留在原地并保持清醒，才能维持召唤物的形体。这会缓慢但确实地伤害你……"))
		var/obj/structure/emergency_shield/cult/weak/N = new(T)
		if(ghost_to_spawn.mind && ghost_to_spawn.mind)
			new_human.AddComponent( \
				/datum/component/temporary_body, \
				old_mind = ghost_to_spawn.mind, \
			)
		new_human.PossessByPlayer(ghost_to_spawn.key)
		var/datum/antagonist/cult/created_cultist = new_human.mind?.add_antag_datum(/datum/antagonist/cult)
		created_cultist?.silent = TRUE
		to_chat(new_human, span_cult_italic("<b>你是几何之神的仆从。纳尔西的血教已使你获得半实体形态，你必须不惜一切代价为他们效力。</b>"))

		while(!QDELETED(src) && !QDELETED(user) && !QDELETED(new_human) && (user in T))
			if(IS_UNCONSCIOUS_OR_CRIT(user))
				break
			user.apply_damage(0.1, BRUTE)
			sleep(0.1 SECONDS)

		qdel(N)
		ghosts--
		if(new_human)
			new_human.visible_message(span_warning("[new_human]突然崩解为骨灰。"), \
					span_cult_large("你与现世的联系消退了。你的形体四分五裂。"))
			for(var/obj/I in new_human)
				new_human.dropItemToGround(I, TRUE)
			new_human.mind?.remove_antag_datum(/datum/antagonist/cult)
			new_human.dust()

	else if(choice == "Ascend as a Dark Spirit")
		affecting = user
		affecting.add_atom_colour(RUNE_COLOR_DARKRED, ADMIN_COLOUR_PRIORITY)
		affecting.visible_message(span_warning("[affecting]如雕像般僵立不动，散发着诡异的红光。"), \
						span_cult("你看见了彼岸之物。一切都已揭示。在此形态下，你的声音更加洪亮，并且可以为整个血教标记目标"))
		var/mob/dead/observer/G = affecting.ghostize(TRUE)
		ADD_TRAIT(G, TRAIT_NO_OBSERVE, CULT_TRAIT)
		var/datum/action/innate/cult/comm/spirit/CM = new
		var/datum/action/innate/cult/ghostmark/GM = new
		G.name = "[G.name]的暗影之灵"
		G.color = "red"
		CM.Grant(G)
		GM.Grant(G)
		while(!QDELETED(affecting))
			if(!(affecting in T))
				user.visible_message(span_warning("一条幽影触须缠住[affecting]，将其拽回符文处！"))
				Beam(affecting, icon_state="drainbeam", time = 2)
				affecting.forceMove(get_turf(src)) //NO ESCAPE :^)
			if(affecting.key)
				affecting.visible_message(span_warning("[affecting]缓缓放松下来，其周身的辉光渐渐变暗。"), \
					span_danger("你与肉体重新合一。[src]放开了对你的束缚。"))
				affecting.Paralyze(40)
				break
			if(affecting.health <= 10)
				to_chat(G, span_cult_italic("你的身体再也无法维持这条连接！"))
				break
			sleep(0.5 SECONDS)
		CM.Remove(G)
		GM.Remove(G)
		affecting.remove_atom_colour(ADMIN_COLOUR_PRIORITY, RUNE_COLOR_DARKRED)
		affecting.grab_ghost()
		affecting = null
		rune_in_use = FALSE

/mob/living/carbon/human/cult_ghost/spill_organs(drop_bitflags=NONE)
	drop_bitflags &= ~DROP_BRAIN //cult ghosts never drop a brain
	. = ..()

/mob/living/carbon/human/cult_ghost/get_organs_for_zone(zone, include_children)
	. = ..()
	for(var/obj/item/organ/brain/B in .) //they're not that smart, really
		. -= B


/obj/effect/rune/apocalypse
	cultist_name = "Apocalypse"
	cultist_desc = "末日的先兆。会随血教的绝望而增强——但代价可能是……副作用。"
	invocation = "Ta'gh fara'qha fel d'amar det!"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "apoc"
	pixel_x = -32
	pixel_y = 16
	pixel_z = -48
	color = RUNE_COLOR_DARKRED
	req_cultists = 3
	scribe_delay = 100

/obj/effect/rune/apocalypse/invoke(list/invokers)
	if(rune_in_use)
		return
	. = ..()

	var/area/place = get_area(src)
	var/mob/living/user = invokers[1]
	var/datum/antagonist/cult/user_antag = user.mind.has_antag_datum(/datum/antagonist/cult,TRUE)
	var/datum/objective/eldergod/summon_objective = locate() in user_antag.cult_team.objectives
	if(length(summon_objective.summon_spots) <= 1)
		to_chat(user, span_cult_large("只剩下一个仪式地点了——它必须留作最终召唤之用！"))
		return
	if(!(place in summon_objective.summon_spots))
		to_chat(user, span_cult_large("天启符文会移除一处可召唤纳尔西的仪式地点，它只能书写于[english_list(summon_objective.summon_spots)]！"))
		return

	summon_objective.summon_spots -= place
	rune_in_use = TRUE

	var/turf/T = get_turf(src)
	new /obj/effect/temp_visual/dir_setting/curse/grasp_portal/fading(T)
	var/intensity = 0
	for(var/mob/living/M in GLOB.player_list)
		if(IS_CULTIST(M))
			intensity++
	intensity = max(60, 360 - (360*(intensity/length(GLOB.player_list) + 0.3)**2)) //significantly lower intensity for "winning" cults
	var/duration = intensity*10

	playsound(T, 'sound/effects/magic/enter_blood.ogg', 100, TRUE)
	visible_message(span_warning("一道巨大的能量冲击波从符文中迸发，并将符文本身一同瓦解！"))

	for(var/mob/living/target in range(src, 3))
		target.Paralyze(30)
	empulse(T, 0.42*(intensity), 1, emp_source = src)

	var/list/images = list()
	for(var/mob/living/M in GLOB.alive_mob_list)
		if(!is_valid_z_level(T, get_turf(M)))
			continue
		if(ishuman(M))
			if(!IS_CULTIST(M))
				ADD_TRAIT(M, TRAIT_BLOCK_SECHUD, CULT_TRAIT)
				addtimer(TRAIT_CALLBACK_REMOVE(M, TRAIT_BLOCK_SECHUD, CULT_TRAIT), duration)
			var/image/A = image('icons/mob/nonhuman-player/cult.dmi',M,"cultist", ABOVE_MOB_LAYER)
			A.override = 1
			add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/noncult, "human_apoc", A, NONE)
			addtimer(CALLBACK(M, TYPE_PROC_REF(/atom/, remove_alt_appearance),"human_apoc",TRUE), duration)
			images += A
			SEND_SOUND(M, pick(sound('sound/music/antag/bloodcult/bloodcult_gain.ogg'),sound('sound/music/antag/bloodcult/ghost_whisper.ogg'),sound('sound/music/antag/bloodcult/ghosty_wind.ogg')))
		else
			var/construct = pick("wraith","artificer","juggernaut")
			var/image/B = image('icons/mob/nonhuman-player/cult.dmi',M,construct, ABOVE_MOB_LAYER)
			B.override = 1
			add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/noncult, "mob_apoc", B, NONE)
			addtimer(CALLBACK(M, TYPE_PROC_REF(/atom/, remove_alt_appearance),"mob_apoc",TRUE), duration)
			images += B
		if(!IS_CULTIST(M))
			if(M.client)
				var/image/C = image('icons/effects/cult.dmi', M, "bloodsparkles", ABOVE_MOB_LAYER)
				add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/has_antagonist/cult, "cult_apoc", C, NONE)
				addtimer(CALLBACK(M, TYPE_PROC_REF(/atom/, remove_alt_appearance),"cult_apoc",TRUE), duration)
				images += C
		else
			to_chat(M, span_cult_large("有人在[place]激活了天启符文，该处已不能再作为召唤地点！"))
			SEND_SOUND(M, 'sound/effects/pope_entry.ogg')
	image_handler(images, duration)
	if(intensity >= 285) // Based on the prior formula, this means the cult makes up <15% of current players
		var/outcome = rand(1,100)
		switch(outcome)
			if(1 to 10)
				force_event_async(/datum/round_event_control/disease_outbreak, "一枚天启符文")
				force_event_async(/datum/round_event_control/mice_migration, "一枚天启符文")
			if(11 to 20)
				force_event_async(/datum/round_event_control/radiation_storm, "一枚天启符文")

			if(21 to 30)
				force_event_async(/datum/round_event_control/brand_intelligence, "一枚天启符文")

			if(31 to 40)
				force_event_async(/datum/round_event_control/immovable_rod, "一枚天启符文")
				force_event_async(/datum/round_event_control/immovable_rod, "一枚天启符文")
				force_event_async(/datum/round_event_control/immovable_rod, "一枚天启符文")

			if(41 to 50)
				force_event_async(/datum/round_event_control/meteor_wave, "一枚天启符文")

			if(51 to 60)
				SSdynamic.force_run_midround(/datum/dynamic_ruleset/midround/spiders)

			if(61 to 70)
				force_event_async(/datum/round_event_control/anomaly/anomaly_flux, "一枚天启符文")
				force_event_async(/datum/round_event_control/anomaly/anomaly_grav, "一枚天启符文")
				force_event_async(/datum/round_event_control/anomaly/anomaly_pyro, "一枚天启符文")
				force_event_async(/datum/round_event_control/anomaly/anomaly_vortex, "一枚天启符文")

			if(71 to 80)
				force_event_async(/datum/round_event_control/spacevine, "一枚天启符文")
				force_event_async(/datum/round_event_control/grey_tide, "一枚天启符文")

			if(81 to 100)
				force_event_async(/datum/round_event_control/portal_storm_narsie, "一枚天启符文")

	qdel(src)

/obj/effect/rune/apocalypse/proc/image_handler(list/images, duration)
	var/end = world.time + duration
	set waitfor = 0
	while(end>world.time)
		for(var/image/I in images)
			I.override = FALSE
			animate(I, alpha = 0, time = 25, flags = ANIMATION_PARALLEL)
		sleep(3.5 SECONDS)
		for(var/image/I in images)
			animate(I, alpha = 255, time = 25, flags = ANIMATION_PARALLEL)
		sleep(2.5 SECONDS)
		for(var/image/I in images)
			if(I.icon_state != "bloodsparkles")
				I.override = TRUE
		sleep(19 SECONDS)
