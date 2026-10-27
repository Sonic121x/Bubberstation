/datum/design/biogen/frontier_ration/snacks
	name = "边疆零食"
	id = DESIGN_ID_IGNORE
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/storage/box
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_AKHTER_FOODRICATOR_SNACKS,
	)

/datum/design/biogen/frontier_ration/snacks/frontier_ration_gum
	name = "口香糖"
	id = "frontier_ration_gum"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/storage/box/gum

/datum/design/biogen/frontier_ration/snacks/frontier_ration_gum_wakeup
	name = "活力 12 小时药用口香糖"
	id = "frontier_ration_gum_wakeup"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/storage/box/gum/wake_up

/datum/design/biogen/frontier_ration/snacks/frontier_ration_energy_bar
	name = "高功率能量棒"
	id = "frontier_ration_energy_bar"
	build_path = /obj/item/food/energybar

/datum/design/biogen/frontier_ration/snacks/frontier_ration_ciggies
	name = "香烟"
	id = "frontier_ration_ciggies"
	build_path = /obj/item/storage/fancy/cigarettes/cigpack_uplift

/datum/design/biogen/frontier_ration/snacks/frontier_ration_engine_fodder
	name = "轮机口粮"
	id = "frontier_ration_engine_fodder"
	build_path = /obj/item/food/vendor_snacks/moth_bag

/datum/design/biogen/frontier_ration/snacks/frontier_ration_fueljak_snack
	name = "燃料工的零食"
	id = "frontier_ration_fueljak_snack"
	build_path = /obj/item/food/vendor_snacks/moth_bag/fuel_jack

/datum/design/biogen/frontier_ration/snacks/frontier_ration_ricecracker
	name = "米饼"
	id = "frontier_ration_ricecracker"
	build_path = /obj/item/food/vendor_snacks/rice_crackers
