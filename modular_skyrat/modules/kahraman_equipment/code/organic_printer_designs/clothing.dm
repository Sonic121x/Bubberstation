/datum/design/biogen/frontier_clothing
	abstract_type = /datum/design/biogen/frontier_clothing
	materials = list(/datum/material/biomass = 100)

	build_path = /obj/item/clothing/under/frontier_colonist
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_AKHTER_CLOTHING,
	)

// Jumpsuit

/datum/design/biogen/frontier_clothing/frontier_jumpsuit
	name = "边疆连体服"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/clothing/under/frontier_colonist

// Boots

/datum/design/biogen/frontier_clothing/frontier_boots
	name = "重型边疆长靴"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/clothing/shoes/jackboots/frontier_colonist

// Gloves

/datum/design/biogen/frontier_clothing/frontier_gloves
	name = "边疆手套"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/clothing/gloves/frontier_colonist

// Suit items

/datum/design/biogen/frontier_clothing/frontier_trench
	name = "边疆风衣"
	build_path = /obj/item/clothing/suit/jacket/frontier_colonist

/datum/design/biogen/frontier_clothing/frontier_jacket
	name = "边疆夹克"
	build_path = /obj/item/clothing/suit/jacket/frontier_colonist/short

/datum/design/biogen/frontier_clothing/frontier_med_jacket
	name = "边疆医疗夹克"
	materials = list(/datum/material/biomass = 125)
	build_path = /obj/item/clothing/suit/jacket/frontier_colonist/medical

/datum/design/biogen/frontier_clothing/frontier_flak
	name = "边疆防破片夹克"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/clothing/suit/frontier_colonist_flak

/datum/design/biogen/frontier_clothing/frontier_tanker_helmet
	name = "边疆软盔"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/clothing/head/frontier_colonist_helmet

// Hats

/datum/design/biogen/frontier_clothing/frontier_cap
	name = "边疆软帽"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/clothing/head/soft/frontier_colonist

/datum/design/biogen/frontier_clothing/frontier_cap_med
	name = "边疆医疗帽"
	build_path = /obj/item/clothing/head/soft/frontier_colonist/medic

// That one gas mask

/datum/design/biogen/frontier_clothing/frontier_mask
	name = "边疆防毒面具"
	build_path = /obj/item/clothing/mask/gas/atmos/frontier_colonist
