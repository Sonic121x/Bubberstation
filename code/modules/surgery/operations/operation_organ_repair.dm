/// Repairing specific organs
/datum/surgery_operation/organ/repair
	abstract_type = /datum/surgery_operation/organ/repair
	name = "修复器官"
	desc = "修复病人受损的器官。"
	required_organ_flag = ORGAN_TYPE_FLAGS & ~ORGAN_ROBOTIC
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_NOTABLE | OPERATION_NO_PATIENT_REQUIRED
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT|SURGERY_BONE_SAWED
	/// What % damage do we heal the organ to on success
	/// Note that 0% damage = 100% health
	var/heal_to_percent = 0.6
	/// What % damage do we apply to the organ on failure
	var/failure_damage_percent = 0.2
	/// If TRUE, an organ can be repaired multiple times
	var/repeatable = FALSE

/datum/surgery_operation/organ/repair/New()
	. = ..()
	if(operation_flags & OPERATION_LOOPING)
		repeatable = TRUE // if it's looping it would necessitate being repeatable
	if(!repeatable)
		desc += " 该手术对每个器官只能进行一次。"

/datum/surgery_operation/organ/repair/state_check(obj/item/organ/organ)
	if(organ.damage < (organ.maxHealth * heal_to_percent) || (!repeatable && HAS_TRAIT(organ, TRAIT_ORGAN_OPERATED_ON)))
		return FALSE // conditionally available so we don't spam the radial with useless options, alas
	return TRUE

/datum/surgery_operation/organ/repair/all_required_strings()
	. = ..()
	if(!repeatable)
		. += "器官必须受到中度损伤"

/datum/surgery_operation/organ/repair/all_blocked_strings()
	. = ..()
	if(!repeatable)
		. += "该器官此前未接受过手术修复"

/datum/surgery_operation/organ/repair/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	organ.set_organ_damage(organ.maxHealth * heal_to_percent)
	organ.organ_flags &= ~ORGAN_EMP
	ADD_TRAIT(organ, TRAIT_ORGAN_OPERATED_ON, TRAIT_GENERIC)

/datum/surgery_operation/organ/repair/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	organ.apply_organ_damage(organ.maxHealth * failure_damage_percent)

/datum/surgery_operation/organ/repair/lobectomy
	name = "切除受损肺叶"
	rnd_name = "肺叶切除术（肺部手术）"
	desc = "切除损伤最严重的肺叶，以修复病人受损的肺部。"
	implements = list(
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 1.5,
		/obj/item/knife = 2.25,
		/obj/item/shard = 2.85,
	)
	time = 4.2 SECONDS
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/organ1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	target_type = /obj/item/organ/lungs
	failure_damage_percent = 0.1

/datum/surgery_operation/organ/repair/lobectomy/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始在 [FORMAT_ORGAN_OWNER(organ)] 的肺部做切口……"),
		span_notice("[surgeon] 开始在 [FORMAT_ORGAN_OWNER(organ)] 身上做切口。"),
		span_notice("[surgeon] 开始在 [FORMAT_ORGAN_OWNER(organ)] 身上做切口。"),
	)
	display_pain(organ.owner, "你感到胸口一阵刺痛！")

/datum/surgery_operation/organ/repair/lobectomy/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功切除了 [FORMAT_ORGAN_OWNER(organ)] 损伤最严重的肺叶。"),
		span_notice("[surgeon] 成功切除了 [FORMAT_ORGAN_OWNER(organ)] 损伤最严重的肺叶。"),
		span_notice("[surgeon] 成功切除了 [FORMAT_ORGAN_OWNER(organ)] 损伤最严重的肺叶。"),
	)

/datum/surgery_operation/organ/repair/lobectomy/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	organ.owner?.losebreath += 4
	display_results(
		surgeon,
		organ.owner,
		span_warning("你搞砸了，没能切除 [FORMAT_ORGAN_OWNER(organ)] 受损的肺叶！"),
		span_warning("[surgeon] 搞砸了！"),
		span_warning("[surgeon] 搞砸了！"),
	)
	display_pain(organ.owner, "你感到胸口一阵锐利的刺痛；你的呼吸被打乱了，喘气都疼！")

