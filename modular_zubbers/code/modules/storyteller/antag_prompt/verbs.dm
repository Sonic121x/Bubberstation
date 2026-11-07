GAME_VERB_DESC(/client, clear_poll_ignores, "清除招募屏蔽", "撤销你做出的所有“本回合不再询问”选择。", "OOC")
	var/list/cleared = list()
	for(var/ignore_category in GLOB.poll_ignore)
		var/list/ignored = GLOB.poll_ignore[ignore_category]
		if(!(ckey in ignored))
			continue
		ignored -= ckey
		cleared += chinese_poll_role_display(GLOB.poll_ignore_desc[ignore_category] || ignore_category)

	if(!length(cleared))
		to_chat(src, span_warning("你没有屏蔽任何招募。"))
		return
	to_chat(src, span_notice("已取消屏蔽：[english_list(cleared)]。今后会再次向你显示这些招募。"))
