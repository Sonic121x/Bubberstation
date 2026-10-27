/obj/item/food/canned/tuna
	name = "金枪鱼罐头"
	desc = "你可以给钢琴调音，却没法给金枪鱼“调音”。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "tunacan"
	trash_type = /obj/item/trash/can/food/tuna
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/nutriment/vitamin = 6
	)
	tastes = list("金枪鱼" = 1)
	foodtypes = SEAFOOD

/obj/item/trash/can/food/tuna
	name = "金枪鱼罐头"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "tunacan_empty"

/obj/item/food/fishmeat/moonfish/akula
	name = "水生鱼排"
	desc = "一整条相当大的鱼的鱼排……"
	tastes = list("鲜嫩鱼肉" = 1)
	foodtypes = SEAFOOD | GORE
	venue_value = FOOD_MEAT_HUMAN