/datum/surgery_operation/organ/repair/lobectomy/mechanic
	name = "进行维护"
	rnd_name = "空气过滤诊断（肺部手术）"
	implements = list(
		TOOL_WRENCH = 1.05,
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 1.5,
		/obj/item/knife = 2.25,
		/obj/item/shard = 2.85,
	)
	preop_sound = 'sound/items/tools/ratchet.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/organ/repair/hepatectomy
	name = "切除受损肝脏部分"
	rnd_name = "肝部分切除术（肝脏手术）"
	desc = "切除损伤最严重的部分，以修复病人受损的肝脏。"
	implements = list(
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 1.5,
		/obj/item/knife = 2.25,
		/obj/item/shard = 2.85,
	)
	time = 5.2 SECONDS
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/organ1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	target_type = /obj/item/organ/liver
	heal_to_percent = 0.1
	failure_damage_percent = 0.15

/datum/surgery_operation/organ/repair/hepatectomy/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始切下 [FORMAT_ORGAN_OWNER(organ)] 肝脏受损的一块……"),
		span_notice("[surgeon] 开始在 [FORMAT_ORGAN_OWNER(organ)] 身上做切口。"),
		span_notice("[surgeon] 开始在 [FORMAT_ORGAN_OWNER(organ)] 身上做切口。"),
	)
	display_pain(organ.owner, "你的腹部火辣辣地剧痛，像被刺穿一样！")

/datum/surgery_operation/organ/repair/hepatectomy/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功切除了 [FORMAT_ORGAN_OWNER(organ)] 肝脏受损的部分。"),
		span_notice("[surgeon] 成功切除了 [FORMAT_ORGAN_OWNER(organ)] 肝脏受损的部分。"),
		span_notice("[surgeon] 成功切除了 [FORMAT_ORGAN_OWNER(organ)] 肝脏受损的部分。"),
	)
	display_pain(organ.owner, "疼痛稍微减轻了一些！")

/datum/surgery_operation/organ/repair/hepatectomy/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("你切错了 [FORMAT_ORGAN_OWNER(organ)] 肝脏的部位！"),
		span_warning("[surgeon] 切错了 [FORMAT_ORGAN_OWNER(organ)] 肝脏的部位！"),
		span_warning("[surgeon] 切错了 [FORMAT_ORGAN_OWNER(organ)] 肝脏的部位！"),
	)
	display_pain(organ.owner, "你腹部的疼痛加剧了！")

/datum/surgery_operation/organ/repair/hepatectomy/mechanic
	name = "进行维护"
	rnd_name = "杂质管理系统诊断（肝脏手术）"
	implements = list(
		TOOL_WRENCH = 1.05,
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 1.5,
		/obj/item/knife = 2.25,
		/obj/item/shard = 2.85,
	)
	preop_sound = 'sound/items/tools/ratchet.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/organ/repair/coronary_bypass
	name = "搭桥冠状动脉旁路"
	rnd_name = "冠状动脉旁路移植术（心脏手术）"
	desc = "在病人受损的心脏上搭桥，以恢复正常的血液流动。"
	implements = list(
		TOOL_HEMOSTAT = 1.05,
		TOOL_WIRECUTTER = 2.85,
		/obj/item/stack/package_wrap = 6.67,
		/obj/item/stack/cable_coil = 2,
	)
	time = 9 SECONDS
	preop_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	success_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	target_type = /obj/item/organ/heart

/datum/surgery_operation/organ/repair/coronary_bypass/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始在 [FORMAT_ORGAN_OWNER(organ)] 的心脏上搭桥……"),
		span_notice("[surgeon] 开始在 [FORMAT_ORGAN_OWNER(organ)] 的心脏上搭桥。"),
		span_notice("[surgeon] 开始在 [FORMAT_ORGAN_OWNER(organ)] 的心脏上搭桥。"),
	)
	display_pain(organ.owner, "你胸口的疼痛无法忍受！你几乎撑不住了！")

