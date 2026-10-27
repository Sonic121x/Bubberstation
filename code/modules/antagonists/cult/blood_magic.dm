/// how many units of blood one charge of blood rites is worth
#define USES_TO_BLOOD 2
/// blood rites charges gained from sapping blood from a victim
#define BLOOD_DRAIN_GAIN 50
/// penalty for self healing, 1 point of damage * this # = charges required
#define SELF_HEAL_PENALTY 1.65

/datum/action/innate/cult/blood_magic //Blood magic handles the creation of blood spells (formerly talismans)
	name = "准备血魔法"
	button_icon_state = "carve"
	desc = "通过将符文刻入血肉来准备血魔法。在<b>赋能符文</b>旁进行会更容易。"
	default_button_position = DEFAULT_BLOODSPELLS
	var/list/spells = list()
	var/channeling = FALSE
	/// If the magic has been enhanced somehow, likely due to a crimson medallion.
	var/magic_enhanced = FALSE

/datum/action/innate/cult/blood_magic/Remove()
	for(var/X in spells)
		qdel(X)
	..()

/datum/action/innate/cult/blood_magic/IsAvailable(feedback = FALSE)
	if(!IS_CULTIST(owner))
		return FALSE
	return ..()

/datum/action/innate/cult/blood_magic/proc/Positioning()
	for(var/datum/hud/hud as anything in viewers)
		var/our_view = hud.mymob?.canon_client?.view || "15x15"
		var/atom/movable/screen/movable/action_button/button = viewers[hud]
		var/position = screen_loc_to_offset(button.screen_loc)
		var/list/position_list = list()
		for(var/possible_position in 1 to magic_enhanced ? ENHANCED_BLOODCHARGE : MAX_BLOODCHARGE)
			position_list += possible_position
		for(var/datum/action/innate/cult/blood_spell/blood_spell in spells)
			if(blood_spell.positioned)
				position_list.Remove(blood_spell.positioned)
				continue
			var/atom/movable/screen/movable/action_button/moving_button = blood_spell.viewers[hud]
			if(!moving_button)
				continue
			var/first_available_slot = position_list[1]
			var/our_x = position[1] + first_available_slot * ICON_SIZE_X // Offset any new buttons into our list
			hud.position_action(moving_button, offset_to_screen_loc(our_x, position[2], our_view))
			blood_spell.positioned = first_available_slot

/datum/action/innate/cult/blood_magic/Activate()
	var/rune = FALSE
	var/limit = RUNELESS_MAX_BLOODCHARGE
	for(var/obj/effect/rune/empower/R in range(1, owner))
		rune = TRUE
		break
	if(rune)
		limit = magic_enhanced ? ENHANCED_BLOODCHARGE : MAX_BLOODCHARGE
	if(length(spells) >= limit)
		if(rune)
			to_chat(owner, span_cult_italic("你最多只能存储 [limit] 个法术。<b>请选择一个法术移除。</b>"))
		else
			to_chat(owner, span_cult_bold_italic("<u>没有赋能符文时，你最多只能存储 [RUNELESS_MAX_BLOODCHARGE] 个法术！请选择一个法术移除。</u>"))
		var/nullify_spell = tgui_input_list(owner, "要移除的法术", "当前法术", spells)
		if(isnull(nullify_spell))
			return
		qdel(nullify_spell)
	var/entered_spell_name
	var/datum/action/innate/cult/blood_spell/BS
	var/list/possible_spells = list()
	for(var/I in subtypesof(/datum/action/innate/cult/blood_spell))
		var/datum/action/innate/cult/blood_spell/J = I
		var/cult_name = initial(J.name)
		possible_spells[cult_name] = J
	possible_spells += "(REMOVE SPELL)"
	entered_spell_name = tgui_input_list(owner, "要准备的血魔法", "法术选择", possible_spells)
	if(isnull(entered_spell_name))
		return
	if(entered_spell_name == "(REMOVE SPELL)")
		var/nullify_spell = tgui_input_list(owner, "要移除的法术", "当前法术", spells)
		if(isnull(nullify_spell))
			return
		qdel(nullify_spell)
	BS = possible_spells[entered_spell_name]
	if(QDELETED(src) || owner.incapacitated || !BS || (rune && !(locate(/obj/effect/rune/empower) in range(1, owner))) || (length(spells) >= limit))
		return
	to_chat(owner,span_warning("你开始在自己血肉上刻下诡异的符号！"))
	SEND_SOUND(owner, sound('sound/items/weapons/slice.ogg',0,1,10))
	if(!channeling)
		channeling = TRUE
	else
		to_chat(owner, span_cult_italic("你已经在施放血魔法了！"))
		return
	var/spell_carving_timer = 10 SECONDS
	if(rune)
		spell_carving_timer = 4 SECONDS
	if(magic_enhanced)
		spell_carving_timer *= 0.5
	if(do_after(owner, spell_carving_timer, target = owner))
		if(ishuman(owner))
			var/mob/living/carbon/human/human_owner = owner
			human_owner.bleed(rune ? 8 : 40)
		var/datum/action/innate/cult/blood_spell/new_spell = new BS(owner.mind)
		new_spell.Grant(owner, src)
		spells += new_spell
		Positioning()
		to_chat(owner, span_warning("你的伤口泛起力量的光芒，你已准备好[new_spell.name]的咒文！"))
	channeling = FALSE

/datum/action/innate/cult/blood_spell //The next generation of talismans, handles storage/creation of blood magic
	name = "血魔法"
	button_icon_state = "telerune"
	desc = "敬畏古血。"
	var/charges = 1
	var/magic_path = null
	var/obj/item/melee/blood_magic/hand_magic
	var/datum/action/innate/cult/blood_magic/all_magic
	var/base_desc //To allow for updating tooltips
	var/invocation
	var/health_cost = 0
	/// Have we already been positioned into our starting location?
	var/positioned = FALSE
	/// If false, the spell will not delete after running out of charges
	var/deletes_on_empty = TRUE

