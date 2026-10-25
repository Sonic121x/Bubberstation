/datum/export/stack
	abstract_type = /datum/export/stack
	unit_name = "板"

/datum/export/stack/get_amount(obj/O)
	var/obj/item/stack/S = O
	if(istype(S))
		return S.amount
	return 0

// Hides

/datum/export/stack/monkey
	cost = CARGO_CRATE_VALUE * 0.25
	unit_name = "猴皮"
	export_types = list(/obj/item/stack/sheet/animalhide/carbon/monkey)

/datum/export/stack/human
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "片"
	message = "人类皮肤"
	export_types = list(/obj/item/stack/sheet/animalhide/carbon/human)

/datum/export/stack/goliath_hide
	cost = CARGO_CRATE_VALUE
	unit_name = "歌利亚皮"
	export_types = list(/obj/item/stack/sheet/animalhide/goliath_hide)

/datum/export/stack/cat
	cost = CARGO_CRATE_VALUE * 0.75
	unit_name = "猫皮"
	export_types = list(/obj/item/stack/sheet/animalhide/cat)

/datum/export/stack/corgi
	cost = CARGO_CRATE_VALUE
	unit_name = "柯基皮"
	export_types = list(/obj/item/stack/sheet/animalhide/corgi)

/datum/export/stack/lizard
	cost = CARGO_CRATE_VALUE * 0.75
	unit_name = "蜥蜴皮"
	export_types = list(/obj/item/stack/sheet/animalhide/carbon/lizard)

/datum/export/stack/gondola
	cost = CARGO_CRATE_VALUE * 10
	unit_name = "贡多拉皮"
	export_types = list(/obj/item/stack/sheet/animalhide/gondola)

/datum/export/stack/xeno
	cost = CARGO_CRATE_VALUE * 2.5
	unit_name = "异形皮"
	export_types = list(/obj/item/stack/sheet/animalhide/xeno)

/datum/export/stack/carp
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "鲤鱼皮"
	export_types = list(/obj/item/stack/sheet/animalhide/carp)

/datum/export/stack/licenseplate
	cost = CARGO_CRATE_VALUE * 0.125
	unit_name = "车牌"
	export_types = list(/obj/item/stack/license_plates/filled)


// Common materials.
// For base materials, see materials.dm

/datum/export/stack/plasteel
	cost = CARGO_CRATE_VALUE * 0.41 // 100u of plasma + 100u of iron.
	message = "塑钢"
	export_types = list(/obj/item/stack/sheet/plasteel)

// 1 glass + 0.5 iron, cost is rounded up.
/datum/export/stack/rglass
	cost = CARGO_CRATE_VALUE * 0.02
	message = "强化玻璃"
	export_types = list(/obj/item/stack/sheet/rglass)

/datum/export/stack/plastitanium
	cost = CARGO_CRATE_VALUE * 0.65 // plasma + titanium costs
	message = "塑钛"
	export_types = list(/obj/item/stack/sheet/mineral/plastitanium)

/datum/export/stack/wood
	cost = CARGO_CRATE_VALUE * 0.05
	unit_name = "木板"
	export_types = list(/obj/item/stack/sheet/mineral/wood)

/datum/export/stack/cloth
	cost = CARGO_CRATE_VALUE * 0.025
	message = "布卷"
	export_types = list(/obj/item/stack/sheet/cloth)

/datum/export/stack/durathread
	cost = CARGO_CRATE_VALUE * 0.35
	message = "耐久纤维卷"
	export_types = list(/obj/item/stack/sheet/durathread)


/datum/export/stack/cardboard
	cost = CARGO_CRATE_VALUE * 0.01
	message = "纸板"
	export_types = list(/obj/item/stack/sheet/cardboard)

/datum/export/stack/sandstone
	cost = CARGO_CRATE_VALUE * 0.005
	unit_name = "块"
	message = "砂岩"
	export_types = list(/obj/item/stack/sheet/mineral/sandstone)

/datum/export/stack/cable
	cost = CARGO_CRATE_VALUE * 0.001
	unit_name = "电缆段"
	export_types = list(/obj/item/stack/cable_coil)

/datum/export/stack/ammonia_crystals
	cost = CARGO_CRATE_VALUE * 0.125
	unit_name = "氨晶体"
	export_types = list(/obj/item/stack/ammonia_crystals)

/datum/export/stack/pizza
	cost = CARGO_CRATE_VALUE * 0.06
	unit_name = "披萨饼"
	export_types = list(/obj/item/stack/sheet/pizza)

/datum/export/stack/meat
	cost = CARGO_CRATE_VALUE * 0.04
	unit_name = "肉"
	export_types = list(/obj/item/stack/sheet/meat)

// Weird Stuff

/datum/export/stack/abductor
	cost = CARGO_CRATE_VALUE * 2
	message = "异形合金"
	export_types = list(/obj/item/stack/sheet/mineral/abductor)
