/datum/job/persistence // Job Define
	title = ROLE_PERSISTENCE
	policy_index = ROLE_PERSISTENCE
	akula_outfit = /datum/outfit/akula

// Persistence mining rig Ghost Spawners

/obj/effect/mob_spawn/ghost_role/human/persistence
	name = "恒久号人员"
	use_outfit_name = TRUE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "一名恒久号人员"
	you_are_text = "你是辛迪加特工，受雇在陆地履带车上作为船员的一员。你的任务目标是采集材料、建造前哨、生产物资，并推进公司的利益。"
	flavour_text = "你已被部署到敌方领地。尽你所能继续工作，并保持低调。"
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = TRUE
	computer_area = /area/ruin/space/has_grav/bubbers/persistance/service/lockers
	spawner_job_path = /datum/job/persistence
	/// If true, this spawner will give it's target exploitables access.
	var/give_exploitables = TRUE
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/persistence/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()

	if (give_exploitables)
		spawned_mob.mind?.has_exploitables_override = TRUE
		spawned_mob.mind?.handle_exploitables_menu()

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate
	name = "辛迪加特工"
	prompt_name = "一名辛迪加特工"
	you_are_text = "你是辛迪加特工，受雇在陆地履带车上作为船员的一员。"
	flavour_text = "由辛迪加运营的恒久号采矿平台已被部署到敌方领地，秘密监视纳米传讯的资产。你的命令是维护飞船的完整、履行你的职责，同时保持低调，并维持采矿作业的伪装。"
	important_text = "你并非反派，本局也不以恒久号为重心。任何与空间站及其船员的重大互动，你必须提交敌对势力申请或发起 adminhelp。"
	outfit = /datum/outfit/persistence/syndicate

/obj/effect/mob_spawn/ghost_role/human/persistence/command
	name = "辛迪加指挥特工"
	prompt_name = "一名辛迪加领袖"
	you_are_text = "你是辛迪加指挥特工，被指派领导 SSV 恒久号，引领它朝既定目标前进。"
	flavour_text = "由辛迪加运营的恒久号采矿平台已被部署到敌方领地，以合法采矿作业为掩护，秘密监视纳米传讯的资产。你的命令是领导恒久号，同时确保全船保持低调。"
	important_text = "你属于指挥类角色，需以更高标准要求自己。你并非反派，本局也不以恒久号为中心。任何与空间站及其船员的重大互动，你必须提交敌对势力申请或发起 adminhelp。"
	outfit = /datum/outfit/persistence/command

/obj/effect/mob_spawn/ghost_role/human/persistence/prisoner
	name = "辛迪加实习生"
	prompt_name = "一名辛迪加实习生"
	you_are_text = "你是一艘不明飞船上的实习生。"
	flavour_text = "你不知道自己在哪儿，只知道自己是个实习生。那些塑钛应该能让你猜到雇主是谁……至于你为什么在这里？那得你自己知道，再由我们来弄明白。"
	important_text = "你并非反派。你仍须遵守有关冲突升级的角色扮演规则。如果你激怒了辛迪加人员，他们会把你扔进外面的熔岩或等离子体里。"
	outfit = /datum/outfit/persistence/prisoner
	computer_area = /area/ruin/space/has_grav/bubbers/persistance/sec/prison
	give_exploitables = FALSE

/obj/effect/mob_spawn/ghost_role/robot/persistence
	name = "辛迪加半机械人储藏舱"
	prompt_name = "一台辛迪加机器人"
	icon = 'modular_skyrat/modules/ghostcafe/icons/robot_storage.dmi'
	icon_state = "robostorage"
	anchored = TRUE
	density = FALSE
	spawner_job_path = /datum/job/persistence
	you_are_text = "你是辛迪加半机械人，被编入陆地履带车上的船员。"
	flavour_text = "你已被部署到敌方领地。尽你所能继续工作，并保持低调。"
	deletes_on_zero_uses_left = TRUE
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/robot/persistence/special(mob/living/silicon/robot/new_spawn)
	. = ..()
	if(new_spawn.client) //It should have a client, right?
		new_spawn.add_faction(ROLE_SYNDICATE)
		new_spawn.add_faction(ROLE_PERSISTENCE) //This is the one to select the cyborg model.
		new_spawn.radio.keyslot = new /obj/item/encryptionkey/headset_syndicate/cybersun(src)
		new_spawn.radio.recalculateChannels()
		new_spawn.UnlinkSelf() //This should prevent AI linking and consoles to see or lock them down.
		new_spawn.SetEmagged(TRUE) //just to be sure.
		new_spawn.laws = new /datum/ai_laws/persistence()
		new_spawn.show_laws() //Check your laws.
		new_spawn.custom_name = null //Taken from ghostcafe, otherwise it'll lead to a runtime if random_appeareance is set to FALSE.
		new_spawn.updatename(new_spawn.client)
		new_spawn.transfer_emote_pref(new_spawn.client)
		new_spawn.gender = NEUTER
