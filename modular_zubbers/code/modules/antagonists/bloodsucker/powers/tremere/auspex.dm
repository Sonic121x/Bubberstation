/**
 *	# Auspex
 *
 *	Level 1 - Cloak of Darkness until clicking an area, teleports the user to the selected area (max 2 tile)
 *	Level 2 - Cloak of Darkness until clicking an area, teleports the user to the selected area (max 3 tiles)
 *	Level 3 - Cloak of Darkness until clicking an area, teleports the user to the selected area
 *	Level 4 - Cloak of Darkness until clicking an area, teleports the user to the selected area, causes nearby people to bleed.
 *	Level 5 - Cloak of Darkness until clicking an area, teleports the user to the selected area, causes nearby people to fall asleep.
 */

#define AUSPEX_BLOOD_COST_PER_TILE 5
#define AUSPEX_BLEED_LEVEL 4
#define AUSPEX_KNOCKDOWN_LEVEL 5
#define AUSPEX_ANYWHERE_LEVEL 6
/datum/action/cooldown/bloodsucker/targeted/tremere/auspex
	name = "灵视"
	level_current = 1
	button_icon_state = "power_auspex"
	bloodsucker_check_flags = BP_CANT_USE_IN_TORPOR
	purchase_flags = TREMERE_CAN_BUY
	bloodcost = 10
	constant_bloodcost = 1
	cooldown_time = 12 SECONDS
	target_range = 2
	power_activates_immediately = FALSE
	prefire_message = "右键点击传送"

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/on_power_upgrade()
	// 1 + for default, the other + is for the upgrade that hasn't been added yet.
	if(level_current >= AUSPEX_ANYWHERE_LEVEL)
		target_range = 0
	else
		target_range = min(level_current + 2, 10)
	. = ..()

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/get_power_desc_extended()
	. = "借黑暗斗篷隐匿身形，点击地格即可传送"
	. = "每传送一格消耗[AUSPEX_BLOOD_COST_PER_TILE]血量。"
	if(target_range)
		. += "最远可传送[target_range]格。"
	else
		. += "可传送到任何看得见的地方。"
	if(level_current >= AUSPEX_BLEED_LEVEL)
		if(level_current >= AUSPEX_KNOCKDOWN_LEVEL)
			. += "这会使目的地的人流血并昏睡。"
		else
			. += "这会使目的地的人开始流血。"

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/get_power_explanation_extended()
	. = list()
	. += "启用后，你会隐匿于黑暗斗篷之中。"
	. += "[target_range ? "点击可传送至[target_range]格内看得见的位置" : "你可以传送到任何看得见的地方"]。"
	. += "传送会完全恢复你的耐力。"
	. += "达到[AUSPEX_BLEED_LEVEL]级后，会使目的地的人开始流血。"
	. += "达到[AUSPEX_KNOCKDOWN_LEVEL]级后，会将目的地的人击倒。"
	. += "达到[AUSPEX_ANYWHERE_LEVEL]级后，可以传送到任何地方，即使无法清楚看见该地格。"
	. += "每传送一格消耗[AUSPEX_BLOOD_COST_PER_TILE]血量。"

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/CheckValidTarget(atom/target_atom)
	. = ..()
	if(!.)
		return FALSE
	if(!isturf(target_atom))
		return FALSE
	var/turf/target_turf = target_atom
	if(target_turf.is_blocked_turf_ignore_climbable())
		return FALSE
	if(level_current < AUSPEX_ANYWHERE_LEVEL && !(target_turf in view(owner.client.view, owner.client)))
		owner.balloon_alert(owner, "不在视野内！")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/ActivatePower(trigger_flags)
	. = ..()
	owner.AddElement(/datum/element/digitalcamo)
	animate(owner, alpha = 15, time = 2 SECONDS)
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return FALSE
	animate(owner, alpha = 255, time = 2 SECONDS)
	owner.RemoveElement(/datum/element/digitalcamo)

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/FireSecondaryTargetedPower(atom/target, params)
	. = ..()
	var/mob/living/user = owner
	var/turf/targeted_turf = get_turf(target)
	auspex_blink(user, targeted_turf)

/datum/action/cooldown/bloodsucker/targeted/tremere/auspex/proc/auspex_blink(mob/living/user, turf/targeted_turf)
	var/blood_cost = AUSPEX_BLOOD_COST_PER_TILE * get_dist(user, targeted_turf)
	if(!can_pay_blood(blood_cost))
		owner.balloon_alert(owner, "血量不足！")
		return
	playsound(user, 'sound/effects/magic/summon_karp.ogg', 60)
	playsound(targeted_turf, 'sound/effects/magic/summon_karp.ogg', 60)

	new /obj/effect/particle_effect/fluid/smoke/vampsmoke(user.drop_location())
	new /obj/effect/particle_effect/fluid/smoke/vampsmoke(targeted_turf)

	for(var/mob/living/carbon/living_mob in range(1, targeted_turf)-user)
		if(IS_BLOODSUCKER(living_mob) || IS_GHOUL(living_mob))
			continue
		if(level_current >= AUSPEX_BLEED_LEVEL)
			var/obj/item/bodypart/bodypart = pick(living_mob.bodyparts)
			bodypart.force_wound_upwards(/datum/wound/slash/flesh/critical)
			living_mob.adjust_brute_loss(15)
		if(level_current >= AUSPEX_KNOCKDOWN_LEVEL)
			living_mob.Knockdown(10 SECONDS, ignore_canstun = TRUE)

	do_teleport(owner, targeted_turf, no_effects = TRUE, channel = TELEPORT_CHANNEL_QUANTUM)
	user.adjust_stamina_loss(-user.staminaloss)
	PowerActivatedSuccesfully(cost_override = blood_cost)

#undef AUSPEX_BLOOD_COST_PER_TILE
#undef AUSPEX_BLEED_LEVEL
#undef AUSPEX_KNOCKDOWN_LEVEL
#undef AUSPEX_ANYWHERE_LEVEL
