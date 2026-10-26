/// BUBBER EDIT: Keep localized decal names separate from historical blackbox tally keys.
/obj/effect/decal/cleanable
	var/chinese_statistics_name
	var/chinese_statistics_display_name

/proc/chinese_cleanable_name_pairs()
	var/static/list/names
	if(isnull(names))
		names = list(
		"pool of blood" = "一滩血液",
		"pool of acid" = "一滩酸液",
		"xeno gibs" = "异形碎肉",
		"space ants" = "太空蚂蚁",
		"space fire ants" = "太空火蚁",
		"trail of blood" = "一道血液拖痕",
		"blood trail" = "血液拖痕",
		"gibs" = "碎肉",
		"old rotting gibs" = "陈旧腐烂的碎肉",
		"drop of blood" = "一滴血液",
		"footprints" = "脚印",
		"blood splatter" = "血液溅迹",
		"tomato smudge" = "番茄污渍",
		"plant smudge" = "植物污渍",
		"smashed egg" = "碎蛋",
		"smashed pie" = "碎馅饼",
		"salt pile" = "盐堆",
		"flour" = "面粉",
		"ink smear" = "墨渍",
		"pool of fuel" = "一滩燃料",
		"clutter" = "杂物",
		"ashes" = "灰烬",
		"large pile of ashes" = "一大堆灰烬",
		"tiny shards" = "细小碎片",
		"pile of screws" = "一堆螺丝",
		"dirt" = "污垢",
		"dust" = "灰尘",
		"glowing goo" = "发光黏液",
		"ectoplasmic puddle" = "灵质液滩",
		"radioactive goo" = "放射性黏液",
		"cobweb" = "蛛网",
		"gooey grey mass" = "灰色黏团",
		"big gooey grey mass" = "大团灰色黏团",
		"vomit" = "呕吐物",
		"nanite-infested vomit" = "纳米机器人滋生的呕吐物",
		"nebula vomit" = "星云呕吐物",
		"crusty dried vomit" = "结痂的干呕吐物",
		"black bile" = "黑胆汁",
		"chemical pile" = "化学物质堆",
		"shreds" = "碎布",
		"generic glitter pile" = "普通闪粉堆",
		"stabilized plasma" = "稳定等离子体",
		"insect guts" = "昆虫内脏",
		"confetti" = "彩纸屑",
		"plastic shreds" = "塑料碎片",
		"wrapping shreds" = "包装碎片",
		"pinata shreds" = "皮纳塔碎片",
		"decomposing garbage" = "腐烂垃圾",
		"rubble" = "碎石",
		"shredded can" = "破碎罐头",
		"concrete dust" = "混凝土粉尘",
		"robot debris" = "机器人残骸",
		"motor oil" = "机油",
		"caustic sludge" = "腐蚀性污泥",
		"rune" = "符文",
		"graffiti" = "涂鸦",
		"letter" = "字母",
		"number" = "数字",
		"punctuation mark" = "标点符号",
		"symbol" = "符号",
		"drawing" = "图案",
		"chalk outline" = "粉笔轮廓",
		"dusty robot debris" = "积灰的机器人残骸",
	)
	return names

/proc/chinese_cleanable_original_name(display_name)
	var/list/names = chinese_cleanable_name_pairs()
	for(var/original_name in names)
		if(names[original_name] == display_name)
			return original_name
	return display_name

/proc/chinese_cleanable_stat_name(obj/effect/decal/cleanable/decal)
	if(decal.chinese_statistics_display_name == decal.name && !isnull(decal.chinese_statistics_name))
		return decal.chinese_statistics_name
	return chinese_cleanable_original_name(decal.name)

/// Save the unlocalized dynamic name at the same moment its display value is generated.
/obj/effect/decal/cleanable/proc/chinese_update_cleanable_name(raw_name)
	chinese_statistics_name = chinese_cleanable_original_name(raw_name)
	chinese_statistics_display_name = chinese_blood_decal_name(chinese_statistics_name)
	return chinese_statistics_display_name

/proc/chinese_blood_decal_name(raw_name)
	var/list/names = chinese_cleanable_name_pairs()
	if(names[raw_name])
		return names[raw_name]
	if(findtext(raw_name, "dried ") == 1)
		return "干涸的[chinese_blood_decal_name(copytext(raw_name, 7))]"
	if(findtext(raw_name, "rotting ") == 1)
		return "腐烂的[chinese_blood_decal_name(copytext(raw_name, 9))]"
	if(findtext(raw_name, "pool of ") == 1)
		return "一滩[chinese_blood_decal_text(copytext(raw_name, 9))]"
	if(findtext(raw_name, "trail of ") == 1)
		return "一道[chinese_blood_decal_text(copytext(raw_name, 10))]拖痕"
	if(findtext(raw_name, "drop of ") == 1)
		return "一滴[chinese_blood_decal_text(copytext(raw_name, 9))]"
	if(findtext(raw_name, "drips of ") == 1)
		return "数滴[chinese_blood_decal_text(copytext(raw_name, 10))]"
	if(copytext(raw_name, -6) == " trail")
		return "[chinese_blood_decal_text(copytext(raw_name, 1, -6))]拖痕"
	if(copytext(raw_name, -9) == " splatter")
		return "[chinese_blood_decal_text(copytext(raw_name, 1, -9))]溅迹"
	return raw_name

/// Names here are display-only reagent labels; unknown or custom blood stays unchanged.
/proc/chinese_blood_decal_text(raw_text)
	var/static/list/names = list("blood" = "血液", "acid" = "酸液", "oil" = "油", "liquid electricity" = "液态电流", "colorful reagent" = "多彩试剂", "slime jelly" = "史莱姆凝胶", "water" = "水", "space lube" = "太空润滑剂", "copper" = "铜", "nanite slurry" = "纳米机器人浆液")
	var/list/parts = splittext(replacetext(raw_text, " and ", ", "), ", ")
	var/list/display_parts = list()
	for(var/part in parts)
		if(length(part))
			display_parts += names[part] || part
	return jointext(display_parts, "、")
