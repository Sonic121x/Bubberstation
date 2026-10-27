/datum/mkultra_command/say_my_name
	name = "说出我的名字"
	description = "让某个人说出你的名字。"
	trigger = "say my name|who am i"
	phase_requirement = 1
	cooldown = 30 SECONDS

/datum/mkultra_command/say_my_name/execute(datum/status_effect/mkultra/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	if(status.lewd)
		owner.say("[status.get_gender()]")
	else
		owner.say("[source]")
	return TRUE
