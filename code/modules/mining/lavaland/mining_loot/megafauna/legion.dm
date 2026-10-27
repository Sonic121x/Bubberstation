// Staff of storms

/obj/item/storm_staff
	name = "风暴之杖"
	desc = "从军团的残骸中取得的古老法杖。当你挥动它时，风也随之搅动。"
	icon_state = "staffofstorms"
	inhand_icon_state = "staffofstorms"
	icon_angle = -45
	icon = 'icons/obj/weapons/guns/magic.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	force = 20
	damtype = BURN
	hitsound = 'sound/items/weapons/taserhit.ogg'
	wound_bonus = -30
	exposed_wound_bonus = 20
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/max_thunder_charges = 3
	var/thunder_charges = 3
	var/thunder_charge_time = 15 SECONDS
	var/static/list/excluded_areas = list(/area/space)
	var/list/targeted_turfs = list()

/obj/item/storm_staff/examine(mob/user)
	. = ..()
	. += span_notice("它还剩 [thunder_charges] 次充能。")
	. += span_notice("在手中使用可驱散风暴。")
	. += span_notice("对目标使用可从天空召唤雷霆。")
	. += span_notice("在带有天气效果的区域中，雷霆会被强化。")

/obj/item/storm_staff/attack_self(mob/user)
	var/area/user_area = get_area(user)
	var/turf/user_turf = get_turf(user)
	if(!user_area || !user_turf || (is_type_in_list(user_area, excluded_areas)))
		to_chat(user, span_warning("有某种东西阻止你在此处使用这根法杖。"))
		return
	var/datum/weather/affected_weather
	for(var/datum/weather/weather as anything in SSweather.processing)
		if((user_turf.z in weather.impacted_z_levels) && ispath(user_area.type, weather.area_type))
			affected_weather = weather
			break
	if(!affected_weather)
		return
	if(affected_weather.stage == END_STAGE)
		balloon_alert(user, "已经结束了！")
		return
	if(affected_weather.stage == WIND_DOWN_STAGE)
		balloon_alert(user, "正在结束中！")
		return
	balloon_alert(user, "你举起了法杖……")
	if(!do_after(user, 3 SECONDS, target = src))
		balloon_alert(user, "被打断了！")
		return
	user.visible_message(span_warning("[user] 将 [src] 举向天空，一道橙色光束直冲云霄！"), \
	span_notice("你高举 [src] 指向天空，驱散了风暴！"))
	playsound(user, 'sound/effects/magic/staff_change.ogg', 200, FALSE)
	var/old_color = user.color
	user.color = list(340/255, 240/255, 0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0)
	var/old_transform = user.transform
	user.transform *= 1.2
	animate(user, color = old_color, transform = old_transform, time = 1 SECONDS)
	affected_weather.wind_down()
	user.log_message("在 [AREACOORD(user_turf)] 驱散了一场风暴。", LOG_GAME)

/obj/item/storm_staff/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	return thunder_blast(interacting_with, user) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING

/obj/item/storm_staff/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	thunder_blast(target, user)

/obj/item/storm_staff/proc/thunder_blast(atom/target, mob/user)
	if(!thunder_charges)
		balloon_alert(user, "需要充能！")
		return FALSE
	var/turf/target_turf = get_turf(target)
	var/area/target_area = get_area(target)
	if(!target_turf || !target_area || (is_type_in_list(target_area, excluded_areas)))
		balloon_alert(user, "无法在此处落雷！")
		return FALSE
	if(target_turf in targeted_turfs)
		balloon_alert(user, "已经瞄准过了！")
		return FALSE
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		balloon_alert(user, "你不想伤害任何东西！")
		return FALSE
	var/power_boosted = FALSE
	for(var/datum/weather/weather as anything in SSweather.processing)
		if(weather.stage != MAIN_STAGE)
			continue
		if((target_turf.z in weather.impacted_z_levels) && ispath(target_area.type, weather.area_type))
			power_boosted = TRUE
			break
	playsound(src, 'sound/effects/magic/lightningshock.ogg', 10, TRUE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	targeted_turfs += target_turf
	balloon_alert(user, "你瞄准了 [target_turf]……")
	new /obj/effect/temp_visual/telegraphing/circle(target_turf)
	addtimer(CALLBACK(src, PROC_REF(throw_thunderbolt), target_turf, power_boosted), 1.5 SECONDS)
	thunder_charges--
	addtimer(CALLBACK(src, PROC_REF(recharge)), thunder_charge_time)
	user.log_message("向 [AREACOORD(target_turf)] 发射了风暴之杖。", LOG_ATTACK)
	return TRUE

/obj/item/storm_staff/proc/recharge(mob/user)
	thunder_charges = min(thunder_charges + 1, max_thunder_charges)
	playsound(src, 'sound/effects/magic/charge.ogg', 10, TRUE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)

/obj/item/storm_staff/proc/throw_thunderbolt(turf/target, boosted)
	targeted_turfs -= target
	new /obj/effect/temp_visual/thunderbolt(target)
	var/list/affected_turfs = list(target)
	if(boosted)
		for(var/direction in GLOB.alldirs)
			var/turf_to_add = get_step(target, direction)
			if(!turf_to_add)
				continue
			affected_turfs += turf_to_add
	for(var/turf/turf as anything in affected_turfs)
		new /obj/effect/temp_visual/electricity(turf)
		for(var/mob/living/hit_mob in turf)
			to_chat(hit_mob, span_userdanger("你被闪电击中了！"))
			hit_mob.electrocute_act(15 * (isanimal_or_basicmob(hit_mob) ? 3 : 1) * (turf == target ? 2 : 1) * (boosted ? 2 : 1), src, flags = SHOCK_TESLA|SHOCK_NOSTUN)

		for(var/obj/hit_thing in turf)
			hit_thing.take_damage(20, BURN, ENERGY, FALSE)
	playsound(target, 'sound/effects/magic/lightningbolt.ogg', 100, TRUE)
	target.visible_message(span_danger("一道雷霆击中了 [target]！"))
	explosion(target, light_impact_range = (boosted ? 1 : 0), flame_range = (boosted ? 2 : 1), silent = TRUE)
