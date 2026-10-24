/datum/crafting_recipe/blackcarpet
	name = "黑色地毯"
	reqs = list(
		/obj/item/stack/tile/carpet = 50,
		/obj/item/toy/crayon/black = 1,
	)
	result = /obj/item/stack/tile/carpet/black
	result_amount = 50
	category = CAT_TILES

/datum/crafting_recipe/wired_glass
	name = "布线玻璃地砖"
	result = /obj/item/stack/tile/light
	reqs = list(
		/obj/item/stack/sheet/iron = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/cable_coil = 5,
	)
	category = CAT_TILES

/datum/crafting_recipe/circuit
	name = "电路地砖"
	result = /obj/item/stack/tile/circuit
	reqs = list(
		/obj/item/stack/sheet/iron = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/cable_coil = 5,
	)
	category = CAT_TILES
