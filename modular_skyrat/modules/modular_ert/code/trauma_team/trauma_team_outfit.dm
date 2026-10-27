/datum/outfit/centcom/ert/medic/traumateam //Medical ERT Trauma Team, Admin spawn only obviously
	name = "Trauma Team"
	id = /obj/item/card/id/advanced/centcom/ert/medical/ntrauma
	uniform = /obj/item/clothing/under/rank/medical/paramedic
	suit = /obj/item/clothing/suit/space/ntrauma
	head = /obj/item/clothing/head/helmet/space/ntrauma
	glasses = /obj/item/clothing/glasses/hud/health/night
	ears = /obj/item/radio/headset/headset_cent/alt
	gloves = /obj/item/clothing/gloves/latex/nitrile/ntrauma
	l_hand = /obj/item/gun/energy/e_gun/stun
	shoes = /obj/item/clothing/shoes/combat
	belt = /obj/item/storage/belt/military/ntrauma
	back = /obj/item/storage/backpack/medic
	mask = /obj/item/clothing/mask/breath/medical
	l_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	backpack_contents = list(
		/obj/item/storage/box/survival/security,\
		/obj/item/melee/baton/security/loaded,\
		/obj/item/gun/energy/cell_loaded/medigun/upgraded,\
		/obj/item/storage/box/medicells,\
		/obj/item/storage/medkit/tactical/ntrauma,\
		)
	//Chosen cells are based off the worst things to deal with: TraumaTeam is built for worst-case scenarios, so they get a temperature cell and a better toxin cell

/datum/outfit/centcom/ert/medic/traumateam/leader //Very few differences, mostly just unique leader items - namely, a medbeam rather than a Veymed
	backpack_contents = list(
		/obj/item/storage/box/survival/security,\
		/obj/item/melee/baton/security/loaded ,\
		/obj/item/reagent_containers/hypospray/combat,\
		/obj/item/gun/medbeam,\
		/obj/item/storage/medkit/tactical/ntrauma,\
		/obj/item/emergency_bed,\
		)

/*
*	UNIQUE ITEMS
*/

//A box of VeyGun cells, because storage is hell and these take up a LOT more than they're worth.
/obj/item/storage/box/plastic/medicells
	name = "医疗电池盒"
	desc = "一盒基础医疗电池，专为 VeyMedical 的 CWM 电池驱动医疗枪设计。"
	illustration = "medgel"

/obj/item/storage/box/medicells/PopulateContents()
	. = ..()
	new /obj/item/weaponcell/medical/tier_1/brute(src)
	new /obj/item/weaponcell/medical/tier_1/burn(src)
	new /obj/item/weaponcell/medical/tier_2/toxin(src)
	new /obj/item/weaponcell/medical/utility/temperature(src)
	new /obj/item/weaponcell/medical/utility/bed(src)

/datum/id_trim/centcom/ert/medical/ntrauma
	assignment = "创伤小队专家"
	trim_state = "trim_highcleric"	//This is the CMO trim for the RPG Titles; considering its 'angelic' sprite, its fitting for these guardian angels
	sechud_icon_state = SECHUD_SCRAMBLED

/obj/item/card/id/advanced/centcom/ert/medical/ntrauma
	registered_name = "创伤小队专家"
	trim = /datum/id_trim/centcom/ert/medical/ntrauma
	icon_state = "battlecruisercaller"	//Read desc
	desc = "一张半标准黑色身份卡，上面似乎接着一个小型发射器，并与一个小圆盘相连——那大概装满了权限令牌。这确实不是纳米传讯的标准配置，但功能上等同于他们的紧急响应小队用卡。"

/obj/item/storage/belt/military/ntrauma
	name = "创伤胸挂"
	desc = "创伤响应小队佩戴的战术织带。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "ert_ntrauma"
	worn_icon_state = "ert_ntrauma"

/obj/item/storage/belt/military/ntrauma/PopulateContents()
	new /obj/item/surgical_drapes(src)
	new /obj/item/scalpel/advanced(src)
	new	/obj/item/cautery/advanced(src)
	new /obj/item/retractor/advanced(src)
	new /obj/item/healthanalyzer/advanced(src)
	new	/obj/item/reagent_containers/hypospray/combat(src)

/obj/item/storage/medkit/tactical/ntrauma
	name = "创伤医疗包"
	desc = "希望你买了保险，因为创伤小队的保费可是高得离谱。"

/obj/item/storage/medkit/tactical/ntrauma/PopulateContents()
	new /obj/item/stack/medical/wrap/gauze(src)
	new /obj/item/defibrillator/compact/combat/loaded/nanotrasen(src)
	new /obj/item/reagent_containers/applicator/patch/libital(src)
	new /obj/item/reagent_containers/applicator/patch/libital(src)
	new /obj/item/reagent_containers/applicator/patch/aiuri(src)
	new /obj/item/reagent_containers/applicator/patch/aiuri(src)
	new	/obj/item/holosign_creator/medical (src)

/obj/item/clothing/gloves/latex/nitrile/ntrauma
	name = "创伤专家手套"
	desc = "创伤小队专家使用的丁腈替代材质手套，可密封以抵御气压，并带有独特（且昂贵）的抗酸涂层，防止在处理化学危险品时受损。不过它可保护不了你身体的其他部位。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "ert_ntrauma"
	alternate_worn_layer = ABOVE_BODY_FRONT_LAYER	//So the LONG gloves can be shown off
	resistance_flags = FIRE_PROOF | ACID_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL //Combines with spacesuit

/obj/item/clothing/suit/space/ntrauma
	name = "创伤小队软式宇航服"
	desc = "一件轻量、低防护、完全无菌的软式宇航服，供创伤小队在各种潜在危险环境中作业。表面涂有抗酸化学涂层。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/spacesuit.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit_digi.dmi'
	icon_state = "ert_ntrauma"
	inhand_icon_state = "syndicate-blue"
	slowdown = 0.3
	armor_type = /datum/armor/space_ntrauma
	resistance_flags = ACID_PROOF
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET
	cell = /obj/item/stock_parts/power_store/cell/super

/datum/armor/space_ntrauma
	melee = 10
	bullet = 10
	laser = 10
	energy = 10
	bomb = 10
	bio = 100
	fire = 80
	acid = 80

/obj/item/clothing/head/helmet/space/ntrauma
	name = "创伤小队头盔"
	desc = "一顶无面罩的白色头盔，可与软式宇航服密封连接，供创伤小队在潜在危险环境中作业。表面涂有抗酸化学涂层。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	icon_state = "ert_ntrauma"
	resistance_flags = ACID_PROOF
	supports_variations_flags = NONE	//Also good GOD I didnt want to re-sprite this helmet
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
