/obj/item/organ/cyberimp/chest/scanner
	name = "内置健康分析仪"
	desc = "一种先进的生命分析仪植入体，可直接与宿主的身体对接，并在受令时把扫描信息传送至大脑。"
	slot = ORGAN_SLOT_SCANNER
	icon = 'modular_skyrat/modules/implants/icons/internal_HA.dmi'
	icon_state = "internal_HA"
	actions_types = list(/datum/action/item_action/organ_action/use/internal_analyzer)
	w_class = WEIGHT_CLASS_SMALL

/datum/action/item_action/organ_action/use/internal_analyzer
	desc = "左键：健康扫描。右键：化学扫描。需要植入的分析仪未因电磁脉冲或其他原因故障。不提供治疗辅助。"

/datum/action/item_action/organ_action/use/internal_analyzer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/cyberimp/chest/scanner/our_scanner = target
	if(our_scanner.organ_flags & ORGAN_FAILING)
		to_chat(owner, span_warning("你的健康分析仪报错了！在当前状态下它无法与你的身体对接！"))
		return
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		chemscan(owner, owner)
	else
		healthscan(owner, owner, SCANNER_VERBOSE, TRUE)
