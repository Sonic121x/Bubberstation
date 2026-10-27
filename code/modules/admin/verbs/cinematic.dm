ADMIN_VERB(cinematic, R_FUN, "过场动画", "向所有玩家播放一段过场动画。", ADMIN_CATEGORY_FUN)
	var/datum/cinematic/choice = tgui_input_list(
		user,
		"选择要播放给服务器内所有玩家的过场动画。",
		"选择过场动画",
		sort_list(subtypesof(/datum/cinematic), GLOBAL_PROC_REF(cmp_typepaths_asc)),
	)
	if(!choice || !ispath(choice, /datum/cinematic))
		return
	play_cinematic(choice, world)
