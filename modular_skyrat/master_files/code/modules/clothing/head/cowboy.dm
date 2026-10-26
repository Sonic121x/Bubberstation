/obj/item/clothing/head/cowboy
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/cowboy/skyrat
	name = "SR 牛仔帽 调试"
	desc = "若发现此物请上报"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/cowboy.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/cowboy.dmi'
	icon_state = null //Keeps this from showing up under the chameleon hat
	worn_icon_state = null //TG defaults this to "hunter" and breaks our items
	flags_inv = SHOWSPRITEEARS
	armor_type = /datum/armor/none
	resistance_flags = NONE //TG defaults cowboy hats to fireproof/acidproof

/obj/item/clothing/head/cowboy/skyrat/wide
	name = "宽檐帽"
	desc = "一顶宽檐帽，让你既能遮阳又不失风度。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/cowboy/skyrat/wide"
	post_init_icon_state = "widebrim"
	greyscale_colors = "#4D4D4D#DE9754"
	greyscale_config = /datum/greyscale_config/cowboy_wide
	greyscale_config_worn = /datum/greyscale_config/cowboy_wide/worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/cowboy/skyrat/wide/feathered
	name = "羽饰宽檐帽"
	desc = "一顶饰有羽毛的宽檐帽，为粗犷的装束添上完美的点睛之笔。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/cowboy/skyrat/wide/feathered"
	post_init_icon_state = "widebrim_feathered"
	greyscale_colors = "#4D4D4D#DE9754#D5D5B9"
	greyscale_config = /datum/greyscale_config/cowboy_wide_feathered
	greyscale_config_worn = /datum/greyscale_config/cowboy_wide_feathered/worn

/obj/item/clothing/head/cowboy/skyrat/flat
	name = "平檐帽"
	desc = "一顶做工精良的短平檐帽，正适合老式决斗。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/cowboy/skyrat/flat"
	post_init_icon_state = "flatbrim"
	greyscale_colors = "#BE925B#914C2F"
	greyscale_config = /datum/greyscale_config/cowboy_flat
	greyscale_config_worn = /datum/greyscale_config/cowboy_flat/worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/cowboy/skyrat/flat/cowl
	name = "带风帽的平檐帽"
	desc = "一顶做工精良的短平檐帽，配有一条温暖贴合的围颈风帽。今天真是适合送命的冷天……"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/cowboy/skyrat/flat/cowl"
	post_init_icon_state = "flatbrim_cowl"
	greyscale_colors = "#c26934#8f89ae#774B2D"
	greyscale_config = /datum/greyscale_config/cowboy_flat_cowl
	greyscale_config_worn = /datum/greyscale_config/cowboy_flat_cowl/worn
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR | SHOWSPRITEEARS

/obj/item/clothing/head/cowboy/skyrat/cattleman
	name = "牧场主帽"
	desc = "一顶帽檐带褶、帽冠高挺的帽子，通常需要往头上压得更低，以便在恶劣天气中不被吹走。这在太空里虽不太用得上，但仍然很实用。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/cowboy/skyrat/cattleman"
	post_init_icon_state = "cattleman"
	greyscale_colors = "#725443#B2977C"
	greyscale_config = /datum/greyscale_config/cowboy_cattleman
	greyscale_config_worn = /datum/greyscale_config/cowboy_cattleman/worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/cowboy/skyrat/cattleman/wide
	name = "宽檐牧场主帽"
	desc = "一顶帽檐宽大且略带褶皱的帽子。适合在烈日下劳作，但不太适合钻过狭窄缝隙。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/cowboy/skyrat/cattleman/wide"
	post_init_icon_state = "cattleman_wide"
	greyscale_colors = "#4D4D4D#5F666E"
	greyscale_config = /datum/greyscale_config/cowboy_cattleman_wide
	greyscale_config_worn = /datum/greyscale_config/cowboy_cattleman_wide/worn
	flags_1 = IS_PLAYER_COLORABLE_1

//Presets
/obj/item/clothing/head/cowboy/skyrat/flat/sheriff
	name = "治安官帽"
	desc = "一顶深棕色的帽子，散发着威士忌的气味。内衬上绣着一对小小的鹿角。"
	icon_state = "/obj/item/clothing/head/cowboy/skyrat/flat/sheriff"
	greyscale_colors = "#704640#8f89ae"
	flags_1 = NONE //No recoloring presets

/obj/item/clothing/head/cowboy/skyrat/flat/deputy
	name = "副治安官帽"
	desc = "一顶浅棕色的帽子，散发着铁锈的气味。内衬上绣着一对小小的鹿角。"
	icon_state = "/obj/item/clothing/head/cowboy/skyrat/flat/deputy"
	greyscale_colors = "#c26934#8f89ae"
	flags_1 = NONE //No recoloring presets

/obj/item/clothing/head/cowboy/skyrat/flat/cowl/sheriff
	name = "冬季治安官帽"
	desc = "一顶深色帽子，配有一条同色系的深色围颈风帽，保暖又透气。内衬上绣着一对小小的鹿角。"
	icon_state = "/obj/item/clothing/head/cowboy/skyrat/flat/cowl/sheriff"
	greyscale_colors = "#3F3F3F#716349#3F3F3F"
	flags_1 = NONE //No recoloring presets

/obj/item/clothing/head/cowboy/skyrat/cattleman/sec
	name = "安保牧场主帽"
	desc = "一顶安保牧场主帽，适合任何真正的执法者。"
	icon_state = "/obj/item/clothing/head/cowboy/skyrat/cattleman/sec"
	greyscale_colors = "#403A3A#9D3F3F"
	armor_type = /datum/armor/head_helmet
	flags_1 = NONE //No recoloring presets

/obj/item/clothing/head/cowboy/skyrat/cattleman/wide/sec
	name = "宽檐安保牧场主帽"
	desc = "由匪徒转任的治安官，执法残酷却行之有效——究竟是出于恐惧还是敬重，谁也说不清楚，不过被吊死的尸体并不算多。一片安宁的土地，一群沉默的民众。"
	icon_state = "/obj/item/clothing/head/cowboy/skyrat/cattleman/wide/sec"
	greyscale_colors = "#403A3A#9D3F3F"
	armor_type = /datum/armor/head_helmet
	flags_1 = NONE //No recoloring presets
