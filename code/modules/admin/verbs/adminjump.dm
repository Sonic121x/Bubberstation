ADMIN_VERB(jump_to_area, R_ADMIN, "跳转到区域", "跳转到指定区域。", ADMIN_CATEGORY_GAME)
	VERB_ARG_TYPED(target, VERB_ARG_TYPE_AREA, VERB_ARG_SOURCE_WORLD, /area)
	var/turf/drop_location
	top_level:
		for(var/list/zlevel_turfs as anything in target.get_zlevel_turf_lists())
			for(var/turf/area_turf as anything in zlevel_turfs)
				if(area_turf.density)
					continue
				drop_location = area_turf
				break top_level

	if(isnull(drop_location))
		to_chat(user, span_warning("该区域内没有找到有效的落点！"))
		return

	user.mob.abstract_move(drop_location)
	log_admin("[key_name(user)]跳转到了[AREACOORD(drop_location)]")
	message_admins("[key_name_admin(user)]跳转到了[AREACOORD(drop_location)]")
	BLACKBOX_LOG_ADMIN_VERB("Jump To Area")

ADMIN_VERB_ONLY_CONTEXT_MENU(jump_to_turf, R_ADMIN, "跳转到地块", /turf)
	VERB_ARG_TYPED(locale, VERB_ARG_TYPE_TURF, VERB_ARG_SOURCE_WORLD, /turf)
	log_admin("[key_name(user)]跳转到了[AREACOORD(locale)]")
	message_admins("[key_name_admin(user)]跳转到了[AREACOORD(locale)]")
	user.mob.abstract_move(locale)
	BLACKBOX_LOG_ADMIN_VERB("Jump To Turf")

ADMIN_VERB_ONLY_CONTEXT_MENU(jump_to_mob, R_ADMIN, "跳转到生物", /mob)
	VERB_ARG_TYPED(target, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	user.mob.abstract_move(target.loc)
	log_admin("[key_name(user)]跳转到了[key_name(target)]")
	message_admins("[key_name_admin(user)]跳转到了[ADMIN_LOOKUPFLW(target)]，位于[AREACOORD(target)]")
	BLACKBOX_LOG_ADMIN_VERB("Jump To Mob")

ADMIN_VERB(jump_to_coord, R_ADMIN, "跳转到坐标", "跳转到游戏世界中的指定坐标。", ADMIN_CATEGORY_GAME)
	VERB_ARG(cx, VERB_ARG_TYPE_NUM, VERB_ARG_SOURCE_INPUT)
	VERB_ARG(cy, VERB_ARG_TYPE_NUM, VERB_ARG_SOURCE_INPUT)
	VERB_ARG(cz, VERB_ARG_TYPE_NUM, VERB_ARG_SOURCE_INPUT)
	var/turf/where_we_droppin = locate(cx, cy, cz)
	if(isnull(where_we_droppin))
		to_chat(user, span_warning("坐标无效。"))
		return

	user.mob.abstract_move(where_we_droppin)
	message_admins("[key_name_admin(user)]跳转到了坐标 [cx], [cy], [cz]")
	BLACKBOX_LOG_ADMIN_VERB("Jump To Coordiate")

ADMIN_VERB(jump_to_key, R_ADMIN, "跳转到玩家", "跳转到指定玩家。", ADMIN_CATEGORY_GAME)
	if(!isobserver(user.mob))
		SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/admin_ghost)

	var/list/keys = list()
	for(var/mob/M in GLOB.player_list)
		keys += M.client
	var/client/selection = input(user, "请选择一名玩家！", "管理员跳跃") as null|anything in sort_key(keys)
	if(!selection)
		to_chat(user, "未找到任何玩家。", confidential = TRUE)
		return
	var/mob/M = selection.mob
	log_admin("[key_name(user)]跳转到了[key_name(M)]")
	message_admins("[key_name_admin(user)]跳转到了[ADMIN_LOOKUPFLW(M)]")
	user.mob.abstract_move(M.loc)
	BLACKBOX_LOG_ADMIN_VERB("Jump To Key")

