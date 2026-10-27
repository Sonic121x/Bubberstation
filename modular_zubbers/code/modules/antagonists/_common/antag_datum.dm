
/datum/antagonist
	var/antag_panel_title = "反派面板"
	var/antag_panel_description = "这是反派面板，其中列出了你作为反派可使用的全部能力。请明智地使用它们。"

/datum/antagonist/proc/ability_ui_data(actions = list())
	var/list/data = list()
	data["title"] = "[antag_panel_title]\n[antag_panel_data()]"
	data["description"] = antag_panel_description
	for(var/datum/action/cooldown/power as anything in actions)
		var/list/power_data = list()

		power_data["power_name"] = power.name
		power_data["power_icon"] = power.button_icon
		power_data["power_icon_state"] = power.button_icon_state
		if(istype(power, /datum/action/cooldown/bloodsucker))
			var/datum/action/cooldown/bloodsucker/bloodsucker_power = power
			power_data["power_explanation"] = bloodsucker_power.get_power_explanation()

		data["powers"] += list(power_data)
	return data
