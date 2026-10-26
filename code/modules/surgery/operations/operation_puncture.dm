/datum/surgery_operation/limb/repair_puncture
	name = "复位血管"
	desc = "将病人撕裂的血管复位，为封合做准备。"
	implements = list(
		TOOL_HEMOSTAT = 1,
		TOOL_SCALPEL = 1.15,
		TOOL_WIRECUTTER = 2.5,
	)
	time = 3 SECONDS
	preop_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT

/datum/surgery_operation/limb/repair_puncture/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/pierce/bleed/pierce_wound in limb.wounds)
		if(HAS_TRAIT(pierce_wound, TRAIT_WOUND_SCANNED))
			. *= 0.5

/datum/surgery_operation/limb/repair_puncture/get_default_radial_image()
	return image(/obj/item/hemostat)

/datum/surgery_operation/limb/repair_puncture/all_required_strings()
	return list("该肢体必须有未经处理的穿刺伤") + ..()

/datum/surgery_operation/limb/repair_puncture/state_check(obj/item/bodypart/limb)
	var/datum/wound/pierce/bleed/pierce_wound = locate() in limb.wounds
	if(isnull(pierce_wound) || pierce_wound.blood_flow <= 0 || pierce_wound.mend_state)
		return FALSE
	return TRUE

/datum/surgery_operation/limb/repair_puncture/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始复位 [FORMAT_LIMB_OWNER(limb)] 中撕裂的血管……"),
		span_notice("[surgeon] 开始用 [tool] 复位 [FORMAT_LIMB_OWNER(limb)] 中撕裂的血管。"),
		span_notice("[surgeon] 开始复位 [FORMAT_LIMB_OWNER(limb)] 中撕裂的血管。"),
	)
	display_pain(limb.owner, "你感觉[chinese_body_zone_display(limb.plaintext_zone)]传来一阵可怕的刺痛！")

/datum/surgery_operation/limb/repair_puncture/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/datum/wound/pierce/bleed/pierce_wound = locate() in limb.wounds
	pierce_wound?.adjust_blood_flow(-0.25)
	limb.receive_damage(3, wound_bonus = CANT_WOUND, sharpness = tool.get_sharpness(), damage_source = tool)

	if(QDELETED(pierce_wound))
		display_results(
			surgeon,
			limb.owner,
			span_notice("你成功复位了 [FORMAT_LIMB_OWNER(limb)] 中最后撕裂的血管。"),
			span_notice("[surgeon] 成功用 [tool] 复位了 [FORMAT_LIMB_OWNER(limb)] 中最后撕裂的血管！"),
			span_notice("[surgeon] 成功复位了 [FORMAT_LIMB_OWNER(limb)] 中最后撕裂的血管！"),
		)
		return

	pierce_wound?.mend_state = TRUE
	display_results(
		surgeon,
		limb.owner,
		span_notice("你成功复位了 [FORMAT_LIMB_OWNER(limb)] 中的部分血管。"),
		span_notice("[surgeon] 成功用 [tool] 复位了 [FORMAT_LIMB_OWNER(limb)] 中的部分血管！"),
		span_notice("[surgeon] 成功复位了 [FORMAT_LIMB_OWNER(limb)] 中的部分血管！"),
	)

/datum/surgery_operation/limb/repair_puncture/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你扯开了 [FORMAT_LIMB_OWNER(limb)] 中的部分血管。"),
		span_notice("[surgeon] 用 [tool] 扯开了 [FORMAT_LIMB_OWNER(limb)] 中的部分血管！"),
		span_notice("[surgeon] 扯开了 [FORMAT_LIMB_OWNER(limb)] 中的部分血管。"),
	)
	limb.receive_damage(rand(4, 8), wound_bonus = 10, sharpness = SHARP_EDGED, damage_source = tool)

/datum/surgery_operation/limb/seal_veins
	name = "封合血管"
	// rnd_name = "Anastomosis (Seal Blood Vessels)" // doctor says this is the term to use but it fits awkwardly
	desc = "封合病人已复位的血管。"
	implements = list(
		TOOL_CAUTERY = 1,
		/obj/item/gun/energy/laser = 1.12,
		TOOL_WELDER = 1.5,
		/obj/item = 3.33,
	)
	time = 3.2 SECONDS
	preop_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT

/datum/surgery_operation/limb/seal_veins/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/pierce/bleed/pierce_wound in limb.wounds)
		if(HAS_TRAIT(pierce_wound, TRAIT_WOUND_SCANNED))
			. *= 0.5

/datum/surgery_operation/limb/seal_veins/get_default_radial_image()
	return image(/obj/item/cautery)

/datum/surgery_operation/limb/seal_veins/get_any_tool()
	return "任意热源"

/datum/surgery_operation/limb/seal_veins/all_required_strings()
	return list("该肢体必须有经过处理的穿刺伤") + ..()

/datum/surgery_operation/limb/seal_veins/tool_check(obj/item/tool)
	if(istype(tool, /obj/item/gun/energy/laser))
		var/obj/item/gun/energy/laser/lasergun = tool
		return lasergun.cell?.charge > 0

	return tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST

/datum/surgery_operation/limb/seal_veins/state_check(obj/item/bodypart/limb)
	var/datum/wound/pierce/bleed/pierce_wound = locate() in limb.wounds
	if(isnull(pierce_wound) || pierce_wound.blood_flow <= 0 || !pierce_wound.mend_state)
		return FALSE
	return TRUE

/datum/surgery_operation/limb/seal_veins/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始封合 [FORMAT_LIMB_OWNER(limb)] 中已复位的血管……"),
		span_notice("[surgeon] 开始用 [tool] 封合 [FORMAT_LIMB_OWNER(limb)] 中已复位的血管。"),
		span_notice("[surgeon] 开始封合 [FORMAT_LIMB_OWNER(limb)] 中已复位的血管。"),
	)
	display_pain(limb.owner, "你感觉[chinese_body_zone_display(limb.plaintext_zone)]传来一阵灼烧感！")

/datum/surgery_operation/limb/seal_veins/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/datum/wound/pierce/bleed/pierce_wound = locate() in limb.wounds
	pierce_wound?.adjust_blood_flow(-0.5)

	if(QDELETED(pierce_wound))
		display_results(
			surgeon,
			limb.owner,
			span_notice("你成功封合了 [FORMAT_LIMB_OWNER(limb)] 中最后破裂的血管。"),
			span_notice("[surgeon] 成功用 [tool] 封合了 [FORMAT_LIMB_OWNER(limb)] 中最后破裂的血管！"),
			span_notice("[surgeon] 成功封合了 [FORMAT_LIMB_OWNER(limb)] 中最后破裂的血管！"),
		)
		return

	pierce_wound?.mend_state = FALSE
	display_results(
		surgeon,
		limb.owner,
		span_notice("你成功封合了 [FORMAT_LIMB_OWNER(limb)] 中的部分血管。"),
		span_notice("[surgeon] 成功用 [tool] 封合了 [FORMAT_LIMB_OWNER(limb)] 中的部分血管！"),
		span_notice("[surgeon] 成功封合了 [FORMAT_LIMB_OWNER(limb)] 中的部分血管！"),
	)
