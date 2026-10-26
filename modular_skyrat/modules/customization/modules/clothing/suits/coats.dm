/obj/item/clothing/suit/hooded/wintercoat/medical/paramedic
	allowed = list(
		/obj/item/analyzer,
		/obj/item/stack/medical,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/hypospray,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/storage/pill_bottle,
		/obj/item/paper,
		/obj/item/melee/baton/telescopic,
	)
	armor_type = /datum/armor/wintercoat_paramedic

/datum/armor/wintercoat_paramedic
	bio = 50
	acid = 45
	wound = 3

/obj/item/clothing/suit/flakjack
	name = "防弹夹克"
	desc = "一件用所谓防弹材料制成的破旧夹克（提示：并不是）。隐约有股凝固汽油味。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "flakjack"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST
	resistance_flags = NONE
	armor_type = /datum/armor/suit_flakjack
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/datum/armor/suit_flakjack
	bomb = 5
	fire = -5
	acid = -15

/obj/item/clothing/suit/hooded/cloak/david
	name = "红色斗篷"
	icon_state = "goliath_cloak"
	desc = "想毫不费力就看起来像个狠角色？试试这件纳米传讯牌红斗篷，完全由合成材料制成。"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/david
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hooded/cloakhood/david
	icon = 'icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	name = "红斗篷兜帽"
	icon_state = "golhood"
	desc = "用这顶纳米传讯牌仿歌利亚兜帽把你的脸羞愧地遮起来。"
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/urban
	name = "都市大衣"
	desc = "一件为都市生活打造的外套。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/urban"
	post_init_icon_state = "urban_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/urban_coat
	greyscale_config_worn = /datum/greyscale_config/urban_coat/worn
	greyscale_colors = "#252e5a#938060#66562b"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/deckard
	name = "跑者大衣"
	desc = "他们说你过度玩梗。告诉他们，你正穿着这件可爱的外套吃饭——一件飘逸的棕色长外套。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "deckard"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	inhand_icon_state = "det_suit"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor_type = /datum/armor/toggle_deckard
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS

/datum/armor/toggle_deckard
	melee = 25
	bullet = 10
	laser = 25
	energy = 35
	acid = 45

/obj/item/clothing/suit/jacket/leather/colourable
	desc = "现在颜色更多了！"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/jacket/leather/colourable"
	post_init_icon_state = "leather_jacket"
	greyscale_config = /datum/greyscale_config/leather_jacket
	greyscale_config_worn = /datum/greyscale_config/leather_jacket/worn
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/duster
	name = "防尘大衣"
	desc = "这座空间站容不下你我两个人。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/duster"
	post_init_icon_state = "duster"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/duster
	greyscale_config_worn = /datum/greyscale_config/duster/worn
	greyscale_colors = "#8f6349"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/peacoat
	name = "海军呢大衣"
	desc = "你们融入当地色彩的方式可真行。我是说，旗帜女孩已经够糟了，还有 U 艇舰长？"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/peacoat"
	post_init_icon_state = "peacoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/peacoat
	greyscale_config_worn = /datum/greyscale_config/peacoat/worn
	greyscale_colors = "#61618a"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/lawyer/black/better
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "suitjacket_black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/lawyer/white
	name = "白色西装外套"
	desc = "西装套装中非常百搭的一件。奇怪的是，它很受黑帮分子青睐。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "suitjacket_white"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/det_suit/runner
	name = "愉悦外套"
	desc = "<i>“你看起来像个好伙计。”</i>"
	icon_state = "bladerunner_neue"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|ARMS|LEGS
	heat_protection = CHEST|ARMS|GROIN|LEGS
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	blood_overlay_type = "coat"

/obj/item/clothing/suit/croptop
	name = "露脐高领衫"
	desc = "一件看起来很舒适的露脐高领衫，很时髦，但也让毛衣的意义荡然无存。现在搭载 Pycroft 多色技术！"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/croptop"
	post_init_icon_state = "croptop"
	greyscale_config = /datum/greyscale_config/croptop
	greyscale_config_worn = /datum/greyscale_config/croptop/worn
	greyscale_colors = "#1d1b1b"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/croptop/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/suit/varsity
	name = "学院夹克"
	desc = "一件简单的学院夹克，看不出有什么明显来历。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/varsity"
	post_init_icon_state = "varsity_jacket"
	greyscale_config = /datum/greyscale_config/varsity
	greyscale_config_worn = /datum/greyscale_config/varsity/worn
	greyscale_colors = "#553022#a67a5b#2d2d33"
	body_parts_covered = CHEST|GROIN|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/hooded/leather
	name = "带连帽衫的皮夹克"
	desc = "一件简单的皮外套，里面配着连帽衫——其实算不上有兜帽，对吧？"
	icon_state = "leatherhoodie"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	hoodtype = /obj/item/clothing/head/hooded/leather

/obj/item/clothing/head/hooded/leather
	name = "外套兜帽"
	desc = "连在连帽衫上的兜帽，没什么特别的。"
	icon_state = "leatherhood"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	flags_inv = HIDEHAIR

/obj/item/clothing/suit/tailored_jacket
	name = "定制夹克"
	desc = "一件略长的夹克，专为……它现在的样子量身定制！"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/tailored_jacket"
	post_init_icon_state = "tailored_jacket"
	greyscale_config = /datum/greyscale_config/tailored_jacket
	greyscale_config_worn = /datum/greyscale_config/tailored_jacket/worn
	greyscale_colors = "#8c8c8c#8c8c8c#8c8c8c#bf9f78#8c8c8c#8c8c8c#8c8c8c#bf9f78#8c8c8c" // Look this has a lot of colorable sections
	body_parts_covered = CHEST|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/tailored_jacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "sleeves")

/obj/item/clothing/suit/tailored_jacket/short
	name = "定制短夹克"
	desc = "一件夹克，专为……它现在的样子量身定制！"
	icon_state = "/obj/item/clothing/suit/tailored_jacket/short"
	greyscale_config = /datum/greyscale_config/tailored_short_jacket
	greyscale_config_worn = /datum/greyscale_config/tailored_short_jacket/worn
	greyscale_colors = "#8c8c8c#8c8c8c#8c8c8c#bf9f78#8c8c8c#8c8c8c#bf9f78#8c8c8c"

/obj/item/clothing/suit/warm_coat
	name = "保暖大衣"
	desc = "一件带毛皮的长款保暖外套，看起来相当舒服。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/warm_coat"
	post_init_icon_state = "warm_coat"
	greyscale_config = /datum/greyscale_config/warm_coat
	greyscale_config_worn = /datum/greyscale_config/warm_coat/worn
	greyscale_colors = "#7a5f4f#d9cec7"
	flags_1 = IS_PLAYER_COLORABLE_1
	cold_protection = CHEST|GROIN|ARMS
	body_parts_covered = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
