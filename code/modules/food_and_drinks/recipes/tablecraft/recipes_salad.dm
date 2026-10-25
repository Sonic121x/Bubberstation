
// see code/module/crafting/table.dm

////////////////////////////////////////////////SALADS////////////////////////////////////////////////

/datum/crafting_recipe/food/herbsalad
	name = "香草沙拉"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/ambrosia/vulgaris = 3,
		/obj/item/food/grown/apple = 1
	)
	result = /obj/item/food/salad/herbsalad
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/aesirsalad
	name = "阿萨神族沙拉"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/ambrosia/deus = 3,
		/obj/item/food/grown/apple/gold = 1
	)
	result = /obj/item/food/salad/aesirsalad
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/validsalad
	name = "有效沙拉"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/ambrosia/vulgaris = 3,
		/obj/item/food/grown/potato = 1,
		/obj/item/food/meatball = 1
	)
	result = /obj/item/food/salad/validsalad
	added_foodtypes = FRIED
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/melonfruitbowl
	name ="甜瓜水果碗"
	reqs = list(
		/obj/item/food/grown/melonlike/watermelon = 1,
		/obj/item/food/grown/apple = 1,
		/obj/item/food/grown/citrus/orange = 1,
		/obj/item/food/grown/citrus/lemon = 1,
		/obj/item/food/grown/banana = 1,
		/obj/item/food/grown/ambrosia = 1
	)
	result = /obj/item/food/melonfruitbowl
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/fruitsalad
	name = "水果沙拉"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/apple = 1,
		/obj/item/food/grown/grapes = 1,
		/obj/item/food/grown/citrus/orange = 1,
		/obj/item/food/watermelonslice = 2

	)
	result = /obj/item/food/salad/fruit
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/junglesalad
	name = "丛林沙拉"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/apple = 2,
		/obj/item/food/grown/grapes = 2,
		/obj/item/food/grown/banana = 2,

	)
	result = /obj/item/food/salad/jungle
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/citrusdelight
	name = "柑橘之悦"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/citrus/lime = 1,
		/obj/item/food/grown/citrus/lemon = 1,
		/obj/item/food/grown/citrus/orange = 1

	)
	result = /obj/item/food/salad/citrusdelight
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/edensalad
	name = "伊甸沙拉"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/ambrosia/vulgaris = 1,
		/obj/item/food/grown/ambrosia/deus = 1,
		/obj/item/food/grown/ambrosia/gaia = 1,
		/obj/item/food/grown/peace = 1
	)
	result = /obj/item/food/salad/edensalad
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/kale_salad
	name = "羽衣甘蓝沙拉"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/carrotlike/carrot = 1,
		/obj/item/food/onion_slice/red = 2,
		/obj/item/food/grown/cabbage = 1,
		/datum/reagent/consumable/nutriment/fat/oil/olive = 2,
	)
	result = /obj/item/food/salad/kale_salad
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/greek_salad
	name = "希腊沙拉"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/olive = 1,
		/obj/item/food/grown/tomato = 1,
		/obj/item/food/onion_slice/red = 2,
		/obj/item/food/cheese/wedge = 1,
		/datum/reagent/consumable/nutriment/fat/oil/olive = 5,
		/obj/item/food/grown/cucumber = 1,
	)
	result = /obj/item/food/salad/greek_salad
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/caesar_salad
	name = "凯撒沙拉"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/cabbage = 2,
		/obj/item/food/onion_slice/red = 1,
		/obj/item/food/cheese/wedge = 1,
		/datum/reagent/consumable/nutriment/fat/oil/olive = 5,
		/obj/item/food/breadslice/plain = 1,
	)
	result = /obj/item/food/salad/caesar_salad
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/spring_salad
	name = "春季沙拉"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/cabbage = 2,
		/obj/item/food/grown/carrotlike/carrot = 1,
		/obj/item/food/grown/peas = 1,
		/datum/reagent/consumable/nutriment/fat/oil/olive = 5,
	)
	result = /obj/item/food/salad/spring_salad
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/potato_salad
	name = "土豆沙拉"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/potato = 2,
		/obj/item/food/boiledegg = 2,
		/obj/item/food/grown/onion = 1,
		/datum/reagent/consumable/mayonnaise = 5,
	)
	result = /obj/item/food/salad/potato_salad
	dish_category = DISH_SALAD
	removed_foodtypes = BREAKFAST

/datum/crafting_recipe/food/spinach_fruit_salad
	name = "菠菜水果沙拉"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/herbs = 3,
		/obj/item/food/grown/berries = 2,
		/obj/item/food/pineappleslice = 2,
		/datum/reagent/consumable/nutriment/fat/oil/olive = 2,
	)
	result = /obj/item/food/salad/spinach_fruit_salad
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/antipasto_salad
	name = "意式前菜沙拉"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/cabbage = 2,
		/obj/item/food/grown/olive = 1,
		/obj/item/food/grown/tomato = 1,
		/obj/item/food/meat/cutlet = 1,
		/obj/item/food/cheese/mozzarella = 1,
	)
	result = /obj/item/food/salad/antipasto_salad
	dish_category = DISH_SALAD
	cuisine_category = CUISINE_ITALIAN
