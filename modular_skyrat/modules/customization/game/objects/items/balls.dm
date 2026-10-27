/obj/item/toy/tennis
	name = "网球"
	desc = "一只经典的网球。表面似乎布满了淡淡的咬痕。"
	icon = 'modular_skyrat/master_files/icons/obj/balls.dmi'
	icon_state = "tennis_classic"
	worn_icon_state = "tennis_classic"
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/balls_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/balls_right.dmi'
	inhand_icon_state = "tennis_classic"
	worn_icon = 'modular_skyrat/master_files/icons/mob/mouthball.dmi'
	slot_flags = ITEM_SLOT_HEAD | ITEM_SLOT_NECK | ITEM_SLOT_EARS	//Fluff item, put it wherever you want!
	throw_range = 14
	w_class = WEIGHT_CLASS_SMALL

/obj/item/toy/tennis/rainbow
	name = "伪欧几里得跨维度网球球体"
	desc = "一只来自另一个存在位面的网球。真的很带感。"
	icon_state = "tennis_rainbow"
	worn_icon_state = "tennis_rainbow"
	inhand_icon_state = "tennis_rainbow"
	actions_types = list(/datum/action/item_action/squeeze)		//Giving the masses easy access to unilimted honks would be annoying

/obj/item/toy/tennis/rainbow/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak)

/obj/item/toy/tennis/rainbow/izzy	//izzyinbox's donator item
	name = "卡特琳的球"
	desc = "一只受过不少宠爱的网球，上面沾着几根黑白相间的毛和一些口水。"
	icon_state = "tennis_izzy"
	worn_icon_state = "tennis_izzy"
	inhand_icon_state = "tennis_izzy"

/obj/item/toy/tennis/red	//da red wuns go fasta
	name = "红色网球"
	desc = "一只红色网球。它能飞出三倍的速度！"
	icon_state = "tennis_red"
	worn_icon_state = "tennis_red"
	inhand_icon_state = "tennis_red"
	throw_speed = 9

/obj/item/toy/tennis/yellow	//because yellow is hot I guess
	name = "黄色网球"
	desc = "一只黄色网球。它似乎涂有阻燃涂层。"
	icon_state = "tennis_yellow"
	worn_icon_state = "tennis_yellow"
	inhand_icon_state = "tennis_yellow"
	resistance_flags = FIRE_PROOF

/obj/item/toy/tennis/green	//pestilence
	name = "绿色网球"
	desc = "一只绿色网球。它似乎涂有不透水涂层。"
	icon_state = "tennis_green"
	worn_icon_state = "tennis_green"
	inhand_icon_state = "tennis_green"

/obj/item/toy/tennis/cyan	//electric
	name = "青色网球"
	desc = "一只青色网球。它似乎具有奇特的电学性质。"
	icon_state = "tennis_cyan"
	worn_icon_state = "tennis_cyan"
	inhand_icon_state = "tennis_cyan"
	siemens_coefficient = 0.9

/obj/item/toy/tennis/blue	//reliability
	name = "蓝色网球"
	desc = "一只蓝色网球。它似乎比普通网球略微结实一些。"
	icon_state = "tennis_blue"
	worn_icon_state = "tennis_blue"
	inhand_icon_state = "tennis_blue"
	max_integrity = 300

/obj/item/toy/tennis/purple	//because purple dyes have high pH and would neutralize acids I guess
	name = "紫色网球"
	desc = "一只紫色网球。它似乎涂有耐酸涂层。"
	icon_state = "tennis_purple"
	worn_icon_state = "tennis_purple"
	inhand_icon_state = "tennis_purple"
	resistance_flags = ACID_PROOF

/datum/action/item_action/squeeze
	name = "吱吱！"
