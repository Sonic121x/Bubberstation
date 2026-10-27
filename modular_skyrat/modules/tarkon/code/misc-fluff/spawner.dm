//Port Tarkon, 8 people trapped in a revamped charlie-station like ghost role. Survive the aliens and threats, Fix the port and/or finish construction

/obj/effect/mob_spawn/ghost_role/human/tarkon
	name = "塔肯港船员"
	prompt_name = "港口甲板工"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "你是塔肯工业的成员，最近被派往刚刚收复的资产——塔肯港。你的上级是少尉和场站主管。"
	flavour_text = "在刚刚收复的塔肯港，你的任务是协助完成建设，并执行场站主管交办的工作。最好先看看部门公告板。（OOC提示：设计此幽灵角色时并未重点考虑等离子人或沃克斯人。虽然提供了一些让他们能够生存的设施，但他们并非塔肯港设计时的重点。上方房间中央的储物柜内有这些种族所需的“配套用品”。）"
	important_text = "不得抛弃塔肯港。其他休眠舱提供不同职业。听从场站主管和少尉的指挥。"
	outfit = /datum/outfit/tarkon
	faction = list(FACTION_TARKON)
	spawner_job_path = /datum/job/tarkon
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE
	computer_area = /area/ruin/space/has_grav/port_tarkon/centerhall
	allow_custom_character = ALL

/datum/outfit/tarkon
	name = "塔肯港默认装备"
	uniform = /obj/item/clothing/under/tarkon
	head = /obj/item/clothing/head/utility/welding/hat
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		)
	shoes = /obj/item/clothing/shoes/winterboots
	gloves = /obj/item/clothing/gloves/combat
	id = /obj/item/card/id/advanced/tarkon
	id_trim = /datum/id_trim/away/tarkon
	ears = /obj/item/radio/headset/tarkon
	var/backpack = /obj/item/storage/backpack/tarkon //bubber edit start
	var/satchel = /obj/item/storage/backpack/satchel/tarkon
	var/duffelbag = /obj/item/storage/backpack/duffelbag/tarkon
	var/messenger = /obj/item/storage/backpack/messenger/tarkon

/datum/outfit/tarkon/pre_equip(mob/living/carbon/human/tarkon, visuals_only = FALSE)
	if(ispath(back, /obj/item/storage/backpack)) //we just steal this from the job outfit datum.
		switch(tarkon.backpack)
			if(GBACKPACK)
				back = /obj/item/storage/backpack/tarkon //Tarkon backpack
			if(GSATCHEL)
				back = /obj/item/storage/backpack/satchel/tarkon  //Tarkon satchel
			if(GDUFFELBAG)
				back = /obj/item/storage/backpack/duffelbag/tarkon //Tarkon Duffel bag
			if(LSATCHEL)
				back = /obj/item/storage/backpack/satchel/leather //Leather Satchel
			if(GMESSENGER)
				back = /obj/item/storage/backpack/messenger //Grey messenger bag
			if(DSATCHEL)
				back = satchel //Department satchel
			if(DMESSENGER)
				back = messenger //Messenger Bags
			if(DDUFFELBAG)
				back = duffelbag //Department duffel bag
			if(DMESSENGER)
				back = messenger //Department messenger bag
			else
				back = backpack //Department backpack

	if(isplasmaman(tarkon))
		uniform = /obj/item/clothing/under/plasmaman
		gloves = /obj/item/clothing/gloves/color/plasmaman
		head = /obj/item/clothing/head/helmet/space/plasmaman
		r_hand = /obj/item/tank/internals/plasmaman/belt/full
	if(isvox(tarkon) || isvoxprimalis(tarkon))
		r_hand = /obj/item/tank/internals/nitrogen/belt/full
		mask = /obj/item/clothing/mask/breath/vox //bubber edit end

