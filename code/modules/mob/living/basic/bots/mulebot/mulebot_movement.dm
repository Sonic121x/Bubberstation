/mob/living/basic/bot/mulebot/MobBump(mob/bumped_mob) // called when the bot bumps into a mob
	if(mind || !isliving(bumped_mob)) //if there's a sentience controlling the bot, they aren't allowed to harm folks.
		return ..()
	var/mob/living/bumped_living = bumped_mob
	if(wires.is_cut(WIRE_AVOIDANCE)) // usually just bumps, but if the avoidance wire is cut, knocks them over.
		if(iscyborg(bumped_living))
			visible_message(span_danger("[src] 撞上了 [bumped_living]！"))
		else if(bumped_living.Knockdown(8 SECONDS))
			log_combat(src, bumped_living, "撞倒了")
			visible_message(span_danger("[src] 撞倒了 [bumped_living]！"))
	return ..()

/mob/living/basic/bot/mulebot/on_bot_movement(atom/movable/source, atom/oldloc, dir, forced)
	cell?.use(cell_move_power_usage)
	set_cell_hud()

	if(isnull(buckled) && isnull(pulledby) && isnull(throwing) && has_gravity())
		for(var/mob/living/carbon/human/future_pancake in loc)
			if(future_pancake.body_position == LYING_DOWN)
				run_over(future_pancake)

	return ..()

///Checks if the bot is on or if it has charge
/mob/living/basic/bot/mulebot/proc/on_pre_move()
	SIGNAL_HANDLER

	if(!(bot_mode_flags & BOT_MODE_ON))
		return COMPONENT_MOB_BOT_BLOCK_PRE_STEP

	if((cell && (cell.charge < cell_move_power_usage)) || !has_power())
		turn_off()
		return COMPONENT_MOB_BOT_BLOCK_PRE_STEP

// when mulebot is in the same loc
/mob/living/basic/bot/mulebot/proc/run_over(mob/living/carbon/human/crushed)
	if (!(bot_access_flags & BOT_COVER_EMAGGED) && !wires.is_cut(WIRE_AVOIDANCE))
		if (!has_status_effect(/datum/status_effect/careful_driving))
			crushed.visible_message(span_notice("[src] 放慢速度，以免碾到 [crushed]。"))
		apply_status_effect(/datum/status_effect/careful_driving)
		return // Player mules must be emagged before they can trample

	log_combat(src, crushed, "碾过", addition = "（伤害类型：[uppertext(BRUTE)]）")
	crushed.visible_message(
		span_danger("[src] 从 [crushed] 身上碾了过去！"),
		span_userdanger("[src] 从你身上碾了过去！"),
	)

	playsound(src, 'sound/effects/splat.ogg', 50, TRUE)

	var/damage = rand(5, 15)
	var/static/list/zone_damages = list(
		BODY_ZONE_HEAD = 2,
		BODY_ZONE_CHEST = 2,
		BODY_ZONE_L_LEG = 0.5,
		BODY_ZONE_R_LEG = 0.5,
		BODY_ZONE_L_ARM = 0.5,
		BODY_ZONE_R_ARM = 0.5,
	)
	for(var/body_zone in zone_damages)
		crushed.apply_damage(zone_damages[body_zone] * damage, BRUTE, body_zone, run_armor_check(body_zone, MELEE))

	add_mob_blood(crushed)

	var/turf/below_us = get_turf(src)
	below_us.add_mob_blood(crushed)

	AddComponent(/datum/component/blood_walk, \
		blood_type = /obj/effect/decal/cleanable/blood/tracks, \
		target_dir_change = TRUE, \
		transfer_blood_dna = TRUE, \
		max_blood = 4)
