
/obj/item/clothing/head/utility/beekeeper_head
	name = "养蜂帽"
	desc = "让那些嗡嗡作响的小家伙别钻进你的眼睛。"
	icon_state = "beekeeper"
	inhand_icon_state = null
	clothing_flags = THICKMATERIAL | SNUG_FIT
	pickup_sound = null
	drop_sound = null
	equip_sound = null

/obj/item/clothing/suit/utility/beekeeper_suit
	name = "养蜂服"
	desc = "让那些嗡嗡作响的小家伙远离你柔软的部位。"
	icon_state = "beekeeper"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	clothing_flags = THICKMATERIAL
	allowed = list(/obj/item/melee/flyswatter, /obj/item/reagent_containers/spray/plantbgone, /obj/item/plant_analyzer, /obj/item/seeds, /obj/item/reagent_containers/cup/bottle, /obj/item/reagent_containers/cup/beaker, /obj/item/cultivator, /obj/item/reagent_containers/spray/pestspray, /obj/item/hatchet, /obj/item/storage/bag/plants)
