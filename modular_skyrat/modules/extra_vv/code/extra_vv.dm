/**
 * EXTRA MOB VV
 */
/mob/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_SEND_CRYO, "送往低温储存")
	VV_DROPDOWN_OPTION(VV_HK_LOAD_PREFS, "将偏好设置加载到生物上")

/mob/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_SEND_CRYO])
		vv_send_cryo()


	if(href_list[VV_HK_LOAD_PREFS])
		vv_load_prefs()

/**
 * Sends said person to a cryopod.
 */
/mob/proc/vv_send_cryo()
	if(!check_rights(R_SPAWN))
		return

	var/send_notice = tgui_alert(usr, "要附上一张关于将 [name] 送入低温休眠舱的纸条吗？", "留一张纸条？", list("是", "否", "取消"))
	if(send_notice != "是" && send_notice != "否")
		return

	//log/message
	to_chat(usr, "已将 [src] 放入低温休眠舱。")
	log_admin("[key_name(usr)] 已将 [key_name(src)] 放入低温休眠舱。")
	var/msg = span_notice("[key_name_admin(usr)] 已将 [key_name(src)] 从 [ADMIN_VERBOSEJMP(src)] 放入低温休眠舱。")
	message_admins(msg)
	admin_ticket_log(src, msg)

	send_notice = send_notice == "是"
	send_to_cryo(send_notice)

/**
 * Overrides someones mob with their loaded prefs.
 */
/mob/proc/vv_load_prefs()
	if(!check_rights(R_ADMIN))
		return

	if(!client)
		to_chat(usr, span_warning("未找到客户端！"))
		return

	if(!ishuman(src))
		to_chat(usr, span_warning("该生物不是人类！"))
		return

	var/notice = tgui_alert(usr, "你确定要将客户端当前的偏好设置加载到其生物上吗？", "加载偏好设置", list("是", "否"))
	if(notice != "是")
		return

	client?.prefs?.apply_prefs_to(src)
	SSquirks.OverrideQuirks(src, client)
	var/msg = span_notice("[key_name_admin(usr)] 已将 [key_name(src)] 的偏好设置加载到其当前生物上 [ADMIN_VERBOSEJMP(src)]。")
	message_admins(msg)
	admin_ticket_log(src, msg)
