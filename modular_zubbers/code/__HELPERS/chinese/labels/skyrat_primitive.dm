// BUBBER ADDITION: Chinese labels for ration, primitive crafting and skin choices.
/proc/chinese_skyrat_rations_display(value)
	var/static/list/labels = list(
		"Standard Meats" = "标准肉类", "Seafood Meats" = "海鲜肉类", "Tiziran Meats" = "提兹拉肉类", "Ethereal Meats" = "以太人肉类",
		"Blood Bag" = "血袋", "Glucose Medipens" = "葡萄糖注射笔",
		"Standard Produce" = "标准蔬菜", "Alternative Produce" = "替代蔬菜", "Mothic Produce" = "蛾人蔬菜", "Tiziran Produce" = "提兹拉蔬菜", "Ethereal Produce" = "以太人蔬果",
		"Standard Flour" = "普通面粉", "Korta Flour" = "科塔粉", "Ethereal Stock" = "以太人汤料",
		"Navy Rum" = "海军朗姆酒", "Ginger Beer" = "姜汁啤酒", "Kortara" = "科塔拉", "Voltaic Wine" = "伏打黄葡萄酒", "Hemoglobin Iced Tea" = "血红蛋白冰茶", "Soda and Lemonade" = "苏打水与柠檬水",
		"Cigarettes" = "香烟", "Coffee Powder" = "咖啡粉", "Tea Powder" = "茶粉", "Mixed Gum Pack" = "混合口香糖包",
		"Grind" = "研磨", "Juice" = "榨汁", "Mix" = "混合",
	)
	return labels[value] || value

/proc/chinese_skyrat_rations_radial(mob/user, atom/anchor, list/choices, radius)
	var/list/display_choices = list()
	var/list/original_choices = list()
	for(var/value in choices)
		var/label = chinese_skyrat_rations_display(value)
		display_choices[label] = choices[value]
		original_choices[label] = value
	var/selection = show_radial_menu(user, anchor, display_choices, radius = radius, require_near = TRUE)
	return isnull(selection) ? null : original_choices[selection]

/proc/chinese_skyrat_player_rank_display(value)
	var/static/list/labels = list("donator" = "赞助者", "mentor" = "导师", "vetted" = "已认证玩家")
	return labels[LOWER_TEXT(value)] || value

/proc/chinese_skyrat_glass_step_display(value)
	var/static/list/labels = list("blow" = "吹制", "spin" = "旋转", "paddle" = "拍板塑形", "shear" = "剪切", "jacks" = "成形钳塑形")
	return labels[value] || value

/proc/chinese_skyrat_plant_skin_display(value, atom/target)
	if(!istype(target, /obj/item/storage/bag/plants))
		return value
	var/static/list/labels = list("Original" = "原版", "Linen" = "亚麻")
	return labels[value] || value

/proc/chinese_skyrat_plant_skin_radial(mob/user, atom/anchor, list/choices, datum/callback/custom_check)
	var/list/display_choices = list()
	var/list/original_choices = list()
	for(var/value in choices)
		var/label = chinese_skyrat_plant_skin_display(value, anchor)
		display_choices[label] = choices[value]
		original_choices[label] = value
	var/selection = show_radial_menu(user, anchor, display_choices, custom_check = custom_check, radius = 38, require_near = TRUE)
	return isnull(selection) ? null : original_choices[selection]

/proc/chinese_skyrat_primitive_skill_display(value)
	var/static/list/labels = list("Construction" = "建造", "Primitive" = "原始生存", "Production" = "工艺制作")
	return labels[value] || value
