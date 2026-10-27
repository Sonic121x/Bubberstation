
/obj/item/melee/skateboard
	name = "滑板"
	desc = "一块滑板。可以放下来踩着滑行，也能当作激进的武器使用。"
	icon = 'icons/mob/rideables/vehicles.dmi'
	icon_state = "skateboard_held"
	inhand_icon_state = "skateboard"
	force = 12
	throwforce = 4
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("拍击", "猛击", "砸击", "重砸")
	attack_verb_simple = list("拍击", "猛击", "砸击", "重砸")
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)
	///The vehicle counterpart for the board
	var/board_item_type = /obj/vehicle/ridden/scooter/skateboard

/obj/item/melee/skateboard/attack_self(mob/user)
	var/obj/vehicle/ridden/scooter/skateboard/board = new board_item_type(get_turf(user), src)//this probably has fucky interactions with telekinesis but for the record it wasn't my fault
	board.buckle_mob(user)
	forceMove(board)

/obj/item/melee/skateboard/improvised
	name = "简易滑板"
	desc = "一块临时拼凑的滑板。可以放下来踩着滑行，也能当作激进的武器使用。"
	board_item_type = /obj/vehicle/ridden/scooter/skateboard/improvised

/obj/item/melee/skateboard/pro
	name = "滑板"
	desc = "EightO 品牌的专业滑板。看起来结实且做工精良。"
	icon_state = "skateboard2_held"
	inhand_icon_state = "skateboard2"
	board_item_type = /obj/vehicle/ridden/scooter/skateboard/pro
	custom_premium_price = PAYCHECK_COMMAND * 5

/obj/item/melee/skateboard/hoverboard
	name = "悬浮滑板"
	desc = "来自过去的复古风潮，太复古了！"
	icon_state = "hoverboard_red_held"
	inhand_icon_state = "hoverboard_red"
	board_item_type = /obj/vehicle/ridden/scooter/skateboard/hoverboard
	custom_premium_price = PAYCHECK_COMMAND * 5.4 //If I can't make it a meme I'll make it RAD

/obj/item/melee/skateboard/hoverboard/admin
	name = "董事会滑板"
	desc = "将一艘飞船的工程复杂度浓缩在一块板子里，价格也同样昂贵。"
	icon_state = "hoverboard_nt_held"
	inhand_icon_state = "hoverboard_nt"
	board_item_type = /obj/vehicle/ridden/scooter/skateboard/hoverboard/admin

/obj/item/melee/skateboard/holyboard
	name = "神圣滑板"
	desc = "一块蒙受神明祝福的滑板，拥有为我们的罪孽而滑行的力量。底面刻有首字母缩写“J.C.”。"
	icon_state = "hoverboard_holy_held"
	inhand_icon_state = "hoverboard_holy"
	force = 18
	throwforce = 6
	w_class = WEIGHT_CLASS_NORMAL
	obj_flags = parent_type::obj_flags | UNIQUE_RENAME
	attack_verb_continuous = list("猛撞", "撞击", "摩擦", "滑行")
	attack_verb_simple = list("猛撞", "撞击", "摩擦", "滑行")
	board_item_type = /obj/vehicle/ridden/scooter/skateboard/hoverboard/holyboarded

/obj/item/melee/skateboard/holyboard/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nullrod_core)
