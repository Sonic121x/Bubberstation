/datum/buildmode_mode/proccall
	key = "proccall"
	///The procedure itself, which we will call in the future. For example "qdel"
	var/proc_name = null
	///The list of arguments for the procedure. They may not be. They are selected in the same way in the game, and can be a datum, and other types.
	var/list/proc_args = null

/datum/buildmode_mode/proccall/show_help(client/builder)
	to_chat(builder, span_purple(boxed_message(
		"[span_bold("选择过程与参数")] -> 在建造模式按钮上按鼠标右键\n\
		[span_bold("对物体应用过程")] -> 在机械上按鼠标左键"))
	)

/datum/buildmode_mode/proccall/change_settings(client/target_client)
	if(!check_rights_for(target_client, R_DEBUG))
		return

	proc_name = input("过程名称，例如：fake_blood", "过程：", null) as text|null
	if(!proc_name)
		return

	proc_args = target_client.get_callproc_args()
	if(!proc_args)
		return

/datum/buildmode_mode/proccall/handle_click(client/target_client, params, datum/object as null|area|mob|obj|turf)
	if(!proc_name || !proc_args)
		tgui_alert(target_client, "未定义的过程调用或参数。")
		return

	if(!hascall(object, proc_name))
		to_chat(target_client, span_warning("错误：callproc_datum()：[object.type] 类型没有名为 [proc_name] 的过程。"), confidential = TRUE)
		return

	if(!is_valid_src(object))
		to_chat(target_client, span_warning("错误：callproc_datum()：该过程的所有者已不存在。"), confidential = TRUE)
		return


	var/msg = "[key_name(target_client)] 以 [proc_args.len ? "参数 [list2params(proc_args)]" : "无参数"] 调用了 [object] 的 [proc_name]()。"
	log_admin(msg)
	message_admins(msg)
	admin_ticket_log(object, msg)
	BLACKBOX_LOG_ADMIN_VERB("Atom ProcCall")

	var/returnval = WrapAdminProcCall(object, proc_name, proc_args) // Pass the lst as an argument list to the proc
	. = target_client.get_callproc_returnval(returnval, proc_name)
	if(.)
		to_chat(target_client, ., confidential = TRUE)
