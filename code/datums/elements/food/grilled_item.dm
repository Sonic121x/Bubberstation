/// Items grilled through the grill.
/datum/element/grilled_item

/datum/element/grilled_item/Attach(datum/target, grill_time)
	. = ..()
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE

	var/atom/this_food = target

	switch(grill_time) //no 0-20 to prevent spam
		if(20 SECONDS to 30 SECONDS)
			this_food.name = "轻烤的[this_food.name]"
			this_food.desc += "稍微烤过。"

		if(30 SECONDS to 80 SECONDS)
			this_food.name = "烤制的[this_food.name]"
			this_food.desc += "已经烤过了。"

		if(80 SECONDS to 100 SECONDS)
			this_food.name = "重度烤制的[this_food.name]"
			this_food.desc += "已经烤得很熟了。"

		if(100 SECONDS to INFINITY) //grill marks reach max alpha
			this_food.name = "火力全开的烤[this_food.name]"
			this_food.desc = "一份[this_food.name]。让你想起了妻子，等等，不，它更漂亮！"

	if(grill_time > 30 SECONDS && isnull(this_food.GetComponent(/datum/component/edible)))
		this_food.AddComponentFrom(SOURCE_EDIBLE_GRILLED, /datum/component/edible, foodtypes = FRIED)

	SEND_SIGNAL(this_food, COMSIG_ITEM_BARBEQUE_GRILLED, grill_time)
	ADD_TRAIT(this_food, TRAIT_FOOD_BBQ_GRILLED, ELEMENT_TRAIT(type))

/datum/element/grilled_item/Detach(atom/source, ...)
	source.name = initial(source.name)
	source.desc = initial(source.desc)
	source.RemoveComponentSource(SOURCE_EDIBLE_GRILLED, /datum/component/edible)
	REMOVE_TRAIT(src, TRAIT_FOOD_BBQ_GRILLED, ELEMENT_TRAIT(type))
	return ..()
