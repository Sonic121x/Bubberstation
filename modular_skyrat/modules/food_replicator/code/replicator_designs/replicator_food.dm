/datum/design/biogen/food_replicator
	abstract_type = /datum/design/biogen/food_replicator
	materials = list(/datum/material/biomass = 100)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_NRI_FOOD,
	)

/datum/design/biogen/food_replicator/ration
	name = "外国殖民口粮"
	materials = list(/datum/material/biomass = 550)
	build_path = /obj/item/storage/box/colonial_rations

/datum/design/biogen/food_replicator/pljeskavica
	name = "外国殖民口粮，主菜"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/food/colonial_course/pljeskavica

/datum/design/biogen/food_replicator/nachos
	name = "外国殖民口粮，配菜"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/food/colonial_course/nachos

/datum/design/biogen/food_replicator/blins
	name = "外国殖民口粮，甜点"
	build_path = /obj/item/food/colonial_course/blins

///Despite being in the medical.dm file, it's still used to fill your hunger up, as such, technically, is food.
/datum/design/biogen/food_replicator/glucose
	name = "葡萄糖注射笔"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/reagent_containers/hypospray/medipen/glucose

/datum/design/biogen/food_replicator/spork
	name = "外国殖民口粮，餐具"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/storage/box/utensils

/datum/design/biogen/food_replicator/bubblegum
	name = "外国殖民口粮，口香糖包"
	build_path = /obj/item/storage/box/gum/colonial

/datum/design/biogen/food_replicator/cup
	name = "空纸杯"
	materials = list(/datum/material/biomass = 10)
	build_path = /obj/item/reagent_containers/cup/glass/coffee/colonial/empty

/datum/design/biogen/food_replicator/tea
	name = "红茶叶粉"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_tea

/datum/design/biogen/food_replicator/coffee
	name = "咖啡粉"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_coffee

/datum/design/biogen/food_replicator/cocoa
	name = "热巧克力粉"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/coco

/datum/design/biogen/food_replicator/lemonade
	name = "柠檬水粉"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_lemonade

/datum/design/biogen/food_replicator/replicator_sugar
	name = "糖"
	materials = list(/datum/material/biomass = 5)
	make_reagent = /datum/reagent/consumable/sugar

/datum/design/biogen/food_replicator/powdered_milk
	name = "奶粉"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_milk

/datum/design/biogen/food_replicator/water
	name = "水"
	materials = list(/datum/material/biomass = 1)
	make_reagent = /datum/reagent/water
