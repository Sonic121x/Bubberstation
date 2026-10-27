GAME_VERB(/client, mentorwho, "导师名单", "Mentor")
	var/msg = "<b>当前导师：</b>\n"
	for(var/X in GLOB.mentors)
		var/client/C = X
		if(!C)
			GLOB.mentors -= C
			continue // weird runtime that happens randomly
		var/suffix = ""
		if(holder)
			if(isobserver(C.mob))
				suffix += " - 观察中"
			else if(istype(C.mob,/mob/dead/new_player))
				suffix += " - 大厅"
			else
				suffix += " - 游戏中"

			if(C.is_afk())
				suffix += "（暂离）"
		msg += span_infoplain("\t[C][suffix]\n")
	to_chat(src, msg)