/datum/action/innate/cult/blood_spell/Grant(mob/living/owner, datum/action/innate/cult/blood_magic/BM)
	if(health_cost)
		desc += "<br>每次使用会对你的手臂造成 <u>[health_cost] 点伤害</u>。"
	base_desc = desc
	desc += "<br><b><u>剩余 [charges] 次使用</u></b>。"
	all_magic = BM
	return ..()

/datum/action/innate/cult/blood_spell/Remove()
	if(all_magic)
		all_magic.spells -= src
	if(hand_magic)
		qdel(hand_magic)
		hand_magic = null
	..()

/datum/action/innate/cult/blood_spell/IsAvailable(feedback = FALSE)
	if(!IS_CULTIST(owner) || owner.incapacitated || (!charges && deletes_on_empty))
		return FALSE
	return ..()

/datum/action/innate/cult/blood_spell/Activate()
	if(!magic_path) // only concerned with spells that flow from the hand
		return
	if(hand_magic)
		qdel(hand_magic)
		hand_magic = null
		to_chat(owner, span_warning("你熄灭了法术，将其留待后用。"))
		return
	hand_magic = new magic_path(owner, src)
	if(!owner.put_in_hands(hand_magic))
		qdel(hand_magic)
		hand_magic = null
		to_chat(owner, span_warning("你没有空手来施放血魔法！"))
		return
	to_chat(owner, span_notice("你的伤口泛起光芒，你施放了[name]。"))

//Cult Blood Spells
/datum/action/innate/cult/blood_spell/stun
	name = "眩晕"
	desc = "让你的手在接触时眩晕并沉默受害者。加入血教的人越多，效果越弱。"
	button_icon_state = "hand"
	magic_path = /obj/item/melee/blood_magic/stun
	health_cost = 10

/datum/action/innate/cult/blood_spell/teleport
	name = "传送"
	desc = "让你的手在接触时将你或另一名血教徒传送到传送符文。"
	button_icon_state = "tele"
	magic_path = /obj/item/melee/blood_magic/teleport
	health_cost = 7

/datum/action/innate/cult/blood_spell/emp
	name = "电磁脉冲"
	desc = "释放一次大型电磁脉冲。"
	button_icon_state = "emp"
	health_cost = 10
	invocation = "Ta'gh fara'qha fel d'amar det!"

/datum/action/innate/cult/blood_spell/emp/Activate()
	owner.whisper(invocation, language = /datum/language/common, forced = "cult invocation")
	owner.visible_message(span_warning("[owner]的手闪过一道明亮的蓝光！"), \
		span_cult_italic("你念出受诅咒的词语，从手中迸发出一道电磁脉冲冲击。"))
	empulse(owner, 2, 5, emp_source = src)
	charges--
	SSblackbox.record_feedback("tally", "cult_spell_invoke", 1, "[name]")
	if(charges <= 0)
		qdel(src)

/datum/action/innate/cult/blood_spell/shackles
	name = "暗影镣铐"
	desc = "让你的手在接触时开始给受害者戴上手铐，若成功还会使其沉默。"
	button_icon_state = "cuff"
	charges = 4
	magic_path = /obj/item/melee/blood_magic/shackles

/datum/action/innate/cult/blood_spell/construction
	name = "扭曲构造"
	desc = "让你的手腐化特定的金属物体。<br><u>转化：</u><br>塑钢化为符文金属<br>50 金属化为构造体外壳<br>活着的半机械人延迟后化为构造体<br>半机械人外壳化为构造体外壳<br>净化过的灵魂石（及其中任何幽影）化为血教徒灵魂石<br>气闸延迟后化为脆弱的符文气闸（伤害意图）"
	button_icon_state = "transmute"
	magic_path = /obj/item/melee/blood_magic/construction
	health_cost = 12

/datum/action/innate/cult/blood_spell/equipment
	name = "召唤战斗装备"
	desc = "让你的手在接触血教徒时召唤出战斗装备，包括血教护甲、血教流星锤和血教长剑。在血教的存在尚未暴露前不建议使用。"
	button_icon_state = "equip"
	magic_path = /obj/item/melee/blood_magic/armor

/datum/action/innate/cult/blood_spell/dagger
	name = "召唤仪式匕首"
	desc = "允许你召唤一把仪式匕首，以备你弄丢了发给你的那把。"
	invocation = "Wur d'dai leev'mai k'sagan!" //where did I leave my keys, again?
	button_icon_state = "equip" //this is the same icon that summon equipment uses, but eh, I'm not a spriter
	/// The item given to the cultist when the spell is invoked. Typepath.
	var/obj/item/summoned_type = /obj/item/melee/cultblade/dagger

/datum/action/innate/cult/blood_spell/dagger/Activate()
	var/turf/owner_turf = get_turf(owner)
	owner.whisper(invocation, language = /datum/language/common, forced = "cult invocation")
	owner.visible_message(span_warning("[owner]的手短暂地泛起红光。"), \
		span_cult_italic("你的求援得到了回应，光芒开始在你手中闪烁并凝聚成形！"))
	var/obj/item/summoned_blade = new summoned_type(owner_turf)
	if(owner.put_in_hands(summoned_blade))
		to_chat(owner, span_warning("[summoned_blade]出现在你手中！"))
	else
		owner.visible_message(span_warning("[summoned_blade]出现在[owner]脚边！"), \
			span_cult_italic("[summoned_blade]在你脚边凝聚成形。"))
	SEND_SOUND(owner, sound('sound/effects/magic.ogg', FALSE, 0, 25))
	charges--
	SSblackbox.record_feedback("tally", "cult_spell_invoke", 1, "[name]")
	if(charges <= 0)
		qdel(src)

/datum/action/innate/cult/blood_spell/horror
	name = "幻觉"
	desc = "远距离使目标产生幻觉。无声且无形的法术。"
	button_icon_state = "horror"
	charges = 4
	click_action = TRUE
	enable_text = span_cult("你准备让目标陷入恐惧……")
	disable_text = span_cult("你驱散了魔法……")

