/datum/objective/destroy_nation
	name = "国度毁灭"
	explanation_text = "确保敌方国度的任何成员都无法活着逃脱！"
	team_explanation_text = "确保敌方国度的任何成员都无法活着逃脱！"
	var/datum/team/nation/target_team

/datum/objective/destroy_nation/New(text, target_department)
	. = ..()
	target_team = target_department
	update_explanation_text()

/datum/objective/destroy_nation/Destroy()
	target_team = null
	. = ..()


/datum/objective/destroy_nation/update_explanation_text()
	. = ..()
	if(target_team)
		explanation_text = "确保 [target_team]（[target_team.department.department_name]）国度的任何成员都无法活着逃脱！"
	else
		explanation_text = "自由目标"

/datum/objective/destroy_nation/check_completion()
	if(!target_team)
		return TRUE

	for(var/datum/antagonist/separatist/separatist_datum in GLOB.antagonists)
		if(separatist_datum.nation.department != target_team.department) //a separatist, but not one part of the department we need to destroy
			continue
		var/datum/mind/target = separatist_datum.owner
		if(target && considered_alive(target) && (target.current.onCentCom() || target.current.onSyndieBase()))
			return FALSE //at least one member got away
	return TRUE

/datum/objective/separatist_fluff

/datum/objective/separatist_fluff/New(text, nation_name)
	explanation_text = pick(list(
		"空间站其余部门必须为使用[nation_name]的服务而缴税。",
		"到处为[nation_name]的光荣领袖立起雕像。如果你们没有领袖，就从你们当中加冕一位！",
		"[nation_name]必须被打扮得金光闪闪。",
		"尽可能破坏空间站，让它一直处于失修状态。[nation_name]必须是那未被染指的典范！",
		"大力加固[nation_name]，以抵御外部世界的危险。",
		"确保[nation_name]完全脱离电网，不需要来自其他部门的电力或任何其他服务！",
		"使用校准错误的传送器，让你和[nation_name]的其他公民变成苍蝇人。记得带上抗毒素药物！",
		"在空间站最需要的时候拯救它。[nation_name]将被铭记为守护者。",
		"武装起来。[nation_name]的公民有权持有武器。",
	))
	..()

/datum/objective/separatist_fluff/check_completion()
	return TRUE

/datum/objective/united_nations
	explanation_text = "维持空间站的和平。确保每个国度在回合结束时都有一名代表存活。"
	team_explanation_text = "维持空间站的和平。确保每个国度在回合结束时都有一名代表存活。"

/datum/objective/united_nations/check_completion()
	var/list/all_separatists = list()
	var/list/alive_separatists = list()

	for(var/datum/team/nation/separatist_team in GLOB.antagonist_teams)
		all_separatists |= separatist_team.department
		for(var/datum/mind/separatist as anything in separatist_team.members)
			if(considered_escaped(separatist))
				alive_separatists |= separatist_team.department
				break

	return length(all_separatists) == length(alive_separatists)