// crew spawners

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/service
	outfit = /datum/outfit/persistence/syndicate/service

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/janitor
	outfit = /datum/outfit/persistence/syndicate/janitor

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/enginetech
	outfit = /datum/outfit/persistence/syndicate/enginetech

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/researcher
	outfit = /datum/outfit/persistence/syndicate/researcher

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/stationmed
	outfit = /datum/outfit/persistence/syndicate/stationmed

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/brigoff
	outfit = /datum/outfit/persistence/syndicate/brigoff

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/quartermaster
	outfit = /datum/outfit/persistence/syndicate/quartermaster

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/moraleofficer
	outfit = /datum/outfit/persistence/syndicate/moraleofficer

//command spawners

/obj/effect/mob_spawn/ghost_role/human/persistence/command/masteratarms
	outfit = /datum/outfit/persistence/command/masteratarms

/obj/effect/mob_spawn/ghost_role/human/persistence/command/corporateliaison
	outfit = /datum/outfit/persistence/command/corporateliaison

/obj/effect/mob_spawn/ghost_role/human/persistence/command/admiral
	outfit = /datum/outfit/persistence/command/admiral

// Codespeak Granter

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)

/obj/effect/mob_spawn/ghost_role/human/persistence/command/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)


// Outfits --------------

/datum/outfit/persistence
	name = "Persistence"

/datum/outfit/persistence/post_equip(mob/living/carbon/human/syndicate, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = syndicate.wear_id
	if(istype(id_card))
		id_card.registered_name = syndicate.real_name
		id_card.update_label()
		id_card.update_icon()
	syndicate.apply_pref_name(/datum/preference/name/syndicate, syndicate.client)
	handlebank(syndicate)
	return ..()

//Persistence Hostage

/datum/outfit/persistence/prisoner
	name = "Persistence Syndicate Prisoner"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	shoes = /obj/item/clothing/shoes/combat
	id = /obj/item/card/id/advanced/prisoner/ds2
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/prisoner

//Persistence Roles

/obj/item/robot_model/syndicatejack/dauntless //kinda count as a outfit, nah?
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/extinguisher,
		/obj/item/weldingtool/electric,
		/obj/item/multitool/cyborg,
		/obj/item/crowbar/cyborg/power,
		/obj/item/screwdriver/cyborg/power,
		/obj/item/construction/rcd/borg/syndicate,
		/obj/item/pipe_dispenser,
		/obj/item/lightreplacer,
		/obj/item/stack/cable_coil,
		/obj/item/stack/sheet/iron,
		/obj/item/stack/rods/cyborg,
		/obj/item/stack/sheet/glass,
		/obj/item/stack/tile/iron/base/cyborg,
		/obj/item/storage/part_replacer/cyborg,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/assembly/signaler/cyborg,
		/obj/item/holosign_creator/atmos,
		/obj/item/borg/apparatus/circuit,
		/obj/item/borg/apparatus/sheet_manipulator,
		/obj/item/electroadaptive_pseudocircuit,
		/obj/item/shockpaddles/cyborg,
		/obj/item/healthanalyzer/advanced,
		/obj/item/surgical_drapes,
		/obj/item/retractor/advanced,
		/obj/item/cautery/advanced,
		/obj/item/scalpel/advanced,
		/obj/item/stack/medical/wrap/gauze,
		/obj/item/borg/cyborghug/medical,
		/obj/item/borg/lollipop,
		/obj/item/borg/apparatus/beaker,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/borg_shapeshifter/dauntless
		)

/datum/outfit/persistence/syndicate
	name = "Persistence Operative"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/syndicateciv/staff
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/choice_beacon/syndicateoffstation = 1,
		)
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless

/datum/outfit/persistence/syndicate/service
	name = "Persistence General Staff"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/syndicatestaff
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/sharpener = 1,
		/obj/item/choice_beacon/syndicateoffstation = 1,
		)
	suit = /obj/item/clothing/suit/apron/chef
	head = /obj/item/clothing/head/soft/mime

/datum/outfit/persistence/syndicate/janitor
	name = "Persistence Sanitation Technician"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/janitor
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/choice_beacon/syndicateoffstation = 1,
		/obj/item/soap/syndie = 1,
		)
	belt = /obj/item/storage/belt/janitor/full

/datum/outfit/persistence/syndicate/enginetech
	name = "Persistence Engineer"
	uniform = /obj/item/clothing/under/syndicate/skyrat/overalls
	head = /obj/item/clothing/head/soft/sec/syndicate
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/choice_beacon/syndicateoffstation/engineer = 1,
		)
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/engineer
	glasses = /obj/item/clothing/glasses/welding/up
	belt = /obj/item/storage/belt/utility/syndicate
	gloves = /obj/item/clothing/gloves/combat

