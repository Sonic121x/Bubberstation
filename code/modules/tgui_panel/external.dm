/*!
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */

/client/var/datum/tgui_panel/tgui_panel

/**
 * tgui panel / chat troubleshooting verb
 */
GAME_VERB(/client, fix_tgui_panel, "修复聊天", "OOC")
	var/action
	log_tgui(src, "开始修复。", context = "verb/fix_tgui_panel")

	nuke_chat()

	// Failed to fix, using tg_alert as fallback
	action = tg_alert(src, "成功了吗？", "", "是", "没有，切换到旧界面")
	if (action == "没有，切换到旧界面")
		winset(src, OUTPUT_SELECTOR_LEGACY_OUTPUT_SELECTOR, "left=output_legacy")
		log_tgui(src, "修复失败。", context = "verb/fix_tgui_panel")

/client/proc/nuke_chat()
	// Catch all solution (kick the whole thing in the pants)
	winset(src, OUTPUT_SELECTOR_LEGACY_OUTPUT_SELECTOR, "left=output_legacy")
	if(!tgui_panel || !istype(tgui_panel))
		log_tgui(src, "缺少 tgui_panel 数据",
			context = "verb/fix_tgui_panel")
		tgui_panel = new(src)
	tgui_panel.initialize(force = TRUE)
	// Force show the panel to see if there are any errors
	winset(src, OUTPUT_SELECTOR_LEGACY_OUTPUT_SELECTOR, "left=output_browser")

GAME_VERB(/client, refresh_tgui, "刷新 TGUI", "OOC")

	for(var/window_id in tgui_windows)
		var/datum/tgui_window/window = tgui_windows[window_id]
		window.reinitialize()
