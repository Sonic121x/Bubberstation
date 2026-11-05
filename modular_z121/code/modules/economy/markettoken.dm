/*Token*/
/*
*	GUN VENDOR
*/
/*
/obj/machinery/gun_vendor
	name = "武器柜"
	desc = "一坨屎一样的武器柜，给权力上瘾的人或者是脑残用的"
	icon = 'modular_z121/icons/Meme_weapons2024/obj/guns/smg.dmi'
	icon_state = "guns"
	use_power = NO_POWER_USE
	circuit = /obj/item/circuitboard/machine/gun_vendor
	max_integrity = 2000
	density = TRUE
	/// If FALSE, does not require an alert level to redeem the token.
	var/requires_alert = TRUE

/obj/item/circuitboard/machine/gun_vendor
	name = "Weapons Dispenser (Machine Board)"
	icon_state = "circuit_map"
	build_path = /obj/machinery/gun_vendor
	req_components = list(
		/datum/stock_part/matter_bin = 2,
		/obj/item/stack/sheet/plasteel = 5)

/obj/structure/gun_vendor/wrench_act(mob/living/user, obj/item/item)
	default_unfasten_wrench(user, item, 120)
	return TRUE

/obj/machinery/gun_vendor/attacked_by(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/armament_token))
		RedeemToken(I, user)
		return

/obj/machinery/gun_vendor/proc/RedeemToken(obj/item/armament_token/token, mob/redeemer)
	if((SSsecurity_level.get_current_level_as_number() < token.minimum_sec_level) && requires_alert)
		to_chat(redeemer, span_redtext("Warning, this holochip is locked to [SSsecurity_level.get_current_level_as_text()]!"))
		message_admins("ARMAMENT LOG: [redeemer] attempted to redeem a [token.name] on the incorrect security level!")
		return
	var/list/radial_build = token.get_available_gunsets()
	var/obj/item/storage/box/gunset/chosen_gunset = show_radial_menu(redeemer, src, radial_build, radius = 40)
	if(!chosen_gunset)
		return
	if(!redeemer.Adjacent(src))
		return
	if(QDELETED(token))
		return
	var/obj/item/storage/box/gunset/dispensed = new chosen_gunset(src.loc)

	if(redeemer.CanReach(src) && redeemer.put_in_hands(dispensed))
		to_chat(redeemer, span_notice("You take [dispensed] out of the slot."))
	else
		to_chat(redeemer, span_warning("[dispensed] falls onto the floor!"))
	playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)
	to_chat(redeemer, "Thank you for redeeming your token. Remember. Do NOT take lethal ammo without permission or good reasoning.")
	SSblackbox.record_feedback("tally", "armament_token_redeemed", 1, dispensed)
	qdel(token)

/obj/machinery/gun_vendor/no_alert
	requires_alert = FALSE

/*
*	TOKENS
*/

/obj/item/armament_token
	icon = 'modular_z121/icons/Meme_weapons2024/obj/guns/smg.dmi'
	icon_state = "sidearm_card"
	w_class = WEIGHT_CLASS_TINY
	var/minimum_sec_level = SEC_LEVEL_GREEN

/obj/item/armament_token/proc/get_available_gunsets()
	return FALSE

/*
*	SIDEARMS
*/

/obj/item/armament_token/sidearm
	name = "副手武器钥匙卡"
	desc = "一张可以获得一把手枪的钥匙卡，或者别的什么"
	icon_state = "sidearm_card"
	//minimum_sec_level = SEC_LEVEL_BLUE

/obj/item/armament_token/sidearm/get_available_gunsets()
	return list(
	/obj/item/storage/box/gunset/hipoint = image(
		icon = 'modular_z121/icons/Meme_weapons2024/obj/guns/smg.dmi',
		icon_state = "hipoint_show"
		),
	/obj/item/storage/box/gunset/SigP320 = image(
		icon = 'modular_z121/icons/Meme_weapons2024/obj/guns/smg.dmi',
		icon_state = "sig_show"
		),
	/obj/item/storage/box/gunset/M1911C = image(
		icon = 'modular_z121/icons/Meme_weapons2024/obj/guns/64x32.dmi',
		icon_state = "m1911_show"
		),
	/obj/item/storage/box/gunset/b92 = image(
		icon = 'modular_z121/icons/Meme_weapons2024/obj/guns/64x32.dmi',
		icon_state = "b92_show"
		),
	/obj/item/storage/box/gunset/AMT = image(
		icon = 'modular_z121/icons/Meme_weapons2024/obj/guns/64x32.dmi',
		icon_state = "AMT_show"
		),
	/obj/item/storage/box/gunset/M29 = image(
		icon = 'modular_z121/icons/Meme_weapons2024/obj/guns/pistol.dmi',
		icon_state = "police_show"
		),
	)

