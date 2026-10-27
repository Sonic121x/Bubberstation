/datum/mod_theme/frontline
	name = "前线"
	desc = "泛斯拉夫联邦国防委员会的防护服，专为坚固阵地作战和人道援助设计。"
	extended_desc = "由当时的新俄罗斯帝国创新委员会与阿古尔卡尔研究人员合作研制，\
	是老旧旭日动力装甲更便宜、用途更广的替代品。它以凯夫拉衬底薄钛板代替聚脲涂层、耐久纤维衬里的塑钢板，使其更轻巧紧凑，\
	也为其他模块留出空间；但缺少能量耗散系统，使使用者更容易受到常规激光武器伤害。\
	内置的弹道与弹药辅助计算机会提示更好的瞄准位置，并告知使用者\
	手中武器及其弹匣的剩余弹药。此功能相当耗电，因此这套装甲很少用于坚固阵地或人道任务之外的场合，\
	也成为军方所能提供的有限善意与援助的象征。不过许多穿过这套MOD的人都称它“非常不舒服”，\
	主要原因是缺乏完善的环境调节系统。但凭借其防护能力、庞大产量和低廉价格，它很快成为泛斯拉夫联邦国防委员会的主力装甲系统。"
	default_skin = "frontline"
	armor_type = /datum/armor/mod_theme_frontline
	complexity_max = DEFAULT_MAX_COMPLEXITY
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
		"frontline" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/wornmod.dmi',
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

/datum/armor/mod_theme_frontline
	melee = 50
	bullet = 60
	laser = 40
	energy = 50
	bomb = 60
	bio = 100
	fire = 50
	acid = 80
	wound = 25

/obj/item/mod/control/pre_equipped/frontline
	theme = /datum/mod_theme/frontline
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/flashlight,
	)

/obj/item/mod/control/pre_equipped/frontline/ert
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/auto_doc,
		/obj/item/mod/module/visor/thermal,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot/advanced,
	)
	default_pins = list(
		/obj/item/mod/module/visor/thermal,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot/advanced,
	)


/datum/mod_theme/frontline/surplus
	name = "军剩前线"
	activation_step_time = MOD_ACTIVATION_STEP_TIME + 3
	desc = "泛斯拉夫联邦国防委员会的防护服，专为坚固阵地作战和人道援助设计。这一套看起来相当陈旧磨损。"
	extended_desc = "泛斯拉夫联邦国防委员会的防护服，专为坚固阵地作战和人道援助设计。\
		这一套购自拍卖会，战斗规格模块已被拆除，\
		但仍很适合军火走私者和私人安保部队使用。\
		不过，它的内部系统已经老化，部分烧蚀装甲板也被拆掉了。"
	armor_type = /datum/armor/mod_theme_frontline/surplus

/datum/mod_theme/frontline/surplus/set_skin(obj/item/mod/control/mod, skin)
	. = ..()
	mod.set_mod_color("#888888", FIXED_COLOUR_PRIORITY)

/datum/armor/mod_theme_frontline/surplus
	melee = 30
	bullet = 40
	laser = 15
	energy = 15
	bomb = 30
	wound = 10

/datum/mod_theme/frontline/surplus/New()
	allowed_suit_storage -= /obj/item/shield/riot
	. = ..()

/obj/item/mod/control/pre_equipped/frontline/surplus
	theme = /datum/mod_theme/frontline/surplus
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/flashlight,
	)

/datum/supply_pack/imports/surplus_nri_modsuit
	name = "军剩战斗MOD模块化外骨骼箱"
	desc = "一箱单套军剩MOD模块化外骨骼，\
		原为泛斯拉夫联邦国防委员会设计。\
		其战斗模块已被拆除，但对于需要防护和机动性的人来说仍是不错的装备。\
		值得一提的是，它不使用也不需要装甲模块。"
	cost = CARGO_CRATE_VALUE * 22
	contains = list(/obj/item/mod/control/pre_equipped/frontline/surplus)
	order_flags = ORDER_CONTRABAND

/datum/mod_theme/policing
	name = "警务"
	desc = "泛斯拉夫联邦内务委员会的通用防护服，专为核心世界巡逻设计。"
	extended_desc = "一款外包给阿帕达因科技制造、随后由相应帝国警区改装为边疆用途的MOD模块化外骨骼，\
		设计重点是安抚惊慌的平民，而非投入实战。薄塑钛装甲板能够抵御环境和弹丸威胁，\
		内置的微型能量再分配系统也能提供一些能量武器防护，尽管效果不佳。\
		当地警方的改装为四肢增加了装甲，代价是更高的系统负载。"
	default_skin = "policing"
	armor_type = /datum/armor/mod_theme_policing
	complexity_max = DEFAULT_MAX_COMPLEXITY - 1
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.25
	slowdown_deployed = 0.5
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
		"policing" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/wornmod.dmi',
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

/datum/armor/mod_theme_policing
	melee = 40
	bullet = 50
	laser = 30
	energy = 30
	bomb = 60
	bio = 100
	fire = 75
	acid = 75
	wound = 20

/obj/item/mod/control/pre_equipped/policing
	theme = /datum/mod_theme/policing
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/paper_dispenser,
		/obj/item/mod/module/magnetic_harness
	)
	default_pins = list(
		/obj/item/mod/module/tether,
		/obj/item/mod/module/magboot,
	)

///Unrelated-to-Spider-Clan version of the module.
/obj/item/mod/module/status_readout/operational
	name = "MOD作战状态显示模块"
	desc = "一种曾经很常见的模块，可惜这项技术在较安全的星域已不再流行；\
		但在其他地方仍被广泛使用。这个装置连接到外骨骼的背部脊柱，\
		能够采集并显示穿戴者的各种生物特征数据：睡眠、营养、体能、指纹，\
		甚至包括总体健康状况等有用的信息。生命体征监测器还配有足够响亮的扬声器，\
		能让附近所有人知道确实有人死亡。这一型号还带有时钟和作战身份显示功能。"
	display_time = TRUE
	death_sound = 'modular_skyrat/modules/novaya_ert/sound/flatline.ogg'
	removable = TRUE