/datum/action/innate/cult/blood_spell/horror/InterceptClickOn(mob/living/clicker, params, atom/clicked_on)
	var/turf/caller_turf = get_turf(clicker)
	if(!isturf(caller_turf))
		return FALSE

	if(!ishuman(clicked_on) || get_dist(clicker, clicked_on) > 7)
		return FALSE

	var/mob/living/carbon/human/human_clicked = clicked_on
	if(IS_CULTIST(human_clicked))
		return FALSE

	return ..()

/datum/action/innate/cult/blood_spell/horror/do_ability(mob/living/clicker, mob/living/carbon/human/clicked_on)

	clicked_on.set_hallucinations_if_lower(240 SECONDS)
	SEND_SOUND(clicker, sound('sound/effects/ghost.ogg', FALSE, TRUE, 50))

	var/image/sparkle_image = image('icons/effects/cult.dmi', clicked_on, "bloodsparkles", ABOVE_MOB_LAYER)
	clicked_on.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/has_antagonist/cult, "cult_apoc", sparkle_image, NONE)

	addtimer(CALLBACK(clicked_on, TYPE_PROC_REF(/atom/, remove_alt_appearance), "cult_apoc", TRUE), 4 MINUTES, TIMER_OVERRIDE|TIMER_UNIQUE)
	to_chat(clicker, span_cult_bold("[clicked_on]被诅咒，被活生生的噩梦缠身！"))

	charges--
	desc = base_desc
	desc += "<br><b><u>剩余 [charges] 次使用</u></b>。"
	build_all_button_icons()
	SSblackbox.record_feedback("tally", "cult_spell_invoke", 1, "[name]")
	if(charges <= 0)
		to_chat(clicker, span_cult("你已经耗尽了该法术的力量！"))
		qdel(src)

	return TRUE

/datum/action/innate/cult/blood_spell/veiling
	name = "隐匿存在"
	desc = "在隐藏与显露附近的血教建筑和符文之间切换。"
	invocation = "Kla'atu barada nikt'o!"
	button_icon_state = "gone"
	charges = 10
	var/revealing = FALSE //if it reveals or not

/datum/action/innate/cult/blood_spell/veiling/Activate()
	if(!revealing)
		owner.visible_message(span_warning("细细的灰色尘埃从[owner]的手中落下！"), \
			span_cult_italic("你施放隐匿法术，隐藏附近的符文。"))
		charges--
		SEND_SOUND(owner, sound('sound/effects/magic/smoke.ogg',0,1,25))
		owner.whisper(invocation, language = /datum/language/common, forced = "cult invocation")
		for(var/obj/effect/rune/R in range(5,owner))
			R.conceal()
		for(var/obj/structure/destructible/cult/S in range(5,owner))
			S.conceal()
		for(var/turf/open/floor/engine/cult/T  in range(5,owner))
			if(!T.realappearance)
				continue
			T.realappearance.alpha = 0
		for(var/obj/machinery/door/airlock/cult/AL in range(5, owner))
			AL.conceal()
		revealing = TRUE
		name = "显露符文"
		button_icon_state = "back"
	else
		owner.visible_message(span_warning("[owner]的手中闪出一道亮光！"), \
			span_cult_italic("你施放反制法术，显露附近的符文。"))
		charges--
		owner.whisper(invocation, language = /datum/language/common, forced = "cult invocation")
		SEND_SOUND(owner, sound('sound/effects/magic/enter_blood.ogg',0,1,25))
		for(var/obj/effect/rune/R in range(7,owner)) //More range in case you weren't standing in exactly the same spot
			R.reveal()
		for(var/obj/structure/destructible/cult/S in range(6,owner))
			S.reveal()
		for(var/turf/open/floor/engine/cult/T  in range(6,owner))
			if(!T.realappearance)
				continue
			T.realappearance.alpha = initial(T.realappearance.alpha)
		for(var/obj/machinery/door/airlock/cult/AL in range(6, owner))
			AL.reveal()
		revealing = FALSE
		name = "隐匿符文"
		button_icon_state = "gone"
	SSblackbox.record_feedback("tally", "cult_spell_invoke", 1, "Conceal Runes")
	if(charges <= 0)
		qdel(src)
	desc = base_desc
	desc += "<br><b><u>剩余 [charges] 次使用</u></b>。"
	build_all_button_icons()

/datum/action/innate/cult/blood_spell/manipulation
	name = "血祭"
	desc = "让你的手吸收血液以用于高阶仪式，或在接触血教徒时治疗他。手持该法术使用可施放高阶仪式。"
	invocation = "Fel'th Dol Ab'orod!"
	button_icon_state = "manip"
	charges = 5
	magic_path = /obj/item/melee/blood_magic/manipulator
	deletes_on_empty = FALSE

// The "magic hand" items
/obj/item/melee/blood_magic
	name = "\improper 魔法灵光"
	desc = "一团扭曲周遭现实流动的邪恶灵光。"
	icon = 'icons/obj/weapons/hand.dmi'
	lefthand_file = 'icons/mob/inhands/items/touchspell_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/touchspell_righthand.dmi'
	icon_state = "disintegrate"
	inhand_icon_state = "disintegrate"
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 0
	throw_range = 0
	throw_speed = 0
	var/invocation
	var/uses = 1
	var/health_cost = 0 //The amount of health taken from the user when invoking the spell
	var/datum/action/innate/cult/blood_spell/source

/obj/item/melee/blood_magic/Initialize(mapload, spell)
	. = ..()
	if(spell)
		source = spell
		uses = source.charges
		health_cost = source.health_cost

/obj/item/melee/blood_magic/Destroy()
	if(!QDELETED(source))
		if(uses <= 0 && source.deletes_on_empty)
			source.hand_magic = null
			qdel(source)
			source = null
		else
			source.hand_magic = null
			source.charges = uses
			source.desc = source.base_desc
			source.desc += "<br><b><u>剩余 [uses] 次使用</u></b>。"
			source.build_all_button_icons()
	return ..()

/obj/item/melee/blood_magic/attack_self(mob/living/user)
	cast_spell(user, user)

