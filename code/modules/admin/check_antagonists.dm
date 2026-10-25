//I wish we had interfaces sigh, and i'm not sure giving team and antag common root is a better solution here

//Name shown on antag list
/datum/antagonist/proc/antag_listing_name()
	if(!owner)
		return "未分配"
	if(owner.current)
		return "<a href='byond://?_src_=holder;[HrefToken()];adminplayeropts=[REF(owner.current)]'>[owner.current.real_name]</a> "
	else
		return "<a href='byond://?_src_=vars;[HrefToken()];Vars=[REF(owner)]'>[owner.name]</a> "

//Whatever interesting things happened to the antag admins should know about
//Include additional information about antag in this part
/datum/antagonist/proc/antag_listing_status()
	if(!owner)
		return "（未分配）"
	if(!owner.current)
		return "<font color=red>（躯体已被摧毁）</font>"
	else
		if(owner.current.stat == DEAD)
			return "<font color=red>（已死亡）</font>"
		else if(!owner.current.client)
			return "（无客户端）"

//Builds the common FLW PM TP commands part
//Probably not going to be overwritten by anything but you never know
/datum/antagonist/proc/antag_listing_commands()
	if(!owner)
		return
	var/list/parts = list()
	parts += "<a href='byond://?priv_msg=[ckey(owner.key)]'>PM</a>"
	if(owner.current) //There's body to follow
		parts += "<a href='byond://?_src_=holder;[HrefToken()];adminplayerobservefollow=[REF(owner.current)]'>FLW</a>"
	else
		parts += ""
	parts += "<a href='byond://?_src_=holder;[HrefToken()];traitor=[REF(owner)]'>查看目标</a>"
	return parts //Better as one cell or two/three

//Builds table row for the antag
// Jim (Status) FLW PM TP
/datum/antagonist/proc/antag_listing_entry()
	var/list/parts = list()
	if(show_name_in_check_antagonists)
		parts += "[antag_listing_name()]([name])"
	else
		parts += antag_listing_name()
	parts += antag_listing_status()
	parts += antag_listing_commands()
	return "<tr><td>[parts.Join("</td><td>")]</td></tr>"

/datum/admins/proc/build_antag_listing()
	var/list/sections = list()
	var/list/priority_sections = list()

	var/list/all_teams = list()
	var/list/all_antagonists = list()

	for(var/datum/antagonist/A in GLOB.antagonists)
		if(!A.owner)
			continue
		all_teams |= A.get_team()
		all_antagonists += A

	for(var/datum/team/T in all_teams)
		for(var/datum/antagonist/X in all_antagonists)
			if(X.get_team() == T)
				all_antagonists -= X
		sections += T.antag_listing_entry()

	sortTim(all_antagonists, GLOBAL_PROC_REF(cmp_antag_category))

	var/current_category
	var/list/current_section = list()
	for(var/i in 1 to all_antagonists.len)
		var/datum/antagonist/current_antag = all_antagonists[i]
		var/datum/antagonist/next_antag
		if(i < all_antagonists.len)
			next_antag = all_antagonists[i+1]
		if(!current_category)
			current_category = current_antag.roundend_category
			current_section += "<b>[chinese_roundend_category_display(current_category)]</b><br>"
			current_section += "<table cellspacing=5>"
		current_section += current_antag.antag_listing_entry() // Name - (Traitor) - FLW | PM | TP

		if(!next_antag || next_antag.roundend_category != current_antag.roundend_category) //End of section
			current_section += "</table>"
			sections += current_section.Join()
			current_section.Cut()
			current_category = null
	var/list/all_sections = priority_sections + sections
	return all_sections.Join("<br>")

