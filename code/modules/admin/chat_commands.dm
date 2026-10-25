/// Reload admins tgs chat command. Intentionally not validated.
/datum/tgs_chat_command/reload_admins
	name = "reload_admins"
	help_text = "强制服务器重新加载管理员。"
	admin_only = TRUE

/datum/tgs_chat_command/reload_admins/Run(datum/tgs_chat_user/sender, params)
	ReloadAsync()
	log_admin("[sender.friendly_name] 通过聊天命令重新加载了管理员。")
	message_admins("[sender.friendly_name] 通过聊天命令重新加载了管理员。")
	return new /datum/tgs_message_content("管理员已重新加载。")

/datum/tgs_chat_command/reload_admins/proc/ReloadAsync()
	set waitfor = FALSE
	load_admins()

/// subtype tgs chat command with validated admin ranks. Only supports discord.
/datum/tgs_chat_command/validated
	ignore_type = /datum/tgs_chat_command/validated
	admin_only = TRUE
	var/required_rights = 0 //! validate discord userid is linked to a game admin with these flags.


/// called by tgs
/datum/tgs_chat_command/validated/Run(datum/tgs_chat_user/sender, params)
	if (!CONFIG_GET(flag/secure_chat_commands) || CONFIG_GET(flag/admin_legacy_system) || !SSdbcore.Connect())
		return Validated_Run(sender, params)

	var/discord_id = SSdiscord.get_discord_id_from_mention(sender.mention) || sender.id
	if (!discord_id)
		return new /datum/tgs_message_content("错误：获取你的 Discord ID 时发生未知错误。")

	var/datum/admins/linked_admin
	var/admin_ckey = ckey(SSdiscord.lookup_ckey(discord_id))

	if (admin_ckey)
		linked_admin = GLOB.admin_datums[admin_ckey] || GLOB.deadmins[admin_ckey]
	else
		return new /datum/tgs_message_content("错误：无法为你的 Discord ID 找到关联的 ckey。")

	if (!linked_admin)
		return new /datum/tgs_message_content("错误：你关联的 ckey（`[admin_ckey]`）未在管理员列表中找到。如果这是个错误，可以试试 `reload_admins`")

	if (!linked_admin.check_for_rights(required_rights))
		return new /datum/tgs_message_content("错误：你关联的 ckey（`[admin_ckey]`）没有足够的权限执行该操作。你需要以下旗标之一：`[rights2text(required_rights," ")]`")

	return Validated_Run(sender, params)


/// Called if the sender passes validation checks or if those checks are disabled.
/datum/tgs_chat_command/validated/proc/Validated_Run(datum/tgs_chat_user/sender, params)
	RETURN_TYPE(/datum/tgs_message_content)
	CRASH("[type] has no implementation for Validated_Run()")

/datum/tgs_chat_command/validated/ahelp
	name = "ahelp"
	help_text = "<ckey|ticket #> <message|ticket <close|resolve|icissue|reject|reopen <ticket #>|list>>"
	admin_only = TRUE
	required_rights = R_ADMIN

/datum/tgs_chat_command/validated/ahelp/Validated_Run(datum/tgs_chat_user/sender, params)
	var/list/all_params = splittext(params, " ")
	if(all_params.len < 2)
		return new /datum/tgs_message_content("参数不足")
	var/target = all_params[1]
	all_params.Cut(1, 2)
	var/id = text2num(target)
	if(id != null)
		var/datum/admin_help/AH = GLOB.ahelp_tickets.TicketByID(id)
		if(AH)
			target = AH.initiator_ckey
		else
			return new /datum/tgs_message_content("未找到工单 #[id]！")
	return new /datum/tgs_message_content(TgsPm(target, all_params.Join(" "), sender.friendly_name))

/datum/tgs_chat_command/validated/namecheck
	name = "namecheck"
	help_text = "返回指定目标的信息"
	admin_only = TRUE
	required_rights = R_ADMIN

/datum/tgs_chat_command/validated/namecheck/Validated_Run(datum/tgs_chat_user/sender, params)
	params = trim(params)
	if(!params)
		return new /datum/tgs_message_content("参数不足")
	log_admin("聊天名称检查：[sender.friendly_name] 检查 [params]")
	message_admins("[sender.friendly_name] 正在对 [params] 进行名称检查")
	return new /datum/tgs_message_content(keywords_lookup(params, 1))

/datum/tgs_chat_command/validated/adminwho
	name = "adminwho"
	help_text = "列出当前在服务器上的管理员"
	admin_only = TRUE
	required_rights = 0

/datum/tgs_chat_command/validated/adminwho/Validated_Run(datum/tgs_chat_user/sender, params)
	return new /datum/tgs_message_content(tgsadminwho())

/datum/tgs_chat_command/validated/sdql
	name = "sdql"
	help_text = "执行一条 SDQL 查询"
	admin_only = TRUE
	required_rights = R_DEBUG

/datum/tgs_chat_command/validated/sdql/Validated_Run(datum/tgs_chat_user/sender, params)
	var/list/results = HandleUserlessSDQL(sender.friendly_name, params)
	if(!results)
		return new /datum/tgs_message_content("查询没有产生输出")
	var/list/text_res = results.Copy(1, 3)
	var/list/refs = results.len > 3 ? results.Copy(4) : null
	return new /datum/tgs_message_content("[text_res.Join("\n")][refs ? "\n引用：[refs.Join(" ")]" : ""]")

/datum/tgs_chat_command/validated/tgsstatus
	name = "status"
	help_text = "获取服务器的管理员数、玩家数、游戏模式与真实游戏模式"
	admin_only = TRUE
	required_rights = R_ADMIN

/datum/tgs_chat_command/validated/tgsstatus/Validated_Run(datum/tgs_chat_user/sender, params)
	var/list/adm = get_admin_counts()
	var/list/allmins = adm["total"]
	var/status = "管理员：[allmins.len]（在线：[english_list(adm["present"])] 暂离：[english_list(adm["afk"])] 隐身：[english_list(adm["stealth"])] 无旗标：[english_list(adm["noflags"])]）。"
	status += "玩家：[GLOB.clients.len]（活跃：[get_active_player_count(FALSE, TRUE, FALSE)]）。本回合[SSticker.HasRoundStarted() ? "" : "尚未"]开始。"
	return new /datum/tgs_message_content(status)
