#define DEFAULT_WHO_CELLS_PER_ROW 4
#define NO_ADMINS_ONLINE_MESSAGE "管理员求助也会通过 TGS 发送到 IRC、Discord 等服务。如果游戏内没有可用的管理员，发送管理员求助仍可能被注意到并得到回应。"

GAME_VERB(/client, who, "Who", "OOC")

	var/msg = ""

	var/list/Lines = list()
	var/columns_per_row = DEFAULT_WHO_CELLS_PER_ROW

	if(holder)
		if (check_rights(R_ADMIN,0) && isobserver(src.mob))//If they have +ADMIN and are a ghost they can see players IC names and statuses.
			columns_per_row = 1
			var/mob/dead/observer/G = src.mob
			if(!G.started_as_observer)//If you aghost to do this, KorPhaeron will deadmin you in your sleep.
				log_admin("[key_name(usr)] checked advanced who in-round")
			for(var/client/client in GLOB.clients)
				var/entry = "\t[client.key]"
				if(client.holder && client.holder.fakekey)
					entry += " <i>（化名 [client.holder.fakekey]）</i>"
				if (isnewplayer(client.mob))
					entry += " - <font color='darkgray'><b>在大厅中</b></font>"
				else
					entry += " - 正在扮演 [client.mob.real_name]"
					switch(client.mob.stat)
						if(HARD_CRIT)
							entry += " - <font color='darkgray'><b>失去意识</b></font>"
						if(DEAD)
							if(isobserver(client.mob))
								var/mob/dead/observer/O = client.mob
								if(O.started_as_observer)
									entry += " - <font color='gray'>观察中</font>"
								else
									entry += " - <font color='black'><b>死亡</b></font>"
							else
								entry += " - <font color='black'><b>死亡</b></font>"
					if(client.mob.is_antag())
						entry += " - <b><font color='red'>反派</font></b>"
				entry += " [ADMIN_QUE(client.mob)]"
				entry += " ([round(client.avgping, 1)]ms)"
				Lines += entry
		else//If they don't have +ADMIN, only show hidden admins
			for(var/client/client in GLOB.clients)
				var/entry = "[client.key]"
				if(client.holder && client.holder.fakekey)
					entry += " <i>（化名 [client.holder.fakekey]）</i>"
				entry += " ([round(client.avgping, 1)]ms)"
				Lines += entry
	else
		for(var/client/client in GLOB.clients)
			if(client.holder && client.holder.fakekey)
				Lines += "[client.holder.fakekey] ([round(client.avgping, 1)]ms)"
			else
				Lines += "[client.key] ([round(client.avgping, 1)]ms)"

	var/num_lines = 0
	msg += "<table style='width: 100%; table-layout: fixed'><tr>"
	for(var/line in sort_list(Lines))
		msg += "<td>[line]</td>"

		num_lines += 1
		if (num_lines == columns_per_row)
			num_lines = 0
			msg += "</tr><tr>"
	msg += "</tr></table>"

	msg += "<b>玩家总数：[length(Lines)]</b>"
	to_chat(src, fieldset_block(span_bold("当前玩家"), span_infoplain(msg), "boxed_message"), type = MESSAGE_TYPE_INFO)

GAME_VERB(/client, adminwho, "Adminwho", "Admin")

	var/list/lines = list()
	var/payload_string = generate_adminwho_string()
	var/header = (payload_string == NO_ADMINS_ONLINE_MESSAGE) ? "当前无管理员在线" : "当前管理员"

	lines += span_bold(header)
	lines += payload_string

	to_chat(src, fieldset_block(span_bold(header), jointext(lines, "\n"), "boxed_message"), type = MESSAGE_TYPE_INFO)

/// Proc that generates the applicable string to dispatch to the client for adminwho.
/client/proc/generate_adminwho_string()
	var/list/list_of_admins = get_list_of_admins()
	if(isnull(list_of_admins))
		return NO_ADMINS_ONLINE_MESSAGE

	var/list/message_strings = list()
	if(isnull(holder))
		message_strings += get_general_adminwho_information(list_of_admins)
		message_strings += NO_ADMINS_ONLINE_MESSAGE
	else
		message_strings += get_sensitive_adminwho_information(list_of_admins)

	return jointext(message_strings, "\n")

/// Proc that returns a list of cliented admins. Remember that this list can contain nulls!
/// Also, will return null if we don't have any admins.
/proc/get_list_of_admins()
	var/returnable_list = list()

	for(var/client/admin in GLOB.admins)
		returnable_list += admin

	if(length(returnable_list) == 0)
		return null

	return returnable_list

/// Proc that will return the applicable display name, linkified or not, based on the input client reference.
/proc/get_linked_admin_name(client/admin)
	var/feedback_link = admin.holder.feedback_link()
	return isnull(feedback_link) ? admin : "<a href=[feedback_link]>[admin]</a>"

/// Proc that gathers adminwho information for a general player, which will only give information if an admin isn't AFK, and handles potential fakekeying.
/// Will return a list of strings.
/proc/get_general_adminwho_information(list/checkable_admins)
	var/returnable_list = list()

	for(var/client/admin in checkable_admins)
		if(admin.is_afk() || !isnull(admin.holder.fakekey))
			continue //Don't show afk or fakekeyed admins to adminwho

		returnable_list += "• [get_linked_admin_name(admin)] 是 [admin.holder.rank_names()]"

	return returnable_list

/// Proc that gathers adminwho information for admins, which will contain information on if the admin is AFK, readied to join, etc. Only arg is a list of clients to use.
/// Will return a list of strings.
/proc/get_sensitive_adminwho_information(list/checkable_admins)
	var/returnable_list = list()

	for(var/client/admin in checkable_admins)
		var/list/admin_strings = list()

		admin_strings += "• [get_linked_admin_name(admin)] 是 [admin.holder.rank_names()]"

		if(admin.holder.fakekey)
			admin_strings += "<i>（化名 [admin.holder.fakekey]）</i>"

		if(isobserver(admin.mob))
			admin_strings += "- 观察中"
		else if(isnewplayer(admin.mob))
			if(SSticker.current_state <= GAME_STATE_PREGAME)
				var/mob/dead/new_player/lobbied_admin = admin.mob
				if(lobbied_admin.ready == PLAYER_READY_TO_PLAY)
					admin_strings += "- 大厅（已准备）"
				else
					admin_strings += "- 大厅（未准备）"
			else
				admin_strings += "- 大厅"
		else
			admin_strings += "- 游戏中"

		if(admin.is_afk())
			admin_strings += "（暂离）"

		returnable_list += jointext(admin_strings, " ")

	return returnable_list

#undef DEFAULT_WHO_CELLS_PER_ROW
#undef NO_ADMINS_ONLINE_MESSAGE
