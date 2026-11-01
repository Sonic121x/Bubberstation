// BUBBER EDIT: Dispenser reagents retain master's internal names and ordering.
// Translate only presentation values; do not translate recipe keys or action IDs.
/proc/chinese_reagent_display(value, return_mapping = FALSE)
	var/static/list/labels
	if(isnull(labels))
		labels = list(
			"Synthflesh" = "合成肉液",
			"Ethanol" = "乙醇",
			"Beer" = "啤酒",
			"Malt Liquor" = "麦芽酒",
			"Kahlua" = "卡鲁瓦",
			"Whiskey" = "威士忌",
			"Thirteen Loko" = "十三洛科",
			"Vodka" = "伏特加",
			"Gin" = "金酒",
			"Rum" = "朗姆酒",
			"Tequila" = "龙舌兰酒",
			"Vermouth" = "味美思",
			"Wine" = "葡萄酒",
			"Cognac" = "干邑",
			"Absinthe" = "苦艾酒",
			"Ale" = "艾尔啤酒",
			"Whiskey Cola" = "威士忌可乐",
			"Hard Cider" = "烈性苹果酒",
			"Atomic Bomb" = "原子弹",
			"Triple Sec" = "三重橙酒",
			"Creme de Menthe" = "薄荷利口酒",
			"Creme de Cacao" = "可可利口酒",
			"Creme de Coconut" = "椰子利口酒",
			"Sake" = "清酒",
			"Fernet" = "费内特",
			"Applejack" = "苹果杰克",
			"Curaçao" = "库拉索",
			"Navy Rum" = "海军朗姆酒",
			"Rice Beer" = "米啤酒",
			"Yūyake" = "夕烧",
			"Coconut Rum" = "椰子朗姆酒",
			"Orange Juice" = "橙汁",
			"Tomato Juice" = "番茄汁",
			"Lime Juice" = "青柠汁",
			"Berry Juice" = "浆果汁",
			"Apple Juice" = "苹果汁",
			"Watermelon Juice" = "西瓜汁",
			"Lemon Juice" = "柠檬汁",
			"Banana Juice" = "香蕉汁",
			"Cream" = "奶油",
			"Coffee" = "咖啡",
			"Tea" = "茶",
			"Iced Tea" = "冰茶",
			"Cola" = "可乐",
			"SM Wind" = "太空山风",
			"Dr. Gibb" = "吉布博士",
			"Space-Up" = "太空七喜",
			"Lemon Lime" = "柠檬青柠",
			"Pwr Game" = "电玩能量",
			"Shambler's Juice" = "蹒跚者果汁",
			"Soda Water" = "苏打水",
			"Tonic Water" = "汤力水",
			"Ice" = "冰",
			"Pumpkin Juice" = "南瓜汁",
			"Blumpkin Juice" = "布伦普金汁",
			"Menthol" = "薄荷醇",
			"Grenadine" = "石榴糖浆",
			"Pineapple Juice" = "菠萝汁",
			"Peach Juice" = "桃子汁",
			"Sol Dry" = "太阳干姜",
			"Melon Soda" = "甜瓜苏打",
			"Space Drugs" = "太空毒品",
			"Sugar" = "糖",
			"Frost Oil" = "霜冻油",
			"Vanilla Powder" = "香草粉",
			"Liquid Electricity" = "液态电力",
			"Mint Extract" = "薄荷提取物",
			"Cryoxadone" = "冷冻沙酮",
			"Miner's Salve" = "矿工药膏",
			"Morphine" = "吗啡",
			"Mutadone" = "去突变药",
			"Water" = "水",
			"Oxygen" = "氧气",
			"Copper" = "铜",
			"Nitrogen" = "氮气",
			"Hydrogen" = "氢气",
			"Potassium" = "钾",
			"Mercury" = "汞",
			"Sulfur" = "硫",
			"Carbon" = "碳",
			"Chlorine" = "氯",
			"Fluorine" = "氟",
			"Sodium" = "钠",
			"Phosphorus" = "磷",
			"Lithium" = "锂",
			"Iron" = "铁",
			"Silver" = "银",
			"Uranium" = "铀",
			"Radium" = "镭",
			"Aluminium" = "铝",
			"Silicon" = "硅",
			"Welding Fuel" = "焊接燃料",
			"Ammonia" = "氨",
			"Diethylamine" = "二乙胺",
			"E-Z Nutrient" = "易滋营养剂",
			"Left 4 Zed" = "求生之路 4",
			"Robust Harvest" = "强劲丰收",
			"Enduro Grow" = "耐性生长剂",
			"Liquid Earthquake" = "液态地震",
			"Oil" = "油",
			"Stable Plasma" = "稳定等离子体",
			"Iodine" = "碘",
			"Bromine" = "溴",
			"Phenol" = "苯酚",
			"Ash" = "灰烬",
			"Acetone" = "丙酮",
			"Saltpetre" = "硝石",
			"Toxin" = "毒素",
			"Unstable Mutagen" = "不稳定诱变剂",
			"Plasma" = "等离子体",
			"Carpotoxin" = "鲤鱼毒素",
			"Mindbreaker Toxin" = "心智破坏毒素",
			"Plant-B-Gone" = "植物克星",
			"Weed Killer" = "除草剂",
			"Pest Killer" = "杀虫剂",
			"Tirizene" = "提里嗪",
			"Histamine" = "组胺",
			"Sulfuric Acid" = "硫酸",
			"Synthanol" = "合成醇",
		)
	if(return_mapping)
		return labels
	return labels[value] || value

/// Support names typed by players without changing stored reagent identifiers.
/proc/chinese_reagent_internal_name(value)
	if(!istext(value))
		return value
	var/list/labels = chinese_reagent_display(null, TRUE)
	for(var/internal_name in labels)
		if(labels[internal_name] == value)
			return internal_name
	return value

/// Recording data sent to the UI is a copy; saved recipes retain internal names.
/proc/chinese_reagent_recipe_display(list/recipe)
	if(isnull(recipe))
		return null
	var/list/display_recipe = list()
	for(var/reagent_name in recipe)
		var/label = chinese_reagent_display(reagent_name)
		display_recipe[label] += recipe[reagent_name]
	return display_recipe

/// Select a localized label while returning the original reagent name.
/proc/chinese_reagent_choice(mob/user)
	var/list/choices = list()
	for(var/reagent_name in GLOB.name2reagent)
		var/label = chinese_reagent_display(reagent_name)
		choices["[label] ([reagent_name])"] = reagent_name
	var/selected = tgui_input_list(user, "选择试剂", "试剂", choices)
	return choices[selected]

/// Convert only presentation fields in reaction lookup data, leaving IDs intact.
/proc/chinese_reagent_ui_display(list/data)
	if(!islist(data))
		return data
	for(var/key in data)
		if(islist(key))
			chinese_reagent_ui_display(key)
		else if(istext(key))
			if(key == "name" || key == "inverseReagent")
				data[key] = chinese_reagent_display(data[key])
			else if(islist(data[key]))
				chinese_reagent_ui_display(data[key])
	return data
