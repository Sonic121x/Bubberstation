/datum/surgery_operation/organ/lobotomy
	name = "施行脑白质切除术"
	rnd_name = "脑白质切除术（脑白质切除）"
	desc = "修复病人的大部分脑部创伤，但有可能造成新的永久性创伤。"
	rnd_desc = "一种侵入性手术，几乎可以确保清除所有脑部创伤，但可能因此造成另一处永久性创伤。"
	operation_flags = OPERATION_MORBID | OPERATION_AFFECTS_MOOD | OPERATION_LOCKED | OPERATION_NOTABLE | OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		TOOL_SCALPEL = 1.15,
		/obj/item/melee/energy/sword = 0.55,
		/obj/item/knife = 2.85,
		/obj/item/shard = 4,
		/obj/item = 5,
	)
	target_type = /obj/item/organ/brain
	required_organ_flag = ORGAN_TYPE_FLAGS & ~ORGAN_ROBOTIC
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/scalpel2.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_BONE_SAWED
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/organ/lobotomy/get_any_tool()
	return "任意带刃物品"

/datum/surgery_operation/organ/lobotomy/tool_check(obj/item/tool)
	// Require edged sharpness OR a tool behavior match
	return ((tool.get_sharpness() & SHARP_EDGED) || implements[tool.tool_behaviour])

/datum/surgery_operation/organ/lobotomy/on_preop(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始对 [FORMAT_ORGAN_OWNER(organ)] 的大脑施行脑白质切除术……"),
		span_notice("[surgeon] 开始对 [FORMAT_ORGAN_OWNER(organ)] 的大脑施行脑白质切除术。"),
		span_notice("[surgeon] 开始对 [FORMAT_ORGAN_OWNER(organ)] 的大脑施行手术。"),
	)
	display_pain(organ.owner, "你的头阵阵作痛，痛得难以想象！")

/datum/surgery_operation/organ/lobotomy/on_success(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功对 [FORMAT_ORGAN_OWNER(organ)] 施行了脑白质切除术！"),
		span_notice("[surgeon] 成功对 [FORMAT_ORGAN_OWNER(organ)] 施行了脑白质切除术！"),
		span_notice("[surgeon] 完成了对 [FORMAT_ORGAN_OWNER(organ)] 大脑的手术。"),
	)
	display_pain(organ.owner, "你的头有一瞬间完全麻木了，疼痛铺天盖地！")

	organ.cure_all_traumas(TRAUMA_RESILIENCE_LOBOTOMY)
	if (organ.owner)
		organ.owner.mind?.remove_antag_datum(/datum/antagonist/brainwashed)
	else if (organ.brainmob)
		organ.brainmob.mind?.remove_antag_datum(/datum/antagonist/brainwashed)

	if(!prob(75))
		return

	switch(rand(1, 3))//Now let's see what hopefully-not-important part of the brain we cut off
		if(1)
			organ.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_MAGIC)
		if(2)
			if(HAS_TRAIT(organ, TRAIT_SPECIAL_TRAUMA_BOOST) && prob(50))
				organ.gain_trauma_type(BRAIN_TRAUMA_SPECIAL, TRAUMA_RESILIENCE_MAGIC)
			else
				organ.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_MAGIC)
		if(3)
			organ.gain_trauma_type(BRAIN_TRAUMA_SPECIAL, TRAUMA_RESILIENCE_MAGIC)

/datum/surgery_operation/organ/lobotomy/on_failure(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_warning("你切错了部位，造成了更多损伤！"),
		span_notice("[surgeon] 试图对 [FORMAT_ORGAN_OWNER(organ)] 施行脑白质切除术，但失败了！"),
		span_notice("[surgeon] 完成了对 [FORMAT_ORGAN_OWNER(organ)] 大脑的手术。"),
	)
	display_pain(organ.owner, "你头部的疼痛似乎只是越来越严重了！")
	organ.apply_organ_damage(80)
	switch(rand(1, 3))
		if(1)
			organ.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_MAGIC)
		if(2)
			if(HAS_TRAIT(organ, TRAIT_SPECIAL_TRAUMA_BOOST) && prob(50))
				organ.gain_trauma_type(BRAIN_TRAUMA_SPECIAL, TRAUMA_RESILIENCE_MAGIC)
			else
				organ.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_MAGIC)
		if(3)
			organ.gain_trauma_type(BRAIN_TRAUMA_SPECIAL, TRAUMA_RESILIENCE_MAGIC)

/datum/surgery_operation/organ/lobotomy/mechanic
	name = "执行神经碎片整理"
	rnd_name = "湿件操作系统破坏性碎片整理（脑白质切除）"
	implements = list(
		TOOL_MULTITOOL = 1.15,
		/obj/item/melee/energy/sword = 1.85,
		/obj/item/knife = 2.85,
		/obj/item/shard = 4,
		/obj/item = 5,
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
