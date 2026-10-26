/// Action used to pull up the NIF menu
/datum/action/item_action/nif
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/nif/open_menu
	name = "打开 NIF 菜单"
	button_icon_state = "user"

/datum/action/item_action/nif/open_menu/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/cyberimp/brain/nif/target_nif = target

	if(target_nif.calibrating)
		target_nif.send_message("NIF 仍在校准中，请稍候！", TRUE)
		return FALSE

	if(target_nif.durability < 1)
		target_nif.send_message("耐久度不足！", TRUE)
		return FALSE

	if(target_nif.broken)
		target_nif.send_message("当前无法使用 NIF！", TRUE)
		return FALSE

	if(!.)
		return

	target_nif.ui_interact(usr)