/obj/item/melee/blood_magic/attack(mob/living/M, mob/living/carbon/user)
	if(!cast_spell(M, user))
		return
	log_combat(user, M, "使用了血教法术攻击", src)
	SSblackbox.record_feedback("tally", "cult_spell_invoke", 1, "[name]")
	M.lastattacker = user.real_name
	M.lastattackerckey = user.ckey
	user.do_attack_animation(M)

/obj/item/melee/blood_magic/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!iscarbon(user) || !IS_CULTIST(user))
		uses = 0
		qdel(src)
		return ITEM_INTERACT_BLOCKING

	if(isliving(interacting_with))
		return ITEM_INTERACT_SKIP_TO_ATTACK

	var/spell_name = source.name // Spell action is deleted in cast_spell() if we're out of charges

	if(!cast_spell(interacting_with, user))
		return ITEM_INTERACT_BLOCKING

	user.do_attack_animation(interacting_with)
	log_combat(user, interacting_with, "使用了血教法术攻击", spell_name)
	SSblackbox.record_feedback("tally", "cult_spell_invoke", 1, "[name]")
	return ITEM_INTERACT_SUCCESS

/obj/item/melee/blood_magic/proc/cast_spell(atom/target, mob/living/carbon/user)
	if(invocation)
		user.whisper(invocation, language = /datum/language/common, forced = "cult invocation")
	if(health_cost)
		if(user.active_hand_index == 1)
			user.apply_damage(health_cost, BRUTE, BODY_ZONE_L_ARM, wound_bonus = CANT_WOUND)
		else
			user.apply_damage(health_cost, BRUTE, BODY_ZONE_R_ARM, wound_bonus = CANT_WOUND)
	if(uses <= 0)
		qdel(src)
		return TRUE
	if(source)
		source.desc = source.base_desc
		source.desc += "<br><b><u>剩余 [uses] 次使用</u></b>。"
		source.build_all_button_icons()
	return TRUE

//Stun
/obj/item/melee/blood_magic/stun
	name = "眩晕灵光"
	desc = "接触时眩晕并沉默意志薄弱的受害者。"
	color = RUNE_COLOR_RED
	invocation = "Fuu ma'jin!"

/obj/item/melee/blood_magic/stun/cast_spell(mob/living/target, mob/living/carbon/user)
	if(!istype(target) || IS_CULTIST(target))
		return
	var/datum/antagonist/cult/cultist = GET_CULTIST(user)
	var/datum/team/cult/cult_team = cultist?.get_team()
	var/effect_coef = 1
	if(cult_team?.cult_ascendent)
		effect_coef = 0.1
	else if(cult_team?.cult_risen)
		effect_coef = 0.4
	if(IS_CULTIST(user) && isnull(GET_CULTIST(user)))
		effect_coef = 0.2
	user.visible_message(
		span_warning("[user]举起手，手上爆出一团红光！"),
		span_cult_italic("你试图用法术眩晕[target]！"),
		visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
	)
	user.mob_light(range = 1.1, power = 2, color = LIGHT_COLOR_BLOOD_MAGIC, duration = 0.2 SECONDS)
	uses--
	// Heretics are momentarily disoriented by the stunning aura. Enough for both parties to go 'oh shit' but only a mild combat ability.
	// Heretics have an identical effect on their grasp. The cultist's worse spell preparation is offset by their extra gear and teammates.
	if(IS_HERETIC(target))
		target.AdjustKnockdown(0.5 SECONDS)
		target.adjust_confusion_up_to(1.5 SECONDS, 3 SECONDS)
		target.adjust_dizzy_up_to(1.5 SECONDS, 3 SECONDS)
		ADD_TRAIT(target, TRAIT_NO_SIDE_KICK, REF(src)) // We don't want this to be a good stunning tool, just minor disorientation
		addtimer(TRAIT_CALLBACK_REMOVE(target, TRAIT_NO_SIDE_KICK, REF(src)), 1 SECONDS)

		var/old_color = target.color
		target.color = COLOR_HERETIC_GREEN
		animate(target, color = old_color, time = 4 SECONDS, easing = SINE_EASING|EASE_IN)
		target.mob_light(range = 1.5, power = 2.5, color = COLOR_HERETIC_GREEN, duration = 0.5 SECONDS)
		playsound(target, 'sound/effects/magic/magic_block_mind.ogg', 150, TRUE) // insanely quiet

		to_chat(user, span_warning("当你触碰[target]时，一股诡秘的力量介入，吸收了大部分效果！"))
		to_chat(target, span_warning("当[user]用邪恶魔法触碰你时，漫宿吸收了大部分效果！"))
		target.balloon_alert_to_viewers("被吸收！")
		return ..()
		// SKYRAT EDIT ADDITION START
	else if(IS_CLOCK(target))
		to_chat(user, span_warning("某种比你更强大的力量介入！[target]受到异教徒拉特瓦的庇护！"))
		to_chat(target, span_warning("你对拉特瓦的信仰庇护着你！"))
		var/old_color = target.color
		target.color = rgb(190, 135, 0)
		animate(target, color = old_color, time = 1 SECONDS, easing = EASE_IN)
		// SKYRAT EDIT ADDITION END
		return ..()

	if(target.can_block_magic())
		to_chat(user, span_warning("法术没有产生任何效果！"))
		return ..()

	to_chat(user, span_cult_italic("一道耀眼的红光闪过，[target]倒在地上！"))
	target.Paralyze(16 SECONDS * effect_coef)
	target.flash_act(1, TRUE)
	if(issilicon(target))
		var/mob/living/silicon/silicon_target = target
		silicon_target.emp_act(EMP_HEAVY)
	else if(iscarbon(target))
		var/mob/living/carbon/carbon_target = target
		carbon_target.adjust_silence(12 SECONDS * effect_coef)
		carbon_target.adjust_stutter(30 SECONDS * effect_coef)
		carbon_target.adjust_timed_status_effect(30 SECONDS * effect_coef, /datum/status_effect/speech/slurring/cult)
		carbon_target.set_jitter_if_lower(30 SECONDS * effect_coef)
	return ..()

//Teleportation
/obj/item/melee/blood_magic/teleport
	name = "传送灵光"
	color = RUNE_COLOR_TELEPORT
	desc = "接触时将血教徒传送到传送符文。"
	invocation = "Sas'so c'arta forbici!"

