//SPAWNERS//

/obj/effect/mob_spawn/ghost_role/human/ash_walker/special(mob/living/carbon/human/spawned_human)
	. = ..()
	if(SSmapping.level_trait(spawned_human.z, ZTRAIT_ICE_RUINS_UNDERGROUND) || SSmapping.level_trait(spawned_human.z, ZTRAIT_ICE_RUINS_UNDERGROUND))
		ADD_TRAIT(spawned_human, TRAIT_NOBREATH, ROUNDSTART_TRAIT)
		ADD_TRAIT(spawned_human, TRAIT_RESISTCOLD, ROUNDSTART_TRAIT)

	spawned_human.mind?.teach_crafting_recipe(/datum/crafting_recipe/bronze_arrow)

/obj/effect/mob_spawn/ghost_role/human/pirate/silverscale/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/common, source = LANGUAGE_SPAWNER)

/obj/effect/mob_spawn/ghost_role/human/blackmarket
	name = "低温休眠舱"
	prompt_name = "一名黑市商人"
	desc = "一台嗡嗡作响的低温休眠舱。机器正试图唤醒舱内的乘员。"
	mob_name = "一名黑市商人"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "你是一名黑市商人，在纳米传讯的太空里开了家小店。"
	flavour_text = "FTU、独立……管他呢，不管你是什么来头。在这片地方都无所谓。\
	你在一颗略有些可疑却还凑合能用的小行星上支起了摊子做买卖。\
	去探索太空，找到值钱的遗物和上好的战利品——再转手卖给纳米传讯那些蠢货。\
	又或者，附近的太空里还有更稀奇的客户……？"
	important_text = "你不是反派。"
	outfit = /datum/outfit/black_market
	spawner_job_path = /datum/job/blackmarket
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = TRUE
	allow_custom_character = ALL

/datum/outfit/black_market
	name = "Black Market Trader"
	uniform = /obj/item/clothing/under/rank/cargo/tech
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id/advanced/chameleon/black/blackmarket

/datum/outfit/black_market/post_equip(mob/living/carbon/human/shady, visualsOnly)
	handlebank(shady)
	return ..()

/obj/effect/mob_spawn/ghost_role/human/ds2
	name = "DS2 人员"
	use_outfit_name = TRUE
	prompt_name = "DS2 人员"
	you_are_text = "你是一名辛迪加特工，受雇于一座研发生物武器的绝密研究设施。"
	flavour_text = "不幸的是，你们憎恶的敌人纳米传讯已开始在这一星区采矿。尽力继续你的任务，并尽量保持低调。"
	quirks_enabled = TRUE
	random_appearance = FALSE
	computer_area = /area/ruin/space/has_grav/skyrat/interdynefob/service/dorms
	spawner_job_path = /datum/job/ds2