/datum/outfit/persistence/syndicate/researcher
	name = "Persistence Researcher"
	uniform = /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/researcher
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	glasses = /obj/item/clothing/glasses/sunglasses/chemical
	gloves = /obj/item/clothing/gloves/color/black
	back = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/utility/syndicate

/datum/outfit/persistence/syndicate/stationmed
	name = "Persistence Medical Officer"
	uniform = /obj/item/clothing/under/syndicate/scrubs
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/medicalofficer
	suit = /obj/item/clothing/suit/toggle/labcoat/interdyne
	belt = /obj/item/storage/belt/medical/paramedic
	gloves = /obj/item/clothing/gloves/latex/nitrile/ntrauma
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/storage/medkit/surgery = 1,
		/obj/item/choice_beacon/syndicateoffstation = 1,
		)

/datum/outfit/persistence/syndicate/brigoff
	name = "Persistence Brig Officer"
	uniform = /obj/item/clothing/under/syndicate/combat
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/brigofficer
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/bulletproof/old
	back = /obj/item/storage/backpack/security
	backpack_contents = list(
		/obj/item/flashlight/seclite = 1,
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/choice_beacon/syndicateoffstation = 1,
		)
	head = /obj/item/clothing/head/helmet/swat/ds
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/redsec
	mask = /obj/item/clothing/mask/gas/syndicate
	ears = /obj/item/radio/headset/syndicateciv/staff

/datum/outfit/persistence/syndicate/quartermaster
	name = "Persistence Cargo Tech"
	uniform = /obj/item/clothing/under/syndicate/skyrat/overalls
	belt = /obj/item/storage/bag/ore
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/cargo
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/bulletproof/old
	back = /obj/item/storage/backpack/satchel/sec
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/knife/combat/survival = 1,
		/obj/item/t_scanner/adv_mining_scanner/lesser = 1,
		/obj/item/gun/energy/recharge/kinetic_accelerator = 1,
		/obj/item/choice_beacon/syndicateoffstation = 1,
		)
	mask = /obj/item/clothing/mask/gas/syndicate
	ears = /obj/item/radio/headset/syndicateciv/staff
	l_pocket = /obj/item/card/mining_point_card
	r_pocket = /obj/item/mining_voucher
	head = /obj/item/clothing/head/soft/black

/datum/outfit/persistence/syndicate/moraleofficer
	name = "Persistence Morale Officer"
	uniform = /obj/item/clothing/under/syndicate/sniper
	head = /obj/item/clothing/head/fedora
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack/satchel
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/moraleofficer
	mask = /obj/item/clothing/mask/gas/clown_hat


//gives syndicate role so turrets don't shoot operative
/datum/outfit/persistence/syndicate/post_equip(mob/living/carbon/human/syndicate)
	syndicate.add_faction(ROLE_SYNDICATE)
	return ..()

// Dauntless Command

/datum/outfit/persistence/command
	name = "Persistence Command Operative"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/syndicateciv/command
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/choice_beacon/syndicateoffstation/command = 1,
		)
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/bubberstation/dauntless

/datum/outfit/persistence/command/masteratarms
	name = "Persistence Master At Arms"
	uniform = /obj/item/clothing/under/syndicate/combat
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/masteratarms
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/vest/warden/syndicate
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/redsec
	back = /obj/item/storage/backpack/satchel/sec
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/choice_beacon/syndicateoffstation/maa =1,
		)
	head = /obj/item/clothing/head/hats/hos/beret/syndicate
	r_pocket = /obj/item/flashlight/seclite
	implants = list(
		/obj/item/implant/weapons_auth,
		/obj/item/implant/kaza_ruk
		)

/datum/outfit/persistence/command/corporateliaison
	name = "Persistence Corporate Liasion"
	uniform = /obj/item/clothing/under/syndicate/sniper
	head = /obj/item/clothing/head/fedora
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack/satchel
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/corporateliasion

/datum/outfit/persistence/command/admiral
	name = "Rig Admiral"
	uniform = /obj/item/clothing/under/rank/captain/skyrat/utility/syndicate
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/choice_beacon/syndicateoffstation/morale = 1,
		/obj/item/storage/lockbox/medal/bubber/synd = 1,
		)
	head = /obj/item/clothing/head/hats/hos/cap/syndicate
	id = /obj/item/card/id/advanced/gold/generic
	id_trim = /datum/id_trim/syndicom/bubberstation/persistence/rigmanager


//gives syndicate role so turrets don't shoot operatives
/datum/outfit/persistence/command/post_equip(mob/living/carbon/human/syndicate)
	syndicate.add_faction(ROLE_SYNDICATE)
	return ..()

//Give cyborg a specific chameleon item that do not disrupt, still lose power though.
/obj/item/borg_shapeshifter/dauntless
	signalCache = list()
