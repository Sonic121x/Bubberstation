/obj/machinery/cell_charger/click_alt(mob/user)
	. = ..()
	if(. || !charging)
		return
	to_chat(user, span_notice("你启动快拆装置，电池弹了出来！"))
	removecell(drop_location())
	return CLICK_ACTION_SUCCESS

/obj/machinery/cell_charger/examine(mob/user)
	. = ..()
	. += span_notice("按住 Alt 单击可扳动弹出杆！")