/datum/outfit/tarkon/post_equip(mob/living/carbon/human/tarkon, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = tarkon.wear_id
	if(istype(id_card))
		id_card.registered_name = tarkon.real_name
		id_card.update_label()
		id_card.update_icon()
	var/obj/item/radio/target_radio = tarkon.ears
	target_radio.set_frequency(FREQ_TARKON)
	target_radio.recalculateChannels()

	handlebank(tarkon)
	return ..()

/obj/effect/mob_spawn/ghost_role/human/tarkon/cargo
	name = "塔肯港补给船员"
	prompt_name = "港口打捞技师"
	outfit = /datum/outfit/tarkon/cargo

/datum/outfit/tarkon/cargo
	name = "塔肯港货运装备"
	uniform = /obj/item/clothing/under/tarkon/cargo
	glasses = /obj/item/clothing/glasses/sunglasses
	id = /obj/item/card/id/advanced/tarkon/cargo
	id_trim = /datum/id_trim/away/tarkon/cargo
	l_pocket = /obj/item/mining_voucher
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/keycard/tarkon_job_supply,
		/obj/item/crowbar = 1,
		)
	skillchips = list(/obj/item/skillchip/job/miner)

/obj/effect/mob_spawn/ghost_role/human/tarkon/sci
	name = "塔肯港科研船员"
	prompt_name = "港口研究员"
	outfit = /datum/outfit/tarkon/sci

/obj/effect/mob_spawn/ghost_role/human/tarkon/service
	name = "塔肯港服务船员"
	prompt_name = "塔肯港厨师兼清洁工"
	outfit = /datum/outfit/tarkon/service

/datum/outfit/tarkon/service
	name = "塔肯港服务装备"
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/advanced/tarkon/service
	id_trim = /datum/id_trim/away/tarkon/service
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/keycard/tarkon_job_service,
		/obj/item/crowbar = 1,
		)
	skillchips = list(/obj/item/skillchip/chefs_kiss, /obj/item/skillchip/intj)

/datum/outfit/tarkon/sci
	name = "塔肯港科研装备"
	uniform = /obj/item/clothing/under/tarkon/sci
	glasses = /obj/item/clothing/glasses/hud/diagnostic
	id = /obj/item/card/id/advanced/tarkon/sci
	id_trim = /datum/id_trim/away/tarkon/sci
	r_pocket = /obj/item/stock_parts/power_store/cell/high
	l_pocket = /obj/item/card/id/away/tarkonrobo
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/keycard/tarkon_job_rnd,
		)
	skillchips = list(/obj/item/skillchip/job/roboticist)

/obj/effect/mob_spawn/ghost_role/human/tarkon/med
	name = "塔肯港医疗船员"
	prompt_name = "港口创伤医护"
	outfit = /datum/outfit/tarkon/med

/datum/outfit/tarkon/med
	name = "塔肯港医疗装备"
	uniform = /obj/item/clothing/under/tarkon/med
	glasses = /obj/item/clothing/glasses/hud/health
	id = /obj/item/card/id/advanced/tarkon/med
	id_trim = /datum/id_trim/away/tarkon/med
	neck = /obj/item/clothing/neck/stethoscope
	l_pocket = /obj/item/healthanalyzer
	r_pocket = /obj/item/stack/medical/suture/medicated
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/keycard/tarkon_job_med,
		)
	skillchips = list(/obj/item/skillchip/entrails_reader)

/obj/effect/mob_spawn/ghost_role/human/tarkon/engi
	name = "塔肯港工程船员"
	prompt_name = "港口维护工程师"
	outfit = /datum/outfit/tarkon/engi

/datum/outfit/tarkon/engi
	name = "塔肯港工程装备"
	uniform = /obj/item/clothing/under/tarkon/eng
	glasses = /obj/item/clothing/glasses/meson/engine/tray
	id = /obj/item/card/id/advanced/tarkon/engi
	id_trim = /datum/id_trim/away/tarkon/eng
	neck = /obj/item/clothing/neck/security_cape/tarkon
	l_hand = /obj/item/inducer
	l_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	r_pocket = /obj/item/stack/cable_coil
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/keycard/tarkon_job_engi,
		)
	skillchips = list(/obj/item/skillchip/job/engineer)

/obj/effect/mob_spawn/ghost_role/human/tarkon/sec
	name = "塔肯港安保船员"
	prompt_name = "港口安保人员"
	outfit = /datum/outfit/tarkon/sec

