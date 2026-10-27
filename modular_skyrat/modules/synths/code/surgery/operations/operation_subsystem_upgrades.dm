/datum/surgery_operation/limb/subsystem_upgrade
	abstract_type = /datum/surgery_operation/limb/subsystem_upgrade
	implements = list(
		IMPLEMENT_HAND = 1,
	)
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_NOTABLE | OPERATION_MORBID | OPERATION_LOCKED | OPERATION_MECHANIC
	required_bodytype = BODYTYPE_SYNTHETIC
	time = 12.5 SECONDS
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_BONE_SAWED|SURGERY_ORGANS_CUT
	/// What status effect is gained when the surgery is successful?
	/// Used to check against other subsystem_upgrade types to prevent stacking.
	var/datum/status_effect/status_effect_gained = /datum/status_effect/subsystem_upgrade
	/// Zone to operate on for this subsystem_upgrade
	var/required_zone = BODY_ZONE_CHEST

/datum/surgery_operation/limb/subsystem_upgrade/get_default_radial_image()
	return image('icons/hud/implants.dmi', "lighting_bolt")

/datum/surgery_operation/limb/subsystem_upgrade/all_required_strings()
	return list("对[parse_zone(required_zone)]进行手术（瞄准[parse_zone(required_zone)]）") + ..()

/datum/surgery_operation/limb/subsystem_upgrade/all_blocked_strings()
	var/list/incompatible_surgeries = list()
	for(var/datum/surgery_operation/limb/subsystem_upgrade/other_subsystem_upgrade as anything in subtypesof(/datum/surgery_operation/limb/subsystem_upgrade))
		if(other_subsystem_upgrade::status_effect_gained::id != status_effect_gained::id)
			continue
		if(other_subsystem_upgrade::required_bodytype != required_bodytype)
			continue
		incompatible_surgeries += (other_subsystem_upgrade.rnd_name || other_subsystem_upgrade.name)

	return ..() + list("患者此前不得接受过[jointext(incompatible_surgeries, "或")]手术")

/datum/surgery_operation/limb/subsystem_upgrade/state_check(obj/item/bodypart/limb)
	if(limb.body_zone != required_zone)
		return FALSE
	if(limb.owner.has_status_effect(status_effect_gained))
		return FALSE
	return TRUE

/datum/surgery_operation/limb/subsystem_upgrade/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	limb.owner.apply_status_effect(status_effect_gained)
	if(limb.owner.ckey)
		SSblackbox.record_feedback("tally", "subsystem_upgrade", 1, status_effect_gained)

/datum/surgery_operation/limb/subsystem_upgrade/muscled_veins
	name = "肌化血管"
	rnd_name = "液压冗余子程序（肌化血管）"
	desc = "为机械患者的液压系统添加冗余，使其没有驱动机或泵也能推动液体。"
	status_effect_gained = /datum/status_effect/subsystem_upgrade/heart/muscled_veins

/datum/surgery_operation/limb/subsystem_upgrade/muscled_veins/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始用肌肉包裹[limb.owner]的血管。"),
		span_notice("[surgeon]开始用肌肉包裹[limb.owner]的血管。"),
		span_notice("[surgeon]开始调整[limb.owner]的血管。"),
	)
	display_pain(limb.owner, "你的全身都灼痛难忍！")

/datum/surgery_operation/limb/subsystem_upgrade/muscled_veins/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("你重塑了[limb.owner]的血管，添加了一层肌肉膜！"),
		span_notice("[surgeon]重塑了[limb.owner]的血管，添加了一层肌肉膜！"),
		span_notice("[surgeon]完成了对[limb.owner]血管的调整。"),
	)
	display_pain(limb.owner, "你能感觉到强劲的心跳脉动传遍全身！")

/datum/surgery_operation/limb/subsystem_upgrade/nerve_splicing
	name = "拼接神经"
	rnd_name = "强化伺服机构（神经拼接）"
	desc = "升级合成人患者的运动伺服机构，使其更能抵抗眩晕。"
	time = 15.5 SECONDS
	status_effect_gained = /datum/status_effect/subsystem_upgrade/nerves/spliced

