/obj/item/storage/lunchbox
	name = "午餐盒"
	icon = 'modular_zubbers/icons/obj/storage/lunchbox.dmi'
	icon_state = "lunchbox"
	desc = "这玩意儿彻底坏了，去骂程序员吧。"
	inhand_icon_state = "lunchbox"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/lunchbox_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/lunchbox_righthand.dmi'
	drop_sound = 'sound/items/handling/cardboard_box/cardboardbox_drop.ogg'
	pickup_sound =  'sound/items/handling/cardboard_box/cardboardbox_pickup.ogg'
	throw_speed = 3
	throw_range = 7

/obj/item/storage/lunchbox/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 8
	atom_storage.set_holdable(list(
		/obj/item/food,
		/obj/item/reagent_containers/cup,
		/obj/item/reagent_containers/condiment,
		/obj/item/storage/box/gum,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/lighter,
		))

/obj/item/storage/lunchbox/nanotrasen
	name = "纳米传讯午餐盒"
	icon_state = "lunchbox_nanotrasen"
	inhand_icon_state = "lunchbox_nanotrasen"
	desc = "一款精致的蓝色午餐盒，用来表达你对大家最爱的巨型企业的支持。"

/obj/item/storage/lunchbox/medical
	name = "医疗午餐盒"
	icon_state = "lunchbox_medical"
	inhand_icon_state = "lunchbox_medical"
	desc = "绿色的午餐盒，专为饥肠辘辘的医生设计。"

/obj/item/storage/lunchbox/bunny
	name = "兔子午餐盒"
	icon_state = "lunchbox_bunny"
	inhand_icon_state = "lunchbox"
	desc = "印着兔子的可爱午餐盒。"

/obj/item/storage/lunchbox/corgi
	name = "柯基午餐盒"
	icon_state = "lunchbox_corgi"
	inhand_icon_state = "lunchbox"
	desc = "印着柯基的可爱午餐盒。"

/obj/item/storage/lunchbox/heart
	name = "爱心午餐盒"
	icon_state = "lunchbox_heart"
	inhand_icon_state = "lunchbox_heart"
	desc = "印着心形图案的粉色午餐盒。"

/obj/item/storage/lunchbox/safetymoth
	name = "安全蛾午餐盒"
	icon_state = "lunchbox_safetymoth"
	inhand_icon_state = "lunchbox_safetymoth"
	desc = "橙色的衬铅午餐盒，印着大家最爱的飞蛾。"

/obj/item/storage/lunchbox/amongus
	name = "可疑午餐盒"
	icon_state = "lunchbox_suspicious"
	inhand_icon_state = "lunchbox_suspicious"
	desc = "一个朴素的红色午餐盒……对吧？"
