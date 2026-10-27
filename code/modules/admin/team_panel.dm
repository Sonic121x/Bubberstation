//Split into Team List -> Team Details ?
/datum/admins/proc/team_listing()
	var/list/content = list()
	for(var/datum/team/T in GLOB.antagonist_teams)
		content += "<h3>[T.name] - [T.type]</h3>"
		content += "<a href='byond://?_src_=holder;[HrefToken()];team_command=rename_team;team=[REF(T)]'>重命名</a>"
		content += "<a href='byond://?_src_=holder;[HrefToken()];team_command=delete_team;team=[REF(T)]'>删除</a>"
		content += "<a href='byond://?_src_=holder;[HrefToken()];team_command=communicate;team=[REF(T)]'>发送消息</a>"
		for(var/command in T.get_admin_commands())
			content += "<a href='byond://?src=[REF(T)];command=[command]'>[command]</a>"
		content += "<br>"
		content += "目标：<br><ol>"
		for(var/datum/objective/O in T.objectives)
			content += "<li>[O.explanation_text] - <a href='byond://?_src_=holder;[HrefToken()];team_command=remove_objective;team=[REF(T)];tobjective=[REF(O)]'>移除</a></li>"
		content += "</ol><a href='byond://?_src_=holder;[HrefToken()];team_command=add_objective;team=[REF(T)]'>添加目标</a><br>"
		content += "成员：<br><ul>"
		for(var/datum/mind/M in T.members)
			content += "<li>[M.name] - <a href='byond://?_src_=holder;[HrefToken()];team_command=remove_member;team=[REF(T)];tmember=[REF(M)]'>移除成员</a></li>"
		content += "</ul><a href='byond://?_src_=holder;[HrefToken()];team_command=add_member;team=[REF(T)]'>添加成员</a>"
		content += "<hr>"
	content += "<a href='byond://?_src_=holder;[HrefToken()];team_command=create_team'>创建小队</a><br>"
	return content.Join()


/datum/admins/proc/check_teams()
	if(!SSticker.HasRoundStarted())
		tgui_alert(usr,"游戏尚未开始！")
		return

	var/datum/browser/popup = new(usr, "teams", "小队列表", 500, 500)
	popup.set_content(team_listing())
	popup.open()

/datum/admins/proc/admin_create_team(mob/user)
	var/team_name = stripped_input(user,"小队名称？")
	if(!team_name)
		return
	var/datum/team/T = new()
	T.name = team_name

	message_admins("[key_name_admin(usr)]创建了新的[name]反派小队。")
	log_admin("[key_name(usr)]创建了新的[name]反派小队。")

/datum/team/proc/admin_rename(mob/user)
	var/old_name = name
	var/team_name = stripped_input(user,"新的小队名称？","小队重命名",old_name)
	if(!team_name)
		return
	name = team_name
	message_admins("[key_name_admin(usr)]将[old_name]小队重命名为[name]")
	log_admin("[key_name(usr)]将[old_name]小队重命名为[name]")

/datum/team/proc/admin_communicate(mob/user)
	var/message = input(user,"要给小队发送的消息？","小队消息") as text|null
	if(!message)
		return
	for(var/datum/mind/M in members)
		to_chat(M.current,message, confidential = TRUE)

	message_admins("[key_name_admin(usr)]向[name]小队发送了消息：[message]")
	log_admin("小队消息：[key_name(usr)] -> [name]小队：[message]")

/datum/team/proc/admin_add_objective(mob/user)
	//any antag with get_team == src => add objective to that antag
	//otherwise create new custom antag
	if(!GLOB.admin_objective_list)
		generate_admin_objective_list()

	var/selected_type = chinese_objective_choice(user, "选择目标类型：", "目标类型", GLOB.admin_objective_list)
	selected_type = GLOB.admin_objective_list[selected_type]
	if (!selected_type)
		return

	var/datum/objective/O = new selected_type
	O.team = src
	O.admin_edit(user)
	objectives |= O

	var/custom_antag_name

	for(var/datum/mind/M in members)
		var/datum/antagonist/team_antag
		for(var/datum/antagonist/A in M.antag_datums)
			if(A.get_team() == src)
				team_antag = A
		if(!team_antag)
			team_antag = new /datum/antagonist/custom
			if(!custom_antag_name)
				custom_antag_name = stripped_input(user, "自定义小队反派名称：", "自定义反派", "反派")
				if(!custom_antag_name)
					custom_antag_name = "小队成员"
			team_antag.name = custom_antag_name
			M.add_antag_datum(team_antag,src)
		team_antag.objectives |= O

	message_admins("[key_name_admin(usr)]向[name]添加了目标“[O.explanation_text]”")
	log_admin("[key_name(usr)]向[name]添加了目标“[O.explanation_text]”")

/datum/team/proc/admin_remove_objective(mob/user,datum/objective/O)
	for(var/datum/mind/M in members)
		for(var/datum/antagonist/A in M.antag_datums)
			A.objectives -= O
	objectives -= O

	message_admins("[key_name_admin(usr)]从[name]移除了目标“[O.explanation_text]”")
	log_admin("[key_name(usr)]从[name]移除了目标“[O.explanation_text]”")
	//qdel maybe

/datum/team/proc/admin_add_member(mob/user)
	var/list/minds = list()
	for(var/mob/M in GLOB.mob_list)
		if(M.mind)
			minds |= M.mind
	var/datum/mind/value = input("选择新成员：", "新小队成员", null) as null|anything in sort_names(minds)
	if (!value)
		return

	message_admins("[key_name_admin(usr)]将[key_name_admin(value)]添加为[name]小队的成员")
	log_admin("[key_name(usr)]将[key_name(value)]添加为[name]小队的成员")

	add_member(value)

/datum/team/proc/admin_remove_member(mob/user,datum/mind/M)
	message_admins("[key_name_admin(usr)]将[key_name_admin(M)]从[name]小队中移除")
	log_admin("[key_name(usr)]将[key_name(M)]从[name]小队中移除")
	remove_member(M)

//After a bit of consideration i block team deletion if there's any members left until unified objective handling is in.
/datum/team/proc/admin_delete(mob/user)
	if(members.len > 0)
		to_chat(user,"小队中仍有成员，请先移除他们，并确保你清楚自己在做什么。", confidential = TRUE)
		return
	qdel(src)

/datum/team/Topic(href, href_list)
	if(!check_rights(R_ADMIN))
		return

	var/commands = get_admin_commands()
	for(var/admin_command in commands)
		if(href_list["command"] == admin_command)
			var/datum/callback/C = commands[admin_command]
			C.Invoke(usr)
			return

/datum/team/proc/get_admin_commands()
	return list()
