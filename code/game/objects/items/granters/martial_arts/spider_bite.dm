/obj/item/book/granter/martial/spider_bite
	martial = /datum/martial_art/spiders_bite

	name = "神秘卷轴"
	martial_name = "蛛咬拳"
	desc = "一卷布满奇怪符号的卷轴，似乎画着某种武术招式。"
	greet = span_sciradio("你学会了蜘蛛氏族世代传承的技艺——蛛咬拳。\
		现在，你可以踢击站立但步履踉跄的目标，并有机会踢掉其武器。\
		你还可以更有效地扑倒目标，并进行更牢固的抓握。")
	icon = 'icons/obj/scrolls.dmi'
	icon_state = "sleepingcarp"
	worn_icon_state = "scroll"
	remarks = list(
		"轻若蛛丝，狠如蛛噬。",
		"我必须与蜘蛛融为一体。",
		"我这辈子从没见过这种语言。至少还有插图。",
		"引力流转之术……我能驾驭重力的力量吗？",
		"腾跃攀爬之术……我的身体有那么灵活吗？",
		"多足蛛之术……我的踢击真有那么强吗？",
		"蛛网缠缚之术……只要用双臂缠住目标就行？",
	)

/obj/item/book/granter/martial/spider_bite/on_reading_finished(mob/living/carbon/user)
	. = ..()
	update_appearance()

/obj/item/book/granter/martial/spider_bite/update_appearance(updates)
	. = ..()
	if(uses <= 0)
		name = "空白卷轴"
		desc = "上面一片空白。"
		icon_state = "blankscroll"
	else
		name = initial(name)
		desc = initial(desc)
		icon_state = initial(icon_state)
