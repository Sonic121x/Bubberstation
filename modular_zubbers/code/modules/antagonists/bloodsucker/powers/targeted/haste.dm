/* Level 1: Speed to location
 * Level 2: Dodge Bullets
 * Level 3: Stun People Passed
 */

#define HASTE_GETUP_LEVEL 3
/datum/action/cooldown/bloodsucker/targeted/haste
	name = "不死疾行"
	desc = "倒地时强行起身，以超自然速度冲向某处。附近的人可能被击退、击晕或打落手中物品。"
	button_icon_state = "power_speed"
	prefire_message = "你准备冲刺！"
	purchase_flags = BLOODSUCKER_CAN_BUY|GHOUL_CAN_BUY
	bloodsucker_check_flags = parent_type::bloodsucker_check_flags & ~BP_CANT_USE_IN_FRENZY
	bloodcost = 6
	cooldown_time = 12 SECONDS
	target_range = 5
	power_activates_immediately = FALSE
	///List of all people hit by our power, so we don't hit them again.
	var/list/hit = list()

/datum/action/cooldown/bloodsucker/targeted/haste/get_power_desc_extended()
	. = "冲向指定位置，击倒沿途的人并恢复耐力。附近的人可能被击退、击晕或打落手中物品。\n"
	if(level_current >= HASTE_GETUP_LEVEL)
		. += "倒地时冲刺会使你起身，但不会影响敌人。"
	else
		. += "被击倒时无法冲刺。"

/datum/action/cooldown/bloodsucker/targeted/haste/get_power_explanation_extended()
	. = list()
	. += "点击任意位置，立即向那里冲刺。"
	. += "达到[HASTE_GETUP_LEVEL]级后，倒地时可以起身并恢复耐力，但这次冲刺不会击倒附近的人。"
	. += "疾行会击倒敌人[DisplayTimeText(GetKnockdown())]并恢复你的耐力，但倒地时使用会使冷却时间延长至[DisplayTimeText(cooldown_time * 3)]。"
	. += "躺倒、处于失重环境或被强力抓住时，此能力无法生效。"
	. += "疾行途中挡路的人都会被击倒。"
	. += "等级越高，对敌人造成的击倒时间越长。"
	. += "它也会恢复耐力，让你能继续移动。"
	. += "若坚韧正在生效，使用疾行会将其关闭。"

/datum/action/cooldown/bloodsucker/targeted/haste/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	// Being Grabbed
	if(user.pulledby && user.pulledby.grab_state >= GRAB_AGGRESSIVE)
		user.balloon_alert(user, "你被抓住了！")
		return FALSE
	if(!user.has_gravity(user.loc)) //We dont want people to be able to use this to fly around in space
		user.balloon_alert(user, "漂浮时无法冲刺！")
		return FALSE
	if(level_current < HASTE_GETUP_LEVEL && user.body_position == LYING_DOWN)
		user.balloon_alert(user, "必须站着才能冲刺！")
		return FALSE
	return TRUE

/// Anything will do, if it's not mea or my square
/datum/action/cooldown/bloodsucker/targeted/haste/CheckValidTarget(atom/target_atom)
	. = ..()
	if(!.)
		return FALSE
	return target_atom.loc != owner.loc

/// This is a non-async proc to make sure the power is "locked" until this finishes.
/datum/action/cooldown/bloodsucker/targeted/haste/FireTargetedPower(atom/target, params)
	. = ..()
	var/mob/living/user = owner
	var/stuns_mobs = TRUE
	var/temp_cooldown = cooldown_time
	if(level_current >= HASTE_GETUP_LEVEL && user.body_position == LYING_DOWN)
		to_chat(user, span_danger("你的心脏跳动了一下，你强迫自己站了起来！"))
		user.SetKnockdown(0)
		user.set_stamina_loss(0)
		user.set_resting(FALSE, FALSE, TRUE)
		stuns_mobs = FALSE
		temp_cooldown = GetGetupCooldown()
	if(stuns_mobs)
		RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	var/turf/targeted_turf = isturf(target) ? target : get_turf(target)
	// Pulled? Not anymore.
	user.pulledby?.stop_pulling()
	// Go to target turf
	// DO NOT USE WALK TO.
	owner.balloon_alert(owner, "你腾空冲出！")
	playsound(get_turf(owner), 'sound/items/weapons/punchmiss.ogg', 25, 1, -1)
	var/safety = get_dist(user, targeted_turf) * 3 + 1
	var/consequetive_failures = 0
	active = TRUE
	while(--safety && (get_turf(user) != targeted_turf))
		var/success = step_towards(user, targeted_turf) //This does not try to go around obstacles.
		if(!success)
			success = step_to(user, targeted_turf) //this does
		if(!success)
			consequetive_failures++
			if(consequetive_failures >= 3) //if 3 steps don't work
				break //just stop
		else
			consequetive_failures = 0 //reset so we can keep moving
		if(user.resting || INCAPACITATED_IGNORING(user, INCAPABLE_GRAB|INCAPABLE_RESTRAINTS)) //actually down? stop.
			break
		if(success) //don't sleep if we failed to move.
			sleep(world.tick_lag)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	hit.Cut()
	user.adjust_stamina_loss(-user.staminaloss)
	PowerActivatedSuccesfully(temp_cooldown)

/datum/action/cooldown/bloodsucker/targeted/haste/proc/GetKnockdown()
	return 10 + level_current * 4

/datum/action/cooldown/bloodsucker/targeted/haste/proc/GetGetupCooldown()
	return cooldown_time * 3

/datum/action/cooldown/bloodsucker/targeted/haste/proc/on_move()
	for(var/mob/living/hit_living in dview(1, get_turf(owner)) - owner)
		if(hit.Find(hit_living))
			continue
		hit += hit_living
		playsound(hit_living, "sound/weapons/punch[rand(1,4)].ogg", 15, 1, -1)
		hit_living.Knockdown(GetKnockdown())
		hit_living.spin(10, 1)

#undef HASTE_GETUP_LEVEL
