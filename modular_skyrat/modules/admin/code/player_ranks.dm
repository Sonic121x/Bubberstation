/// The list of the available special player ranks
#define SKYRAT_PLAYER_RANKS list("Donator", "Mentor")

ADMIN_VERB(manage_player_ranks, R_ADMIN, "管理玩家头衔", "在服务器运行期间管理拥有特殊玩家头衔的人员。", ADMIN_CATEGORY_MAIN)
	if(!check_rights(R_ADMIN))
		return

	usr.client?.holder.manage_player_ranks()

/// Proc for admins to change people's "player" ranks (donator, mentor, etc.)
/datum/admins/proc/manage_player_ranks()
	if(IsAdminAdvancedProcCall())
		return

	if(!check_rights(R_ADMIN))
		return

	var/choice = tgui_alert(usr, "你想管理哪个头衔？", "管理玩家头衔", SKYRAT_PLAYER_RANKS)
	if(!choice || !(choice in SKYRAT_PLAYER_RANKS))
		return

	manage_player_rank_in_group(choice)

/**
 * Handles managing player ranks based on the name of the group that was chosen.
 *
 * Arguments:
 * * group - The title of the player rank that was chosen to be managed.
 */
/datum/admins/proc/manage_player_rank_in_group(group)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	if(!(group in SKYRAT_PLAYER_RANKS))
		CRASH("[key_name(usr)] attempted to add someone to an invalid \"[group]\" group.")

	var/group_title = LOWER_TEXT(group)

	var/list/choices = list("Add", "Remove")
	switch(tgui_alert(usr, "你想做什么？", "管理 [group]", choices))
		if("Add")
			var/name = input(usr, "请输入你想授予 [group_title] 头衔之人的 CKEY（不区分大小写）：", "添加 [group_title]") as null|text
			if(!name)
				return

			var/player_to_be = ckey(name)
			if(!player_to_be)
				to_chat(usr, span_warning("“[name]” 不是有效的 CKEY。"))
				return

			var/success = SSplayer_ranks.add_player_to_group(usr.client, player_to_be, group_title)

			if(!success)
				return

			message_admins("[key_name(usr)] 已将 [group_title] 头衔授予 [player_to_be]。")
			log_admin_private("[key_name(usr)] 已将 [group_title] 头衔授予 [player_to_be]。")


		if("Remove")
			var/name = input(usr, "请输入你想撤销 [group_title] 头衔之人的 CKEY（不区分大小写）：", "移除 [group_title]") as null|text
			if(!name)
				return

			var/player_that_was = ckey(name)
			if(!player_that_was)
				to_chat(usr, span_warning("“[name]” 不是有效的 CKEY。"))
				return

			var/success = SSplayer_ranks.remove_player_from_group(usr.client, player_that_was, group_title)

			if(!success)
				return

			message_admins("[key_name(usr)] 已撤销 [player_that_was] 的 [group_title] 头衔。")
			log_admin_private("[key_name(usr)] 已撤销 [player_that_was] 的 [group_title] 头衔。")

		else
			return



ADMIN_VERB(migrate_player_ranks, R_ADMIN|R_DEBUG|R_SERVER, "迁移玩家头衔", "将各种玩家头衔从旧系统逐个迁移到基于 SQL 的系统。", ADMIN_CATEGORY_DEBUG)
	user.mob.client?.holder.migrate_player_ranks()

/datum/admins/proc/migrate_player_ranks()
	if(IsAdminAdvancedProcCall())
		return

	if(!check_rights(R_ADMIN | R_DEBUG | R_SERVER))
		return

	if(!CONFIG_GET(flag/sql_enabled))
		return

	var/choice = tgui_alert(usr, "你想迁移哪个头衔？", "迁移玩家头衔", SKYRAT_PLAYER_RANKS)
	if(!choice || !(choice in SKYRAT_PLAYER_RANKS))
		return

	if(tgui_alert(usr, "你确定要将 [choice] 头衔迁移到基于 SQL 的系统吗？", "迁移玩家头衔", list("Yes", "No")) != "Yes")
		return

	log_admin("[key_name(usr)] 正在将 [choice] 玩家头衔从旧系统迁移到基于 SQL 的系统。")
	SSplayer_ranks.migrate_player_rank_to_sql(usr.client, choice)


#undef SKYRAT_PLAYER_RANKS
