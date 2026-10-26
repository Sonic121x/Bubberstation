//GAME_VERB_DESC(/client, looc, "LOOC", "Local OOC, seen only by those in view.", "OOC", msg as text)
GAME_VERB_DESC(/client, looc, "LOOC", "本地场外聊天，仅视野内的人可见。", "OOC")
	VERB_ARG(msg, VERB_ARG_TYPE_TEXT, VERB_ARG_SOURCE_INPUT)
	looc_message(msg)

//GAME_VERB_DESC(/client, looc_wallpierce, "LOOC (Wallpierce)", "Local OOC, seen by anyone within 7 tiles of you.", "OOC", msg as text)
GAME_VERB_DESC(/client, looc_wallpierce, "LOOC（穿墙）", "本地场外聊天，周围 7 格内的人可见。", "OOC")
	VERB_ARG(msg, VERB_ARG_TYPE_TEXT, VERB_ARG_SOURCE_INPUT)
	looc_message(msg, TRUE)

/client/proc/looc_message(msg, wall_pierce)
	if(GLOB.say_disabled)
		to_chat(usr, span_danger("管理员目前已禁用发言。"))
		return

	if(!mob)
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	if(!holder)
		if(!GLOB.looc_allowed)
			to_chat(src, span_danger("LOOC 已全服禁言。"))
			return
		if(handle_spam_prevention(msg, MUTE_OOC))
			return
		if(findtext(msg, "byond://"))
			to_chat(src, span_boldannounce("<B>禁止宣传其他服务器。</B>"))
			log_admin("[key_name(src)] has attempted to advertise in LOOC: [msg]")
			return
		if(prefs.muted & MUTE_LOOC)
			to_chat(src, span_danger("你无法使用 LOOC（已被禁言）。"))
			return
		if(is_banned_from(ckey, BAN_LOOC))
			to_chat(src, span_warning("你已被禁止使用 LOOC！"))
			return
		if(mob.stat == DEAD)
			to_chat(src, span_danger("死亡时无法使用 LOOC。"))
			return
		if(istype(mob, /mob/dead))
			to_chat(src, span_danger("幽灵状态下无法使用 LOOC。"))
			return

	msg = emoji_parse(msg)

	mob.log_talk(msg,LOG_OOC, tag="LOOC")
	var/list/heard
	if(wall_pierce)
		heard = get_hearers_in_looc_range(mob.get_top_level_mob())
	else
		heard = get_hearers_in_view(LOOC_RANGE, mob.get_top_level_mob())

	//so the ai can post looc text
	if(istype(mob, /mob/living/silicon/ai))
		var/mob/living/silicon/ai/ai = mob
		if(wall_pierce)
			heard = get_hearers_in_looc_range(ai.eyeobj)
		else
			heard = get_hearers_in_view(LOOC_RANGE, ai.eyeobj)
	//so the ai can see looc text
	for(var/mob/living/silicon/ai/ai as anything in GLOB.ai_list)
		if(ai.client && !(ai in heard) && (ai.eyeobj in heard))
			heard += ai

	var/list/admin_seen = list()
	for(var/mob/hearing in heard)
		if(!hearing.client)
			continue
		var/client/hearing_client = hearing.client

		var/is_holder = hearing_client.holder
		if (is_holder)
			admin_seen[hearing_client] = TRUE
			// dont continue here, still need to show runechat


		if (isobserver(hearing) && !is_holder)
			continue //ghosts dont hear looc, apparantly

		// do the runetext here so admins can still get the runetext
		if(mob.runechat_prefs_check(hearing) && hearing.client?.prefs.read_preference(/datum/preference/toggle/enable_looc_runechat))
			// EMOTE is close enough. We don't want it to treat the raw message with languages.
			// I wish it didn't include the asterisk but it's modular this way.
			hearing.create_chat_message(mob, raw_message = "(LOOC: [msg])", runechat_flags = EMOTE_MESSAGE)

		if (is_holder)
			continue //admins are handled afterwards

		if(holder && isdead(src.mob)) // Admins ghosted display ckey
			to_chat(hearing_client, span_looc(span_prefix("LOOC[wall_pierce ? "（穿墙）" : ""]:</span> <EM>[src.ckey]:</EM> <span class='message'>[msg]")))
		else
			to_chat(hearing_client, span_looc(span_prefix("LOOC[wall_pierce ? "（穿墙）" : ""]:</span> <EM>[src.mob.name]:</EM> <span class='message'>[msg]")))

	for(var/client/cli_client as anything in GLOB.admins)
		if (admin_seen[cli_client])
			to_chat(cli_client, span_looc("[ADMIN_FLW(usr)] <span class='prefix'>LOOC[wall_pierce ? "（穿墙）" : ""]:</span> <EM>[src.key]/[src.mob.name]:</EM> <span class='message'>[msg]</span>"))
		else if (cli_client.prefs.read_preference(/datum/preference/toggle/admin/see_looc))
			to_chat(cli_client, span_rlooc("[ADMIN_FLW(usr)] <span class='prefix'>(R)LOOC[wall_pierce ? "（穿墙）" : ""]:</span> <EM>[src.key]/[src.mob.name]:</EM> <span class='message'>[msg]</span>"))
