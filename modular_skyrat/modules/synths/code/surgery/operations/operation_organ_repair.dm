/// Repairing specific Synth Organs

/*
*
*   Hydraulic Pump Surgery - Heart
*
*/

/// Hydraulic Pump Surgery - Heart
/datum/surgery_operation/organ/repair/coronary_bypass/mechanic/synth
	name = "检修液压泵内部"
	rnd_name = "液压泵维护"
	desc = "用于修复仿生人内部液压泵的机械手术。"
	implements = list(
		TOOL_CROWBAR = 0.8,
		TOOL_SCALPEL = 1.5,
		/obj/item/melee/energy/sword = 2,
		/obj/item/knife = 3.25,
		/obj/item/shard = 3.85,
	)
	preop_sound = 'sound/items/tools/ratchet.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	target_type = /obj/item/organ/heart/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/coronary_bypass/mechanic/synth/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始紧固[FORMAT_ORGAN_OWNER(organ)]液压泵周围的卡箍……"),
		span_notice("[surgeon]开始用[tool]修复[FORMAT_ORGAN_OWNER(organ)]的液压泵！"),
		span_notice("[surgeon]开始修复[FORMAT_ORGAN_OWNER(organ)]的液压泵！"),
	)
	display_pain(organ.owner, "你的胸口剧痛难忍！你几乎撑不住了！")

// flavor text - success
/datum/surgery_operation/organ/repair/coronary_bypass/mechanic/synth/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功为[FORMAT_ORGAN_OWNER(organ)]的液压泵接上了旁通管道。"),
		span_notice("[surgeon]用[tool]固定好了[FORMAT_ORGAN_OWNER(organ)]液压泵周围的管路。"),
		span_notice("[surgeon]固定好了[FORMAT_ORGAN_OWNER(organ)]液压泵周围的管路。"),
	)
	display_pain(organ.owner, "你的胸口仍在阵阵作痛，但心脏感觉前所未有地好！")

// flavor text - on_failure
/datum/surgery_operation/organ/repair/coronary_bypass/mechanic/synth/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	var/blood_name = LOWER_TEXT(organ.owner?.get_bloodtype()?.get_blood_name()) || "血液"
	display_results(
		surgeon,
		organ.owner,
		span_warning("你失手将[tool]滑进了泵内，把管路从泵上扯了下来！"),
		span_warning("[surgeon]操作失误，导致高压[blood_name]从[FORMAT_ORGAN_OWNER(organ)]胸口大量喷出！"),
		span_warning("[surgeon]完成了手术，可[blood_name]应该这样从[FORMAT_ORGAN_OWNER(organ)]胸口喷出来吗？"),
	)
	display_pain(organ.owner, "胸口传来灼痛，你感觉自己快要疯了！")

/*
*
*   Reagent Processor Surgery - Liver
*
*/

/// Reagent Processor Repair surgery start
/datum/surgery_operation/organ/repair/hepatectomy/mechanic/synth
	name = "维护试剂处理器"
	rnd_name = "试剂处理器维护（试剂处理器修复）"
	desc = "用于修复仿生人试剂处理器的机械手术。"
	implements = list(
		TOOL_WRENCH = 0.8,
		TOOL_SCALPEL = 1.5,
		/obj/item/melee/energy/sword = 2,
		/obj/item/knife = 3.25,
		/obj/item/shard = 3.85,
	)
	preop_sound = 'sound/items/tools/screwdriver_operating.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	target_type = /obj/item/organ/liver/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/hepatectomy/mechanic/synth/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始清除[FORMAT_ORGAN_OWNER(organ)]试剂处理器内堆积的矿物垢……"),
		span_notice("[surgeon]开始用[tool]切开[FORMAT_ORGAN_OWNER(organ)]的试剂处理器。"),
		span_notice("[surgeon]开始切开[FORMAT_ORGAN_OWNER(organ)]的试剂处理器。"),
	)
	display_pain(organ.owner, "你的系统断开了与试剂处理器的连接，以避免不必要的错误。")

