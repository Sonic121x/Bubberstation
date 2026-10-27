/datum/design/biogen/frontier_equipment
	name = "边疆装备"
	id = DESIGN_ID_IGNORE
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/storage
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_AKHTER_EQUIPMENT,
	)

// Belts

/datum/design/biogen/frontier_equipment/frontier_chest_rig
	name = "边疆胸挂"
	id = "frontier_chest_rig"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/storage/belt/utility/frontier_colonist

/datum/design/biogen/frontier_equipment/frontier_med_belt
	name = "挎包式医疗包"
	id = "frontier_med_belt"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/storage/backpack/duffelbag/deforest_medkit

/datum/design/biogen/frontier_equipment/frontier_medtech_belt
	name = "医疗技师套装"
	id = "frontier_medtech_belt"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/storage/backpack/duffelbag/deforest_paramedic

/datum/design/biogen/frontier_equipment/frontier_medkit
	name = "边疆医疗包"
	id = "frontier_medkit"
	build_path = /obj/item/storage/medkit/frontier

// Backpacks

/datum/design/biogen/frontier_equipment/frontier_backpack
	name = "边疆背包"
	id = "frontier_backpack"
	build_path = /obj/item/storage/backpack/industrial/frontier_colonist

/datum/design/biogen/frontier_equipment/frontier_satchel
	name = "边疆挎包"
	id = "frontier_satchel"
	build_path = /obj/item/storage/backpack/industrial/frontier_colonist/satchel

/datum/design/biogen/frontier_equipment/frontier_messenger
	name = "边疆邮差包"
	id = "frontier_messenger"
	build_path = /obj/item/storage/backpack/industrial/frontier_colonist/messenger
