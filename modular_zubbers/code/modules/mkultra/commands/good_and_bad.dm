/datum/mkultra_command/good_boy
	name = "称赞"
	description = "给予称赞作为奖励"
	feedback = "因称赞而颤抖！"
	erp_command = TRUE
	trigger = "good boy|good girl|good pet|good job|good"
	cooldown = 10 SECONDS

/datum/mkultra_command/good_boy/execute(datum/status_effect/mkultra/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	to_chat(owner, span_userlove("[status.get_gender()]称赞了我！！"))
	owner.emote("shiver")
	status.progress += 20
	return TRUE

/datum/mkultra_command/bad_boy
	name = "惩罚"
	description = "用言语惩罚你的宠物"
	feedback = "因斥责而畏缩。"
	erp_command = TRUE
	trigger = "bad boy|bad girl|bad pet|bad job"
	cooldown = 10 SECONDS

/datum/mkultra_command/bad_boy/execute(datum/status_effect/mkultra/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	to_chat(owner, span_red("我让[status.get_gender()]失望了……真是个坏宠物……"))
	return TRUE
