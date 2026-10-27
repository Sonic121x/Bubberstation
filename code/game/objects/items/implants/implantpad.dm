/obj/item/implantpad//SKYRAT EDIT - ICON OVERRIDDEN BY AESTHETICS - SEE MODULE
	name = "植入体面板"
	desc = "用于修改植入体。"
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "implantpad-0"
	base_icon_state = "implantpad"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	interaction_flags_click = FORBID_TELEKINESIS_REACH|ALLOW_RESTING

	///The implant case currently inserted into the pad.
	var/obj/item/implantcase/inserted_case

	/// The deathrattle group currently saved to the implantpad.
	var/datum/deathrattle_group/saved_deathrattle_group

/obj/item/implantpad/update_icon_state()
	icon_state = "[base_icon_state]-[!isnull(inserted_case)]"
	return ..()

/obj/item/implantpad/examine(mob/user)
	. = ..()
	if(!inserted_case)
		. += span_info("目前是空的。")
		return

	if(Adjacent(user))
		. += span_info("里面装有[inserted_case]。")
	else
		. += span_warning("里面似乎有什么东西，但你在这么远的地方看不清是什么……")
	. += span_info("Alt 点击以取出[inserted_case]。")

/obj/item/implantpad/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == inserted_case)
		inserted_case = null
		update_appearance(UPDATE_ICON)

/obj/item/implantpad/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(inserted_case || !istype(tool, /obj/item/implantcase))
		return NONE
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	user.balloon_alert(user, "已插入植入体盒")
	inserted_case = tool
	update_static_data_for_all_viewers()
	update_appearance(UPDATE_ICON)
	return ITEM_INTERACT_SUCCESS

/obj/item/implantpad/click_alt(mob/user)
	remove_implant(user)
	return CLICK_ACTION_SUCCESS

/obj/item/implantpad/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "ImplantPad", name)
		ui.open()

/obj/item/implantpad/ui_data(mob/user)
	var/list/data = list()
	data["saved_deathrattle_group"] = saved_deathrattle_group ? saved_deathrattle_group.name : null
	data["current_deathrattle_group"] = null
	data["has_case"] = !!inserted_case
	if(!inserted_case)
		return data
	data["has_implant"] = !!inserted_case.imp
	if(inserted_case.imp)
		data["case_information"] = inserted_case.imp.get_data()
		data["case_lore"] = inserted_case.imp.get_lore()
		if(istype(inserted_case.imp, /obj/item/implant/deathrattle))
			var/obj/item/implant/deathrattle/inserted_deathrattle = inserted_case.imp
			if(inserted_deathrattle.current_group)
				data["current_deathrattle_group"] = inserted_deathrattle.current_group
	return data

/obj/item/implantpad/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/mob/user = usr
	if(action == "eject_implant")
		remove_implant(user)
		return
	if(action == "save_deathrattle_group")
		save_deathrattle_group(user)
	if(action == "set_deathrattle_group")
		set_deathrattle_group(user)
	if(action == "init_deathrattle_group")
		init_deathrattle_group(user)

///Removes the implant from the pad and puts it in the user's hands if possible.
/obj/item/implantpad/proc/remove_implant(mob/user)
	if(!inserted_case)
		user.balloon_alert(user, "里面没有植入体盒！")
		return FALSE
	add_fingerprint(user)
	inserted_case.add_fingerprint(user)
	user.put_in_hands(inserted_case)
	user.balloon_alert(user, "已取出植入体盒")
	update_appearance(UPDATE_ICON)
	update_static_data_for_all_viewers()
	return TRUE

/// Saves the currently inserted implant's deathrattle group.
/obj/item/implantpad/proc/save_deathrattle_group(mob/user)
	if(!inserted_case)
		user.balloon_alert(user, "里面没有植入体盒！")
		return FALSE
	if(!istype(inserted_case.imp, /obj/item/implant/deathrattle))
		user.balloon_alert(user, "植入体不兼容！")
		return FALSE
	var/obj/item/implant/deathrattle/inserted_implant = inserted_case.imp
	var/datum/deathrattle_group/current_group = inserted_implant.current_group
	if(!current_group)
		user.balloon_alert(user, "没有激活的亡语组！")
		return FALSE
	saved_deathrattle_group = current_group
	user.balloon_alert(user, "已保存亡语组[current_group.name]")
	update_static_data_for_all_viewers()
	return TRUE

/// Sets the currently inserted implant's deathrattle group to saved.
/obj/item/implantpad/proc/set_deathrattle_group(mob/user)
	if(!inserted_case)
		user.balloon_alert(user, "里面没有植入体盒！")
		return FALSE
	if(!saved_deathrattle_group)
		user.balloon_alert(user, "没有已保存的亡语组！")
		return FALSE
	if(!istype(inserted_case.imp, /obj/item/implant/deathrattle))
		user.balloon_alert(user, "植入体不兼容！")
		return FALSE
	var/obj/item/implant/deathrattle/inserted_implant = inserted_case.imp
	if(!istype(saved_deathrattle_group, inserted_implant.deathrattle_group_type))
		user.balloon_alert(user, "亡语组不兼容！")
		return FALSE
	saved_deathrattle_group.register(inserted_implant)
	user.balloon_alert(user, "已注册到亡语组[saved_deathrattle_group.name]")
	inserted_case.name = "[initial(inserted_case.name)] - [saved_deathrattle_group.name]"
	update_static_data_for_all_viewers()
	return TRUE

/// Initializes and saves a new deathrattle group, then registers the current implant to it.
/obj/item/implantpad/proc/init_deathrattle_group(mob/user)
	if(!inserted_case)
		user.balloon_alert(user, "里面没有植入体盒！")
		return FALSE
	if(!istype(inserted_case.imp, /obj/item/implant/deathrattle))
		user.balloon_alert(user, "植入体不兼容！")
		return FALSE
	var/obj/item/implant/deathrattle/inserted_implant = inserted_case.imp
	if(inserted_implant.current_group)
		user.balloon_alert(user, "已设置亡语组！")
		return FALSE
	// init and save new group
	saved_deathrattle_group = new inserted_implant.deathrattle_group_type
	// register current implant
	saved_deathrattle_group.register(inserted_implant)
	user.balloon_alert(user, "已注册到新亡语组[saved_deathrattle_group.name]")
	inserted_case.name += " - [saved_deathrattle_group.name]"
	update_static_data_for_all_viewers()
	return TRUE
