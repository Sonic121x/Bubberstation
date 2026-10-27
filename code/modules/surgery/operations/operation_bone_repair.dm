// Surgical analog to manual dislocation treatment
/datum/surgery_operation/limb/repair_dislocation
	name = "复位脱位"
	desc = "复位病人肢体中脱位的骨头。 \
		与野外应急处理类似，但在受控环境下施行，因此更快也更安全。"
	operation_flags = OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED | OPERATION_AFFECTS_MOOD | OPERATION_STANDING_ALLOWED | OPERATION_IGNORE_CLOTHES
	implements = list(
		TOOL_BONESET = 1,
		TOOL_CROWBAR = 2,
		IMPLEMENT_HAND = 5,
	)
	time = 2.4 SECONDS

/datum/surgery_operation/limb/repair_dislocation/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/blunt/bone/bone_wound in limb.wounds)
		if(HAS_TRAIT(bone_wound, TRAIT_WOUND_SCANNED) && (TOOL_BONESET in bone_wound.treatable_tools))
			. *= 0.5

/datum/surgery_operation/limb/repair_dislocation/get_default_radial_image()
	return image(/obj/item/bonesetter)

/datum/surgery_operation/limb/repair_dislocation/all_required_strings()
	return list("肢体必须处于脱位状态") + ..()

/datum/surgery_operation/limb/repair_dislocation/state_check(obj/item/bodypart/limb)
	for(var/datum/wound/blunt/bone/bone_wound in limb.wounds)
		if(TOOL_BONESET in bone_wound.treatable_tools)
			return TRUE

	return FALSE

/datum/surgery_operation/limb/repair_dislocation/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始复位[FORMAT_LIMB_OWNER(limb)]的脱位……"),
		span_notice("[surgeon] 开始用 [tool] 复位[FORMAT_LIMB_OWNER(limb)]的脱位。"),
		span_notice("[surgeon] 开始复位[FORMAT_LIMB_OWNER(limb)]的脱位。"),
	)
	display_pain(limb.owner, "你的[chinese_body_zone_display(limb.plaintext_zone)]隐隐作痛！")

/datum/surgery_operation/limb/repair_dislocation/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	for(var/datum/wound/blunt/bone/bone_wound in limb.wounds)
		if(TOOL_BONESET in bone_wound.treatable_tools)
			qdel(bone_wound)

	display_results(
		surgeon,
		limb.owner,
		span_notice("你成功复位了[FORMAT_LIMB_OWNER(limb)]的脱位。"),
		span_notice("[surgeon] 成功复位了[FORMAT_LIMB_OWNER(limb)]的脱位！"),
		span_notice("[surgeon] 成功复位了[FORMAT_LIMB_OWNER(limb)]的脱位！"),
	)
	display_pain(limb.owner, "你的[chinese_body_zone_display(limb.plaintext_zone)]现在舒服多了！")

/datum/surgery_operation/limb/repair_dislocation/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你没能复位[FORMAT_LIMB_OWNER(limb)]的脱位，还造成了更多损伤！"),
		span_notice("[surgeon] 没能复位[FORMAT_LIMB_OWNER(limb)]的脱位，还造成了更多损伤！"),
		span_notice("[surgeon] 没能复位[FORMAT_LIMB_OWNER(limb)]的脱位！"),
	)
	display_pain(limb.owner, "你[chinese_body_zone_display(limb.plaintext_zone)]的疼痛加剧了！")
	limb.receive_damage(25, damage_source = tool)

/datum/surgery_operation/limb/repair_hairline
	name = "修复骨裂"
	desc = "修补病人骨骼上的骨裂。"
	operation_flags = OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		TOOL_BONESET = 1,
		/obj/item/stack/medical/bone_gel = 1,
		/obj/item/stack/medical/wrap/sticky_tape/surgical = 1,
		/obj/item/stack/medical/wrap/sticky_tape/super = 2,
		/obj/item/stack/medical/wrap/sticky_tape = 3.33,
	)
	time = 4 SECONDS
	any_surgery_states_required = ALL_SURGERY_SKIN_STATES

/datum/surgery_operation/limb/repair_hairline/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/blunt/bone/critical/bone_wound in limb.wounds)
		if(HAS_TRAIT(bone_wound, TRAIT_WOUND_SCANNED))
			. *= 0.5

/datum/surgery_operation/limb/repair_hairline/get_default_radial_image()
	return image(/obj/item/bonesetter)

/datum/surgery_operation/limb/repair_hairline/all_required_strings()
	return list("肢体必须有骨裂") + ..()

/datum/surgery_operation/limb/repair_hairline/state_check(obj/item/bodypart/limb)
	if(!(locate(/datum/wound/blunt/bone/severe) in limb.wounds))
		return FALSE
	return TRUE

