/proc/chinese_zubbers_quirk_display(value)
	var/static/list/display_names = list(
		"Hydraulic Leak" = "液压泄漏", "Dusting Sickness" = "化灰症", "Brain Degeneration" = "脑退化症", "Positronic Cascade Anomaly" = "正电子级联异常",
		"Criminal Underworlder" = "犯罪地下世界成员", "Dirty" = "污垢缠身", "Gifted" = "天赋异禀", "Heavy Sleeper" = "沉睡者", "Small" = "小个子", "Microsized" = "微型体格", "Microscopic" = "极微体格",
		"Nerve Stapled" = "神经钉植入", "Permanent Limp" = "永久跛行", "Unrobust Brain" = "脆弱大脑", "Aphrodisiacal Bite" = "催情之咬", "Body Morpher" = "身体塑形者", "Death Consequences" = "死亡后遗症",
		"Dominant Aura" = "支配气场", "Oviparity" = "卵生", "Entombed" = "甲中囚徒", "Hemophagia" = "嗜血症", "Hungry" = "易饥饿", "Hydrophilic" = "亲水体质", "Hypnotic" = "催眠魅力", "Nitrogen Breather" = "氮气呼吸者",
		"Nameless" = "无名者", "Oversized" = "超大体型", "Perch" = "悬挂", "Pet Owner" = "宠物主人", "Seamless Heels" = "一体式高跟鞋", "Unblinking" = "不眨眼", "Waddle" = "摇摆步态", "Well-Trained" = "训练有素",
		"Jerk" = "混蛋", "Featherweight" = "轻如羽毛", "Psionic Holding" = "念力持物", "Isotropic Stability" = "辐射稳定体质", "Life Savings" = "积蓄生财", "Soaked" = "浑身湿透", "Underworld Connections" = "地下人脉", "Venomous Bite" = "毒牙之咬",
	)
	return display_names[value] || value

/proc/chinese_zubbers_honorific_display(value)
	var/static/list/display_names = list(
		"Father" = "神父", "Mother" = "嬷嬷", "Preacher" = "传教士", "Rabbi" = "拉比", "Imam" = "伊玛目", "Monk" = "修士", "Nun" = "修女", "Oracle" = "神谕者", "Pontifex" = "祭司长", "Magister" = "导师", "High Priest" = "大祭司", "High Priestess" = "女大祭司", "Cleric" = "教士",
		"Commissioner" = "警务专员", "Chief Constable" = "警察总长", "Sheriff" = "治安官", "Security Commander" = "安保指挥官", "S.CMDR." = "安保指挥官（简称）", "HOS" = "安保主管（简称）", "Facility Director" = "设施主管", "Station Commander" = "空间站指挥官", "Site Manager" = "站点经理",
		"Sous-Chef" = "副主厨", "Junior Chef" = "初级厨师", "Tavern Chef" = "酒馆厨师", "Confectionist" = "糖点师", "Pastry Chef" = "糕点师", "All-American" = "全美厨师", "Deck Chief" = "甲板主管", "Logistics Coordinator" = "后勤协调员", "Supply Foreman" = "物资领班", "Union Requisitions Officer" = "工会物资官", "Supervisor" = "监督员",
		"Head Researcher" = "首席研究员", "Administrator" = "行政官", "RD" = "科研主管（简称）", "Chief Science Officer" = "首席科学官", "CSO" = "首席科学官（简称）", "Analyst" = "分析员", "Security Specialist" = "安保专家", "Security Officer" = "安保官", "Constable" = "警员", "Trooper" = "骑警", "Deputy" = "副警长", "Cadet" = "学员",
		"Warden" = "典狱长", "Sergeant" = "警佐", "Sgt." = "警佐（简称）", "Master-at-Arms" = "军械长", "Superintendent" = "警司", "Chief Engineer" = "总工程师", "Engineering Foreman" = "工程领班", "CE" = "总工程师（简称）", "Associate" = "助理研究员",
		"M.D." = "医学博士", "G.P." = "全科医生", "Physician" = "医师", "Nurse" = "护士", "Resident" = "住院医师", "Resident Physician" = "住院医生", "Resident Nurse" = "住院护士", "Resident Intern" = "住院实习生", "Paramedic" = "急救员", "Emergency Medical Technician" = "急救技术员", "First Responder" = "初始响应员", "E.M.T." = "急救技术员（简称）",
	)
	return display_names[value] || value

