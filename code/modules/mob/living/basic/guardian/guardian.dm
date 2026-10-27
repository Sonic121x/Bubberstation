/**
 * A mob which acts as a guardian angel to another mob, sharing health but protecting them using special powers.
 * Usually either obtained in magical form by a wizard, or technological form by a traitor. Sometimes found by miners.
 */
/mob/living/basic/guardian
	name = "守护灵"
	real_name = "守护灵"
	desc = "一个守在召唤者身旁、时刻警惕的神秘存在。"
	icon = 'icons/mob/nonhuman-player/guardian.dmi'
	icon_state = "magicbase"
	icon_living = "magicbase"
	icon_dead = "magicbase"
	gender = NEUTER
	basic_mob_flags = DEL_ON_DEATH
	mob_biotypes = MOB_SPECIAL
	sentience_type = SENTIENCE_HUMANOID
	hud_type = /datum/hud/guardian
	speed = 0
	status_flags = CANPUSH
	maxHealth = INFINITY // The spirit itself is invincible and passes damage to its host
	health = INFINITY
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, STAMINA = 0, OXY = 1)
	unsuitable_atmos_damage = 0
	unsuitable_cold_damage = 0
	unsuitable_heat_damage = 0
	speak_emote = list("嘶声说")
	bubble_icon = "guardian"
	response_help_continuous = "把手穿过"
	response_help_simple = "把手穿过"
	response_disarm_continuous = "胡乱挥手打"
	response_disarm_simple = "胡乱挥手打"
	response_harm_continuous = "拳击"
	response_harm_simple = "拳击"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	attack_verb_continuous = "拳击"
	attack_verb_simple = "拳击"
	obj_damage = 40
	melee_damage_lower = 15
	melee_damage_upper = 15
	melee_attack_cooldown = CLICK_CD_MELEE
	light_system = OVERLAY_LIGHT
	light_range = 3
	light_on = FALSE

	/// The summoner of the guardian, we share health with them and can't move too far away (usually)
	var/mob/living/summoner
	/// How far from the summoner the guardian can be.
	var/range = 10

	/// The guardian's colour, used for their sprite, chat, and some effects.
	var/guardian_colour
	/// Coloured overlay we apply
	var/mutable_appearance/overlay

	/// Which toggle button the guardian has. Won't get one if it's null.
	var/toggle_button_type = null
	/// Name used by the guardian creator.
	var/creator_name = "错误"
	/// Description used by the guardian creator.
	var/creator_desc = "这里不该出现这个！请在 GitHub 上报告！"
	/// Icon used by the guardian creator.
	var/creator_icon = "fuck"

	/// What type of guardian are we?
	var/guardian_type = null
	/// How are we themed?
	var/datum/guardian_fluff/theme
	/// A string explaining to the guardian what they can do.
	var/playstyle_string = span_boldholoparasite("你是一名没有类型的守护灵。你不该存在，是对神的冒犯！")

	/// Are we forced to not be able to manifest/recall?
	var/locked = FALSE
	/// Cooldown between manifests/recalls.
	COOLDOWN_DECLARE(manifest_cooldown)
	/// Cooldown between the summoner resetting the guardian's client.
	COOLDOWN_DECLARE(resetting_cooldown)

	/// List of actions we give to our summoner.
	var/static/list/control_actions = list(
		/datum/action/cooldown/mob_cooldown/guardian_comms,
		/datum/action/cooldown/mob_cooldown/recall_guardian,
		/datum/action/cooldown/mob_cooldown/replace_guardian,
	)
	/// List of actions we give to ourselves.
	var/static/list/self_actions = list(
		/datum/action/cooldown/guardian/check_type,
		/datum/action/cooldown/guardian/toggle_light,
		/datum/action/cooldown/guardian/communicate,
		/datum/action/cooldown/guardian/manifest,
		/datum/action/cooldown/guardian/recall,
	)

