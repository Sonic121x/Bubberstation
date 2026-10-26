/*
*	Whirring Convergence
*   Communicate a message to all other clock cultists
*/
/datum/action/innate/clockcult/comm
	name = "嗡鸣汇聚"
	desc = "低语的词句，连接着我们所有人内部的齿轮。<br><b>警告：</b>附近的非仆从仍然能听见你。"
	button_icon_state = "linked_minds"

/datum/action/innate/clockcult/comm/Activate()
	var/input = tgui_input_text(usr, "要传达给其他信徒的消息。", "齿轮之声")
	if(!input || !IsAvailable())
		return

	var/list/filter_result = CAN_BYPASS_FILTER(usr) ? null : is_ic_filtered(input)
	if(filter_result)
		REPORT_CHAT_FILTER_TO_USER(usr, filter_result)
		return

	var/list/soft_filter_result = CAN_BYPASS_FILTER(usr) ? null : is_soft_ic_filtered(input)
	if(soft_filter_result)

		if(tgui_alert(usr,"你的消息包含“[soft_filter_result[CHAT_FILTER_INDEX_WORD]]”。“[soft_filter_result[CHAT_FILTER_INDEX_REASON]]”，你确定要说出来吗？", "软屏蔽词", list("Yes", "No")) != "Yes")
			return
		message_admins("[ADMIN_LOOKUPFLW(usr)] 通过了 \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" 的软过滤，可能正在使用不被允许的用语。消息：\"[html_encode(input)]\"")
		log_admin_private("[key_name(usr)] 通过了 \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" 的软过滤，可能正在使用不被允许的用语。消息：\"[input]\"")

	cultist_commune(usr, input)

/// A user can input a message to send to other clock cultists over the clock cult communication channel
/datum/action/innate/clockcult/comm/proc/cultist_commune(mob/living/user, message)
	if(!message)
		return

	user.whisper("Engine, V vaibxr gb-gur`r gb-pbzzhar gb-nyy.", language = /datum/language/common) //Ratvar, I invoke to-the`e to-commune to-all.
	user.whisper(html_decode(message), filterproof = TRUE)
	send_clock_message(user, message)

/// Send `sent_message` to all other clock cultists and ghosts from the user
/proc/send_clock_message(mob/living/user, sent_message, span = "<span class='brass'>", msg_ghosts = TRUE)
	var/final_message = ""
	if(user)
		final_message = span + "<i><b>发条[user.gender == FEMALE ? "姐妹" : "兄弟"] [findtextEx(user.name, user.real_name) ? user.name : "[user.real_name]（化名 [user.name]）"]</b> 传讯：“" + sent_message + "”</i></span>"
	else
		final_message = span + sent_message + "</span>"

	for(var/mob/player_mob as anything in GLOB.player_list)

		if(IS_CLOCK(player_mob))
			to_chat(player_mob, final_message)

		else if(player_mob in GLOB.dead_mob_list)
			if(!msg_ghosts)
				continue
			if(user)
				to_chat(player_mob, "[FOLLOW_LINK(player_mob, user)] [final_message]")
			else
				to_chat(player_mob, final_message)
