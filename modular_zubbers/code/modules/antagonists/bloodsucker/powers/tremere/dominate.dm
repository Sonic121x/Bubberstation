/**
 *	# Dominate;
 *
 *	Level 1 - Mesmerizes target
 *	Level 2 - Mesmerizes and mutes target
 *	Level 3 - Mesmerizes, blinds and mutes target
 *	Level 4 - Target (if at least in crit & has a mind) will revive as a Mute/Deaf Ghoul for 5 minutes before dying.
 *	Level 5 - Target (if at least in crit & has a mind) will revive as a Ghoul for 8 minutes before dying.
 */

#define TEMP_GHOULIZE_COST 150
#define DOMINATE_XRAY_LEVEL 3
#define DOMINATE_NON_MUTE_GHOULIZE_LEVEL 4
/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate
	name = "支配"
	button_icon_state = "power_auspex"
	background_icon_state = "tremere_power_off"
	active_background_icon_state = "tremere_power_on"
	base_background_icon_state = "tremere_power_off"
	button_icon = 'modular_zubbers/icons/mob/actions/tremere_bloodsucker.dmi'
	background_icon = 'modular_zubbers/icons/mob/actions/tremere_bloodsucker.dmi'
	level_current = 1
	button_icon_state = "power_dominate"
	purchase_flags = TREMERE_CAN_BUY
	bloodcost = 15
	constant_bloodcost = 0.1
	target_range = 6
	mesmerize_delay = 4 SECONDS
	blind_at_level = 3
	requires_facing_target = FALSE
	blocked_by_glasses = FALSE
	knockdown_on_secondary = TRUE
	/// Data huds to show while the power is active
	var/list/datahuds = list(DATA_HUD_SECURITY_ADVANCED, DATA_HUD_MEDICAL_ADVANCED, DATA_HUD_DIAGNOSTIC, DATA_HUD_BOT_PATH)
	var/list/thralls = list()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/Remove(mob/removed_from)
	. = ..()
	for(var/thrall in thralls)
		if(!thrall)
			continue
		end_possession(thrall)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/get_power_desc_extended()
	. = ..()
	if(level_current >= DOMINATE_GHOULIZE_LEVEL)
		. += "若目标濒死或已死亡，则会被转化为临时血仆，消耗[TEMP_GHOULIZE_COST]血量。原本已是血仆的死者只会被复活。"

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/get_power_explanation_extended()
	. = list()
	. += "点击任意人，在[DisplayTimeText(mesmerize_delay)]后使其眩晕[DisplayTimeText(get_power_time())]。"
	. += "右键点击受害者会将其击倒，并使其混乱、减速[DisplayTimeText(get_power_time())]。"
	. += "左键点击会将目标完全定身并致盲[DisplayTimeText(get_power_time())]，同时禁言[DisplayTimeText(get_power_time())]。"
	. += "此能力生效时，你能看到房间内所有人的更多信息。"
	. += "达到[DOMINATE_XRAY_LEVEL]级后，此能力生效时会给予你透视视觉。"
	. += "达到[DOMINATE_GHOULIZE_LEVEL]级后，贴近濒死或已死亡的目标使用，会将其转化为临时血仆，消耗[TEMP_GHOULIZE_COST]血量。"
	. += "受害者至少需要[BLOOD_VOLUME_BAD]血量才能被转化为血仆。"
	. += "若[src]低于[DOMINATE_NON_MUTE_GHOULIZE_LEVEL]级，血仆会又聋又哑。"
	. += "对已死亡的普通血仆使用时，其不会像临时血仆一样在时限结束后猝死。"
	. += "临时血仆会完全忠于你，直到施放后[DisplayTimeText(get_ghoul_duration())]死亡。"
	. += "转化或复活血仆会使此能力进入[DisplayTimeText(get_ghoulize_cooldown())]冷却。"

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/CheckCanTarget(atom/target_atom)
	var/mob/living/selected_target = target_atom
	if(level_current >= DOMINATE_GHOULIZE_LEVEL && (IS_GHOUL(selected_target) || selected_target.stat >= SOFT_CRIT))
		if(selected_target?.mind && owner.Adjacent(selected_target))
			return TRUE
	. = ..()
	if(!.)
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/ContinueActive(mob/living/user, mob/living/target)
	if(!target)
		return can_use(user)
	. = ..()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/ActivatePower(atom/target)
	. = ..()
	if(level_current >= DOMINATE_XRAY_LEVEL)
		ADD_TRAIT(owner, TRAIT_XRAY_VISION, DOMINATE_TRAIT)
	for(var/hudtype in datahuds)
		var/datum/atom_hud/data_hud = GLOB.huds[hudtype]
		data_hud.show_to(owner)
	owner.update_sight()
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return
	if(level_current >= DOMINATE_XRAY_LEVEL)
		REMOVE_TRAIT(owner, TRAIT_XRAY_VISION, DOMINATE_TRAIT)
	for(var/hudtype in datahuds)
		var/datum/atom_hud/data_hud = GLOB.huds[hudtype]
		data_hud.hide_from(owner)
	owner.update_sight()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/FireTargetedPower(atom/target, params)
	var/mob/living/target_mob = target
	var/mob/living/user = owner
	if(IS_UNCONSCIOUS(target_mob) && level_current >= DOMINATE_GHOULIZE_LEVEL)
		if(user.Adjacent(target))
			attempt_ghoulize(target, user)
		else
			if(IS_GHOUL(target_mob))
				owner.balloon_alert(owner, "太远，无法复活！")
			else
				owner.balloon_alert(owner, "太远，无法转化血仆！")
		return TRUE
	return ..()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/attempt_ghoulize(mob/living/target, mob/living/user)
	owner.face_atom(target)
	var/datum/antagonist/ghoul/ghoul = IS_GHOUL(target)
	if(!victim_has_blood(target))
		return FALSE
	if(ghoul)
		owner.balloon_alert(owner, "正在尝试复活")
	else
		owner.balloon_alert(owner, "正在尝试转化血仆")
	if(!do_after(user, 6 SECONDS, target, NONE, TRUE))
		return FALSE
	if(!victim_has_blood(target))
		return FALSE
	if(ghoul?.master == bloodsuckerdatum_power)
		if(target.stat != DEAD)
			owner.balloon_alert(owner, "尚未死亡！")
			return FALSE
		PowerActivatedSuccesfully(get_ghoulize_cooldown())
		to_chat(user, span_warning("我们复活了[target]！"))
		owner.balloon_alert(owner, "复活成功！")
		target.mind?.grab_ghost()
		target.revive(ADMIN_HEAL_ALL)
		pay_cost(TEMP_GHOULIZE_COST - bloodcost)
		log_combat(owner, target, "特雷默复活", addition="使用支配复活了自己的血仆")
		return FALSE
	if(!bloodsuckerdatum_power.make_ghoul(target))
		owner.balloon_alert(owner, "目标无法转化为血仆！")
		return

	/*if(IS_MONSTERHUNTER(target))
		to_chat(target, span_notice("这具身体拒绝回应……"))
		return*/
	PowerActivatedSuccesfully(get_ghoulize_cooldown())
	to_chat(user, span_warning("我们复活了[target]！"))
	// no escaping at this point
	target.mind?.grab_ghost(TRUE)
	target.revive(ADMIN_HEAL_ALL)
	var/datum/antagonist/ghoul/ghouldatum = target.mind.has_antag_datum(/datum/antagonist/ghoul)
	ghouldatum.special_type = TREMERE_GHOUL //don't turn them into a favorite please
	var/living_time = get_ghoul_duration()
	log_combat(owner, target, "特雷默心智奴役", addition="复活[target]并转化为临时特雷默血仆，持续[DisplayTimeText(living_time)]。")
	if(level_current <= DOMINATE_NON_MUTE_GHOULIZE_LEVEL)
		target.add_traits(list(TRAIT_MUTE, TRAIT_DEAF), DOMINATE_TRAIT)
	user.balloon_alert(target, "只能再活[DisplayTimeText(living_time)]！")
	to_chat(target, span_warning("你只能再活[DisplayTimeText(living_time)]！服从主人，轰轰烈烈地迎接终结吧！"))
	var/timer_id = addtimer(CALLBACK(src, PROC_REF(end_possession), target), living_time, TIMER_STOPPABLE)
	// timer that only the master and thrall can see
	setup_timer(user, target, living_time, timer_id)
	thralls += target
	RegisterSignals(target, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING), PROC_REF(end_possession), timer_id)
	RegisterSignal(ghouldatum, COMSIG_ANTAGONIST_REMOVED, PROC_REF(on_antag_datum_removal), target, timer_id)
	pay_cost(TEMP_GHOULIZE_COST - bloodcost)
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/victim_has_blood(mob/living/target)
	// you can always revive non-temporary ghouls
	if(IS_GHOUL(target))
		return TRUE
	if(target.blood_volume < BLOOD_VOLUME_BAD)
		owner.balloon_alert(owner, "受害者血量不足！")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/setup_timer(mob/living/user, mob/living/target, living_time, timer_id)
	var/list/show_to = list(user, target)
	if(bloodsuckerdatum_power && length(bloodsuckerdatum_power.ghouls))
		for(var/datum/antagonist/ghoul in bloodsuckerdatum_power.ghouls)
			if(!ghoul?.owner?.current)
				continue
			show_to += ghoul.owner.current
	new /atom/movable/screen/text/screen_timer/attached(null, show_to, timer_id, "将在${timer}后死亡", null, null, target)
	new /atom/movable/screen/text/screen_timer(null, target, timer_id, "你将在${timer}后死亡")

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/on_antag_datum_removal(datum/antagonist/ghoul, mob/living/thrall, timer_id)
	end_possession(thrall, timer_id)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/end_possession(mob/living/user, timer_id)
	if(timer_id)
		deltimer(timer_id)
	if(!user)
		CRASH("[src] end_possession called with no user!")
	if(!(user in thralls))
		return
	thralls -= user
	user.remove_traits(list(TRAIT_MUTE, TRAIT_DEAF), DOMINATE_TRAIT)
	if(!HAS_TRAIT(user, TRAIT_NOBLOOD))
		user.blood_volume = 0
	if(!IS_GHOUL(user))
		to_chat(user, span_warning("你感到维持生命的血液耗尽了！"))
		return
	to_chat(user, span_warning("你感到主人的血液耗尽了！"))
	user.mind?.remove_antag_datum(/datum/antagonist/ghoul)
	if(user.stat == DEAD)
		return
	user.death()

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/get_ghoul_duration()
	return 4 MINUTES * max(level_current, 1)

/datum/action/cooldown/bloodsucker/targeted/mesmerize/dominate/proc/get_ghoulize_cooldown()
	return cooldown_time * 3

#undef TEMP_GHOULIZE_COST
#undef DOMINATE_XRAY_LEVEL
#undef DOMINATE_NON_MUTE_GHOULIZE_LEVEL