/mob/living/basic/guardian/Initialize(mapload, datum/guardian_fluff/theme)
	. = ..()
	GLOB.parasites += src
	src.theme = theme
	theme?.apply(src)
	AddElement(/datum/element/death_drops, /obj/effect/temp_visual/guardian/phase/out)
	AddElement(/datum/element/simple_flying)
	// life link
	update_appearance(UPDATE_ICON)
	manifest_effects()
	create_actions()

/mob/living/basic/guardian/Destroy()
	GLOB.parasites -= src
	if (is_deployed())
		recall_effects()
	cut_summoner(different_person = TRUE)
	return ..()

///Creates the guardian's default action buttons and sets them to go in their proper location.
///Subtypes overwrite this for special ability types and whatnot.
/mob/living/basic/guardian/proc/create_actions()
	for (var/action_type in self_actions + toggle_button_type)
		if(isnull(action_type)) //no toggle button type
			continue
		if (locate(action_type) in actions)
			continue
		var/datum/action/new_action = new action_type(src)
		new_action.Grant(src)
	update_action_buttons()

/mob/living/basic/guardian/update_overlays()
	. = ..()
	. += overlay

/mob/living/basic/guardian/Login() //if we have a mind, set its name to ours when it logs in
	. = ..()
	if (!. || isnull(client))
		return FALSE
	if (isnull(summoner))
		to_chat(src, span_boldholoparasite("不知为何，你竟然没有召唤者。请立即报告此问题。"))
		stack_trace("Guardian created with client but no summoner.")
	else
		to_chat(src, span_holoparasite("你是<b>[theme.name]</b>，受缚于此，为 [summoner.real_name] 效劳。"))
		to_chat(src, span_holoparasite("你可以用 HUD 上的按钮现身，或收回到你的主人身边。那里还有一个按钮，可以私下与主人交流。"))
		to_chat(src, span_holoparasite("虽然你本身无敌，但若 [summoner.real_name] 死去，你也会死去；任何对你造成的伤害都会有一部分传递到主人身上，因为你从主人身上汲取养分来维持自身。"))
	to_chat(src, playstyle_string)
	if (!isnull(guardian_colour))
		return // Already set up so we don't need to do it again
	locked = TRUE
	guardian_rename()
	guardian_recolour()
	locked = FALSE

/mob/living/basic/guardian/mind_initialize()
	. = ..()
	if (isnull(summoner))
		to_chat(src, span_boldholoparasite("不知为何，你竟然没有召唤者。请立即报告此问题。"))
		return
	mind.enslave_mind_to_creator(summoner) // Once our mind is created, we become enslaved to our summoner. cant be done in the first run of set_summoner, because by then we dont have a mind yet.

/// Pick a new colour for our guardian
/mob/living/basic/guardian/proc/guardian_recolour()
	if (isnull(client))
		return
	var/chosen_guardian_colour = tgui_color_picker(src, "你想让自己的颜色是什么？", "选择你的颜色", COLOR_WHITE)
	if (isnull(chosen_guardian_colour)) //redo proc until we get a color
		to_chat(src, span_warning("无效的颜色，请重试。"))
		return guardian_recolour()
	set_guardian_colour(chosen_guardian_colour)

/// Apply a new colour to our guardian
/mob/living/basic/guardian/proc/set_guardian_colour(colour)
	guardian_colour = colour
	set_light_color(guardian_colour)
	overlay?.color = guardian_colour
	update_appearance(UPDATE_ICON)

/mob/living/basic/guardian/proc/guardian_rename()
	if (isnull(client))
		return

	var/new_name = sanitize_name(reject_bad_text(tgui_input_text(src, "你想让自己叫什么名字？", "选择你的名字", generate_random_name(), MAX_NAME_LEN)))
	if (!new_name) //redo proc until we get a good name
		to_chat(src, span_warning("无效的名字，请重试。"))
		return guardian_rename()
	to_chat(src, span_notice("你的新名字 [span_name(new_name)] 在你的意识中扎下了根。"))
	fully_replace_character_name(null, new_name, log_new_name = TRUE)

