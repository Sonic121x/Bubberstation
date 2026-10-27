/**
 * Takes input from cmd_mentor_pm_context, cmd_Mentor_pm_panel or /client/Topic and sends them a PM.
 * Fetching a message if needed. src is the sender and target is the target client
 *
 * Arguments:
 * * whom - The target of the mentor PM.
 * * msg - The content of the mentor PM.
 */
/client/proc/cmd_mentor_pm(whom, msg)
	var/client/target
	if(ismob(whom))
		var/mob/mob_target = whom
		target = mob_target.client
	else if(istext(whom))
		target = GLOB.directory[whom]
	else if(istype(whom,/client))
		target = whom
	if(!target)
		if(is_mentor())
			to_chat(src, span_danger("错误：导师私信：未找到客户端。"))
		else
			mentorhelp(msg)	//Mentor we are replying to left. Mentorhelp instead(check below)
		return

	if(is_mentor(whom))
		to_chat(GLOB.mentors, span_purple(span_mentor("[src] 开始回复 [whom] 的导师求助。")))

	//get message text, limit it's length.and clean/escape html
	if(!msg)
		msg = tgui_input_text(src, "消息：", "私信")

		if(!msg)
			if (is_mentor(whom))
				to_chat(GLOB.mentors, span_mentor(span_purple("[src] 停止回复 [whom] 的导师求助。")))
			return

		if(!target)
			if(is_mentor())
				to_chat(src, span_danger("错误：导师私信：未找到客户端。"))
			else
				mentorhelp(msg)	//Mentor we are replying to has vanished, Mentorhelp instead (how the fuck does this work?let's hope it works,shrug)
				return

		// Neither party is a mentor, they shouldn't be PMing!
		if (!target.is_mentor() && !is_mentor())
			return

	if(!msg)
		if (is_mentor(whom))
			to_chat(GLOB.mentors, span_mentor(span_purple("[src] 停止回复 [whom] 的导师求助。")))
		return
	log_mentor("导师私信：[key_name(src)]->[key_name(target)]：[msg]")

	msg = emoji_parse(msg)
	SEND_SOUND(target, 'sound/items/bikehorn.ogg')
	var/show_char = CONFIG_GET(flag/mentors_mobname_only)
	if(target.is_mentor())
		if(is_mentor())//both are mentors
			to_chat(target, span_mentor(span_purple("来自-<b>[key_name_mentor(src, target, TRUE, FALSE, FALSE)]</b> 的导师私信：[msg]")))
			to_chat(src, span_mentor(span_blue("发给-<b>[key_name_mentor(target, target, TRUE, FALSE, FALSE)]</b> 的导师私信：[msg]")))

		else		//recipient is a mentor but sender is not
			to_chat(target, span_mentor(span_purple("来自-<b>[key_name_mentor(src, target, TRUE, FALSE, show_char)]</b> 的回复私信：[msg]")))
			to_chat(src, span_mentor("发给-<b>[key_name_mentor(target, target, TRUE, FALSE, FALSE)]</b> 的导师私信：[msg]"))

	else
		if(is_mentor())	//sender is a mentor but recipient is not.
			to_chat(target, span_mentor(span_purple("来自-<b>[key_name_mentor(src, target, TRUE, FALSE, FALSE)]</b> 的导师私信：[msg]")))
			to_chat(src, span_mentor("发给-<b>[key_name_mentor(target, target, TRUE, FALSE, show_char)]</b> 的导师私信：[msg]"))

	//we don't use message_Mentors here because the sender/receiver might get it too // We should make it an argument for that proc to ignore the sender, then. :(
	var/show_char_sender = !is_mentor() && CONFIG_GET(flag/mentors_mobname_only)
	var/show_char_recip = !target.is_mentor() && CONFIG_GET(flag/mentors_mobname_only)
	for(var/it in GLOB.mentors)
		var/client/mentor = it
		if(mentor?.key != key && mentor?.key != target.key)	//check client/mentor is an Mentor and isn't the sender or recipient
			to_chat(mentor, span_mentor("<B>导师私信：[key_name_mentor(src, mentor, FALSE, FALSE, show_char_sender)]-&gt;[key_name_mentor(target, mentor, FALSE, FALSE, show_char_recip)]：</B> [span_blue(msg)]")) //inform mentor
