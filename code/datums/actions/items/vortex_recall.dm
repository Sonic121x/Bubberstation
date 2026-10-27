/datum/action/item_action/vortex_recall
	name = "漩涡召回"
	desc = "随时将自己和附近的人传送回已绑定的圣职者信标。<br>如果信标仍装在武器上，则将其卸下。"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "vortex_recall"

/datum/action/item_action/vortex_recall/IsAvailable(feedback = FALSE)
	if(!istype(target, /obj/item/hierophant_club))
		return
	var/obj/item/hierophant_club/teleport_stick = target
	if(teleport_stick.teleporting)
		return FALSE
	if(teleport_stick.beacon && !check_teleport_valid(owner, get_turf(teleport_stick.beacon), TELEPORT_CHANNEL_FREE))
		return FALSE
	return ..()
