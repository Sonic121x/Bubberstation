/obj/item/clothing/head/hats/warden/drill/blueshield
	name = "蓝盾军帽"
	desc = "一顶典狱官军帽的变体，重新配色以搭配蓝盾。采用耐久纤维制成，以保护他们软乎乎的脑壳。内衬纳米凯夫拉，因此比标准贝雷帽更具防护性。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "bluedrill"
	armor_type = /datum/armor/suit_armor/blueshield //same as the Blueshield's default beret.

/obj/item/clothing/head/hats/warden/drill/captain
	name = "舰长军帽"
	desc = "一顶典狱官军帽的变体，供更崇尚军事化的舰长使用。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "capdrill"
	armor_type = /datum/armor/hats_caphat

/obj/item/clothing/head/hats/warden/drill/hos
	name = "安保主管军帽"
	desc = "一顶典狱官军帽的变体，供安保主管使用。终结血仇，携手合作吧。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "hosdrill"
	armor_type = /datum/armor/hats_hos

/obj/item/clothing/head/hats/warden/drill/nanotrasen
	name = "代表军帽"
	desc = "一顶典狱官军帽的变体，供更崇尚军事化的代表使用。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "repdrill"
	armor_type = /datum/armor/head_nanotrasen_consultant

//Donator request by Gavla
/obj/item/clothing/head/beret/medical/coroner
	name = "验尸官贝雷帽"
	desc = "有格调地摘取器官！"
	icon_state = "/obj/item/clothing/head/beret/medical/coroner"
	post_init_icon_state = "beret_badge_med"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#3E3E48#FFFFFF"

/obj/item/clothing/head/security_beanie
	name = "安保针织帽"
	desc = "一顶结实的针织帽，上面印有安保徽记。采用加固面料，可提供足够的防护。"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "beanie_sec"
	armor_type = /datum/armor/beanie_sec

/obj/item/clothing/head/utility/surgerycap
	flags_inv = null

/datum/armor/beanie_sec
	melee = 30
	bullet = 25
	laser = 25
	energy = 35
	bomb = 25
	fire = 20
	acid = 50
	wound = 4

/obj/item/clothing/head/utility/surgerycap
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/utility_teshari.dmi'

/obj/item/clothing/head/utility/chefhat
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/utility_teshari.dmi'
