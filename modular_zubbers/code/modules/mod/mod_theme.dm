/datum/mod_theme/asset_protection
	name = "资产保护"
	desc = "伪典 MOD 外骨骼的弱化版本，主要由纳米传讯资产保护部使用。"
	extended_desc = "一种为纳米传讯资产保护部打造的伪典 MOD 外骨骼弱化版。这套外骨骼拥有更高的速度与先进的促动器，让移动几乎毫无重量感，并配备供老练保镖使用的先进功能。"
	default_skin = "asset_protection"
	armor_type = /datum/armor/mod_theme_ap
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_deployed = 0
	allowed_suit_storage = list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
	)
	variants = list(
		"asset_protection" = list(
			MOD_ICON_OVERRIDE = 'modular_zubbers/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_zubbers/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),

	)

/datum/armor/mod_theme_ap
	melee = 50
	bullet = 40
	laser = 50
	energy = 50
	bomb = 50
	bio = 100
	fire = 100
	acid = 100
	wound = 15

/datum/mod_theme/asset_protection/set_skin(obj/item/mod/control/mod, skin)
	. = ..()
	var/parts = mod.get_parts()
	for(var/obj/item/part as anything in parts + mod)
		part.worn_icon_digi = 'modular_zubbers/icons/mob/clothing/modsuit/mod.dmi'

/datum/mod_theme/mining/New()
	variants += list(
		"imp" = list(
			MOD_ICON_OVERRIDE = 'modular_zubbers/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_zubbers/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR|HIDESNOUT,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEYES|HIDEFACE,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)
	. = ..()

#define LUSTWISH_HELMET_SEAL "滑拢闭合"
#define LUSTWISH_HELMET_UNSEAL "滑开"
#define LUSTWISH_CHESTPLATE_SEAL "紧紧贴合住你的身体"
#define LUSTWISH_CHESTPLATE_UNSEAL "自行松开"
#define LUSTWISH_GAUNTLET_SEAL "在每根手指之间收紧"
#define LUSTWISH_GAUNTLET_UNSEAL "从你的手上松弛下来"
#define LUSTWISH_BOOT_SEAL "紧紧勒住你的脚踝"
#define LUSTWISH_BOOT_UNSEAL "给你的双脚让出空间"

//// Sprites done by Toriate - Commissioned by The Sharkenning
/datum/mod_theme/lustwish
	name = "欲愿"
	desc = "一款特别设计的欲愿主题 MOD 外骨骼，完全以早期民用 MOD 外骨骼为基础。"
	default_skin = "lustwish"
	hardlight_color = ROYAL_PURPLE
	ui_theme = "ntos_darkmode"
	variants = list(
		"lustwish" = list(
			MOD_ICON_OVERRIDE = 'modular_zubbers/icons/obj/clothing/modsuit/mod_lustwish.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_zubbers/icons/mob/clothing/modsuit/mod_lustwish.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = LUSTWISH_HELMET_UNSEAL,
				SEALED_MESSAGE = LUSTWISH_HELMET_SEAL,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = LUSTWISH_CHESTPLATE_UNSEAL,
				SEALED_MESSAGE = LUSTWISH_CHESTPLATE_SEAL,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = LUSTWISH_GAUNTLET_UNSEAL,
				SEALED_MESSAGE = LUSTWISH_GAUNTLET_SEAL,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = LUSTWISH_BOOT_UNSEAL,
				SEALED_MESSAGE = LUSTWISH_BOOT_SEAL,
			),
		),
	)

#undef LUSTWISH_HELMET_SEAL
#undef LUSTWISH_HELMET_UNSEAL
#undef LUSTWISH_CHESTPLATE_SEAL
#undef LUSTWISH_CHESTPLATE_UNSEAL
#undef LUSTWISH_GAUNTLET_SEAL
#undef LUSTWISH_GAUNTLET_UNSEAL
#undef LUSTWISH_BOOT_SEAL
#undef LUSTWISH_BOOT_UNSEAL

// VOSKHOD MOD, ported from Nova. By Vinylspiders

/datum/mod_theme/voskhod
	name = "改装型 VOSKHOD"
	desc = "一套经过升级的老旧 VOSKHOD 装甲，已提升至更现代的 MOD 模块化标准。"
	extended_desc = "虽然模块化外骨骼在泛斯拉夫联邦境内仍较为少见，但 CIN 内部的许多成员国都需要将老旧的 VOSKHOD 套装改装成更现代的东西。此套件提供了这种现代化替代方案，并内置了 MOD 模块化外骨骼技术。这通常由专门的制造系统完成，但用一些稀有的售后零件套件再加上不少力气，也能达到同样的效果。"
	default_skin = "voskhod"
	armor_type = /datum/armor/mod_theme_voskhod
	complexity_max = DEFAULT_MAX_COMPLEXITY //Five of which is occupied by the in-builts, thus it's closer to 10
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.5
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/knife/combat,
		/obj/item/shield/riot,
		/obj/item/gun,
	)
	variants = list(
		"voskhod" = list(
			MOD_ICON_OVERRIDE = 'modular_zubbers/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_zubbers/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = HEAD_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_voskhod
	melee = 20
	bullet = 35
	laser = 30
	energy = 20
	bomb = 30
	bio = 30
	fire = 80
	acid = 85
	wound = 20

/datum/mod_theme/administrative
	variants = list(
		"debug" = list(
			MOD_WORN_ICON_OVERRIDE = 'modular_zubbers/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR|HIDESNOUT,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)
