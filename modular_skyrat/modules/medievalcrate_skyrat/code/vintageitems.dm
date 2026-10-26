/obj/item/clothing/gloves/plate/larp
	desc = "它们像手套，不过是金属做的。最好别碰带电的电线！"
	siemens_coefficient = 1

	body_parts_covered = parent_type::body_parts_covered | ARMS
	armor_type = /datum/armor/plate_larp

/datum/armor/plate_larp
	melee = 10
	bullet = 5
	laser = 5
	energy = 5
	bomb = 5
	fire = 60
	acid = 60

/obj/item/clothing/gloves/plate/larp/red
	icon_state = "crusader-red"

/obj/item/clothing/gloves/plate/larp/blue
	icon_state = "crusader-blue"

/obj/item/clothing/shoes/plate/larp
	clothing_flags = null
	armor_type = /datum/armor/plate_larp

/obj/item/clothing/shoes/plate/larp/red
	icon_state = "crusader-red"

/obj/item/clothing/shoes/plate/larp/blue
	icon_state = "crusader-blue"

/obj/item/clothing/suit/armor/riot/knight/larp
	name = "板甲"
	desc = "一套沉重的板甲复制品，在抵挡近战攻击方面非常有效。"
	slowdown = 0.7

/obj/item/clothing/suit/armor/riot/knight/larp/blue
	icon_state = "knight_blue"

/obj/item/clothing/suit/armor/riot/knight/larp/red
	icon_state = "knight_red"

/obj/item/clothing/suit/armor/vest/cuirass/larp
	armor_type = /datum/armor/cuirass_larp

/datum/armor/cuirass_larp
	melee = 30
	bullet = 30
	laser = 5
	energy = 5
	bomb = 5
	fire = 60
	acid = 60
