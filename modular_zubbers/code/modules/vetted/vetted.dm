GLOBAL_LIST_EMPTY(vetted_list_legacy)
GLOBAL_PROTECT(vetted_list_legacy)
GLOBAL_LIST_EMPTY(vetted_list)
GLOBAL_PROTECT(vetted_list)

/datum/player_rank_controller/vetted
	rank_title = "vetted user"

/client/
	var/is_vetted = null

/datum/controller/subsystem/player_ranks/proc/is_vetted(client/user, admin_bypass = TRUE)
	if(!istype(user))
		CRASH("传给 is_vetted() 的用户类型无效，应为 'client'，实际为 '[user ? user.type : "null"]'。")
	if(!isnull(user.is_vetted))
		return user.is_vetted
	if(get_user_vetted_status_hot(user.ckey))
		user.is_vetted = TRUE
		return user.is_vetted
	else
		user.is_vetted = FALSE
		return user.is_vetted



/datum/controller/subsystem/player_ranks/proc/get_user_vetted_status_hot(ckey)
	if(IsAdminAdvancedProcCall())
		return
	if(!SSdbcore.Connect())
		return
	var/datum/db_query/query_load_player_rank = SSdbcore.NewQuery("SELECT ckey FROM vetted_list WHERE ckey = :ckey", list("ckey" = ckey))
	if(!query_load_player_rank.warn_execute())
		qdel(query_load_player_rank)
		return
	while(query_load_player_rank.NextRow())
		var/ckey2 = ckey(query_load_player_rank.item[1])
		. = ckey2
	qdel(query_load_player_rank)

/datum/player_rank_controller/vetted/proc/convert_all_to_sql()
	if(!SSdbcore.Connect())
		return message_admins("无法连接数据库，无法完成从平面文件到 SQL 的转换。")
	for(var/ckey_ in GLOB.vetted_list_legacy)
		add_player_to_sql(ckey_)

/datum/player_rank_controller/vetted/proc/add_player_to_sql(ckey, admin_mob)
	var/ckey_admin = "Conversion Script"
	var/mob/admin_who_added_client = admin_mob
	if(istype(admin_who_added_client, /mob) && admin_who_added_client.client)
		ckey_admin = admin_who_added_client?.client?.ckey

	var/datum/db_query/query_add_player_rank = SSdbcore.NewQuery(
		"INSERT INTO vetted_list (ckey, admin_who_added) VALUES(:ckey, :admin_who_added)",
		list("ckey" = ckey, "admin_who_added" = ckey_admin),
	)

	. = query_add_player_rank.warn_execute()
	qdel(query_add_player_rank)

/datum/player_rank_controller/vetted/add_player(ckey, legacy, admin)
	ckey = ckey(ckey)
	if(legacy)
		GLOB.vetted_list_legacy[ckey] = TRUE
	GLOB.vetted_list[ckey] = TRUE
	if(admin)
		add_player_to_sql(ckey, admin)

/datum/player_rank_controller/vetted/remove_player(ckey)
	GLOB.vetted_list -= ckey
	remove_player_from_sql(ckey)

/datum/player_rank_controller/vetted/proc/remove_player_from_sql(ckey)
	var/datum/db_query/query_remove_player_vetted = SSdbcore.NewQuery(
		"DELETE FROM vetted_list WHERE ckey = :ckey",
		list("ckey" = ckey),
	)
	. = query_remove_player_vetted.warn_execute()
	qdel(query_remove_player_vetted)

ADMIN_VERB(convert_flatfile_vettedlist_to_sql, R_DEBUG, "将认证名单转换为 SQL", "警告！可能很慢！", ADMIN_CATEGORY_DEBUG)
	var/consent = tgui_input_list(usr, "你想把认证名单转换为 SQL 吗？", "哎呀", list("是", "否"), "否")
	if(consent == "是")
		SSplayer_ranks.vetted_controller.convert_all_to_sql()
		message_admins("[usr] 已强制将认证名单文件转换为 SQL。")

ADMIN_VERB(add_vetted, R_ADMIN, "将用户加入认证名单", "把一个用户加入认证名单", ADMIN_CATEGORY_MAIN)
	var/user_adding = tgui_input_text(usr, "要添加哪位用户？", "认证名单")
	if(length(user_adding))
		SSplayer_ranks.vetted_controller.add_player(ckey = user_adding, admin = usr)
		message_admins("[usr] 已将 [user_adding] 加入认证数据库。")

ADMIN_VERB(remove_vetted, R_ADMIN, "将用户移出认证名单", "把一个用户移出认证名单", ADMIN_CATEGORY_MAIN)
	var/user_del = tgui_input_text(usr, "要移除哪位用户？", "认证名单")
	if(length(user_del))
		SSplayer_ranks.vetted_controller.remove_player(ckey = user_del)
		message_admins("[usr] 已将 [user_del] 从认证数据库中移除。")
