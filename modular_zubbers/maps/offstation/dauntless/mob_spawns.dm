/datum/job/dauntless // Job Define
	title = ROLE_DAUNTLESS
	policy_index = ROLE_DAUNTLESS
	akula_outfit = /datum/outfit/akula

// Dauntless Ghost Spawners (Lava)

/obj/effect/mob_spawn/ghost_role/human/dauntless
	name = "无畏号人员"
	use_outfit_name = TRUE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "一名无畏号人员"
	you_are_text = "你是辛迪加特工，受雇于一艘藏在熔岩地带的绝密间谍船。"
	flavour_text = "不幸的是，你们的宿敌纳米传讯已开始在这一星区采矿。尽你所能继续干活，并保持低调。"
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = TRUE
	computer_area = /area/ruin/space/has_grav/bubbers/dauntless/service
	spawner_job_path = /datum/job/dauntless
	/// If true, this spawner will give it's target exploitables access.
	var/give_exploitables = TRUE

/obj/effect/mob_spawn/ghost_role/human/dauntless/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()

	if (give_exploitables)
		spawned_mob.mind?.has_exploitables_override = TRUE
		spawned_mob.mind?.handle_exploitables_menu()

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate
	name = "辛迪加特工"
	prompt_name = "一名辛迪加特工"
	you_are_text = "一名被派往辛迪加间谍船无畏号的特工，受雇于此的理由只有你自己清楚。"
	flavour_text = "由多方共管的 SSV 无畏号被派去秘密监视纳米传讯的资产。DS-2 被摧毁后，它藏身于熔岩地带滚滚的灰烬云之后。你的命令是维护飞船的完整，并保持低调。"
	important_text = "你并非反派，本局也不以无畏号为中心。当你与空间站及其船员的冲突升级时，你必须提交敌对势力申请或发起 adminhelp。"
	outfit = /datum/outfit/dauntless/syndicate

/obj/effect/mob_spawn/ghost_role/human/dauntless/command
	name = "辛迪加指挥特工"
	prompt_name = "一名辛迪加领袖"
	you_are_text = "一名辛迪加指挥特工，被指派领导 SSV 无畏号，引领它朝既定目标前进。"
	flavour_text = "由多方共管的 SSV 无畏号被派去秘密监视纳米传讯的资产。DS-2 被摧毁后，它藏身于熔岩地带滚滚的灰烬云之后。你的命令是协助领导无畏号，同时确保全船保持低调。"
	important_text = "你属于指挥类角色，需以更高标准要求自己。你并非反派，本局也不以无畏号为中心。当你与空间站及其船员的冲突升级时，你必须提交敌对势力申请或发起 adminhelp。"
	outfit = /datum/outfit/dauntless/command

/obj/effect/mob_spawn/ghost_role/human/dauntless/prisoner
	name = "辛迪加人质"
	prompt_name = "一名辛迪加人质"
	you_are_text = "你是一艘不明辛迪加飞船上的人质。"
	flavour_text = "你不知道自己在哪儿，只知道自己是个囚犯。这些塑钛或许能让你猜到绑匪是谁……至于你为什么在这里？那得你自己知道，再由我们来弄明白。"
	important_text = "你并非反派。你仍须遵守有关冲突升级的角色扮演规则。如果你激怒无畏号人员，他们会把你扔进熔岩里。"
	outfit = /datum/outfit/dauntless/prisoner
	computer_area = /area/ruin/space/has_grav/bubbers/dauntless/sec/prison
	give_exploitables = FALSE

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate/service
	outfit = /datum/outfit/dauntless/syndicate/service

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate/enginetech
	outfit = /datum/outfit/dauntless/syndicate/enginetech

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate/researcher
	outfit = /datum/outfit/dauntless/syndicate/researcher

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate/stationmed
	outfit = /datum/outfit/dauntless/syndicate/stationmed

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate/brigoff
	outfit = /datum/outfit/dauntless/syndicate/brigoff

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate/miningoff
	outfit = /datum/outfit/dauntless/syndicate/miningoff

/obj/effect/mob_spawn/ghost_role/human/dauntless/command/masteratarms
	outfit = /datum/outfit/dauntless/command/masteratarms

/obj/effect/mob_spawn/ghost_role/human/dauntless/command/corporateliaison
	outfit = /datum/outfit/dauntless/command/corporateliaison

/obj/effect/mob_spawn/ghost_role/human/dauntless/command/admiral
	outfit = /datum/outfit/dauntless/command/admiral

// Dauntless Ghost Spawners (Space)

