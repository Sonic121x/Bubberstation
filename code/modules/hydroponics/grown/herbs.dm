// Herbs
/obj/item/seeds/herbs
	name = "草本种子包"
	desc = "这些种子会长出各式各样的香草和调味料。"
	icon_state = "seed-herbs"
	species = "herbs"
	plantname = "香草"
	product = /obj/item/food/grown/herbs
	growthstages = 2
	yield = 5
	potency = 20
	growing_icon = 'icons/obj/service/hydroponics/growing.dmi'
	icon_grow = "herbs-grow"
	icon_dead = "herbs-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/herbs
	seed = /obj/item/seeds/herbs
	name = "一捆香草"
	desc = "一捆各式香草。不知为何，你总能从中挑出自己需要的那种。"
	icon_state = "herbs"
	foodtypes = VEGETABLES
	tastes = list("难以名状的香草" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/fernet

/obj/item/food/grown/herbs/grind_results()
	return list(/datum/reagent/consumable/nutriment = 0)

/obj/item/food/grown/herbs/juice_typepath()
	return /datum/reagent/consumable/nutriment