/// Picks a random name as a suggestion
/mob/living/basic/guardian/proc/generate_random_name()
	var/list/surname_options = list("Guardian") // Fallback in case you define a guardian with no theme
	switch(theme?.fluff_type)
		if (GUARDIAN_MAGIC)
			surname_options = GLOB.guardian_fantasy_surnames
		if (GUARDIAN_TECH)
			surname_options = GLOB.guardian_tech_surnames

	return "[pick(GLOB.guardian_first_names)] [pick(surname_options)]"

/mob/living/basic/guardian/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	if (!is_deployed())
		balloon_alert(src, "尚未实体化！")
		return FALSE
	return ..()

/mob/living/basic/guardian/death(gibbed)
	if (!QDELETED(summoner))
		to_chat(summoner, span_bolddanger("你的 [name] 不知怎么死了！"))
		summoner.dust()
	return ..()

/mob/living/basic/guardian/ex_act(severity, target)
	switch(severity)
		if (EXPLODE_DEVASTATE)
			investigate_log("被爆炸炸成了碎块。", INVESTIGATE_DEATHS)
			gib()
			return TRUE
		if (EXPLODE_HEAVY)
			adjust_brute_loss(60)
		if (EXPLODE_LIGHT)
			adjust_brute_loss(30)

	return TRUE

/mob/living/basic/guardian/gib()
	death(TRUE)

/mob/living/basic/guardian/dust(just_ash, drop_items, give_moodlet, force)
	death(TRUE)

/// Link up with a summoner mob.
/mob/living/basic/guardian/proc/set_summoner(mob/living/to_who, different_person = FALSE)
	if (QDELETED(src))
		return // Just in case
	if (QDELETED(to_who))
		ghostize(FALSE)
		qdel(src) // No life of free invulnerability for you.
		return
	cut_summoner(different_person)
	AddComponent(/datum/component/life_link, to_who, CALLBACK(src, PROC_REF(on_harm)), CALLBACK(src, PROC_REF(on_summoner_death)))
	summoner = to_who

	for (var/action_type in control_actions)
		if (locate(action_type) in summoner.actions)
			continue
		var/datum/action/new_action = new action_type(summoner)
		new_action.Grant(summoner)

	if (different_person)
		if (mind)
			mind.enslave_mind_to_creator(to_who)
		else //mindless guardian, manually give them factions
			add_faction(summoner.get_faction())
			add_ally(summoner.allies)
			summoner.add_ally(src)
	remove_all_languages(LANGUAGE_MASTER)
	copy_languages(to_who, LANGUAGE_MASTER) // make sure holoparasites speak same language as master
	RegisterSignal(to_who, COMSIG_QDELETING, PROC_REF(on_summoner_deletion))
	RegisterSignal(to_who, COMSIG_LIVING_ON_WABBAJACKED, PROC_REF(on_summoner_wabbajacked))
	RegisterSignal(to_who, COMSIG_LIVING_SHAPESHIFTED, PROC_REF(on_summoner_shapeshifted))
	RegisterSignal(to_who, COMSIG_LIVING_UNSHAPESHIFTED, PROC_REF(on_summoner_unshapeshifted))
	recall(forced = TRUE)
	leash_to(src, summoner)
	if (to_who.stat == DEAD)
		on_summoner_death(src, to_who)
	summoner.updatehealth()

/// Remove all references to our summoner
/mob/living/basic/guardian/proc/cut_summoner(different_person = FALSE)
	if (isnull(summoner))
		return
	if (is_deployed())
		recall_effects()
	var/summoner_turf = get_turf(summoner)
	if (!isnull(summoner_turf))
		forceMove(summoner_turf)
	unleash()
	UnregisterSignal(summoner, list(COMSIG_QDELETING, COMSIG_LIVING_ON_WABBAJACKED, COMSIG_LIVING_SHAPESHIFTED, COMSIG_LIVING_UNSHAPESHIFTED))
	if (different_person)
		summoner.remove_ally(src)
		remove_faction(summoner.get_faction())
		mind?.remove_all_antag_datums()
	if (!length(summoner.get_all_linked_holoparasites() - src))
		for (var/action_type in control_actions)
			var/datum/action/remove_action = locate(action_type) in summoner.actions
			if (isnull(remove_action))
				continue
			remove_action.Remove(summoner)
	summoner = null

