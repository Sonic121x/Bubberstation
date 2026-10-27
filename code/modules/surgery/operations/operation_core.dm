/datum/surgery_operation/basic/core_removal
	name = "提取核心"
	rnd_name = "核心摘除术（提取核心）" // source: i made it up
	desc = "从史莱姆体内取出核心。"
	implements = list(
		TOOL_HEMOSTAT = 1,
		TOOL_CROWBAR = 1,
	)
	time = 1.6 SECONDS
	operation_flags = OPERATION_IGNORE_CLOTHES | OPERATION_STANDING_ALLOWED
	any_surgery_states_required = ALL_SURGERY_SKIN_STATES
	required_biotype = NONE

/datum/surgery_operation/basic/core_removal/get_default_radial_image()
	return image(/mob/living/basic/slime)

/datum/surgery_operation/basic/core_removal/all_required_strings()
	return list("对已死亡的史莱姆施术") + ..()

/datum/surgery_operation/basic/core_removal/state_check(mob/living/patient)
	return isslime(patient) && patient.stat == DEAD

/datum/surgery_operation/basic/core_removal/on_preop(mob/living/basic/slime/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		patient,
		span_notice("你开始提取[patient]的核心……"),
		span_notice("[surgeon] 开始提取[patient]的核心。"),
		span_notice("[surgeon] 开始提取[patient]的核心。"),
	)

/datum/surgery_operation/basic/core_removal/on_success(mob/living/basic/slime/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/core_count = patient.cores
	if(core_count && patient.try_extract_cores(count = core_count))
		display_results(
			surgeon,
			patient,
			span_notice("你成功从[patient]体内取出了 [core_count] 个核心。"),
			span_notice("[surgeon] 成功从[patient]体内取出了 [core_count] 个核心！"),
			span_notice("[surgeon] 成功从[patient]体内取出了 [core_count] 个核心！"),
		)
	else
		to_chat(surgeon, span_warning("[patient] 体内已经没有核心了！"))
