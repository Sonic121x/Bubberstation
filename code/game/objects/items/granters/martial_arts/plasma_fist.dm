/obj/item/book/granter/martial/plasma_fist
	martial = /datum/martial_art/plasma_fist
	name = "磨损的卷轴"
	martial_name = "等离子拳"
	desc = "一张年久磨损的纸片，上面写着不断变幻的符文，还绘有徒手搏击的插图。"
	greet = span_bolddanger("你学会了古老武术等离子拳。连招极难施展，却包含了世间最致命的一些招式，\
		其中的等离子拳一旦成功施展，就会让对手猛烈爆炸。")
	icon = 'icons/obj/scrolls.dmi'
	icon_state ="plasmafist"
	remarks = list(
		"平衡……",
		"力量……",
		"控制……",
		"精通……",
		"警觉……",
		"技巧……",
	)

/obj/item/book/granter/martial/plasma_fist/on_reading_finished(mob/living/carbon/user)
	. = ..()
	update_appearance()

/obj/item/book/granter/martial/plasma_fist/update_appearance(updates)
	. = ..()
	if(uses <= 0)
		name = "空白卷轴"
		desc = "上面一片空白。"
		icon_state = "blankscroll"
	else
		name = initial(name)
		desc = initial(desc)
		icon_state = initial(icon_state)

/obj/item/book/granter/martial/plasma_fist/nobomb
	martial = /datum/martial_art/plasma_fist/nobomb