/datum/outfit/tarkon/sec
	name = "塔肯港安保装备"
	uniform = /obj/item/clothing/under/tarkon/sec
	glasses = /obj/item/clothing/glasses/hud/security/redsec
	gloves = /obj/item/clothing/gloves/tackler/combat
	neck = /obj/item/clothing/neck/security_cape/tarkon
	id = /obj/item/card/id/advanced/tarkon/sec
	id_trim = /datum/id_trim/away/tarkon/sec
	l_pocket = /obj/item/melee/baton/telescopic
	r_pocket = /obj/item/grenade/barrier
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/keycard/tarkon_job_sec,
		)
	skillchips = list(/obj/item/skillchip/chameleon/reload)

/obj/effect/mob_spawn/ghost_role/human/tarkon/ensign
	name = "塔肯港少尉"
	prompt_name = "被遗弃的少尉"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper-o"
	you_are_text = "塔肯工业派你前往塔肯港担任基层指挥人员。你的上级是场站主管。"
	flavour_text = "作为副指挥，你通常带领其他塔肯成员执行外勤任务，而场站主管留守港口。（OOC提示：设计此幽灵角色时并未重点考虑等离子人或沃克斯人。虽然提供了一些让他们能够生存的设施，但他们并非塔肯港设计时的重点。上方房间中央的储物柜内有这些种族所需的“配套用品”。）"
	important_text = "不得无故抛弃塔肯港。你可以前往可到达的Z层及空间站，也可以组织探险队。"
	outfit = /datum/outfit/tarkon/ensign
	spawner_job_path = /datum/job/tarkon

/datum/outfit/tarkon/ensign //jack of all trades, master of none, spent all his credits, every last one
	name = "塔肯港少尉装备"
	uniform = /obj/item/clothing/under/tarkon/com
	ears = /obj/item/radio/headset/tarkon/command
	id = /obj/item/card/id/advanced/tarkon/ensign
	id_trim = /datum/id_trim/away/tarkon/ensign
	neck = /obj/item/clothing/neck/security_cape/tarkon
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/keycard/tarkon_job_ensign,
		)
	skillchips = list(/obj/item/skillchip/chameleon/reload)

/obj/effect/mob_spawn/ghost_role/human/tarkon/director
	name = "塔肯港场站主管"
	prompt_name = "港口场站主管"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "你是新上任的塔肯港场站主管。除你自己的意志与塔肯工业外，没有其他上级。"
	flavour_text = "在刚刚收复的塔肯港，你负责监督船员，维持港口运转。（OOC提示：设计此幽灵角色时并未重点考虑等离子人或沃克斯人。虽然提供了一些让他们能够生存的设施，但他们并非塔肯港设计时的重点。上方房间中央的储物柜内有这些种族所需的“配套用品”。）"
	important_text = "不得抛弃塔肯港。其他休眠舱提供不同职业。"
	outfit = /datum/outfit/tarkon/director
	spawner_job_path = /datum/job/tarkon

/datum/outfit/tarkon/director //Look at me, I'm the director now.
	name = "塔肯港主管装备"
	uniform = /obj/item/clothing/under/tarkon/com
	ears = /obj/item/radio/headset/tarkon/command
	id = /obj/item/card/id/advanced/tarkon/director
	id_trim = /datum/id_trim/away/tarkon/director
	neck = /obj/item/clothing/neck/security_cape/tarkon
	r_pocket = /obj/item/card/id/away/tarkonrobo
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/crowbar = 1,
		/obj/item/keycard/tarkon_job_command,
		)
	skillchips = list(/obj/item/skillchip/chameleon/reload)

/obj/machinery/computer/cryopod/tarkon
	radio = /obj/item/radio/headset/tarkon
	announcement_channel = RADIO_CHANNEL_TARKON
	req_one_access = list("tarkon")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/computer/cryopod/tarkon, 32)

////////////////////// Corpse/Mob Spawners Below

/datum/outfit/tarkon/loot
	name = "已故塔肯少尉装备"
	uniform = /obj/item/clothing/under/tarkon/com
	ears = /obj/item/radio/headset/tarkon/command
	id = /obj/item/card/id/advanced/tarkon/ensign
	id_trim = /datum/id_trim/away/tarkon/ensign
	neck = /obj/item/clothing/neck/security_cape/tarkon
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/mod/control/pre_equipped/tarkon
	backpack_contents = list(/obj/item/trench_tool)

