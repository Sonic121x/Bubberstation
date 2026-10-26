// Its modsuiting time

/datum/mod_theme/frontier_colonist
	name = "边疆危害防护"
	desc = "一种设计奇特的套装，实际上不过是一层纤薄的内衬，附带内置外套与密封头盔。"
	extended_desc = "边疆廉价科技的巅峰之作。这类套装的样式通常并不统一，\
		但在基础设施欠佳的边疆定居点却很常见。与大多数非官方\
		设计一样，它们存在缺陷，没有一件是完美的，但它们达成了唯一的目标，这才是\
		关键所在。此类套装专为罕见紧急情况而造，那种情况会形成其他装备\
		难以应付的危险环境。通常，这类套装不仅能保护使用者\
		免受电流伤害，还能抵御辐射、生物危害、他人等等。不过，\
		这套装备并不能保护你免受你自己之害。"

	default_skin = "colonist"
	armor_type = /datum/armor/colonist_hazard
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY - 3
	charge_drain = DEFAULT_CHARGE_DRAIN * 2
	slowdown_deployed = 1
	inbuilt_modules = list(
		/obj/item/mod/module/joint_torsion/permanent
	)
	allowed_suit_storage = list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/flashlight,
		/obj/item/gun,
		/obj/item/melee,
		/obj/item/tank/internals,
		/obj/item/storage/belt/holster,
		/obj/item/construction,
		/obj/item/fireaxe,
		/obj/item/pipe_dispenser,
		/obj/item/storage/bag,
		/obj/item/pickaxe,
		/obj/item/resonator,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/storage/medkit,
	)
	variants = list(
		"colonist" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/kahraman_equipment/icons/modsuits/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/kahraman_equipment/icons/modsuits/mod_worn.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
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

/obj/item/mod/control/pre_equipped/frontier_colonist
	theme = /datum/mod_theme/frontier_colonist
	applied_cell = /obj/item/stock_parts/power_store/cell/high
	applied_modules = list(
		/obj/item/mod/module/welding,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/status_readout,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/storage,
	)
	default_pins = list(
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/thermal_regulator,
	)

/obj/item/mod/control/pre_equipped/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Joint torsion module that can't be removed and has no complexity

/obj/item/mod/module/joint_torsion/permanent
	removable = FALSE
	complexity = 0
