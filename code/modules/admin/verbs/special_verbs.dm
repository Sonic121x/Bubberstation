// Admin Verbs in this file are special and cannot use the AVD system for some reason or another.

GAME_VERB_PROC(/client, show_verbs, "管理员指令 - 显示", ADMIN_CATEGORY_MAIN)

	UNASSIGN_GAME_VERB(src, /client, show_verbs)
	add_admin_verbs()

	to_chat(src, span_interface("你的所有管理员指令现在都可见了。"), confidential = TRUE)
	BLACKBOX_LOG_ADMIN_VERB("Show Adminverbs")

GAME_VERB_PROC_DESC(/client, readmin, "重新成为管理员", "重新获得你的管理员权限。", "管理员")

	var/datum/admins/A = GLOB.deadmins[ckey]

	if(!A)
		A = GLOB.admin_datums[ckey]
		if (!A)
			var/msg = " 正在尝试重新成为管理员，但并没有对应的取消管理员记录"
			message_admins("[key_name_admin(src)][msg]")
			log_admin_private("[key_name(src)][msg]")
			return

	A.associate(src)

	if (!holder)
		return //This can happen if an admin attempts to vv themself into somebody elses's deadmin datum by getting ref via brute force

	to_chat(src, span_interface("你现在是管理员了。"), confidential = TRUE)
	message_admins("[src] 重新成为管理员了。")
	log_admin("[src] 重新成为管理员了。")
	BLACKBOX_LOG_ADMIN_VERB("Readmin")

GAME_VERB_PROC(/client, admin_2fa_verify, "验证管理员", "管理员")

	var/datum/admins/admin = GLOB.admin_datums[ckey]
	admin?.associate(src)
