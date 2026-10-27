/datum/ash_ritual/ash_bait
	name = "灰烬龙供品"
	desc = "为灰烬龙准备一份餐食。作为供品的回报，灰烬龙会掉落一些鳞片。"
	required_components = list(
		"north" = /obj/item/stack/ore/diamond,
		"south" = /obj/item/organ/monster_core/regenerative_core,
		"east" = /obj/item/food/meat/steak/goliath,
		"west" = /obj/item/food/meat/steak/goliath,
	)
	consumed_components = list(
		/obj/item/stack/ore/diamond,
		/obj/item/organ/monster_core/regenerative_core,
		/obj/item/food/meat/steak/goliath,
		/obj/item/food/meat/steak/goliath,
	)
	ritual_success_items = list(
		/obj/item/food/meat/slab/drakebait,
	)