/obj/item/melee/blood_magic/teleport/cast_spell(mob/living/target, mob/living/carbon/user)
	if(!istype(target) || !IS_CULTIST(target))
		to_chat(user, span_warning("此法术只能传送血教徒！"))
		return

	var/list/potential_runes = list()
	var/list/teleportnames = list()
	for(var/obj/effect/rune/teleport/teleport_rune as anything in GLOB.teleport_runes)
		potential_runes[avoid_assoc_duplicate_keys(teleport_rune.listkey, teleportnames)] = teleport_rune

	if(!length(potential_runes))
		to_chat(user, span_warning("没有可用于传送的有效符文！"))
		return
	var/turf/T = get_turf(src)
	if(is_away_level(T.z))
		to_chat(user, span_cult_italic("你不在正确的维度中！"))
		return
	var/input_rune_key = tgui_input_list(user, "要传送到的符文", "传送目标", potential_runes) //we know what key they picked
	if(isnull(input_rune_key))
		return
	if(isnull(potential_runes[input_rune_key]))
		to_chat(user, span_warning("你必须选择一个有效的符文！"))
		return
	var/obj/effect/rune/teleport/actual_selected_rune = potential_runes[input_rune_key] //what rune does that key correspond to?
	if(QDELETED(src) || !user || !user.is_holding(src) || user.incapacitated || !actual_selected_rune)
		return
	var/turf/dest = get_turf(actual_selected_rune)
	if(dest.is_blocked_turf(TRUE))
		to_chat(user, span_warning("目标符文被阻挡，你无法传送到那里。"))
		return
	uses--
	var/turf/origin = get_turf(user)
	if(do_teleport(target, dest, channel = TELEPORT_CHANNEL_CULT))
		origin.visible_message(
			span_warning("尘埃从[user]的手中流出，随后[user]随着一声清脆的爆响消失了！"),
			span_cult_italic("你念出符咒上的词语，发现自己已身处他处！"),
			span_hear("你听到一声清脆的爆响。"),
		)
		dest.visible_message(
			span_warning("随着一声轰响，空气向外涌出，有东西出现在符文上方！"),
			null,
			span_hear("你听到一声轰鸣。"),
		)
		playsound(origin, SFX_PORTAL_ENTER, 50, TRUE, SILENCED_SOUND_EXTRARANGE)
		playsound(dest, SFX_PORTAL_ENTER, 50, TRUE, SILENCED_SOUND_EXTRARANGE)
	return ..()

//Shackles
/obj/item/melee/blood_magic/shackles
	name = "镣铐灵光"
	desc = "接触时开始给受害者戴上手铐，若成功还会使其沉默。"
	invocation = "In'totum Lig'abis!"
	color = COLOR_BLACK // black

/obj/item/melee/blood_magic/shackles/cast_spell(atom/target, mob/living/carbon/user)
	if(!iscarbon(target))
		return
	var/mob/living/carbon/C = target
	if(IS_CULTIST(C))
		return
	if(!C.canBeHandcuffed())
		user.visible_message(span_cult_italic("这个受害者没有足够的手臂来完成束缚！"))
		return
	CuffAttack(C, user)
	return ..()

/obj/item/melee/blood_magic/shackles/proc/CuffAttack(mob/living/carbon/C, mob/living/user)
	if(!C.handcuffed)
		playsound(loc, 'sound/items/weapons/cablecuff.ogg', 30, TRUE, -2)
		C.visible_message(span_danger("[user]开始用黑暗魔法束缚[C]！"), \
								span_userdanger("[user]开始在你的手腕上凝聚黑暗魔法镣铐！"))
		if(do_after(user, 3 SECONDS, C))
			if(!C.handcuffed)
				C.equip_to_slot_or_del(new /obj/item/restraints/handcuffs/cult, ITEM_SLOT_HANDCUFFED, indirect_action = TRUE)
				C.adjust_silence(10 SECONDS)
				to_chat(user, span_notice("你给[C]戴上了镣铐。"))
				log_combat(user, C, "铐住了")
				uses--
			else
				to_chat(user, span_warning("[C]已被束缚。"))
		else
			to_chat(user, span_warning("你未能给[C]戴上镣铐。"))
	else
		to_chat(user, span_warning("[C]已被束缚。"))

//Construction: Converts 50 iron to a construct shell, plasteel to runed metal, airlock to brittle runed airlock, a borg to a construct, or borg shell to a construct shell
/obj/item/melee/blood_magic/construction
	name = "扭曲灵光"
	desc = "接触时腐化特定的金属物体。"
	invocation = "Ethra p'ni dedol!"
	color = COLOR_BLACK // black
	var/channeling = FALSE

