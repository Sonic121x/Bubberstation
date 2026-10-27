/// Exploration drone unlockables ///

/datum/supply_pack/exploration
	order_flags = ORDER_SPECIAL
	group = "Outsourced"

/datum/supply_pack/exploration/scrapyard
	name = "废料场板条箱"
	desc = "外包板条箱，内含各种废品。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/relic,
					/obj/item/broken_bottle,
					/obj/item/pickaxe/rusted)
	crate_name = "废料场板条箱"

/datum/supply_pack/exploration/catering
	name = "餐饮板条箱"
	desc = "没有厨师？没问题！食物品质可能因供应商而异。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/food/sandwich = 5)
	crate_name = "外包食品板条箱"

/datum/supply_pack/exploration/catering/fill(obj/structure/closet/crate/crate)
	. = ..()
	if(!prob(30))
		return

	for(var/obj/item/food/food_item in crate)
		// makes all of our items GROSS
		food_item.name = "变质的 [food_item.name]"
		food_item.AddComponentFrom(SOURCE_EDIBLE_INNATE, /datum/component/edible, foodtypes = GROSS)

/datum/supply_pack/exploration/shrubbery
	name = "灌木板条箱"
	desc = "装满绿篱灌木的板条箱。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/grown/shrub = 8)
	crate_name = "灌木板条箱"
