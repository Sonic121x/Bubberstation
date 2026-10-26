/obj/item/seeds/poppy/opiumpoppy
	name = "鸦片罂粟种子包"
	desc = "这些种子能长成真正的鸦片罂粟。"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	icon_state = "seed-opiumpoppy"
	species = "opiumpoppy"
	icon_grow = "opiumpoppy-grow"
	icon_dead = "opiumpoppy-dead"
	plantname = "鸦片罂粟"
	product = /obj/item/food/grown/flower/poppy/opiumpoppy
	reagents_add = list(/datum/reagent/drug/opium = 0.3, /datum/reagent/toxin/fentanyl = 0.075, /datum/reagent/consumable/nutriment = 0.05)
	slot_flags = null

/obj/item/food/grown/flower/poppy/opiumpoppy
	seed = /obj/item/seeds/poppy/opiumpoppy
	name = "鸦片罂粟蒴果"
	desc = "鸦片罂粟的蒴果，含有鸦片乳汁。"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "opiumpoppy"
	worn_icon_state = "map_flower"
	greyscale_config = null
	greyscale_config_worn = /datum/greyscale_config/flower_simple_worn
	greyscale_colors = "#01690f"
	distill_reagent = /datum/reagent/consumable/ethanol/turbo //How can a slow drug make fast drink? Don't question it.
