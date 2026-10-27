#define GOHOME_START 0
#define GOHOME_FLICKER_ONE 2
#define GOHOME_FLICKER_TWO 4
#define GOHOME_TELEPORT 6

/**
 * Given to Bloodsuckers near Sol if they have a Coffin claimed.
 * Teleports them to their Coffin after a delay.
 * Makes them drop everything if someone witnesses the act.
 */
/datum/action/cooldown/bloodsucker/gohome
	name = "消失戏法"
	desc = "黎明将至时，化作迷雾直接返回避难所。<br><b>警告：</b>若被凡人看见，你会丢下<b>全部</b>随身物品。"
	button_icon_state = "power_gohome"
	active_background_icon_state = "vamp_power_off_oneshot"
	base_background_icon_state = "vamp_power_off_oneshot"
	power_flags = BP_CONTINUOUS_EFFECT|BP_AM_SINGLEUSE|BP_AM_STATIC_COOLDOWN
	bloodsucker_check_flags = BP_CANT_USE_IN_FRENZY
	check_flags = NONE
	purchase_flags = NONE
	bloodcost = 100
	cooldown_time = 10 SECONDS
	power_activates_immediately = FALSE
	level_current = -1

	///What stage of the teleportation are we in
	var/teleporting_stage = GOHOME_START
	///The types of mobs that will drop post-teleportation.
	var/static/list/spawning_mobs = list(
		/mob/living/basic/mouse = 3,
		/mob/living/basic/bat = 1,
	)

/datum/action/cooldown/bloodsucker/gohome/get_power_explanation_extended()
	. = list()
	. += "消失戏法会在短暂延迟后，将使用者传送至其认领的棺材。"
	. += "若被凡人看见，使用者会丢下全部物品。"
	. += "若认领的棺材被摧毁，能力将被取消。"
	. += "启用后，使用者周围的灯光会立刻开始闪烁。"
	. += "使用者传送回棺材后，原地会留下一只老鼠或蝙蝠。"

/datum/action/cooldown/bloodsucker/gohome/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	/// Have No Haven (NOTE: You only got this power if you had a haven, so this means it's destroyed)
	if(!istype(bloodsuckerdatum_power) || !bloodsuckerdatum_power.coffin)
		owner.balloon_alert(owner, "棺材已被摧毁！")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/gohome/ActivatePower(atom/target)
	owner.balloon_alert(owner, "正在准备传送……")
	return TRUE

/datum/action/cooldown/bloodsucker/gohome/DeactivatePower(deactivate_flags)
	if(active && teleporting_stage != GOHOME_TELEPORT)
		owner.balloon_alert(owner, "传送已取消")
		teleporting_stage = GOHOME_START
		return . = ..(DEACTIVATE_POWER_DO_NOT_REMOVE)
	. = ..()

/datum/action/cooldown/bloodsucker/gohome/process(seconds_per_tick)
	. = ..()
	if(!.)
		return FALSE

	switch(teleporting_stage)
		if(GOHOME_START)
			INVOKE_ASYNC(src, PROC_REF(flicker_lights), 3, 20)
		if(GOHOME_FLICKER_ONE)
			INVOKE_ASYNC(src, PROC_REF(flicker_lights), 4, 40)
		if(GOHOME_FLICKER_TWO)
			INVOKE_ASYNC(src, PROC_REF(flicker_lights), 4, 60)
		if(GOHOME_TELEPORT)
			INVOKE_ASYNC(src, PROC_REF(teleport_to_coffin), owner)
	teleporting_stage++

/datum/action/cooldown/bloodsucker/gohome/ContinueActive(mob/living/user, mob/living/target)
	. = ..()
	if(!.)
		return FALSE
	if(!isturf(owner.loc))
		return FALSE
	if(!bloodsuckerdatum_power.coffin)
		user.balloon_alert(user, "棺材已被摧毁！")
		to_chat(owner, span_warning("你的棺材已被摧毁！你已无处可归。"))
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/gohome/proc/flicker_lights(flicker_range, beat_volume)
	for(var/obj/machinery/light/nearby_lights in view(flicker_range, get_turf(owner)))
		nearby_lights.flicker(5)
	playsound(get_turf(owner), 'sound/effects/singlebeat.ogg', beat_volume, 1)

/datum/action/cooldown/bloodsucker/gohome/proc/teleport_to_coffin(mob/living/carbon/user)
	var/drop_item = FALSE
	var/turf/current_turf = get_turf(user)
	// If we aren't in the dark, anyone watching us will cause us to drop out stuff
	if(current_turf && current_turf.lighting_object && current_turf.get_lumcount() >= 0.2)
		for(var/mob/living/watchers in viewers(world.view, get_turf(user)) - user)
			if(QDELETED(watchers.client) || IS_UNCONSCIOUS(watchers))
				continue
			if(watchers.has_unlimited_silicon_privilege)
				continue
			if(watchers.is_blind())
				continue
			if(!IS_BLOODSUCKER(watchers) && !IS_GHOUL(watchers))
				drop_item = TRUE
				break
	// Drop all necessary items (handcuffs, legcuffs, items if seen)
	user.uncuff()
	if(drop_item)
		for(var/obj/item/literally_everything in owner)
			owner.dropItemToGround(literally_everything)

	playsound(current_turf, 'sound/effects/magic/summon_karp.ogg', 60, 1)

	do_smoke(3, FALSE, current_turf, smoke_type = /obj/effect/particle_effect/fluid/smoke/vampsmoke)

	/// STEP FIVE: Create animal at prev location
	var/mob/living/simple_animal/new_mob = pick_weight(spawning_mobs)
	new new_mob(current_turf)
	/// TELEPORT: Move to Coffin & Close it!
	user.set_resting(TRUE, TRUE, FALSE)
	do_teleport(user, bloodsuckerdatum_power.coffin, no_effects = TRUE, forced = TRUE, channel = TELEPORT_CHANNEL_QUANTUM)
	bloodsuckerdatum_power.coffin.force_enter(user)

	DeactivatePower()
	pay_cost()

#undef GOHOME_START
#undef GOHOME_FLICKER_ONE
#undef GOHOME_FLICKER_TWO
#undef GOHOME_TELEPORT
