/obj/item/stack/ammonia_crystals
	name = "氨结晶"
	desc = "结晶状的氨。对某些人来说很有价值，但那个人多半不是你。"
	singular_name = "氨结晶"
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "ammonia_crystal"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	max_amount = 50
	merge_type = /obj/item/stack/ammonia_crystals

/obj/item/stack/ammonia_crystals/grind_results()
	return list(/datum/reagent/ammonia = 10)
