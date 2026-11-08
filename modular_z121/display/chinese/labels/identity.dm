/obj/item/modular_computer/get_visible_name(add_id_name = TRUE, force_real_name = FALSE)
	. = ..()
	if((!saved_identification && !saved_job) || HAS_TRAIT(src, TRAIT_WAS_RENAMED))
		return
	if(. == "[saved_identification] ([saved_job])")
		return "[saved_identification] ([chinese_job_display(saved_job)])"

/proc/chinese_job_display(value, return_mapping = FALSE)
	if(!return_mapping && istext(value) && findtextEx(value, "已下班 ") == 1)
		return "已下班 [chinese_job_display(copytext_char(value, 5))]"
	if(!return_mapping && istext(value) && findtextEx(value, "实习") == 1)
		return "实习[chinese_job_display(copytext_char(value, 3))]"
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"Brig Physician" = "监牢医生", "Field Medic" = "战地医护", "Security Corpsman" = "安保卫生员", "Security Medic" = "安保医护", "Combat Medic" = "战斗医护", "Special Operations Medic" = "特战医护",
		"Arena Participant" = "竞技场参赛者",
		"Assistant" = "助理", "Prisoner" = "囚犯", "Captain" = "舰长", "Head of Personnel" = "人事主管", "Head of Security" = "安保主管", "Research Director" = "科研主管", "Chief Engineer" = "总工程师", "Chief Medical Officer" = "首席医疗官",
		"Bridge Assistant" = "舰桥助理", "Veteran Security Advisor" = "资深安保顾问", "AI" = "人工智能", "Cyborg" = "赛博", "Personal AI" = "个人 AI", "Big Brother" = "老大哥", "Warden" = "典狱长", "Detective" = "侦探",
		"Security Officer" = "安保官", "Security Officer (Medical)" = "安保官（医疗部）", "Security Officer (Engineering)" = "安保官（工程部）", "Security Officer (Science)" = "安保官（科研部）", "Security Officer (Cargo)" = "安保官（货运部）", "Corrections Officer" = "惩教官",
		"Station Engineer" = "空间站工程师", "Atmospheric Technician" = "大气技术员", "Engineering Guard" = "工程部警卫", "Telecomms Specialist" = "电信专家", "Coroner" = "法医", "Medical Doctor" = "医生", "Paramedic" = "急救员", "Chemist" = "化学家", "Orderly" = "护工",
		"Scientist" = "科学家", "Roboticist" = "机器人专家", "Geneticist" = "遗传学家", "Science Guard" = "科研部警卫", "Quartermaster" = "货运主管", "Cargo Technician" = "货运技术员", "Cargo Gorilla" = "货运大猩猩", "Shaft Miner" = "矿工", "Bitrunner" = "比特潜行者", "Customs Agent" = "海关人员",
		"Bartender" = "调酒师", "Botanist" = "植物学家", "Cook" = "厨师", "Chef" = "主厨", "Janitor" = "清洁工", "Clown" = "小丑", "Mime" = "默剧演员", "Curator" = "馆长", "Lawyer" = "律师", "Chaplain" = "牧师", "Psychologist" = "心理医生", "Barber" = "理发师", "Bouncer" = "酒吧保安", "Pun Pun" = "潘潘",
		"Death Commando" = "死亡突击队员", "Emergency Response Team Commander" = "紧急响应小队指挥官", "Security Response Officer" = "安保响应队员", "Engineering Response Officer" = "工程响应队员", "Medical Response Officer" = "医疗响应队员", "Religious Response Officer" = "宗教响应队员", "Janitorial Response Officer" = "清洁响应队员", "Entertainment Response Officer" = "娱乐响应队员",
		"Central Command" = "中央指挥部", "CentCom Official" = "中央指挥部官员", "Admiral" = "上将", "CentCom Commander" = "中央指挥部指挥官", "VIP Guest" = "贵宾", "CentCom Bartender" = "中央指挥部调酒师", "Custodian" = "管理员", "Thunderdome Overseer" = "雷霆竞技场监管员", "Medical Officer" = "医疗官", "Research Officer" = "科研官", "Special Ops Officer" = "特种作战军官", "Private Security Force" = "私人安保人员",
		"Blueshield" = "蓝盾", "Nanotrasen Consultant" = "纳米传讯顾问", "Ensign" = "少尉", "Lieutenant" = "上尉", "Lieutenant Commander" = "少校", "Commander" = "指挥官", "Rear Admiral" = "少将", "Fleet Admiral" = "元帅", "Space Police" = "太空警察", "TerraGov" = "地球政府", "TerraGov Liaison" = "地球政府联络员",
		"Visiting Engineer" = "来访工程师", "Visiting Doctor" = "来访医生", "Visiting Officer" = "来访安保官", "Visiting Scientist" = "来访科学家", "Visiting Technician" = "来访技术员", "Visiting Civillian" = "来访平民", "Bluespace Technician" = "蓝空间技师",
		"Jannie" = "管理员打杂工", "Highlander" = "高地勇士", "CentCom Intern" = "中央指挥部实习生", "CentCom Head Intern" = "中央指挥部实习生主管", "Bounty Hunter" = "赏金猎人", "Emergency Response Team Intern" = "紧急响应小队实习生", "Frontier Militia" = "边疆民兵", "Frontier Militia General" = "边疆民兵将军", "Intern" = "实习生", "Busser" = "餐桌服务员",
		"Captain-in-Training" = "见习舰长", "Chief Engineer-in-Training" = "见习总工程师", "Chief Medical Officer-in-Training" = "见习首席医疗官", "Head of Personnel-in-Training" = "见习人事主管", "Head of Security-in-Training" = "见习安保主管", "Quartermaster-in-Training" = "见习货运主管", "Research Director-in-Training" = "见习科研主管",
		"Command Bodyguard" = "指挥保镖", "Executive Protection Agent" = "要员保护特工", "Command Security Specialist" = "指挥安保专家", "Command Protection Officer" = "指挥保护官", "Henchman" = "跟班",
		"DS-2 Operative" = "DS-2 特工", "DS-2 Hostage" = "DS-2 人质", "DS-2 Mining Officer" = "DS-2 采矿官", "DS-2 General Staff" = "DS-2 参谋", "DS-2 Researcher" = "DS-2 研究员", "DS-2 Engine Technician" = "DS-2 引擎技术员", "DS-2 Medical Officer" = "DS-2 医疗官", "DS-2 Master At Arms" = "DS-2 纠察长", "DS-2 Brig Officer" = "DS-2 禁闭室军官", "DS-2 Corporate Liaison" = "DS-2 企业联络官", "DS-2 Admiral" = "DS-2 上将", "Interdyne Operative" = "英特戴恩特工", "Deck Officer" = "甲板军官",
		"Reaper" = "收割者", "Mobster" = "黑帮成员", "VR Participant" = "虚拟现实参与者", "Syndicate VR Operative" = "辛迪加虚拟现实特工", "Tunnel Clown!" = "隧道小丑！", "Bit Avatar" = "比特化身", "Cyber Police" = "网络警察",
		"Charlie Station Security Officer" = "查理站安保官", "Charlie Station Scientist" = "查理站科学家", "Charlie Station Engineer" = "查理站工程师", "Engine Equipment Access" = "引擎设备通行权限", "Cat Surgeon" = "猫科外科医生", "Head Researcher" = "首席研究员", "Lifeguard" = "救生员", "Space Bartender" = "太空调酒师", "Bridge Officer" = "舰桥军官", "Tradepost Officer" = "贸易站军官", "Nanotrasen Assault Force" = "纳米传讯突击部队", "Senior Station Engineer" = "高级空间站工程师",
		"Gunner" = "炮手", "Pirate" = "海盗", "Pirate Captain" = "海盗船长", "Silver Scale Member" = "银鳞成员", "Silver Scale VIP" = "银鳞贵宾", "Researcher" = "研究员", "Head Occultist" = "首席神秘学家", "Waystation Cargo Hauler" = "中转站货运搬运工", "Waystation Quartermaster" = "中转站货运主管", "Waystation Security Officer" = "中转站安保官", "Krazy Cashier" = "疯狂收银员", "Angry Assistant Manager" = "暴躁副经理", "The Mad Manager" = "疯经理", "Donk Co. Employee" = "咚克公司员工", "Donk Co. Executive" = "咚克公司主管", "Glove Packer" = "手套包装工", "Fabric Technician" = "纺织技术员", "Actor" = "演员", "Director" = "导演",
		"Syndicate Overlord" = "辛迪加霸主", "Syndicate Operative" = "辛迪加特工", "Interdyne Pharmacist" = "英特戴恩药剂师", "Interdyne Pharmacist Director" = "英特戴恩药剂主管", "Internal Revenue Service Agent" = "国税局探员", "Internal Revenue Service Head Auditor" = "国税局首席审计员", "Syndicate Ship Captain" = "辛迪加舰长", "Syndicate Battlecruiser Crew" = "辛迪加战列巡洋舰舰员", "Syndicate Battlecruiser Captain" = "辛迪加战列巡洋舰舰长", "Syndicate Operative Leader" = "辛迪加特工队长", "Syndicate Entertainment Operative" = "辛迪加娱乐特工", "Syndicate Entertainment Operative Leader" = "辛迪加娱乐特工队长",
		"Unassigned" = "未分配", "Unknown" = "未知", "Unassigned Crewmember" = "未分配船员", "Traitor" = "叛徒", "Changeling" = "变形怪", "Cultist" = "血教徒", "Heretic" = "异端", "Malf AI" = "失控 AI", "Revolutionary" = "革命者", "Head Revolutionary" = "革命领袖", "Nuclear Operative" = "核爆特工", "Wizard" = "巫师", "Space Ninja" = "太空忍者", "Blood Brother" = "血盟兄弟"
	)
	display_names |= chinese_skyrat_items_job_display(null, TRUE)
	display_names |= chinese_batch_ten_job_display(null, TRUE)
	display_names |= chinese_zubbers_modules_job_display(null, TRUE)
	display_names |= list("Medical Examiner" = "验尸官", "Medical Investigator" = "医学调查员", "Forensic Pathologist" = "法医病理学家", "Funeral Director" = "殡仪主管", "Mortician" = "遗体护理师", "Undertaker" = "殡葬人员")
	display_names["Asset Protection"] = "资产保护"
	display_names["Citizen"] = "公民"
	display_names["Icemoon Dweller"] = "冰月居民"
	if(return_mapping)
		return display_names
	return display_names[value] || chinese_id_honorific_display(chinese_zubbers_job_display(value))

