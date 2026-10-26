// BUBBER ADDITION: Stencil labels are separate from the icon-state protocol values.
/proc/chinese_crayon_stencil_display(value)
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"amyjon" = "艾米乔恩", "antilizard" = "反蜥蜴", "body" = "人体轮廓", "cyka" = "俄语粗口", "dwarf" = "矮人", "end" = "终结", "engie" = "工程师", "face" = "面孔", "guy" = "小人", "matt" = "马特", "prolizard" = "亲蜥蜴", "revolution" = "革命", "star" = "星星", "uboa" = "乌波亚",
		"biohazard" = "生物危害", "credit" = "信用点", "danger" = "危险", "electricdanger" = "触电危险", "firedanger" = "火灾危险", "evac" = "撤离", "food" = "食物", "heart" = "爱心", "like" = "赞", "med" = "医疗", "nay" = "反对", "peace" = "和平", "radiation" = "辐射", "safe" = "安全", "shop" = "商店", "skull" = "骷髅", "space" = "太空", "trade" = "交易",
		"beepsky" = "哔普斯基", "blueprint" = "蓝图", "bottle" = "瓶子", "brush" = "画笔", "carp" = "太空鲤鱼", "cat" = "猫", "clown" = "小丑", "corgi" = "柯基", "disk" = "磁盘", "fireaxe" = "消防斧", "ghost" = "幽灵", "largebrush" = "大画笔", "scroll" = "卷轴", "shotgun" = "霰弹枪", "smallbrush" = "小画笔", "snake" = "蛇", "splatter" = "泼洒", "stickman" = "火柴人", "taser" = "泰瑟枪", "toilet" = "马桶", "toolbox" = "工具箱",
		"arrow" = "箭头", "chevron" = "人字纹", "clawprint" = "爪印", "footprint" = "脚印", "line" = "线条", "pawprint" = "兽掌印", "shortline" = "短线", "thinline" = "细线", "rune1" = "符文一", "rune2" = "符文二", "rune3" = "符文三", "rune4" = "符文四", "rune5" = "符文五", "rune6" = "符文六",
		"furrypride" = "兽迷骄傲", "paint" = "油漆", "secborg" = "安保半机械人", "yiffhell" = "兽交地狱", "Random Graffiti" = "随机涂鸦", "Random Letter" = "随机字母", "Random Punctuation" = "随机标点", "Random Number" = "随机数字", "Random Symbol" = "随机符号", "Random Drawing" = "随机图案", "Random Oriented" = "随机定向图案", "Random Rune" = "随机符文", "Random Anything" = "完全随机",
	)
	return display_names[value] || value
