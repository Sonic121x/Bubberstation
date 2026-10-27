/obj/item/reagent_containers/cup/glass/drinkingglass/shotglass/syndicate
	name = "烈酒杯"
	desc = "一只烈酒杯——糟糕决定的通用象征。"
	icon_state = "shotglass"
	base_icon_state = "shotglass"
	gulp_size = 50
	amount_per_transfer_from_this = 50
	possible_transfer_amounts = list(50)
	volume = 50
	initial_reagent_flags = REFILLABLE | DRAINABLE

/obj/item/storage/box/syndieshotglasses
	name = "烈酒杯盒"
	desc = "上面印着烈酒杯的图案。"
	illustration = "drinkglass"

/obj/item/storage/box/syndieshotglasses/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/cup/glass/drinkingglass/shotglass/syndicate(src)
