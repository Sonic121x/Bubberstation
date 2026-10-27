/datum/mod_theme/contractor
	name = "承包商"
	desc = "由赛博太阳工业与戈尔莱克斯掠夺者合作开发的顶级 MOD 外骨骼，辛迪加承包商的最爱。"
	extended_desc = "承包商 MOD 外骨骼一改辛迪加惯用的配色方案，专为\
		特色承包商生产制造。其结构是流线型分层，由成型塑钛\
		与复合陶瓷组成，内衬则采用轻质凯夫拉与耐久纤维混纺织物，\
		在装甲板覆盖不到的地方为使用者提供充分防护，并配有非法的机载电动\
		烧蚀护盾模块，可抵御常规能量枪械。\
		此外，它还内置变色龙系统，可在未展开状态下伪装整套外骨骼。\
		上面挂着一张小标签，写着：“戈尔莱克斯掠夺者财产，由赛博太阳工业协助制造。\
		保留所有权利，擅自拆改套装将导致保修失效。”"
	default_skin = "contractor"
	armor_type = /datum/armor/mod_theme_contractor
	resistance_flags = FIRE_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_deployed = 0
	ui_theme = "syndicate"
	inbuilt_modules = list(/obj/item/mod/module/chameleon/contractor)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/melee/energy/sword,
		/obj/item/shield/energy,
	)
	variants = list(
		"contractor" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/contractor/icons/modsuit.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/contractor/icons/worn_modsuit.dmi',
			HELMET_LAYER = NECK_LAYER,
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
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

/datum/armor/mod_theme_contractor
	melee = 35
	bullet = 40
	laser = 35
	energy = 35
	bomb = 35
	bio = 100
	fire = 80
	acid = 90
	wound = 25