/obj/effect/mob_spawn/ghost_role/human/ds2/prisoner
	name = "辛迪加囚犯"
	prompt_name = "一名辛迪加囚犯"
	you_are_text = "你是一名辛迪加囚犯，身处一艘不知名的飞船之上。"
	flavour_text = "你不知道自己身在何处，只知道自己是个囚犯。那些塑钛结构应该能暗示你的俘获者是谁……至于你为什么在这里？那得问你自己，再由我们来查清。"
	important_text = "你仍受标准囚犯规则的约束，若要与 DS2 对抗，必须先向管理员求助。"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	computer_area = /area/ruin/space/has_grav/skyrat/interdynefob/security/prison
	outfit = /datum/outfit/ds2/prisoner
	spawner_job_path = /datum/job/ds2

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate
	name = "辛迪加特工"
	prompt_name = "一名辛迪加特工"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	you_are_text = "你是索斯兰辛迪加恐怖小组的一名特工，出于你自己的原因受雇于深空 2 号前进基地。"
	flavour_text = "索斯兰辛迪加认为有必要向 13 号星区派遣一座前进基地，以监视纳米传讯的行动。你的命令是维护船体的完好，并尽可能保持低调。"
	important_text = "你不是反派。若要与空间站船员对抗，必须先向管理员求助。"
	outfit = /datum/outfit/ds2/syndicate
	computer_area = /area/ruin/space/has_grav/skyrat/interdynefob/halls
	spawner_job_path = /datum/job/ds2
	loadout_enabled = TRUE

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate_command
	name = "辛迪加指挥特工"
	prompt_name = "一名辛迪加领导者"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	you_are_text = "你是索斯兰辛迪加恐怖小组的一名指挥特工，受雇于深空 2 号前进基地，负责引导它推进目标。"
	flavour_text = "索斯兰辛迪加认为有必要派你来协助指挥 13 号星区的前进基地。你的命令是统率 DS-2 的船员，同时尽可能保持低调。"
	important_text = "请以与指挥规则同等的标准要求自己。你不是反派，若要与空间站船员对抗，必须先向管理员求助。"
	outfit = /datum/outfit/ds2/syndicate_command
	computer_area = /area/ruin/space/has_grav/skyrat/interdynefob/halls
	spawner_job_path = /datum/job/ds2
	loadout_enabled = TRUE

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate_command/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/service
	outfit = /datum/outfit/ds2/syndicate/service

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/miner
	outfit = /datum/outfit/ds2/syndicate/miner

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/enginetech
	outfit = /datum/outfit/ds2/syndicate/enginetech

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/researcher
	outfit = /datum/outfit/ds2/syndicate/researcher

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/stationmed
	outfit = /datum/outfit/ds2/syndicate/stationmed

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/brigoff
	outfit = /datum/outfit/ds2/syndicate/brigoff

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate_command/masteratarms
	outfit = /datum/outfit/ds2/syndicate_command/masteratarms

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate_command/corporateliaison
	outfit = /datum/outfit/ds2/syndicate_command/corporateliaison

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate_command/admiral
	outfit = /datum/outfit/ds2/syndicate_command/admiral

/obj/effect/mob_spawn/ghost_role/human/hotel_staff
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/hotel_staff/manager
	name = "员工经理休眠舱"
	mob_name = "酒店员工经理"
	outfit = /datum/outfit/hotelstaff/manager
	you_are_text = "你是一家顶级太空酒店的经理！"
	flavour_text = "你是一家顶级太空酒店的经理！确保客人得到照顾、酒店宣传到位，也别让员工偷懒！"

/obj/effect/mob_spawn/corpse/human/damaged/ashwalker
	mob_type = /mob/living/carbon/human/species/lizard/ashwalker;
	outfit = /datum/outfit/consumed_ashwalker

/obj/effect/mob_spawn/ghost_role/human/oldstation/sec
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/oldstation/sci
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/oldstation/eng
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE

//OUTFITS//
/datum/outfit/syndicatespace/syndicrew
	ears = /obj/item/radio/headset/cybersun
	id_trim = /datum/id_trim/syndicom/skyrat/crew

/datum/outfit/syndicatespace/syndicaptain
	ears = /obj/item/radio/headset/cybersun/captain
	id_trim = /datum/id_trim/syndicom/skyrat/captain

/datum/outfit/ds2
	name = "default ds2 outfit"

/datum/outfit/ds2/post_equip(mob/living/carbon/human/syndicate, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = syndicate.wear_id
	if(istype(id_card))
		id_card.registered_name = syndicate.real_name
		id_card.update_label()
		id_card.update_icon()
	syndicate.apply_pref_name(/datum/preference/name/syndicate, syndicate.client)
	handlebank(syndicate)
	return ..()

//DS-2 Hostage
/datum/outfit/ds2/prisoner
	name = "Syndicate Prisoner"
	uniform = /obj/item/clothing/under/rank/prisoner/syndicate
	shoes = /obj/item/clothing/shoes/sneakers/crimson
	id = /obj/item/card/id/advanced/prisoner/ds2
	id_trim = /datum/id_trim/syndicom/skyrat/ds2/prisoner

//DS-2 Crew
/datum/outfit/ds2/syndicate
	name = "DS-2 Operative"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/syndicateciv/staff
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		)
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/skyrat/ds2

