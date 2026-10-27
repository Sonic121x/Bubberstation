ADMIN_VERB_VISIBILITY(set_server_fps, ADMIN_VERB_VISIBLITY_FLAG_MAPPING_DEBUG)
ADMIN_VERB(set_server_fps, R_DEBUG, "设置服务器 FPS", "以每秒帧数设置游戏速度。可能导致游戏崩溃。", ADMIN_CATEGORY_DEBUG)
	var/cfg_fps = CONFIG_GET(number/fps)
	var/new_fps = round(input(user, "设置游戏每秒帧数。可能导致游戏崩溃（默认：[cfg_fps]）","FPS", world.fps) as num|null)

	if(new_fps <= 0)
		to_chat(user, span_danger("错误：set_server_fps()：无效的 world.fps 值。未做任何更改。"), confidential = TRUE)
		return
	if(new_fps > cfg_fps * 1.5)
		if(tgui_alert(user, "你正在把 FPS 设置为较高的值：\n\t[new_fps] 帧/秒\n\tconfig.fps = [cfg_fps]","警告！",list("Confirm","ABORT-ABORT-ABORT")) != "Confirm")
			return

	var/msg = "[key_name(user)] 已将 world.fps 修改为 [new_fps]"
	log_admin(msg, 0)
	message_admins(msg, 0)
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Set Server FPS", "[new_fps]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

	CONFIG_SET(number/fps, new_fps)
	world.change_fps(new_fps)
