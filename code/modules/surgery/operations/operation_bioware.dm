/datum/surgery_operation/limb/bioware
	abstract_type = /datum/surgery_operation/limb/bioware
	implements = list(
		IMPLEMENT_HAND = 1,
	)
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_NOTABLE | OPERATION_MORBID | OPERATION_LOCKED
	required_bodytype = (~BODYTYPE_ROBOTIC & ~BODYTYPE_SYNTHETIC) // NOVA EDIT CHANGE - SYNTH FLAGS  -Original: required_bodytype = ~BODYTYPE_ROBOTIC
	time = 12.5 SECONDS
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_BONE_SAWED|SURGERY_ORGANS_CUT
	/// What status effect is gained when the surgery is successful?
	/// Used to check against other bioware types to prevent stacking.
	var/datum/status_effect/status_effect_gained = /datum/status_effect/bioware
	/// Zone to operate on for this bioware
	var/required_zone = BODY_ZONE_CHEST

/datum/surgery_operation/limb/bioware/get_default_radial_image()
	return image('icons/hud/implants.dmi', "lighting_bolt")

/datum/surgery_operation/limb/bioware/all_required_strings()
	return list("对 [chinese_body_zone_display(parse_zone(required_zone))] 施术（目标 [chinese_body_zone_display(parse_zone(required_zone))]）") + ..()

/datum/surgery_operation/limb/bioware/all_blocked_strings()
	var/list/incompatible_surgeries = list()
	for(var/datum/surgery_operation/limb/bioware/other_bioware as anything in subtypesof(/datum/surgery_operation/limb/bioware))
		if(other_bioware::status_effect_gained::id != status_effect_gained::id)
			continue
		if(other_bioware::required_bodytype != required_bodytype)
			continue
		incompatible_surgeries += (other_bioware.rnd_name || other_bioware.name)

	return ..() + list("病人此前不得接受过 [english_list(incompatible_surgeries, and_text = " 或 ")]")

/datum/surgery_operation/limb/bioware/state_check(obj/item/bodypart/limb)
	if(limb.body_zone != required_zone)
		return FALSE
	if(limb.owner.has_status_effect(status_effect_gained))
		return FALSE
	return TRUE

/datum/surgery_operation/limb/bioware/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	limb.owner.apply_status_effect(status_effect_gained)
	if(limb.owner.ckey)
		SSblackbox.record_feedback("tally", "bioware", 1, status_effect_gained)

/datum/surgery_operation/limb/bioware/vein_threading
	name = "编织静脉"
	rnd_name = "静脉缝编术（静脉编织）" // "together vessel fusion"
	desc = "将病人的静脉编织成加固网层，减少受伤时的失血量。"
	status_effect_gained = /datum/status_effect/bioware/heart/threaded_veins

/datum/surgery_operation/limb/bioware/vein_threading/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始编织[limb.owner]的血管。"),
		span_notice("[surgeon] 开始编织[limb.owner]的血管。"),
		span_notice("[surgeon] 开始摆弄[limb.owner]的血管。"),
	)
	display_pain(limb.owner, "你全身都灼痛难忍！")

/datum/surgery_operation/limb/bioware/vein_threading/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("你把[limb.owner]的血管编织成了抗损网层！"),
		span_notice("[surgeon] 把[limb.owner]的血管编织成了抗损网层！"),
		span_notice("[surgeon] 完成了对[limb.owner]血管的处理。"),
	)
	display_pain(limb.owner, "你能感觉到血液在加固后的静脉中奔流！")

/datum/surgery_operation/limb/bioware/vein_threading/mechanic
	rnd_name = "液压管路优化（编织静脉）"
	desc = "优化机械病人的液压系统管路，减少泄漏造成的液体流失。"
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/limb/bioware/muscled_veins
	name = "肌肉化静脉"
	rnd_name = "肌血管成形术（肌肉化静脉）" // "muscle vessel reshaping"
	desc = "为病人的静脉加上肌肉膜，使其无需心脏也能泵送血液。"
	status_effect_gained = /datum/status_effect/bioware/heart/muscled_veins

