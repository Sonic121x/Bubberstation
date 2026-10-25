/obj/item/clothing/suit/jacket
	icon = 'icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'icons/mob/clothing/suits/jacket.dmi'
	abstract_type = /obj/item/clothing/suit/jacket
	allowed = list(
		/obj/item/flashlight,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/toy,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/lighter,
		/obj/item/radio,
		)
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/jacket/Initialize(mapload)
	. = ..()
	allowed += GLOB.personal_carry_allowed

/obj/item/clothing/suit/toggle/jacket
	icon = 'icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'icons/mob/clothing/suits/jacket.dmi'
	abstract_type = /obj/item/clothing/suit/toggle/jacket
	allowed = list(
		/obj/item/flashlight,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/tank/jetpack/captain,
		/obj/item/toy,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/lighter,
		/obj/item/radio,
		)
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/toggle/jacket/Initialize(mapload)
	. = ..()
	allowed += GLOB.personal_carry_allowed

/obj/item/clothing/suit/toggle/jacket/sweater
	name = "毛衣夹克"
	desc = "一件毛衣夹克。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/sweater"
	post_init_icon_state = "sweater"
	greyscale_config = /datum/greyscale_config/sweater
	greyscale_config_worn = /datum/greyscale_config/sweater/worn
	greyscale_colors = "#414344"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/jacket/trenchcoat
	name = "风衣"
	desc = "一件多用途风衣。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/trenchcoat"
	post_init_icon_state = "trenchcoat"
	greyscale_config = /datum/greyscale_config/trenchcoat
	greyscale_config_worn = /datum/greyscale_config/trenchcoat/worn
	greyscale_colors = "#414344"
	flags_1 = IS_PLAYER_COLORABLE_1
	blood_overlay_type = "coat"
	flags_inv = HIDEBELT
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR // I know kung-fu

/obj/item/clothing/suit/toggle/jacket/trenchcoat/Initialize(mapload)
	. = ..()
	allowed += GLOB.improvised_firearm_allowed

/obj/item/clothing/suit/jacket/blazer
	name = "西装夹克"
	desc = "一件西装夹克。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/jacket/blazer"
	post_init_icon_state = "blazer"
	greyscale_config = /datum/greyscale_config/blazer
	greyscale_config_worn = /datum/greyscale_config/blazer/worn
	greyscale_colors = "#414344"
	flags_1 = IS_PLAYER_COLORABLE_1
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/suit/jacket/oversized
	name = "超大号夹克"
	desc = "一件超大号夹克。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/jacket/oversized"
	post_init_icon_state = "jacket_oversized"
	greyscale_config = /datum/greyscale_config/jacket_oversized
	greyscale_config_worn = /datum/greyscale_config/jacket_oversized/worn
	greyscale_colors = "#414344"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/jacket/fancy
	name = "华丽毛皮大衣"
	desc = "《Cosmo》杂志评其为最佳大衣品牌，10 分满分。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/jacket/fancy"
	post_init_icon_state = "fancy_coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/fancy_coat
	greyscale_config_worn = /datum/greyscale_config/fancy_coat/worn
	greyscale_colors = "#EDE3DC#414344"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/jacket/bomber
	name = "飞行夹克"
	desc = "不含飞行眼镜。"
	icon_state = "bomberjacket"
	inhand_icon_state = "brownjsuit"

/obj/item/clothing/suit/jacket/bomber/Initialize(mapload)
	. = ..()
	allowed += GLOB.improvised_firearm_allowed

/obj/item/clothing/suit/jacket/leather
	name = "皮夹克"
	desc = "不含飞机头。"
	icon_state = "leatherjacket"
	inhand_icon_state = "hostrench"
	resistance_flags = NONE
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT

/obj/item/clothing/suit/jacket/leather/Initialize(mapload)
	. = ..()
	allowed += GLOB.improvised_firearm_allowed

/obj/item/clothing/suit/jacket/leather/biker
	name = "机车夹克"
	desc = "你觉得我连一美元都不值，但我感觉自己像个百万富翁。"
	icon_state = "leatherjacket_biker"

/obj/item/clothing/suit/jacket/puffer
	name = "羽绒夹克"
	desc = "一件厚实的夹克，外层是富有弹性、防水的面料。"
	icon_state = "pufferjacket"
	inhand_icon_state = "hostrench"
	armor_type = /datum/armor/jacket_puffer

/datum/armor/jacket_puffer
	bio = 50

/obj/item/clothing/suit/jacket/puffer/vest
	name = "羽绒背心"
	desc = "一件厚实的背心，外层是富有弹性、防水的面料。"
	icon_state = "puffervest"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN
	armor_type = /datum/armor/puffer_vest

/datum/armor/puffer_vest
	bio = 30

/obj/item/clothing/suit/jacket/miljacket
	name = "军装夹克"
	desc = "一件仿照经典美军军服风格的帆布夹克。结实却舒适。"
	icon_state = "militaryjacket"
	inhand_icon_state = null

/obj/item/clothing/suit/jacket/miljacket/Initialize(mapload)
	. = ..()
	allowed += GLOB.improvised_firearm_allowed

/obj/item/clothing/suit/jacket/letterman
	name = "校队夹克"
	desc = "一件经典的棕色校队夹克。看起来又热又厚重。"
	icon_state = "letterman"
	inhand_icon_state = null
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/jacket/letterman/Initialize(mapload)
	. = ..()
	allowed += GLOB.improvised_firearm_allowed

/obj/item/clothing/suit/jacket/letterman_red
	name = "红色校队夹克"
	desc = "一件红得炫酷的校队夹克。太棒了。"
	icon_state = "letterman_red"
	inhand_icon_state = null
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/jacket/letterman_red/Initialize(mapload)
	. = ..()
	allowed += GLOB.improvised_firearm_allowed

/obj/item/clothing/suit/jacket/letterman_syndie
	name = "血红色校队夹克"
	desc = "奇怪的是，这件夹克背面似乎有一个大大的 S……"
	icon_state = "letterman_s"
	inhand_icon_state = null
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/jacket/letterman_syndie/Initialize(mapload)
	. = ..()
	allowed += GLOB.improvised_firearm_allowed

/obj/item/clothing/suit/jacket/letterman_nanotrasen
	name = "蓝色校队夹克"
	desc = "一件蓝色校队夹克，背面骄傲地印着纳米传讯的 N 字。标签上写着它产于太空中国。"
	icon_state = "letterman_n"
	inhand_icon_state = null
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/jacket/letterman_nanotrasen/Initialize(mapload)
	. = ..()
	allowed += GLOB.improvised_firearm_allowed
