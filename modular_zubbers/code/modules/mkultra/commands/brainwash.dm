/datum/mkultra_command/mind_control
	name = "洗脑"
	description = "用新目标给你的受害者洗脑。这是有机制支持的洗脑，会给受害者附加被洗脑的反派状态。"
	feedback = "在你植入新目标时松懈了下来。"
	trigger = "new order|obey this command|new objective"
	phase_requirement = 3
	cooldown = 5 MINUTES

/datum/mkultra_command/mind_control/execute(datum/status_effect/mkultra/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	var/text = tgui_input_text(source, title = "洗脑输入", max_length = 150)
	if(!text)
		return FALSE
	brainwash(owner, text)
	return TRUE
