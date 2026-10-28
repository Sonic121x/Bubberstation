/obj/item/reagent_containers/cup/bottle/large
	name = "大号瓶子"
	desc = "一个大号瓶子。"
	icon = 'modular_zubbers/icons/obj/medical/chemical.dmi'
	icon_state = "bottle_large"
	fill_icon = 'modular_zubbers/icons/obj/medical/reagent_fillings.dmi'
	fill_icon_state = "bottle_large"
	possible_transfer_amounts = list(5, 10, 15, 25, 50, 100)
	volume = 100

/obj/item/reagent_containers/cup/bottle/large/Initialize(mapload)
	. = ..()
	if(!icon_state)
		icon_state = "bottle_large"
	update_appearance()

/obj/item/reagent_containers/cup/bottle/medi

/obj/item/reagent_containers/cup/bottle/plushmium
	name = "毛绒素瓶"
	desc = "一小瓶毛绒素。"
	icon = 'icons/obj/medical/chemical.dmi'
	list_reagents = list(/datum/reagent/plushmium = 30)
