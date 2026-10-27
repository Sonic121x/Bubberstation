/// Display-only mappings for the 9001-9205 translation range; identifiers remain unchanged.
/proc/chinese_skyrat_items_quirk_display(value)
	var/static/list/names = list("Masochism" = "受虐倾向", "Sadism" = "施虐倾向", "Rope bunny" = "绳缚爱好者", "Rigger" = "绳缚师", "Night Vision" = "夜视")
	return names[value] || value

/proc/chinese_skyrat_items_event_display(value)
	var/static/list/names = list("Moldies" = "霉菌灾害", "HNZ-1 Pathogen Outbreak" = "HNZ-1病原体暴发")
	return names[value] || value

/proc/chinese_skyrat_items_dynamic_display(value)
	var/static/list/names = list("OPFOR Candidate Reroll" = "重新抽选敌对势力候选人")
	return names[value] || value

/proc/chinese_skyrat_items_antag_storage(value)
	var/static/list/names = list("突变憎恶" = "Mutated Abomination", "联邦边境巡逻队员" = "Commonwealth border patrol", "联邦对外关系委员会外交官" = "Commonwealth ERC Diplomat", "敌对势力候选人" = "OPFOR Candidate", "侍徒" = "Acolyte", "侍徒（不生成影响）" = "Acolyte (No Influence Spawning)", "被入侵的合成人" = "Hacked Synthetic", "阿玛达因公司" = "Armadyne Corporate", "阿玛达因公司安保分队" = "Armadyne Corporate Security Detail", "阿玛达因公司董事会" = "Armadyne Corporate Directorate", "阿玛达因公司安保" = "Armadyne Corporate Security", "阿玛达因公司安保（高度戒备）" = "Armadyne Corporate Security (High Alert)", "阿玛达因公司安保指挥官" = "Armadyne Corporate Security Commander", "阿玛达因公司安保指挥官（高度戒备）" = "Armadyne Corporate Security Commander (High Alert)")
	var/plain_name = replacetext(value, "\improper", "")
	return names[plain_name] ? replacetext(value, plain_name, names[plain_name]) : value

/// BYOND article prefixes are formatting markers, not part of the lookup key.
/proc/chinese_skyrat_items_antag_display(value)
	if(!istext(value))
		return value
	var/plain_name = replacetext(value, "\improper", "")
	var/display_name = chinese_batch_four_admin_display(plain_name)
	return plain_name == display_name ? value : replacetext(value, plain_name, display_name)

/proc/chinese_skyrat_items_category_display(value)
	var/static/list/names = list("mutants" = "突变体", "Mutant" = "突变体", "OPFOR Candidate" = "敌对势力候选人", "Opposing Force" = "敌对势力")
	return names[value] || value

/proc/chinese_skyrat_items_species_display(value, return_mapping = FALSE)
	var/static/list/names = list("high-functioning mutant" = "高机能突变体", "mutated abomination" = "突变憎恶", "fast mutated abomination" = "迅捷突变憎恶", "slow mutated abomination" = "迟缓突变憎恶")
	if(return_mapping)
		return names
	if(!istext(value))
		return value
	return names[lowertext(value)] || value

/proc/chinese_skyrat_items_job_display(value, return_mapping = FALSE)
	var/static/list/names = list("PSC Soldier" = "泛斯拉夫联邦士兵", "PSC Platoon Commander" = "泛斯拉夫联邦排长", "PSC Heavy Soldier" = "泛斯拉夫联邦重装士兵", "PSC Corpsman" = "泛斯拉夫联邦战地医护兵", "PSC Combat Engineer" = "泛斯拉夫联邦战斗工兵", "PSC Diplomat" = "泛斯拉夫联邦外交官", "PSC Major" = "泛斯拉夫联邦少校", "PSC Research Inspector" = "泛斯拉夫联邦科研监察员", "PSC Medical Inspector" = "泛斯拉夫联邦医疗监察员")
	if(return_mapping)
		return names
	return names[value] || value