/datum/surgery_operation/limb/bioware/muscled_veins/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始把肌肉包裹在[limb.owner]的血管周围。"),
		span_notice("[surgeon] 开始把肌肉包裹在[limb.owner]的血管周围。"),
		span_notice("[surgeon] 开始摆弄[limb.owner]的血管。"),
	)
	display_pain(limb.owner, "你全身都灼痛难忍！")

/datum/surgery_operation/limb/bioware/muscled_veins/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("你重塑了[limb.owner]的血管，为其加上了肌肉膜！"),
		span_notice("[surgeon] 重塑了[limb.owner]的血管，为其加上了肌肉膜！"),
		span_notice("[surgeon] 完成了对[limb.owner]血管的处理。"),
	)
	display_pain(limb.owner, "你能感到心跳的有力搏动传遍全身！")

/datum/surgery_operation/limb/bioware/muscled_veins/mechanic
	rnd_name = "液压冗余子程序（肌肉化静脉）"
	desc = "为机械病人的液压系统增加冗余，使其在没有引擎或泵的情况下也能输送液体。"
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/limb/bioware/nerve_splicing
	name = "拼接神经"
	rnd_name = "神经缝接术（拼接神经）" // "together nerve fusion"
	desc = "将病人的神经拼接在一起，使其更能抵抗眩晕。"
	time = 15.5 SECONDS
	status_effect_gained = /datum/status_effect/bioware/nerves/spliced

/datum/surgery_operation/limb/bioware/nerve_splicing/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始拼接[limb.owner]的神经。"),
		span_notice("[surgeon] 开始拼接[limb.owner]的神经。"),
		span_notice("[surgeon] 开始摆弄[limb.owner]的神经系统。"),
	)
	display_pain(limb.owner, "你全身都麻木了！")

/datum/surgery_operation/limb/bioware/nerve_splicing/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("你成功拼接了[limb.owner]的神经系统！"),
		span_notice("[surgeon] 成功拼接了[limb.owner]的神经系统！"),
		span_notice("[surgeon] 完成了对[limb.owner]神经系统的处理。"),
	)
	display_pain(limb.owner, "你的身体恢复了感觉；周围的一切仿佛都在慢动作中发生！")

/datum/surgery_operation/limb/bioware/nerve_splicing/mechanic
	rnd_name = "系统自动重置子程序（拼接神经）"
	desc = "升级机械病人的自动系统，使其更能抵抗眩晕。"
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/limb/bioware/nerve_grounding
	name = "神经接地"
	rnd_name = "黄化神经成形术（接地神经）" // "yellow nerve reshaping". see: yellow gloves
	desc = "重新布线病人的神经，使其充当接地棒，保护其免受电击。"
	time = 15.5 SECONDS
	status_effect_gained = /datum/status_effect/bioware/nerves/grounded

/datum/surgery_operation/limb/bioware/nerve_grounding/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始重新布线[limb.owner]的神经。"),
		span_notice("[surgeon] 开始重新布线[limb.owner]的神经。"),
		span_notice("[surgeon] 开始摆弄[limb.owner]的神经系统。"),
	)
	display_pain(limb.owner, "你全身都麻木了！")

/datum/surgery_operation/limb/bioware/nerve_grounding/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("你成功重新布线了[limb.owner]的神经系统！"),
		span_notice("[surgeon] 成功重新布线了[limb.owner]的神经系统！"),
		span_notice("[surgeon] 完成了对[limb.owner]神经系统的处理。"),
	)
	display_pain(limb.owner, "你的身体恢复了感觉！你感觉精力充沛！")

/datum/surgery_operation/limb/bioware/nerve_grounding/mechanic
	rnd_name = "系统电击缓冲（接地神经）"
	desc = "在机械病人的神经系统中安装接地棒，保护其免受电击。"
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/limb/bioware/ligament_hook
	name = "重塑韧带"
	rnd_name = "关节成形术（韧带钩）" // "joint reshaping"
	desc = "重塑病人的韧带，使断肢可以被手动接回——代价是肢体也更容易脱落。"
	status_effect_gained = /datum/status_effect/bioware/ligaments/hooked

