/datum/mod_theme/blueshield
	name = "禁卫"
	desc = "配发给站内蓝盾的巨头级套装原型，至今仍具备堪比仪仗卫队的卓越防护。"
	extended_desc = "配发给站内蓝盾使用的巨头级套装原型，\
		它拥有与后继型号同样卓越的防护性能，代价是牺牲了一部分模块容量。\
		巨头级的全部防护，舒适度一点也没有！面甲用蓝光遮住\
		佩戴者的面容，使它看上去更加威压逼人。与后来那套流畅奢华的\
		设计相比，这套套装毫不掩饰自己的用途：绝缘内衬护甲之上\
		层层叠加的加固装甲板，为它提供对腐蚀性液体、爆炸冲击、\
		火焰、电击以及其余船员轻蔑目光的防护。"

	default_skin = "praetorian"
	armor_type = /datum/armor/mod_theme_blueshield
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY
	slowdown_deployed = 0.25
	allowed_suit_storage = list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
	)
	variants = list(
		"praetorian" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/blueshield/icons/praetorian.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/blueshield/icons/worn_praetorian.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
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

/datum/armor/mod_theme_blueshield
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 50
	bio = 100
	fire = 100
	acid = 100
	wound = 20
