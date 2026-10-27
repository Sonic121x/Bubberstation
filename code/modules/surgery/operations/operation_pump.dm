/datum/surgery_operation/organ/stomach_pump
	name = "洗胃"
	rnd_name = "胃灌洗术（洗胃）"
	desc = "手动冲洗病人的胃，诱使呕吐并排出有害化学物质。"
	operation_flags = OPERATION_NOTABLE
	implements = list(
		IMPLEMENT_HAND = 1,
	)
	time = 2 SECONDS
	required_organ_flag = ORGAN_TYPE_FLAGS & ~ORGAN_ROBOTIC
	target_type = /obj/item/organ/stomach
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT

/datum/surgery_operation/organ/stomach_pump/get_default_radial_image()
	return image(/atom/movable/screen/alert/disgusted::overlay_icon, /atom/movable/screen/alert/disgusted::overlay_state)

/datum/surgery_operation/organ/stomach_pump/all_required_strings()
	return ..() + list("病人不能已成焦尸")

/datum/surgery_operation/organ/stomach_pump/state_check(obj/item/organ/stomach/organ)
	return !HAS_TRAIT(organ.owner, TRAIT_HUSK)

/datum/surgery_operation/organ/stomach_pump/on_preop(obj/item/organ/stomach/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始给 [organ.owner] 洗胃……"),
		span_notice("[surgeon] 开始给 [organ.owner] 洗胃。"),
		span_notice("[surgeon] 开始按压 [organ.owner] 的腹部。"),
	)
	display_pain(organ.owner, "你感觉肚子里翻江倒海！你要吐了！")

/datum/surgery_operation/organ/stomach_pump/on_success(obj/item/organ/stomach/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("[surgeon] 迫使 [organ.owner] 呕吐，清除了胃里的一些化学物质！"),
		span_notice("[surgeon] 迫使 [organ.owner] 呕吐，清除了胃里的一些化学物质！"),
		span_notice("[surgeon] 迫使 [organ.owner] 呕吐！"),
	)
	organ.owner.vomit((MOB_VOMIT_MESSAGE | MOB_VOMIT_STUN), lost_nutrition = 20, purge_ratio = 0.67)

/datum/surgery_operation/organ/stomach_pump/on_failure(obj/item/organ/stomach/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_warning("你搞砸了，撞伤了 [organ.owner] 的胸部！"),
		span_warning("[surgeon] 搞砸了，撞伤了 [organ.owner] 的胸部！"),
		span_warning("[surgeon] 搞砸了！"),
	)
	organ.apply_organ_damage(5)
	organ.bodypart_owner.receive_damage(5)

/datum/surgery_operation/organ/stomach_pump/mechanic
	name = "清洗营养处理器"
	rnd_name = "营养处理器清洗（洗胃）"
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
