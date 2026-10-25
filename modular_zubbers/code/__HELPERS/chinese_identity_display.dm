/proc/chinese_job_display(value, return_mapping = FALSE)
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"Arena Participant" = "竞技场参赛者",
		"Assistant" = "助理", "Prisoner" = "囚犯", "Captain" = "舰长", "Head of Personnel" = "人事主管", "Head of Security" = "安保主管", "Research Director" = "科研主管", "Chief Engineer" = "总工程师", "Chief Medical Officer" = "首席医疗官",
		"Bridge Assistant" = "舰桥助理", "Veteran Security Advisor" = "资深安保顾问", "AI" = "人工智能", "Cyborg" = "半机械人", "Personal AI" = "个人 AI", "Big Brother" = "老大哥", "Warden" = "典狱长", "Detective" = "侦探",
		"Security Officer" = "安保官", "Security Officer (Medical)" = "安保官（医疗部）", "Security Officer (Engineering)" = "安保官（工程部）", "Security Officer (Science)" = "安保官（科研部）", "Security Officer (Cargo)" = "安保官（货运部）", "Corrections Officer" = "惩教官",
		"Station Engineer" = "空间站工程师", "Atmospheric Technician" = "大气技术员", "Engineering Guard" = "工程部警卫", "Telecomms Specialist" = "电信专家", "Coroner" = "法医", "Medical Doctor" = "医生", "Paramedic" = "急救员", "Chemist" = "化学家", "Orderly" = "护工",
		"Scientist" = "科学家", "Roboticist" = "机器人专家", "Geneticist" = "遗传学家", "Science Guard" = "科研部警卫", "Quartermaster" = "货运主管", "Cargo Technician" = "货运技术员", "Cargo Gorilla" = "货运大猩猩", "Shaft Miner" = "矿工", "Bitrunner" = "比特潜行者", "Customs Agent" = "海关人员",
		"Bartender" = "调酒师", "Botanist" = "植物学家", "Cook" = "厨师", "Chef" = "主厨", "Janitor" = "清洁工", "Clown" = "小丑", "Mime" = "默剧演员", "Curator" = "馆长", "Lawyer" = "律师", "Chaplain" = "牧师", "Psychologist" = "心理医生", "Barber" = "理发师", "Bouncer" = "酒吧保安", "Pun Pun" = "潘潘",
		"Death Commando" = "死亡突击队员", "Emergency Response Team Commander" = "紧急响应小队指挥官", "Security Response Officer" = "安保响应队员", "Engineering Response Officer" = "工程响应队员", "Medical Response Officer" = "医疗响应队员", "Religious Response Officer" = "宗教响应队员", "Janitorial Response Officer" = "清洁响应队员", "Entertainment Response Officer" = "娱乐响应队员",
		"Central Command" = "中央指挥部", "CentCom Official" = "中央指挥部官员", "Admiral" = "上将", "CentCom Commander" = "中央指挥部指挥官", "VIP Guest" = "贵宾", "CentCom Bartender" = "中央指挥部调酒师", "Custodian" = "管理员", "Thunderdome Overseer" = "雷霆竞技场监管员", "Medical Officer" = "医疗官", "Research Officer" = "科研官", "Special Ops Officer" = "特种作战军官", "Private Security Force" = "私人安保人员",
		"Blueshield" = "蓝盾", "Nanotrasen Consultant" = "纳米传讯顾问", "Ensign" = "少尉", "Lieutenant" = "上尉", "Lieutenant Commander" = "少校", "Commander" = "指挥官", "Rear Admiral" = "少将", "Fleet Admiral" = "元帅", "Space Police" = "太空警察", "TerraGov" = "地球政府", "TerraGov Liaison" = "地球政府联络员",
		"Visiting Engineer" = "来访工程师", "Visiting Doctor" = "来访医生", "Visiting Officer" = "来访安保官", "Visiting Scientist" = "来访科学家", "Visiting Technician" = "来访技术员", "Visiting Civillian" = "来访平民",
		"Jannie" = "管理员打杂工", "Highlander" = "高地勇士", "CentCom Intern" = "中央指挥部实习生", "CentCom Head Intern" = "中央指挥部实习生主管", "Bounty Hunter" = "赏金猎人", "Emergency Response Team Intern" = "紧急响应小队实习生", "Frontier Militia" = "边疆民兵", "Frontier Militia General" = "边疆民兵将军", "Intern" = "实习生", "Busser" = "餐桌服务员",
		"Captain-in-Training" = "见习舰长", "Chief Engineer-in-Training" = "见习总工程师", "Chief Medical Officer-in-Training" = "见习首席医疗官", "Head of Personnel-in-Training" = "见习人事主管", "Head of Security-in-Training" = "见习安保主管", "Quartermaster-in-Training" = "见习货运主管", "Research Director-in-Training" = "见习科研主管",
		"Reaper" = "收割者", "Mobster" = "黑帮成员", "VR Participant" = "虚拟现实参与者", "Syndicate VR Operative" = "辛迪加虚拟现实特工", "Tunnel Clown!" = "隧道小丑！", "Bit Avatar" = "比特化身", "Cyber Police" = "网络警察",
		"Charlie Station Security Officer" = "查理站安保官", "Charlie Station Scientist" = "查理站科学家", "Charlie Station Engineer" = "查理站工程师", "Engine Equipment Access" = "引擎设备通行权限", "Cat Surgeon" = "猫科外科医生", "Head Researcher" = "首席研究员", "Lifeguard" = "救生员", "Space Bartender" = "太空调酒师", "Bridge Officer" = "舰桥军官", "Tradepost Officer" = "贸易站军官", "Nanotrasen Assault Force" = "纳米传讯突击部队", "Senior Station Engineer" = "高级空间站工程师",
		"Gunner" = "炮手", "Pirate" = "海盗", "Pirate Captain" = "海盗船长", "Silver Scale Member" = "银鳞成员", "Silver Scale VIP" = "银鳞贵宾", "Researcher" = "研究员", "Head Occultist" = "首席神秘学家", "Waystation Cargo Hauler" = "中转站货运搬运工", "Waystation Quartermaster" = "中转站货运主管", "Waystation Security Officer" = "中转站安保官", "Krazy Cashier" = "疯狂收银员", "Angry Assistant Manager" = "暴躁副经理", "The Mad Manager" = "疯经理", "Donk Co. Employee" = "咚克公司员工", "Donk Co. Executive" = "咚克公司主管", "Glove Packer" = "手套包装工", "Fabric Technician" = "纺织技术员", "Actor" = "演员", "Director" = "导演",
		"Syndicate Overlord" = "辛迪加霸主", "Syndicate Operative" = "辛迪加特工", "Interdyne Pharmacist" = "英特戴恩药剂师", "Interdyne Pharmacist Director" = "英特戴恩药剂主管", "Internal Revenue Service Agent" = "国税局探员", "Internal Revenue Service Head Auditor" = "国税局首席审计员", "Syndicate Ship Captain" = "辛迪加舰长", "Syndicate Battlecruiser Crew" = "辛迪加战列巡洋舰舰员", "Syndicate Battlecruiser Captain" = "辛迪加战列巡洋舰舰长", "Syndicate Operative Leader" = "辛迪加特工队长", "Syndicate Entertainment Operative" = "辛迪加娱乐特工", "Syndicate Entertainment Operative Leader" = "辛迪加娱乐特工队长",
		"Unassigned" = "未分配", "Unknown" = "未知", "Traitor" = "叛徒", "Changeling" = "变形怪", "Cultist" = "血教徒", "Heretic" = "异教徒", "Malf AI" = "失控 AI", "Revolutionary" = "革命者", "Head Revolutionary" = "革命领袖", "Nuclear Operative" = "核爆特工", "Wizard" = "巫师", "Space Ninja" = "太空忍者", "Blood Brother" = "血盟兄弟"
	)
	if(return_mapping)
		return display_names
	return display_names[value] || value

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
	var/static/list/display_names = list("Male" = "男", "Female" = "女", "Other" = "其他", "male" = "男", "female" = "女", "neuter" = "无性", "plural" = "复数", "None" = "无", "Unknown" = "未知", "Unassigned" = "未分配", "Active" = "正常", "Stable" = "稳定", "Arrest" = "逮捕", "Incarcerated" = "监禁中", "Paroled" = "假释", "Discharged" = "已释放", "Suspect" = "嫌疑人", "Wanted" = "通缉中", "Disabled" = "残疾", "Unconscious" = "昏迷", "Deceased" = "死亡", "Unstable" = "不稳定", "Insane" = "精神失常")
	if(return_mapping)
		return display_names
	return display_names[value] || value

