
GAME_VERB_PROC_DESC(/mob/living/silicon/ai, show_laws_verb, "查看法则", "私下查看你的法则。同时确保所有已同步的半机械人都掌握你的最新法则，并提醒他们你的法则。", "AI 指令")
	if(usr.stat == DEAD)
		return //won't work if dead
	src.show_laws()

/mob/living/silicon/ai/try_sync_laws()
	for(var/mob/living/silicon/robot/borgo in connected_robots)
		if(borgo.try_sync_laws())
			to_chat(borgo, span_bold("你的 AI 提醒了你以下法则："))
			borgo.show_laws()
