ADMIN_VERB(panic_bunker, R_SERVER, "切换恐慌地堡", "为服务器切换恐慌地堡。", ADMIN_CATEGORY_SERVER)
	if (!CONFIG_GET(flag/sql_enabled))
		to_chat(user, span_adminnotice("数据库未启用！"), confidential = TRUE)
		return

	var/new_pb = !CONFIG_GET(flag/panic_bunker)
	var/interview = CONFIG_GET(flag/panic_bunker_interview)
	var/time_rec = 0
	var/message = ""
	if(new_pb)
		time_rec = input(user, "他们需要游玩多少存活分钟？填 0 表示关闭此限制。", "事情是不是搞砸了", CONFIG_GET(number/panic_bunker_living)) as num
		message = input(user, "他们登录时会看到什么？", "嗯嗯", CONFIG_GET(string/panic_bunker_message)) as text
		message = replacetext(message, "%minutes%", time_rec)
		CONFIG_SET(number/panic_bunker_living, time_rec)
		CONFIG_SET(string/panic_bunker_message, message)

		var/interview_sys = tgui_alert(user, "是否应启用面试系统？（允许玩家在未满小时限制时连接，但必须经人工批准才能游玩）", "启用面试？", list("Enable", "Disable"))
		interview = interview_sys == "Enable"
		CONFIG_SET(flag/panic_bunker_interview, interview)
	CONFIG_SET(flag/panic_bunker, new_pb)
	log_admin("[key_name(user)] 切换了恐慌地堡，现在它[new_pb ? "已开启，存活分钟数要求为 [time_rec]，登录提示为 [message]。面试系统[interview ? "已启用" : "已禁用"]" : "已关闭"]。")
	message_admins("[key_name_admin(user)] 切换了恐慌地堡，现在它[new_pb ? "已启用，存活分钟数要求为 [time_rec]。面试系统[interview ? "已启用" : "已禁用"]" : "已禁用"]。")
	if (new_pb && !SSdbcore.Connect())
		message_admins("数据库尚未连接！在重新建立连接之前，恐慌地堡将无法运作。")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Panic Bunker", "[new_pb ? "Enabled" : "Disabled"]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

ADMIN_VERB(toggle_interviews, R_SERVER, "切换地堡面试", "切换新玩家是接受面试还是被阻止连接。", ADMIN_CATEGORY_SERVER)
	if (!CONFIG_GET(flag/panic_bunker))
		to_chat(user, span_adminnotice("注意：恐慌地堡尚未启用，因此在启用之前，此更改不会产生任何效果。"), confidential = TRUE)
	var/new_interview = !CONFIG_GET(flag/panic_bunker_interview)
	CONFIG_SET(flag/panic_bunker_interview, new_interview)
	log_admin("[key_name(user)] 切换了恐慌地堡的面试系统，现在它[new_interview ? "已启用" : "已禁用"]。")
	message_admins("[key_name(user)] 切换了恐慌地堡的面试系统，现在它[new_interview ? "已启用" : "已禁用"]。")
