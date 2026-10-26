/datum/surgery_operation/organ/asthmatic_bypass
	name = "强行撑开气管"
	// google says the *actual* operation used to relieve asthma is called bronchial thermoplasty but this operation doesn't resemble that at all
	// local doctors suggested "bronchial dilatation" instead
	rnd_name = "支气管扩张术（哮喘绕行）"
	desc = "强行扩张病人的气管，缓解哮喘症状。"
	operation_flags = OPERATION_PRIORITY_NEXT_STEP
	implements = list(
		TOOL_RETRACTOR = 1.25,
		TOOL_WIRECUTTER = 2.25,
	)
	time = 8 SECONDS
	preop_sound = 'sound/items/handling/surgery/retractor1.ogg'
	success_sound = 'sound/items/handling/surgery/retractor2.ogg'
	target_type = /obj/item/organ/lungs
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT
	/// The amount of inflammation a failure or success of this surgery will reduce.
	var/inflammation_reduction = 75

/datum/surgery_operation/organ/asthmatic_bypass/all_required_strings()
	return list("病人必须患有哮喘") + ..()

/datum/surgery_operation/organ/asthmatic_bypass/state_check(obj/item/organ/organ)
	if(!organ.owner.has_quirk(/datum/quirk/item_quirk/asthma))
		return FALSE
	return TRUE

/datum/surgery_operation/organ/asthmatic_bypass/on_preop(obj/item/organ/lungs/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始撑开[organ.owner]的气管，尽力避开附近的血管……"),
		span_notice("[surgeon] 开始撑开[organ.owner]的气管，小心地避开附近的血管。"),
		span_notice("[surgeon] 开始撑开[organ.owner]的气管。"),
	)
	display_pain(organ.owner, "你的颈部传来一阵痛苦的拉伸感！")

/datum/surgery_operation/organ/asthmatic_bypass/on_success(obj/item/organ/lungs/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/datum/quirk/item_quirk/asthma/asthma = organ.owner.get_quirk(/datum/quirk/item_quirk/asthma)
	if(isnull(asthma))
		return

	asthma.adjust_inflammation(-inflammation_reduction)

	display_results(
		surgeon,
		organ.owner,
		span_notice("你用 [tool] 撑开了[organ.owner]的气管，成功避开了附近的血管。"),
		span_notice("[surgeon] 用 [tool] 成功撑开了[organ.owner]的气管，避开了附近的血管。"),
		span_notice("[surgeon] 完成了[organ.owner]气管的撑开。")
	)

/datum/surgery_operation/organ/asthmatic_bypass/on_failure(obj/item/organ/lungs/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/datum/quirk/item_quirk/asthma/asthma = organ.owner.get_quirk(/datum/quirk/item_quirk/asthma)
	if(isnull(asthma))
		return

	asthma.adjust_inflammation(-inflammation_reduction)

	display_results(
		surgeon,
		organ.owner,
		span_warning("你用 [tool] 撑开了[organ.owner]的气管，却不小心剪到了几根动脉！"),
		span_warning("[surgeon] 成功撑开了[organ.owner]的气管，却不小心剪到了几根动脉！"),
		span_warning("[surgeon] 完成了[organ.owner]气管的撑开，但搞砸了！"),
	)

	organ.owner.losebreath++

	if(prob(30))
		organ.owner.cause_wound_of_type_and_severity(WOUND_SLASH, organ.bodypart_owner, WOUND_SEVERITY_MODERATE, WOUND_SEVERITY_CRITICAL, WOUND_PICK_LOWEST_SEVERITY, tool)
	organ.bodypart_owner.receive_damage(brute = 10, wound_bonus = tool.wound_bonus, sharpness = SHARP_EDGED, damage_source = tool)
