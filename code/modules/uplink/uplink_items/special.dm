/datum/uplink_category/special
	name = "特殊"
	weight = -3

/datum/uplink_item/special
	category = /datum/uplink_category/special
	cant_discount = TRUE
	surplus = 0
	purchasable_from = NONE

/datum/uplink_item/special/autosurgeon
	name = "辛迪加自动手术器"
	desc = "一台可多次使用的自动手术器，能把任何你想要的东西植入自己体内。把空间站拆了，然后让它成为你的一部分。"
	item = /obj/item/autosurgeon/syndicate
	cost = 5

/datum/uplink_item/special/autosurgeon/New()
	..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_CYBERNETIC_REVOLUTION))
		purchasable_from |= UPLINK_TRAITORS
