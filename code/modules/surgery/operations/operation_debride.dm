/datum/surgery_operation/limb/debride
	name = "清除感染血肉"
	rnd_name = "清创术"
	desc = "清除病人伤口中感染或坏死的血肉，以促进愈合。"
	implements = list(
		TOOL_HEMOSTAT = 1,
		TOOL_SCALPEL = 1.25,
		TOOL_SAW = 1.66,
		TOOL_WIRECUTTER = 2.5,
	)
	time = 3 SECONDS
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_LOOPING | OPERATION_PRIORITY_NEXT_STEP | OPERATION_NO_PATIENT_REQUIRED
	preop_sound = list(
		TOOL_SCALPEL = 'sound/items/handling/surgery/scalpel1.ogg',
		TOOL_HEMOSTAT = 'sound/items/handling/surgery/hemostat1.ogg',
	)
	success_sound = 'sound/items/handling/surgery/retractor2.ogg'
	failure_sound = 'sound/items/handling/surgery/organ1.ogg'

	/// How much infestation is removed per step (positive number)
	var/infestation_removed = 4
	/// How much sanitization is added per step
	var/sanitization_added = 0.5 // just enough to stop infestation from worsening

/datum/surgery_operation/limb/debride/get_time_modifiers(obj/item/bodypart/limb, mob/living/surgeon, tool)
	. = ..()
	for(var/datum/wound/burn/flesh/wound in limb.wounds)
		if(HAS_TRAIT(wound, TRAIT_WOUND_SCANNED))
			. *= 0.5

/datum/surgery_operation/limb/debride/get_default_radial_image()
	return image(/obj/item/reagent_containers/applicator/patch/aiuri)

/datum/surgery_operation/limb/debride/all_required_strings()
	return list("该肢体必须有二度或更严重的烧伤") + ..()

/datum/surgery_operation/limb/debride/state_check(obj/item/bodypart/limb)
	var/datum/wound/burn/flesh/wound = locate() in limb.wounds
	return wound?.infection > 0

/// To give the surgeon a heads up how much work they have ahead of them
/datum/surgery_operation/limb/debride/proc/get_progress(datum/wound/burn/flesh/wound)
	if(wound?.infection <= 0)
		return null

	var/estimated_remaining_steps = wound.infection / infestation_removed
	var/progress_text

	switch(estimated_remaining_steps)
		if(-INFINITY to 1)
			return null
		if(1 to 2)
			progress_text = "，正准备清除最后残留的一点感染"
		if(2 to 4)
			progress_text = "，逐步缩小剩余的感染范围"
		if(5 to INFINITY)
			progress_text = "，不过还有相当多的组织需要切除"

	return progress_text

/datum/surgery_operation/limb/debride/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始从 [FORMAT_LIMB_OWNER(limb)] 上切除感染的血肉……"),
		span_notice("[surgeon] 开始用 [tool] 从 [FORMAT_LIMB_OWNER(limb)] 上切除感染的血肉。"),
		span_notice("[surgeon] 开始从 [FORMAT_LIMB_OWNER(limb)] 上切除感染的血肉。"),
	)
	display_pain(limb.owner, "你[chinese_body_zone_display(limb.plaintext_zone)]上的感染处剧痛无比！感觉就像被刀捅了一样！")

/datum/surgery_operation/limb/debride/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args, default_display_results = FALSE)
	limb.receive_damage(3, wound_bonus = CANT_WOUND, sharpness = tool.get_sharpness(), damage_source = tool)
	var/datum/wound/burn/flesh/wound = locate() in limb.wounds
	wound?.infection -= infestation_removed
	wound?.sanitization += sanitization_added
	display_results(
		surgeon,
		limb.owner,
		span_notice("你成功从 [FORMAT_LIMB_OWNER(limb)] 上切除了一些感染的血肉[get_progress(wound)]。"),
		span_notice("[surgeon] 成功用 [tool] 从 [FORMAT_LIMB_OWNER(limb)] 上切除了一些感染的血肉！"),
		span_notice("[surgeon] 成功从 [FORMAT_LIMB_OWNER(limb)] 上切除了一些感染的血肉！"),
	)

/datum/surgery_operation/limb/debride/on_failure(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你从 [FORMAT_LIMB_OWNER(limb)] 上削掉了一些健康的血肉。"),
		span_notice("[surgeon] 用 [tool] 从 [FORMAT_LIMB_OWNER(limb)] 上削掉了一些健康的血肉！"),
		span_notice("[surgeon] 从 [FORMAT_LIMB_OWNER(limb)] 上削掉了一些健康的血肉！"),
	)
	limb.receive_damage(rand(4, 8), wound_bonus = CANT_WOUND, sharpness = tool.get_sharpness(), damage_source = tool)
