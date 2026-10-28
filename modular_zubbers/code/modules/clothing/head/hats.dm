/obj/item/clothing/head/soft/allamerican
	name = "全美餐馆员工帽"
	desc = "一顶鲑鱼色的棒球帽，全美餐馆的员工都会戴。你可以在帽子正面看到餐馆的名字，好让你知道自己身在何处。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "allamericansoft"
	soft_type = "allamerican"
	dog_fashion = null

/obj/item/clothing/head/soft/galfedcap
	name = "银河联邦帽"
	desc = "一顶正面印有银河联邦标志的帽子，蓝色调很好看。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "galfedsoft"
	soft_type = "galfed"
	dog_fashion = null

/obj/item/clothing/head/peacekeeperberet
	name = "维和者贝雷帽"
	desc = "一件来自过去的遗物。它作为时尚帽子的效果从未受到质疑。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "unberet"
	dog_fashion = null

/obj/item/clothing/head/beret/lizardgas
	name = "蜥蜴燃气资深员工贝雷帽"
	desc = "一顶授予在蜥蜴燃气品牌旗下任职满一年或更久的团队成员的贝雷帽！他们的周年纪念日肯定会举办披萨派对。"
	icon_state = "/obj/item/clothing/head/beret/science/rd"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#7e1980#c9cbcb"

//Ported from Kuro020 of TGMC.
/obj/item/clothing/head/bandana/snake
	name = "士兵头巾"
	desc = "<i>她的</i>头巾，从尼加拉瓜湖中打捞上来，并被用心修补过。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "headband_snake"

/obj/item/clothing/head/bandana/snake/sec
	name = "装甲头巾"
	desc = "十年来，我们同生共死。你根本不可能理解。"
	armor_type = /datum/armor/cosmetic_sec

//virosec hats
/obj/item/clothing/head/sec/viro
	name = "安保软帽"
	desc = "一顶软帽，让安保人员在整天戴头盔之后，脖子能少受点罪。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "secsoft_v"
	armor_type = /datum/armor/cosmetic_sec

/datum/greyscale_component_style/security_cap
	output_icon_state = "security_cap"
	fallback_icon_state = "security_cap"
	default_accessories = list("security_cap_accs_front", "security_cap_accs_logo")
	core_components = list(
		list(
			"name" = "帽身",
			"key" = "cap",
			"default" = "security",
			"options" = list(
				"security" = list(
					"name" = "安保帽",
					"state" = "security_cap",
					"color_id" = 1,
					"color_label" = "主色",
					"default_color" = "#A53429",
				),
			),
		),
	)
	accessories = list(
		"Backing" = list(
			"state" = "security_cap_accs_front",
			"color_id" = 2,
			"color_label" = "衬垫",
			"default_color" = "#3F6E9E",
		),
		"Logo" = list(
			"state" = "security_cap_accs_logo",
			"color_id" = 3,
			"color_label" = "徽标",
			"default_color" = "#FFFFFF",
		),
	)

/obj/item/clothing/head/soft/sec/recolorable
	name = "安保帽"
	desc = "一顶结实的棒球帽，这一顶似乎是定制的。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "security_cap"
	post_init_icon_state = "security_cap"
	soft_type = "security_cap"
	soft_suffix = ""
	greyscale_config = /datum/greyscale_config/security_cap
	greyscale_config_worn = /datum/greyscale_config/security_cap/worn
	greyscale_colors = "#A53429#3F6E9E#FFFFFF"
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1
	greyscale_component_style_type = /datum/greyscale_component_style/security_cap
	greyscale_component_icon_file = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	greyscale_component_worn_icon_file = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	greyscale_component_worn_state_overrides = list(
		"security_cap" = "security_capg",
		"security_cap_accs_front" = "security_capg_accs_backing",
		"security_cap_accs_logo" = "security_capg_accs_logo",
	)
	greyscale_component_accessories = list("security_cap_accs_front", "security_cap_accs_logo")

/obj/item/clothing/head/soft/sec/recolorable/Initialize(mapload)
	initialize_greyscale_component_style()
	return ..()

/obj/item/clothing/head/soft/sec/recolorable/update_greyscale()
	. = ..()
	update_greyscale_component_icons()

/obj/item/clothing/head/soft/sec/recolorable/flip(mob/user)
	balloon_alert(user, "无法翻转！")

/obj/item/clothing/head/sec/viro/beanie
	name = "安保针织帽"
	desc = "一顶用于安保工作的针织帽"
	icon_state = "security_beanie"
	armor_type = /datum/armor/cosmetic_sec

/obj/item/clothing/head/costume/mailman
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/costume_teshari.dmi'

/obj/item/clothing/head/fedora/det_hat
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'

/obj/item/clothing/head/hats/caphat
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'

/obj/item/clothing/head/nanotrasen_consultant
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'

/obj/item/clothing/head/hats/hopcap
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'

/obj/item/clothing/head/hats/warden/red
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'

/obj/item/clothing/head/small_bow
	greyscale_config_worn_teshari = /datum/greyscale_config/small_bow/worn/teshari

/obj/item/clothing/head/large_bow
	greyscale_config_worn_teshari = /datum/greyscale_config/large_bow/worn/teshari

/obj/item/clothing/head/back_bow
	greyscale_config_worn_teshari = /datum/greyscale_config/back_bow/worn/teshari

/obj/item/clothing/head/sweet_bow
	greyscale_config_worn_teshari = /datum/greyscale_config/sweet_bow/worn/teshari

/obj/item/clothing/head/costume/jesteralt
	greyscale_config_worn_teshari = /datum/greyscale_config/jester_hat_alt/worn/teshari

/obj/item/clothing/head/soft/propeller_hat
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'