/datum/surgery_operation/limb/subsystem_upgrade/nerve_splicing/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始拼接[limb.owner]的神经。"),
		span_notice("[surgeon]开始拼接[limb.owner]的神经。"),
		span_notice("[surgeon]开始调整[limb.owner]的神经系统。"),
	)
	display_pain(limb.owner, "你的全身都麻木了！")

/datum/surgery_operation/limb/subsystem_upgrade/nerve_splicing/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("你成功拼接了[limb.owner]的神经系统！"),
		span_notice("[surgeon]成功拼接了[limb.owner]的神经系统！"),
		span_notice("[surgeon]完成了对[limb.owner]神经系统的调整。"),
	)
	display_pain(limb.owner, "你的身体恢复了知觉，周围的一切仿佛都变成了慢动作！")

/datum/surgery_operation/limb/subsystem_upgrade/nerve_grounding
	name = "神经接地"
	rnd_name = "强化电容器（神经接地）"
	desc = "安装额外的电容组以吸收电击。"
	time = 15.5 SECONDS
	status_effect_gained = /datum/status_effect/subsystem_upgrade/nerves/grounded

/datum/surgery_operation/limb/subsystem_upgrade/nerve_grounding/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始重接[limb.owner]的神经。"),
		span_notice("[surgeon]开始重接[limb.owner]的神经。"),
		span_notice("[surgeon]开始调整[limb.owner]的神经系统。"),
	)
	display_pain(limb.owner, "你的全身都麻木了！")

/datum/surgery_operation/limb/subsystem_upgrade/nerve_grounding/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("你成功重接了[limb.owner]的神经系统！"),
		span_notice("[surgeon]成功重接了[limb.owner]的神经系统！"),
		span_notice("[surgeon]完成了对[limb.owner]神经系统的调整。"),
	)
	display_pain(limb.owner, "你的身体恢复了知觉！你感到充满活力！")

/datum/surgery_operation/limb/subsystem_upgrade/ligament_reinforcement
	name = "强化韧带"
	rnd_name = "锚点加固（韧带强化）"
	desc = "加固机械患者的肢体关节以防止断肢，代价是神经连接更容易中断。"
	status_effect_gained = /datum/status_effect/subsystem_upgrade/ligaments/reinforced

/datum/surgery_operation/limb/subsystem_upgrade/ligament_reinforcement/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始强化[limb.owner]的韧带。"),
		span_notice("[surgeon]开始强化[limb.owner]的韧带。"),
		span_notice("[surgeon]开始调整[limb.owner]的韧带。"),
	)
	display_pain(limb.owner, "你的四肢传来剧烈的灼痛！")

/datum/surgery_operation/limb/subsystem_upgrade/ligament_reinforcement/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("你强化了[limb.owner]的韧带！"),
		span_notice("[surgeon]强化了[limb.owner]的韧带！"),
		span_notice("[surgeon]完成了对[limb.owner]韧带的调整。"),
	)
	display_pain(limb.owner, "你的四肢感觉更加牢固，却也更加脆弱了。")

/datum/surgery_operation/limb/subsystem_upgrade/cortex_folding
	name = "皮层折叠"
	rnd_name = "神经通路强化（皮层折叠）"
	desc = "使用诡异至极的编程语言重写机械患者的神经网络，为非标准神经模式腾出空间。"
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_NOTABLE | OPERATION_MORBID | OPERATION_LOCKED | OPERATION_NO_PATIENT_REQUIRED
	status_effect_gained = /datum/status_effect/subsystem_upgrade/cortex // Not actually applied, simply for compatibility checks
	required_zone = BODY_ZONE_CHEST

/datum/surgery_operation/limb/subsystem_upgrade/cortex_folding/state_check(obj/item/bodypart/limb)
	. = ..()
	if (!.)
		return
	var/obj/item/organ/brain/brain = locate() in limb
	if(isnull(brain))
		return FALSE
	return !HAS_TRAIT_FROM(brain, TRAIT_SPECIAL_TRAUMA_BOOST, SUBSYSTEM_UPGRADE_TRAIT)