/obj/item/melee/blood_magic/construction/examine(mob/user)
	. = ..()
	. += {"<u>一种用于转化的邪恶法术：</u>\n
	塑钢化为符文金属\n
	[IRON_TO_CONSTRUCT_SHELL_CONVERSION] 铁化为构造体外壳\n
	活着的半机械人在延迟后化为构造体\n
	半机械人外壳化为构造体外壳\n
	净化过的灵魂石（及其中任何幽影）化为血教徒灵魂石\n
	气闸在延迟后化为脆弱的符文气闸（伤害意图）"}

/obj/item/melee/blood_magic/construction/cast_spell(atom/target, mob/living/carbon/user)
	if(channeling)
		to_chat(user, span_cult_italic("你已经在施放扭曲构造了！"))
		return

	var/turf/T = get_turf(target)
	if(istype(target, /obj/item/stack/sheet/iron))
		var/obj/item/stack/sheet/candidate = target
		if(!candidate.use(IRON_TO_CONSTRUCT_SHELL_CONVERSION))
			to_chat(user, span_warning("你需要 [IRON_TO_CONSTRUCT_SHELL_CONVERSION] 单位的铁才能制造构造体外壳！"))
			return
		uses--
		to_chat(user, span_warning("一团黑雾从你手中涌出，缠绕着铁块，将其扭曲成构造体外壳！"))
		new /obj/structure/constructshell(T)
		SEND_SOUND(user, sound('sound/effects/magic.ogg',0,1,25))
		return ..()

	if(istype(target, /obj/item/stack/sheet/plasteel))
		var/obj/item/stack/sheet/plasteel/candidate = target
		var/quantity = candidate.amount
		if(!candidate.use(quantity))
			return

		uses--
		new /obj/item/stack/sheet/runed_metal(T,quantity)
		to_chat(user, span_warning("一团黑雾从你手中涌出，缠绕着塑钢，将其转化为符文金属！"))
		SEND_SOUND(user, sound('sound/effects/magic.ogg',0,1,25))
		return ..()

	if(istype(target,/mob/living/silicon/robot))
		var/mob/living/silicon/robot/candidate = target
		if(candidate.mmi || candidate.shell)
			channeling = TRUE
			user.visible_message(span_danger("一团黑雾从[user]的手中涌出，缠绕在[candidate]周围！"))
			playsound(T, 'sound/machines/airlock/airlock_alien_prying.ogg', 80, TRUE)
			var/prev_color = candidate.color
			candidate.color = "black"
			if(!do_after(user, 9 SECONDS, target = candidate))
				channeling = FALSE
				candidate.color = prev_color
				return
			candidate.undeploy()
			candidate.emp_act(EMP_HEAVY)
			var/construct_class = show_radial_menu(user, src, GLOB.construct_radial_images, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE, tooltips = TRUE)
			if(!check_menu(user) || QDELETED(candidate))
				channeling = FALSE
				candidate.color = prev_color
				return
			candidate.grab_ghost()
			user.visible_message(span_danger("黑雾从曾是[candidate]的形体上退去，露出一个[construct_class]！"))
			make_new_construct_from_class(construct_class, THEME_CULT, candidate, user, FALSE, T)
			uses--
			qdel(candidate)
			channeling = FALSE
			return ..()

		uses--
		to_chat(user, span_warning("一团黑雾从你手中涌出，缠绕着[candidate]——将其扭曲成构造体外壳！"))
		new /obj/structure/constructshell(T)
		SEND_SOUND(user, sound('sound/effects/magic.ogg',0,1,25))
		qdel(candidate)
		return ..()

	if(istype(target,/obj/machinery/door/airlock))
		channeling = TRUE
		playsound(T, 'sound/machines/airlock/airlockforced.ogg', 50, TRUE)
		do_sparks(5, TRUE, target)
		if(!do_after(user, 5 SECONDS, target = user) && !QDELETED(target))
			channeling = FALSE
			return

		target.narsie_act()
		uses--
		user.visible_message(span_warning("黑色丝带突然从[user]的手中涌出，缠绕住气闸——将其扭曲并腐化！"))
		SEND_SOUND(user, sound('sound/effects/magic.ogg',0,1,25))
		channeling = FALSE
		return ..()

	if(istype(target,/obj/item/soulstone))
		var/obj/item/soulstone/candidate = target
		if(!candidate.corrupt())
			return

		uses--
		to_chat(user, span_warning("你腐化了[candidate]！"))
		SEND_SOUND(user, sound('sound/effects/magic.ogg',0,1,25))
		return ..()

	to_chat(user, span_warning("该法术对[target]无效！"))

/obj/item/melee/blood_magic/construction/proc/check_menu(mob/user)
	if(!istype(user))
		CRASH("The cult construct selection radial menu was accessed by something other than a valid user.")
	if(user.incapacitated || !user.Adjacent(src))
		return FALSE
	return TRUE


//Armor: Gives the target (cultist) a basic cultist combat loadout
/obj/item/melee/blood_magic/armor
	name = "武装灵光"
	desc = "接触时为一血教徒装备血教战斗装备。"
	color = "#33cc33" // green

/obj/item/melee/blood_magic/armor/cast_spell(mob/living/target, mob/living/carbon/user)
	if(!iscarbon(target) || !IS_CULTIST(target))
		return
	uses--
	var/mob/living/carbon/carbon_target = target
	carbon_target.visible_message(span_warning("异界护甲突然出现在[carbon_target]身上！"))
	carbon_target.equip_to_slot_or_del(new /obj/item/clothing/under/color/black,ITEM_SLOT_ICLOTHING)
	carbon_target.equip_to_slot_or_del(new /obj/item/clothing/suit/hooded/cultrobes/alt(user), ITEM_SLOT_OCLOTHING)
	carbon_target.equip_to_slot_or_del(new /obj/item/clothing/shoes/cult/alt(user), ITEM_SLOT_FEET)
	carbon_target.equip_to_slot_or_del(new /obj/item/storage/backpack/cultpack(user), ITEM_SLOT_BACK)
	if(carbon_target == user)
		qdel(src) //Clears the hands
	carbon_target.put_in_hands(new /obj/item/melee/cultblade/dagger(user))
	carbon_target.put_in_hands(new /obj/item/restraints/legcuffs/bola/cult(user))
	return ..()

/obj/item/melee/blood_magic/manipulator
	name = "血祭灵光"
	desc = "从你触碰到的任何东西上吸取血液。触碰血教徒和构造体可为其治疗。手持使用可施放高阶仪式。"
	color = "#7D1717"

/obj/item/melee/blood_magic/manipulator/examine(mob/user)
	. = ..()
	. += "血染长戟、血矢弹幕和血能光束分别消耗 [BLOOD_HALBERD_COST]、[BLOOD_BARRAGE_COST] 和 [BLOOD_BEAM_COST] 点充能。"

/**
 * handles inhand use of blood rites on constructs, humans, or non-living blood sources
 *
 * see '/obj/item/melee/blood_magic/manipulator/proc/heal_construct' for construct/shade behavior
 * see '/obj/item/melee/blood_magic/manipulator/proc/heal_cultist' for human cultist behavior
 * see '/obj/item/melee/blood_magic/manipulator/proc/drain_victim' for human non-cultist behavior
 * if any of the above procs return FALSE, '/obj/item/melee/blood_magic/afterattack' will not be called
 *
 * '/obj/item/melee/blood_magic/manipulator/proc/blood_draw' handles blood pools/trails and does not affect parent proc
 */
/obj/item/melee/blood_magic/manipulator/cast_spell(mob/living/target, mob/living/carbon/user)
	if(isconstruct(target) || isshade(target))
		if (heal_construct(target, user))
			return ..()
		return
	if(istype(target, /obj/effect/decal/cleanable/blood) || isturf(target))
		blood_draw(target, user)
		return ..()
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/human_bloodbag = target
	if(!CAN_HAVE_BLOOD(human_bloodbag))
		human_bloodbag.balloon_alert(user, "没有血！")
		return
	if(human_bloodbag.stat == DEAD)
		human_bloodbag.balloon_alert(user, "已死亡！")
		return
	if(IS_CULTIST(human_bloodbag) && !heal_cultist(human_bloodbag, user))
		return
	if(!IS_CULTIST(human_bloodbag) && !drain_victim(human_bloodbag, user))
		return
	return ..()

/**
 * handles blood rites usage on constructs
 *
 * will only return TRUE if some amount healing is done
 */
/obj/item/melee/blood_magic/manipulator/proc/heal_construct(atom/target, mob/living/carbon/human/user)
	var/mob/living/basic/construct_thing = target
	if(!IS_CULTIST(construct_thing))
		return FALSE
	var/missing_health = construct_thing.maxHealth - construct_thing.health
	if(!missing_health)
		to_chat(user,span_cult("该血教徒不需要治疗！"))
		return FALSE
	if(uses <= 0)
		construct_thing.balloon_alert(user, "血液耗尽！")
		return FALSE
	if(uses > missing_health)
		construct_thing.adjust_health(-missing_health)
		construct_thing.visible_message(span_warning("[construct_thing]被[user]的血魔法完全治愈！"))
		uses -= missing_health
	else
		construct_thing.adjust_health(-uses)
		construct_thing.visible_message(span_warning("[construct_thing]被[user]的血魔法部分治愈！"))
		uses = 0
	playsound(get_turf(construct_thing), 'sound/effects/magic/staff_healing.ogg', 25)
	user.Beam(construct_thing, icon_state="sendbeam", time = 1 SECONDS)
	return TRUE

/**
 * handles blood rites usage on human cultists
 *
 * first restores blood, then heals damage. healing damage is more expensive, especially if performed on oneself
 * returns TRUE if some amount of blood is restored and/or damage is healed
 */
/obj/item/melee/blood_magic/manipulator/proc/heal_cultist(mob/living/carbon/human/human_bloodbag, mob/living/carbon/human/user)
	if(uses <= 0)
		human_bloodbag.balloon_alert(user, "血液耗尽！")
		return FALSE

	/// used to ensure the proc returns TRUE if we completely restore an undamaged persons blood
	var/blood_donor = FALSE
	var/cached_blood_volume = human_bloodbag.get_blood_volume()
	if(cached_blood_volume < BLOOD_VOLUME_SAFE)
		var/blood_needed = BLOOD_VOLUME_SAFE - cached_blood_volume
		/// how much blood we are capable of restoring, based on spell charges
		var/blood_bank = USES_TO_BLOOD * uses
		if(blood_bank < blood_needed)
			human_bloodbag.adjust_blood_volume(blood_bank)
			to_chat(user,span_danger("你用尽了最后的血祭之力，尽力补回了能补回的血液！"))
			uses = 0
			return TRUE
		blood_donor = TRUE
		human_bloodbag.set_blood_volume(BLOOD_VOLUME_SAFE)
		uses -= round(blood_needed / USES_TO_BLOOD)
		to_chat(user,span_warning("你的血祭已将[human_bloodbag == user ? "你自己的" : "[human_bloodbag]的"]血液恢复至安全水平！"))

	var/overall_damage = human_bloodbag.get_brute_loss() + human_bloodbag.get_fire_loss() + human_bloodbag.get_tox_loss() + human_bloodbag.get_oxy_loss()
	if(overall_damage == 0)
		if(blood_donor)
			return TRUE
		to_chat(user,span_cult("该血教徒不需要治疗！"))
		return FALSE
	/// how much damage we can/will heal
	var/damage_healed = -1 * min(uses, overall_damage)
	/// how many spell charges will be consumed to heal said damage
	var/healing_cost = damage_healed
	if(human_bloodbag == user)
		to_chat(user,span_cult("<b>对自己使用时，你的血液治疗效果会大打折扣！</b>"))
		damage_healed = -1 * min(uses * (1 / SELF_HEAL_PENALTY), overall_damage)
		healing_cost = damage_healed * SELF_HEAL_PENALTY
	uses += round(healing_cost)
	human_bloodbag.visible_message(span_warning("[human_bloodbag]被[human_bloodbag == user ? "自己的" : "[user]的"]血魔法[uses == 0 ? "部分治愈":"完全治愈"]了！"))

	var/need_mob_update = FALSE
	need_mob_update += human_bloodbag.adjust_oxy_loss(damage_healed * (human_bloodbag.get_oxy_loss() / overall_damage), updating_health = FALSE)
	need_mob_update += human_bloodbag.adjust_tox_loss(damage_healed * (human_bloodbag.get_tox_loss() / overall_damage), updating_health = FALSE)
	need_mob_update += human_bloodbag.adjust_fire_loss(damage_healed * (human_bloodbag.get_fire_loss() / overall_damage), updating_health = FALSE)
	need_mob_update += human_bloodbag.adjust_brute_loss(damage_healed * (human_bloodbag.get_brute_loss() / overall_damage), updating_health = FALSE)
	if(need_mob_update)
		human_bloodbag.updatehealth()
	playsound(get_turf(human_bloodbag), 'sound/effects/magic/staff_healing.ogg', 25)
	new /obj/effect/temp_visual/cult/sparks(get_turf(human_bloodbag))
	if (user != human_bloodbag) //Dont create beam from the user to the user
		user.Beam(human_bloodbag, icon_state="sendbeam", time = 15)
	return TRUE

/**
 * handles blood rites use on a non-cultist human
 *
 * returns TRUE if blood is successfully drained from the victim
 */
/obj/item/melee/blood_magic/manipulator/proc/drain_victim(mob/living/carbon/human/human_bloodbag, mob/living/carbon/human/user)
	if(human_bloodbag.has_status_effect(/datum/status_effect/speech/slurring/cult))
		to_chat(user,span_danger("[human_bloodbag]的血液已被更强形态的血魔法污染，这样对我们毫无用处！"))
		return FALSE
	if(human_bloodbag.get_blood_volume() <= BLOOD_VOLUME_SAFE)
		to_chat(user,span_warning("[human_bloodbag]失血过多——你无法再从其身上吸取更多血液了！"))
		return FALSE
	human_bloodbag.adjust_blood_volume(-BLOOD_DRAIN_GAIN * USES_TO_BLOOD)
	uses += BLOOD_DRAIN_GAIN
	user.Beam(human_bloodbag, icon_state="drainbeam", time = 1 SECONDS)
	playsound(get_turf(human_bloodbag), 'sound/effects/magic/enter_blood.ogg', 50)
	human_bloodbag.visible_message(span_danger("[user]吸取了[human_bloodbag]的一部分血液！"))
	to_chat(user,span_cult_italic("你的血祭通过吸取[human_bloodbag]的血液获得了 50 点充能。"))
	new /obj/effect/temp_visual/cult/sparks(get_turf(human_bloodbag))
	return TRUE

/**
 * handles blood rites use on turfs, blood pools, and blood trails
 */
/obj/item/melee/blood_magic/manipulator/proc/blood_draw(atom/target, mob/living/carbon/human/user)
	var/blood_to_gain = 0
	var/turf/our_turf = get_turf(target)
	if(!our_turf)
		return
	for(var/obj/effect/decal/cleanable/blood/blood_around_us in range(our_turf, 2))
		if(blood_around_us.decal_reagent == /datum/reagent/blood || blood_around_us.reagents?.has_reagent(/datum/reagent/blood))
			blood_to_gain += max(blood_around_us.bloodiness * 0.6 * BLOOD_TO_UNITS_MULTIPLIER, 1)
			new /obj/effect/temp_visual/cult/turf/floor(get_turf(blood_around_us))
			qdel(blood_around_us)

	if(!blood_to_gain)
		return
	user.Beam(our_turf,icon_state="drainbeam", time = 15)
	new /obj/effect/temp_visual/cult/sparks(get_turf(user))
	playsound(our_turf, 'sound/effects/magic/enter_blood.ogg', 50)
	to_chat(user, span_cult_italic("你的血祭从周围的血液来源获得了 [round(blood_to_gain)] 点充能！"))
	uses += max(1, round(blood_to_gain))

/**
 * handles untargeted use of blood rites
 *
 * allows user to trade in spell uses for equipment or spells
 */
/obj/item/melee/blood_magic/manipulator/attack_self(mob/living/user)
	var/static/list/spells = list(
		"Bloody Halberd (150)" = image(icon = 'icons/obj/weapons/spear.dmi', icon_state = "occultpoleaxe0"),
		"Blood Bolt Barrage (300)" = image(icon = 'icons/obj/weapons/guns/ballistic.dmi', icon_state = "arcane_barrage"),
		"Blood Beam (500)" = image(icon = 'icons/obj/weapons/hand.dmi', icon_state = "disintegrate")
		)
	var/choice = show_radial_menu(user, src, spells, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE)
	if(!check_menu(user))
		to_chat(user, span_cult_italic("你决定不进行高阶血祭了。"))
		return

	switch(choice)
		if("Bloody Halberd (150)")
			if(uses < BLOOD_HALBERD_COST)
				to_chat(user, span_cult_italic("你需要 [BLOOD_HALBERD_COST] 点充能才能进行此仪式。"))
				return
			uses -= BLOOD_HALBERD_COST
			var/turf/current_position = get_turf(user)
			qdel(src)
			var/datum/action/innate/cult/halberd/halberd_act_granted = new(user)
			var/obj/item/melee/cultblade/halberd/rite = new(current_position)
			halberd_act_granted.Grant(user, rite)
			rite.halberd_act = halberd_act_granted
			if(user.put_in_hands(rite))
				to_chat(user, span_cult_italic("[rite.name]出现在你手中！"))
			else
				user.visible_message(span_warning("[rite.name]出现在[user]脚边！"), \
					span_cult_italic("[rite.name]在你脚边凝聚成形。"))

		if("Blood Bolt Barrage (300)")
			if(uses < BLOOD_BARRAGE_COST)
				to_chat(user, span_cult_italic("你需要 [BLOOD_BARRAGE_COST] 点充能才能进行此仪式。"))
				return
			var/obj/rite = new /obj/item/gun/magic/wand/arcane_barrage/blood()
			uses -= BLOOD_BARRAGE_COST
			qdel(src)
			if(user.put_in_hands(rite))
				to_chat(user, span_cult("<b>你的双手泛起力量的光芒！</b>"))
			else
				to_chat(user, span_cult_italic("你需要一只空手来施放此仪式！"))
				qdel(rite)

		if("Blood Beam (500)")
			if(uses < BLOOD_BEAM_COST)
				to_chat(user, span_cult_italic("你需要 [BLOOD_BEAM_COST] 点充能才能进行此仪式。"))
				return
			var/obj/rite = new /obj/item/blood_beam()
			uses -= BLOOD_BEAM_COST
			qdel(src)
			if(user.put_in_hands(rite))
				to_chat(user, span_cult_large("<b>你的双手泛起压倒性的力量！！！</b>"))
			else
				to_chat(user, span_cult_italic("你需要一只空手来施放此仪式！"))
				qdel(rite)

/obj/item/melee/blood_magic/manipulator/proc/check_menu(mob/living/user)
	if(!istype(user))
		CRASH("The Blood Rites manipulator radial menu was accessed by something other than a valid user.")
	if(user.incapacitated || !user.Adjacent(src))
		return FALSE
	return TRUE

#undef USES_TO_BLOOD
#undef BLOOD_DRAIN_GAIN
#undef SELF_HEAL_PENALTY
