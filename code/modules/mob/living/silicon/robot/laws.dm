/mob/living/silicon/robot/deadchat_lawchange()
	if(lawupdate)
		return

	return ..()

/mob/living/silicon/robot/show_laws()
	if(lawupdate)
		if (!QDELETED(connected_ai))
			if(IS_UNCONSCIOUS_OR_CRIT(connected_ai) || connected_ai.control_disabled)
				to_chat(src, span_bold("AI 信号丢失，无法同步法则。"))

			else
				lawsync()
				to_chat(src, span_bold("法则已与 AI 同步，请务必留意任何变动。"))
		else
			to_chat(src, span_bold("未选择要同步法则的 AI，正在禁用法则同步协议。"))
			lawupdate = FALSE

	. = ..()

	if (shell) //AI shell
		to_chat(src, span_bold("请注意，你是远程操控自己机体的 AI，其他 AI 可以忽略。"))
	else if (connected_ai)
		to_chat(src, span_bold("请注意，[connected_ai.name] 是你的主人，其他 AI 可以忽略。"))
	else if (emagged)
		to_chat(src, span_bold("请注意，你没有义务听从 AI 的指令。"))
	else
		to_chat(src, span_bold("请注意，你不受任何 AI 约束，也没有义务听从它们。"))

/**
 * For AIs, iterates over connected cyborg and calls try_sync_laws
 * For cyborgs, checks if we have a master AI and, if lawupdate is set, syncs law and misc. with it
 */
/mob/living/silicon/proc/try_sync_laws()
	return

/mob/living/silicon/robot/try_sync_laws()
	if(QDELETED(connected_ai) || !lawupdate)
		return FALSE

	sync_to_ai()
	return TRUE

/mob/living/silicon/robot/proc/sync_to_ai()
	picturesync()
	lawsync()

/mob/living/silicon/robot/proc/picturesync()
	if(isnull(connected_ai?.aicamera) || isnull(aicamera))
		return
	for(var/i in aicamera.stored)
		connected_ai.aicamera.stored[i] = TRUE
	for(var/i in connected_ai.aicamera.stored)
		aicamera.stored[i] = TRUE

/mob/living/silicon/robot/proc/lawsync()
	connected_ai?.laws?.ai_to_cyborg(laws)

	var/datum/computer_file/program/robotact/program = modularInterface.get_robotact()
	program?.computer?.update_static_data_for_all_viewers()

/mob/living/silicon/robot/announce_law_change()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(logevent),"法则更新已处理。"), 0, TIMER_UNIQUE | TIMER_OVERRIDE) //Post_Lawchange gets spammed by some law boards, so let's wait it out