/datum/surgery_operation/limb/repair_hairline/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始修复[FORMAT_LIMB_OWNER(limb)]的骨折……"),
		span_notice("[surgeon] 开始用 [tool] 修复[FORMAT_LIMB_OWNER(limb)]的骨折。"),
		span_notice("[surgeon] 开始修复[FORMAT_LIMB_OWNER(limb)]的骨折。"),
	)
	display_pain(limb.owner, "你的[chinese_body_zone_display(limb.plaintext_zone)]隐隐作痛！")

/datum/surgery_operation/limb/repair_hairline/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/datum/wound/blunt/bone/fracture = locate() in limb.wounds
	qdel(fracture)

	display_results(
		surgeon,
		limb.owner,
		span_notice("你成功修复了[FORMAT_LIMB_OWNER(limb)]的骨折。"),
		span_notice("[surgeon] 成功修复了[FORMAT_LIMB_OWNER(limb)]的骨折！"),
		span_notice("[surgeon] 成功修复了[FORMAT_LIMB_OWNER(limb)]的骨折！"),
	)

/datum/surgery_operation/limb/reset_compound
	name = "复位开放性骨折"
	desc = "复位病人骨骼上的开放性骨折，为正常愈合做好准备。"
	operation_flags = OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		TOOL_BONESET = 1,
		/obj/item/stack/medical/wrap/sticky_tape/surgical = 1.66,
		/obj/item/stack/medical/wrap/sticky_tape/super = 2.5,
		/obj/item/stack/medical/wrap/sticky_tape = 5,
	)
	time = 6 SECONDS
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/limb/reset_compound/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/blunt/bone/severe/bone_wound in limb.wounds)
		if(HAS_TRAIT(bone_wound, TRAIT_WOUND_SCANNED))
			. *= 0.5

/datum/surgery_operation/limb/reset_compound/get_default_radial_image()
	return image(/obj/item/bonesetter)

/datum/surgery_operation/limb/reset_compound/all_required_strings()
	return list("肢体必须有开放性骨折") + ..()

/datum/surgery_operation/limb/reset_compound/state_check(obj/item/bodypart/limb)
	var/datum/wound/blunt/bone/critical/fracture = locate() in limb.wounds
	if(isnull(fracture) || fracture.reset)
		return FALSE
	return TRUE

/datum/surgery_operation/limb/reset_compound/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始复位[FORMAT_LIMB_OWNER(limb)]的骨头……"),
		span_notice("[surgeon] 开始用 [tool] 复位[FORMAT_LIMB_OWNER(limb)]的骨头。"),
		span_notice("[surgeon] 开始复位[FORMAT_LIMB_OWNER(limb)]的骨头。"),
	)
	display_pain(limb.owner, "你[chinese_body_zone_display(limb.plaintext_zone)]的酸痛难以忍受！")

/datum/surgery_operation/limb/reset_compound/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/datum/wound/blunt/bone/critical/fracture = locate() in limb.wounds
	fracture?.reset = TRUE

	display_results(
		surgeon,
		limb.owner,
		span_notice("你成功复位了[FORMAT_LIMB_OWNER(limb)]的骨头。"),
		span_notice("[surgeon] 成功用 [tool] 复位了[FORMAT_LIMB_OWNER(limb)]的骨头！"),
		span_notice("[surgeon] 成功复位了[FORMAT_LIMB_OWNER(limb)]的骨头！"),
	)

/datum/surgery_operation/limb/repair_compound
	name = "修复开放性骨折"
	desc = "修补病人骨骼上的开放性骨折。"
	operation_flags = OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		/obj/item/stack/medical/bone_gel = 1,
		/obj/item/stack/medical/wrap/sticky_tape/surgical = 1,
		/obj/item/stack/medical/wrap/sticky_tape/super = 2,
		/obj/item/stack/medical/wrap/sticky_tape = 3.33,
	)
	time = 4 SECONDS
	any_surgery_states_required = ALL_SURGERY_SKIN_STATES

/datum/surgery_operation/limb/repair_compound/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/blunt/bone/critical/bone_wound in limb.wounds)
		if(HAS_TRAIT(bone_wound, TRAIT_WOUND_SCANNED))
			. *= 0.5

/datum/surgery_operation/limb/repair_compound/get_default_radial_image()
	return image(/obj/item/stack/medical/bone_gel)

/datum/surgery_operation/limb/repair_compound/all_required_strings()
	return list("肢体的开放性骨折已复位") + ..()

/datum/surgery_operation/limb/repair_compound/state_check(obj/item/bodypart/limb)
	var/datum/wound/blunt/bone/critical/fracture = locate() in limb.wounds
	if(isnull(fracture) || !fracture.reset)
		return FALSE
	return TRUE

/datum/surgery_operation/limb/repair_compound/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始修复[FORMAT_LIMB_OWNER(limb)]的骨折……"),
		span_notice("[surgeon] 开始用 [tool] 修复[FORMAT_LIMB_OWNER(limb)]的骨折。"),
		span_notice("[surgeon] 开始修复[FORMAT_LIMB_OWNER(limb)]的骨折。"),
	)
	display_pain(limb.owner, "你[chinese_body_zone_display(limb.plaintext_zone)]的酸痛难以忍受！")

