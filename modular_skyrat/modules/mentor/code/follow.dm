/client/proc/mentor_follow(mob/living/M)
	if(!is_mentor())
		return
	var/orbiting = TRUE
	if(!isobserver(usr))
		mentor_datum.following = M
		usr.reset_perspective(M)
		ASSIGN_GAME_VERB(src, /client, mentor_unfollow)
		to_chat(usr, span_info("点击这里或导师选项卡中的<a href='byond://?_src_=mentor;mentor_unfollow=1;[MentorHrefToken(TRUE)]'>“停止跟随”</a>按钮，即可停止跟随 [key_name(M)]。"))
		orbiting = FALSE
	else
		var/mob/dead/observer/O = usr
		O.ManualFollow(M)
	to_chat(GLOB.admins, span_mentor(span_prefix("MENTOR:</span> <EM>[key_name(usr)]</EM> 现在正在[orbiting ? "环绕观察" : "跟随"] <EM>[key_name(M)][key_name(M)][orbiting ? "（以幽灵形态）" : ""]。")))
	log_mentor("[key_name(usr)] [orbiting ? "现在正在环绕观察" : "开始跟随"] [key_name(M)][orbiting ? "（以幽灵形态）" : ""]。")

GAME_VERB_PROC_DESC(/client, mentor_unfollow, "停止跟随", "停止跟随当前跟随的对象。", "Mentor")
	if(!is_mentor())
		return
	usr.reset_perspective()
	UNASSIGN_GAME_VERB(src, /client, mentor_unfollow)
	to_chat(GLOB.admins, span_mentor(span_prefix("MENTOR:</span> <EM>[key_name(usr)]</EM> 不再跟随 <EM>[key_name(mentor_datum.following)]。")))
	log_mentor("[key_name(usr)] 停止跟随 [key_name(mentor_datum.following)]。")
	mentor_datum.following = null