/proc/chinese_footprint_species_display(value, return_mapping = FALSE)
	if(!istext(value) && !return_mapping)
		return value
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"flyperson" = "蝇人", "podperson" = "植物人", "jellyperson" = "凝胶人", "mushroomperson" = "蘑菇人", "spooky scary skeleton" = "骷髅", "high-functioning zombie" = "高功能僵尸", "ash walker" = "灰行者", "silver scale" = "银鳞蜥蜴人", "mothperson" = "蛾人",
		"abductor" = "绑架者", "android" = "仿生人", "dullahan" = "无头骑士", "ethereal" = "以太人", "lustrous" = "辉光以太人", "ghost" = "幽灵", "golem" = "魔像", "felinid" = "猫人", "fly" = "蝇人", "human" = "人类", "jelly" = "凝胶人", "slime" = "史莱姆人", "slimeperson" = "史莱姆人", "spirit" = "灵体", "luminescent" = "发光凝胶人", "stargazer" = "观星凝胶人", "lizard" = "蜥蜴人", "lizardperson" = "蜥蜴人", "ashwalker" = "灰行者", "silverscale" = "银鳞蜥蜴人", "nightmare" = "梦魇", "monkey" = "猴子", "moth" = "蛾人", "mush" = "蘑菇人", "plasmaman" = "等离子人", "pod" = "植物人", "shadow" = "暗影人", "skeleton" = "骷髅", "snail" = "蜗牛人", "vampire" = "吸血鬼", "zombie" = "僵尸", "voidwalker" = "虚空行者",
		"akula" = "阿库拉", "aquatic" = "水生种族", "dwarf" = "矮人", "humanoid" = "类人生物", "insect" = "昆虫种族", "mammal" = "哺乳类种族", "podweak" = "植物人", "synth" = "合成人", "skrell" = "斯克雷尔", "tajaran" = "塔亚拉", "unathi" = "乌纳西", "vox" = "沃克斯", "vox_primalis" = "原始沃克斯", "vulpkanin" = "沃尔普卡宁", "xeno" = "异形", "ghoul" = "食尸鬼", "teshari" = "特沙利", "primitive_felinid" = "原始猫人", "protean" = "普罗蒂安", "serpentid" = "蛇形气体人", "mutant" = "突变体", "infectious_mutant" = "感染性突变体", "slow_mutant" = "迟缓突变体", "fast_mutant" = "迅捷突变体", "shadekin" = "影裔", "mhuman" = "突变人类", "lesser_abductor" = "低阶绑架者", "digitigrade" = "趾行生物", "bot" = "机器人", "hemophage" = "嗜血者"
	)
	display_names |= chinese_skyrat_items_species_display(null, TRUE)
	display_names |= chinese_batch_ten_species_display(null, TRUE)
	var/list/species_labels = chinese_species_name_labels()
	for(var/species_name in species_labels)
		display_names[species_name] = species_labels[species_name]
	display_names["hearthkin"] = "炉裔"
	display_names["moorman"] = "荒原人"
	display_names[lowertext("\improper Moorman")] = "荒原人"
	if(return_mapping)
		return display_names
	return display_names[lowertext(value)] || value

