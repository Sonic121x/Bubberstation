/datum/reagent/mkultra
	name = "MKUltra"
	description = "一种丝绒般醇厚的物质，一旦摄入，会增强其创造者声音对那些受其影响者的吸引力。"
	color = "#660015"
	taste_description = "合成巧克力、淡淡酒香和鲜明的玫瑰香"
	metabolization_rate = REAGENTS_METABOLISM * 0.4
	overdose_threshold = 50
	ph = 10
	data = list("enchanter" = null)

/datum/reagent/mkultra/on_new(data)
	. = ..()
	var/ckey = holder.my_atom?.fingerprintslast
	var/mob/living/enchanter = get_mob_by_ckey(ckey)
	if(!istype(enchanter) && isnull(ckey))
		return

	if(istype(/obj/machinery/plumbing, holder.my_atom)) // No automation
		return

	if(isnull(src.data["enchanter"]))
		src.data["enchanter"] = enchanter

/datum/reagent/mkultra/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(purity < 0.5 || isnull(data["enchanter"]))
		metabolization_rate = 1
		return

	if(affected_mob != data["enchanter"])
		var/datum/status_effect/mkultra/status = affected_mob.has_status_effect(/datum/status_effect/mkultra)
		if(!status)
			affected_mob.apply_status_effect(/datum/status_effect/mkultra, data["enchanter"])
		var/progress = (1 * seconds_per_tick)
		if(status?.progress < 400)
			status?.progress += progress

/datum/reagent/mkultra/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 1 * seconds_per_tick, required_organ_flag = affected_organ_flags)

/obj/item/reagent_containers/cup/beaker/mkultra_debug
	list_reagents = list(/datum/reagent/consumable/coco = 10, /datum/reagent/silver = 10, /datum/reagent/toxin/mindbreaker = 10, /datum/reagent/medicine/psicodine = 10, /datum/reagent/drug/happiness = 10)
	volume = 100
