/datum/supply_pack/security/armory/soft_armor
	name = "软质护甲套装箱"
	crate_name = "软质护甲套装箱"
	desc = "内含三套地球政府制造的软质护甲和配套头盔。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/clothing/head/helmet/sf_peacekeeper/debranded = 3,
		/obj/item/clothing/suit/armor/sf_peacekeeper/debranded = 3,
	)

/datum/supply_pack/security/armory/hardened_armor
	name = "硬化护甲套装箱"
	crate_name = "硬化护甲套装箱"
	desc = "内含三套地球政府制造的硬化护甲和配套头盔。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/clothing/head/helmet/toggleable/sf_hardened = 3,
		/obj/item/clothing/suit/armor/sf_hardened = 3,
	)

/datum/supply_pack/security/armory/sacrificial_armor
	name = "牺牲式护甲套装箱"
	crate_name = "牺牲式护甲套装箱"
	desc = "内含三套地球政府制造的牺牲式护甲和配套头盔。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/clothing/head/helmet/sf_sacrificial = 3,
		/obj/item/sacrificial_face_shield = 3,
		/obj/item/clothing/suit/armor/sf_sacrificial = 3,
	)
