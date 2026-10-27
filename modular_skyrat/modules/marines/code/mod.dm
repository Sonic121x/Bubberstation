// 1 2 3 4 marine corps marine corps

/datum/mod_theme/marines
	name = "陆战队"
	desc = "由纳米传讯与多家知名承包商合作开发，这套特化套装专为高强度战斗打造。"
	extended_desc = "一套纳米传讯设计的黑蓝配色套装，供企业太空陆战队在标准装备 \
		应付不来的实战环境中使用。轻量复合装甲板包覆在 \
		坚固的外骨骼之上，确保不因防护而牺牲速度，另有多种独特的 \
		模块让穿着者在实战中保持高效。当响应小队失手时， \
		你就是后援的后援——最后的手段。"
	default_skin = "marine"
	armor_type = /datum/armor/mod_theme_marines
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	resistance_flags = FIRE_PROOF|ACID_PROOF
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_deployed = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY + 10 //drr drr drr
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/gun/ballistic,
		/obj/item/melee/breaching_hammer,
	)
	variants = list(
		"marine" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/marines/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/marines/icons/wornmod.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT|FLASH_PROTECTION_WELDER,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
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

/datum/armor/mod_theme_marines
	melee = 50
	bullet = 50
	laser = 50
	energy = 50
	bomb = 50
	bio = 100
	fire = 100
	acid = 50
	wound = 20

/obj/item/mod/control/pre_equipped/marine
	theme = /datum/mod_theme/marines
	applied_cell = /obj/item/stock_parts/power_store/cell/bluespace
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/power_kick,
		/obj/item/mod/module/megaphone,
		/obj/item/mod/module/springlock/contractor,
		/obj/item/mod/module/dna_lock, //in lieu of req_access
		/obj/item/mod/module/visor/sechud, //for identifying teammates also in suits
	)
	default_pins = list(
		/obj/item/mod/module/holster,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/power_kick,
	)

/obj/item/mod/control/pre_equipped/marine/engineer //smartgunner version of modsuit, with less versatile modules but the ALMIGHTY SMARTGUN
	theme = /datum/mod_theme/marines
	applied_cell = /obj/item/stock_parts/power_store/cell/bluespace
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/visor/sechud,
		/obj/item/mod/module/smartgun/marines,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/smartgun/marines,
	)
