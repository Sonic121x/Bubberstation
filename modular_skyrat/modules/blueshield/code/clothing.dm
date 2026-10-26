//Blueshield

//Uniform items are in command.dm

/obj/item/clothing/gloves/tackler/combat/insulated/blueshield
	name = "战斗手套"
	desc = "这副战术手套看上去独一无二，由双重编织的耐久纤维制成，因此既防火又耐酸。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	icon_state = "combat"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	resistance_flags = FIRE_PROOF |  ACID_PROOF
	armor_type = /datum/armor/insulated_blueshield

/datum/armor/insulated_blueshield
	fire = 100
	acid = 100

/obj/item/radio/headset/headset_bs
	name = "\proper 蓝盾的耳机"
	icon = 'modular_skyrat/modules/blueshield/icons/radio.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/ears.dmi'
	icon_state = "bshield_headset"
	worn_icon_state = "bshield_headset"
	keyslot = /obj/item/encryptionkey/heads/blueshield
	keyslot2 = /obj/item/encryptionkey/headset_cent

/obj/item/radio/headset/headset_bs/alt
	icon_state = "bshield_headset_alt"
	worn_icon_state = "bshield_headset_alt"

/obj/item/radio/headset/headset_bs/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))


/obj/item/clothing/head/helmet/space/plasmaman/blueshield
	name = "蓝盾等离子防护头盔"
	desc = "专为认证蓝盾设计的等离子防护头盔，毕竟保护主管的工作不该包含自燃……大多数时候不该。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/plasmaman_hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/plasmaman_head.dmi'
	icon_state = "bs_envirohelm"
	armor_type = /datum/armor/head_helmet/plasmaman/blueshield

/datum/armor/head_helmet/plasmaman/blueshield
	acid = 90

/obj/item/clothing/under/plasmaman/blueshield
	name = "蓝盾等离子环境服"
	desc = "专为认证蓝盾设计的等离子环境服，能提供少量额外防护。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/plasmaman.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/plasmaman.dmi'
	icon_state = "bs_envirosuit"
	armor_type = /datum/armor/clothing_under/under_plasmaman_blueshield
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/datum/armor/clothing_under/under_plasmaman_blueshield
	melee = 10
	laser = 10
	bomb = 5
	bio = 100
	fire = 95
	acid = 95

/obj/item/clothing/head/beret/blueshield
	name = "蓝盾贝雷帽"
	desc = "一顶耐久纤维制成的蓝色贝雷帽，镶着正品金色徽章，表明佩戴者是蓝盾中尉。它似乎衬有纳米凯夫拉，比标准的加固贝雷帽更结实。"
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/blueshield"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#3A4E7D#DEB63D"
	//alternate_worn_icon_digi = 'modular_skyrat/icons/mob/head_muzzled.dmi'
	post_init_icon_state = "beret_badge_police"
	armor_type = /datum/armor/head_helmet/blueshield
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/datum/armor/head_helmet/blueshield
	fire = 75
	acid = 75

/obj/item/clothing/head/beret/blueshield/navy
	name = "藏青蓝盾贝雷帽"
	desc = "一顶耐久纤维制成的海军蓝贝雷帽，镶着银色徽章，表明佩戴者是蓝盾中尉。它似乎衬有纳米凯夫拉，比标准的加固贝雷帽更结实。"
	icon_state = "/obj/item/clothing/head/beret/blueshield/navy"
	greyscale_colors = "#3C485A#BBBBBB"

/obj/item/storage/backpack/blueshield
	name = "蓝盾背包"
	desc = "结实的背包，配发给纳米传讯最优秀的成员。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "backpack_blueshield"
	inhand_icon_state = "backpack_blueshield"

/obj/item/storage/backpack/satchel/blueshield
	name = "蓝盾挎包"
	desc = "结实的挎包，配发给纳米传讯最优秀的成员。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "satchel_blueshield"
	inhand_icon_state = "satchel_blueshield"

/obj/item/storage/backpack/duffelbag/blueshield
	name = "蓝盾行李袋"
	desc = "结实的行李袋，配发给纳米传讯最优秀的成员。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "duffel_blueshield"
	inhand_icon_state = "duffel_blueshield"

//blueshield armor
/obj/item/clothing/suit/armor/vest/blueshield
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	name = "蓝盾护甲"
	desc = "一件贴身的凯夫拉衬里背心，胸口缀着一枚蓝色徽章。"
	icon_state = "blueshieldarmor"
	body_parts_covered = CHEST
	armor_type = /datum/armor/suit_armor/blueshield

/obj/item/clothing/suit/armor/vest/blueshield/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/blueshield_armor)

/datum/atom_skin/blueshield_armor
	abstract_type = /datum/atom_skin/blueshield_armor

/datum/atom_skin/blueshield_armor/slim
	preview_name = "修身"
	new_icon_state = "blueshieldarmor"

/datum/atom_skin/blueshield_armor/marine
	preview_name = "陆战"
	new_icon_state = "bs_marine"

/datum/atom_skin/blueshield_armor/bulky
	preview_name = "厚重"
	new_icon_state = "vest_black"

/datum/armor/suit_armor/blueshield
	bomb = 30
	fire = 75
	acid = 75

/obj/item/clothing/suit/armor/vest/blueshield/jacket
	name = "蓝盾夹克"
	desc = "一件昂贵的凯夫拉衬里夹克，胸口缀着金色徽章，背后印着“NT”字样。它看起来沉甸甸的，实际却出奇地轻。"
	icon_state = "blueshield"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/blueshield/jacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/suit/hooded/wintercoat/skyrat/blueshield
	name = "蓝盾冬季大衣"
	icon_state = "coatblueshield"
	desc = "一件舒适的凯夫拉衬里大衣，带蓝色高光，既能为蓝盾提供护甲，也能保暖。"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/skyrat/blueshield
	allowed = list(/obj/item/melee/baton/security/loaded)
	armor_type = /datum/armor/suit_armor/blueshield

/obj/item/clothing/suit/hooded/wintercoat/skyrat/blueshield/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/head/hooded/winterhood/skyrat/blueshield
	icon_state = "hood_blueshield"
	desc = "一件舒适的凯夫拉衬里兜帽，与那件舒适的凯夫拉衬里大衣相配。"
	armor_type = /datum/armor/suit_armor/blueshield
