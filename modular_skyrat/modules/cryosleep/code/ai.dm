GAME_VERB_DESC(/mob/living/silicon/ai, ai_cryo, "AI 低温休眠", "将当前 AI 人格置入低温休眠，为下一位腾出位置。", "AI 指令")
	if(incapacitated)
		return
	switch(alert("你要进入低温休眠吗？这会让你变成幽灵。即使当前没有管理员在线，在从重要职位上退出前也请记得先用 AHELP 报备。",,"Yes.","No."))
		if("Yes.")
			src.ghostize(FALSE)
			var/announce_rank = "人工智能"
			if(GLOB.announcement_systems.len)
				// Sends an announcement the AI has cryoed.
				var/obj/machinery/announcement_system/announcer = pick(GLOB.announcement_systems)
				announcer.announce("CRYOSTORAGE", src.real_name, announce_rank, list())
			new /obj/structure/ai_core/latejoin_inactive(loc)
			if(src.mind)
				//Handle job slot/tater cleanup.
				if(src.mind.assigned_role.title == JOB_AI)
					SSjob.FreeRole(JOB_AI)
			LAZYNULL(src.mind.special_roles)
			qdel(src)
		else
			return
