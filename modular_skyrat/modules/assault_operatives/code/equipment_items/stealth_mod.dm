/datum/mod_theme/covert
	name = "隐秘"
	desc = "一种罕见的 MOD 设计，来源不明，覆盖着光滑的装甲，面罩坚固得令人不安。"
	extended_desc = "关于这种套装，人们所知甚少，大多数见到它的人都称之为“隐秘”型。 \
		它的结构是流线型的分层设计，由成型塑钛与复合陶瓷组成，而内衬则是 \
		轻量凯夫拉与耐久纤维混纺织物，在装甲板未覆盖之处为用户提供充分防护； \
		此外还非法内置了一套电力驱动的烧蚀护盾模块，以抵御常规能量枪械。 \
		另外，它还有内置的变色龙系统，让你能在未展开状态下伪装这套套装。 \
		除此之外，找不到任何制造商标记或标签，甚至其配色方案对大多数 \
		已知的 MOD 制造商来说也相当陌生。"
	default_skin = "stealth"
	armor_type = /datum/armor/mod_theme_covert
	resistance_flags = FIRE_PROOF | ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY + 5
	slowdown_deployed = 0
	ui_theme = "hackerman"
	slot_flags = ITEM_SLOT_BELT
	inbuilt_modules = list(
		/obj/item/mod/module/storage/belt,
		/obj/item/mod/module/chameleon/contractor,
		/obj/item/mod/module/welding/camera_vision,
		/obj/item/mod/module/stealth,
	)
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
		"stealth" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/assault_operatives/icons/modsuits/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/assault_operatives/icons/modsuits/wornmod.dmi',
			HELMET_LAYER = NECK_LAYER,
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
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

/datum/armor/mod_theme_covert
	melee = 30
	bullet = 50
	laser = 40
	energy = 30
	bomb = 30
	bio = 30
	fire = 100
	acid = 100
	wound = 25

/obj/item/mod/control/pre_equipped/stealth_operative
	worn_icon = 'modular_skyrat/modules/assault_operatives/icons/modsuits/wornmod.dmi'
	icon = 'modular_skyrat/modules/assault_operatives/icons/modsuits/mod.dmi'
	icon_state = "stealth-control"
	theme = /datum/mod_theme/covert
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/visor/night,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/holster,
	)

/obj/machinery/suit_storage_unit/industrial/assault_operative
	mod_type = /obj/item/mod/control/pre_equipped/stealth_operative
	storage_type = /obj/item/tank/internals/emergency_oxygen/double