/proc/chinese_job_choice(mob/user, message, title, list/choices, default)
	var/list/display_choices = list()
	for(var/value in choices)
		display_choices["[chinese_job_display(value)] ([value])"] = value
	var/selection = tgui_input_list(user, message, title, display_choices, "[chinese_job_display(default)] ([default])")
	return isnull(selection) ? null : display_choices[selection]

/proc/chinese_record_value_display(value, return_mapping = FALSE)
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list("Male" = "男", "Female" = "女", "Other" = "其他", "male" = "男", "female" = "女", "neuter" = "无性", "plural" = "复数", "None" = "无", "Unknown" = "未知", "Unassigned" = "未分配", "Active" = "正常", "Stable" = "稳定", "Arrest" = "逮捕", "Incarcerated" = "监禁中", "Paroled" = "假释", "Discharged" = "已释放", "Suspect" = "嫌疑人", "Wanted" = "通缉中", "Disabled" = "残疾", "Unconscious" = "昏迷", "Deceased" = "死亡", "Unstable" = "不稳定", "Insane" = "精神失常")
	display_names |= chinese_record_status_display(null, TRUE)
	if(return_mapping)
		return display_names
	return display_names[value] || value

/proc/chinese_record_status_display(value, return_mapping = FALSE)
	var/static/list/labels
	if(isnull(labels))
		labels = list("Debilitated" = "虚弱", "Watch" = "需观察", "Parole" = "假释", "Suspected" = "嫌疑人", "Honk" = "喇叭恶作剧", "Slip" = "滑倒恶作剧")
	if(return_mapping)
		return labels
	return labels[value] || value

