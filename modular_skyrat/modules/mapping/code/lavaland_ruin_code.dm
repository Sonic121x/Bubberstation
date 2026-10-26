//SPAWNERS//
/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/shaftminer
	name = "英特戴恩矿工"
	you_are_text = "你是一名英特戴恩矿工，受雇于一座研发生物武器的绝密研究设施。"
	outfit = /datum/outfit/lavaland_syndicate/shaftminer

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/space
	outfit = /datum/outfit/lavaland_syndicate/comms/space

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/shaftminer/ice
	name = "英特戴恩矿工"
	you_are_text = "你是一名英特戴恩矿工，受雇于一座研发生物武器的绝密研究设施。"
	outfit = /datum/outfit/lavaland_syndicate/shaftminer/ice

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate
	name = "英特戴恩生化武器科学家"
	you_are_text = "你是一名英特戴恩科学技术员，受雇于一座研发生物武器的绝密研究设施。"

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/ice
	outfit = /datum/outfit/lavaland_syndicate/ice

//OUTFITS//
/datum/outfit/lavaland_syndicate
	name = "Interdyne Bioweapon Scientist"
	uniform = /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate
	suit = /obj/item/clothing/suit/toggle/labcoat/interdyne
	ears = /obj/item/radio/headset/syndicateciv/staff

/datum/outfit/lavaland_syndicate/post_equip(mob/living/carbon/human/syndicate, visualsOnly = FALSE)
	syndicate.add_faction(ROLE_SYNDICATE)

	var/obj/item/card/id/id_card = syndicate.wear_id
	if(istype(id_card))
		id_card.registered_name = syndicate.real_name
		id_card.update_label()
		id_card.update_icon()

	handlebank(syndicate)
	return ..()

/datum/outfit/lavaland_syndicate/ice
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	suit = /obj/item/clothing/suit/hooded/wintercoat/skyrat/syndicate
	ears = /obj/item/radio/headset/syndicateciv/staff

/datum/outfit/lavaland_syndicate/comms
	uniform = /obj/item/clothing/under/rank/security/skyrat/utility/redsec/syndicate
	ears = /obj/item/radio/headset/syndicateciv/comms

/datum/outfit/lavaland_syndicate/comms/space
	ears = /obj/item/radio/headset/syndicate/alt

/datum/outfit/lavaland_syndicate/shaftminer
	name = "Interdyne Shaft Miner"
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/utility/syndicate
	suit = null //Subtype moment
	r_pocket = /obj/item/storage/bag/ore
	id_trim = /datum/id_trim/syndicom/skyrat/interdyne
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/t_scanner/adv_mining_scanner/lesser=1,
		/obj/item/gun/energy/recharge/kinetic_accelerator=1,\
		/obj/item/stack/marker_beacon/ten=1,\
		/obj/item/card/mining_point_card=1)

/datum/outfit/lavaland_syndicate/shaftminer/deckofficer
	name = "Interdyne Deck Officer"
	uniform = /obj/item/clothing/under/rank/cargo/qm/skyrat/syndie
	neck = /obj/item/clothing/neck/cloak/qm/syndie
	ears = /obj/item/radio/headset/syndicateciv/command
	id = /obj/item/card/id/advanced/silver/generic
	id_trim = /datum/id_trim/syndicom/skyrat/interdyne/deckofficer
	r_hand = /obj/item/gun/ballistic/rifle/sniper_rifle

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/deckofficer
	name = "英特戴恩甲板军官"
	you_are_text = "你是一名英特戴恩甲板军官，受雇于一座研发生物武器的绝密研究设施。"
	outfit = /datum/outfit/lavaland_syndicate/shaftminer/deckofficer

/datum/outfit/lavaland_syndicate/shaftminer/ice
	name = "Icemoon Interdyne Shaft Miner"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	suit = /obj/item/clothing/suit/hooded/wintercoat/skyrat/syndicate

//ITEMS
/obj/structure/closet/crate/freezer/sansufentanyl
	name = "桑苏芬太尼冷冻柜"
	desc = "一台冷冻柜。内有冷藏的桑苏芬太尼，用于控制遗传性流形病，由英特戴恩制药公司生产。"

/obj/structure/closet/crate/freezer/sansufentanyl/PopulateContents()
	. = ..()
	for(var/grabbin_pills in 1 to 10)
		new /obj/item/storage/pill_bottle/sansufentanyl(src)

//MOBS

// hivelords that stand guard where they spawn
/mob/living/basic/mining/hivelord/no_wander
	ai_controller = /datum/ai_controller/basic_controller/hivelord/no_wander

//MOB AI

// same as a regular hivelord minus the idle walking
/datum/ai_controller/basic_controller/hivelord/no_wander