/*
*	PRIMARIES
*/

/obj/item/armament_token/primary
	name = "步枪钥匙卡"
	desc = "可以获得一把步枪，也可能是别的什么"
	icon_state = "rifle_card"
	//minimum_sec_level = SEC_LEVEL_AMBER

/obj/item/armament_token/primary/get_available_gunsets()
	return list(
	/obj/item/storage/box/gunset/M24 = image(
		icon = 'modular_z121/icons/Meme_weapons2024/obj/guns/smg.dmi',
		icon_state = "m24_show"
		),
	/obj/item/storage/box/gunset/AR15 = image(
		icon = 'modular_z121/icons/Meme_weapons2024/obj/guns/smg.dmi',
		icon_state = "ar15_show"
		),
	/obj/item/storage/box/gunset/MP5A = image(
		icon = 'modular_z121/icons/Meme_weapons2024/obj/guns/48x32.dmi',
		icon_state = "mp5_show"
		),
	/obj/item/storage/box/gunset/BAR = image(
		icon = 'modular_z121/icons/Meme_weapons2024/obj/guns/40x32.dmi',
		icon_state = "bar_show"
		)
	)


//Primary
/obj/item/armament_token/armor
	name = "Armor Key Card"
	desc = "A keycard used in any armament vendor, this is for armor. Do not bend."
	icon_state = "armor_card"

/obj/item/armament_token/armor/get_available_gunsets()
	return list(
	/obj/item/storage/box/gunset/heavypolice = image(
		icon = 'modular_z121/icons/Meme_weapons2024/obj/clothing/suits.dmi',
		icon_state = "heavypolice"
		),
	/obj/item/storage/box/gunset/longpolice = image(
		icon = 'modular_z121/icons/Meme_weapons2024/obj/clothing/suits.dmi',
		icon_state = "longpolice"
		)
	)

/obj/item/storage/box/armament_tokens_sidearm
	name = "Sidearm Keycards"
	//icon = 'modular_skyrat/modules/modular_weapons/icons/obj/gunsets.dmi'
	desc = "A box full of sidearm armament ketcards!"
	//icon_state = "armadyne_sidearm"
	illustration = null

/obj/item/storage/box/armament_tokens_sidearm/PopulateContents()
	. = ..()
	new /obj/item/armament_token/sidearm(src)
	new /obj/item/armament_token/sidearm(src)
	new /obj/item/armament_token/sidearm(src)

/obj/item/storage/box/armament_tokens_primary
	name = "Main Weapon Keycards"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/gunsets.dmi'
	//icon_state = "armadyne_primary"
	desc = "A box full of primary armament keycards!"
	illustration = null

/obj/item/storage/box/armament_tokens_primary/PopulateContents()
	. = ..()
	new /obj/item/armament_token/primary(src)
	new /obj/item/armament_token/primary(src)
	new /obj/item/armament_token/primary(src)
	new /obj/item/armament_token/primary(src)
	new /obj/item/armament_token/primary(src)
*/
/*
/datum/supply_pack/vending/wardrobes/securityclassic
	name = "经典安保服装贩卖机补给箱"
	desc = "This crate contains refills for the Old Nanotrasen brand SecDrobe,classic."
	cost = CARGO_CRATE_VALUE * 4
	access = ACCESS_BRIG
	access_view = ACCESS_BRIG
	contains = list(/obj/item/vending_refill/wardrobe/sec_wardrobe,
					/obj/item/vending_refill/wardrobe/det_wardrobe)
	crate_name = "classic security department supply crate"

//goodies
/datum/supply_pack/engineering/experimental_rcd
	name = "实验性RCD箱"
	desc = "Contains a single highly advanced RCD, capable of projecting its improved construction nanites at an increased range."
	access = ACCESS_ENGINE_EQUIP
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/construction/rcd/arcd)
	cost = CARGO_CRATE_VALUE * 50
	crate_name = "experimental RCD crate"
*/
/datum/supply_pack/misc/jukebox
	name = "唱片机箱"
	desc = "内有一台普通的老式点唱机。它能播放音乐！"
	cost = CARGO_CRATE_VALUE * 20
	contains = list(/obj/machinery/jukebox)
	crate_name = "点唱机箱"

/datum/supply_pack/misc/jukebox_disco
	name = "镭射舞蹈机箱"
	desc = "内有全新改进的第四代炫光舞蹈机！可播放多种音乐，同时投射绚丽的灯光秀。"
	cost = CARGO_CRATE_VALUE * 50
	contains = list(/obj/machinery/jukebox/disco)
	crate_name = "舞蹈机箱"

