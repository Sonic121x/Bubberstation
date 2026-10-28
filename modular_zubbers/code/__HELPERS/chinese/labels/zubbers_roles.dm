// BUBBER ADDITION: Downstream job and outfit labels; preserve original identifiers.
/proc/chinese_zubbers_modules_job_display(value, return_mapping = FALSE)
	var/static/list/labels = list("Stowaway" = "偷渡客", "Security Medic" = "安保医疗兵", "Security Medical" = "安保医疗兵")
	if(return_mapping)
		return labels
	return labels[value] || value

/proc/chinese_zubbers_modules_outfit_display(value)
	var/static/list/labels
	if(isnull(labels))
		labels = list(
			"Dauntless" = "无畏号", "Persistence" = "恒久号",
			"Persistence Syndicate Prisoner" = "恒久号辛迪加囚犯", "Persistence Operative" = "恒久号特工", "Persistence General Staff" = "恒久号普通职员",
			"Persistence Sanitation Technician" = "恒久号清洁技术员", "Persistence Engineer" = "恒久号工程师", "Persistence Researcher" = "恒久号研究员",
			"Persistence Medical Officer" = "恒久号医疗官", "Persistence Brig Officer" = "恒久号拘留区长官", "Persistence Cargo Tech" = "恒久号货运技术员",
			"Persistence Morale Officer" = "恒久号士气官", "Persistence Command Operative" = "恒久号指挥特工", "Persistence Master At Arms" = "恒久号纠察长",
			"Persistence Corporate Liasion" = "恒久号企业联络官", "Rig Admiral" = "钻井平台上将",
			"Syndicate Prisoner" = "辛迪加囚犯", "Dauntless Operative" = "无畏号特工", "Dauntless General Staff" = "无畏号普通职员",
			"Dauntless Engineer" = "无畏号工程官", "Dauntless Researcher" = "无畏号研究员", "Dauntless Medical Officer" = "无畏号医疗官",
			"Dauntless Brig Officer" = "无畏号拘留区长官", "Dauntless Mining Officer" = "无畏号采矿官", "Dauntless Command Operative" = "无畏号指挥特工",
			"Dauntless Master At Arms" = "无畏号纠察长", "Syndicate Corporate Liasion" = "辛迪加企业联络官", "Ship Admiral" = "飞船上将",
			"Cafe Visitor" = "咖啡厅访客", "NT Asset protection corpse" = "纳米传讯资产保护部尸体",
		)
	return labels[value] || chinese_job_display(value)
