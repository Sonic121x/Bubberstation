ADMIN_VERB(request_more_opfor, R_FUN, "征集敌对势力", "邀请启用反派选项的玩家申请敌对势力。", ADMIN_CATEGORY_FUN)
	var/confirm = tgui_alert(user, "确定要邀请所有启用反派选项的玩家提交敌对势力申请吗？", "确认征集敌对势力", list("是", "否"))
	if(confirm != "是")
		return

	var/asked = 0
	for(var/mob/living/carbon/human/human in GLOB.alive_player_list)
		if(human.client?.prefs?.read_preference(/datum/preference/toggle/be_antag))
			to_chat(human, custom_boxed_message("green_box", span_greentext("管理员正在征集敌对势力玩家，有兴趣的话请在OOC选项卡中报名！")))
			asked++
	message_admins("[ADMIN_LOOKUP(user)]征集了更多敌对势力玩家！（已邀请：[asked]名玩家）")


ADMIN_VERB(view_opfors, R_ADMIN, "查看敌对势力", "查看敌对势力申请。", ADMIN_CATEGORY_GAME)
	user.mob.client?.view_opfors()

/client/proc/view_opfors()
	if(holder)
		var/list/dat = list("<html>")
		dat += SSopposing_force.get_check_antag_listing()
		dat += "</html>"
		usr << browse(dat.Join(), "window=roundstatus;size=500x500")
		log_admin("[key_name(usr)]查看了敌对势力申请。")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "View OPFORs")