/proc/chinese_zubbers_template_display(value)
	var/static/list/display_names = list("Space-Ruin DK Excavator 453" = "太空遗迹 DK 挖掘者453号", "Space Ruin SYN-C Brutus" = "太空遗迹 SYN-C 布鲁图斯号")
	return display_names[value] || value

/proc/chinese_zubbers_job_display(value)
	if(value == "Asset Protection")
		return "资产保护"
	return value

/proc/chinese_zubbers_wire_display(value)
	var/static/list/display_names = list("Unlink" = "断开连接", "Test" = "测试", "Link" = "连接", "Vent Direction" = "通风方向", "Vent Power" = "通风供电", "Tamper" = "防篡改", "Factory Reset" = "恢复出厂设置")
	return display_names[value] || value

/proc/chinese_zubbers_sound_display(value)
	var/static/list/display_names = list(
		"Gulp" = "咕噜吞咽", "Swallow" = "吞咽", "Insert" = "塞入", "Insertion1" = "塞入1", "Insertion2" = "塞入2", "Insertion3" = "塞入3", "Schlorp" = "湿黏吸入",
		"Squish1" = "挤压1", "Squish2" = "挤压2", "Squish3" = "挤压3", "Squish4" = "挤压4", "Rustle (cloth)" = "衣物摩擦1", "Rustle 2 (cloth)" = "衣物摩擦2", "Rustle 3 (cloth)" = "衣物摩擦3", "Rustle 4 (cloth)" = "衣物摩擦4", "Rustle 5 (cloth)" = "衣物摩擦5",
		"Zipper" = "拉链", "None" = "无", "Splatter" = "飞溅", "Tauric Swallow" = "半人兽吞咽", "Stomach Move" = "腹部蠕动", "Pred Escape" = "逃出腹腔",
	)
	return display_names[value] || value

/proc/chinese_zubbers_sound_choice(mob/user, message, title, list/choices, default_value)
	var/list/display_choices = list()
	for(var/value in choices)
		display_choices[chinese_zubbers_sound_display(value)] = value
	var/selection = tgui_input_list(user, message, title, display_choices, chinese_zubbers_sound_display(default_value))
	return isnull(selection) ? null : display_choices[selection]

/proc/chinese_zubbers_breath_display(value)
	switch(value)
		if("oxygen")
			return "氧气"
		if("nitrogen")
			return "氮气"
	return value

/proc/chinese_zubbers_coin_face_display(value)
	switch(value)
		if("Stategic Air Command")
			return "战略空军司令部"
		if("Peace is Our Profession")
			return "和平是我们的事业"
	return value

/proc/chinese_zubbers_area_display(value, return_mapping = FALSE)
	var/static/list/display_names = list(
		"Interlink Administrative Office" = "中转站行政办公室", "Ministation Solar Array" = "微型站太阳能阵列", "Ministation Atmospherics Room" = "微型站大气室", "Ministation Lobby" = "微型站大厅",
		"Aux. Cryopods Room" = "辅助冷冻舱室", "Public Mining" = "公共采矿区", "Public Xenoarchaeology" = "公共异星考古区", "Shuttle Construction Bay" = "穿梭机建造舱", "Public Mining Maintenance" = "公共采矿维护区", "Chemistry Maintenance" = "化学维护区",
		"Supermatter Emitter Room" = "超物质发射器室", "Service Lathe" = "服务部车床区", "Coroner's Office" = "验尸官办公室", "Public Shuttle Dock" = "公共穿梭机码头", "Arrivals Terminal" = "抵达航站楼", "Arrivals Terminal Cryo" = "抵达航站楼冷冻室",
		"Arrivals Terminal Interlink Dock" = "抵达航站楼中转码头", "Arrivals Terminal Lobby" = "抵达航站楼大厅", "Arrivals Terminal Central Maintenance" = "抵达航站楼中央维护区", "Arrivals Terminal Disposals" = "抵达航站楼垃圾处理区", "Arrivals Terminal Aft Maintenance" = "抵达航站楼后部维护区",
		"Tramline" = "电车轨道", "Engineering EVA Storage" = "工程部舱外作业装备库", "DO NOT USE" = "请勿使用", "Lunar Surface" = "月球表面", "Lunar Caves" = "月球洞穴", "Mining Elevators" = "采矿升降机", "Psychology Maintenance" = "心理诊室维护区", "Lower Engineering Maintenance" = "下层工程维护区",
		"Loop Station" = "环线站", "Loop Station Gateway" = "环线站传送门", "Loop Station Central Hallway" = "环线站中央走廊", "Loop Station Engineering" = "环线站工程区", "Loop Station Telecommunications" = "环线站通讯区", "Loop Station Power Room" = "环线站电力室", "Loop Station Gravity Room" = "环线站重力室", "Loop Station Radiation Shelter" = "环线站辐射避难所",
		"Blacksmith Workshop" = "锻造工坊", "Station Ship Dock" = "空间站船坞", "Auxiliary Ship Dock" = "辅助船坞", "Secondary Ship Dock" = "二号船坞", "Blacksmith Mining Workshop" = "采矿锻造工坊", "Nanite Lab" = "纳米机器人实验室", "RB-MK2 Reactor Room" = "RB-MK2 反应堆室", "RB-MK2 Reactor Chamber" = "RB-MK2 反应堆舱",
	)
	if(return_mapping)
		return display_names
	return display_names[trimtext(format_text(value))] || value

