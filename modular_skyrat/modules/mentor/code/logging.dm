GLOBAL_LIST_EMPTY(mentorlog)
GLOBAL_PROTECT(mentorlog)

/proc/log_mentor(text, list/data)
	GLOB.mentorlog.Add(text)
	logger.Log(LOG_CATEGORY_GAME_MENTOR, text, data)

/datum/admins/proc/MentorLogSecret()
	var/dat = "<B>导师日志<HR></B>"
	for(var/l in GLOB.mentorlog)
		dat += "<li>[l]</li>"

	if(!GLOB.mentorlog.len)
		dat += "本回合没有导师执行任何操作！"
	usr << browse(dat, "window=mentor_log")