/proc/chinese_record_value_choice(mob/user, message, title, list/choices, default)
	var/list/display_choices = list()
	var/default_display
	for(var/value in choices)
		var/label = chinese_record_value_display(value)
		var/unique_label = label
		var/duplicate = 1
		while(unique_label in display_choices)
			unique_label = "[label]（选项[++duplicate]）"
		display_choices[unique_label] = value
		if(value == default)
			default_display = unique_label
	var/selection = tgui_input_list(user, message, title, display_choices, default_display)
	return isnull(selection) ? null : display_choices[selection]

/proc/chinese_nif_examine_display(value)
	var/legacy_default = "There's a certain spark to their eyes."
	return (value == legacy_default || value == html_encode(legacy_default)) ? /datum/component/nif_examine::nif_examine_text : value

/proc/chinese_character_preference_display(value)
	var/static/list/labels
	if(isnull(labels))
		labels = list(
			"Unset" = "未设置", "Check OOC" = "查看场外说明", "Check OOC Notes" = "查看场外备注", "Ask (L)OOC" = "通过场外频道询问",
			"Yes" = "是", "No" = "否", "Maybe" = "也许", "No ERP" = "不进行成人角色扮演",
			"Yes - Dom" = "是－支配", "Yes - Sub" = "是－顺从", "Yes - Switch" = "是－可切换", "Yes - Pred" = "是－捕食者", "Yes - Prey" = "是－猎物",
			"None" = "无", "Roleplay only" = "仅角色扮演", "Mechanical only" = "仅游戏机制", "Mechanical and Roleplay" = "游戏机制与角色扮演",
			"Always/Whenever" = "始终／随时", "Gameplay Only" = "仅限游戏互动",
			"Straight" = "异性恋", "Lesbian" = "女同性恋", "Gay" = "男同性恋", "Bisexual" = "双性恋", "Pansexual" = "泛性恋", "Polysexual" = "多性恋",
			"Asexual" = "无性恋", "Aromantic" = "无浪漫倾向", "Aro/Ace" = "无浪漫／无性恋", "Skoliosexual" = "非二元性别吸引倾向", "Omnisexual" = "全性恋",
			"Male" = "男性", "Female" = "女性", "Nonbinary" = "非二元性别", "Genderfluid" = "流动性别", "Trans" = "跨性别", "Transmasc" = "跨男性", "Transfem" = "跨女性",
			"Andromorph" = "男性形态", "Gynomorph" = "女性形态", "Agender" = "无性别", "Plural" = "多重身份", "Omnigender" = "全性别",
			"Top - Dom" = "主动方－支配", "Top - Switch" = "主动方－可切换", "Top - Sub" = "主动方－顺从",
			"Bottom - Dom" = "接受方－支配", "Bottom - Switch" = "接受方－可切换", "Bottom - Sub" = "接受方－顺从",
			"Verse - Dom" = "双方皆可－支配", "Verse - Switch" = "双方皆可－可切换", "Verse - Sub" = "双方皆可－顺从",
			"Verse-Top - Dom" = "偏主动方－支配", "Verse-Top - Switch" = "偏主动方－可切换", "Verse-Top - Sub" = "偏主动方－顺从",
			"Verse-Bottom - Dom" = "偏接受方－支配", "Verse-Bottom - Switch" = "偏接受方－可切换", "Verse-Bottom - Sub" = "偏接受方－顺从",
			"A few sentences" = "几句话", "1-2 Paragraphs" = "一至两段", "Multi-Paragraph" = "多段", "I'll Match You" = "配合对方", "No Preference" = "无偏好",
			"Approach IC" = "通过角色内互动接近", "Approach OOC" = "通过场外交流接近", "Any" = "任意", "Both" = "两者皆可", "See Below" = "见下文",
		)
	return labels[value] || value