/proc/chinese_zubbers_choice_display(value)
	var/static/list/genders = list("Random" = "随机", MALE = "雄性", FEMALE = "雌性", PLURAL = "复数", NEUTER = "无性别")
	if(genders[value])
		return genders[value]
	var/static/list/display_names = list(
		"Left, minor" = "左腿，轻度", "Left, moderate" = "左腿，中度", "Left, major" = "左腿，重度", "Right, minor" = "右腿，轻度", "Right, moderate" = "右腿，中度", "Right, major" = "右腿，重度",
		"Fancy Heels (Colourable)" = "精致高跟鞋（可调色）", "High Heels (Colourable)" = "高跟鞋（可调色）", "Pink Heels" = "粉色高跟鞋", "Dominant Heels" = "支配者高跟鞋", "Latex Heels" = "乳胶高跟鞋", "Ballet Heels" = "芭蕾高跟鞋", "High-Heeled Jackboots" = "高跟军靴",
		"Standard Blue" = "标准蓝", "Alert Amber" = "警戒琥珀色", "Contractor Red" = "承包商红", "Extrashield Green" = "强化护盾绿", "Evil Green" = "邪恶绿", "Royal Purple" = "皇家紫", "Hazard Orange" = "危险橙", "Cosmic Blue" = "宇宙蓝",
		"Standard" = "标准型", "Civilian" = "民用型", "Advanced" = "高级型", "Atmospheric" = "大气型", "Corpsman" = "战地医疗型", "Cosmohonk" = "宇宙洪克型", "Engineering" = "工程型", "Loader" = "装载型", "Interdyne" = "英特戴恩型", "Medical" = "医疗型", "Mining" = "采矿型", "Prototype" = "原型", "Security" = "安保型", "Lustwish" = "欲愿型",
		"Hypnophrase" = "催眠文字", "Velvet" = "天鹅绒", "Yellow Flashy" = "黄色闪烁", "Pink" = "粉色", "Cult" = "邪教",
		"Axolotl" = "美西螈", "Baby Penguin" = "企鹅幼崽", "Bat" = "蝙蝠", "Bull terrier" = "牛头梗", "Butterfly" = "蝴蝶", "Cat" = "猫", "Cat (Clown)" = "小丑猫", "Cat (Mime)" = "默剧猫", "Carp" = "太空鲤鱼", "Carp (Clown)" = "小丑太空鲤鱼", "Chick" = "小鸡", "Chicken" = "鸡",
		"Chinchilla (dark)" = "深色龙猫", "Chinchilla (white)" = "白色龙猫", "Corgi" = "柯基犬", "Corgi puppy" = "柯基幼犬", "Cyber Corgi" = "机械柯基", "Cockroach" = "蟑螂", "Crab" = "螃蟹", "Deer" = "鹿", "Dobermann" = "杜宾犬", "Fennec" = "耳廓狐", "Fox" = "狐狸", "Frog" = "青蛙", "Giant ant" = "巨蚁", "Kitten" = "小猫", "Kiwi" = "几维鸟", "Mothroach" = "蛾蟑",
		"Mouse (white)" = "白鼠", "Mouse (gray)" = "灰鼠", "Mouse (brown)" = "褐鼠", "Penguin" = "企鹅", "Pitbull" = "比特犬", "Pig" = "猪", "Pug" = "巴哥犬", "Rabbit" = "兔子", "Red Panda" = "小熊猫", "Sloth" = "树懒", "Snake" = "蛇", "Spider" = "蜘蛛", "Stoat" = "白鼬", "Tegu" = "泰加蜥", "Tiger" = "老虎",
	)
	return display_names[value] || value
