/// Translate choice labels without changing icon, organ or configuration identifiers.
/proc/chinese_skyrat_item_label(value)
	if(!istext(value))
		return value
	var/static/list/labels = list("pink" = "粉色", "teal" = "青绿色", "green" = "绿色", "red" = "红色", "yellow" = "黄色", "blue" = "蓝色", "cyan" = "青色", "lime" = "黄绿色", "black" = "黑色", "orange" = "橙色", "purple" = "紫色", "white" = "白色", "metal" = "金属色", "tail" = "尾巴", "small" = "小型", "medium" = "中型", "big" = "大型", "avian" = "鸟类", "canine" = "犬类", "equine" = "马类", "dragon" = "龙类", "human" = "人类", "tentacle" = "触手", "whip" = "长鞭", "crotch" = "短鞭", "weak" = "柔软", "hard" = "坚硬", "penis" = "阴茎", "vagina" = "阴道", "breasts" = "乳房", "nipples" = "乳头")
	labels["square"] = "方形"
	labels["round"] = "圆形"
	labels["kinetic"] = "动能"
	labels["pyramid"] = "棱锥"
	labels["cube"] = "立方体"
	labels["sphere"] = "球体"
	labels["kill"] = "杀伤"
	labels["marksman"] = "精确射击"
	labels["disable"] = "失能"
	labels["launcher"] = "发射器"
	labels["shotgun"] = "霰弹"
	labels["blade"] = "刀刃"
	labels["flare"] = "照明弹"
	labels["incinerate"] = "焚烧"
	labels["default"] = "默认"
	labels["system idle"] = "系统空闲"
	labels["system synthesising virus"] = "系统正在合成病毒"
	labels["system synthesising cure"] = "系统正在合成解药"
	labels["announcer_aimalf"] = "人工智能故障"
	labels["announcer_aliens"] = "异形"
	labels["announcer_animes"] = "动漫"
	labels["announcer_granomalies"] = "引力异常"
	labels["announcer_intercept"] = "截获通讯"
	labels["announcer_ionstorm"] = "离子风暴"
	labels["announcer_meteors"] = "陨石"
	labels["announcer_outbreak5"] = "五级生物危害"
	labels["announcer_outbreak6"] = "六级生物危害"
	labels["announcer_outbreak7"] = "七级生物危害"
	labels["announcer_poweroff"] = "断电"
	labels["announcer_poweron"] = "恢复供电"
	labels["announcer_radiation"] = "辐射"
	labels["announcer_shuttlecalled"] = "穿梭机已呼叫"
	labels["announcer_shuttledock"] = "穿梭机已停靠"
	labels["announcer_shuttlerecalled"] = "穿梭机已召回"
	labels["announcer_spanomalies"] = "时空异常"
	labels["announcer_shuttleleft"] = "穿梭机已离站"
	labels["announcer_carp"] = "太空鲤鱼"
	labels["announcer_vortexanomalies"] = "涡旋异常"
	labels["announcer_captain"] = "站长"
	labels["announcer_massivebspaceanomalies"] = "巨型蓝空间异常"
	labels["announcer_translocation"] = "空间位移"
	labels["announcer_pyroanomalies"] = "高温异常"
	labels["announcer_fluxanomalies"] = "通量异常"
	labels["announcer_gravanomalies"] = "重力异常"
	labels["announcer_gravgenon"] = "重力发生器已开启"
	labels["announcer_gravgenoff"] = "重力发生器已关闭"
	labels["announcer_greytide"] = "灰潮"
	labels["announcer_commsblackout"] = "通讯中断"
	labels["announcer_electricalstorm"] = "电磁风暴"
	labels["announcer_brandintelligence"] = "品牌智能"
	labels["announcer_radiationpasssed"] = "辐射已过境"
	labels["announcer_bluespacearty"] = "蓝空间火炮"
	labels["announcer_spooky"] = "灵异现象"
	labels["announcer_ertyes"] = "紧急响应小队已获准"
	labels["announcer_mutants"] = "突变体"
	labels["announcer_klaxon"] = "警笛"
	labels["announcer_icarus"] = "伊卡洛斯"
	labels["announcer_nri_raiders"] = "新俄罗斯帝国袭击者"
	labels["announcer_gravgenblackout"] = "重力发生器停机"
	labels["announcer_meteorwarning"] = "陨石预警"
	return labels[lowertext(value)] || value

/proc/chinese_skyrat_item_choice(mob/user, message, title, list/choices, default)
	var/list/labels = list()
	for(var/value in choices)
		labels[chinese_skyrat_item_label(value)] = value
	var/choice = tgui_input_list(user, message, title, labels, chinese_skyrat_item_label(default))
	return isnull(choice) ? null : labels[choice]

/proc/chinese_skyrat_item_radial(mob/user, atom/anchor, list/choices, datum/callback/custom_check, radius, require_near = FALSE, tooltips = FALSE)
	var/list/images = list()
	var/list/values = list()
	for(var/value in choices)
		var/label = chinese_skyrat_item_label(value)
		images[label] = choices[value]
		values[label] = value
	var/choice = show_radial_menu(user, anchor, images, custom_check = custom_check, radius = radius, require_near = require_near, tooltips = tooltips)
	return isnull(choice) ? null : values[choice]
