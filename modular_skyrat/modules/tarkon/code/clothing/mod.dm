/datum/mod_theme/tarkon
	name = "tarkon"
	desc = "塔肯工业的通用防护服，专为港口安保及一般舱外活动设计。"
	extended_desc = "塔肯工业配备的第四代模块化防护服，是员工从事需要气密防护作业时的标准安全装备。它具备足以抵挡大多数塌方伤害的抗冲击能力，已经在各种有机与无机危险所导致的不可预测事故中挽救了数十名员工。"
	default_skin = "tarkon"
	armor_type = /datum/armor/mod_theme_tarkon
	complexity_max = DEFAULT_MAX_COMPLEXITY + 5
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.5
	inbuilt_modules = list(/obj/item/mod/module/magboot/advanced)
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
		"tarkon" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/tarkon/icons/obj/clothing/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/tarkon/icons/mob/clothing/mod.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = HEAD_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				UNSEALED_COVER = HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_INVISIBILITY = HIDEHAIR|HIDEEYES|HIDESNOUT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS,
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

/obj/item/mod/construction/plating/tarkon
	theme = /datum/mod_theme/tarkon
	icon = 'modular_skyrat/modules/tarkon/icons/obj/mod_construct.dmi'
	icon_state = "tarkon-plating"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
	)

/datum/armor/mod_theme_tarkon
	melee = 25
	bullet = 15
	laser = 20
	energy = 15
	bomb = 10
	bio = 100
	fire = 100
	acid = 25
	wound = 10


/obj/item/mod/control/pre_equipped/tarkon
	theme = /datum/mod_theme/tarkon
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/clamp,
		/obj/item/mod/module/tether,
	)
	default_pins = list(
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/clamp,
		/obj/item/mod/module/tether,
	)

/obj/machinery/suit_storage_unit/industrial/tarkon
	mod_type = /obj/item/mod/control/pre_equipped/tarkon

/////////// Prototype Hauler Suit


/datum/mod_theme/prototype/hauler
	name = "Prototype: Hauler"
	desc = "这套笨重的原型模块化防护服似乎经过大量改装，增加了支撑结构以分散重量。内部伺服机构也已改造，以承受额外负荷，但松散的布线迫使设计者加装了橡胶绝缘内衬。"
	inbuilt_modules = list()
	charge_drain = DEFAULT_CHARGE_DRAIN * 3
	siemens_coefficient = 0
	slowdown_deployed = 1

/obj/item/mod/control/pre_equipped/prototype/hauler
	theme = /datum/mod_theme/prototype/hauler
	req_access = list(ACCESS_TARKON)
	applied_cell = /obj/item/stock_parts/power_store/cell/high
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/clamp,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/tether,
	)

/obj/machinery/suit_storage_unit/industrial/hauler
	mod_type = /obj/item/mod/control/pre_equipped/prototype/hauler