// flavor text - success
/datum/surgery_operation/organ/repair/hepatectomy/mechanic/synth/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功清除了[FORMAT_ORGAN_OWNER(organ)]试剂处理器中的矿物垢，并恢复了出厂设置。"),
		span_notice("[surgeon]成功清除了[FORMAT_ORGAN_OWNER(organ)]试剂处理器中的矿物垢，并恢复了出厂设置。"),
		span_notice("[surgeon]成功重置了[FORMAT_ORGAN_OWNER(organ)]的试剂处理器。"),
	)
	display_pain(organ.owner, "流量已恢复。")

// flavor text - failure
/datum/surgery_operation/organ/repair/hepatectomy/mechanic/synth/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("你切错了[FORMAT_ORGAN_OWNER(organ)]试剂处理器的部件，破坏了其规格！"),
		span_warning("[surgeon]照着错误的图纸维修了[FORMAT_ORGAN_OWNER(organ)]的试剂处理器！"),
		span_warning("[surgeon]调整好了[FORMAT_ORGAN_OWNER(organ)]的试剂处理器……等等，好像不对……"),
	)
	display_pain(organ.owner, "错误信息在你的视野中滚动！")

/*
*
*   Heatsink Repair Surgery - Lung
*
*/

/// Heatsink Repair Surgery start
/datum/surgery_operation/organ/repair/lobectomy/mechanic/synth
	name = "散热器维护"
	rnd_name = "散热器诊断（散热器修复）"
	desc = "用于修复仿生人内部散热器的机械手术。"
	implements = list(
		TOOL_WRENCH = 1.05,
		TOOL_RETRACTOR = 1.5,
	)
	preop_sound = 'sound/items/tools/ratchet_fast.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	target_type = /obj/item/organ/lungs/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/lobectomy/mechanic/synth/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始拧紧[FORMAT_ORGAN_OWNER(organ)]散热器上的螺栓……"),
		span_notice("[surgeon]开始用[tool]拧紧[FORMAT_ORGAN_OWNER(organ)]散热器上的螺栓。"),
		span_notice("[surgeon]开始拧紧[FORMAT_ORGAN_OWNER(organ)]散热器上的螺栓。"),
	)
	display_pain(organ.owner, "[surgeon]开始操作时，你感觉胸腔内传来金属碰撞。")

// flavor text - success
/datum/surgery_operation/organ/repair/lobectomy/mechanic/synth/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功拧紧了[FORMAT_ORGAN_OWNER(organ)]散热器上的螺栓。"),
		span_notice("[surgeon]成功用[tool]紧固了[FORMAT_ORGAN_OWNER(organ)]的散热器。"),
		span_notice("[surgeon]完成了对[FORMAT_ORGAN_OWNER(organ)]散热器的紧固。"),
	)
	display_pain(organ.owner, "温度调节系统的内部错误已清除。")

// flavor text - failure
/datum/surgery_operation/organ/repair/lobectomy/mechanic/synth/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("你手一滑，勉强接住了掉落的[tool]，没能紧固[FORMAT_ORGAN_OWNER(organ)]的散热器！"),
		span_warning("[surgeon]笨手笨脚，差点让[tool]掉进[FORMAT_ORGAN_OWNER(organ)]的胸腔，幸好及时接住！"),
		span_warning("[surgeon]操作失误，差点把[tool]掉进[FORMAT_ORGAN_OWNER(organ)]的胸腔！"),
	)
	display_pain(organ.owner, "你感觉胸腔内传来沉闷的撞击，像是[tool]掉进去了！")

/*
*
*   Fuel Cell Maintenance - Stomach
*
*/

/// Fuel Cell Maintenance - Start
/datum/surgery_operation/organ/repair/gastrectomy/mechanic/synth
	name = "燃料电池维护"
	rnd_name = "燃料电池诊断（燃料电池修复）"
	desc = "用于修复仿生人内部燃料电池的机械手术。"
	implements = list(
		TOOL_SCREWDRIVER = 1.05,
		TOOL_SCALPEL = 1.5,
		/obj/item/melee/energy/sword = 2,
		/obj/item/knife = 3.25,
		/obj/item/shard = 3.85,
		/obj/item = 6,
	)
	preop_sound = 'sound/effects/bodyfall/bodyfall1.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	target_type = /obj/item/organ/stomach/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/gastrectomy/mechanic/synth/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始修补[FORMAT_ORGAN_OWNER(organ)]燃料电池的受损部分……"),
		span_notice("[surgeon]开始用[tool]小心修复[FORMAT_ORGAN_OWNER(organ)]的燃料电池。"),
		span_notice("[surgeon]开始小心修复[FORMAT_ORGAN_OWNER(organ)]的燃料电池。"),
	)
	display_pain(organ.owner, "你的腹部传来可怕的刺痛！")