/datum/admins/proc/check_antagonists()
	if(!SSticker.HasRoundStarted())
		tgui_alert(usr, "游戏还没有开始！")
		return
	var/list/dat = list("<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><title>回合状态</title></head><body><h1><B>回合状态</B></h1>")
	dat += "<a href='byond://?_src_=holder;[HrefToken()];gamemode_panel=1'>动态面板</a><br>"
	dat += "回合时长：<B>[DisplayTimeText(world.time - SSticker.round_start_time)]</B><BR>"
	dat += "<B>紧急穿梭机</B><BR>"
	if(EMERGENCY_IDLE_OR_RECALLED)
		dat += "<a href='byond://?_src_=holder;[HrefToken()];call_shuttle=1'>呼叫穿梭机</a><br>"
	else
		var/timeleft = SSshuttle.emergency.timeLeft()
		if(SSshuttle.emergency.mode == SHUTTLE_CALL)
			dat += "预计抵达时间：<a href='byond://?_src_=holder;[HrefToken()];edit_shuttle_time=1'>[(timeleft / 60) % 60]:[add_leading(num2text(timeleft % 60), 2, "0")]</a><BR>"
			dat += "<a href='byond://?_src_=holder;[HrefToken()];call_shuttle=2'>召回</a><br>"
		else
			dat += "预计抵达时间：<a href='byond://?_src_=holder;[HrefToken()];edit_shuttle_time=1'>[(timeleft / 60) % 60]:[add_leading(num2text(timeleft % 60), 2, "0")]</a><BR>"
	dat += "<a href='byond://?_src_=holder;[HrefToken()];end_round=[REF(usr)]'>立即结束回合</a><br>"
	if(SSticker.delay_end)
		dat += "<a href='byond://?_src_=holder;[HrefToken()];undelay_round_end=1'>取消延迟回合结束</a><br>"
	else
		dat += "<a href='byond://?_src_=holder;[HrefToken()];delay_round_end=1'>延迟回合结束</a><br>"
	dat += "<a href='byond://?_src_=holder;[HrefToken()];ctf_toggle=1'>启用/禁用 CTF</a><br>"
	dat += "<a href='byond://?_src_=holder;[HrefToken()];rebootworld=1'>重启世界</a><br>"
	dat += "<a href='byond://?_src_=holder;[HrefToken()];check_teams=1'>检查队伍</a>"
	var/connected_players = GLOB.clients.len
	var/lobby_players = 0
	var/observers = 0
	var/observers_connected = 0
	var/living_players = 0
	var/living_players_connected = 0
	var/antagonists = 0
	var/antagonists_dead = 0
	var/brains = 0
	var/other_players = 0
	var/living_skipped = 0
	var/drones = 0
	var/security = 0
	var/security_dead = 0
	for(var/mob/checked_mob in GLOB.mob_list)
		if(checked_mob.ckey)
			if(isnewplayer(checked_mob))
				lobby_players++
				continue
			else if(checked_mob.mind && !isbrain(checked_mob) && !isobserver(checked_mob))
				if(checked_mob.stat != DEAD)
					if(isdrone(checked_mob))
						drones++
						continue
					if(is_centcom_level(checked_mob.z))
						living_skipped++
						continue
					living_players++
					if(checked_mob.client)
						living_players_connected++
				else if (checked_mob.ckey)
					// This finds all dead mobs that still have a ckey inside them
					// Ie, they have died, but have not ghosted
					observers++
					if (checked_mob.client)
						observers_connected++

				if(checked_mob.is_antag())
					antagonists++
					if(checked_mob.stat == DEAD)
						antagonists_dead++
				if(checked_mob.mind.assigned_role?.departments_list?.Find(/datum/job_department/security))
					security++
					if(checked_mob.stat == DEAD)
						security_dead++
			else if(checked_mob.stat == DEAD || isobserver(checked_mob))
				observers++
				if(checked_mob.client)
					observers_connected++
			else if(isbrain(checked_mob))
				brains++
			else
				other_players++
	dat += "<BR><b><font color='blue' size='3'>玩家：|[connected_players - lobby_players] 在游戏中|[connected_players] 已连接|[lobby_players] 大厅|</font></b>"
	dat += "<BR><b><font color='green'>存活玩家：|[living_players_connected] 活跃|[living_players - living_players_connected] 已断线|</font></b>"
	dat += "<BR><b><font color='#e29300'>反派玩家：|[antagonists] 在游戏中|[antagonists-antagonists_dead] 存活|[antagonists_dead] 已死亡|</font></b>"
	dat += "<BR><b><font color='#860e03'>安保玩家：|[security] 在游戏中|[security-security_dead] 存活|[security_dead] 已死亡|</font></b>"
	dat += "<BR><b><font color='#bf42f4'>已跳过 \[位于中央指挥部 Z 层\]：[living_skipped] 名存活玩家|[drones] 个存活无人机|</font></b>"
	dat += "<BR><b><font color='red'>死亡/旁观玩家：|[observers_connected] 活跃|[observers - observers_connected] 已断线|[brains] 个大脑|</font></b>"
	if(other_players)
		dat += "<BR>[span_userdanger("[other_players] 名玩家处于无效状态，或统计代码存在缺陷！")]"
	dat += "<br><br>"

	dat += build_antag_listing()

	dat += SSopposing_force.get_check_antag_listing() //SKYRAT EDIT ADDITION

	dat += "</body></html>"
	var/datum/browser/browser = new(usr, "roundstatus", "回合状态", 500, 500)
	browser.set_content(dat.Join())
	browser.open()
