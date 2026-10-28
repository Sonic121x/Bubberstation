//Modsuits used by offstation syndicate factions

//Infiltrator mod minus the Psi Emitter

/datum/mod_theme/infiltrator/persistence
	extended_desc = "多年来，关于这套隐秘的渗透者模块化套装，人们提出过不少疑问。 \
		为什么明明是潜行套装，却是血红色的？为什么偏偏是一家电影公司研发了隐形套装？ \
		最简单的答案是，瑰红银河公司雇了不少古怪的家伙，他们对 \
		视觉美学和道具设计的了解，远多于对实用特工伪装的了解。但真正的原因还要更深。 \
		这套套装的外观彰显的是赤裸裸的力量炫耀，而非真正的潜行。然而，套装内置的潜行机制 \
		能阻止任何人完全认清穿着者，只能看到套装，从而制造出完美的匿名性。 \
		这一套似乎缺少这类模块化套装通常配备的灵能发射器。"

	inbuilt_modules = list(/obj/item/mod/module/infiltrator, /obj/item/mod/module/storage/belt)
	allowed_suit_storage = list(
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/melee/energy/sword,
		/obj/item/shield/energy,
	)

//Admiral's Unique modsuit, designed around being a Cybersun modsuit and not specifically Syndicate

/obj/item/mod/control/pre_equipped/daimyo
	theme = /datum/mod_theme/daimyo
	applied_cell = /obj/item/stock_parts/power_store/cell/bluespace
	starting_frequency = MODLINK_FREQ_SYNDICATE
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/welding/syndicate,
		/obj/item/mod/module/shock_absorber,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/longfall,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/shove_blocker,
		/obj/item/mod/module/pathfinder,
		/obj/item/mod/module/night,
		/obj/item/mod/module/hat_stabilizer/syndicate,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/night,
	)

/datum/mod_theme/daimyo
	name = "大名"
	desc = "由赛博太阳工业与中村工程公司联手设计的顶尖装甲套装。"
	extended_desc = "这套外观别具一格的加强装甲 MOD 套装承袭了赛博太阳的悠久传承， \
		大名 MOD 套装由中村工程公司最顶尖的部门联手设计。它采用的先进技术 \
		由一家行事隐秘、仅以“因维克提亚研究部”为名的赛博太阳西部子公司提供。 \
		作为对伪典 MOD 套装的回应，大名 MOD 套装的整体防护较弱， \
		以便在对峙中采取更加激进的打法。只有赛博太阳的高管和 \
		高层员工才会穿戴，这套 MOD 套装象征着赛博太阳的卓越与力量。这一套经过了 \
		轻微改装，以便更好地保护穿戴者免受其所部署的熔岩地带的严酷环境。 \
		核心上挂着一枚标签，写着：“这是你一辈子接触过的最昂贵的装备， \
		绝对不要弄丢。”——鲁杰罗"
	default_skin = "daimyo"
	hardlight_color = CONTRACTOR_RED
	armor_type = /datum/armor/mod_theme_daimyo
	resistance_flags = FIRE_PROOF|ACID_PROOF|LAVA_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_deployed = 0
	ui_theme = "syndicate"
	complexity_max = DEFAULT_MAX_COMPLEXITY + 10
	hearing_protection = EAR_PROTECTION_NORMAL
	allowed_suit_storage = list(
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/melee/energy/sword,
		/obj/item/shield/energy,
	)
	variants = list(
		"daimyo" = list(
			MOD_ICON_OVERRIDE = 'modular_zubbers/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_zubbers/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS|BLOCK_GAS_SMOKE_EFFECT,
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

/datum/armor/mod_theme_daimyo
	melee = 80
	bullet = 60
	laser = 50
	energy = 60
	bomb = 100
	bio = 100
	fire = 100
	acid = 100
	wound = 25

/datum/mod_theme/daimyo/set_skin(obj/item/mod/control/mod, skin)
	. = ..()
	var/parts = mod.get_parts()
	for(var/obj/item/part as anything in parts + mod)
		part.worn_icon_digi = 'modular_zubbers/icons/mob/clothing/modsuit/mod.dmi'
