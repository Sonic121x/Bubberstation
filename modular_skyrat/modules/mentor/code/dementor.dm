GAME_VERB_PROC(/client, cmd_mentor_dementor, "解除导师", "Mentor")
	if(!is_mentor())
		return
	remove_mentor_verbs()
	if (/client/proc/mentor_unfollow in verbs)
		mentor_unfollow()
	GLOB.mentors -= src
	to_chat(src, span_interface("你不再是导师了。"))
	log_mentor("MENTOR: [src] 已解除导师身份。")
	ASSIGN_GAME_VERB(src, /client, cmd_mentor_rementor)

GAME_VERB_PROC(/client, cmd_mentor_rementor, "恢复导师", "Mentor")
	if(!is_mentor())
		return
	add_mentor_verbs()
	GLOB.mentors[src] = TRUE
	to_chat(src, span_interface("你现在是导师了。"))
	log_mentor("MENTOR: [src] 已重新获得导师身份。")
	UNASSIGN_GAME_VERB(src, /client, cmd_mentor_rementor)