/datum/surgery_operation/organ/repair/coronary_bypass/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功在 [FORMAT_ORGAN_OWNER(organ)] 的心脏上搭了桥。"),
		span_notice("[surgeon] 成功在 [FORMAT_ORGAN_OWNER(organ)] 的心脏上搭了桥。"),
		span_notice("[surgeon] 成功在 [FORMAT_ORGAN_OWNER(organ)] 的心脏上搭了桥。"),
	)
	display_pain(organ.owner, "你胸口阵阵作痛，但心脏感觉前所未有地好！")

/datum/surgery_operation/organ/repair/coronary_bypass/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	organ.bodypart_owner?.adjustBleedStacks(30)
	var/blood_name = LOWER_TEXT(organ.owner?.get_bloodtype()?.get_blood_name()) || "blood"
	display_results(
		surgeon,
		organ.owner,
		span_warning("你搭桥时搞砸了，移植物被扯掉，还撕裂了部分心脏！"),
		span_warning("[surgeon] 搞砸了，[chinese_scanner_label(blood_name)] 从 [FORMAT_ORGAN_OWNER(organ)] 的胸口大量喷涌而出！"),
		span_warning("[surgeon] 搞砸了，[chinese_scanner_label(blood_name)] 从 [FORMAT_ORGAN_OWNER(organ)] 的胸口大量喷涌而出！"),
	)
	display_pain(organ.owner, "你的胸口灼痛；你觉得自己快要疯了！")

/datum/surgery_operation/organ/repair/coronary_bypass/mechanic
	name = "接触引擎内部"
	rnd_name = "引擎诊断（心脏手术）"
	implements = list(
		TOOL_CROWBAR = 1.05,
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 1.5,
		/obj/item/knife = 2.25,
		/obj/item/shard = 2.85,
	)
	preop_sound = 'sound/items/tools/ratchet.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/organ/repair/gastrectomy
	name = "切除受损胃部"
	rnd_name = "胃部分切除术（胃部手术）"
	desc = "切除受损的部分，以修复病人的胃部。"
	implements = list(
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 1.5,
		/obj/item/knife = 2.25,
		/obj/item/shard = 2.85,
		/obj/item = 4,
	)
	time = 5.2 SECONDS
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/organ1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	target_type = /obj/item/organ/stomach
	heal_to_percent = 0.2
	failure_damage_percent = 0.15

/datum/surgery_operation/organ/repair/gastrectomy/get_any_tool()
	return "任意带刃物品"

/datum/surgery_operation/organ/repair/gastrectomy/tool_check(obj/item/tool)
	// Require edged sharpness OR a tool behavior match
	return ((tool.get_sharpness() & SHARP_EDGED) || implements[tool.tool_behaviour])

/datum/surgery_operation/organ/repair/gastrectomy/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始切下 [FORMAT_ORGAN_OWNER(organ)] 胃部受损的一块……"),
		span_notice("[surgeon] 开始在 [FORMAT_ORGAN_OWNER(organ)] 身上做切口。"),
		span_notice("[surgeon] 开始在 [FORMAT_ORGAN_OWNER(organ)] 身上做切口。"),
	)
	display_pain(organ.owner, "你感到腹部一阵可怕的刺痛！")

/datum/surgery_operation/organ/repair/gastrectomy/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功切除了 [FORMAT_ORGAN_OWNER(organ)] 胃部受损的部分。"),
		span_notice("[surgeon] 成功切除了 [FORMAT_ORGAN_OWNER(organ)] 胃部受损的部分。"),
		span_notice("[surgeon] 成功切除了 [FORMAT_ORGAN_OWNER(organ)] 胃部受损的部分。"),
	)
	display_pain(organ.owner, "你腹部的疼痛稍微减轻了一些！")

