/proc/chinese_bloodsucker_clan_display(value)
	var/static/list/names
	if(isnull(names))
		names = list(
			CLAN_NONE = "无族者",
			CLAN_BRUJAH = "布鲁赫氏族",
			CLAN_TOREADOR = "托瑞朵氏族",
			CLAN_NOSFERATU = "诺斯费拉图氏族",
			CLAN_TREMERE = "特雷默氏族",
			CLAN_GANGREL = "冈格罗氏族",
			CLAN_VENTRUE = "梵卓氏族",
			CLAN_MALKAVIAN = "末卡维氏族",
			CLAN_TZIMISCE = "茨密希氏族",
		)
	return names[value] || value

/proc/chinese_bloodsucker_category_display(value)
	var/static/list/names
	if(isnull(names))
		names = list("bloodsuckers" = "吸血鬼", "ghouls" = "血仆", "abandoned Ghouls" = "被遗弃的血仆")
	return names[value] || value

/proc/chinese_bloodsucker_antag_storage(value)
	var/static/list/names
	if(isnull(names))
		names = list("吸血鬼" = "Bloodsucker", "血仆" = "Ghoul", "前血仆" = "Ex-Ghoul", "宠爱血仆" = "Favorite Ghoul", "复仇血仆" = "Revenge Ghoul")
	var/plain_name = replacetext(value, "\improper", "")
	return names[plain_name] ? replacetext(value, plain_name, names[plain_name]) : value

/proc/chinese_bloodsucker_damage_display(value)
	var/static/list/names
	if(isnull(names))
		names = list(BRUTE = "蛮力", BURN = "烧伤", TOX = "毒素", OXY = "窒息", CLONE = "细胞", STAMINA = "耐力", LASER = "激光")
	return names[value] || value

/proc/chinese_bloodsucker_objective_display(value)
	var/static/list/names
	if(isnull(names))
		names = list(
			"claimhaven" = "建立避难所", "bloodsuckersurvive" = "吸血鬼存活", "ghouling" = "转化血仆", "ghoulingcommand" = "血仆任职指挥层", "ghoulify department" = "转化部门成员",
			"heartthief" = "窃取心脏", "gourmand" = "吸食鲜血", "steal the Book of Nod" = "盗取诺德之书", "tremerepower" = "提升血魔法", "embrace" = "进行初拥", "destroymonsters" = "消灭怪物", "ghoulhim" = "将目标转化为血仆",
		)
	return names[value] || value
