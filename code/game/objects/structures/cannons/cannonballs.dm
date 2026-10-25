/obj/item/stack/cannonball
	name = "炮弹"
	desc = "一叠沉重的塑钢炮弹。太空时代的炮术！"
	icon_state = "cannonballs"
	base_icon_state = "cannonballs"
	max_amount = 14
	singular_name = "炮弹"
	merge_type = /obj/item/stack/cannonball
	throwforce = 10
	obj_flags = CONDUCTS_ELECTRICITY
	custom_materials = list(/datum/material/alloy/plasteel=SHEET_MATERIAL_AMOUNT)
	resistance_flags = FIRE_PROOF
	throw_speed = 5
	throw_range = 3
	///the type of projectile this type of cannonball item turns into.
	var/obj/projectile/projectile_type = /obj/projectile/bullet/cannonball

/obj/item/stack/cannonball/update_icon_state()
	. = ..()
	icon_state = (amount == 1) ? "[base_icon_state]" : "[base_icon_state]_[min(amount, 14)]"

/obj/item/stack/cannonball/fourteen
	amount = 14

/obj/item/stack/cannonball/four
	amount = 4

/obj/item/stack/cannonball/shellball
	name = "爆炸榴弹"
	singular_name = "爆炸榴弹"
	desc = "一种爆炸性的反器材、反炮兵炮弹。对付任何墙壁都极有效，方便开个入口。"
	color = COLOR_RED
	merge_type = /obj/item/stack/cannonball/shellball
	projectile_type = /obj/projectile/bullet/cannonball/explosive

/obj/item/stack/cannonball/shellball/seven
	amount = 7

/obj/item/stack/cannonball/shellball/fourteen
	amount = 14

/obj/item/stack/cannonball/emp
	name = "故障弹"
	singular_name = "故障弹"
	icon_state = "emp_cannonballs"
	base_icon_state = "emp_cannonballs"
	desc = "一发内有两个腔室的炮弹，撞击时混合产生化学 EMP。这到底是什么意思？谁知道呢。现代海盗用上这些新玩意儿后，真是彻底没了灵魂。"
	max_amount = 4
	merge_type = /obj/item/stack/cannonball/emp
	projectile_type = /obj/projectile/bullet/cannonball/emp

/obj/item/stack/cannonball/the_big_one
	name = "“最大颗”"
	singular_name = "“最大颗”"
	desc = "疯狂的炸药量被塞进一颗巨大的炮弹里。这可能是你在一场战斗中发射的最后一颗炮弹，主要是因为之后也没什么可打的了。"
	max_amount = 5
	icon_state = "biggest_cannonballs"
	base_icon_state = "biggest_cannonballs"
	merge_type = /obj/item/stack/cannonball/the_big_one
	projectile_type = /obj/projectile/bullet/cannonball/biggest_one

/obj/item/stack/cannonball/the_big_one/five
	amount = 5

/obj/item/stack/cannonball/trashball
	name = "垃圾球"
	singular_name = "垃圾球"
	desc = "一团塞得紧紧的垃圾。它确实能当炮弹用，但把它塞进真炮里可能不太健康。"
	max_amount = 4
	icon_state = "trashballs"
	base_icon_state = "trashballs"
	merge_type = /obj/item/stack/cannonball/trashball
	projectile_type = /obj/projectile/bullet/cannonball/trashball
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/stack/cannonball/trashball/four
	amount = 4