/datum/surgery_operation/limb/bioware/ligament_hook/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始把[limb.owner]的韧带重塑成钩状。"),
		span_notice("[surgeon] 开始把[limb.owner]的韧带重塑成钩状。"),
		span_notice("[surgeon] 开始摆弄[limb.owner]的韧带。"),
	)
	display_pain(limb.owner, "你的肢体传来剧烈的灼痛！")

/datum/surgery_operation/limb/bioware/ligament_hook/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("你把[limb.owner]的韧带重塑成了连接钩！"),
		span_notice("[surgeon] 把[limb.owner]的韧带重塑成了连接钩！"),
		span_notice("[surgeon] 完成了对[limb.owner]韧带的处理。"),
	)
	display_pain(limb.owner, "你的肢体感觉……怪异地松垮。")

/datum/surgery_operation/limb/bioware/ligament_hook/mechanic
	rnd_name = "锚点卡扣（韧带钩）"
	desc = "改造机械病人的肢体关节以实现快速拆卸，使断肢可以被手动接回—— \
		代价是肢体也更容易脱落。"
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/limb/bioware/ligament_reinforcement
	name = "强化韧带"
	rnd_name = "关节缝固术（韧带强化）" // "joint strengthening" / "joint stitching"
	desc = "强化病人的韧带，使肢体更难被截断，代价是神经连接更容易被打断。"
	status_effect_gained = /datum/status_effect/bioware/ligaments/reinforced

/datum/surgery_operation/limb/bioware/ligament_reinforcement/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始强化[limb.owner]的韧带。"),
		span_notice("[surgeon] 开始强化[limb.owner]的韧带。"),
		span_notice("[surgeon] 开始摆弄[limb.owner]的韧带。"),
	)
	display_pain(limb.owner, "你的肢体传来剧烈的灼痛！")

/datum/surgery_operation/limb/bioware/ligament_reinforcement/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("你强化了[limb.owner]的韧带！"),
		span_notice("[surgeon] 强化了[limb.owner]的韧带！"),
		span_notice("[surgeon] 完成了对[limb.owner]韧带的处理。"),
	)
	display_pain(limb.owner, "你的肢体感觉更稳固了，但也更脆弱了。")

/datum/surgery_operation/limb/bioware/ligament_reinforcement/mechanic
	rnd_name = "锚点加固（韧带强化）"
	desc = "加固机械病人的肢体关节以防止截肢，代价是神经连接更容易被打断。"
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/limb/bioware/cortex_folding
	name = "皮层折叠"
	rnd_name = "脑分形成形术（皮层折叠）" // it's a stretch - "brain fractal reshaping"
	desc = "一种生物升级，将病人的大脑皮层折叠成分形图案，提高神经密度与灵活性。"
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_NOTABLE | OPERATION_MORBID | OPERATION_LOCKED | OPERATION_NO_PATIENT_REQUIRED
	status_effect_gained = /datum/status_effect/bioware/cortex // Not actually applied, simply for compatibility checks
	required_zone = BODY_ZONE_HEAD

/datum/surgery_operation/limb/bioware/cortex_folding/state_check(obj/item/bodypart/limb)
	. = ..()
	if (!.)
		return
	var/obj/item/organ/brain/brain = locate() in limb
	if(isnull(brain))
		return FALSE
	return !HAS_TRAIT_FROM(brain, TRAIT_SPECIAL_TRAUMA_BOOST, BIOWARE_TRAIT)

/datum/surgery_operation/limb/bioware/cortex_folding/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	var/obj/item/organ/brain/brain = locate() in limb
	if(!isnull(brain))
		ADD_TRAIT(brain, TRAIT_SPECIAL_TRAUMA_BOOST, BIOWARE_TRAIT)

