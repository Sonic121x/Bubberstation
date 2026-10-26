/// BUBBER ADDITION: Preserve existing action-layout preference keys after translation.
/proc/chinese_batch_five_clothing_action_storage(value, action_type)
	if(value == "切换兜帽" && ispath(action_type, /datum/action/item_action))
		return "Toggle Hood"
	if(ispath(action_type, /datum/action/item_action/chameleon/change) && findtext(value, "更改") == 1 && endswith(value, "外观"))
		var/item_name = copytext_char(value, 3, -2)
		var/static/list/item_names = list("物品" = "Item", "颈部配饰" = "Neck Accessory", "印章" = "Stamp", "平板电脑" = "Tablet", "耳机" = "Headset", "腰带" = "Belt", "背包" = "Backpack", "鞋子" = "Shoes", "面罩" = "Mask", "帽子" = "Hat", "手套" = "Gloves", "眼镜" = "Glasses", "外套" = "Suit", "连体服" = "Jumpsuit", "ID 卡" = "ID Card", "ID 卡饰条" = "ID Trim", "枪械" = "Gun", "变色龙扫描器" = "Chameleon Scanner")
		return "Change [item_names[item_name] || item_name] Appearance"
	var/static/list/legacy_names
	if(!legacy_names)
		legacy_names = list(
			/datum/action/cooldown/spell/shapeshift/polymorph_belt = list("反转变形场" = "Invert Polymorphic Field"),
			/datum/action/item_action/chameleon/change = list("变色龙变换" = "Chameleon Change"),
			/datum/action/chameleon_outfit = list("选择变色龙套装" = "Select Chameleon Outfit"),
			/datum/action/item_action/chameleon/drone/randomise = list("随机化头饰" = "Randomise Headgear"),
			/datum/action/item_action/chameleon/drone/togglehatmask = list("切换头饰模式" = "Toggle Headgear Mode"),
			/datum/action/item_action/switch_hud = list("切换 HUD" = "Switch HUD"),
			/datum/action/cooldown/spell/pointed/percept_hallucination = list("致幻" = "Hallucinate"),
			/datum/action/item_action/halt = list("站住！" = "HALT!"),
			/datum/action/item_action/toot = list("嘟！" = "TOOT!")
		)
	for(var/legacy_type in legacy_names)
		if(ispath(action_type, legacy_type))
			var/list/type_names = legacy_names[legacy_type]
			if(type_names[value])
				return type_names[value]
	return value