ADMIN_VERB(jump_to_ghost, R_ADMIN, "跳转到幽灵", "把你的身体传送到你的管理员幽灵处。", ADMIN_CATEGORY_GAME)
	var/mob/dead/observer/ghost = user.mob
	if(!isobserver(ghost))
		return
	var/mob/living/body = ghost?.mind?.current
	if(!body)
		to_chat(user, "没有可带到幽灵处的有效身体。", confidential = TRUE)
		return
	log_admin("[key_name(user)]跳转到了其管理员幽灵处，位于[AREACOORD(ghost.loc)]")
	message_admins("[key_name_admin(user)]跳转到了其管理员幽灵[ADMIN_FLW(body)]处，位于[AREACOORD(ghost.loc)]")
	body.abstract_move(ghost.loc)
	body.setDir(ghost.dir)
	SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/admin_ghost)
	BLACKBOX_LOG_ADMIN_VERB("Jump To Ghost")

ADMIN_VERB_AND_CONTEXT_MENU(get_mob, R_ADMIN, "拉取生物", "把某个生物传送到你的位置。", ADMIN_CATEGORY_GAME, /mob)
	VERB_ARG_TYPED(target, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	var/atom/loc = get_turf(user.mob)
	target.admin_teleport(loc)
	BLACKBOX_LOG_ADMIN_VERB("Get Mob")

/// Proc to hook user-enacted teleporting behavior and keep logging of the event.
/atom/movable/proc/admin_teleport(atom/new_location)
	if(isnull(new_location))
		log_admin("[key_name(usr)]把[key_name(src)]传送到了虚空")
		moveToNullspace()
	else
		var/turf/location = get_turf(new_location)
		log_admin("[key_name(usr)]把[key_name(src)]传送到了[AREACOORD(location)]")
		forceMove(new_location)

/mob/admin_teleport(atom/new_location)
	var/turf/location = get_turf(new_location)
	var/msg = "[key_name_admin(usr)]把[ADMIN_LOOKUPFLW(src)]传送到了[isnull(new_location) ? "虚空" : ADMIN_VERBOSEJMP(location)]"
	message_admins(msg)
	admin_ticket_log(src, msg)
	return ..()

ADMIN_VERB(get_key, R_ADMIN, "拉取玩家", "把指定 key 的玩家传送到你身边。", ADMIN_CATEGORY_GAME)
	var/list/keys = list()
	for(var/mob/M in GLOB.player_list)
		keys += M.client
	var/client/selection = input(user, "请选择一名玩家！", "管理员跳跃") as null|anything in sort_key(keys)
	if(!selection)
		return
	var/mob/M = selection.mob

	if(!M)
		return
	log_admin("[key_name(user)]传送了[key_name(M)]")
	var/msg = "[key_name_admin(user)]传送了[ADMIN_LOOKUPFLW(M)]"
	message_admins(msg)
	admin_ticket_log(M, msg)
	if(M)
		M.forceMove(get_turf(user))
		BLACKBOX_LOG_ADMIN_VERB("Get Key")

ADMIN_VERB_AND_CONTEXT_MENU(send_mob, R_ADMIN, "发送生物", "把指定生物传送到你选择的区域。", ADMIN_CATEGORY_GAME, /mob)
	VERB_ARG_TYPED(jumper, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	var/list/sorted_areas = get_sorted_areas()
	if(!length(sorted_areas))
		to_chat(user, "未找到任何区域。", confidential = TRUE)
		return
	var/area/target_area = tgui_input_list(user, "选择区域", "发送生物", sorted_areas)
	if(isnull(target_area))
		return
	if(!istype(target_area))
		return
	var/list/turfs = get_area_turfs(target_area)
	if(length(turfs) && jumper.forceMove(pick(turfs)))
		log_admin("[key_name(user)]把[key_name(jumper)]传送到了[AREACOORD(jumper)]")
		var/msg = "[key_name_admin(user)]把[ADMIN_LOOKUPFLW(jumper)]传送到了[AREACOORD(jumper)]"
		message_admins(msg)
		admin_ticket_log(jumper, msg)
	else
		to_chat(user, "无法将生物移动到有效位置。", confidential = TRUE)
	BLACKBOX_LOG_ADMIN_VERB("Send Mob")
