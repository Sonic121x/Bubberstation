/obj/item/circuitboard/computer/cargo/express/interdyne
	name = "英特戴恩快速补给控制台"
	build_path = /obj/machinery/computer/cargo/express/interdyne
	contraband = TRUE

/obj/machinery/computer/cargo/express/interdyne
	name = "英特戴恩快速补给控制台"
	desc = "一台标准的纳米传讯快速补给控制台，被戈尔莱克斯工业改装成使用\
		他们实验性的“1100mm 轨道炮”，并做得格外坚固，以防\
		被 SSV 无畏号上的辛迪加学员电磁破坏。"
	circuit = /obj/item/circuitboard/computer/cargo/express/interdyne
	req_access = list(ACCESS_SYNDICATE)
	cargo_account = ACCOUNT_INT
	contraband = TRUE
	pod_type = /obj/structure/closet/supplypod/bluespacepod
	console_flags = CARGO_CONSOLE_INTERDYNE
	landingzone = /area/ruin/space/has_grav/bubbers/persistance/cargo

/obj/machinery/computer/cargo/express/interdyne/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(user)
		to_chat(user, span_notice("你试图修改路由协议，然而机器显示了一个运行时错误并重启了。"))
	return FALSE//never let this console be emagged

//Tarkons console
/obj/item/circuitboard/computer/cargo/express/interdyne/tarkon
	name = "塔肯快速补给控制台"
	build_path = /obj/machinery/computer/cargo/express/interdyne/tarkon
	contraband = TRUE
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT)

/obj/machinery/computer/cargo/express/interdyne/tarkon
	name = "塔肯快速补给控制台"
	landingzone = /area/ruin/space/has_grav/port_tarkon/cargo
	desc = "一台标准的塔肯快速补给控制台。"
	circuit = /obj/item/circuitboard/computer/cargo/express/interdyne/tarkon
	req_access = list(ACCESS_TARKON)
	cargo_account = ACCOUNT_TAR
	console_flags = NONE
