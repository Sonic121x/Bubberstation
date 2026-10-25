/obj/item/clothing/shoes/combat //basic syndicate combat boots for nuke ops and mob corpses
	name = "作战靴"
	desc = "高速低阻的作战靴。"
	icon_state = "jackboots"
	inhand_icon_state = "jackboots"
	/* BUBBER EDIT REMOVAL
	supports_variations_flags = CLOTHING_DIGITIGRADE_MASK
	bodyshapes_with_variations = BODYSHAPE_DIGITIGRADE
	*/
	body_parts_covered = FEET|LEGS
	armor_type = /datum/armor/shoes_combat
	strip_delay = 4 SECONDS
	resistance_flags = NONE
	lace_time = 12 SECONDS

/datum/armor/shoes_combat
	melee = 25
	bullet = 25
	laser = 25
	energy = 25
	bomb = 50
	bio = 90
	fire = 70
	acid = 50

/obj/item/clothing/shoes/combat/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/shoes)
	AddElement(/datum/element/ignites_matches)

/obj/item/clothing/shoes/combat/swat //overpowered boots for death squads
	name = "\improper 特警靴"
	desc = "高速零阻的作战靴。"
	clothing_traits = list(TRAIT_NO_SLIP_WATER)
	armor_type = /datum/armor/combat_swat

/datum/armor/combat_swat
	melee = 40
	bullet = 30
	laser = 25
	energy = 25
	bomb = 50
	bio = 100
	fire = 90
	acid = 50

/obj/item/clothing/shoes/jackboots
	name = "长筒军靴"
	desc = "纳米传讯安保部配发的作战靴，适用于作战场景或作战状况。随时都在作战。"
	icon_state = "jackboots"
	inhand_icon_state = "jackboots"
	/* BUBBER EDIT REMOVAL
	supports_variations_flags = CLOTHING_DIGITIGRADE_MASK
	bodyshapes_with_variations = BODYSHAPE_DIGITIGRADE
	*/
	strip_delay = 3 SECONDS
	equip_delay_other = 5 SECONDS
	resistance_flags = NONE
	armor_type = /datum/armor/shoes_jackboots
	fastening_type = SHOES_SLIPON
	body_parts_covered = FEET|LEGS

/datum/armor/shoes_jackboots
	bio = 90

/obj/item/clothing/shoes/jackboots/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/shoes)
	AddElement(/datum/element/ignites_matches)

/obj/item/clothing/shoes/jackboots/fast
	slowdown = -1

/obj/item/clothing/shoes/jackboots/sec
	icon_state = "jackboots_sec"

/obj/item/clothing/shoes/jackboots/floortile
	name = "地板砖迷彩军靴"
	desc = "是我眼花，还是地板上放着一双军靴？"
	icon_state = "ftc_boots"
	inhand_icon_state = null
	supports_variations_flags = NONE
	bodyshapes_with_variations = NONE

/obj/item/clothing/shoes/jackboots/floortile/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -5) //tacticool

/obj/item/clothing/shoes/winterboots
	name = "冬靴"
	desc = "内衬“合成”动物毛皮的靴子。"
	icon_state = "winterboots"
	inhand_icon_state = null
	/* BUBBER EDIT REMOVAL
	supports_variations_flags = CLOTHING_DIGITIGRADE_MASK
	bodyshapes_with_variations = BODYSHAPE_DIGITIGRADE
	*/
	armor_type = /datum/armor/shoes_winterboots
	cold_protection = FEET|LEGS
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET|LEGS
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT
	lace_time = 8 SECONDS

/datum/armor/shoes_winterboots
	bio = 80

/obj/item/clothing/shoes/winterboots/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/shoes)
	AddElement(/datum/element/ignites_matches)

/obj/item/clothing/shoes/winterboots/ice_boots
	name = "冰上徒步靴"
	desc = "一双底部带有特殊防滑纹的冬靴，专为防止在结冰表面滑倒而设计。"
	icon_state = "iceboots"
	inhand_icon_state = null
	clothing_traits = list(TRAIT_NO_SLIP_ICE, TRAIT_NO_SLIP_SLIDE, TRAIT_NO_SNOWPRINTS)