/datum/outfit/ds2/syndicate/miner
	name = "DS-2 Mining Officer"
	uniform = /obj/item/clothing/under/syndicate/skyrat/overalls
	belt = /obj/item/storage/bag/ore
	back = /obj/item/storage/backpack/satchel/explorer
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/knife/combat/survival = 1,
		/obj/item/t_scanner/adv_mining_scanner/lesser = 1,
		/obj/item/gun/energy/recharge/kinetic_accelerator = 1,
		)
	id_trim = /datum/id_trim/syndicom/skyrat/ds2/miner
	l_pocket = /obj/item/card/mining_point_card
	r_pocket = /obj/item/mining_voucher
	head = /obj/item/clothing/head/soft/black

/datum/outfit/ds2/syndicate/service
	name = "DS-2 General Staff"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	id_trim = /datum/id_trim/syndicom/skyrat/ds2/syndicatestaff
	back = /obj/item/storage/backpack/satchel
	suit = /obj/item/clothing/suit/apron/chef
	head = /obj/item/clothing/head/soft/mime

/datum/outfit/ds2/syndicate/enginetech
	name = "DS-2 Engine Technician"
	uniform = /obj/item/clothing/under/syndicate/skyrat/overalls
	head = /obj/item/clothing/head/soft/sec/syndicate
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/storage/box/syndie_kit/space_suit = 1,
		)
	id_trim = /datum/id_trim/syndicom/skyrat/ds2/enginetechnician
	glasses = /obj/item/clothing/glasses/welding/up
	belt = /obj/item/storage/belt/utility/syndicate
	gloves = /obj/item/clothing/gloves/combat
	r_pocket = /obj/item/gun/energy/e_gun/mini

/datum/outfit/ds2/syndicate/researcher
	name = "DS-2 Researcher"
	uniform = /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/ds2/researcher
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	glasses = /obj/item/clothing/glasses/sunglasses/chemical
	gloves = /obj/item/clothing/gloves/color/black
	back = /obj/item/storage/backpack/satchel
	r_pocket = /obj/item/gun/energy/e_gun/mini

/datum/outfit/ds2/syndicate/stationmed
	name = "DS-2 Medical Officer"
	uniform = /obj/item/clothing/under/syndicate/scrubs
	id_trim = /datum/id_trim/syndicom/skyrat/ds2/medicalofficer
	suit = /obj/item/clothing/suit/toggle/labcoat/interdyne
	belt = /obj/item/storage/belt/medical/paramedic
	gloves = /obj/item/clothing/gloves/latex/nitrile/ntrauma
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/storage/medkit/surgery = 1,
		/obj/item/gun/syringe/rapidsyringe = 1,
		)

/datum/outfit/ds2/syndicate/brigoff
	name = "DS-2 Brig Officer"
	uniform = /obj/item/clothing/under/syndicate/combat
	id_trim = /datum/id_trim/syndicom/skyrat/ds2/brigofficer
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/bulletproof/old
	back = /obj/item/storage/backpack/security
	head = /obj/item/clothing/head/helmet/swat/ds
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/redsec
	r_pocket = /obj/item/flashlight/seclite
	mask = /obj/item/clothing/mask/gas/syndicate
	ears = /obj/item/radio/headset/syndicateciv/staff

/datum/outfit/ds2/syndicate/post_equip(mob/living/carbon/human/syndicate)
	syndicate.add_faction(ROLE_SYNDICATE)
	return ..()

//DS-2 Command
/datum/outfit/ds2/syndicate_command
	name = "DS-2 Command Operative"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/syndicateciv/command
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		)
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/skyrat/ds2

