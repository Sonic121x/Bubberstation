///Essentially, just turns the implantee into a teleport beacon.
/obj/item/implant/beacon
	name = "信标植入体"
	desc = "传送东西。"
	actions_types = null
	implant_flags = IMPLANT_TYPE_SECURITY
	hud_icon_state = "hud_imp_beacon"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3)
	///How long will the implant be teleportable to after death?
	var/lifespan_postmortem = 10 MINUTES

	implant_info = "植入后自动激活。可用作专用的、仅用于传送的蓝空间信标。\
		宿主死亡十分钟后失效，但仍留在体内。"

	implant_lore = "强劲公司 JMP-21 逃犯回收植入体是一种皮下蓝空间应答器，\
		设计用于与常见的蓝空间传送技术对接，并充当可直接传送至其上的信标。\
		遗憾的是，它只能作为可被锁定的信标应答器，不提供任何追踪功能。\
		宿主死亡十分钟后自动失效。"

/obj/item/implant/beacon/is_shown_on_console(obj/machinery/computer/prisoner/management/console)
	if(imp_in.stat == DEAD && imp_in.timeofdeath + lifespan_postmortem < world.time)
		return FALSE
	return TRUE

/obj/item/implant/beacon/get_management_console_data()
	var/list/info_shown = ..()

	var/area/destination_area = get_area(imp_in)
	if(isnull(destination_area) || !check_teleport_valid(imp_in, usr))
		info_shown["Status"] = "无法接收植入体携带者的传送信号！"
	else
		var/turf/turf_to_check = get_turf(imp_in)
		info_shown["Status"] = "植入体携带者处于[is_safe_turf(turf_to_check, dense_atoms = TRUE) ? "安全环境中。" : "危险环境中！"]"

	return info_shown

/obj/item/implanter/beacon
	imp_type = /obj/item/implant/beacon

/obj/item/implantcase/beacon
	name = "植入体盒——“信标”"
	desc = "一个装有信标植入体的玻璃盒。"
	imp_type = /obj/item/implant/beacon
