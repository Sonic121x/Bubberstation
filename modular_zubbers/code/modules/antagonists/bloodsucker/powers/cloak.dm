#define USE_SEEN_CLOAK_LEVEL 2
#define USE_RUN_CLOAK_LEVEL 4

/datum/action/cooldown/bloodsucker/cloak
	name = "黑暗斗篷"
	desc = "融入阴影，避开未经训练者和人工视觉的观察。"
	button_icon_state = "power_cloak"
	power_explanation = "黑暗斗篷：\n\
		在阴影中启用该能力，你将逐渐变得近乎隐形。\n\
		使用黑暗斗篷时，尝试奔跑会压伤自己。\n\
		此外，斗篷生效时，AI完全无法看见你。\n\
		等级越高，隐形效果越好。\n\
		达到2级后，无需避开他人视线也能启用该能力。\n\
		达到4级后，你可以在隐形时奔跑。"
	power_flags = BP_CONTINUOUS_EFFECT
	check_flags = AB_CHECK_CONSCIOUS
	purchase_flags = BLOODSUCKER_CAN_BUY|GHOUL_CAN_BUY
	bloodcost = 5
	constant_bloodcost = 0.2
	cooldown_time = 5 SECONDS
	var/was_running

/// Must have nobody around to see the cloak
/datum/action/cooldown/bloodsucker/cloak/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	if(level_current < USE_SEEN_CLOAK_LEVEL)
		for(var/mob/living/watcher in oviewers(9, owner))
			if(!watcher.mind)
				continue
			if(!can_see(watcher, owner))
				continue
			if(IS_BLOODSUCKER(watcher) || IS_GHOUL(watcher))
				continue
			owner.balloon_alert(owner, "无人看见时才能隐形")
			return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/cloak/ActivatePower(atom/target)
	var/mob/living/user = owner
	was_running = (user.move_intent == MOVE_INTENT_RUN)
	if(level_current < USE_RUN_CLOAK_LEVEL && was_running)
		user.toggle_move_intent()
	user.AddElement(/datum/element/digitalcamo)
	user.balloon_alert(user, "斗篷已启用")
	return TRUE

/datum/action/cooldown/bloodsucker/cloak/process(seconds_per_tick)
	// Checks that we can keep using this.
	. = ..()
	if(!.)
		return
	if(!active)
		return
	var/mob/living/user = owner
	animate(user, alpha = max(25, owner.alpha - min(75, 10 + 5 * level_current)), time = 1.5 SECONDS)
	// Prevents running while on Cloak of Darkness
	if(level_current < USE_RUN_CLOAK_LEVEL && user.move_intent != MOVE_INTENT_WALK)
		owner.balloon_alert(owner, "尝试奔跑压伤了自己")
		user.toggle_move_intent()
		user.adjust_brute_loss(rand(5, 15))

/datum/action/cooldown/bloodsucker/cloak/ContinueActive(mob/living/user, mob/living/target)
	. = ..()
	if(!.)
		return FALSE
	/// Must be CONSCIOUS
	if(IS_UNCONSCIOUS(user))
		to_chat(owner, span_warning("你失去了意识，斗篷失效了！"))
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/cloak/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return
	var/mob/living/user = owner
	animate(user, alpha = 255, time = 1 SECONDS)
	user.RemoveElement(/datum/element/digitalcamo)
	if(level_current < USE_RUN_CLOAK_LEVEL && was_running && user.move_intent == MOVE_INTENT_WALK)
		user.toggle_move_intent()
	user.balloon_alert(user, "斗篷已关闭")

#undef USE_SEEN_CLOAK_LEVEL
#undef USE_RUN_CLOAK_LEVEL
