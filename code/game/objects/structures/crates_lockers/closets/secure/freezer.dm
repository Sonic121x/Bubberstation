/obj/structure/closet/secure_closet/freezer
	icon_state = "freezer"
	base_icon_state = "freezer"
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1
	door_anim_squish = 0.22
	door_anim_angle = 123
	door_anim_time = 4
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5.3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3.5)
	/// If FALSE, we will protect the first person in the freezer from an explosion / nuclear blast.
	var/jones = FALSE
	paint_jobs = null
	sealed = TRUE

	/// The rate at which the internal air mixture cools
	var/cooling_rate_per_second = 4
	/// Minimum temperature of the internal air mixture
	var/minimum_temperature = T0C - 60

/obj/structure/closet/secure_closet/freezer/process_internal_air(seconds_per_tick)
	if(opened)
		var/datum/gas_mixture/current_exposed_air = loc.return_air()
		if(!current_exposed_air)
			return
		// The internal air won't cool down the external air when the freezer is opened.
		internal_air.temperature = max(current_exposed_air.temperature, internal_air.temperature)
		return ..()
	else
		if(internal_air.temperature <= minimum_temperature)
			return
		var/temperature_decrease_this_tick = min(cooling_rate_per_second * seconds_per_tick, internal_air.temperature - minimum_temperature)
		internal_air.temperature -= temperature_decrease_this_tick

/obj/structure/closet/secure_closet/freezer/ex_act()
	if(jones)
		return ..()
	jones = TRUE
	flags_1 &= ~PREVENT_CONTENTS_EXPLOSION_1
	return FALSE

/obj/structure/closet/secure_closet/freezer/atom_deconstruct(disassembled)
	new /obj/item/assembly/igniter/condenser(drop_location())

/obj/structure/closet/secure_closet/freezer/empty
	name = "冷冻柜"

/obj/structure/closet/secure_closet/freezer/empty/open
	req_access = null
	locked = FALSE

/obj/structure/closet/secure_closet/freezer/kitchen
	name = "厨柜"
	req_access = list(ACCESS_KITCHEN)

/obj/structure/closet/secure_closet/freezer/kitchen/PopulateContents()
	..()
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/condiment/flour(src)
	new /obj/item/reagent_containers/condiment/rice(src)
	new /obj/item/reagent_containers/condiment/sugar(src)
	new /obj/effect/spawner/holiday/powdered_ingredient(src)

/obj/structure/closet/secure_closet/freezer/kitchen/all_access
	req_access = null

/obj/structure/closet/secure_closet/freezer/kitchen/maintenance
	name = "维护区冰箱"
	desc = "这台冰箱积满了灰尘，里面还有能吃的东西吗？"
	req_access = null

/obj/structure/closet/secure_closet/freezer/kitchen/maintenance/PopulateContents()
	..()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/condiment/milk(src)
		new /obj/item/reagent_containers/condiment/soymilk(src)
	for(var/i in 1 to 2)
		new /obj/item/storage/fancy/egg_box(src)
	new /obj/effect/spawner/holiday/liquid_ingredient(src)

/obj/structure/closet/secure_closet/freezer/kitchen/mining
	req_access = null

/obj/structure/closet/secure_closet/freezer/meat
	name = "肉类冰箱"
	req_access = list(ACCESS_KITCHEN)

/obj/structure/closet/secure_closet/freezer/meat/update_name()
	name = check_holidays(VEGAN_DAY) ? "纯素食冰箱" : "肉类冰箱"
	return ..()

/obj/structure/closet/secure_closet/freezer/meat/PopulateContents()
	..()
	if(!check_holidays(VEGAN_DAY))
		for(var/i in 1 to 4)
			new /obj/item/food/meat/slab/monkey(src)
	new /obj/effect/spawner/holiday/meat_ingredient(src) //this contains holiday specials (and vegan day stuff)

/obj/structure/closet/secure_closet/freezer/meat/open
	locked = FALSE
	req_access = null

/obj/structure/closet/secure_closet/freezer/meat/all_access
	req_access = null

/obj/structure/closet/secure_closet/freezer/gulag_fridge
	name = "冰箱"

/obj/structure/closet/secure_closet/freezer/gulag_fridge/PopulateContents()
	..()
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/cup/glass/bottle/beer/light(src)

/obj/structure/closet/secure_closet/freezer/fridge
	name = "冰箱"
	req_access = list(ACCESS_KITCHEN)

/obj/structure/closet/secure_closet/freezer/fridge/PopulateContents()
	..()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/condiment/milk(src)
		new /obj/item/reagent_containers/condiment/soymilk(src)
	for(var/i in 1 to 2)
		new /obj/item/storage/fancy/egg_box(src)
	new /obj/effect/spawner/holiday/liquid_ingredient(src)

/obj/structure/closet/secure_closet/freezer/fridge/all_access
	req_access = null

/obj/structure/closet/secure_closet/freezer/fridge/open
	req_access = null
	locked = FALSE

/obj/structure/closet/secure_closet/freezer/fridge/preopen
	req_access = null
	locked = FALSE
	opened = TRUE

/obj/structure/closet/secure_closet/freezer/money
	name = "冷冻柜"
	desc = "里面放着冰冷的硬通货。"
	req_access = list(ACCESS_VAULT)

/obj/structure/closet/secure_closet/freezer/money/PopulateContents()
	..()
	for(var/i in 1 to 3)
		new /obj/item/stack/spacecash/c1000(src)
	for(var/i in 1 to 5)
		new /obj/item/stack/spacecash/c500(src)
	for(var/i in 1 to 6)
		new /obj/item/stack/spacecash/c200(src)

/obj/structure/closet/secure_closet/freezer/cream_pie
	name = "奶油派柜"
	desc = "里面是装满奶油和蛋奶馅的派，别想歪了。"
	req_access = list(ACCESS_THEATRE)

/obj/structure/closet/secure_closet/freezer/cream_pie/PopulateContents()
	..()
	new /obj/item/food/pie/cream(src)