/datum/surgery_operation/limb/repair_compound/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/datum/wound/blunt/bone/critical/fracture = locate() in limb.wounds
	qdel(fracture)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你成功修复了[FORMAT_LIMB_OWNER(limb)]的骨折。"),
		span_notice("[surgeon] 成功用 [tool] 修复了[FORMAT_LIMB_OWNER(limb)]的骨折！"),
		span_notice("[surgeon] 成功修复了[FORMAT_LIMB_OWNER(limb)]的骨折！"),
	)

/datum/surgery_operation/limb/prepare_cranium_repair
	name = "清除颅骨碎屑"
	desc = "清除病人颅骨裂口中的骨片与碎屑，为修复做好准备。"
	operation_flags = OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		TOOL_HEMOSTAT = 1,
		TOOL_WIRECUTTER = 2.5,
		TOOL_SCREWDRIVER = 2.5,
	)
	time = 2.4 SECONDS
	preop_sound = 'sound/items/handling/surgery/hemostat1.ogg'

/datum/surgery_operation/limb/prepare_cranium_repair/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/cranial_fissure/fissure in limb.wounds)
		if(HAS_TRAIT(fissure, TRAIT_WOUND_SCANNED))
			. *= 0.5

/datum/surgery_operation/limb/prepare_cranium_repair/get_default_radial_image()
	return image(/obj/item/hemostat)

/datum/surgery_operation/limb/prepare_cranium_repair/all_required_strings()
	return list("颅骨必须裂开") + ..()

/datum/surgery_operation/limb/prepare_cranium_repair/state_check(obj/item/bodypart/limb)
	var/datum/wound/cranial_fissure/fissure = locate() in limb.wounds
	if(isnull(fissure) || fissure.prepped)
		return FALSE
	return TRUE

/datum/surgery_operation/limb/prepare_cranium_repair/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始清除[FORMAT_LIMB_OWNER(limb)]中较小的颅骨碎屑……"),
		span_notice("[surgeon] 开始清除[FORMAT_LIMB_OWNER(limb)]中较小的颅骨碎屑……"),
		span_notice("[surgeon] 开始在[FORMAT_LIMB_OWNER(limb)]里翻找……"),
	)
	display_pain(limb.owner, "你的大脑感觉像被细小的玻璃碎片刺扎！")

/datum/surgery_operation/limb/prepare_cranium_repair/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	var/datum/wound/cranial_fissure/fissure = locate() in limb.wounds
	fissure?.prepped = TRUE

/datum/surgery_operation/limb/repair_cranium
	name = "修复颅骨"
	desc = "修补病人颅骨上的裂口。"
	operation_flags = OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		/obj/item/stack/medical/bone_gel = 1,
		/obj/item/stack/medical/wrap/sticky_tape/surgical = 1,
		/obj/item/stack/medical/wrap/sticky_tape/super = 2,
		/obj/item/stack/medical/wrap/sticky_tape = 3.33,
	)
	time = 4 SECONDS

/datum/surgery_operation/limb/repair_cranium/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/cranial_fissure/fissure in limb.wounds)
		if(HAS_TRAIT(fissure, TRAIT_WOUND_SCANNED))
			. *= 0.5

/datum/surgery_operation/limb/repair_cranium/get_default_radial_image()
	return image(/obj/item/stack/medical/bone_gel)

/datum/surgery_operation/limb/repair_cranium/all_required_strings()
	return list("颅骨裂口处的碎屑已被清除") + ..()

/datum/surgery_operation/limb/repair_cranium/state_check(obj/item/bodypart/limb)
	var/datum/wound/cranial_fissure/fissure = locate() in limb.wounds
	if(isnull(fissure) || !fissure.prepped)
		return FALSE
	return TRUE

/datum/surgery_operation/limb/repair_cranium/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始尽己所能修复[limb.owner || limb]的头骨……"),
		span_notice("[surgeon] 开始用 [tool] 修复[limb.owner || limb]的头骨。"),
		span_notice("[surgeon] 开始修复[limb.owner || limb]的头骨。"),
	)

	display_pain(limb.owner, "你能感觉到颅骨碎片在摩擦你的大脑！")

/datum/surgery_operation/limb/repair_cranium/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/datum/wound/cranial_fissure/fissure = locate() in limb.wounds
	qdel(fissure)

	display_results(
		surgeon,
		limb.owner,
		span_notice("你成功修复了[limb.owner || limb]的头骨。"),
		span_notice("[surgeon] 成功用 [tool] 修复了[limb.owner || limb]的头骨。"),
		span_notice("[surgeon] 成功修复了[limb.owner || limb]的头骨。")
	)
