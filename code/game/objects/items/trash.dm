//Added by Jack Rost
/obj/item/trash
	icon = 'icons/obj/service/janitor.dmi'
	lefthand_file = 'icons/mob/inhands/items/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/food_righthand.dmi'
	abstract_type = /obj/item/trash
	desc = "这是垃圾。"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	item_flags = NOBLUDGEON|SKIP_FANTASY_ON_SPAWN
	custom_materials = list(/datum/material/plastic=SMALL_MATERIAL_AMOUNT*2)

/obj/item/trash/Initialize(mapload)
	var/turf/T = get_turf(src)
	if(T && is_station_level(T.z))
		SSblackbox.record_feedback("tally", "station_mess_created", 1, name)
	return ..()

/obj/item/trash/Destroy()
	var/turf/T = get_turf(src)
	if(T && is_station_level(T.z))
		SSblackbox.record_feedback("tally", "station_mess_destroyed", 1, name)
	return ..()

/obj/item/trash/raisins
	name = "\improper 4no 葡萄干"
	icon_state= "4no_raisins"
	custom_materials = list(/datum/material/cardboard=SMALL_MATERIAL_AMOUNT*2)

/obj/item/trash/candy
	name = "糖果"
	icon_state= "candy"

/obj/item/trash/cheesie
	name = "芝士脆角"
	icon_state = "cheesie_honkers"

/obj/item/trash/chips
	name = "薯片"
	icon_state = "chips"

/obj/item/trash/shrimp_chips
	name = "虾片"
	icon_state = "shrimp_chips"

/obj/item/trash/boritos
	name = "波利多玉米片袋"
	icon_state = "boritos"

/obj/item/trash/boritos/grind_results()
	return list(/datum/reagent/aluminium = 1)

/obj/item/trash/boritos/green
	icon_state = "boritosgreen"

/obj/item/trash/boritos/red
	icon_state = "boritosred"

/obj/item/trash/boritos/purple
	icon_state = "boritospurple"

/obj/item/trash/popcorn
	name = "爆米花"
	icon_state = "popcorn"
	custom_materials = list(/datum/material/cardboard=SMALL_MATERIAL_AMOUNT*2)

/obj/item/trash/popcorn/caramel
	name = "空焦糖爆米花袋"
	desc = "现在它不再是甜点，只是一个黏糊糊的袋子……"
	icon_state = "empty_caramel_popcorn"

/obj/item/trash/popcorn/salty
	name = "空咸味爆米花袋"
	desc = "看来袋子底部只剩下几粒盐了……"
	icon_state = "empty_salty_popcorn"

/obj/item/trash/sosjerky
	name = "\improper 胆小鬼私藏牛肉干"
	icon_state = "sosjerky"

/obj/item/trash/syndi_cakes
	name = "辛迪加蛋糕"
	icon_state = "syndi_cakes"
	custom_materials = list(/datum/material/cardboard=SMALL_MATERIAL_AMOUNT*2)

/obj/item/trash/energybar
	name = "能量棒包装纸"
	icon_state = "energybar"

/obj/item/trash/fleet_ration
	name = "舰队盈余口粮包装纸"
	desc = "在蛾族舰队里，每一张包装纸都会被仔细回收，重新制成新材料。而在这一带，它们更常见的归宿是被直接丢在地上。"
	icon_state = "moth_ration"
	custom_materials = list(/datum/material/cardboard=SMALL_MATERIAL_AMOUNT*2)

/obj/item/trash/pistachios
	name = "开心果袋"
	icon_state = "pistachios_pack"

/obj/item/trash/semki
	name = "葵花籽袋"
	icon_state = "semki_pack"

/obj/item/trash/semki/healthy
	name = "啃过的葵花籽"
	icon_state = "sunseeds"
	custom_materials = null

/obj/item/trash/tray
	name = "托盘"
	icon_state = "tray"
	resistance_flags = NONE
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*4)

