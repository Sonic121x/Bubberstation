/datum/design/biogen/frontier_utensils
	name = "边疆餐具"
	id = DESIGN_ID_IGNORE
	materials = list(/datum/material/biomass = 10)
	build_path = /obj/item/kitchen
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_AKHTER_FOODRICATOR_UTENSILS,
	)

/datum/design/biogen/frontier_utensils/frontier_ration_plastic_fork
	name = "塑料叉"
	id = "frontier_ration_plastic_fork"
	build_path = /obj/item/kitchen/fork/plastic

/datum/design/biogen/frontier_utensils/frontier_ration_plastic_spoon
	name = "塑料勺"
	id = "frontier_ration_plastic_spoon"
	build_path = /obj/item/kitchen/spoon/plastic

/datum/design/biogen/frontier_utensils/frontier_ration_plastic_knife
	name = "塑料刀"
	id = "frontier_ration_plastic_knife"
	build_path = /obj/item/knife/plastic

/datum/design/biogen/frontier_utensils/frontier_ration_plastic_cup
	name = "塑料杯"
	id = "frontier_ration_plastic_cup"
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/reagent_containers/cup/glass/coffee_cup
