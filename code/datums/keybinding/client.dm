/datum/keybinding/client
	category = CATEGORY_CLIENT
	weight = WEIGHT_HIGHEST


/datum/keybinding/client/admin_help
	hotkey_keys = list("F1")
	name = "admin_help"
	full_name = "管理员求助"
	description = "向管理员寻求帮助。"
	keybind_signal = COMSIG_KB_CLIENT_GETHELP_DOWN

/datum/keybinding/client/admin_help/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	user.adminhelp()
	return TRUE


/datum/keybinding/client/screenshot
	hotkey_keys = list("F2")
	name = "quick screenshot"
	full_name = "快速截图"
	description = "截取画面并保存到 BYOND 的 screenshots 文件夹。"
	keybind_signal = COMSIG_KB_CLIENT_SCREENSHOT_DOWN
	can_edit = FALSE

/datum/keybinding/client/screenshot/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	to_chat(user, span_notice("截图已保存到 'BYOND/screenshots' 文件夹。"))
	//This is dealt by BYOND. Keeping this here in case that ever changes, though this command doesn't actually work when manually called.
	//winset(user, null, "command=.screenshot auto")
	return TRUE

/datum/keybinding/client/screenshot_loc
	hotkey_keys = list("ShiftF2")
	name = "screenshot as"
	full_name = "截图另存为"
	description = "截取画面并保存到指定位置。"
	keybind_signal = COMSIG_KB_CLIENT_SCREENSHOT_AS_DOWN
	can_edit = FALSE

/datum/keybinding/client/screenshot_loc/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	//This is dealt by BYOND. Keeping this here in case that ever changes.
	//winset(user, null, "command=.screenshot")
	return TRUE

/datum/keybinding/client/toggle_fullscreen
	hotkey_keys = list("F11")
	name = "toggle_fullscreen"
	full_name = "切换全屏"
	description = "将游戏窗口切换为全屏。"
	keybind_signal = COMSIG_KB_CLIENT_FULLSCREEN_DOWN

/datum/keybinding/client/toggle_fullscreen/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	user.toggle_fullscreen()
	return TRUE

/datum/keybinding/client/minimal_hud
	hotkey_keys = list("F12")
	name = "minimal_hud"
	full_name = "精简 HUD"
	description = "隐藏大部分 HUD 界面元素"
	keybind_signal = COMSIG_KB_CLIENT_MINIMALHUD_DOWN

/datum/keybinding/client/minimal_hud/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return

	if(user.mob.hud_used)
		user.mob.hud_used.show_hud() //Shows the next hud preset
		to_chat(user, span_info("已切换 HUD 模式，按 F12 可再次切换。"))
	else
		to_chat(user, span_warning("此生物类型不使用 HUD。"))

	return TRUE

/datum/keybinding/client/close_every_ui
	hotkey_keys = list("Northwest") // HOME key
	name = "close_every_ui"
	full_name = "关闭已打开的界面"
	description = "关闭你当前打开的所有界面窗口。"
	keybind_signal = COMSIG_KB_CLIENT_CLOSEUI_DOWN

/datum/keybinding/client/close_every_ui/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	SStgui.close_user_uis(user.mob)
	return TRUE