/obj/item/trash/candle
	name = "融化的蜡烛"
	icon = 'icons/obj/candle.dmi'
	icon_state = "candle4"
	custom_materials = null

/obj/item/trash/candle/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/floor_placeable)

/obj/item/trash/flare
	name = "烧尽的照明弹"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "flare-empty"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*2,/datum/material/glass=SMALL_MATERIAL_AMOUNT,)

/obj/item/trash/can
	name = "压扁的罐子"
	icon_state = "cola"
	resistance_flags = NONE
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*2)

/obj/item/trash/can/grind_results()
	return list(/datum/reagent/aluminium = 10)

/obj/item/trash/can/food
	icon = 'icons/obj/food/canned.dmi'
	icon_state = "peachcan_empty"

/obj/item/trash/can/food/peaches
	name = "黄桃罐头"
	icon_state = "peachcan_empty"

/obj/item/trash/can/food/peaches/maint
	name = "维护通道黄桃罐头"
	icon_state = "peachcanmaint_empty"

/obj/item/trash/can/food/beans
	name = "一罐豆子"
	icon_state = "beans_empty"

/obj/item/trash/can/Initialize(mapload)
	. = ..()
	pixel_x = rand(-4,4)
	pixel_y = rand(-4,4)

/obj/item/trash/peanuts
	name = "\improper 画廊花生袋"
	desc = "这帖就是垃圾！"
	icon_state = "peanuts"

/obj/item/trash/cnds
	name = "\improper C&Ds 包装袋"
	icon_state = "cnds"

/obj/item/trash/can/food/envirochow
	name = "狗咬狗环保饲料"
	icon_state = "envirochow_empty"

/obj/item/trash/can/food/tomatoes
	name = "圣马扎诺番茄罐头"
	icon_state = "tomatoescan_empty"

/obj/item/trash/can/food/pine_nuts
	name = "松子罐头"
	icon_state = "pinenutscan_empty"

/obj/item/trash/can/food/jellyfish
	name = "射手水母罐头"
	icon_state = "jellyfish_empty"

/obj/item/trash/can/food/desert_snails
	name = "沙漠蜗牛罐头"
	icon_state = "snails_empty"

/obj/item/trash/can/food/larvae
	name = "蜜蜂幼虫罐头"
	icon_state = "larvae_empty"

/obj/item/trash/spacers_sidekick
	name = "\improper 太空旅伴包装袋"
	icon_state = "spacers_sidekick"

/obj/item/trash/ready_donk
	name = "空的咚克即食餐"
	desc = "它已经被咚克消灭殆尽。"
	icon_state = "ready_donk"

/obj/item/trash/can/food/squid_ink
	name = "墨鱼汁罐头"
	icon_state = "squidinkcan_empty"

/obj/item/trash/can/food/chap
	name = "一罐 CHAP"
	icon_state = "chapcan_empty"

/obj/item/trash/hot_shots
	name = "\improper 热辣射手盒"
	icon_state = "hot_shots"

/obj/item/trash/sticko
	name = "\improper 棒棒客盒"
	icon_state = "sticko"
	custom_materials = list(/datum/material/cardboard=SMALL_MATERIAL_AMOUNT*2)

/obj/item/trash/sticko/matcha
	icon_state = "sticko_matcha"

/obj/item/trash/sticko/nutty
	icon_state = "sticko_nutty"

/obj/item/trash/sticko/pineapple
	icon_state = "sticko_pineapple"

/obj/item/trash/sticko/yuyake
	icon_state = "sticko_yuyake"

/obj/item/trash/shok_roks
	name = "\improper 震震糖包装袋"
	icon_state = "shok_roks"

/obj/item/trash/shok_roks/citrus
	icon_state = "shok_roks_citrus"

/obj/item/trash/shok_roks/berry
	icon_state = "shok_roks_berry"

/obj/item/trash/shok_roks/tropical
	icon_state = "shok_roks_tropical"

/obj/item/trash/shok_roks/lanternfruit
	icon_state = "shok_roks_lanternfruit"
