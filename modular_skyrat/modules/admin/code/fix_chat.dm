ADMIN_VERB(fix_say, R_ADMIN, "修复发言", "为玩家修复发言功能。", ADMIN_CATEGORY_MAIN)
	for(var/player in GLOB.player_list)
		if(!isnull(player))
			continue

		GLOB.player_list -= player