/datum/surgery_operation/organ/repair/gastrectomy/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("你切错了 [FORMAT_ORGAN_OWNER(organ)] 胃部的部位！"),
		span_warning("[surgeon] 切错了 [FORMAT_ORGAN_OWNER(organ)] 胃部的部位！"),
		span_warning("[surgeon] 切错了 [FORMAT_ORGAN_OWNER(organ)] 胃部的部位！"),
	)
	display_pain(organ.owner, "你腹部的疼痛加剧了！")

/datum/surgery_operation/organ/repair/gastrectomy/mechanic
	name = "进行维护"
	rnd_name = "营养处理系统诊断（胃部手术）"
	implements = list(
		TOOL_WRENCH = 1.05,
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 1.5,
		/obj/item/knife = 2.25,
		/obj/item/shard = 2.85,
		/obj/item = 4,
	)
	preop_sound = 'sound/items/tools/ratchet.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/organ/repair/ears
	name = "耳部手术"
	rnd_name = "耳切开术（耳部手术）" // source: i made it up
	desc = "修复病人受损的耳朵，以恢复听力。"
	operation_flags = parent_type::operation_flags & ~OPERATION_AFFECTS_MOOD
	implements = list(
		TOOL_HEMOSTAT = 1.05,
		TOOL_SCREWDRIVER = 2.25,
		/obj/item/pen = 4,
	)
	target_type = /obj/item/organ/ears
	time = 6.4 SECONDS
	heal_to_percent = 0
	repeatable = TRUE
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/organ/repair/ears/all_blocked_strings()
	return ..() + list("若该肢体有骨骼，则骨骼必须完好")

/datum/surgery_operation/organ/repair/ears/state_check(obj/item/organ/ears/organ)
	// If bones are sawed, prevent the operation (unless we're operating on a limb with no bones)
	if(LIMB_HAS_ANY_SURGERY_STATE(organ.bodypart_owner, SURGERY_BONE_SAWED|SURGERY_BONE_DRILLED) && LIMB_HAS_BONES(organ.bodypart_owner))
		return FALSE
	return TRUE // always available so you can intentionally fail it

/datum/surgery_operation/organ/repair/ears/on_preop(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始修复 [FORMAT_ORGAN_OWNER(organ)] 的耳朵……"),
		span_notice("[surgeon] 开始修复 [FORMAT_ORGAN_OWNER(organ)] 的耳朵。"),
		span_notice("[surgeon] 开始对 [FORMAT_ORGAN_OWNER(organ)] 的耳朵施行手术。"),
	)
	display_pain(organ.owner, "你感到头部一阵令人眩晕的疼痛！")

/datum/surgery_operation/organ/repair/ears/on_success(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	var/deaf_change = 40 SECONDS - organ.temporary_deafness
	organ.adjust_temporary_deafness(deaf_change)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功修复了 [FORMAT_ORGAN_OWNER(organ)] 的耳朵。"),
		span_notice("[surgeon] 成功修复了 [FORMAT_ORGAN_OWNER(organ)] 的耳朵。"),
		span_notice("[surgeon] 成功修复了 [FORMAT_ORGAN_OWNER(organ)] 的耳朵。"),
	)
	display_pain(organ.owner, "你的头一阵眩晕，但似乎能感觉到听力正在恢复！")

