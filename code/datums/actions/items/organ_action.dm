/datum/action/item_action/organ_action
	name = "器官动作"
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/organ_action/IsAvailable(feedback = FALSE)
	var/obj/item/organ/attached_organ = target
	if(!attached_organ.owner)
		return FALSE
	return ..()

/datum/action/item_action/organ_action/toggle
	name = "切换器官开关"

/datum/action/item_action/organ_action/toggle/New(Target)
	..()
	var/obj/item/organ/organ_target = target
	name = "切换[organ_target.name]开关"

/datum/action/item_action/organ_action/use
	name = "使用器官"

/datum/action/item_action/organ_action/use/New(Target)
	..()
	var/obj/item/organ/organ_target = target
	name = "使用[organ_target.name]"

/datum/action/item_action/organ_action/go_feral
	name = "释放野性"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "feral_mode_off"
	var/list/ability_name = list("释放野性", "恩将仇咬", "释放本我", "激活猫脑", "捣蛋鬼模式", "开咬模式", "抛弃人性", "不守规矩")

/datum/action/item_action/organ_action/go_feral/New(Target)
	..()
	name = pick(ability_name)

/datum/action/item_action/organ_action/go_feral/do_effect(trigger_flags)
	var/obj/item/organ/fangs/cat/cat_fangs = target
	cat_fangs.toggle_feral()
	if(!cat_fangs.feral_mode)
		background_icon_state = "bg_default"
		button_icon_state = "feral_mode_off"
		to_chat(cat_fangs.owner, span_notice("你将正常进行徒手攻击。"))
	else
		background_icon_state = "bg_default_on"
		button_icon_state = "feral_mode_on"
		to_chat(cat_fangs.owner, span_notice("你将在徒手攻击时撕咬目标。"))
	build_all_button_icons()
	return TRUE
