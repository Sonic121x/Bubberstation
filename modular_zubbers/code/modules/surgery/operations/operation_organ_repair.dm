/datum/surgery_operation/organ/repair/brain/advanced
	name = "创伤手术"
	rnd_name = "神经切除术（高级脑部手术）"
	desc = "一种侵入性外科手术，可确保移除根深蒂固的脑创伤，但身体需要一段时间才能恢复……"
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_NOTABLE | OPERATION_PRIORITY_NEXT_STEP
	time = 15 SECONDS
	implements = list(
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 0.55,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	var/resilience_level = TRAUMA_RESILIENCE_LOBOTOMY
	var/datum/reagent/reagent_1_type = /datum/reagent/medicine/neurine
	var/reagent_1_amount = 3
	var/datum/reagent/reagent_2_type
	var/reagent_2_amount

/datum/surgery_operation/organ/repair/brain/advanced/all_required_strings()
	if(!isnull(reagent_2_type))
		return ..() + list("患者必须摄入至少 [reagent_1_amount]u 的 [reagent_1_type.name]", "患者必须摄入至少 [reagent_2_amount]u 的 [reagent_2_type.name]")
	else
		return ..() + list("患者必须摄入至少 [reagent_1_amount]u 的 [reagent_1_type.name]")

/datum/surgery_operation/organ/repair/brain/advanced/state_check(obj/item/organ/brain/organ)
	var/mob/living/carbon/human/brain_owner = organ.owner
	if(!istype(brain_owner))
		return FALSE

	var/max_trauma_level = 0
	if(length(brain_owner.get_traumas()))
		for(var/active_trauma in brain_owner.get_traumas())
			var/datum/brain_trauma/trauma = active_trauma
			if(trauma.resilience > max_trauma_level)
				max_trauma_level = trauma.resilience
		if(max_trauma_level == resilience_level)
			return TRUE

	return FALSE

/datum/surgery_operation/organ/repair/brain/advanced/pre_preop(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/obj/item/organ/brain/human_brain = operating_on
	var/mob/living/carbon/human/brain_owner = human_brain.owner
	if(brain_owner.reagents?.get_reagent_amount(reagent_1_type) < reagent_1_amount)
		surgeon.balloon_alert(surgeon, "缺少 [LOWER_TEXT(reagent_1_type.name)]！")
		return FALSE

	if(reagent_2_type && (brain_owner.reagents?.get_reagent_amount(reagent_2_type) < reagent_2_amount))
		surgeon.balloon_alert(surgeon, "缺少 [LOWER_TEXT(reagent_2_type.name)]！")
		return FALSE

	surgeon.balloon_alert_to_viewers("正在施用药物……", vision_distance = COMBAT_MESSAGE_RANGE)
	if(do_after(surgeon, 1.5 SECONDS))
		return TRUE

	return FALSE

/datum/surgery_operation/organ/repair/brain/advanced/on_preop(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始切除 [FORMAT_ORGAN_OWNER(organ)] 脑中的坏死神经……"),
		span_notice("[surgeon] 开始修复 [FORMAT_ORGAN_OWNER(organ)] 的大脑。"),
		span_notice("[surgeon] 开始对 [FORMAT_ORGAN_OWNER(organ)] 的大脑进行手术。"),
	)
	display_pain(organ.owner, "你的意识仿佛正在被碎片整理！")

/datum/surgery_operation/organ/repair/brain/advanced/on_success(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功切除了 [FORMAT_ORGAN_OWNER(organ)] 的坏死神经，治愈了创伤。"),
		span_notice("[surgeon] 成功治愈了 [FORMAT_ORGAN_OWNER(organ)] 的创伤！"),
		span_notice("[surgeon] 完成了对 [FORMAT_ORGAN_OWNER(organ)] 大脑的手术。"),
	)
	display_pain(organ.owner, "你的意识又恢复正常了。至少和以前一样正常。")
	for(var/i in TRAUMA_RESILIENCE_BASIC to resilience_level)
		if(i == TRAUMA_RESILIENCE_WOUND)
			continue
		organ.cure_all_traumas(i)

	organ.owner.apply_status_effect(/datum/status_effect/vulnerable_to_damage/surgery)

/datum/surgery_operation/organ/repair/brain/advanced/on_failure(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("你搞砸了，造成了更多损伤！"),
		span_warning("[surgeon] 搞砸了，造成了脑损伤！"),
		span_notice("[surgeon] 完成了对 [FORMAT_ORGAN_OWNER(organ)] 大脑的手术。"),
	)
	display_pain(organ.owner, "哦不……感觉事情的发展不太对劲……")
	if(resilience_level == TRAUMA_RESILIENCE_MAGIC)
		organ.owner.adjust_oxy_loss(200)
	else
		organ.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_MAGIC)

/datum/surgery_operation/organ/repair/brain/advanced/mechanic
	name = "触发创伤调试"
	rnd_name = "神经碎片整理（神经切除术）"
	implements = list(
		TOOL_MULTITOOL = 1.15,
		TOOL_SCALPEL = 1.05,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	reagent_1_type = /datum/reagent/medicine/liquid_solder

/datum/surgery_operation/organ/repair/brain/advanced/blessed
	name = "祝福创伤手术"
	rnd_name = "受祝神经切除术（受祝高级脑部手术）"
	desc = "我们不太确定它究竟是如何起作用的，但借助牧师的祝福与现代化学药剂，它能够移除曾被认为是魔法的、与灵魂绑定的创伤。"
	success_sound = 'sound/effects/magic/repulse.ogg'
	resilience_level = TRAUMA_RESILIENCE_MAGIC
	reagent_2_type = /datum/reagent/water/holywater
	reagent_2_amount = 1

/datum/surgery_operation/organ/repair/brain/advanced/blessed/mechanic
	name = "触发上帝模式创伤调试"
	rnd_name = "神圣碎片整理（受祝神经切除术）"
	implements = list(
		TOOL_MULTITOOL = 1.15,
		TOOL_HEMOSTAT = 1.05,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	reagent_1_type = /datum/reagent/medicine/liquid_solder
