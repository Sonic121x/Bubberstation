/obj/item/reagent_containers/cooler_jug
	name = "饮水机水桶"
	desc = "一个又大又笨重的水桶。它是液体冷却器的生命之源。闻起来像刚冷却的塑料。"
	icon = 'icons/obj/medical/chemical_tanks.dmi'
	icon_state = "cooler_jug"
	volume = 200
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 4)
	initial_reagent_flags = REFILLABLE | DRAINABLE | INJECTABLE | DRAWABLE | TRANSPARENT | NO_SPLASH
	spillable = TRUE
	has_variable_transfer_amount = FALSE
	interaction_flags_click = NEED_DEXTERITY
	fill_icon_state = "cooler_jug_overlay"
	fill_icon_thresholds = list(25, 50, 75, 100)
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_BULKY

/obj/item/reagent_containers/cooler_jug/water
	name = "水桶"
	desc = "一个外形优雅的饮水机水桶。在某个地方，有一台饮水机正等着与它重逢。桶口散发着令人陶醉的陈旧金属味。"
	list_reagents = list(/datum/reagent/water = 200)

/obj/item/reagent_containers/cooler_jug/punch
	name = "果汁桶"
	desc = "一个用来装水果潘趣酒的桶。上面贴满了数十张警告标签和你认不出的吓人符号。桶口还残留着甜腻的潘趣酒气味。"
	list_reagents = list(/datum/reagent/consumable/fruit_punch = 200)
