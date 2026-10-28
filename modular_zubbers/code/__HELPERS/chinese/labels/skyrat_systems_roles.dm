/// Display-only names for Skyrat roles, preferences and categories; raw keys remain unchanged.
/proc/chinese_batch_ten_quirk_display(value)
	var/static/list/names = list(
		"Echolocation" = "回声定位",
		"Hardened Soles" = "坚韧脚底",
		"Linguist" = "语言学家",
		"Sharp Claws" = "锋利爪子",
		"Water breathing" = "水下呼吸",
		"Water aspect (Emotes)" = "水流特性（表情）",
		"Webbing aspect (Emotes)" = "织网特性（表情）",
		"Floral aspect (Emotes)" = "花草特性（表情）",
		"Ash aspect (Emotes)" = "灰烬特性（表情）",
		"Sparkle aspect (Emotes)" = "闪光特性（表情）",
		"Appendicitis Survivor" = "阑尾炎幸存者",
		"Alexithymia" = "述情障碍",
		"Fragility" = "体质脆弱",
		"Monophobia" = "孤独恐惧症",
		"No Guns" = "无法用枪",
		"Excitable!" = "容易兴奋！",
		"Affection Aversion" = "厌恶亲昵",
		"Personal Space" = "私人空间",
		"Do Not Revive" = "禁止复苏",
		"Pseudobulbar Affect" = "假性延髓情感",
		"Felinid Traits" = "猫科特征",
		"Canidae Traits" = "犬科特征",
		"Avian Traits" = "鸟类特征",
		"Bovine Traits" = "牛科特征",
		"Muridae Traits" = "鼠科特征",
		"Sensitive Snout" = "敏感口鼻",
		"Overweight" = "体重超标",
	)
	return names[value] || value

/proc/chinese_batch_ten_job_display(value, return_mapping = FALSE)
	var/static/list/names = list(
		"Prison Transport Officer" = "囚犯押运官",
		"Prisoner Transport Officer" = "囚犯押运官",
		"Barber" = "理发师",
		"Aethestician" = "美容师",
		"Colorist" = "染发师",
		"Masseuse" = "按摩师",
		"Salon Manager" = "沙龙经理",
		"Salon Technician" = "沙龙技师",
		"Stylist" = "造型师",
		"Corrections Officer" = "惩教官",
		"Brig Officer" = "监牢警官",
		"Prison Guard" = "狱警",
		"Armadyne Corporate" = "阿玛达因公司",
		"Armadyne Corporate Security Detail" = "阿玛达因公司安保分队",
		"Armadyne Corporate Directorate" = "阿玛达因公司董事会",
		"Armadyne Corporate Security" = "阿玛达因公司安保",
		"Armadyne Corporate Security (High Alert)" = "阿玛达因公司安保（高度戒备）",
		"Armadyne Corporate Security Commander" = "阿玛达因公司安保指挥官",
		"Armadyne Corporate Security Commander (High Alert)" = "阿玛达因公司安保指挥官（高度戒备）",
		"P-T Deck Worker" = "塔肯港甲板工",
		"P-T Cargo Personnel" = "塔肯港货运人员",
		"P-T Port Guard" = "塔肯港警卫",
		"P-T Service Personnel" = "塔肯港服务人员",
		"P-T Trauma Medic" = "塔肯港创伤医护",
		"P-T Maintenance Crew" = "塔肯港维护人员",
		"P-T Field Researcher" = "塔肯港实地研究员",
		"Tarkon Ensign" = "塔肯少尉",
		"Port Tarkon Director" = "塔肯港主管",
		"Telecomms Specialist" = "电信专家",
		"Wireless Operator" = "无线电操作员",
		"Network Engineer" = "网络工程师",
		"Sysadmin" = "系统管理员",
		"Tram Technician" = "电车技师",
	)
	if(return_mapping)
		return names
	return names[value] || value

/proc/chinese_batch_ten_area_display(value, return_mapping = FALSE)
	var/static/list/names = list(
		"Interdyne Engineering" = "英特戴恩工程部",
		"Interdyne Medbay" = "英特戴恩医疗区",
		"Interdyne Arrivals" = "英特戴恩抵达区",
		"Interdyne Bar" = "英特戴恩酒吧",
		"Interdyne Primary Hallway" = "英特戴恩主走廊",
		"Interdyne Cargo Bay" = "英特戴恩货运舱",
		"Interdyne Chemistry" = "英特戴恩化学实验室",
		"Interdyne Virology" = "英特戴恩病毒实验室",
		"Interdyne Experimentation Lab" = "英特戴恩试验室",
		"Interdyne Dormitories" = "英特戴恩宿舍",
		"Interdyne Telecommunications" = "英特戴恩电信室",
	)
	if(return_mapping)
		return names
	return names[value] || value

/proc/chinese_batch_ten_species_display(value, return_mapping = FALSE)
	var/static/list/names = list("synthetic humanoid" = "人形合成人", "teshari" = "特沙利")
	if(return_mapping)
		return names
	return names[lowertext(value)] || value

/proc/chinese_batch_ten_material_display(value)
	var/static/list/names = list("stone" = "石材")
	return names[value] || value

/proc/chinese_batch_ten_theme_display(value)
	var/static/list/names = list("tarkon" = "塔肯", "Prototype: Hauler" = "原型：搬运者", "civilian" = "民用", "honkerative" = "洪克特战")
	return names[value] || value

/proc/chinese_batch_ten_station_trait_display(value)
	var/static/list/names = list("Cybernetic Revolution (DISABLED)" = "义体革命（已禁用）")
	return names[value] || value

/proc/chinese_batch_ten_station_trait_choice(mob/user, message, title, list/choices)
	var/list/display_choices = list()
	for(var/datum/station_trait/trait as anything in choices)
		display_choices[chinese_batch_ten_station_trait_display(trait.name)] = trait
	var/selected = tgui_input_list(user, message, title, display_choices)
	return isnull(selected) ? null : display_choices[selected]

/proc/chinese_batch_ten_fax_display(value)
	var/static/list/names = list("Tarkon Industries Bridge" = "塔肯工业舰桥", "Tarkon TB." = "塔肯舰桥")
	return names[value] || value

/proc/chinese_batch_ten_language_display(value)
	var/static/list/names = list("Schechi" = "谢奇语")
	return names[value] || value
