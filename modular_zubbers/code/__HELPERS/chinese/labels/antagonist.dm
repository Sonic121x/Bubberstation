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
			"clown operatives" = "小丑特工", "changelings" = "变形怪", "brainwashed victims" = "被洗脑者",
			"assault operatives" = "突击特工", "nri cops" = "NRI 警察"
		)
	return names[value] || chinese_skyrat_items_category_display(chinese_zubbers_heretic_category_display(chinese_bloodsucker_category_display(value)))

/proc/chinese_poll_role_display(value)
	var/static/list/names = list(
		"Antagonist Prompt" = "敌对角色招募", "Academy Wizard Defender" = "学院巫师守卫", "Cortical Borer" = "皮层钻虫",
		"Xenomorph larva" = "异形幼体", "Ash Spirit" = "灰烬之灵", "Ashwalker eggs" = "灰行者卵", "Blob spores" = "变形菌孢子",
		"Bots" = "机器人", "Cargorilla" = "货运大猩猩", "Construct" = "构造体", "Contractor Support Unit" = "承包商支援单位",
		"Drone shells" = "无人机躯壳", "Fire Shark" = "火焰鲨", "Fugitive Hunter" = "逃犯猎人", "Glitch" = "故障体", "Golems" = "魔像",
		"Heretic Monster" = "异教徒怪物", "Holoparasite" = "全息寄生体", "Horrific Necktie" = "恐怖领带", "Imaginary Friend" = "幻想朋友",
		"Lavaland elite" = "熔岩地带精英", "Maid in the Mirror" = "镜中女仆", "Mind magnified monkey" = "心智增幅猴子",
		"Positronic brain" = "正电子脑", "Possessed blade" = "附身之刃", "Slime" = "史莱姆", "Raw Prophet" = "血肉先知",
		"Regal rat" = "鼠王", "Rust Walker" = "锈蚀行者", "Sentience potion" = "启智药水", "Shade" = "暗影",
		"Shuttle denizens" = "穿梭机居民", "Spectral blade" = "幽灵之刃", "Spiders" = "蜘蛛", "Split Personality" = "分裂人格",
		"Stalker" = "潜猎者", "Syndicate" = "辛迪加", "Syndicate Monkey" = "辛迪加猴子", "Venus Human Traps" = "维纳斯捕人花",
		"Recovered Crew" = "获救船员", "Free spore" = "自由孢子", "Blood Worm" = "血虫", "Operative" = "核爆特工", "Spy" = "间谍",
		"Abductor" = "绑架者", "Xenomorph" = "异形", "Blob" = "变形菌", "Blob Infection" = "变形菌感染", "Blood Worm Infestation" = "血虫侵染",
		"Fugitive" = "逃犯", "Lone Operative" = "孤身特工", "Nightmare" = "梦魇", "Obsessed" = "痴迷者", "Clown Operative" = "小丑特工",
		"Paradox Clone" = "悖论克隆体", "Syndicate Sleeper Agent" = "辛迪加潜伏特工", "Space Dragon" = "太空龙", "Spider" = "蜘蛛",
		"Voidwalker" = "虚空行者", "Sunwalker" = "逐日者", "Provocateur" = "煽动者", "Stowaway Changeling" = "偷渡变形怪", "Syndicate Infiltrator" = "辛迪加渗透者",
		"Borer" = "皮层钻虫", "Mutated Abomination" = "变异憎恶", "Clock Cultist" = "发条教徒", "Bloodsucker" = "吸血鬼",
		"Monster Hunter" = "怪物猎人", "Ghoul" = "血仆", "Changeling Zombie" = "变形怪僵尸", "Wire Priest" = "线缆祭司", "Hacked Synthetic" = "被入侵的合成人"
	)
	if(!istext(value))
		return value
	var/base_name = replacetext(replacetext(value, " (Midround)", ""), " (Latejoin)", "")
	var/display_name = names[base_name] || chinese_job_display(base_name)
	return "[display_name][findtext(value, " (Midround)") ? "（回合中途）" : ""][findtext(value, " (Latejoin)") ? "（中途加入）" : ""]"

/// Reverse display names only at the boundary of existing action-button preferences.
/proc/chinese_antag_storage_name(value)
	var/plain_primitive_name = replacetext(value, "\improper", "")
	if(plain_primitive_name == "冰行者")
		return replacetext(value, plain_primitive_name, "Icewalker")
	if(plain_primitive_name == "冰月居民")
		return replacetext(value, plain_primitive_name, "Icemoon Dwellers")
	var/static/list/names
	if(!names)
		names = list(
			"敌对角色" = "Antagonist", "被绑架者" = "Abductee", "绑架者" = "Abductor", "通用比特潜行故障体" = "Generic Bitrunning Glitch", "虚拟域角色" = "Virtual Domain Actor",
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
			"太空巫师" = "Space Wizard", "巫师仆从" = "Wizard Minion", "巫师学徒" = "Wizard Apprentice", "巫师冒充者" = "Wizard Imposter", "学院教师" = "Academy Teacher", "迷失的异形" = "Lost Xenomorph", "异形" = "Xenomorph", "被俘异形" = "Captive Xenomorph", "资产保护专员" = "Asset Protection Specialist", "资产保护官" = "Asset Protection Officer", "发条教徒" = "Clock Cultist", "发条教徒（单人）" = "Clock Cultist (Solo)", "皮层钻虫" = "Cortical Borer", "联邦警察" = "Commonwealth Police Officer", "911 响应人员" = "911 Responder", "执法官" = "Marshal", "高级大气技术员" = "Adv. Atmos Tech", "急救医疗技术员" = "Emergency Medical Technician", "武装特警" = "Armed S.W.A.T. Officer", "地球政府维和人员" = "Terran Government Peacekeeper", "辛迪加登船者" = "Syndicate Boarder", "熏蒸队员" = "Fumigator", "熏蒸队长" = "Fumigator Leader", "轨道空降突击兵" = "Orbital Drop Shock Trooper", "轨道空降突击队长" = "Orbital Drop Shock Trooper Leader", "披萨外送员" = "Pizza Delivery Boy", "多吉诺区域经理" = "Dogginos Regional Manager", "创伤小队专家" = "Trauma Team Specialist", "创伤小队长" = "Trauma Team Leader"
		)
	var/plain_name = replacetext(value, "\improper", "")
	return names[plain_name] ? replacetext(value, plain_name, names[plain_name]) : chinese_skyrat_items_antag_storage(chinese_bloodsucker_antag_storage(value))