/obj/effect/mob_spawn/corpse/human/tarkon
	icon_state = "corpseminer"
	outfit = /datum/outfit/tarkon/loot

/obj/structure/spawner/tarkon_xenos
	name = "虫害地穴"
	desc = "一道深不见底、光线无法触及的隧道，里面传来遥远的咆哮……"
	icon_state = "hole"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	pressure_resistance = 200 //No more pressure cheating. Burn it and its reward or fight.
	max_integrity = 500
	max_mobs = 7
	spawn_time = 20 SECONDS
	mob_types = list(
		/mob/living/basic/alien/drone/tarkon,
		/mob/living/basic/alien/sentinel
	)
	spawn_text = "爬出"
	faction = list(ROLE_ALIEN)
	var/boss_mob = /mob/living/basic/alien/queen/large
	var/loot_drop = /obj/effect/mob_spawn/corpse/human/tarkon

/obj/structure/spawner/tarkon_xenos/atom_deconstruct(disassembled)
	var/obj/effect/nest_break/nest = new /obj/effect/nest_break(loc)
	nest.loot_drop = loot_drop
	nest.boss_mob = boss_mob
	return ..()

/obj/effect/nest_break
	name = "正在坍塌的虫巢"
	desc = "别愣着，快躲开！"
	layer = TABLE_LAYER
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	icon_state = "hole"
	anchored = TRUE
	density = TRUE
	var/boss_mob = null
	var/loot_drop = null

/obj/effect/nest_break/proc/rustle()
	for(var/mob/M in range(7,src))
		shake_camera(M, 15, 1)
	playsound(get_turf(src),'sound/effects/explosion/explosionfar.ogg', 200, TRUE)
	visible_message(span_boldannounce("巢穴入口开始崩塌，随后有什么东西冲了出来！"))
	new boss_mob(loc)
	new loot_drop(loc)
	qdel(src)

/obj/effect/nest_break/Initialize(mapload)
	. = ..()
	visible_message(span_boldannounce("巢穴剧烈轰鸣，入口开始开裂崩塌！"))
	playsound(loc,'sound/effects/tendril_destroyed.ogg', 200, FALSE, 50, TRUE, TRUE)
	addtimer(CALLBACK(src, PROC_REF(rustle)), 5 SECONDS)
	do_jiggle_sr()

/obj/structure/spawner/tarkon_xenos/common
	name = "虫巢"
	desc = "布满杂草的深隧道，里面似乎有什么东西在活动……"
	icon_state = "hole"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	max_integrity = 300
	max_mobs = 4
	spawn_time = 30 SECONDS
	boss_mob = /mob/living/basic/alien/queen
	loot_drop = /obj/effect/spawner/random/astrum/sci_loot/tarkon

/obj/structure/spawner/tarkon_xenos/minor
	name = "虫害隧道"
	desc = "布满杂草的隧道，深处传来咔嗒声……"
	icon_state = "hole"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	max_integrity = 150
	max_mobs = 2
	spawn_time = 30 SECONDS
	mob_types = list(
		/mob/living/basic/alien/drone
	)
	boss_mob = /mob/living/basic/alien/sentinel
	loot_drop = /obj/effect/spawner/random/exotic/technology/tarkon

/obj/effect/spawner/random/astrum/sci_loot/tarkon
	name = "绑架者科学家战利品"
	loot = list(/obj/item/circular_saw/alien = 10,
				/obj/item/retractor/alien = 10,
				/obj/item/scalpel/alien = 10,
				/obj/item/hemostat/alien = 10,
				/obj/item/crowbar/abductor = 10,
				/obj/item/screwdriver/abductor = 10,
				/obj/item/wrench/abductor = 10,
				/obj/item/weldingtool/abductor = 10,
				/obj/item/crowbar/abductor = 10,
				/obj/item/wirecutters/abductor = 10,
				/obj/item/multitool/abductor = 10,
				)

/obj/effect/spawner/random/exotic/technology/tarkon
	spawn_loot_count = 1 //we just need one.