/datum/supply_pack/misc/bullet_drive
	name = "弹壳收集机芯片板"
	desc = "内有一块弹壳收集机电路板，不包含制作所需的部件。"
	cost = PAYCHECK_LOWER * 10
	contains = list(/obj/item/circuitboard/machine/dish_drive/bullet)
	crate_name = "弹壳收集机箱子"

/datum/supply_pack/misc/z121_liquid_pump
	name = "液泵箱"
	desc = "内有一台液体收集泵，用于快速处理泄露的液体"
	cost = PAYCHECK_LOWER * 12
	contains = list(/obj/structure/liquid_pump)
	crate_name = "液泵箱"
/*
//weapons
/datum/supply_pack/goody/dumdum38
	name = ".38 DumDum 快速装弹器独立包"
	desc = "Contains one speedloader of .38 DumDum ammunition, good for embedding in soft targets."
	cost = PAYCHECK_MEDIUM * 2
	access_view = ACCESS_BRIG
	contains = list(/obj/item/ammo_box/c38/dumdum)

/datum/supply_pack/goody/match38
	name = ".38 Match Grade 快速装弹器独立包"
	desc = "Contains one speedloader of match grade .38 ammunition, perfect for showing off trickshots."
	cost = PAYCHECK_MEDIUM * 2
	access_view = ACCESS_BRIG
	contains = list(/obj/item/ammo_box/c38/match)

/datum/supply_pack/goody/rubber
	name = ".38 Rubber 快速装弹器独立包"
	desc = "Contains one speedloader of bouncy rubber .38 ammunition, for when you want to bounce your shots off anything and everything."
	cost = PAYCHECK_MEDIUM * 1.5
	access_view = ACCESS_BRIG
	contains = list(/obj/item/ammo_box/c38/match/bouncy)

/datum/supply_pack/goody/stingbang
	name = "毒刺手雷独立包"
	desc = "Contains one \"stingbang\" grenade, perfect for playing meanhearted pranks."
	cost = PAYCHECK_COMMAND
	access_view = ACCESS_BRIG
	contains = list(/obj/item/grenade/stingbang)

/datum/supply_pack/goody/combatknives_single
	name = "战术匕首包"
	desc = "Contains one sharpened combat knive. Guaranteed to fit snugly inside any Nanotrasen-standard boot."
	cost = PAYCHECK_COMMAND
	contains = list(/obj/item/knife/combat)

/datum/supply_pack/goody/ballistic_single
	name = "战术霰弹枪包"
	desc = "For when the enemy absolutely needs to be replaced with lead. Contains one Aussec-designed Combat Shotgun, and one Shotgun Bandolier."
	cost = PAYCHECK_HARD * 15
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/gun/ballistic/shotgun/automatic/combat, /obj/item/storage/belt/bandolier)

/datum/supply_pack/goody/energy_single
	name = "能量枪包"
	desc = "Contains one energy gun, capable of firing both nonlethal and lethal blasts of light."
	cost = PAYCHECK_HARD * 12
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/gun/energy/e_gun)

/datum/supply_pack/goody/hell_single
	name = "地狱火改装件包"
	desc = "Contains one hellgun degradation kit, an old pattern of laser gun infamous for its ability to horribly disfigure targets with burns. Technically violates the Space Geneva Convention when used on humanoids."
	cost = PAYCHECK_MEDIUM * 2
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/weaponcrafting/gunkit/hellgun)

/datum/supply_pack/goody/wt550_single
	name = "WT-550自动步枪包"
	desc = "Contains one high-powered, semiautomatic rifles chambered in 4.6x30mm." // "high-powered" lol yea right
	cost = PAYCHECK_HARD * 20
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/gun/ballistic/automatic/wt550)

/datum/supply_pack/goody/wt550ammo_single
	name = "WT-550自动步枪弹药包"
	desc = "Contains a 20-round magazine for the WT-550 Auto Rifle. Each magazine is designed to facilitate rapid tactical reloads."
	cost = PAYCHECK_HARD * 6
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/ammo_box/magazine/wt550m9)

//sec
/datum/supply_pack/security/armor
	name = "经典防弹背心箱"
	desc = "Three vests of well-rounded, decently-protective armor. Requires Security access to open."
	cost = CARGO_CRATE_VALUE * 9
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/clothing/suit/armor/vest,
					/obj/item/clothing/suit/armor/vest,
					/obj/item/clothing/suit/armor/vest)
	crate_name = "classic armor crate"

/datum/supply_pack/security/disabler
	name = "镇暴光枪箱"
	desc = "Three stamina-draining disabler weapons. Requires Security access to open."
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/gun/energy/disabler,
					/obj/item/gun/energy/disabler,
					/obj/item/gun/energy/disabler)
	crate_name = "disabler crate"

/datum/supply_pack/security/baton
	name = "电棍箱"
	desc = "Arm the Civil Protection Forces with three stun batons. Batteries included. Requires Security access to open."
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security,
					/obj/item/melee/baton/security,
					/obj/item/melee/baton/security)
	crate_name = "stun baton crate"

/datum/supply_pack/security/securityclothes
	name = "经典安保服装箱"
	desc = "Contains outdated outfits for the station's private security force. Contains outfits for the Warden, Head of Security, and two Security Officers. Each outfit comes with a rank-appropriate jumpsuit, suit, and beret. Requires Security access to open."
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/clothing/under/rank/security/officer/formal,
					/obj/item/clothing/under/rank/security/officer/formal,
					/obj/item/clothing/suit/security/officer,
					/obj/item/clothing/suit/security/officer,
					/obj/item/clothing/head/beret/sec/navyofficer,
					/obj/item/clothing/head/beret/sec/navyofficer,
					/obj/item/clothing/under/rank/security/warden/formal,
					/obj/item/clothing/suit/security/warden,
					/obj/item/clothing/head/beret/sec/navywarden,
					/obj/item/clothing/under/rank/security/head_of_security/formal,
					/obj/item/clothing/suit/security/hos,
					/obj/item/clothing/head/hos/beret/navyhos
					)
	crate_name = "classic security clothing crate"

/datum/supply_pack/security/armory/energy
	name = "能量枪箱"
	desc = "Contains two Energy Guns, capable of firing both nonlethal and lethal blasts of light. Requires Armory access to open."
	cost = CARGO_CRATE_VALUE * 18
	contains = list(/obj/item/gun/energy/e_gun,
					/obj/item/gun/energy/e_gun)
	crate_name = "energy gun crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

//token

/datum/supply_pack/security/armory/sidearm_case
	name = "Box of sidearm keycards"
	desc = "a box with sidearm keycards in it"
	cost = CARGO_CRATE_VALUE * 18
	contraband = TRUE
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/box/armament_tokens_sidearm)
	crate_name = "手枪钥匙卡手提箱"

/datum/supply_pack/security/armory/primaryballistic
	name = "Box of main weapon keycards"
	desc = "a box with main weapon keycards in it"
	cost = CARGO_CRATE_VALUE * 75
	contraband = TRUE
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/box/armament_tokens_primary)
	crate_name = "实弹武器钥匙卡提箱"

/datum/supply_pack/security/armory/primaryarmor
	name = "Armor keycards"
	desc = "a box with armor keycards in it"
	cost = CARGO_CRATE_VALUE * 40
	contraband = TRUE
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/armament_token/armor,
					/obj/item/armament_token/armor,
					/obj/item/armament_token/armor,
					/obj/item/armament_token/armor,
					/obj/item/armament_token/armor,
					/obj/item/armament_token/armor
					)
	crate_name = "护甲钥匙卡箱"

/datum/supply_pack/security/armory/gun_vendor
	name = "枪械兑换机芯片"
	desc = "装有一份Armadyne枪械兑换机组装核心芯片,用于补充损坏的兑换机"
	cost = CARGO_CRATE_VALUE * 15
	contraband = TRUE
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/circuitboard/machine/gun_vendor)
	crate_name = "枪械兑换机芯片"

//Pack
/obj/item/storage/box/gunset/c96
	name = "毛瑟C96枪包"

/obj/item/gun/ballistic/automatic/pistol/c96/nomag
	spawnwithmagazine = FALSE


/obj/item/storage/box/gunset/c96/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/c96/nomag(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/ammo_box/c9mm(src)

//BlackMarket

/datum/market_item/weapon/c96
	name = "毛瑟C96手枪"
	desc = "毛瑟手枪和两个配套弹夹,附赠弹匣袋。"
	item = /obj/item/gun/ballistic/automatic/pistol/c96

	price_min = CARGO_CRATE_VALUE * 12
	price_max = CARGO_CRATE_VALUE * 16
	stock_max = 2
	availability_prob = 50

/datum/market_item/weapon/c96
	name = "温切斯特"
	desc = "没时间想介绍了，先这样吧!"
	item = /obj/item/gun/ballistic/automatic/pistol/c96

	price_min = CARGO_CRATE_VALUE * 16
	price_max = CARGO_CRATE_VALUE * 20
	stock_max = 1
	availability_prob = 50

/datum/armament_entry/company_import/donk/foamforce/darts
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 2

/datum/armament_entry/company_import/donk/foamforce/riot_darts
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 2
*/
/datum/supply_pack/critter/slugcat
	name = "蛞蝓猫箱"
	desc = "来自一颗遗落星球的生物,身体柔软且拥有一定程度的智能,\
		装有一只蛞蝓猫"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/mob/living/basic/pet/slugcat)
	crate_name = "蛞蝓猫箱"