/proc/chinese_direction_display(value)
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list("north" = "北", "south" = "南", "east" = "东", "west" = "西", "northeast" = "东北", "northwest" = "西北", "southeast" = "东南", "southwest" = "西南", "up" = "上", "down" = "下")
	return display_names[value] || value

/proc/chinese_wrestling_move_display(value)
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list("drop" = "坠击", "strike" = "快攻", "kick" = "踢击", "throw" = "旋转投掷", "slam" = "抱摔")
	return display_names[value] || value

/proc/chinese_examine_pronoun_display(value)
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list("he" = "他", "she" = "她", "it" = "它", "they" = "对方")
	return display_names[value] || value

/proc/chinese_material_display(value)
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"material" = "材料", "alloy" = "合金", "plasteel" = "塑钢", "plastitanium" = "塑钛", "plasmaglass" = "等离子玻璃", "titanium glass" = "钛玻璃", "plastitanium glass" = "塑钛玻璃", "alien alloy" = "外星合金", "iron" = "铁", "glass" = "玻璃", "silver" = "银", "gold" = "金", "diamond" = "钻石", "uranium" = "铀", "plasma" = "等离子体", "bluespace crystal" = "蓝空间水晶", "bananium" = "香蕉矿", "titanium" = "钛", "runite" = "符文矿", "plastic" = "塑料", "biomass" = "生物质", "wood" = "木材", "adamantine" = "精金", "mythril" = "秘银", "hot ice" = "热冰", "Metal Hydrogen" = "金属氢", "sand" = "沙子", "sandstone" = "砂岩", "snow" = "雪", "runed metal" = "符文金属", "bronze" = "青铜", "paper" = "纸", "cardboard" = "纸板", "bone" = "骨头", "bamboo" = "竹子", "zaukerite" = "灼蚀晶体", "telecrystal" = "传送水晶", "rock" = "岩石", "hauntium" = "幽魂矿", "meat" = "肉", "pizza" = "披萨"
	)
	return value == "metal hydrogen" ? "金属氢" : (display_names[value] || chinese_batch_ten_material_display(value))
