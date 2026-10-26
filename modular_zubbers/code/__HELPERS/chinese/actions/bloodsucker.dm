/proc/chinese_bloodsucker_action_storage(value, action_type)
	if(value == "蝙蝠形态" && ispath(action_type, /datum/action/cooldown/spell/shapeshift/bat))
		return "Bat Form"
	if(!ispath(action_type, /datum/action/cooldown/bloodsucker))
		return value
	var/static/list/names = list(
		"吸血鬼恩赐" = "Vampiric Gift", "黑暗斗篷" = "Cloak of Darkness", "吸血" = "Feed", "坚韧" = "Fortitude", "消失戏法" = "Vanishing Act", "避世伪装" = "Masquerade",
		"蛮力" = "Brawn", "不死疾行" = "Immortal Haste", "捕食猛扑" = "Predatory Lunge", "摄魂" = "Mesmerize", "化雾穿行" = "Trespass", "特雷默恩赐" = "Tremere Gift",
		"灵视" = "Auspex", "支配" = "Dominate", "血之奇术" = "Thaumaturgy", "求救" = "Distress", "鲜血疗愈" = "Sanguine Recuperation", "援助血仆" = "Help Ghoul", "千面之纱" = "Veil of Many Faces",
	)
	return names[value] || value
