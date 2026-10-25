//does low brute damage, oxygen damage, and stamina damage and wets tiles when damaged
/datum/blobstrain/reagent/pressurized_slime
	name = "加压史莱姆"
	description = "会造成较低的钝击与缺氧伤害、较高的耐力伤害，并让目标脚下的地砖变得非常湿滑。"
	effectdesc = "还会让受攻击的变形菌附近的地砖变滑。"
	analyzerdescdamage = "造成较低的钝击与缺氧伤害、较高的耐力伤害，并使目标脚下的地砖变得非常湿滑，同时扑灭其身上的火焰。对钝击攻击有抗性。"
	analyzerdesceffect = "受到攻击或被杀死时，润滑附近的地砖，并扑灭其上的一切火焰。"
	color = "#AAAABB"
	complementary_color = "#BBBBAA"
	blobbernaut_message = "朝……喷出黏液"
	message = "变形菌溅了你一身"
	message_living = "，你大口喘着气"
	reagent = /datum/reagent/blob/pressurized_slime

/datum/blobstrain/reagent/pressurized_slime/damage_reaction(obj/structure/blob/B, damage, damage_type, damage_flag)
	if((damage_flag == MELEE || damage_flag == BULLET || damage_flag == LASER) || damage_type != BURN)
		extinguisharea(B, damage)
	if(damage_type == BRUTE)
		return damage * 0.5
	return ..()

/datum/blobstrain/reagent/pressurized_slime/death_reaction(obj/structure/blob/B, damage_flag)
	if(damage_flag == MELEE || damage_flag == BULLET || damage_flag == LASER)
		B.visible_message(span_boldwarning("变形菌破裂开来，向这一片区域喷洒出液体！"))
		extinguisharea(B, 50)

/datum/blobstrain/reagent/pressurized_slime/proc/extinguisharea(obj/structure/blob/B, probchance)
	for(var/turf/open/T in range(1, B))
		if(prob(probchance))
			T.MakeSlippery(TURF_WET_LUBE, min_wet_time = 10 SECONDS, wet_time_to_add = 5 SECONDS)
			for(var/obj/O in T)
				O.extinguish()
			for(var/mob/living/L in T)
				L.adjust_wet_stacks(2.5)
				L.extinguish_mob()

/datum/reagent/blob/pressurized_slime
	name = "加压史莱姆"
	taste_description = "一块海绵"
	color = "#AAAABB"

/datum/reagent/blob/pressurized_slime/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message, touch_protection, mob/eye/blob/overmind)
	. = ..()
	reac_volume = return_mob_expose_reac_volume(exposed_mob, methods, reac_volume, show_message, touch_protection, overmind)
	var/turf/open/location_turf = get_turf(exposed_mob)
	if(istype(location_turf) && prob(reac_volume))
		location_turf.MakeSlippery(TURF_WET_LUBE, min_wet_time = 10 SECONDS, wet_time_to_add = 5 SECONDS)
		exposed_mob.adjust_wet_stacks(reac_volume / 10)
	exposed_mob.apply_damage(0.4*reac_volume, BRUTE, wound_bonus=CANT_WOUND)
	if(exposed_mob)
		exposed_mob.adjust_stamina_loss(reac_volume, FALSE)
		exposed_mob.apply_damage(0.4 * reac_volume, OXY)