// flavor text - success
/datum/surgery_operation/organ/repair/gastrectomy/mechanic/synth/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功移除了[FORMAT_ORGAN_OWNER(organ)]燃料电池的受损部分。"),
		span_notice("[surgeon]成功用[tool]修复了[FORMAT_ORGAN_OWNER(organ)]燃料电池的受损部分。"),
		span_notice("[surgeon]成功修复了[FORMAT_ORGAN_OWNER(organ)]燃料电池的受损部分。"),
	)
	display_pain(organ.owner, "燃料电池的错误已清除。")

// flavor text - failure
/datum/surgery_operation/organ/repair/gastrectomy/mechanic/synth/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("你手一滑，刺穿了[FORMAT_ORGAN_OWNER(organ)]的燃料电池！"),
		span_warning("[surgeon]手一滑，用[tool]刺穿了[FORMAT_ORGAN_OWNER(organ)]的燃料电池！"),
		span_warning("[surgeon]手一滑，刺穿了[FORMAT_ORGAN_OWNER(organ)]的燃料电池！"),
	)
	display_pain(organ.owner, "你的腹部又报出了新的错误，这不对劲！")

/*
*
*   Reset Logic Core - Brain
*
*/

/// Reset Logic Core - Start
/datum/surgery_operation/organ/repair/brain/mechanic/synth
	name = "进行神经调试"
	rnd_name = "重置逻辑核心（正电子脑修复）"
	desc = "恢复人形合成人神经网络的默认行为逻辑与人格矩阵的手术。"
	implements = list(
		TOOL_MULTITOOL = 1.05,
		TOOL_SCREWDRIVER = 4.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	time = 12 SECONDS //long and complicated
	target_type = /obj/item/organ/brain/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/brain/mechanic/synth/on_preop(obj/item/organ/brain/synth/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/brain_type = "正电子脑"
	var/obj/item/organ/brain/synth/synth_brain = organ.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	brain_type = synth_brain.name
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始清除[FORMAT_ORGAN_OWNER(organ)]的[brain_type]中的系统损坏……"),
		span_notice("[surgeon]开始修复[FORMAT_ORGAN_OWNER(organ)]的[brain_type]。"),
		span_notice("[surgeon]开始对[FORMAT_ORGAN_OWNER(organ)]的[brain_type]进行手术。"),
	)
	display_pain(organ.owner, "你的思绪开始变得支离破碎！")

// flavor text - success
/datum/surgery_operation/organ/repair/brain/mechanic/synth/on_success(obj/item/organ/brain/synth/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	organ.apply_organ_damage(-organ.maxHealth * heal_to_percent) // no parent call, special healing for this one
	var/brain_type = "正电子脑"
	var/obj/item/organ/brain/synth/synth_brain = organ.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(synth_brain)
		brain_type = synth_brain.name
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功清除了[FORMAT_ORGAN_OWNER(organ)]的[brain_type]中的系统损坏。"),
		span_notice("[surgeon]成功修复了[FORMAT_ORGAN_OWNER(organ)]的[brain_type]。"),
		span_notice("[surgeon]完成了对[FORMAT_ORGAN_OWNER(organ)]的[brain_type]的手术。"),
	)
	display_pain(organ.owner, "碎片化错误开始清除。")
	if (organ.owner)
		organ.owner.mind?.remove_antag_datum(/datum/antagonist/brainwashed)
	else if (organ.brainmob)
		organ.brainmob.mind?.remove_antag_datum(/datum/antagonist/brainwashed)
	organ.cure_all_traumas(TRAUMA_RESILIENCE_SURGERY)
	if(organ.damage > organ.maxHealth * 0.1)
		to_chat(surgeon, "[FORMAT_ORGAN_OWNER(organ)]的[brain_type]仍有一些可以清除的持续性系统损伤。")

// flavor text - failure
/datum/surgery_operation/organ/repair/brain/mechanic/synth/on_failure(obj/item/organ/brain/synth/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	var/brain_type = "正电子脑"
	var/obj/item/organ/brain/synth/synth_brain = organ.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(synth_brain)
		brain_type = synth_brain.name
	display_results(
		surgeon,
		organ.owner,
		span_warning("你搞砸了，导致数据碎片化！"),
		span_warning("[surgeon]操作失误，损坏了电路！"),
		span_notice("[surgeon]完成了对[FORMAT_ORGAN_OWNER(organ)]的[brain_type]的手术。至少看起来如此。"),
	)
	display_pain(organ.owner, "错误信息充斥着你的视野，出问题了！")
	organ.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)

/*
*
*   Repair auditory microphones - Ear
*
*/

/// Repair Auditory Microphones - Start
/datum/surgery_operation/organ/repair/ears/synth
	name = "耳部修复"
	rnd_name = "维修听觉麦克风（听力修复）" // source: i made it up
	desc = "修复患者受损的耳部，恢复听力。"
	implements = list(
		TOOL_MULTITOOL = 1.15,
		TOOL_SCREWDRIVER = 4.85,
		/obj/item/pen = 6.67,
	)
	target_type = /obj/item/organ/ears/synth
	time = 6.4 SECONDS
	heal_to_percent = 0
	repeatable = TRUE
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 1

/datum/surgery_operation/organ/repair/ears/synth/all_blocked_strings()
	return ..() + list("如果该肢体有骨骼，骨骼必须完好")

/datum/surgery_operation/organ/repair/ears/synth/state_check(obj/item/organ/ears/organ)
	// If bones are sawed, prevent the operation (unless we're operating on a limb with no bones)
	if(LIMB_HAS_ANY_SURGERY_STATE(organ.bodypart_owner, SURGERY_BONE_SAWED|SURGERY_BONE_DRILLED) && LIMB_HAS_BONES(organ.bodypart_owner))
		return FALSE
	return TRUE // always available so you can intentionally fail it

/datum/surgery_operation/organ/repair/ears/synth/on_preop(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始修复[FORMAT_ORGAN_OWNER(organ)]的麦克风……"),
		span_notice("[surgeon]开始修复[FORMAT_ORGAN_OWNER(organ)]的麦克风。"),
		span_notice("[surgeon]开始维护[FORMAT_ORGAN_OWNER(organ)]的麦克风。"),
	)
	display_pain(organ.owner, "你的听觉输入开始响起巨大的噼啪声！")

/datum/surgery_operation/organ/repair/ears/synth/on_success(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	var/deaf_change = 40 SECONDS - organ.temporary_deafness
	organ.adjust_temporary_deafness(deaf_change)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功修复了[FORMAT_ORGAN_OWNER(organ)]的麦克风。"),
		span_notice("[surgeon]成功修复了[FORMAT_ORGAN_OWNER(organ)]的麦克风。"),
		span_notice("[surgeon]成功修复了[FORMAT_ORGAN_OWNER(organ)]的麦克风。"),
	)
	display_pain(organ.owner, "传感器发出抗议，但你的麦克风似乎正在恢复上线！")

/datum/surgery_operation/organ/repair/ears/synth/on_failure(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/obj/item/organ/brain/brain = locate() in organ.bodypart_owner
	if(isnull(brain))
		display_results(
			surgeon,
			organ.owner,
			span_warning("你不小心刺中了[FORMAT_ORGAN_OWNER(organ)]的正电子脑！至少，要是有正电子脑就会这样。"),
			span_warning("[surgeon]不小心刺中了[FORMAT_ORGAN_OWNER(organ)]的正电子脑！至少，要是有正电子脑就会这样。"),
			span_warning("[surgeon]不小心刺中了[FORMAT_ORGAN_OWNER(organ)]的正电子脑！"),
		)
		return

	display_results(
		surgeon,
		organ.owner,
		span_warning("你不小心刺中了[FORMAT_ORGAN_OWNER(organ)]的正电子脑！"),
		span_warning("[surgeon]不小心刺中了[FORMAT_ORGAN_OWNER(organ)]的正电子脑！"),
		span_warning("[surgeon]不小心刺中了[FORMAT_ORGAN_OWNER(organ)]的正电子脑！"),
	)
	display_pain(organ.owner, "体内有什么发生短路，突然电得你一震！")
