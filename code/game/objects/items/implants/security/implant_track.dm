/obj/item/implant/tracking
	name = "追踪植入体"
	desc = "用它来追踪。"
	actions_types = null
	implant_flags = IMPLANT_TYPE_SECURITY
	hud_icon_state = "hud_imp_tracking"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)

	///How long will the implant continue to function after death?
	var/lifespan_postmortem = 10 MINUTES

	implant_info = "植入时自动激活。作为专用的纯追踪信标，\
		以及直连大脑的囚犯留言系统。\
		寄主死亡十分钟后停用，但会留在体内。"

	implant_lore = "罗巴斯特公司 EYE-5 囚犯假释监控植入体是一种皮下追踪信标，\
		设计用于与囚犯管理设备对接；它既是可通过定位设备追踪的信标，\
		也是从囚犯管理人员到植入对象的单向通讯提供者，\
		将信息直接传达到对象的大脑。\
		寄主死亡十分钟后自动停用。"

/obj/item/implant/tracking/is_shown_on_console(obj/machinery/computer/prisoner/management/console)
	if(imp_in.stat == DEAD && imp_in.timeofdeath + lifespan_postmortem < world.time)
		return FALSE
	if(!is_valid_z_level(get_turf(console), get_turf(imp_in)))
		return FALSE
	return TRUE

/obj/item/implant/tracking/get_management_console_data()
	var/list/info_shown = ..()
	info_shown["Location"] = get_area_name(imp_in, format_text = TRUE) || "未知"
	return info_shown

/obj/item/implant/tracking/get_management_console_buttons()
	var/list/buttons = ..()
	UNTYPED_LIST_ADD(buttons, list(
		"name" = "警告",
		"color" = "average",
		"tooltip" = "向目标的大脑直接发送一条消息。",
		"action_key" = "warn",
	))
	return buttons

/obj/item/implant/tracking/handle_management_console_action(mob/user, list/params, obj/machinery/computer/prisoner/management/console)
	. = ..()
	if(.)
		return

	if(params["implant_action"] == "warn")
		var/warning = tgui_input_text(user, "你想向[imp_in.name]发送什么警告？", "发送消息", max_length = MAX_MESSAGE_LEN)
		if(!warning || QDELETED(src) || QDELETED(user) || QDELETED(console) || isnull(imp_in))
			return TRUE
		if(!console.is_operational || !user.can_perform_action(console, NEED_DEXTERITY|ALLOW_SILICON_REACH))
			return TRUE

		to_chat(imp_in, span_hear("你听到脑中有一个声音说：“[warning]”"))
		log_directed_talk(user, imp_in, warning, LOG_SAY, "implant message")
		return TRUE

/obj/item/implant/tracking/c38
	name = "TRAC 植入体"
	desc = "一种更小的追踪植入体，仅能供电几分钟。"
	implant_flags = NONE
	///How long before this implant self-deletes?
	var/lifespan = 5 MINUTES
	///The id of the timer that's qdeleting us
	var/timerid

	implant_info = "植入时自动激活，通常通过枪械植入。\
		作为专用的纯追踪信标及直连大脑的囚犯留言系统。\
		5 分钟后分解为可吸收的元素。"

	implant_lore = "罗巴斯特公司 EYE-5/TRAC 逃犯监控植入体是一种皮下追踪信标，\
		设计为通过高速弹丸植入。\
		与原版 EYE-5 囚犯假释监控植入体一样，\
		它可与囚犯管理设备对接，既是可通过定位设备追踪的信标，\
		也是从囚犯管理人员到植入目标的单向通讯提供者，\
		将信息直接传达到目标的大脑。\
		五分钟后分解为生物安全的元素。"

/obj/item/implant/tracking/c38/implant(mob/living/target, mob/user, silent, force)
	. = ..()
	timerid = QDEL_IN_STOPPABLE(src, lifespan)

/obj/item/implant/tracking/c38/removed(mob/living/source, silent, special)
	. = ..()
	deltimer(timerid)
	timerid = null

/obj/item/implant/tracking/c38/Destroy()
	return ..()

/obj/item/implanter/tracking
	imp_type = /obj/item/implant/tracking

/obj/item/implanter/tracking/gps
	imp_type = /obj/item/gps/mining/internal
