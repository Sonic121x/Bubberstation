/datum/surgery_operation/basic/viral_bonding
	name = "病毒共生"
	rnd_name = "病毒整形术（病毒共生）"
	desc = "强行让病人与其感染的病毒建立共生关系。"
	rnd_desc = "一种强行让病毒与其宿主建立共生关系的手术。 \
		病人将完全免疫该病毒的影响，但会携带病毒并传染给他人。"
	implements = list(
		TOOL_CAUTERY = 1,
		TOOL_WELDER = 2,
		/obj/item = 3.33,
	)
	time = 10 SECONDS
	preop_sound = 'sound/items/handling/surgery/cautery1.ogg'
	success_sound = 'sound/items/handling/surgery/cautery2.ogg'
	operation_flags = OPERATION_MORBID | OPERATION_LOCKED | OPERATION_NOTABLE
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT
	var/list/required_chems = list(
		/datum/reagent/medicine/spaceacillin,
		/datum/reagent/consumable/virus_food,
		/datum/reagent/toxin/formaldehyde,
	)

/datum/surgery_operation/basic/viral_bonding/get_any_tool()
	return "任意热源"

/datum/surgery_operation/basic/viral_bonding/all_required_strings()
	. = ..()
	. += "病人必须感染了可供共生的病毒"
	for(var/datum/reagent/chem as anything in required_chems)
		. += "病人必须已摄入至少 1 单位 [chem::name]"

/datum/surgery_operation/basic/viral_bonding/get_default_radial_image()
	return image(/obj/item/clothing/mask/surgical)

/datum/surgery_operation/basic/viral_bonding/state_check(mob/living/patient)
	for(var/chem in required_chems)
		if(patient.reagents?.get_reagent_amount(chem) < 1)
			return FALSE
	for(var/datum/disease/infected_disease as anything in patient.diseases)
		if(infected_disease.severity != DISEASE_SEVERITY_UNCURABLE)
			return TRUE
	return FALSE

/datum/surgery_operation/basic/viral_bonding/tool_check(obj/item/tool)
	return tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST

/datum/surgery_operation/basic/viral_bonding/on_preop(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		patient,
		span_notice("你开始用 [tool] 加热 [patient] 的骨髓……"),
		span_notice("[surgeon] 开始用 [tool] 加热 [patient] 的骨髓……"),
		span_notice("[surgeon] 开始用 [tool] 加热 [patient] 胸腔里的什么东西……"),
	)
	display_pain(patient, "你感觉一股灼热在胸腔里蔓延开来！")

/datum/surgery_operation/basic/viral_bonding/on_success(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		patient,
		span_notice("[patient] 的骨髓开始缓慢搏动。病毒共生完成了。"),
		span_notice("[patient] 的骨髓开始缓慢搏动。"),
		span_notice("[surgeon] 完成了手术。"),
	)
	display_pain(patient, "你感觉胸口传来微弱的搏动。")
	for(var/datum/disease/infected_disease as anything in patient.diseases)
		if(infected_disease.severity != DISEASE_SEVERITY_UNCURABLE) //no curing quirks, sweaty
			infected_disease.carrier = TRUE
	return TRUE