/datum/outfit/ds2/syndicate_command/masteratarms
	name = "DS-2 Master At Arms"
	uniform = /obj/item/clothing/under/syndicate/combat
	id_trim = /datum/id_trim/syndicom/skyrat/ds2/masteratarms
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/vest/warden/syndicate
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/redsec
	back = /obj/item/storage/backpack/satchel/sec
	head = /obj/item/clothing/head/hats/hos/beret/syndicate
	l_pocket = /obj/item/gun/energy/e_gun/mini
	r_pocket = /obj/item/flashlight/seclite
	implants = list(
		/obj/item/implant/weapons_auth,
		/obj/item/implant/kaza_ruk
		)

/datum/outfit/ds2/syndicate_command/corporateliaison
	name = "DS-2 Corporate Liasion"
	uniform = /obj/item/clothing/under/syndicate/sniper
	head = /obj/item/clothing/head/fedora
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack/satchel
	id_trim = /datum/id_trim/syndicom/skyrat/ds2/corporateliasion
	belt = /obj/item/gun/energy/e_gun

/datum/outfit/ds2/syndicate_command/admiral
	name = "DS-2 Admiral"
	uniform = /obj/item/clothing/under/rank/captain/skyrat/utility/syndicate
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/lockbox/medal/bubber/synd = 1,
		)
	belt = /obj/item/storage/belt/sheath/sabre
	head = /obj/item/clothing/head/hats/hos/cap/syndicate
	id = /obj/item/card/id/advanced/gold/generic
	id_trim = /datum/id_trim/syndicom/skyrat/ds2/stationadmiral

/datum/outfit/ds2/syndicate_command/post_equip(mob/living/carbon/human/syndicate)
	syndicate.add_faction(ROLE_SYNDICATE)
	return ..()

/datum/outfit/hotelstaff
	id = /obj/item/card/id/away/hotel

/datum/outfit/hotelstaff/post_equip(mob/living/carbon/human/staff, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = staff.wear_id
	if(istype(id_card))
		id_card.registered_name = staff.real_name
		id_card.update_label()
		id_card.update_icon()

	handlebank(staff)
	return ..()

/datum/outfit/hotelstaff/manager
	name = "Hotel Staff Manager"
	uniform = /obj/item/clothing/under/suit/red
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/radio/off
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/mindshield, /obj/item/implant/exile/noteleport)
	id = /obj/item/card/id/away/hotel/manager

/datum/outfit/hotelstaff/security
	r_hand = /obj/item/gun/energy/laser/scatter/shotty // SKYRAT EDIT ADD - SPAWNS IN HAND INSTEAD OF ON MAP
	id = /obj/item/card/id/away/hotel/security

//Lost Space Truckers: Six people stranded in deep space aboard a cargo freighter. They must survive their marooning and cooperate.

/obj/effect/mob_spawn/ghost_role/human/lostcargo
	name = "货船船员低温休眠舱"
	prompt_name = "一名失联的货运技术员"
	desc = "一台嗡嗡作响的低温休眠舱。里面是一名货运搬运工。"
	mob_name = "货船船员"
	outfit = /datum/outfit/freighter_crew
	spawner_job_path = /datum/job/freighter_crew
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "你当时正在跑货运，一份普通的货运活儿，直到海盗来袭。你和同伴们勉强逃过一劫，但引擎被打坏了。现在你们被困在太空中，只能齐心协力在这场噩梦里活下去。"
	flavour_text = "你当时正在跑货运，一份普通的货运活儿，直到海盗来袭。你和同伴们勉强逃过一劫，但引擎被打坏了。现在你们被困在太空中，只能齐心协力在这场噩梦里活下去。"
	important_text = "与你的船员协作，不要抛弃他们。你并不直接为纳米传讯工作，你是船长手下的独立货船船员。你的工作只是做个甲板水手，干些货运活儿，顺便帮忙准备餐食。"
	random_appearance = FALSE
	quirks_enabled = TRUE
	loadout_enabled = TRUE

