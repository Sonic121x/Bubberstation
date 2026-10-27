
// this costume has so many fugging parts 😭. fuck it, it's a file.
//in fact, we should strive to make the chaplain kits of this quality, moreso than the other way around.

/// undersuit
/obj/item/clothing/under/rank/civilian/chaplain/divine_archer
	name = "神射手套装"
	desc = "神射手的贴身内衬。"
	icon_state = "archergarb"
	inhand_icon_state = "archergarb"
	can_adjust = TRUE

/// suit
/obj/item/clothing/suit/hooded/chaplain_hoodie/divine_archer
	name = "神射手外套"
	desc = "神射手的外套，能提供一定防护。"
	icon_state = "archercoat"
	inhand_icon_state = "archercoat"
	body_parts_covered = CHEST|GROIN|LEGS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/chaplainsuit_armor_weaker
	strip_delay = 8 SECONDS
	equip_delay_other = 6 SECONDS
	hoodtype = /obj/item/clothing/head/hooded/chaplain_hood/divine_archer
	hood_up_affix = ""

/datum/armor/chaplainsuit_armor_weaker
	melee = 40
	bullet = 5
	laser = 5
	energy = 5
	fire = 60
	acid = 60
	wound = 10

/// hood
/obj/item/clothing/head/hooded/chaplain_hood/divine_archer
	name = "神射手兜帽"
	desc = "附赠一顶神射手兜帽——射箭时被太阳晃到过眼睛吗？哦，那感觉真是糟透了。"
	icon_state = "archerhood"
	armor_type = /datum/armor/chaplainsuit_armor_weaker

/// gloves
/obj/item/clothing/gloves/divine_archer
	name = "神射手护臂"
	desc = "护臂，射手的明智之选，免得衣袖妨碍拉弓和放箭。"
	icon_state = "archerbracers"
	inhand_icon_state = "archerbracers"
	body_parts_covered = ARMS|HANDS
	strip_delay = 4 SECONDS
	equip_delay_other = 2 SECONDS
	resistance_flags = NONE
	armor_type = /datum/armor/chaplainsuit_armor_weaker

/// boots
/obj/item/clothing/shoes/divine_archer
	name = "神射手靴子"
	desc = "靴子，让你瞄准时站得更稳。"
	icon_state = "archerboots"
	inhand_icon_state = "archerboots"
	body_parts_covered = LEGS|FEET
	strip_delay = 3 SECONDS
	equip_delay_other = 5 SECONDS
	resistance_flags = NONE
	fastening_type = SHOES_SLIPON
	armor_type = /datum/armor/shoes_divine_archer

/datum/armor/shoes_divine_archer
	melee = 10
	bullet = 5
	laser = 5
	energy = 5
	fire = 60
	acid = 60
	wound = 10