/datum/surgery_operation/limb/subsystem_upgrade/cortex_folding/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	var/obj/item/organ/brain/brain = locate() in limb
	if(!isnull(brain))
		ADD_TRAIT(brain, TRAIT_SPECIAL_TRAUMA_BOOST, SUBSYSTEM_UPGRADE_TRAIT)

/datum/surgery_operation/limb/subsystem_upgrade/cortex_folding/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始折叠[limb.owner]的大脑皮层。"),
		span_notice("[surgeon]开始折叠[limb.owner]的大脑皮层。"),
		span_notice("[surgeon]开始对[limb.owner]的大脑进行手术。"),
	)
	display_pain(limb.owner, "你的头部剧烈抽痛，几乎难以承受！")

/datum/surgery_operation/limb/subsystem_upgrade/cortex_folding/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("你将[limb.owner]的大脑皮层折叠成了分形图案！"),
		span_notice("[surgeon]将[limb.owner]的大脑皮层折叠成了分形图案！"),
		span_notice("[surgeon]完成了对[limb.owner]大脑的手术。"),
	)
	display_pain(limb.owner, "你的大脑感觉更强大了……也更加灵活！")

/datum/surgery_operation/limb/subsystem_upgrade/cortex_folding/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool)
	var/obj/item/organ/brain/brain = locate() in limb
	if(isnull(brain))
		return ..()
	display_results(
		surgeon,
		limb.owner,
		span_warning("你操作失误，损伤了大脑！"),
		span_warning("[surgeon]操作失误，损伤了大脑！"),
		span_notice("[surgeon]完成了对[limb.owner]大脑的手术。"),
	)
	display_pain(limb.owner, "你的头部抽痛得难以忍受！")
	brain.apply_organ_damage(60)
	brain.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)

/datum/surgery_operation/limb/subsystem_upgrade/cortex_imprint
	name = "皮层印刻"
	rnd_name = "抗级联2.0（皮层印刻）"
	desc = "将机械患者的底层操作系统更新到“较新版本”，提高整体性能和韧性。\
		可惜捆绑了太多广告软件。"
	status_effect_gained = /datum/status_effect/subsystem_upgrade/cortex/imprinted
	required_zone = BODY_ZONE_CHEST

/datum/surgery_operation/limb/subsystem_upgrade/cortex_imprint/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始在[limb.owner]的大脑外皮层刻出自印刻图案。"),
		span_notice("[surgeon]开始在[limb.owner]的大脑外皮层刻出自印刻图案。"),
		span_notice("[surgeon]开始对[limb.owner]的大脑进行手术。"),
	)
	display_pain(limb.owner, "你的头部剧烈抽痛，几乎难以承受！")

/datum/surgery_operation/limb/subsystem_upgrade/cortex_imprint/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("你将[limb.owner]的大脑外皮层重塑成了自印刻图案！"),
		span_notice("[surgeon]将[limb.owner]的大脑外皮层重塑成了自印刻图案！"),
		span_notice("[surgeon]完成了对[limb.owner]大脑的手术。"),
	)
	display_pain(limb.owner, "你的大脑感觉更强大了……也更坚韧！")

/datum/surgery_operation/limb/subsystem_upgrade/cortex_imprint/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool)
	if(!limb.owner.get_organ_slot(ORGAN_SLOT_BRAIN))
		return ..()
	display_results(
		surgeon,
		limb.owner,
		span_warning("你操作失误，损伤了大脑！"),
		span_warning("[surgeon]操作失误，损伤了大脑！"),
		span_notice("[surgeon]完成了对[limb.owner]大脑的手术。"),
	)
	display_pain(limb.owner, "你的大脑剧烈抽痛，连思考都令人痛苦！")
	limb.owner.adjust_organ_loss(ORGAN_SLOT_BRAIN, 60)
	limb.owner.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)
