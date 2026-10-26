
/obj/item/clothing/under/suit
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/suits_digi.dmi' //Anything that was in TG's suits.dmi, should be in our suits_digi.dmi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/suit/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/suits.dmi'

//DO NOT ADD A /obj/item/clothing/under/rank/civilian/lawyer/skyrat. USE /obj/item/clothing/under/suit/skyrat FOR MODULAR SUITS

/*
*	RECOLORABLE
*/
/obj/item/clothing/under/suit/skyrat/recolorable
	name = "可改色西装"
	desc = "一件半正式西装，剪裁利落，配同色马甲和长裤。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/suit/skyrat/recolorable"
	post_init_icon_state = "recolorable_suit"
	can_adjust = FALSE
	greyscale_config = /datum/greyscale_config/recolorable_suit
	greyscale_config_worn = /datum/greyscale_config/recolorable_suit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/recolorable_suit/worn/digi
	greyscale_colors = "#a99780#ffffff#6e2727#ffc500"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/suit/skyrat/recolorable/skirt
	name = "可改色西装裙"
	desc = "一件半正式西装裙，剪裁利落，配同色马甲和裙子。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/suit/skyrat/recolorable/skirt"
	post_init_icon_state = "recolorable_suitskirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE
	body_parts_covered = CHEST|GROIN|LEGS
	greyscale_config = /datum/greyscale_config/recolorable_suitskirt
	greyscale_config_worn = /datum/greyscale_config/recolorable_suitskirt/worn
	greyscale_config_worn_digi = /datum/greyscale_config/recolorable_suitskirt/worn/digi

/*
*	SUITS
*/
/obj/item/clothing/under/suit/skyrat/pencil
	name = "黑色铅笔裙"
	desc = "一件干净的白色衬衫配一条紧身黑色铅笔裙。"
	icon_state = "black_pencil"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/suit/skyrat/pencil/black_really
	name = "高管铅笔裙"
	desc = "一套流线型西装，配一条紧身黑色铅笔裙。"
	icon_state = "really_black_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/charcoal
	name = "炭灰色铅笔裙"
	desc = "一件干净的白色衬衫配一条紧身炭灰色铅笔裙。"
	icon_state = "charcoal_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/navy
	name = "藏青色铅笔裙"
	desc = "一件干净的白色衬衫配一条紧身藏青色铅笔裙。"
	icon_state = "navy_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/burgandy
	name = "酒红色铅笔裙"
	desc = "一件干净的白色衬衫配一条紧身酒红色铅笔裙。"
	icon_state = "burgandy_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/checkered
	name = "格纹铅笔裙"
	desc = "一件干净的白色衬衫配一条紧身灰色格纹铅笔裙。"
	icon_state = "checkered_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/tan
	name = "棕褐色铅笔裙"
	desc = "一件干净的白色衬衫配一条紧身棕褐色铅笔裙。"
	icon_state = "tan_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/green
	name = "绿色铅笔裙"
	desc = "一件干净的白色衬衫配一条紧身绿色铅笔裙。"
	icon_state = "green_pencil"

/obj/item/clothing/under/suit/skyrat/scarface
	name = "古巴西装"
	desc = "一套雪白的丝绸西装，配一件绯红衬衫。你就是懂得怎么藏，怎么撒谎。而我，我没这问题。我永远说真话。就算撒谎的时候也是。"
	icon_state = "scarface"

/obj/item/clothing/under/suit/skyrat/black_really_collared
	name = "宽领高管西装"
	desc = "一套正式的黑色西装，领口敞开得很宽，专为站上最优秀的人士准备。"
	icon_state = "really_black_suit_collar"

/obj/item/clothing/under/suit/skyrat/black_really_collared/skirt
	name = "宽领高管西装裙"
	desc = "一套正式的黑色西装，领口敞开得很宽，专为站上最优秀的人士准备。"
	icon_state = "really_black_suit_skirt_collar"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY|FEMALE_UNIFORM_NO_BREASTS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/suit/skyrat/inferno
	name = "炼狱西装"
	desc = "时髦得足以让魔鬼都为之倾倒。"
	icon_state = "lucifer"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	obj_flags = UNIQUE_RENAME

/obj/item/clothing/under/suit/skyrat/inferno/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/inferno_suit)

/datum/atom_skin/inferno_suit
	abstract_type = /datum/atom_skin/inferno_suit

/datum/atom_skin/inferno_suit/pride
	preview_name = "傲慢"
	new_icon_state = "lucifer"

/datum/atom_skin/inferno_suit/wrath
	preview_name = "暴怒"
	new_icon_state = "justice"

/datum/atom_skin/inferno_suit/gluttony
	preview_name = "暴食"
	new_icon_state = "malina"

/datum/atom_skin/inferno_suit/envy
	preview_name = "嫉妒"
	new_icon_state = "zdara"

/datum/atom_skin/inferno_suit/vanity
	preview_name = "虚荣"
	new_icon_state = "cereberus"

/obj/item/clothing/under/suit/skyrat/inferno/skirt
	name = "炼狱西装裙"
	icon_state = "modeus"
	obj_flags = UNIQUE_RENAME

/obj/item/clothing/under/suit/skyrat/inferno/skirt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/inferno_suitskirt)

/datum/atom_skin/inferno_suitskirt
	abstract_type = /datum/atom_skin/inferno_suitskirt

/datum/atom_skin/inferno_suitskirt/lust
	preview_name = "色欲"
	new_icon_state = "modeus"

/datum/atom_skin/inferno_suitskirt/sloth
	preview_name = "懒惰"
	new_icon_state = "pande"

/obj/item/clothing/under/suit/skyrat/inferno/beeze
	name = "名牌炼狱西装"
	desc = "一件华丽的燕尾西装，胸前缀着一个蓬松的蝴蝶结，还配有一枚纳米传讯别针。"
	icon_state = "beeze"
	obj_flags = null

/obj/item/clothing/under/suit/skyrat/inferno/beeze/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/suit/skyrat/helltaker
	name = "红衬衫配白长裤"
	desc = "没空。正忙着收集女孩。"
	icon_state = "helltaker"

/obj/item/clothing/under/suit/skyrat/helltaker/skirt
	name = "红衬衫配白短裙"
	desc = "没空。正忙着收集男孩。"
	icon_state = "helltakerskirt"