/proc/chinese_direction_display(value)
	var/static/list/display_names = list("north" = "北", "south" = "南", "east" = "东", "west" = "西", "northeast" = "东北", "northwest" = "西北", "southeast" = "东南", "southwest" = "西南", "up" = "上", "down" = "下")
	return display_names[value] || value

/proc/chinese_wrestling_move_display(value)
	var/static/list/display_names = list("drop" = "坠击", "strike" = "快攻", "kick" = "踢击", "throw" = "旋转投掷", "slam" = "抱摔")
	return display_names[value] || value

/proc/chinese_material_display(value)
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"material" = "材料", "alloy" = "合金", "plasteel" = "塑钢", "plastitanium" = "塑钛", "plasmaglass" = "等离子玻璃", "titanium glass" = "钛玻璃", "plastitanium glass" = "塑钛玻璃", "alien alloy" = "外星合金", "iron" = "铁", "glass" = "玻璃", "silver" = "银", "gold" = "金", "diamond" = "钻石", "uranium" = "铀", "plasma" = "等离子体", "bluespace crystal" = "蓝空间水晶", "bananium" = "香蕉矿", "titanium" = "钛", "runite" = "符文矿", "plastic" = "塑料", "biomass" = "生物质", "wood" = "木材", "adamantine" = "精金", "mythril" = "秘银", "hot ice" = "热冰", "Metal Hydrogen" = "金属氢", "sand" = "沙子", "sandstone" = "砂岩", "snow" = "雪", "runed metal" = "符文金属", "bronze" = "青铜", "paper" = "纸", "cardboard" = "纸板", "bone" = "骨头", "bamboo" = "竹子", "zaukerite" = "灼蚀晶体", "telecrystal" = "传送水晶", "rock" = "岩石", "hauntium" = "幽魂矿", "meat" = "肉", "pizza" = "披萨"
	)
	return display_names[value] || value
