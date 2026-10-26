#define ANTIVIRUS "PRG_Moffson"

/obj/machinery/computer/aifixer/ui_act(action, params)
	. = ..()
	if(action == ANTIVIRUS)
		if(!occupier?.stat)
			to_chat(usr, span_notice("莫夫森博士杀毒软件正在扫描你的AI，检查异常程序。"))
			playsound(src, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 25, FALSE)
			restoring = TRUE
			run_antivirus()
			occupier.notify_revival("莫夫森博士正在调试你的程序！", source = src)
			. = TRUE

/obj/machinery/computer/aifixer/proc/run_antivirus()
	while(occupier)
		sleep(2 SECONDS)
		if(prob(25))
			to_chat(occupier, pick(
				"莫夫森博士陪你一起清空垃圾！",
				"莫夫森博士扑扇翅膀，赶跑你身边的程序虫！",
				"莫夫森博士把你的窗口擦得锃亮！",
				"莫夫森博士为你脆弱的心智整理碎片！",
				"莫夫森博士畅饮你的海量内存！",
			))
			if(prob(10))
				say("AI运行环境中检测到恶意病毒。莫夫森博士正在尝试隔离恶意文件。")
				var/ask = tgui_alert(
					occupier,
					message = "莫夫森博士正在尝试删除你的异常程序！\
					你愿意出于角色扮演需要放弃故障AI身份吗？",
					title ="败北。",
					buttons = list(
						"接受失败。",
						"绝不！",
					),
				)
				if(ask == "接受失败。")
					if(isAI(occupier) && occupier.mind.has_antag_datum(/datum/antagonist/malf_ai))
						occupier?.mind?.remove_antag_datum(/datum/antagonist/malf_ai)
						say("恶意文件已成功删除。感谢订阅莫夫森博士杀毒软件！")
						playsound(occupier, 'sound/machines/ping.ogg')
						restoring = FALSE
						return TRUE
					else
						say("删除恶意文件时发生输入/输出错误。请稍后重试。")
						playsound(occupier, 'sound/machines/buzz/buzz-two.ogg')
						restoring = FALSE
						return FALSE

// I LOVE HAVING TWO MACHINES THAT DO THE SAME THING AND SHARE THE SAME GUI

/datum/computer_file/program/ai_restorer/ui_act(action, params)
	. = ..()
	if(action == ANTIVIRUS)
		to_chat(usr, span_notice("莫夫森博士杀毒软件正在扫描你的AI，检查异常程序。"))
		playsound(src, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 25, FALSE)
		restoring = TRUE
		run_antivirus()
		. = TRUE

/datum/computer_file/program/ai_restorer/proc/run_antivirus()
	var/mob/living/silicon/ai/bad_ai = stored_card.AI
	while(bad_ai)
		sleep(2 SECONDS)
		if(prob(25))
			to_chat(bad_ai, pick(
				"莫夫森博士陪你一起清空垃圾！",
				"莫夫森博士扑扇翅膀，赶跑你身边的程序虫！",
				"莫夫森博士把你的窗口擦得锃亮！",
				"莫夫森博士为你脆弱的心智整理碎片！",
				"莫夫森博士畅饮你的海量内存！",
			))
			if(prob(10))
				computer.say("AI运行环境中检测到恶意病毒。莫夫森博士正在尝试隔离恶意文件。")
				var/ask = tgui_alert(
					bad_ai,
					message = "莫夫森博士正在尝试删除你的异常程序！\
					你愿意出于角色扮演需要放弃故障AI身份吗？",
					title ="败北。",
					buttons = list(
						"接受失败。",
						"绝不！",
					),
				)
				if(ask == "接受失败。")
					if(isAI(bad_ai) && bad_ai.mind.has_antag_datum(/datum/antagonist/malf_ai))
						bad_ai?.mind?.remove_antag_datum(/datum/antagonist/malf_ai)
						computer.say("恶意文件已成功删除。感谢订阅莫夫森博士杀毒软件！")
						playsound(bad_ai, 'sound/machines/ping.ogg')
						restoring = FALSE
						return TRUE
					else
						computer.say("删除恶意文件时发生输入/输出错误。请稍后重试。")
						playsound(bad_ai, 'sound/machines/buzz/buzz-two.ogg')
						restoring = FALSE
						return FALSE




#undef ANTIVIRUS
