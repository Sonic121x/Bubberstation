/datum/design/biogen/frontier_ration/ingredients
	name = "边疆口粮食材"
	id = DESIGN_ID_IGNORE
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_AKHTER_FOODRICATOR_INGREDIENTS,
	)

/datum/design/biogen/frontier_ration/ingredients/frontier_ration_egg
	name = "鸡蛋"
	id = "frontier_ration_egg"
	build_path = /obj/item/food/egg

/datum/design/biogen/frontier_ration/ingredients/frontier_ration_chicken
	name = "鸡肉"
	id = "frontier_ration_chicken"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/meat/slab/chicken

/datum/design/biogen/frontier_ration/ingredients/frontier_ration_mystery_meat
	name = "肉制品"
	id = "frontier_ration_mystery_meat"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/meat/slab/meatproduct

/datum/design/biogen/frontier_ration/ingredients/frontier_ration_butter
	name = "黄油"
	id = "frontier_ration_butter"
	build_path = /obj/item/food/butter

/datum/design/biogen/frontier_ration/ingredients/frontier_ration_cheese
	name = "奶酪"
	id = "frontier_ration_cheese"
	build_path = /obj/item/food/cheese/wedge

/datum/design/biogen/frontier_ration/ingredients/frontier_ration_cheese_firm
	name = "硬质奶酪"
	id = "frontier_ration_firm_cheese"
	build_path = /obj/item/food/cheese/firm_cheese_slice
