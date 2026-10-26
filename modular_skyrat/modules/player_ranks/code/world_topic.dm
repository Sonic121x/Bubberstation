
/datum/world_topic/set_player_rank
	keyword = "set_player_rank"
	require_comms_key = TRUE

/datum/world_topic/set_player_rank/Run(list/input)
	. = list()

	var/sender_discord_id = input["sender_discord_id"]

	if(!sender_discord_id)
		.["success"] = FALSE
		.["message"] = "发送者的Discord账号ID无效，这不应该发生！请立即报告！"
		return

	var/target_ckey = ckey(input["target_ckey"])

	if(!target_ckey)
		.["success"] = FALSE
		.["message"] = "提供的目标账号ckey无效。"
		return

	var/sender_ckey = ckey(SSdiscord.lookup_ckey(sender_discord_id))

	if(!sender_ckey)
		.["success"] = FALSE
		.["message"] = "未找到与Discord账号ID **[sender_discord_id]**绑定的ckey。请按照游戏内命令的说明验证Discord账号，然后重试。"
		return

	var/datum/admins/linked_admin_holder = GLOB.admin_datums[sender_ckey] || GLOB.deadmins[sender_ckey]

	if(!linked_admin_holder)
		.["success"] = FALSE
		.["message"] = "与你Discord账号绑定的ckey没有关联有效的管理员身份。"
		return

	if(!linked_admin_holder.check_for_rights(R_ADMIN))
		.["success"] = FALSE
		.["message"] = "你没有执行此命令的权限。"
		return

	var/target_rank = input["target_rank"]

	if(!target_rank)
		.["success"] = FALSE
		.["message"] = "提供的目标身份无效。"
		return

	target_rank = capitalize(target_rank)

	var/desired_rank_status = !!text2num(input["desired_rank_status"])

	if(desired_rank_status)
		var/result = SSplayer_ranks.add_player_to_group(linked_admin_holder, target_ckey, target_rank)

		.["success"] = !!result
		.["message"] = result ? "**[linked_admin_holder.target]**已成功为**[target_ckey]**添加**[chinese_skyrat_player_rank_display(target_rank)]**身份。" : "**[linked_admin_holder.target]**未能为**[target_ckey]**添加**[chinese_skyrat_player_rank_display(target_rank)]**身份。请确认ckey输入正确，且目标尚无该身份后重试。如果错误持续，请使用游戏内命令查看详细信息。"
		message_admins(replacetext(.["message"], "*", ""))
		return

	else
		var/result = SSplayer_ranks.remove_player_from_group(linked_admin_holder, target_ckey, target_rank)

		.["success"] = !!result
		.["message"] = result ? "**[linked_admin_holder.target]**已成功移除**[target_ckey]**的**[chinese_skyrat_player_rank_display(target_rank)]**身份。" : "**[linked_admin_holder.target]**未能移除**[target_ckey]**的**[chinese_skyrat_player_rank_display(target_rank)]**身份。请确认ckey输入正确，且目标拥有该身份后重试。如果错误持续，请使用游戏内命令查看详细信息。"
		message_admins(replacetext(.["message"], "*", ""))
		return
