/datum/surgery_operation/limb/filter_blood
	name = "血液过滤"
	rnd_name = "血液透析（血液过滤）"
	desc = "清除病人血液中不需要的化学物质。"
	implements = list(/obj/item/blood_filter = 1)
	time = 2.5 SECONDS
	operation_flags = OPERATION_LOOPING
	required_bodytype = (~BODYTYPE_ROBOTIC & ~BODYTYPE_SYNTHETIC) // NOVA EDIT CHANGE - SYNTH FLAGS  -Original: required_bodytype = ~BODYTYPE_ROBOTIC
	success_sound = 'sound/machines/card_slide.ogg'
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/limb/filter_blood/all_required_strings()
	. = list()
	. += "对胸部施行手术（目标：胸部）"
	. += ..()
	. += "病人不能已成焦尸"

/datum/surgery_operation/limb/filter_blood/get_default_radial_image()
	return image(/obj/item/blood_filter)

/datum/surgery_operation/limb/filter_blood/state_check(obj/item/bodypart/limb)
	return limb.body_zone == BODY_ZONE_CHEST && !HAS_TRAIT(limb.owner, TRAIT_HUSK)

/datum/surgery_operation/limb/filter_blood/can_loop(mob/living/patient, obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	return ..() && has_filterable_chems(limb.owner, tool)

/datum/surgery_operation/limb/filter_blood/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_pain(limb.owner, "你感到胸口传来阵阵抽痛！")

/datum/surgery_operation/limb/filter_blood/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	var/obj/item/blood_filter/bloodfilter = tool
	for(var/datum/reagent/chem as anything in limb.owner.reagents?.reagent_list)
		if(!length(bloodfilter.whitelist) || !(chem.type in bloodfilter.whitelist))
			limb.owner.reagents.remove_reagent(chem.type, clamp(round(chem.volume * 0.22, 0.2), 0.4, 10))
	limb.owner.adjust_tox_loss(clamp(round(limb.owner.get_tox_loss() * -0.07, 2), -2, -10), forced = TRUE) // BUBBER EDIT ADDITION - Filtration fixes toxins
	display_results(
		surgeon,
		limb.owner,
		span_notice("[tool] 完成了一次循环，过滤了 [limb.owner] 的血液。"),
		span_notice("[tool] 嗡嗡作响，过滤着 [limb.owner] 的血液。"),
		span_notice("[tool] 嗡嗡作响，泵动着。"),
	)

	if(surgeon.is_holding_item_of_type(/obj/item/healthanalyzer))
		chemscan(surgeon, limb.owner)

/datum/surgery_operation/limb/filter_blood/on_failure(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_warning("你搞砸了，撞伤了 [limb.owner] 的胸部！"),
		span_warning("[surgeon] 搞砸了，撞伤了 [limb.owner] 的胸部！"),
		span_warning("[surgeon] 搞砸了！"),
	)
	limb.receive_damage(5, damage_source = tool)

/datum/surgery_operation/limb/filter_blood/proc/has_filterable_chems(mob/living/carbon/target, obj/item/blood_filter/bloodfilter)
	// BUBBER EDIT ADDITION BEGIN - Filtration fixes toxins
	if(target.get_tox_loss() > 0)
		return TRUE
	// BUBBER EDIT ADDITION END
	if(!length(target.reagents?.reagent_list))
		bloodfilter.audible_message(span_notice("[bloodfilter] 发出提示音，报告在 [target] 的血液中未检测到化学物质。"))
		playsound(target, 'sound/machines/ping.ogg', 75, TRUE, falloff_exponent = 12, falloff_distance = 1)
		return FALSE

	if(!length(bloodfilter.whitelist))
		return TRUE

	for(var/datum/reagent/chem as anything in target.reagents.reagent_list)
		if(chem.type in bloodfilter.whitelist)
			return TRUE

	return FALSE

/datum/surgery_operation/limb/filter_blood/mechanic
	name = "冲洗液压系统"
	rnd_name = "液压系统冲洗（血液过滤）"
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
