/obj/item/book/granter/martial/carp
	martial = /datum/martial_art/the_sleeping_carp
	name = "神秘卷轴"
	martial_name = "睡鲤拳"
	desc = "一卷写满奇怪标记的卷轴，似乎是某种武术的图解。"
	greet = span_sciradio("你学会了古老的睡鲤拳！你的徒手格斗能力大幅增强，在战斗模式下能够偏转\
		射向你的任何弹体。只要穿着合适的武术服装，或以鲤鱼为主题的服装，\
		你也有机会闪避近战与徒手攻击。你的身体变得更加坚韧，能更好地抵御持久战中不断累积的长期创伤。不过，你也将无法\
		使用任何远程武器。在睡鲤拳标签页使用‘回忆教诲’指令，可以进一步了解新学会的武术。")
	icon = 'icons/obj/scrolls.dmi'
	icon_state = "sleepingcarp"
	worn_icon_state = "scroll"
	remarks = list(
		"等等，只要吃高蛋白饮食就能刀枪不入……？",
		"无坚不摧之力，岿然不动之物……",
		"集中精神……你就能在数秒内让任何敌人失去行动能力……",
		"必须穿透护甲才能造成最大伤害……",
		"我觉得这不能和其他武术结合使用……",
		"与鲤鱼融为一体……",
		"咕噜……",
	)

/obj/item/book/granter/martial/carp/on_reading_finished(mob/living/carbon/user)
	. = ..()
	update_appearance()

/obj/item/book/granter/martial/carp/update_appearance(updates)
	. = ..()
	if(uses <= 0)
		name = "空白卷轴"
		desc = "上面一片空白。"
		icon_state = "blankscroll"
	else
		name = initial(name)
		desc = initial(desc)
		icon_state = initial(icon_state)
