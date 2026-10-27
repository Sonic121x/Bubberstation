// no examine hint, its obvious when being used & is a more "sneaky" tool

/obj/item/coin/eldritch/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if (. & ITEM_INTERACT_SUCCESS)
		return

	if (!istype(interacting_with, /obj/machinery/door))
		return NONE

	var/obj/machinery/door/target_door = interacting_with
	if (!target_door.panel_open)
		balloon_alert(user, "先打开面板！")
		return ITEM_INTERACT_BLOCKING

	user.balloon_alert_to_viewers("正在寻找投币口……")
	if (!do_after(user, 3 SECONDS, target_door))
		balloon_alert(user, "没找到投币口！")
		return ITEM_INTERACT_BLOCKING

	if (!target_door.emag_act(user))
		return ITEM_INTERACT_BLOCKING

	user.balloon_alert_to_viewers("已投入硬币")
	qdel(src)
	return ITEM_INTERACT_SUCCESS
