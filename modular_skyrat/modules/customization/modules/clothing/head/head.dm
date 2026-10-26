/obj/item/clothing/head/hats/flakhelm	//Actually the M1 Helmet
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	name = "防弹头盔"
	icon_state = "m1helm"
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/hats_flakhelm
	desc = "一顶在古老战争中使用的破旧头盔。这一顶已经脆化，基本毫无用处。外壳的带子上别着一张黑桃 A。"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/datum/armor/hats_flakhelm
	bomb = 0.1
	fire = -10
	acid = -15
	wound = 1

/obj/item/clothing/head/hats/flakhelm/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny/spacenam)

/datum/storage/pockets/tiny/spacenam
	attack_hand_interact = TRUE		//So you can actually see what you stuff in there

//Cyberpunk PI Costume - Sprites from Eris
/obj/item/clothing/head/fedora/det_hat/cybergoggles //Subset of detective fedora so that detectives dont have to sacrifice candycorns for style
	name = "34P 型鉴识头饰"
	desc = "某些执法机构使用的一款流行头盔。带有薄层装甲板和新式层压纤维内衬。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "cyberpunkgoggle"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/fedora/det_hat/cybergoggles/civilian //Actually civilian with no armor for drip purposes only
	name = "34C 型鉴识头饰"
	desc = "某些执法机构使用的一款流行头盔的民用型号。没有任何装甲板。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "cyberpunkgoggle"
	armor_type = /datum/armor/none
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/intern/developer
	name = "实习生针织帽"

/obj/item/clothing/head/beret/sec/navywarden/syndicate
	name = "纠察长贝雷帽"
	desc = "出乎意料地时髦——前提是你生活在无声印象派电影里。"
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/sec/navywarden/syndicate"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#353535#AAAAAA"
	post_init_icon_state = "beret_badge"
	armor_type = /datum/armor/navywarden_syndicate
	strip_delay = 60
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/datum/armor/navywarden_syndicate
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 30
	acid = 50
	wound = 6

/obj/item/clothing/head/colourable_flatcap
	name = "鸭舌帽（可染色）"
	desc = "小子，你是搞电脑的？你负责摆弄电脑？"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/colourable_flatcap"
	post_init_icon_state = "flatcap"
	greyscale_config = /datum/greyscale_config/flatcap
	greyscale_config_worn = /datum/greyscale_config/flatcap/worn
	greyscale_colors = "#79684c"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/soft/yankee
	name = "时尚棒球帽"
	desc = "有帽檐，有帽舌。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "yankeesoft"
	soft_type = "yankee"
	dog_fashion = /datum/dog_fashion/head/yankee
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/soft/yankee/rimless
	name = "无檐时尚棒球帽"
	desc = "无檐设计，只为她的愉悦。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "yankeenobrimsoft"
	soft_type = "yankeenobrim"

/obj/item/clothing/head/fedora/brown //Fedora without detective's candy corn gimmick
	name = "棕色软呢帽"
	icon_state = "detective"
	inhand_icon_state = null

/obj/item/clothing/head/hooded/standalone_hood
	name = "独立兜帽"
	desc = "一顶颈部带支撑的兜帽，能真正固定在原位，适合所有想只戴兜帽不穿外套的时候。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/hooded/standalone_hood"
	worn_icon = 'modular_skyrat/modules/GAGS/icons/head/head.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/GAGS/icons/head/head_teshari.dmi'
	post_init_icon_state = "hood"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS|SHOWSPRITEEARS
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#4e4a43#F1F1F1"
	greyscale_config = /datum/greyscale_config/standalone_hood
	greyscale_config_worn = /datum/greyscale_config/standalone_hood/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/standalone_hood/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/standalone_hood/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/standalone_hood/worn/oldvox

/obj/item/clothing/head/beret/badge
	name = "带徽章贝雷帽"
	desc = "一顶贝雷帽。带个徽章。你还想要什么，一篇论文吗？这就是顶帽子。"
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/badge"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#972A2A#EFEFEF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/costume/cowboyhat_old
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	name = "牛仔帽（旧版）"
	desc = "一顶较旧的牛仔帽，适合任何亡命之徒，只是缺少花哨的色彩魔法。"
	icon_state = "cowboyhat_black"
	inhand_icon_state = "cowboy_hat_black"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

//BOWS
/obj/item/clothing/head/small_bow
	name = "小蝴蝶结"
	desc = "一个小巧的蝴蝶结，可以别在头发一侧。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/small_bow"
	post_init_icon_state = "small_bow"
	greyscale_config = /datum/greyscale_config/small_bow
	greyscale_config_worn = /datum/greyscale_config/small_bow/worn
	greyscale_colors = "#7b9ab5"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/small_bow/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_clothes, "small_bow_t")

/obj/item/clothing/head/large_bow
	name = "大蝴蝶结"
	desc = "一个大蝴蝶结，可以戴在头顶。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/large_bow"
	post_init_icon_state = "large_bow"
	greyscale_config = /datum/greyscale_config/large_bow
	greyscale_config_worn = /datum/greyscale_config/large_bow/worn
	greyscale_colors = "#7b9ab5"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/back_bow
	name = "背后蝴蝶结"
	desc = "一个大蝴蝶结，可以戴在脑后。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/back_bow"
	post_init_icon_state = "back_bow"
	greyscale_config = /datum/greyscale_config/back_bow
	greyscale_config_worn = /datum/greyscale_config/back_bow/worn
	greyscale_colors = "#7b9ab5"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/sweet_bow
	name = "甜美蝴蝶结"
	desc = "一个甜美的蝴蝶结，可以戴在脑后。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/sweet_bow"
	post_init_icon_state = "sweet_bow"
	greyscale_config = /datum/greyscale_config/sweet_bow
	greyscale_config_worn = /datum/greyscale_config/sweet_bow/worn
	greyscale_colors = "#7b9ab5"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/hats/caphat/bicorne
	name = "舰长双角帽"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	desc = "推翻国王的感觉真好。"
	icon_state = "terragov_bicorne"
	worn_y_offset = 2

/obj/item/clothing/head/hats/caphat/sonnensoldner
	name = "舰长羽饰帽"
	desc = "火炮就绪！"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "sonnensoldner_hat"
	worn_y_offset = 4
