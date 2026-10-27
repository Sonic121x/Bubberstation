/datum/export/sec_helmet
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "头盔"
	export_types = list(/obj/item/clothing/head/helmet/sec)

/datum/export/sec_armor
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "防弹衣"
	export_types = list(/obj/item/clothing/suit/armor/vest)

/datum/export/riot_shield
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "防暴盾牌"
	export_types = list(/obj/item/shield/riot)


/datum/export/breath_mask
	cost = CARGO_CRATE_VALUE * 0.01
	unit_name = "呼吸面罩"
	export_types = list(/obj/item/clothing/mask/breath)

/datum/export/gas_mask
	cost = CARGO_CRATE_VALUE * 0.05
	unit_name = "防毒面具"
	export_types = list(/obj/item/clothing/mask/gas)
	include_subtypes = FALSE


/datum/export/helmet_space
	cost = CARGO_CRATE_VALUE * 0.15
	unit_name = "太空头盔"
	export_types = list(/obj/item/clothing/head/helmet/space, /obj/item/clothing/head/helmet/space/eva, /obj/item/clothing/head/helmet/space/nasavoid)
	include_subtypes = FALSE

/datum/export/suit_space
	cost = CARGO_CRATE_VALUE * 0.3
	unit_name = "太空服"
	export_types = list(/obj/item/clothing/suit/space, /obj/item/clothing/suit/space/eva, /obj/item/clothing/suit/space/nasavoid)
	include_subtypes = FALSE


/datum/export/syndiehelmet_space
	cost = CARGO_CRATE_VALUE * 0.3
	unit_name = "辛迪加太空头盔"
	export_types = list(/obj/item/clothing/head/helmet/space/syndicate)

/datum/export/syndiesuit_space
	cost = CARGO_CRATE_VALUE * 0.6
	unit_name = "辛迪加太空服"
	export_types = list(/obj/item/clothing/suit/space/syndicate)


/datum/export/radhelmet
	cost = CARGO_CRATE_VALUE * 0.1
	unit_name = "辐射防护服头罩"
	export_types = list(/obj/item/clothing/head/utility/radiation)

/datum/export/radsuit
	cost = CARGO_CRATE_VALUE * 0.2
	unit_name = "辐射防护服"
	export_types = list(/obj/item/clothing/suit/utility/radiation)

/datum/export/biohood
	cost = CARGO_CRATE_VALUE * 0.1
	unit_name = "生物防护服头罩"
	export_types = list(/obj/item/clothing/head/bio_hood)

/datum/export/biosuit
	cost = CARGO_CRATE_VALUE * 0.2
	unit_name = "生物防护服"
	export_types = list(/obj/item/clothing/suit/bio_suit)

/datum/export/bombhelmet
	cost = CARGO_CRATE_VALUE * 0.1
	unit_name = "防爆服头罩"
	export_types = list(/obj/item/clothing/head/utility/bomb_hood)

/datum/export/bombsuit
	cost = CARGO_CRATE_VALUE * 0.2
	unit_name = "防爆服"
	export_types = list(/obj/item/clothing/suit/utility/bomb_suit)

/datum/export/lizardboots
	cost = CARGO_CRATE_VALUE * 0.7
	unit_name = "蜥蜴皮靴"
	export_types = list(/obj/item/clothing/shoes/cowboy/lizard)
	include_subtypes = FALSE

/datum/export/lizardmasterwork
	cost = CARGO_CRATE_VALUE * 2
	unit_name = "抱足者蜥蜴皮靴"
	export_types = list(/obj/item/clothing/shoes/cowboy/lizard/masterwork)

/datum/export/bilton
	cost = CARGO_CRATE_VALUE * 5
	unit_name = "比尔顿牧马人靴"
	export_types = list(/obj/item/clothing/shoes/cowboy/fancy)

/datum/export/ebonydie
	cost = CARGO_CRATE_VALUE
	unit_name = "乌木骰子"
	export_types = list(/obj/item/dice/d6/ebony)

/datum/export/rare_lighter
	cost = CARGO_CRATE_VALUE * 4
	unit_name = "新奇打火机"
	export_types = list(
		/obj/item/lighter/skull,
		/obj/item/lighter/mime,
		/obj/item/lighter/bright,
	)
