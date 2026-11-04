/*
/obj/item/circuitboard/machine/vendor/Initialize()
	vending_names_paths[/obj/machinery/vending/wardrobe/sec_wardrobe/red] = "RedSecDrobe"
	vending_names_paths[/obj/machinery/vending/wardrobe/sec_wardrobe] = "SecDrobe"
	vending_names_paths[/obj/machinery/vending/security] = "SecTech"
	. = ..()

/obj/machinery/vending/custom/Initialize()
	. = ..()
	max_loaded_items = 80

/obj/machinery/vending/wardrobe/sec_wardrobe/peacekeeper
	skyrat_contraband = list(/obj/item/clothing/head/helmet/stormtrooper = 2,
					/obj/item/clothing/suit/armor/stormtrooper = 2,
					/obj/item/clothing/shoes/combat/stormtrooper = 2,
					/obj/item/clothing/gloves/combat/peacekeeper/stormtrooper = 2,
					)
*/
/obj/machinery/vending/dorms
	zubbers_products = list(

					/obj/item/clothing/head/egorabbit = 5,
					/obj/item/clothing/suit/egorabbit = 5,
					/obj/item/clothing/suit/ran = 1,
					/obj/item/clothing/head/ran = 1,
					/obj/item/clothing/under/rank/captain/femformal = 1
					)
/*
//Unchanged from TG:
/obj/item/storage/box/monkeycubes
	icon = 'icons/obj/storage/box.dmi'
/*
/obj/item/storage/box/gum
	icon = 'icons/obj/storage/box.dmi'
*/
/obj/item/storage/box/donkpockets
	icon = 'icons/obj/storage/box.dmi'
/*
/obj/item/storage/box/papersack
	icon = 'icons/obj/storage/box.dmi'
*/
/obj/item/storage/box/mothic_rations
	icon = 'icons/obj/storage/storage.dmi'

/obj/item/storage/box/mothic_goods
	icon = 'icons/obj/storage/storage.dmi'

/obj/item/storage/box/mothic_cans_sauces
	icon = 'icons/obj/storage/storage.dmi'

/obj/item/storage/box/mothic_rations
	icon = 'icons/obj/storage/storage.dmi'

/obj/item/storage/box/tiziran_goods
	icon = 'icons/obj/storage/storage.dmi'

/obj/item/storage/box/tiziran_cans
	icon = 'icons/obj/storage/storage.dmi'

/obj/item/storage/box/tiziran_meats
	icon = 'icons/obj/storage/storage.dmi'

/obj/machinery/vending/sec_wardrobe
	premium_nova = list(
					/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic = 3,
					/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic/blue = 3,
					/obj/item/clothing/suit/hazardvest/security_medic = 3,
					/obj/item/clothing/suit/hazardvest/security_medic/blue = 3,
					/obj/item/clothing/suit/armor/vest/peacekeeper/security_medic = 3,
					/obj/item/clothing/under/rank/security/peacekeeper/security_medic = 3,
					/obj/item/clothing/under/rank/security/peacekeeper/security_medic/skirt = 3
					)
*/