/datum/surgery_operation/limb/bioware/cortex_folding/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始折叠[limb.owner]的大脑皮层。"),
		span_notice("[surgeon] 开始折叠[limb.owner]的大脑皮层。"),
		span_notice("[surgeon] 开始对[limb.owner]的大脑施行手术。"),
	)
	display_pain(limb.owner, "你的头传来骇人的剧痛，几乎无法承受！")

/datum/surgery_operation/limb/bioware/cortex_folding/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("你把[limb.owner]的大脑皮层折叠成了分形图案！"),
		span_notice("[surgeon] 把[limb.owner]的大脑皮层折叠成了分形图案！"),
		span_notice("[surgeon] 完成了对[limb.owner]大脑的手术。"),
	)
	display_pain(limb.owner, "你的大脑感觉更强韧……也更灵活了！")

/datum/surgery_operation/limb/bioware/cortex_folding/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool)
	var/obj/item/organ/brain/brain = locate() in limb
	if(isnull(brain))
		return ..()
	display_results(
		surgeon,
		limb.owner,
		span_warning("你搞砸了，损伤了大脑！"),
		span_warning("[surgeon] 搞砸了，损伤了大脑！"),
		span_notice("[surgeon] 完成了对[limb.owner]大脑的手术。"),
	)
	display_pain(limb.owner, "你的头传来难以忍受的剧痛！")
	brain.apply_organ_damage(60)
	brain.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)

/datum/surgery_operation/limb/bioware/cortex_folding/mechanic
	rnd_name = "湿件操作系统迷宫编程（皮层折叠）"
	desc = "用一种十足的邪异编程语言重新编程机械病人的神经网络，为非标准神经模式腾出空间。"
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/limb/bioware/cortex_imprint
	name = "皮层印刻"
	rnd_name = "脑印刻成形术（皮层印刻）" // it's a stretch - "brain print reshaping"
	desc = "一种生物升级，将病人的大脑皮层刻成自印刻图案，提高神经密度与韧性。"
	status_effect_gained = /datum/status_effect/bioware/cortex/imprinted
	required_zone = BODY_ZONE_HEAD

/datum/surgery_operation/limb/bioware/cortex_imprint/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始把[limb.owner]的外层大脑皮层刻成自印刻图案。"),
		span_notice("[surgeon] 开始把[limb.owner]的外层大脑皮层刻成自印刻图案。"),
		span_notice("[surgeon] 开始对[limb.owner]的大脑施行手术。"),
	)
	display_pain(limb.owner, "你的头传来骇人的剧痛，几乎无法承受！")

/datum/surgery_operation/limb/bioware/cortex_imprint/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("你把[limb.owner]的外层大脑皮层重塑成了自印刻图案！"),
		span_notice("[surgeon] 把[limb.owner]的外层大脑皮层重塑成了自印刻图案！"),
		span_notice("[surgeon] 完成了对[limb.owner]大脑的手术。"),
	)
	display_pain(limb.owner, "你的大脑感觉更强韧……也更有韧性了！")

/datum/surgery_operation/limb/bioware/cortex_imprint/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool)
	if(!limb.owner.get_organ_slot(ORGAN_SLOT_BRAIN))
		return ..()
	display_results(
		surgeon,
		limb.owner,
		span_warning("你搞砸了，损伤了大脑！"),
		span_warning("[surgeon] 搞砸了，损伤了大脑！"),
		span_notice("[surgeon] 完成了对[limb.owner]大脑的手术。"),
	)
	display_pain(limb.owner, "你的大脑传来剧烈的疼痛；连思考都会疼！")
	limb.owner.adjust_organ_loss(ORGAN_SLOT_BRAIN, 60)
	limb.owner.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)

/datum/surgery_operation/limb/bioware/cortex_imprint/mechanic
	rnd_name = "湿件操作系统 2.0 版（皮层印刻）"
	desc = "把机械病人的操作系统更新到“更新版本”，提升整体性能与韧性。 \
		可惜附带了一堆广告软件。"
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
