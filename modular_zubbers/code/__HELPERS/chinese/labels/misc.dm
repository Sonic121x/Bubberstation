// BUBBER EDIT: Presentation-only labels; callers retain original keys and values.
/proc/chinese_vote_display(value)
	if(!istext(value))
		return value
	var/static/list/display_names = list("Map" = "地图", "Custom" = "自定义", "Restart" = "重启", "Transfer" = "船员转移")
	return display_names[value] || value

/proc/chinese_weather_display(value)
	if(!istext(value))
		return value
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"space wind" = "太空风",
		"ash storm" = "灰烬风暴",
		"emberfall" = "落烬",
		"the floor is lava" = "地板熔岩化",
		"radiation storm" = "辐射风暴",
		"rain" = "雨",
		"magical rain" = "魔法雨",
		"severe sandstorm" = "强沙尘暴",
		"sandfall" = "落沙",
		"snow storm" = "暴风雪",
		"void storm" = "虚空风暴",
	)
	return display_names[value] || value

/proc/chinese_color_display(value)
	if(!istext(value))
		return value
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"blue" = "蓝色", "brown" = "棕色", "crimson" = "深红色",
		"cyan" = "青色", "gold" = "金色", "green" = "绿色",
		"grey" = "灰色", "lime" = "黄绿色", "magenta" = "洋红色",
		"orange" = "橙色", "pink" = "粉色", "purple" = "紫色",
		"red" = "红色", "silver" = "银色", "violet" = "紫罗兰色",
		"white" = "白色", "yellow" = "黄色", "black" = "黑色",
		"dim grey" = "暗灰色", "light grey" = "浅灰色",
	)
	return display_names[value] || value

/proc/chinese_language_display(value)
	if(!istext(value))
		return value
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"Carptongue" = "鲤鱼语", "Draconic" = "龙语", "Calcic" = "骨语",
		"Gibbering" = "胡言乱语", "Encoded Audio Language" = "编码音频语言",
		"Buzzwords" = "嗡鸣语", "Beachtongue" = "海滩俚语", "Codespeak" = "暗语",
		"Galactic Common" = "银河通用语", "Sol Common" = "太阳系通用语",
		"Moffic" = "蛾语", "Mothic" = "蛾语", "Drone" = "无人机语",
		"Chimpanzee" = "黑猩猩语", "Mushroom" = "蘑菇语", "Nar'Sian" = "纳尔西语",
		"Piratespeak" = "海盗黑话", "Nekomimetic" = "猫语", "Shadowtongue" = "暗影语",
		"Slime" = "史莱姆语", "Spinwarder" = "顺旋语", "Sylvan" = "林语",
		"Terrum" = "岩语", "Galactic Uncommon" = "银河异通用语", "Voltaic" = "电语",
		"Wormspeak" = "虫语", "Xenomorph" = "异形语", "Ratvarian" = "拉特瓦尔语",
		"Ættmál" = "部族语", "Ashtongue" = "灰烬语", "Canilunzt" = "犬语",
		"Chitinclick" = "甲壳鸣语", "Plutonian" = "冥王星语", "Skrelluq" = "斯克雷尔语",
		"Spacer" = "太空人语", "Te Velu Akko" = "泰维鲁阿科语", "Vox Pidgin" = "沃克斯混合语",
		"Xerxian" = "薛西斯语", "Martian Yangyu" = "火星洋语", "Konjin" = "火星洋语",
		"Marish" = "玛尔语", "Empathy" = "共感语", "Lesser Hivemind" = "次级蜂巢意识",
		"Interslavic" = "斯拉夫共通语", "Federation Legalese" = "联邦法律语",
		"Siik'maas" = "西克玛斯语", "Enochian" = "以诺语", "Terran Uncommon" = "地球异通用语",
	)
	return display_names[value] || value

/// Display department labels without changing access-control identifiers.
/proc/chinese_department_display(value)
	if(!istext(value))
		return value
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"command" = "指挥部", "engineering" = "工程部", "medical" = "医疗部",
		"security" = "安保部", "science" = "科研部", "cargo" = "货运部",
		"service" = "服务部", "civilian" = "民事部门", "centcom" = "中央指挥部",
		"central command" = "中央指挥部", "supply" = "补给部", "silicon" = "硅基单位", "mining" = "采矿部", "unknown" = "未知",
	)
	return display_names[LOWER_TEXT(value)] || value

/// Flavor levels loaded from spook_levels.txt remain unchanged in the data file.
/proc/chinese_spook_level_display(value)
	if(!istext(value))
		return value
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"moderate" = "适度", "regular" = "常规", "okay" = "还行", "somewhat irregular" = "略有异常",
		"weird" = "古怪", "offputting" = "令人不安", "ungodly" = "骇人", "off the charts" = "爆表",
		"earth-shattering" = "惊天动地", "station-shaking" = "震撼空间站", "REDACTED" = "已删节",
		"annoying" = "恼人", "nuisance heavy" = "严重扰民", "intern" = "实习生", "clown" = "小丑",
		"Poly" = "波莉", "low" = "低", "medium" = "中", "high" = "高", "medium rare" = "三分熟",
		"golem" = "魔像", "cheesy horror flick" = "俗套恐怖片", "SKELLY TONE" = "骷髅音调",
		"chair-moving" = "椅子乱动", "hair-raising" = "毛骨悚然", "RUNTIME ERROR" = "运行时错误",
		"help" = "救命", "IT COMES" = "它来了", "NAR" = "纳尔", "hi" = "你好",
	)
	return display_names[value] || value

/// Circuit error strings remain stable; translate them only when shown to a user.
/proc/chinese_launchpad_error_display(value)
	if(!istext(value))
		return value
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"ERROR: Launchpad not operative. Make sure the launchpad is ready and powered." = "错误：传送台无法运行。请确保传送台已就绪且有电力。",
		"ERROR: Launchpad busy." = "错误：传送台正忙。",
		"ERROR: Launchpad not operative. Heavy area shielding makes teleporting impossible." = "错误：传送台无法运行。区域的强力屏蔽阻止了传送。",
		"Not connected!" = "未连接！", "Out of range!" = "超出范围！",
	)
	return display_names[value] || value

/// Preserve the selected area datum, including identically named areas.
/proc/chinese_area_choice(mob/user, message, title, list/choices)
	var/list/display_choices = list()
	for(var/area/choice as anything in choices)
		var/display_label = "[chinese_area_display(choice.name)] ([choice.name])"
		if(display_label in display_choices)
			display_label += " ([REF(choice)])"
		display_choices[display_label] = choice
	var/selected = tgui_input_list(user, message, title, display_choices)
	return isnull(selected) ? null : display_choices[selected]

/// Scan modes and severity keys remain unchanged in scanner settings and UI actions.
/proc/chinese_scangate_display(value)
	if(!istext(value))
		return value
	var/list/display_names = list(
		"Off" = "关闭", "Mindshield" = "心智护盾", "Disease" = "疾病", "Guns" = "枪械",
		"Wanted" = "通缉", "Species" = "物种", "Nutrition" = "营养", "Gender" = "性别", "Nanites" = "纳米机器人",
		"Positive" = "有益", "Harmless" = "无害", "Minor" = "轻微", "Medium" = "中等",
		"Harmful" = "有害", "Dangerous" = "危险", "BIOHAZARD" = "生化危害",
	)
	return display_names[value] || value