/obj/effect/mob_spawn/ghost_role/human/space_dauntless
	name = "无畏号人员"
	use_outfit_name = TRUE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "一名无畏号人员"
	you_are_text = "你是辛迪加特工，受雇于一艘藏在遥远星区的绝密间谍船。"
	flavour_text = "不幸的是，你们的宿敌纳米传讯已开始在这一星区采矿。尽你所能继续干活，并保持低调。"
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = TRUE
	computer_area = /area/ruin/space/has_grav/bubbers/dauntless_space/service
	spawner_job_path = /datum/job/dauntless

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate
	name = "辛迪加特工"
	prompt_name = "一名辛迪加特工"
	you_are_text = "一名被派往辛迪加间谍船无畏号的特工，受雇于此的理由只有你自己清楚。"
	flavour_text = "由多方共管的 SSV 无畏号被派去秘密监视纳米传讯的资产。它藏身于纳米传讯空间站所在的遥远星区。你的命令是维护飞船的完整，并保持低调。"
	important_text = "你并非反派，本局也不以无畏号为中心。当你与空间站及其船员的冲突升级时，你必须提交敌对势力申请或发起 adminhelp。"
	outfit = /datum/outfit/dauntless/syndicate

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/command
	name = "辛迪加指挥特工"
	prompt_name = "一名辛迪加领袖"
	you_are_text = "一名辛迪加指挥特工，被指派领导 SSV 无畏号，引领它朝既定目标前进。"
	flavour_text = "由多方共管的 SSV 无畏号被派去秘密监视纳米传讯的资产。它藏身于纳米传讯空间站所在的遥远星区。你的命令是协助领导无畏号，同时确保全船保持低调。"
	important_text = "你属于指挥类角色，需以更高标准要求自己。你并非反派，本局也不以无畏号为中心。当你与空间站及其船员的冲突升级时，你必须提交敌对势力申请或发起 adminhelp。"
	outfit = /datum/outfit/dauntless/command

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/prisoner
	name = "辛迪加人质"
	prompt_name = "一名辛迪加人质"
	you_are_text = "你是一艘不明辛迪加飞船上的人质。"
	flavour_text = "你不知道自己在哪儿，只知道自己是个囚犯。这些塑钛或许能让你猜到绑匪是谁……至于你为什么在这里？那得你自己知道，再由我们来弄明白。"
	important_text = "你并非反派。你仍须遵守有关冲突升级的角色扮演规则。如果你激怒无畏号人员，他们会把你扔进太空里。"
	outfit = /datum/outfit/dauntless/prisoner
	computer_area = /area/ruin/space/has_grav/bubbers/dauntless_space/sec/prison

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate/service
	outfit = /datum/outfit/dauntless/syndicate/service

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate/enginetech
	outfit = /datum/outfit/dauntless/syndicate/enginetech

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate/researcher
	outfit = /datum/outfit/dauntless/syndicate/researcher

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate/stationmed
	outfit = /datum/outfit/dauntless/syndicate/stationmed

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate/brigoff
	outfit = /datum/outfit/dauntless/syndicate/brigoff

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate/miningoff
	outfit = /datum/outfit/dauntless/syndicate/miningoff

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/command/masteratarms
	outfit = /datum/outfit/dauntless/command/masteratarms

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/command/corporateliaison
	outfit = /datum/outfit/dauntless/command/corporateliaison

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/command/admiral
	outfit = /datum/outfit/dauntless/command/admiral

// Codespeak Granter

/obj/effect/mob_spawn/ghost_role/human/dauntless/syndicate/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)

/obj/effect/mob_spawn/ghost_role/human/dauntless/command/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/syndicate/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)

/obj/effect/mob_spawn/ghost_role/human/space_dauntless/command/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)

// Outfits --------------

/datum/outfit/dauntless
	name = "Dauntless"

/datum/outfit/dauntless/post_equip(mob/living/carbon/human/syndicate, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = syndicate.wear_id
	if(istype(id_card))
		id_card.registered_name = syndicate.real_name
		id_card.update_label()
		id_card.update_icon()
	syndicate.apply_pref_name(/datum/preference/name/syndicate, syndicate.client)
	handlebank(syndicate)
	return ..()

//Dauntless Hostage

/datum/outfit/dauntless/prisoner
	name = "Syndicate Prisoner"
	uniform = /obj/item/clothing/under/rank/prisoner/syndicate
	shoes = /obj/item/clothing/shoes/sneakers/crimson
	id = /obj/item/card/id/advanced/prisoner/ds2
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/prisoner

//Dauntless Roles

/datum/outfit/dauntless/syndicate
	name = "Dauntless Operative"
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
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless

/datum/outfit/dauntless/syndicate/service
	name = "Dauntless General Staff"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/syndicatestaff
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/sharpener = 1,
		)
	suit = /obj/item/clothing/suit/apron/chef
	head = /obj/item/clothing/head/soft/mime