/datum/outfit/freighter_crew
	name = "Freighter Crew"
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/casualman
	shoes = /obj/item/clothing/shoes/workboots
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/away/freightcrew

/datum/outfit/freighter_crew/post_equip(mob/living/carbon/human/crewman, visualsOnly)
	var/obj/item/card/id/id_card = crewman.wear_id
	if(istype(id_card))
		id_card.registered_name = crewman.real_name
		id_card.update_label()
		id_card.update_icon()

	handlebank(crewman)
	return ..()

/obj/effect/mob_spawn/ghost_role/human/lostminer
	name = "货船挖掘工低温休眠舱"
	prompt_name = "一名失联的矿工"
	desc = "一台嗡嗡作响的低温休眠舱。里面是一名挖掘工人。"
	mob_name = "货船挖掘工"
	outfit = /datum/outfit/freighter_excavator
	spawner_job_path = /datum/job/freighter_crew
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "你当时正在跑货运，一份普通的货运活儿，直到海盗来袭。你和同伴们勉强逃过一劫，但引擎被打坏了。现在你们被困在太空中，只能齐心协力在这场噩梦里活下去。"
	flavour_text = "你当时正在跑货运，一份普通的货运活儿，直到海盗来袭。你和同伴们勉强逃过一劫，但引擎被打坏了。现在你们被困在太空中，只能齐心协力在这场噩梦里活下去。"
	important_text = "与你的船员协作，不要抛弃他们。你并不直接为纳米传讯工作，你是在船长手下干活的独立货船船员。你的职责是为这艘船做挖掘与打捞工作。"
	random_appearance = FALSE
	quirks_enabled = TRUE
	loadout_enabled = TRUE

/datum/outfit/freighter_excavator
	name = "Freighter Excavator"
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/gorka
	shoes = /obj/item/clothing/shoes/workboots/mining
	back = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/flashlight/seclite=1,\
		/obj/item/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/t_scanner/adv_mining_scanner/lesser=1,
		/obj/item/gun/energy/recharge/kinetic_accelerator=1,\
		/obj/item/stack/marker_beacon/ten=1,
		)
	r_pocket = /obj/item/storage/bag/ore
	id = /obj/item/card/id/away/freightmine

/datum/outfit/freighter_excavator/post_equip(mob/living/carbon/human/crewman, visualsOnly)
	var/obj/item/card/id/id_card = crewman.wear_id
	if(istype(id_card))
		id_card.registered_name = crewman.real_name
		id_card.update_label()
		id_card.update_icon()

	handlebank(crewman)
	return ..()

/obj/effect/mob_spawn/ghost_role/human/lostcargoqm
	name = "货船船长低温休眠舱"
	prompt_name = "一名失联的货运主管"
	desc = "一台嗡嗡作响的低温休眠舱。里面那人看起来像是管事儿的。"
	mob_name = "货船船长"
	outfit = /datum/outfit/freighter_boss
	spawner_job_path = /datum/job/freighter_crew
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "你和船员们正在跑一趟普通的货运，直到一次海盗袭击打坏了引擎。现在你能做的只有尽力活下去，并保住你的船员。"
	flavour_text = "你和船员们正在跑一趟普通的货运，直到一次海盗袭击打坏了引擎。现在你能做的只有尽力活下去，并保住你的船员。"
	important_text = "不要抛弃你的船员，带领他们、与他们协作求生。你并不直接为纳米传讯工作，你是一支独立货船船员的头儿。你是这艘船（你不久前买下的）的船长，负责统率船员。"
	random_appearance = FALSE
	quirks_enabled = TRUE
	loadout_enabled = TRUE

/datum/outfit/freighter_boss
	name = "Freighter Boss"
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/turtleneck
	shoes = /obj/item/clothing/shoes/workboots
	neck = /obj/item/clothing/neck/cloak/qm
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/megaphone/cargo=1,
		)
	id = /obj/item/card/id/away/silver/freightqm