// A pair of ice boots intended for general crew EVA use - see EVA winter coat for comparison.
/obj/item/clothing/shoes/winterboots/ice_boots/eva
	name = "\proper 恒温徒步靴"
	desc = "一双厚重的靴子，底部装有防滑纹，可让穿戴者在严寒环境中行走时保持直立。"
	icon_state = "iceboots_eva"
	w_class = WEIGHT_CLASS_BULKY
	slowdown = 0.25
	armor_type = /datum/armor/ice_boots_eva
	strip_delay = 4 SECONDS
	equip_delay_other = 4 SECONDS
	clothing_flags = parent_type::clothing_flags | THICKMATERIAL
	body_parts_covered = FEET|LEGS
	resistance_flags = NONE

/datum/armor/ice_boots_eva
	melee = 10
	laser = 10
	energy = 10
	bio = 50
	fire = 50
	acid = 10

/obj/item/clothing/shoes/workboots
	name = "工作靴"
	desc = "纳米传讯工程部配发的系带工作靴，专为蓝领工人打造。"
	icon_state = "workboots"
	inhand_icon_state = "jackboots"
	armor_type = /datum/armor/shoes_workboots
	/* BUBBER EDIT REMOVAL
	supports_variations_flags = CLOTHING_DIGITIGRADE_MASK
	bodyshapes_with_variations = BODYSHAPE_DIGITIGRADE
	*/
	strip_delay = 2 SECONDS
	equip_delay_other = 4 SECONDS
	lace_time = 8 SECONDS

/datum/armor/shoes_workboots
	bio = 80

/obj/item/clothing/shoes/workboots/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/shoes)
	AddElement(/datum/element/ignites_matches)

/obj/item/clothing/shoes/workboots/mining
	name = "采矿靴"
	desc = "钢头采矿靴，适用于危险环境下的采矿作业。非常擅长保护脚趾不被压碎。"
	icon_state = "explorer"
	resistance_flags = FIRE_PROOF

/obj/item/clothing/shoes/workboots/black
	name = "战术工作靴"
	desc = "系带工作靴，保护普通灰领工人不被破碎玻璃、掉落的钢笔等杂物扎伤。"
	icon_state = "workboots_black"

/obj/item/clothing/shoes/russian
	name = "俄罗斯靴"
	desc = "舒适的鞋子。"
	icon_state = "rus_shoes"
	inhand_icon_state = null
	lace_time = 8 SECONDS
	supports_variations_flags = CLOTHING_DIGITIGRADE_MASK
	bodyshapes_with_variations = BODYSHAPE_DIGITIGRADE

/obj/item/clothing/shoes/russian/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/shoes)
	AddElement(/datum/element/ignites_matches)

/obj/item/clothing/shoes/discoshoes
	name = "绿色蜥蜴皮鞋"
	desc = "多年来它们或许已失去了一些光泽，但这双绿色蜥蜴皮鞋穿在你脚上正合适。"
	icon_state = "lizardskin_shoes"
	inhand_icon_state = null

/obj/item/clothing/shoes/jackboots/kim
	name = "飞行靴"
	desc = "一双干净利落的靴子，适合长时间的巡逻执勤。"
	icon_state = "aerostatic_boots"
	inhand_icon_state = null

/obj/item/clothing/shoes/pirate
	name = "海盗靴"
	desc = "呀嗬。"
	icon_state = "pirateboots"
	inhand_icon_state = null

/obj/item/clothing/shoes/pirate/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/shoes)
	AddElement(/datum/element/adjust_fishing_difficulty, -4)

/obj/item/clothing/shoes/pirate/armored
	armor_type = /datum/armor/shoes_pirate
	strip_delay = 4 SECONDS
	resistance_flags = NONE
	lace_time = 12 SECONDS
	body_parts_covered = FEET|LEGS

/datum/armor/shoes_pirate
	melee = 25
	bullet = 25
	laser = 25
	energy = 25
	bomb = 50
	bio = 90
	fire = 70
	acid = 50
