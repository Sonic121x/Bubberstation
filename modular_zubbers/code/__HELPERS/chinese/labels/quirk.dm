/proc/chinese_quirk_display(value)
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"Test Quirk" = "测试特质",
		"Addict" = "成瘾者",
		"Junkie" = "瘾君子",
		"Smoker" = "烟民",
		"Alcoholic" = "酒精依赖",
		"All Nighter" = "彻夜未眠",
		"Extreme Medicine Allergy" = "严重药物过敏",
		"Anosmia" = "嗅觉缺失",
		"Asthma" = "哮喘",
		"Bad Back" = "背痛",
		"Blind" = "失明",
		"Blood Deficiency" = "造血不足",
		"Body Purist" = "身体纯粹主义者",
		"Brain Tumor" = "脑瘤",
		"Eradicative Chronic Illness" = "抹除性慢性病",
		"Claustrophobia" = "幽闭恐惧症",
		"Clumsy" = "笨拙",
		"Common Second Language" = "通用语为第二语言",
		"Cursed" = "厄运缠身",
		"Deaf" = "失聪",
		"Depression" = "抑郁",
		"Erratic" = "反复无常",
		"Family Heirloom" = "传家宝",
		"Fluoride Stare" = "无睑凝视",
		"Food Allergy" = "食物过敏",
		"Frail" = "脆弱",
		"Glass Jaw" = "玻璃下巴",
		"Hemiplegic" = "偏瘫",
		"Hypersensitive" = "过度敏感",
		"Illiterate" = "文盲",
		"Immunodeficiency" = "免疫缺陷",
		"Indebted" = "负债累累",
		"Reality Dissociation Syndrome" = "现实解离综合征",
		"Light Drinker" = "不胜酒力",
		"Limper" = "跛行",
		"Monophobia" = "孤独恐惧症",
		"Mute" = "失语",
		"Narcolepsy" = "发作性睡病",
		"Nearsighted" = "近视",
		"Pacifist" = "和平主义者",
		"Numb" = "痛觉缺失",
		"Nyctophobia" = "黑暗恐惧症",
		"Paraplegic" = "截瘫",
		"Photophobia" = "畏光症",
		"Stormtrooper Aim" = "风暴兵枪法",
		"Prosopagnosia" = "面容失认症",
		"Prosthetic Limb" = "廉价义肢",
		"Prosthetic Organ" = "廉价义体器官",
		"Pushover" = "逆来顺受",
		"Pyrophobia" = "恐火症",
		"Quadruple Amputee" = "四肢截肢",
		"Scarred Eye" = "伤残眼睛",
		"Social Anxiety" = "社交焦虑",
		"Soft-Spoken" = "轻声细语",
		"Tin Man" = "铁皮人",
		"Unstable" = "精神不稳定",
		"Touchy" = "触觉依赖",
		"Smooth-Headed" = "光头",
		"Deviant Tastes" = "异样口味",
		"Fundamentally Evil" = "本性邪恶",
		"Foreigner" = "外来者",
		"Gamer" = "游戏迷",
		"Heterochromatic" = "异色瞳",
		"Monochromacy" = "全色盲",
		"Ageusia" = "味觉缺失",
		"Phobia" = "恐惧症",
		"Photographer" = "摄影爱好者",
		"Ananas Aversion" = "厌恶菠萝",
		"Ananas Affinity" = "喜爱菠萝",
		"Shifty Eyes" = "目光游移",
		"Thanatorenasia" = "死后易魂症",
		"Transhumanist" = "超人类主义者",
		"Vegetarian" = "素食主义者",
		"Alcohol Tolerance" = "酒精耐受",
		"Bilingual" = "双语者",
		"Chip Connector" = "芯片接口",
		"Chipped" = "芯片植入者",
		"Clown Enjoyer" = "小丑爱好者",
		"Drunken Resilience" = "酒后韧性",
		"Empath" = "共情者",
		"Freerunning" = "跑酷",
		"Friendly" = "友善",
		"Jolly" = "乐天派",
		"Keen Nose" = "灵敏嗅觉",
		"Light Step" = "轻盈步伐",
		"Mime Fan" = "默剧迷",
		"Musician" = "音乐家",
		"Poster Boy" = "海报达人",
		"Pyromania" = "纵火癖",
		"Self-Aware" = "自知之明",
		"Settler" = "拓荒者",
		"Signer" = "手语者",
		"Skittish" = "胆小",
		"Spacer" = "太空居民",
		"Strong Stomach" = "强健肠胃",
		"Tagger" = "涂鸦艺术家",
		"Throwing Arm" = "投掷能手",
		"Voracious" = "大胃王",
	)
	if(istext(value) && findtextEx(value, "Extreme ") == 1 && endswith(value, " Allergies"))
		return "严重过敏：[copytext_char(value, 9, -10)]"
	return display_names[value] || value

/proc/chinese_quirk_location_display(value)
	switch(value)
		if("at your feet")
			return "在你的脚边"
		if("left")
			return "左侧"
		if("right")
			return "右侧"
	return value

/proc/chinese_role_list_display(list/roles)
	var/list/display_roles = list()
	for(var/role in roles)
		display_roles += chinese_job_display(role)
	return english_list(display_roles)
