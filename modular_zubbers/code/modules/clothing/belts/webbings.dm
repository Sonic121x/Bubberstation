/obj/item/storage/belt/webbing
	name = "织带"
	desc = "一堆结实的合成皮带与搭扣，随时为你分担重负。"
	icon = 'modular_zubbers/icons/obj/clothing/belts/belts.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/belts/belts.dmi'
	icon_state = "webbing"
	worn_icon_state = "webbing"
	storage_type = /datum/storage/belt/webbing

/obj/item/storage/belt/webbing/colonial_webbing
	name = "殖民地织带背心"
	desc = "一件多功能的单兵携行装备，深受殖民者和囤积狂的喜爱。"
	icon = 'modular_skyrat/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_skyrat/modules/food_replicator/icons/clothing_worn.dmi'
	icon_state = "accessory_webbing"
	worn_icon_state = "accessory_webbing"


/datum/storage/belt/webbing
	max_slots = 3
	max_specific_storage = WEIGHT_CLASS_SMALL
	silent = TRUE

//vest
/obj/item/storage/belt/webbing_vest
	name = "织带背心"
	desc = "一件结实的背心，有许多口袋可以装下你需要的一切，随时为你分担重负。"
	icon = 'modular_zubbers/icons/obj/clothing/belts/belts.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/belts/belts.dmi'
	icon_state = "vest_brown"
	worn_icon_state = "vest_brown"
	storage_type = /datum/storage/belt/webbing

/obj/item/storage/belt/webbing_vest/black
	icon_state = "vest_black"
	worn_icon_state = "vest_black"

/obj/item/storage/belt/webbing_vest/white
	icon_state = "vest_white"
	worn_icon_state = "vest_white"

//drop pouches
/obj/item/storage/belt/webbing_pouch
	name = "挂腿袋"
	desc = "一对结实的挂腿袋，容量可观，随时为你分担重负。"
	icon = 'modular_zubbers/icons/obj/clothing/belts/belts.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/belts/belts.dmi'
	icon_state = "thigh_brown"
	worn_icon_state = "thigh_brown"
	storage_type = /datum/storage/belt/webbing

/obj/item/storage/belt/webbing_pouch/black
	icon_state = "thigh_black"
	worn_icon_state = "thigh_black"

/obj/item/storage/belt/webbing_pouch/white
	icon_state = "thigh_white"
	worn_icon_state = "thigh_white"

//rigging
/obj/item/storage/belt/webbing_pilot
	name = "全套挂具"
	desc = "一堆结实的合成皮带与搭扣，随时为你分担重负。"
	icon = 'modular_zubbers/icons/obj/clothing/belts/belts.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/belts/belts.dmi'
	icon_state = "pilot_webbing1"
	worn_icon_state = "pilot_webbing1"
	storage_type = /datum/storage/belt/webbing

/obj/item/storage/belt/webbing_pilot/low
	name = "低垂挂具"
	icon_state = "pilot_webbing2"
	worn_icon_state = "pilot_webbing2"
