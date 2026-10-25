
ADMIN_VERB(dsay, R_NONE, "死者交谈", "与死者交谈。", ADMIN_CATEGORY_GAME)
	VERB_ARG(message, VERB_ARG_TYPE_TEXT, VERB_ARG_SOURCE_INPUT)
	if(user.prefs.muted & MUTE_DEADCHAT)
		to_chat(user, span_danger("你无法发送 DSAY 消息（已被禁言）。"), confidential = TRUE)
		return

	if (user.handle_spam_prevention(message,MUTE_DEADCHAT))
		return

	message = copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN)
	user.mob.log_talk(message, LOG_DSAY)

	if (!message)
		return
	var/rank_name = user.holder.rank_names()
	var/admin_name = user.key
	if(user.holder.fakekey)
		rank_name = pick(strings("admin_nicknames.json", "ranks", "config"))
		admin_name = pick(strings("admin_nicknames.json", "names", "config"))
	var/name_and_rank = "[span_tooltip(rank_name, "管理员")] ([admin_name])"

	deadchat_broadcast("[span_prefix("死者：")] [name_and_rank] 说：<span class='message'>\"[emoji_parse(message)]\"</span>")

	BLACKBOX_LOG_ADMIN_VERB("Dsay")

/client/proc/get_dead_say()
	var/msg = input(src, null, "dsay \"text\"") as text|null
	if (isnull(msg))
		return
	SSadmin_verbs.dynamic_invoke_verb(src, /datum/admin_verb/dsay, msg)