/// Connects these two mobs by a leash
/mob/living/basic/guardian/proc/leash_to(atom/movable/leashed, atom/movable/leashed_to)
	leashed.AddComponent(\
		/datum/component/leash,\
		owner = leashed_to,\
		distance = range,\
		force_teleport_out_effect = /obj/effect/temp_visual/guardian/phase/out,\
		force_teleport_in_effect = /obj/effect/temp_visual/guardian/phase,\
	)

/// Removes the leash from this guardian
/mob/living/basic/guardian/proc/unleash()
	qdel(GetComponent(/datum/component/leash))

/// Called when our owner dies. We fucked up, so now neither of us get to exist.
/mob/living/basic/guardian/proc/on_summoner_death(mob/living/source, mob/living/former_owner)
	cut_summoner()
	if (!isnull(former_owner.loc))
		forceMove(former_owner.loc)
	to_chat(src, span_danger("你的召唤者死了！"))
	visible_message(span_bolddanger("\The [src] 随使用者一同死去了！"))
	former_owner.visible_message(span_bolddanger("[former_owner] 的身体因维持 [src] 而彻底耗尽了！"))
	former_owner.dust(drop_items = TRUE)

/// Called when our health changes, inform our owner of why they are getting hurt (if they are)
/mob/living/basic/guardian/proc/on_harm(mob/living/source, mob/living/summoner, amount)
	if (QDELETED(src) || QDELETED(summoner) || amount <= 2)
		return
	to_chat(summoner, span_bolddanger("[name] 正遭受攻击！你受到了伤害！"))
	summoner.visible_message(span_bolddanger("[summoner] 身上血花四溅，[src] 正受到伤害！"))
	if(summoner.stat >= HARD_CRIT)
		to_chat(summoner, span_bolddanger("你的头阵阵作痛，在这种状态下你无法承受维持 [src] 的负担！"))
		summoner.adjust_organ_loss(ORGAN_SLOT_BRAIN, amount * 0.5)

/// When our owner is deleted, we go too.
/mob/living/basic/guardian/proc/on_summoner_deletion(mob/living/source)
	SIGNAL_HANDLER
	cut_summoner()
	to_chat(src, span_danger("你的召唤者消失了，你感觉自己正在消散！"))
	ghostize(FALSE)
	qdel(src)

/// Signal proc for [COMSIG_LIVING_ON_WABBAJACKED], when our summoner is wabbajacked we should be alerted.
/mob/living/basic/guardian/proc/on_summoner_wabbajacked(mob/living/source, mob/living/new_mob)
	SIGNAL_HANDLER
	set_summoner(new_mob)
	to_chat(src, span_holoparasite("你的召唤者换了形态！"))

/// Signal proc for [COMSIG_LIVING_SHAPESHIFTED], when our summoner is shapeshifted we should change to the new mob
/mob/living/basic/guardian/proc/on_summoner_shapeshifted(mob/living/source, mob/living/new_shape)
	SIGNAL_HANDLER
	set_summoner(new_shape)
	to_chat(src, span_holoparasite("你的召唤者变成了 [new_shape]！"))

/// Signal proc for [COMSIG_LIVING_UNSHAPESHIFTED], when our summoner unshapeshifts go back to that mob
/mob/living/basic/guardian/proc/on_summoner_unshapeshifted(mob/living/source, mob/living/old_summoner)
	SIGNAL_HANDLER
	set_summoner(old_summoner)
	to_chat(src, span_holoparasite("你的召唤者变回了原本的形态！"))

/mob/living/basic/guardian/wabbajack(what_to_randomize, change_flags = WABBAJACK)
	visible_message(span_warning("[src] 抵抗住了变形！")) // Ha, no

/mob/living/basic/guardian/can_suicide()
	return FALSE // You gotta persuade your boss to end it instead, sorry

/// Returns true if you are out and about
/mob/living/basic/guardian/proc/is_deployed()
	return isnull(summoner) || loc != summoner
