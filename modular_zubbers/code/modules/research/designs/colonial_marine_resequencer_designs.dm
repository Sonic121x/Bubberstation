// Designs for the Colonial Marine Resequencer
// Completely removes the provision and medicine categories, as this version is focused on materials and clothing.

//// Apparel ////

// Jumpsuits

/datum/design/biogen/cmf_colonial_under
	name = "殖民地制服"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/clothing/under/colonial
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_frontier_jumpsuit
	name = "边疆连体服"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/clothing/under/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

// Boots

/datum/design/biogen/cmf_frontier_boots
	name = "重型边疆长靴"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/clothing/shoes/jackboots/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_colonial_boots
	name = "殖民地半靴"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/clothing/shoes/jackboots/colonial
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

// Gloves

/datum/design/biogen/cmf_frontier_gloves
	name = "边疆手套"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/clothing/gloves/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_cool_gloves
	name = "黑色手套"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/clothing/gloves/color/black
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

// Suit items

/datum/design/biogen/cmf_colonial_cloak
	name = "殖民地斗篷"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/clothing/neck/cloak/colonial
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_frontier_trench
	name = "边疆风衣"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/clothing/suit/jacket/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_frontier_jacket
	name = "边疆夹克"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/clothing/suit/jacket/frontier_colonist/short
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_frontier_med_jacket
	name = "边疆医疗夹克"
	materials = list(/datum/material/biomass = 175)
	build_path = /obj/item/clothing/suit/jacket/frontier_colonist/medical
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_frontier_flak
	name = "边疆防破片夹克"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/clothing/suit/frontier_colonist_flak
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_frontier_tanker_helmet
	name = "边疆软盔"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/clothing/head/frontier_colonist_helmet
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

// Hats

/datum/design/biogen/cmf_frontier_cap
	name = "边疆帽"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/clothing/head/soft/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_frontier_cap_med
	name = "边疆医疗帽"
	materials = list(/datum/material/biomass = 125)
	build_path = /obj/item/clothing/head/soft/frontier_colonist/medic
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

/datum/design/biogen/cmf_cool_hat
	name = "殖民地帽"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/clothing/head/hats/colonial
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

// The gas mask

/datum/design/biogen/cmf_frontier_mask
	name = "边疆防毒面具"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/clothing/mask/gas/atmos/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_APPAREL)

//// Equipment ////

// Belts

/datum/design/biogen/cmf_frontier_chest_rig
	name = "边疆胸挂"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/storage/belt/utility/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_frontier_med_belt
	name = "挎包式医疗包"
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/storage/backpack/duffelbag/deforest_medkit
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_frontier_medtech_belt
	name = "医疗技术员医疗包"
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/storage/backpack/duffelbag/deforest_paramedic
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_frontier_medkit
	name = "边疆医疗包"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/storage/medkit/frontier
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

// Backpacks

/datum/design/biogen/cmf_frontier_backpack
	name = "边疆背包"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/storage/backpack/industrial/frontier_colonist
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_frontier_satchel
	name = "边疆挎包"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/storage/backpack/industrial/frontier_colonist/satchel
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_frontier_messenger
	name = "边疆邮差包"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/storage/backpack/industrial/frontier_colonist/messenger
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

// Small Containers

/datum/design/biogen/cmf_colonial_webbing
	name = "轻薄殖民地织带背心"
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/clothing/accessory/colonial_webbing
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_genpouch
	name = "空的殖民地通用小袋"
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/pouch/cin_general
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_pocket_medkit
	name = "空的殖民地急救包"
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/pouch/cin_medkit
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_medipouch
	name = "空的殖民地注射笔小袋"
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/pouch/cin_medipens
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

/datum/design/biogen/cmf_cup
	name = "空的殖民地保温杯"
	materials = list(/datum/material/biomass = 10)
	build_path = /obj/item/reagent_containers/cup/glass/coffee/colonial/empty
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_EQUIPMENT)

//// Materials ////

/datum/design/biogen/cmf_plastic
	name = "塑料板"
	materials = list(/datum/material/biomass = 30)
	build_path = /obj/item/stack/sheet/plastic
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_MATERIALS)

/datum/design/biogen/cmf_leather
	name = "皮革"
	materials = list(/datum/material/biomass = 40)
	build_path = /obj/item/stack/sheet/leather
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_MATERIALS)

/datum/design/biogen/cmf_cloth
	name = "布料"
	materials = list(/datum/material/biomass = 15)
	build_path = /obj/item/stack/sheet/cloth
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_MATERIALS)

/datum/design/biogen/cmf_cardboard
	name = "纸板"
	materials = list(/datum/material/biomass = 7.5)
	build_path = /obj/item/stack/sheet/cardboard
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_MATERIALS)

/datum/design/biogen/cmf_paper
	name = "纸张"
	materials = list(/datum/material/biomass = 2.5)
	build_path = /obj/item/paper
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_MATERIALS)

/datum/design/biogen/cmf_rolling_paper
	name = "卷烟纸"
	materials = list(/datum/material/biomass = 1.25)
	build_path = /obj/item/rollingpaper
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_MATERIALS)

/datum/design/biogen/cmf_candle
	name = "蜡烛"
	materials = list(/datum/material/biomass = 4)
	build_path = /obj/item/flashlight/flare/candle
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_CMR_MATERIALS)
