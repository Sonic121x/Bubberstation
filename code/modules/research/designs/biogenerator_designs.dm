///////////////////////////////////
///////Biogenerator Designs ///////
///////////////////////////////////

/datum/design/biogen
	build_type = BIOGENERATOR
	// biomass doesn't have a sheet type, and the biogenerator isn't meant to churn out unprocessed biomass anyway.
	inherit_materials = DESIGN_DONT_INHERIT_MATS

/datum/design/biogen/milk
	name = "合成牛奶"
	id = "milk"
	materials = list(/datum/material/biomass = 0.4)
	make_reagent = /datum/reagent/consumable/milk
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/soymilk
	name = "合成豆奶"
	id = "soymilk"
	materials = list(/datum/material/biomass = 0.4)
	make_reagent = /datum/reagent/consumable/soymilk
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/ethanol
	name = "合成乙醇"
	id = "ethanol"
	materials = list(/datum/material/biomass = 0.6)
	make_reagent = /datum/reagent/consumable/ethanol
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/cream
	name = "合成奶油"
	id = "cream"
	materials = list(/datum/material/biomass = 0.6)
	make_reagent = /datum/reagent/consumable/cream
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/black_pepper
	name = "合成黑胡椒"
	id = "black_pepper"
	materials = list(/datum/material/biomass = 0.6)
	make_reagent = /datum/reagent/consumable/blackpepper
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/enzyme
	name = "合成通用酶"
	id = "enzyme"
	materials = list(/datum/material/biomass = 0.6)
	make_reagent = /datum/reagent/consumable/enzyme
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/flour
	name = "合成面粉"
	id = "flour_sack"
	materials = list(/datum/material/biomass = 0.6)
	make_reagent = /datum/reagent/consumable/flour
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/sugar
	name = "合成糖"
	id = "sugar"
	materials = list(/datum/material/biomass = 0.6)
	make_reagent = /datum/reagent/consumable/sugar
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/monkey_cube
	name = "猴子方块"
	id = "mcube"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/monkeycube
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/seaweed_sheet
	name = "海苔片"
	id = "seaweedsheet"
	materials = list(/datum/material/biomass = 3)
	build_path = /obj/item/food/seaweedsheet
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

/datum/design/biogen/ez_nut   //easy nut :)
	name = "易滋营养剂"
	id = "ez_nut"
	materials = list(/datum/material/biomass = 0.1)
	make_reagent = /datum/reagent/plantnutriment/eznutriment
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_CHEMICALS)

/datum/design/biogen/l4z_nut
	name = "求生之路 4"
	id = "l4z_nut"
	materials = list(/datum/material/biomass = 0.1)
	make_reagent = /datum/reagent/plantnutriment/left4zednutriment
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_CHEMICALS)

/datum/design/biogen/rh_nut
	name = "强劲丰收"
	id = "rh_nut"
	materials = list(/datum/material/biomass = 0.2)
	make_reagent = /datum/reagent/plantnutriment/robustharvestnutriment
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_CHEMICALS)

/datum/design/biogen/end_gro
	name = "耐性生长剂"
	id = "end_gro"
	materials = list(/datum/material/biomass = 0.3)
	make_reagent = /datum/reagent/plantnutriment/endurogrow
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_CHEMICALS)

/datum/design/biogen/liq_earth
	name = "液态地震"
	id = "liq_earth"
	materials = list(/datum/material/biomass = 0.3)
	make_reagent = /datum/reagent/plantnutriment/liquidearthquake
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_CHEMICALS)

/datum/design/biogen/weed_killer
	name = "除草剂"
	id = "weed_killer"
	materials = list(/datum/material/biomass = 0.2)
	make_reagent = /datum/reagent/toxin/plantbgone/weedkiller
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_CHEMICALS)

/datum/design/biogen/pest_spray
	name = "杀虫剂"
	id = "pest_spray"
	materials = list(/datum/material/biomass = 0.4)
	make_reagent = /datum/reagent/toxin/pestkiller
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_CHEMICALS)

/datum/design/biogen/org_pest_spray
	name = "天然杀虫剂"
	id = "org_pest_spray"
	materials = list(/datum/material/biomass = 0.6)
	make_reagent = /datum/reagent/toxin/pestkiller/organic
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_CHEMICALS)

/datum/design/biogen/leather
	name = "皮革"
	id = "leather"
	materials = list(/datum/material/biomass = 30)
	build_path = /obj/item/stack/sheet/leather
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_MATERIALS)

/datum/design/biogen/cloth
	name = "布料"
	id = "cloth"
	materials = list(/datum/material/biomass = 10)
	build_path = /obj/item/stack/sheet/cloth
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_MATERIALS)

/datum/design/biogen/cardboard
	name = "纸板"
	id = "cardboard"
	materials = list(/datum/material/biomass = 5)
	build_path = /obj/item/stack/sheet/cardboard
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_MATERIALS)

/datum/design/biogen/paper
	name = "纸张"
	id = "paper"
	materials = list(/datum/material/biomass = 2)
	build_path = /obj/item/paper
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_MATERIALS)

/datum/design/biogen/rolling_paper
	name = "卷烟纸"
	id = "rollingpaper"
	materials = list(/datum/material/biomass = 1)
	build_path = /obj/item/rollingpaper
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_MATERIALS)

/datum/design/biogen/candle
	name = "红蜡烛"
	id = "candle"
	materials = list(/datum/material/biomass = 3)
	build_path = /obj/item/flashlight/flare/candle
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_MATERIALS)
