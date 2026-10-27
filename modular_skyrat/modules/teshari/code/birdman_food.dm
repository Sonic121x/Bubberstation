/obj/item/food/meat/slab/chicken/human
	name = "肉"
	tastes = list("嫩肉" = 1)
	foodtypes = MEAT | RAW | GORE
	venue_value = FOOD_MEAT_HUMAN

/obj/item/food/meat/slab/chicken/human/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/chicken/human, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/steak/chicken/human/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency = 1)
	. = ..()
	if(!istype(source_item, /obj/item/food/meat))
		return

	var/obj/item/food/meat/origin_meat = source_item
	subjectname = origin_meat.subjectname
	subjectjob = origin_meat.subjectjob
	if(subjectname)
		name = "[origin_meat.subjectname]肉排"
	else if(subjectjob)
		name = "[chinese_job_display(origin_meat.subjectjob)]肉排"

/obj/item/food/meat/slab/chicken/human/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/meat/rawcutlet/chicken/human, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切割")

/obj/item/food/meat/steak/chicken/human
	tastes = list("嫩肉" = 1)
	foodtypes = MEAT | GORE

/obj/item/food/meat/rawcutlet/chicken/human
	tastes = list("嫩肉" = 1)
	foodtypes = MEAT | RAW | GORE

/obj/item/food/meat/cutlet/chicken/human
	tastes = list("嫩肉" = 1)
	foodtypes = MEAT | GORE

/obj/item/food/meat/cutlet/chicken/human/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency)
	. = ..()
	if(!istype(source_item, /obj/item/food/meat))
		return

	var/obj/item/food/meat/origin_meat = source_item
	if(subjectname)
		name = "[origin_meat.subjectname] [initial(name)]"
	else if(subjectjob)
		name = "[chinese_job_display(origin_meat.subjectjob)][initial(name)]"

/obj/item/food/raw_meatball/chicken/human
	name = "奇怪的生鸡肉丸"
	meatball_type = /obj/item/food/meatball/chicken/human
	patty_type = /obj/item/food/raw_patty/chicken/human

/obj/item/food/meatball/chicken/human
	name = "奇怪的鸡肉丸"

/obj/item/food/raw_patty/chicken/human
	name = "奇怪的生鸡肉饼"
	patty_type = /obj/item/food/patty/human/chicken

/obj/item/food/patty/human/chicken
	name = "奇怪的鸡肉饼"
	tastes = list("鸡肉味儿" = 1)
	icon_state = "chicken_patty"

/datum/food_processor_process/meat/chicken
	blacklist = list(/obj/item/food/meat/slab/chicken/human)

/datum/food_processor_process/meat/chicken/human
	input = /obj/item/food/meat/slab/chicken/human
	output = /obj/item/food/raw_meatball/chicken/human
	blacklist = null

/obj/item/food/burger/human/chicken
	name = "鸟人三明治"
	desc = "你很确定，买这份三明治绝不算支持什么善举……"
	icon_state = "chickenburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/mayonnaise = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("面包" = 2, "鸡肉味儿" = 4, "违背天理" = 1)
	foodtypes = GRAIN | MEAT | FRIED | GORE
	crafting_complexity = FOOD_COMPLEXITY_3
	venue_value = FOOD_PRICE_CHEAP

/obj/item/food/burger/human/chicken/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	for(var/datum/material/meat/mob_meat/mob_meat_material in custom_materials)
		if(mob_meat_material.subjectname)
			name = "[mob_meat_material.subjectname]汉堡"
		else if(mob_meat_material.subjectjob)
			name = "[chinese_job_display(mob_meat_material.subjectjob)]汉堡"

/datum/crafting_recipe/food/chickenburger/human
	added_foodtypes = FRIED | GORE
	name = "鸟人三明治"
	reqs = list(
			/obj/item/food/patty/human/chicken = 1,
			/datum/reagent/consumable/mayonnaise = 5,
			/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/human/chicken
	dish_category = DISH_BURGER