/datum/outfit/freighter_boss/post_equip(mob/living/carbon/human/crewman, visualsOnly)
	var/obj/item/card/id/id_card = crewman.wear_id
	if(istype(id_card))
		id_card.registered_name = crewman.real_name
		id_card.update_label()
		id_card.update_icon()

	handlebank(crewman)
	return ..()



/datum/outfit/proc/handlebank(mob/living/carbon/human/owner)
	var/datum/bank_account/offstation_bank_account = new(owner.real_name)
	owner.account_id = offstation_bank_account.account_id
	offstation_bank_account.replaceable = FALSE
	offstation_bank_account.account_job = new /datum/job/ghost_role
	owner.add_mob_memory(/datum/memory/key/account, remembered_id = owner.account_id)
	if(owner.wear_id)
		var/obj/item/card/id/id_card = owner.wear_id
		id_card.registered_account = offstation_bank_account
	return

//ITEMS//
/obj/item/radio/headset/cybersun
	keyslot = new /obj/item/encryptionkey/headset_syndicate/cybersun

/obj/item/radio/headset/cybersun/captain
	name = "赛博太阳舰长耳机"
	desc = "老大的耳机。"
	command = TRUE


//OBJECTS//
/obj/structure/showcase/machinery/oldpod/used
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod-open"

/obj/structure/showcase/machinery/oldpod/used/psyker
	icon = 'icons/obj/machines/sleeper.dmi' // SKYRAT TODO - Add aesthetics sprites

//IDS//

/obj/item/card/id/away/silver
	name = "旧银色身份证"
	desc = "一张标准的通用身份证。看来还缺点个性化。这一张似乎曾属于某位重要人物。"
	wildcard_slots = WILDCARD_LIMIT_SILVER

/obj/item/card/id/advanced/chameleon/black/blackmarket
	name = "磨损的身份证"
	desc = "一张褪色、磨损的塑料身份证。你能辨认出上面的职衔是“甲板船员”。"
	trim = /datum/id_trim/away/blackmarket

/datum/id_trim/away/blackmarket
	access = list(ACCESS_AWAY_GENERIC4)
	assignment = "甲板船员"

/obj/item/card/id/away/freightcrew
	name = "货船身份证"
	desc = "一张标有货运搬运工职衔的身份证。"
	trim = /datum/id_trim/job/cargo_technician

/obj/item/card/id/away/freightmine
	name = "货船身份证"
	desc = "一张标有货船挖掘工职衔的身份证。"
	trim = /datum/id_trim/job/shaft_miner

/obj/item/card/id/away/silver/freightqm
	name = "货船甲板主管身份证"
	desc = "一张标有货船甲板主管职衔的身份证。"
	trim = /datum/id_trim/job/quartermaster

/obj/item/card/id/away/hotel/manager
	name = "经理身份证"
	trim = /datum/id_trim/away/hotel/manager

/datum/id_trim/away/hotel
	assignment = "酒店员工"
	access = list(ACCESS_TWIN_NEXUS_STAFF)

/datum/id_trim/away/hotel/manager
	assignment = "酒店经理"
	access = list(ACCESS_TWIN_NEXUS_STAFF, ACCESS_TWIN_NEXUS_MANAGER)

/datum/id_trim/away/hotel/security
	assignment = "酒店安保"


//CRYO CONSOLES
/obj/machinery/computer/cryopod/interdyne
	radio = /obj/item/radio/headset/syndicateciv/staff
	announcement_channel = RADIO_CHANNEL_INTERDYNE
	req_one_access = list("syndicate_leader")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/computer/cryopod/interdyne, 32)

//CRYO CONSOLES
/obj/machinery/computer/cryopod/cybersun
	radio = /obj/item/radio/headset/syndicateciv/staff
	announcement_channel = RADIO_CHANNEL_CYBERSUN
	req_one_access = list("syndicate_leader")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/computer/cryopod/cybersun, 32)

