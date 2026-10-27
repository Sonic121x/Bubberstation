#define SLAM_COMBO "GH"
#define KICK_COMBO "HH"
#define RESTRAIN_COMBO "GG"
#define PRESSURE_COMBO "DG"
#define CONSECUTIVE_COMBO "DDH"

/datum/martial_art/cqc
	name = "CQC"
	id = MARTIALART_CQC
	help_verb = "回顾 CQC 基础"
	smashes_tables = TRUE
	display_combos = TRUE
	/// Weakref to a mob we're currently restraining (with grab-grab combo)
	VAR_PRIVATE/datum/weakref/restraining_mob
	/// Probability of successfully blocking attacks while on throw mode
	var/block_chance = 75

/datum/martial_art/cqc/activate_style(mob/living/new_holder)
	. = ..()
	RegisterSignal(new_holder, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(new_holder, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(check_block))

/datum/martial_art/cqc/deactivate_style(mob/living/remove_from)
	UnregisterSignal(remove_from, list(COMSIG_ATOM_ATTACKBY, COMSIG_LIVING_CHECK_BLOCK))
	return ..()

///Signal from getting attacked with an item, for a special interaction with touch spells
/datum/martial_art/cqc/proc/on_attackby(mob/living/cqc_user, obj/item/attack_weapon, mob/attacker, list/modifiers)
	SIGNAL_HANDLER

	if(!istype(attack_weapon, /obj/item/melee/touch_attack))
		return
	if(!can_use(cqc_user))
		return
	cqc_user.visible_message(
		span_danger("[cqc_user]扭转[attacker]的手臂，将[attack_weapon]反送向攻击者自己！"),
		span_userdanger("你避开[attacker]的[attack_weapon]，扭转对方的手臂，将攻击原路奉还！"),
	)
	var/obj/item/melee/touch_attack/touch_weapon = attack_weapon
	var/datum/action/cooldown/spell/touch/touch_spell = touch_weapon.spell_which_made_us?.resolve()
	if(!touch_spell)
		return
	INVOKE_ASYNC(touch_spell, TYPE_PROC_REF(/datum/action/cooldown/spell/touch, do_hand_hit), touch_weapon, attacker, attacker)
	return COMPONENT_NO_AFTERATTACK

/datum/martial_art/cqc/proc/check_block(mob/living/cqc_user, atom/movable/hitby, damage, attack_text, attack_type, ...)
	SIGNAL_HANDLER

	if(!can_use(cqc_user) || !cqc_user.throw_mode || INCAPACITATED_IGNORING(cqc_user, INCAPABLE_GRAB))
		return NONE
	if(attack_type == PROJECTILE_ATTACK)
		return NONE

	var/blocking_text = "格挡了"
	var/blocking_text_s = "格挡了"
	var/potential_block_chance = block_chance

	if(attack_type == OVERWHELMING_ATTACK)
		blocking_text = "躲过了"
		blocking_text_s = "躲过了"
		potential_block_chance = clamp(round(potential_block_chance / (attack_type == OVERWHELMING_ATTACK ? 2 : 1), 1), 0, 100)

	if(!prob(potential_block_chance))
		return NONE

	var/mob/living/attacker = GET_ASSAILANT(hitby)
	if(istype(attacker) && cqc_user.Adjacent(attacker))
		cqc_user.visible_message(
			span_danger("[cqc_user][blocking_text_s][attack_text]，并将[attacker]的手臂反扭到背后！"),
			span_userdanger("你[blocking_text][attack_text]！"),
		)
		attacker.Stun(4 SECONDS)
	else
		cqc_user.visible_message(
			span_danger("[cqc_user][blocking_text_s][attack_text]！"),
			span_userdanger("你[blocking_text][attack_text]！"),
		)
	return SUCCESSFUL_BLOCK


/datum/martial_art/cqc/reset_streak(mob/living/new_target)
	if(!IS_WEAKREF_OF(new_target, restraining_mob))
		restraining_mob = null
	return ..()

/datum/martial_art/cqc/proc/check_streak(mob/living/attacker, mob/living/defender)
	if(findtext(streak, SLAM_COMBO))
		reset_streak()
		return Slam(attacker, defender)
	if(findtext(streak, KICK_COMBO))
		reset_streak()
		return Kick(attacker, defender)
	if(findtext(streak, RESTRAIN_COMBO))
		reset_streak()
		return Restrain(attacker, defender)
	if(findtext(streak, PRESSURE_COMBO))
		reset_streak()
		return Pressure(attacker, defender)
	if(findtext(streak, CONSECUTIVE_COMBO))
		reset_streak()
		return Consecutive(attacker, defender)
	return FALSE

/datum/martial_art/cqc/proc/Slam(mob/living/attacker, mob/living/defender)
	if(defender.body_position != STANDING_UP)
		return FALSE

	attacker.do_attack_animation(defender)
	defender.visible_message(
		span_danger("[attacker]将[defender]狠狠摔向地面！"),
		span_userdanger("[attacker]将你狠狠摔向地面！"),
		span_hear("你听到肉体碰撞的骇人闷响！"),
		null,
		attacker,
	)
	to_chat(attacker, span_danger("你将[defender]狠狠摔向地面！"))
	playsound(attacker, 'sound/items/weapons/slam.ogg', 50, TRUE, -1)
	defender.apply_damage(10, BRUTE)
	defender.Paralyze(12 SECONDS)
	log_combat(attacker, defender, "slammed (CQC)")
	return TRUE

/datum/martial_art/cqc/proc/Kick(mob/living/attacker, mob/living/defender)
	if(IS_UNCONSCIOUS_OR_CRIT(defender))
		return FALSE

	attacker.do_attack_animation(defender)
	if(defender.body_position == LYING_DOWN && !IS_UNCONSCIOUS(defender) && defender.get_stamina_loss() >= 100)
		log_combat(attacker, defender, "knocked out (Head kick)(CQC)")
		defender.visible_message(
			span_danger("[attacker]踢中[defender]的头部，将其踢昏！"),
			span_userdanger("[attacker]将你踢昏了！"),
			span_hear("你听到肉体碰撞的骇人闷响！"),
			null,
			attacker,
		)
		to_chat(attacker, span_danger("你踢中[defender]的头部，将其踢昏！"))
		playsound(attacker, 'sound/items/weapons/genhit1.ogg', 50, TRUE, -1)

		var/helmet_protection = defender.run_armor_check(BODY_ZONE_HEAD, MELEE)
		defender.apply_effect(20 SECONDS, EFFECT_KNOCKDOWN, helmet_protection)
		defender.apply_effect(10 SECONDS, EFFECT_UNCONSCIOUS, helmet_protection)
		defender.adjust_organ_loss(ORGAN_SLOT_BRAIN, 15, 150)

	else
		defender.visible_message(
			span_danger("[attacker]将[defender]踢退！"),
			span_userdanger("[attacker]将你踢退！"),
			span_hear("你听到肉体碰撞的骇人闷响！"),
			COMBAT_MESSAGE_RANGE,
			attacker,
		)
		to_chat(attacker, span_danger("你将[defender]踢退！"))
		playsound(attacker, 'sound/items/weapons/cqchit1.ogg', 50, TRUE, -1)
		var/atom/throw_target = get_edge_target_turf(defender, attacker.dir)
		defender.throw_at(throw_target, 1, 14, attacker)
		defender.apply_damage(10, attacker.get_attack_type())
		if(defender.body_position == LYING_DOWN && !IS_UNCONSCIOUS(defender))
			defender.adjust_stamina_loss(45)
		log_combat(attacker, defender, "kicked (CQC)")

	return TRUE

/datum/martial_art/cqc/proc/Pressure(mob/living/attacker, mob/living/defender)
	attacker.do_attack_animation(defender)
	log_combat(attacker, defender, "pressured (CQC)")
	defender.visible_message(
		span_danger("[attacker]一拳击中[defender]的颈部！"),
		span_userdanger("[attacker]一拳击中你的颈部！"),
		span_hear("你听到肉体碰撞的骇人闷响！"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)
	to_chat(attacker, span_danger("你一拳击中[defender]的颈部！"))
	defender.adjust_stamina_loss(60)
	playsound(attacker, 'sound/items/weapons/cqchit1.ogg', 50, TRUE, -1)
	return TRUE

/datum/martial_art/cqc/proc/Restrain(mob/living/attacker, mob/living/defender)
	if(restraining_mob?.resolve())
		return FALSE
	if(IS_UNCONSCIOUS_OR_CRIT(defender))
		return FALSE

	log_combat(attacker, defender, "restrained (CQC)")
	defender.visible_message(
		span_warning("[attacker]用擒拿姿势锁住了[defender]！"),
		span_userdanger("[attacker]用擒拿姿势锁住了你！"),
		span_hear("你听到扭动声和一声低沉的呻吟！"),
		null,
		attacker,
	)
	to_chat(attacker, span_danger("你用擒拿姿势锁住了[defender]！"))
	defender.adjust_stamina_loss(20)
	defender.Stun(10 SECONDS)
	restraining_mob = WEAKREF(defender)
	addtimer(VARSET_CALLBACK(src, restraining_mob, null), 5 SECONDS, TIMER_UNIQUE)
	return TRUE

/datum/martial_art/cqc/proc/Consecutive(mob/living/attacker, mob/living/defender)
	if(IS_UNCONSCIOUS_OR_CRIT(defender))
		return FALSE

	attacker.do_attack_animation(defender)
	log_combat(attacker, defender, "consecutive CQC'd (CQC)")
	defender.visible_message(
		span_danger("[attacker]连续击打[defender]的腹部、颈部和背部！"), \
		span_userdanger("[attacker]连续击打你的腹部、颈部和背部！"),
		span_hear("你听到肉体碰撞的骇人闷响！"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)
	to_chat(attacker, span_danger("你连续击打[defender]的腹部、颈部和背部！"))
	playsound(defender, 'sound/items/weapons/cqchit2.ogg', 50, TRUE, -1)
	var/obj/item/held_item = defender.get_active_held_item()
	if(held_item && defender.temporarilyRemoveItemFromInventory(held_item))
		attacker.put_in_hands(held_item)
	defender.adjust_stamina_loss(50)
	defender.apply_damage(25, attacker.get_attack_type())
	return TRUE

/datum/martial_art/cqc/grab_act(mob/living/attacker, mob/living/defender)
	if(attacker == defender)
		return MARTIAL_ATTACK_INVALID
	if(defender.check_block(attacker, 0, attacker.name, UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	add_to_streak("G", defender)
	if(check_streak(attacker, defender)) //if a combo is made no grab upgrade is done
		return MARTIAL_ATTACK_SUCCESS
	if(attacker.body_position == LYING_DOWN)
		return MARTIAL_ATTACK_INVALID

	var/old_grab_state = attacker.grab_state
	defender.grabbedby(attacker, TRUE)
	if(old_grab_state == GRAB_PASSIVE)
		defender.drop_all_held_items()
		attacker.setGrabState(GRAB_AGGRESSIVE) //Instant aggressive grab if on grab intent
		log_combat(attacker, defender, "grabbed", addition="aggressively")
		defender.visible_message(
			span_warning("[attacker]粗暴地抓住了[defender]！"),
			span_userdanger("[attacker]粗暴地抓住了你！"),
			span_hear("你听到激烈的抓扯声！"),
			COMBAT_MESSAGE_RANGE,
			attacker,
		)
		to_chat(attacker, span_danger("你粗暴地抓住了[defender]！"))
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/cqc/harm_act(mob/living/attacker, mob/living/defender)
	if(attacker.grab_state == GRAB_KILL \
		&& attacker.zone_selected == BODY_ZONE_HEAD \
		&& attacker.pulling == defender \
		&& defender.stat != DEAD \
	)
		var/obj/item/bodypart/head = defender.get_bodypart(BODY_ZONE_HEAD)
		if(!isnull(head))
			playsound(defender, 'sound/effects/wounds/crack1.ogg', 100)
			defender.visible_message(
				span_danger("[attacker]扭断了[defender]的脖子！"),
				span_userdanger("[attacker]扭断了你的脖子！"),
				span_hear("你听到一声骇人的断裂声！"),
				ignored_mobs = attacker
			)
			to_chat(attacker, span_danger("你干脆利落地扭断了[defender]的脖子！"))
			log_combat(attacker, defender, "snapped neck")
			defender.apply_damage(100, BRUTE, BODY_ZONE_HEAD, wound_bonus=CANT_WOUND)
			if(!HAS_TRAIT(defender, TRAIT_NODEATH))
				defender.death()
				defender.investigate_log("被[attacker]扭断了脖子。", INVESTIGATE_DEATHS)
			return MARTIAL_ATTACK_SUCCESS

	if(defender.check_block(attacker, 10, attacker.name, UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	if(attacker.resting && defender.stat != DEAD && defender.body_position == STANDING_UP)
		defender.visible_message(
			span_danger("[attacker]对[defender]使出了扫堂腿！"),
			span_userdanger("[attacker]扫中了你的双腿！"),
			span_hear("你听到肉体碰撞的骇人闷响！"),
			null,
			attacker,
		)
		to_chat(attacker, span_danger("你对[defender]使出了扫堂腿！"))
		playsound(attacker, 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
		attacker.do_attack_animation(defender)
		defender.apply_damage(10, BRUTE)
		defender.Knockdown(5 SECONDS)
		log_combat(attacker, defender, "sweeped (CQC)")
		reset_streak()
		return MARTIAL_ATTACK_SUCCESS

	add_to_streak("H", defender)
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS
	attacker.do_attack_animation(defender)
	var/picked_hit_type = pick("CQC", "Big Boss")
	var/bonus_damage = 13
	if(defender.body_position == LYING_DOWN)
		bonus_damage += 5
		picked_hit_type = pick("kick", "stomp")
	defender.apply_damage(bonus_damage, BRUTE)

	playsound(defender, (picked_hit_type == "kick" || picked_hit_type == "stomp") ? 'sound/items/weapons/cqchit2.ogg' : 'sound/items/weapons/cqchit1.ogg', 50, TRUE, -1)

	defender.visible_message(
		span_danger("[attacker]以[chinese_cqc_hit_display(picked_hit_type)]攻击了[defender]！"),
		span_userdanger("[attacker]以[chinese_cqc_hit_display(picked_hit_type)]攻击了你！"),
		span_hear("你听到肉体碰撞的骇人闷响！"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)
	to_chat(attacker, span_danger("你以[chinese_cqc_hit_display(picked_hit_type)]攻击了[defender]！"))
	log_combat(attacker, defender, "attacked ([picked_hit_type]'d)(CQC)")
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/cqc/disarm_act(mob/living/attacker, mob/living/defender)
	if(defender.check_block(attacker, 0, attacker.name, UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	add_to_streak("D", defender)
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS

	if(IS_WEAKREF_OF(attacker.pulling, restraining_mob))
		log_combat(attacker, defender, "disarmed (CQC)", addition = "knocked out (CQC Chokehold)")
		defender.visible_message(
			span_danger("[attacker]锁住了[defender]的喉咙！"),
			span_userdanger("[attacker]锁住了你的喉咙！"),
			span_hear("你听到扭动声和一声低沉的呻吟！"),
			null,
			attacker,
		)
		to_chat(attacker, span_danger("你锁住了[defender]的喉咙！"))
		defender.SetSleeping(40 SECONDS)
		restraining_mob = null
		if(attacker.grab_state < GRAB_NECK && !HAS_TRAIT(attacker, TRAIT_PACIFISM))
			attacker.setGrabState(GRAB_NECK)
		return MARTIAL_ATTACK_SUCCESS

	attacker.do_attack_animation(defender, ATTACK_EFFECT_DISARM)
	if(prob(65) && (!IS_UNCONSCIOUS_OR_CRIT(defender) || !defender.IsParalyzed() || !restraining_mob?.resolve()))
		var/obj/item/disarmed_item = defender.get_active_held_item()
		if(disarmed_item && defender.temporarilyRemoveItemFromInventory(disarmed_item))
			defender.dropItemToGround(disarmed_item)
			if(isturf(disarmed_item.loc)) //If it fell on the ground we can take it, otherwise assume it's attached to something.
				attacker.put_in_hands(disarmed_item)
			else
				disarmed_item = null
		else
			disarmed_item = null

		defender.visible_message(
			span_danger("[attacker]用手击打[defender]的下颌[disarmed_item ? "，夺下了[disarmed_item]" : ""]！"),
			span_userdanger("[attacker]击打你的下颌[disarmed_item ? "，夺下了你的[disarmed_item]" : ""]，让你晕头转向！"),
			span_hear("你听到肉体碰撞的骇人闷响！"),
			COMBAT_MESSAGE_RANGE,
			attacker,
		)
		to_chat(attacker, span_danger("你击打[defender]的下颌[disarmed_item ? "，夺下了[disarmed_item]" : ""]，让其晕头转向！"))
		playsound(defender, 'sound/items/weapons/cqchit1.ogg', 50, TRUE, -1)
		defender.set_jitter_if_lower(4 SECONDS)
		defender.apply_damage(5, attacker.get_attack_type())
		log_combat(attacker, defender, "disarmed (CQC)", addition = disarmed_item ? "(disarmed of [disarmed_item])" : null)
		return MARTIAL_ATTACK_SUCCESS

	defender.visible_message(
		span_danger("[attacker]没能缴械[defender]！"), \
		span_userdanger("[attacker]差点将你缴械！"),
		span_hear("你听到呼的一声！"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)
	to_chat(attacker, span_warning("你没能缴械[defender]！"))
	playsound(defender, 'sound/items/weapons/punchmiss.ogg', 25, TRUE, -1)
	log_combat(attacker, defender, "failed to disarm (CQC)")
	return MARTIAL_ATTACK_FAIL


/datum/martial_art/cqc/get_style_help()
	. = list()

	. += "<b><i>你试着回忆 CQC 的一些基础招式。</i></b>"

	. += "[span_notice("摔击")]：抓取、拳击。将对手摔向地面，使其倒地。"
	. += "[span_notice("CQC 踢击")]：拳击、拳击。将对手踢退；可击昏已失去行动能力的对手，并造成体力伤害。"
	. += "[span_notice("擒拿")]：抓取、抓取。锁住对手，随后使用缴械可通过锁喉使其昏迷。"
	. += "[span_notice("压迫打击")]：推搡、抓取。造成可观的体力伤害。"
	. += "[span_notice("连续 CQC")]：推搡、推搡、拳击。以进攻为主，造成大量伤害与可观的体力伤害。"

	. += "<b><i>此外，受攻击时开启投掷模式即可进入主动防御状态，有机会格挡，甚至反击对方的攻击。</i></b>"
	return .

///Subtype of CQC. Only used for the chef.
/datum/martial_art/cqc/under_siege
	name = "近身烹饪术"
	///List of all areas that CQC will work in, defaults to Kitchen.
	var/list/kitchen_areas = list(/area/station/service/kitchen)

/// Refreshes the valid areas from the cook's mapping config, adding areas in config to the list of possible areas.
/datum/martial_art/cqc/under_siege/proc/refresh_valid_areas()
	var/list/additional_cqc_areas = CHECK_MAP_JOB_CHANGE(JOB_COOK, "additional_cqc_areas")
	if(!additional_cqc_areas)
		return

	if(!islist(additional_cqc_areas))
		stack_trace("Incorrect CQC area format from mapping configs. Expected /list, got: \[[additional_cqc_areas.type]\]")
		return

	for(var/path_as_text in additional_cqc_areas)
		var/path = text2path(path_as_text)
		if(!ispath(path, /area))
			stack_trace("Invalid path in mapping config for chef CQC: \[[path_as_text]\]")
			continue

		kitchen_areas |= path

/// Limits where the chef's CQC can be used to only whitelisted areas.
/datum/martial_art/cqc/under_siege/can_use(mob/living/martial_artist)
	if(!is_type_in_list(get_area(martial_artist), kitchen_areas))
		return FALSE
	return ..()

#undef SLAM_COMBO
#undef KICK_COMBO
#undef RESTRAIN_COMBO
#undef PRESSURE_COMBO
#undef CONSECUTIVE_COMBO