/datum/outfit/dauntless/syndicate/enginetech
	name = "Dauntless Engineer"
	uniform = /obj/item/clothing/under/syndicate/skyrat/overalls
	head = /obj/item/clothing/head/soft/sec/syndicate
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		)
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/enginetechnician
	glasses = /obj/item/clothing/glasses/welding/up
	belt = /obj/item/storage/belt/utility/syndicate
	gloves = /obj/item/clothing/gloves/combat

/datum/outfit/dauntless/syndicate/researcher
	name = "Dauntless Researcher"
	uniform = /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/researcher
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	glasses = /obj/item/clothing/glasses/sunglasses/chemical
	gloves = /obj/item/clothing/gloves/color/black
	back = /obj/item/storage/backpack/satchel

/datum/outfit/dauntless/syndicate/stationmed
	name = "Dauntless Medical Officer"
	uniform = /obj/item/clothing/under/syndicate/scrubs
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/medicalofficer
	suit = /obj/item/clothing/suit/toggle/labcoat/interdyne
	belt = /obj/item/storage/belt/medical/paramedic
	gloves = /obj/item/clothing/gloves/latex/nitrile/ntrauma
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/storage/medkit/surgery = 1,
		)

/datum/outfit/dauntless/syndicate/brigoff
	name = "Dauntless Brig Officer"
	uniform = /obj/item/clothing/under/syndicate/combat
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/brigofficer
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/bulletproof/old
	back = /obj/item/storage/backpack/security
	backpack_contents = list(
		/obj/item/flashlight/seclite = 1,
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		)
	head = /obj/item/clothing/head/helmet/swat/ds
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/redsec
	mask = /obj/item/clothing/mask/gas/syndicate
	ears = /obj/item/radio/headset/syndicateciv/staff

/datum/outfit/dauntless/syndicate/miningoff
	name = "Dauntless Mining Officer"
	uniform = /obj/item/clothing/under/syndicate/skyrat/overalls
	belt = /obj/item/storage/bag/ore
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/miner
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/bulletproof/old
	suit_store = /obj/item/gun/ballistic/automatic/pistol
	back = /obj/item/storage/backpack/satchel/explorer
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/knife/combat/survival = 1,
		/obj/item/t_scanner/adv_mining_scanner/lesser = 1,
		/obj/item/gun/energy/recharge/kinetic_accelerator = 1,
		/obj/item/ammo_box/magazine/m9mm
		)
	mask = /obj/item/clothing/mask/gas/syndicate
	ears = /obj/item/radio/headset/syndicateciv/staff
	l_pocket = /obj/item/card/mining_point_card
	r_pocket = /obj/item/mining_voucher
	head = /obj/item/clothing/head/soft/black

/datum/outfit/dauntless/syndicate/post_equip(mob/living/carbon/human/syndicate)
	syndicate.add_faction(ROLE_SYNDICATE)
	return ..()

// Dauntless Command

/datum/outfit/dauntless/command
	name = "Dauntless Command Operative"
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
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless

/datum/outfit/dauntless/command/masteratarms
	name = "Dauntless Master At Arms"
	uniform = /obj/item/clothing/under/syndicate/combat
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/masteratarms
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/vest/warden/syndicate
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/redsec
	back = /obj/item/storage/backpack/satchel/sec
	head = /obj/item/clothing/head/hats/hos/beret/syndicate
	r_pocket = /obj/item/flashlight/seclite
	implants = list(
		/obj/item/implant/weapons_auth,
		/obj/item/implant/kaza_ruk
		)

/datum/outfit/dauntless/command/corporateliaison
	name = "Syndicate Corporate Liasion"
	uniform = /obj/item/clothing/under/syndicate/sniper
	head = /obj/item/clothing/head/fedora
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack/satchel
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/corporateliasion

/datum/outfit/dauntless/command/admiral
	name = "Ship Admiral"
	uniform = /obj/item/clothing/under/rank/captain/skyrat/utility/syndicate
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/choice_beacon/syndicateoffstation/morale = 1,
		/obj/item/storage/lockbox/medal/bubber/synd = 1,
		)
	belt = /obj/item/gun/ballistic/automatic/pistol/aps
	head = /obj/item/clothing/head/hats/hos/cap/syndicate
	id = /obj/item/card/id/advanced/gold/generic
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless/stationadmiral

/datum/outfit/dauntless/command/post_equip(mob/living/carbon/human/syndicate)
	syndicate.add_faction(ROLE_SYNDICATE)
	return ..()
