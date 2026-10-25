
///global reference to the current theme, if there is one.
GLOBAL_DATUM(triple_ai_controller, /datum/triple_ai_controller)

/**
 * The triple ai controller handles the admin triple AI mode, if enabled.
 * It is first created when "Toggle AI Triumvirate" triggers it, and it can be referenced from GLOB.triple_ai_controller
 * After it handles roundstart business, it cleans itself up.
 */
/datum/triple_ai_controller

/datum/triple_ai_controller/New()
	. = ..()
	RegisterSignal(SSjob, COMSIG_OCCUPATIONS_DIVIDED, PROC_REF(on_occupations_divided))

/datum/triple_ai_controller/proc/on_occupations_divided(datum/source, pure, allow_all)
	SIGNAL_HANDLER

	for(var/datum/job/ai/ai_datum in SSjob.joinable_occupations)
		ai_datum.spawn_positions = 3
	if(!pure)
		for(var/obj/effect/landmark/start/ai/secondary/secondary_ai_spawn in GLOB.start_landmarks_list)
			secondary_ai_spawn.latejoin_active = TRUE
		qdel(src)

/datum/triple_ai_controller/Destroy(force)
	UnregisterSignal(SSjob, COMSIG_OCCUPATIONS_DIVIDED)
	GLOB.triple_ai_controller = null
	. = ..()

GAME_VERB_PROC(/client, triple_ai, "切换 AI 三人执政", "Admin.Events")

	if(SSticker.current_state > GAME_STATE_PREGAME)
		to_chat(usr, "此选项目前只能在游戏开始前使用。未来可能会变更。", confidential = TRUE)
		return

	var/datum/job/job = SSjob.get_job_type(/datum/job/ai)
	if(!job)
		to_chat(usr, "无法找到 AI 职业", confidential = TRUE)
		CRASH("triple_ai() called, no /datum/job/ai to be found.")

	if(!GLOB.triple_ai_controller)
		GLOB.triple_ai_controller = new()
	else
		QDEL_NULL(GLOB.triple_ai_controller)
	to_chat(usr, "回合开始时[GLOB.triple_ai_controller ? "将" : "不会"]出现 AI 三人执政。")
	message_admins(span_adminnotice("[key_name_admin(usr)] 已[GLOB.triple_ai_controller ? "开启" : "关闭"]了回合开始时的三 AI 模式。"))
