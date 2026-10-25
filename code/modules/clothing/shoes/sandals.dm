/obj/item/clothing/shoes/sandal
	desc = "一双相当朴素的木制凉鞋。"
	name = "凉鞋"
	icon_state = "wizard"
	inhand_icon_state = "wizshoe"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT)
	resistance_flags = FLAMMABLE
	strip_delay = 0.5 SECONDS
	equip_delay_other = 5 SECONDS
	armor_type = /datum/armor/shoes_sandal
	fastening_type = SHOES_SLIPON
	species_exception = list(/datum/species/golem)
	lace_time = 3 SECONDS
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/shoes/sandal/alt
	name = "黑色凉鞋"
	desc = "一双闪亮的黑色木制凉鞋。"
	icon_state = "blacksandals"
	inhand_icon_state = "blacksandals"

/datum/armor/shoes_sandal
	bio = 10

/obj/item/clothing/shoes/sandal/magic
	name = "魔法凉鞋"
	desc = "一双被施了魔法的凉鞋。"
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/shoes/sandal/beach
	name = "人字拖"
	desc = "一双非常时尚的人字拖。"

/obj/item/clothing/shoes/sandal/velcro
	name = "尼龙搭扣凉鞋"
	desc = "一双木制凉鞋，为了符合公司制服规定，被“升级”上了尼龙搭扣带。"
	fastening_type = SHOES_VELCRO

/obj/item/clothing/shoes/sandal/alt/velcro
	name = "黑色尼龙搭扣凉鞋"
	desc = "一双闪亮的黑色凉鞋，为了符合公司制服规定，被“升级”上了尼龙搭扣带。"
	fastening_type = SHOES_VELCRO
