// BUBBER ADDITION: Localize card labels while preserving stored honorifics and icon states.
/proc/chinese_id_honorific_display(value)
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"Custodian" = "管理员", "Intern" = "实习生", "Head Intern" = "实习生主管", "Doctor" = "医生", "Dr." = "医生（简称）", "Commander" = "指挥官", "CMDR." = "指挥官（简称）", "Commando" = "突击队员", "Officer" = "军官", "Chaplain" = "牧师", "Minuteman" = "民兵", "Minuteman General" = "民兵将军", "General" = "将军", "CISO" = "首席信息安全官",
		"Technician" = "技术员", ", Almighty Scourge" = "，全能灾星", "Underling" = "下属", "Assistant" = "助理", "Mate" = "伙伴", "Captain" = "舰长", "Cpt." = "舰长（简称）", "Courier" = "快递员", "Reverend" = "牧师阁下", "Chief" = "主管", ", PhD." = "，博士", ", MD." = "，医学博士", " the Clown" = "小丑", "Cook" = "厨师", "Chef" = "主厨", "Detective" = "侦探", "Investigator" = "调查员", "Chief Officer" = "首席军官", ", Esq." = "，律师", " the Mime" = "默剧演员", "EMT" = "急救员", "Convict" = "囚犯", "Manager" = "经理", "Director" = "主管", "Dir." = "主管（简称）", "Researcher" = "研究员", "Orderly" = "护工", "Engineer" = "工程师", "Gen." = "将军（简称）", "Watchman" = "守卫", "Lieutenant" = "上尉", "Lt." = "上尉（简称）", "Auditor" = "审计员",
		"Agent" = "特工", "ESS" = "ESS", "CPO" = "CPO", "CSS" = "CSS", "Corrections Officer" = "惩教官", "C.O." = "惩教官（简称）", "Professor" = "教授", "Prof." = "教授（简称）", "Curator" = "馆长", "Archivist" = "档案员", "Librarian" = "图书管理员", "Historian" = "历史学家", "Geneticist" = "遗传学家", "Personnel Officer" = "人事官", "Executive Officer" = "执行官", "Head of Personnel" = "人事主管", "EO" = "执行官（简称）", "HOP" = "人事主管（简称）", "Advisor" = "顾问", "Consultant" = "咨询顾问", "Representative" = "代表", "Rep." = "代表（简称）", "Interest Officer" = "权益官", "Liaison" = "联络员",
		"Line Medic" = "前线军医", "Squad Physician" = "随队医生", "Medical Specialist" = "医疗专家", "Support Specialist" = "支援专家", "Doc." = "医生（口语）", "Guard" = "警卫", "Medical Attendant" = "医疗护理员", "Medical Support Officer" = "医疗支援官", "Medical Technician" = "医疗技术员", "Miner" = "矿工", "Excavator" = "挖掘工", "Junior Miner" = "初级矿工", "Dredger" = "采掘工", "Rockbreaker" = "碎岩工", "Prospector" = "勘探员", "Spelunker" = "洞穴探险者", "Apprentice Miner" = "见习矿工", "Drill Technician" = "钻探技术员", "Contract Miner" = "承包矿工", "Field Scout" = "野外侦察员",
		"Mr." = "先生", "Ms." = "女士", "Mrs." = "夫人", "Miss" = "小姐", "Crewmember" = "船员", "Crewmate" = "船员伙伴", "Bartender" = "调酒师", "Barkeep" = "酒保", "Barmaid" = "女酒保", "Barman" = "男酒保", "Barwoman" = "酒吧女招待", "Barperson" = "酒吧招待", "Runner" = "潜行者", "Junior Runner" = "初级潜行者", "Botanist" = "植物学家", "Gardener" = "园丁", "Landscaper" = "园林师", "Coroner" = "法医", "Medical Examiner" = "验尸官", "Medical Investigator" = "医学调查员", "Forensic Pathologist" = "法医病理学家", "Funeral Director" = "殡仪主管", "Mortician" = "遗体护理师", "Undertaker" = "殡葬人员",
	)
	return display_names[value] || chinese_zubbers_honorific_display(value)

/proc/chinese_id_honorific_choice(mob/user, message, title, list/choices)
	var/list/display_choices = list()
	for(var/value in choices)
		display_choices[chinese_id_honorific_display(value)] = value
	var/selection = tgui_input_list(user, message, title, display_choices)
	return isnull(selection) ? null : display_choices[selection]

/proc/chinese_id_trim_choice(mob/user, message, title, list/choices)
	var/list/display_choices = list()
	for(var/value in choices)
		var/display_name = value
		for(var/trim_path in SSid_access.trim_singletons_by_path)
			var/datum/id_trim/trim = SSid_access.trim_singletons_by_path[trim_path]
			if(trim.trim_state == "trim_[value]" && trim.assignment)
				display_name = chinese_job_display(trim.assignment)
				break
		if(display_name in display_choices)
			display_name = "[display_name] ([value])"
		display_choices[display_name] = value
	var/selection = tgui_input_list(user, message, title, display_choices)
	return isnull(selection) ? null : display_choices[selection]