/datum/surgery_operation/organ/repair/ears/on_failure(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/obj/item/organ/brain/brain = locate() in organ.bodypart_owner
	if(isnull(brain))
		display_results(
			surgeon,
			organ.owner,
			span_warning("你不小心一刀扎进了 [FORMAT_ORGAN_OWNER(organ)] 的大脑！如果 [FORMAT_ORGAN_OWNER(organ)] 有大脑的话。"),
			span_warning("[surgeon] 不小心一刀扎进了 [FORMAT_ORGAN_OWNER(organ)] 的大脑！如果 [FORMAT_ORGAN_OWNER(organ)] 有大脑的话。"),
			span_warning("[surgeon] 不小心一刀扎进了 [FORMAT_ORGAN_OWNER(organ)] 的大脑！"),
		)
		return

	display_results(
		surgeon,
		organ.owner,
		span_warning("你不小心一刀扎进了 [FORMAT_ORGAN_OWNER(organ)] 的大脑！"),
		span_warning("[surgeon] 不小心一刀扎进了 [FORMAT_ORGAN_OWNER(organ)] 的大脑！"),
		span_warning("[surgeon] 不小心一刀扎进了 [FORMAT_ORGAN_OWNER(organ)] 的大脑！"),
	)
	display_pain(organ.owner, "你感到一阵深入骨髓的刺痛，直穿头部刺入大脑！")
	organ.apply_organ_damage(70)

/datum/surgery_operation/organ/repair/eyes
	name = "眼部手术"
	rnd_name = "玻璃体切除术（眼部手术）"
	desc = "修复病人受损的眼睛，以恢复视力。"
	operation_flags = parent_type::operation_flags & ~OPERATION_AFFECTS_MOOD
	implements = list(
		TOOL_HEMOSTAT = 1.05,
		TOOL_SCREWDRIVER = 2.25,
		/obj/item/pen = 4,
	)
	time = 6.4 SECONDS
	target_type = /obj/item/organ/eyes
	heal_to_percent = 0
	repeatable = TRUE
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/organ/repair/eyes/all_blocked_strings()
	return ..() + list("若该肢体有骨骼，则骨骼必须完好")

/datum/surgery_operation/organ/repair/eyes/state_check(obj/item/organ/organ)
	// If bones are sawed, prevent the operation (unless we're operating on a limb with no bones)
	if(LIMB_HAS_ANY_SURGERY_STATE(organ.bodypart_owner, SURGERY_BONE_SAWED|SURGERY_BONE_DRILLED) && LIMB_HAS_BONES(organ.bodypart_owner))
		return FALSE
	return TRUE // always available so you can intentionally fail it

/datum/surgery_operation/organ/repair/eyes/get_default_radial_image()
	return image(icon = 'icons/obj/medical/surgery_ui.dmi', icon_state = "surgery_eyes")

/datum/surgery_operation/organ/repair/eyes/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始修复 [FORMAT_ORGAN_OWNER(organ)] 的眼睛……"),
		span_notice("[surgeon] 开始修复 [FORMAT_ORGAN_OWNER(organ)] 的眼睛。"),
		span_notice("[surgeon] 开始对 [FORMAT_ORGAN_OWNER(organ)] 的眼睛施行手术。"),
	)
	display_pain(organ.owner, "你感到眼睛一阵刺痛！")

/datum/surgery_operation/organ/repair/eyes/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	organ.owner?.remove_status_effect(/datum/status_effect/temporary_blindness)
	organ.owner?.set_eye_blur_if_lower(70 SECONDS) //this will fix itself slowly.
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功修复了 [FORMAT_ORGAN_OWNER(organ)] 的眼睛。"),
		span_notice("[surgeon] 成功修复了 [FORMAT_ORGAN_OWNER(organ)] 的眼睛。"),
		span_notice("[surgeon] 成功修复了 [FORMAT_ORGAN_OWNER(organ)] 的眼睛。"),
	)
	display_pain(organ.owner, "你的视线变得模糊，但似乎现在能看得更清楚一些了！")

