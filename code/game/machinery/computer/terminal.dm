//Basic computer meant for basic detailing in ruins and away missions, NOT meant for the station
/obj/machinery/computer/terminal
	name = "终端"
	desc = "用于内部计算、内网邮件和日志记录的低技术设备。这个型号看起来相当古老。"
	icon_state = MAP_SWITCH("computer", "/obj/machinery/computer/piratepad_control")
	circuit = /obj/item/circuitboard/computer/terminal //Deconstruction still wipes contents but this is easier than smashing the console
	///Text that displays on top of the actual 'lore' funnies.
	var/upperinfo = "版权所有2487纳米软件™——禁止再分发"
	///Text this terminal contains, not dissimilar to paper. Unlike paper, players cannot add or edit existing info.
	var/content = list("恭喜购买纳米软件™终端！更多设置说明请查阅 \
	用户手册。授权与注册事宜，请联系获授权的纳米软件经销商及维修服务代表。")
	///The TGUI theme this console uses. Defaults to hackerman, a retro greeny pallete which should fit most terminals.
	var/tguitheme = "hackerman"

/obj/machinery/computer/terminal/ui_interact(mob/user, datum/tgui/ui)
	..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Terminal", name) //The paper tgui file scares me, so new type of UI
		ui.open()

/obj/machinery/computer/terminal/ui_static_data(mob/user)
	return list(
		"messages" = content,
		"uppertext" = upperinfo,
		"tguitheme" = tguitheme,
	)

