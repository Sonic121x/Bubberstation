// Wire Priest Robes
/obj/item/clothing/suit/hooded/techpriest/fleshmind
	name = "线缆祭司长袍"
	desc = "血肉一视同仁。加入血肉。"
	icon_state = "wirepriest"
	icon = 'modular_zubbers/icons/fleshmind/fleshmind_clothing.dmi'
	worn_icon = 'modular_zubbers/icons/fleshmind/fleshmind_clothing_onmob.dmi'
	hoodtype = /obj/item/clothing/head/hooded/techpriest/fleshmind
	armor_type = /datum/armor/suit_armor

/obj/item/clothing/head/hooded/techpriest/fleshmind
	name = "线缆祭司兜帽"
	icon = 'modular_zubbers/icons/fleshmind/fleshmind_clothing.dmi'
	worn_icon = 'modular_zubbers/icons/fleshmind/fleshmind_clothing_onmob.dmi'
	desc = "血肉一视同仁。加入血肉。"
	icon_state = "wirepriesthood"
	armor_type = /datum/armor/head_helmet

// Wire Priest's Staff
/obj/item/wire_priest_staff
	name = "线缆祭司法杖"
	desc = "一根缠满线缆的大木杖……线缆似乎正主动沿着杖身游动盘绕。\
	由于尺寸较大，它的攻击距离比大多数武器更远。"
	force = 20
	throwforce = 7
	reach = 2
	w_class = WEIGHT_CLASS_BULKY
	icon = 'modular_zubbers/icons/fleshmind/fleshmind_objects.dmi'
	lefthand_file = 'modular_zubbers/icons/fleshmind/fleshmind_objects_onmob_l.dmi'
	righthand_file = 'modular_zubbers/icons/fleshmind/fleshmind_objects_onmob_r.dmi'
	icon_state = "wireprieststaff"
