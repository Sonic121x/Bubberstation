/datum/reagent/fuel
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/fuel/oil
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/stable_plasma
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/pax
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/water
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/hellwater
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/carbondioxide
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/iron
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/blood
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING // For Hemophages to be able to drink it without any issue.

/datum/reagent/stable_plasma/on_mob_life(mob/living/carbon/C)
	if(C.mob_biotypes & MOB_ROBOTIC)
		C.nutrition = min(C.nutrition + 5, NUTRITION_LEVEL_FULL-1)
	..()

/datum/reagent/fuel/on_mob_life(mob/living/carbon/C)
	if(C.mob_biotypes & MOB_ROBOTIC)
		C.nutrition = min(C.nutrition + 5, NUTRITION_LEVEL_FULL-1)
	..()

/datum/reagent/fuel/oil/on_mob_life(mob/living/carbon/C)
	if(C.mob_biotypes & MOB_ROBOTIC && C.blood_volume < BLOOD_VOLUME_NORMAL)
		C.blood_volume += 0.5
	..()

/datum/reagent/carbondioxide/on_mob_life(mob/living/carbon/C)
	if(C.mob_biotypes & MOB_ROBOTIC)
		C.nutrition = min(C.nutrition + 5, NUTRITION_LEVEL_FULL-1)
	..()
// Catnip
/datum/reagent/pax/catnip
	name = "猫薄荷"
	taste_description = "草"
	description = "一种无色液体，能让人更加平和，让猫科动物更加愉快。"
	metabolization_rate = 1.75 * REAGENTS_METABOLISM

/datum/reagent/pax/catnip/on_mob_life(mob/living/carbon/M)
	if(isfeline(M))
		if(prob(20))
			M.emote("nya")
		if(prob(20))
			to_chat(M, span_notice("[pick("被摸头的感觉真好。", "要是有人给揉背就好了。", "喵")]"))
	else
		to_chat(M, span_notice("[pick("我感到莫名的平静。", "我感到很放松。", "喵？")]"))
	..()

#define DERMAGEN_SCAR_FIX_AMOUNT 10

/datum/reagent/medicine/dermagen
	name = "真皮再生剂"
	description = "涂抹后可治愈过去外伤留下的疤痕。至少需要 10 单位，仅限外敷生效。"
	color = "#FFEBEB"
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/medicine/dermagen/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE)
	. = ..()
	if(!iscarbon(exposed_mob))
		return
	if(!(methods & (PATCH|TOUCH|VAPOR)))
		return
	var/mob/living/carbon/scarred = exposed_mob
	if(scarred.stat == DEAD)
		show_message = FALSE
	if(show_message)
		to_chat(scarred, span_danger("你身上的疤痕开始淡化、消失。"))
	if(reac_volume >= DERMAGEN_SCAR_FIX_AMOUNT)
		for(var/i in scarred.all_scars)
			qdel(i)

#undef DERMAGEN_SCAR_FIX_AMOUNT
