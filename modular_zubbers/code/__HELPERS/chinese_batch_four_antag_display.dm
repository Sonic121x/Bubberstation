/// Preserve category keys used by both upstream and downstream antagonist reports.
/proc/chinese_roundend_category_display(value)
	var/static/list/names
	if(!names)
		names = list(
			"other antagonists" = "其他敌对角色", "abductees" = "被绑架者", "abductors" = "绑架者",
			"battlecruiser syndicate operatives" = "战列巡洋舰辛迪加特工", "blood worms" = "血虫", "blobs" = "变形菌",
			"evil clones" = "邪恶克隆体", "Fugitive" = "逃犯", "Heretics" = "异教徒",
			"hypnotized victims" = "被催眠的受害者", "syndicate operatives" = "辛迪加特工",
			"space dragons" = "太空龙", "traitors" = "叛徒", "wizard prank victims" = "巫师恶作剧受害者",
			"wizards/witches" = "巫师/女巫", "demons" = "恶魔", "valentines" = "情人",
			"spies" = "间谍", "revolutionaries" = "革命者", "space pirates" = "太空海盗",
			"Paradox Clone" = "悖论克隆体", "obsessed" = "痴迷者", "cultists" = "血教徒",
			"clown operatives" = "小丑特工", "changelings" = "变形怪", "brainwashed victims" = "被洗脑者"
		)
	return names[value] || value

/// Reverse display names only at the boundary of existing action-button preferences.
/proc/chinese_antag_storage_name(value)
	var/static/list/names
	if(!names)
		names = list(
			"敌对角色" = "Antagonist", "被绑架者" = "Abductee", "绑架者" = "Abductor",
			"绑架者特工" = "Abductor Agent", "绑架者科学家" = "Abductor Scientist", "单人绑架者" = "Abductor Solo",
			"灰行者" = "Ash Walker", "战列巡洋舰船员" = "Battlecruiser Crewmember", "战列巡洋舰盟友" = "Battlecruiser Ally", "战列巡洋舰舰长" = "Battlecruiser Captain",
			"变形菌" = "Blob", "变形菌感染" = "Blob Infection", "变形菌仆从" = "Blob Minion", "血虫" = "Blood Worm",
			"被洗脑者" = "Brainwashed Victim", "血盟兄弟" = "Brother", "变形怪" = "Changeling", "头蛞蝓变形怪" = "Headslug Changeling", "太空变形怪" = "Space Changeling", "堕落变形怪" = "Fallen Changeling",
			"小丑特工首领" = "Clown Operative Leader", "小丑特工增援" = "Clown Operative Reinforcement", "血教构装体" = "Cult Construct", "血教徒" = "Cultist", "血教暗影" = "Cult Shade",
			"紧急响应官" = "Emergency Response Officer", "中央指挥部官员" = "CentCom Official", "死亡小队队员" = "Deathsquad Trooper", "死亡小队军官" = "Deathsquad Officer", "中央指挥部实习生" = "CentCom Intern", "中央指挥部实习生主管" = "CentCom Head Intern",
			"陆战队指挥官" = "Marine Commander", "陆战队重装兵" = "Marine Heavy", "陆战队工程师" = "Marine Engineer", "陆战队医疗兵" = "Marine Medic", "边疆民兵" = "Frontier Militia", "边疆民兵将军" = "Frontier Militia General",
			"邪恶克隆体" = "Evil Clone", "逃犯" = "Fugitive", "逃犯猎人" = "Fugitive Hunter", "绿字" = "winner", "异教徒" = "Heretic", "邪异恐魔" = "Eldritch Horror",
			"月狂者" = "Lunatic", "头目" = "Ringleader", "被囚魂的异教徒" = "Soultrapped Heretic", "高地人" = "Highlander", "被催眠的受害者" = "Hypnotized Victim", "魔法仆从" = "Magic Servant",
			"故障 AI" = "Malfunctioning AI", "被感染的 AI" = "Infected AI", "拟态怪" = "Morph", "梦魇" = "Nightmare", "核爆特工队长" = "Nuclear Operative Leader", "孤身特工" = "Lone Operative", "核爆特工增援" = "Nuclear Operative Reinforcement", "核爆特工支援半机械人" = "Nuclear Operative Support Cyborg",
			"痴迷者" = "Obsessed", "前痴迷者" = "Former Obsessed", "悖论克隆体" = "Paradox Clone", "太空海盗" = "Space Pirate", "火山碎屑异常" = "Pyroclastic Anomaly", "亡魂" = "Revenant",
			"国家公敌" = "Enemy of the State", "革命者" = "Revolutionary", "革命领袖" = "Head Revolutionary", "圣诞老人" = "Santa", "有知觉生物" = "Sentient Creature", "分离主义者" = "Separatists", "忠诚暗影" = "Loyal Shade",
			"太空鲤鱼" = "Space Carp", "太空龙" = "Space Dragon", "太空忍者" = "Space Ninja", "蜘蛛" = "Spider", "血肉蜘蛛" = "Flesh Spider", "间谍" = "Spy", "生存主义者" = "Survivalist", "业余魔法师" = "Amateur Magician", "大逃杀参赛者" = "Battle Royale Contestant",
			"辛迪加猴子" = "Syndicate Monkey", "承包商支援单位" = "Contractor Support Unit", "叛徒" = "Traitor", "负心人" = "Heartbreaker", "情人" = "Valentine", "电灯泡" = "Third Wheel", "维纳斯捕人花" = "Venus Human Trap",
			"逐日者" = "Sunwalker", "虚空行者" = "Voidwalker", "许愿者化身" = "Wishgranter Avatar", "巫师恶作剧受害者" = "Wizard Prank Victim", "小恶魔" = "Imp", "屠戮恶魔" = "Slaughter Demon", "欢笑恶魔" = "Laughter demon",
			"太空巫师" = "Space Wizard", "巫师仆从" = "Wizard Minion", "巫师学徒" = "Wizard Apprentice", "巫师冒充者" = "Wizard Imposter", "学院教师" = "Academy Teacher", "迷失的异形" = "Lost Xenomorph", "异形" = "Xenomorph", "被俘异形" = "Captive Xenomorph"
		)
	var/plain_name = replacetext(value, "\improper", "")
	return names[plain_name] ? replacetext(value, plain_name, names[plain_name]) : value