/datum/surgery_operation/organ/repair/eyes/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/obj/item/organ/brain/brain = locate() in organ.bodypart_owner
	if(isnull(brain))
		display_results(
			surgeon,
			organ.owner,
			span_warning("你不小心一刀扎进了 [FORMAT_ORGAN_OWNER(organ)] 的大脑！如果 [FORMAT_ORGAN_OWNER(organ)] 有大脑的话。"),
			span_warning("[surgeon] 不小心一刀扎进了 [FORMAT_ORGAN_OWNER(organ)] 的大脑！如果 [FORMAT_ORGAN_OWNER(organ)] 有大脑的话。"),
			span_warning("[surgeon] 不小心一刀扎进了 [FORMAT_ORGAN_OWNER(organ)] 的大脑！"),
		)
		return

	display_results(
		surgeon,
		organ.owner,
		span_warning("你不小心一刀扎进了 [FORMAT_ORGAN_OWNER(organ)] 的大脑！"),
		span_warning("[surgeon] 不小心一刀扎进了 [FORMAT_ORGAN_OWNER(organ)] 的大脑！"),
		span_warning("[surgeon] 不小心一刀扎进了 [FORMAT_ORGAN_OWNER(organ)] 的大脑！"),
	)
	display_pain(organ.owner, "你感到一阵深入骨髓的刺痛，直穿头部刺入大脑！")
	organ.apply_organ_damage(70)

/datum/surgery_operation/organ/repair/brain
	name = "脑部手术"
	rnd_name = "神经外科手术（脑部手术）"
	desc = "修复病人受损的脑组织，以恢复认知功能。"
	implements = list(
		TOOL_HEMOSTAT = 1.05,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	time = 10 SECONDS
	preop_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	success_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	operation_flags = parent_type::operation_flags | OPERATION_LOOPING
	target_type = /obj/item/organ/brain
	heal_to_percent = 0.25
	failure_damage_percent = 0.3
	repeatable = TRUE
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_BONE_SAWED
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/organ/repair/brain/state_check(obj/item/organ/brain/organ)
	return TRUE // always available so you can intentionally fail it

/datum/surgery_operation/organ/repair/brain/on_preop(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始修复 [FORMAT_ORGAN_OWNER(organ)] 的大脑……"),
		span_notice("[surgeon] 开始修复 [FORMAT_ORGAN_OWNER(organ)] 的大脑。"),
		span_notice("[surgeon] 开始对 [FORMAT_ORGAN_OWNER(organ)] 的大脑施行手术。"),
	)
	display_pain(organ.owner, "你的头阵阵作痛，痛得难以想象！")

/datum/surgery_operation/organ/repair/brain/on_success(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	organ.apply_organ_damage(-organ.maxHealth * heal_to_percent) // no parent call, special healing for this one
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功修复了 [FORMAT_ORGAN_OWNER(organ)] 的大脑。"),
		span_notice("[surgeon] 成功修复了 [FORMAT_ORGAN_OWNER(organ)] 的大脑！"),
		span_notice("[surgeon] 完成了对 [FORMAT_ORGAN_OWNER(organ)] 大脑的手术。"),
	)
	display_pain(organ.owner, "你头部的疼痛减轻了，思考变得稍微容易了一些！")
	if (organ.owner)
		organ.owner.mind?.remove_antag_datum(/datum/antagonist/brainwashed)
	else if (organ.brainmob)
		organ.brainmob.mind?.remove_antag_datum(/datum/antagonist/brainwashed)
	organ.cure_all_traumas(TRAUMA_RESILIENCE_SURGERY)
	if(organ.damage > organ.maxHealth * 0.1)
		to_chat(surgeon, "[FORMAT_ORGAN_OWNER(organ)] 的大脑看起来还能进一步修复。")

/datum/surgery_operation/organ/repair/brain/on_failure(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("你搞砸了，造成了更多损伤！"),
		span_warning("[surgeon] 搞砸了，造成了脑损伤！"),
		span_notice("[surgeon] 完成了对 [FORMAT_ORGAN_OWNER(organ)] 大脑的手术。"),
	)
	display_pain(organ.owner, "你的头部阵阵剧痛；连思考都疼！")
	organ.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)

/datum/surgery_operation/organ/repair/brain/mechanic
	name = "执行神经调试"
	rnd_name = "湿件操作系统诊断（脑部手术）"
	implements = list(
		TOOL_MULTITOOL = 1.15,
		TOOL_HEMOSTAT = 1.05,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
