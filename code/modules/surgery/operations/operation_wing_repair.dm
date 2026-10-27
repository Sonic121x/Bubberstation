/datum/surgery_operation/organ/fix_wings
	name = "修复翅膀"
	rnd_name = "翅膀整形术（翅膀修复）"
	desc = "修复病人受损的翅膀，以恢复飞行能力。"
	rnd_desc = "一种使用合成肉液修复受损翅膀的手术。"
	implements = list(
		TOOL_HEMOSTAT = 1.15,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	operation_flags = OPERATION_LOCKED | OPERATION_NOTABLE
	time = 20 SECONDS
	target_type = /obj/item/organ/wings/moth
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED
	required_organ_flag = NONE

/datum/surgery_operation/organ/fix_wings/get_default_radial_image()
	return image(icon = 'icons/mob/human/species/moth/moth_wings.dmi', icon_state = "m_moth_wings_monarch_BEHIND")

/datum/surgery_operation/organ/fix_wings/all_required_strings()
	return ..() + list("翅膀必须已被烧毁", "病人必须已摄入至少 5 单位 [/datum/reagent/medicine/c2/synthflesh::name]")

/datum/surgery_operation/organ/fix_wings/all_blocked_strings()
	return ..() + list("若该肢体有骨骼，则骨骼必须完好")

/datum/surgery_operation/organ/fix_wings/state_check(obj/item/organ/wings/moth/organ)
	if(!organ.burnt)
		return FALSE
	// If bones are sawed, prevent the operation (unless we're operating on a limb with no bones)
	if(LIMB_HAS_ANY_SURGERY_STATE(organ.bodypart_owner, SURGERY_BONE_DRILLED|SURGERY_BONE_SAWED) && LIMB_HAS_BONES(organ.bodypart_owner))
		return FALSE
	if(organ.owner.reagents?.get_reagent_amount(/datum/reagent/medicine/c2/synthflesh) < 5)
		return FALSE
	return TRUE

/datum/surgery_operation/organ/fix_wings/on_preop(obj/item/organ/wings/moth/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始修复 [organ.owner] 受损的翅膀……"),
		span_notice("[surgeon] 开始修复 [organ.owner] 受损的翅膀。"),
		span_notice("[surgeon] 开始对 [organ.owner] 受损的翅膀施行手术。"),
	)
	display_pain(organ.owner, "你的翅膀疼得要命！")

/datum/surgery_operation/organ/fix_wings/on_success(obj/item/organ/wings/moth/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功修复了 [organ.owner] 的翅膀。"),
		span_notice("[surgeon] 成功修复了 [organ.owner] 的翅膀！"),
		span_notice("[surgeon] 完成了对 [organ.owner] 翅膀的手术。"),
	)
	display_pain(organ.owner, "你又能感觉到自己的翅膀了！")
	// heal the wings in question
	organ.heal_wings(surgeon, ALL)

	// might as well heal their antennae too
	var/obj/item/organ/antennae/antennae = organ.owner.get_organ_slot(ORGAN_SLOT_EXTERNAL_ANTENNAE)
	antennae?.heal_antennae(surgeon, ALL)

	organ.owner.update_body_parts()
