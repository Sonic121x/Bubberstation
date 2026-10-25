///This station traits gives 5 bananium sheets to the clown (and every dead clown out there in deep space or lavaland).
/datum/station_trait/bananium_shipment
	name = "香蕉矿货运"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 5
	cost = STATION_TRAIT_COST_LOW
	report_message = "据传，小丑星球一直在向本星系的小丑发送援助包裹。"
	trait_to_give = STATION_TRAIT_BANANIUM_SHIPMENTS

/datum/station_trait/bananium_shipment/get_pulsar_message()
	var/advisory_string = "预警等级：<b>小丑星球</b></center><BR>"
	advisory_string += "你所在星区的预警等级为小丑星球！我们的自行车喇叭侦测到了大量香蕉矿。小丑数据显示，大批小丑正涌入你站。强烈建议滑倒一切威胁，以保全香蕉星区内的滑稽传讯资产。情报部门建议守住化学室，防止小丑制造脱发剂或太空润滑油。"
	return advisory_string

/datum/station_trait/unnatural_atmosphere
	name = "异常大气性质"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 5
	cost = STATION_TRAIT_COST_LOW
	show_in_report = TRUE
	report_message = "本星系的行星大气性质异常。"
	trait_to_give = STATION_TRAIT_UNNATURAL_ATMOSPHERE

	// This station trait modifies the atmosphere, which is too far past the time admins are able to revert it
	can_revert = FALSE

/// Upgrades pun-pun into a big ass gorrilla.
/datum/station_trait/pun_pun_gym_day
	name = "潘潘健身日"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 1
	cost = STATION_TRAIT_COST_LOW
	show_in_report = TRUE
	report_message = "由于灵长类申领表出现文书错误，你站酒吧的猴子被升级成了更大的灵长类动物。我们决定不予纠正。"
	trait_to_give = STATION_TRAIT_PUN_PUN_GYM_DAY
	blacklist = list(/datum/station_trait/job/pun_pun) //We should make these two work together later, itd be funny.


/datum/station_trait/spider_infestation
	name = "蜘蛛泛滥"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 5
	report_message = "我们引入了天然防治手段，以减少你站的啮齿动物数量。"
	trait_to_give = STATION_TRAIT_SPIDER_INFESTATION

/datum/station_trait/unique_ai
	name = "独特 AI"
	trait_type = STATION_TRAIT_NEUTRAL
	trait_flags = parent_type::trait_flags | STATION_TRAIT_REQUIRES_AI
	weight = 5
	show_in_report = TRUE
	report_message = "出于实验目的，本站 AI 的法则集可能与默认设置不同。请勿干涉实验，我们已移除\
		你们对备用上传模块的访问权限，因为我们知道你们已经在打干涉实验的主意了。"
	trait_to_give = STATION_TRAIT_UNIQUE_AI

/datum/station_trait/unique_ai/on_round_start()
	. = ..()
	for(var/mob/living/silicon/ai/ai as anything in GLOB.ai_list)
		ai.show_laws()

/datum/station_trait/ian_adventure
	name = "伊恩的冒险"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 5
	show_in_report = FALSE
	cost = STATION_TRAIT_COST_LOW
	report_message = "伊恩去空间站里的某处探险了。"

/datum/station_trait/ian_adventure/on_round_start()
	for(var/mob/living/basic/pet/dog/corgi/dog in GLOB.mob_list)
		if(!(istype(dog, /mob/living/basic/pet/dog/corgi/ian) || istype(dog, /mob/living/basic/pet/dog/corgi/puppy/ian)))
			continue

		// Makes this station trait more interesting. Ian probably won't go anywhere without a little external help.
		// Also gives him a couple extra lives to survive eventual tiders.
		dog.deadchat_plays(DEMOCRACY_MODE|MUTE_DEMOCRACY_MESSAGES, 3 SECONDS)
		dog.AddComponent(/datum/component/multiple_lives, 2)
		RegisterSignal(dog, COMSIG_ON_MULTIPLE_LIVES_RESPAWN, PROC_REF(do_corgi_respawn))

		// The extended safety checks at time of writing are about chasms and lava
		// if there are any chasms and lava on stations in the future, woah
		var/turf/current_turf = get_turf(dog)
		var/turf/adventure_turf = find_safe_turf(extended_safety_checks = TRUE, dense_atoms = FALSE)

		// Poof!
		do_smoke(location=current_turf)
		dog.forceMove(adventure_turf)
		do_smoke(location=adventure_turf)

/// Moves the new dog somewhere safe, equips it with the old one's inventory and makes it deadchat_playable.
/datum/station_trait/ian_adventure/proc/do_corgi_respawn(mob/living/basic/pet/dog/corgi/old_dog, mob/living/basic/pet/dog/corgi/new_dog, gibbed, lives_left)
	SIGNAL_HANDLER

	var/turf/current_turf = get_turf(new_dog)
	var/turf/adventure_turf = find_safe_turf(extended_safety_checks = TRUE, dense_atoms = FALSE)

	do_smoke(location=current_turf)
	new_dog.forceMove(adventure_turf)
	do_smoke(location=adventure_turf)

	if(old_dog.inventory_back)
		var/obj/item/old_dog_back = old_dog.inventory_back
		old_dog.inventory_back = null
		old_dog_back.forceMove(new_dog)
		new_dog.inventory_back = old_dog_back

	if(old_dog.inventory_head)
		var/obj/item/old_dog_hat = old_dog.inventory_head
		old_dog.inventory_head = null
		new_dog.place_on_head(old_dog_hat)

	new_dog.update_corgi_fluff()
	new_dog.regenerate_icons()
	new_dog.deadchat_plays(DEMOCRACY_MODE|MUTE_DEMOCRACY_MESSAGES, 3 SECONDS)
	if(lives_left)
		RegisterSignal(new_dog, COMSIG_ON_MULTIPLE_LIVES_RESPAWN, PROC_REF(do_corgi_respawn))

	if(!gibbed) //The old dog will now disappear so we won't have more than one Ian at a time.
		qdel(old_dog)

/datum/station_trait/glitched_pdas
	name = "PDA 故障"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 5
	show_in_report = TRUE
	cost = STATION_TRAIT_COST_MINIMAL
	report_message = "本班次配发的 PDA 似乎出了点问题。不过没什么大碍。"
	trait_to_give = STATION_TRAIT_PDA_GLITCHED

/datum/station_trait/announcement_intern
	name = "广播实习生"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 1
	show_in_report = TRUE
	report_message = "请对他友善一点。"
	blacklist = list(/datum/station_trait/announcement_medbot, /datum/station_trait/birthday)

/datum/station_trait/announcement_intern/New()
	. = ..()
	SSstation.announcer = /datum/centcom_announcer/intern

/datum/station_trait/announcement_intern/get_pulsar_message()
	var/advisory_string = "预警等级：<b>（在此填入标题）</b></center><BR>"
	advisory_string += "（将威胁情报办公室提供的概要复制粘贴到此处。这应该没什么难度，只要记得按发送键前替换掉这条消息。另外，做完后记得为 06:00 的会议准备好咖啡。）"
	return advisory_string

/datum/station_trait/announcement_medbot
	name = "广播“系统”"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 1
	show_in_report = TRUE
	report_message = "广播系统目前正在进行计划维护。幸好我们还有备用方案。"
	blacklist = list(/datum/station_trait/announcement_intern, /datum/station_trait/birthday)

/datum/station_trait/announcement_medbot/New()
	. = ..()
	SSstation.announcer = /datum/centcom_announcer/medbot

/datum/station_trait/colored_assistants
	name = "彩衣助手"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 10
	show_in_report = TRUE
	cost = STATION_TRAIT_COST_MINIMAL
	report_message = "由于制式连身服短缺，我们为你站助手配发了一批备用服装。"
	blacklist = list(/datum/station_trait/assistant_gimmicks)

/datum/station_trait/colored_assistants/New()
	. = ..()

	var/new_colored_assistant_type = pick(subtypesof(/datum/colored_assistant) - get_configured_colored_assistant_type())
	GLOB.colored_assistant = new new_colored_assistant_type

/datum/station_trait/birthday
	name = "员工生日"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 2
	show_in_report = TRUE
	report_message = "纳米传讯全体同仁祝员工姓名生日快乐！"
	trait_to_give = STATION_TRAIT_BIRTHDAY
	blacklist = list(/datum/station_trait/announcement_intern, /datum/station_trait/announcement_medbot) //Overiding the annoucer hides the birthday person in the annoucement message.
	///Variable that stores a reference to the person selected to have their birthday celebrated.
	var/mob/living/carbon/human/birthday_person
	///Variable that holds the real name of the birthday person once selected, just incase the birthday person's real_name changes.
	var/birthday_person_name = ""
	///Variable that admins can override with a player's ckey in order to set them as the birthday person when the round starts.
	var/birthday_override_ckey

/datum/station_trait/birthday/New()
	. = ..()
	RegisterSignals(SSdcs, list(COMSIG_GLOB_JOB_AFTER_SPAWN), PROC_REF(on_job_after_spawn))

/datum/station_trait/birthday/revert()
	for (var/obj/effect/landmark/start/hangover/party_spot in GLOB.start_landmarks_list)
		QDEL_LIST(party_spot.party_debris)
	return ..()

/datum/station_trait/birthday/on_round_start()
	. = ..()
	if(birthday_override_ckey)
		if(!check_valid_override())
			message_admins("尝试将[birthday_override_ckey]设为寿星，但其并非有效的空间站角色。已改为随机选择寿星。")

	if(!birthday_person)
		var/list/birthday_options = list()
		for(var/mob/living/carbon/human/human in GLOB.human_list)
			if(human.mind?.assigned_role.job_flags & JOB_CREW_MEMBER)
				birthday_options += human
		if(length(birthday_options))
			birthday_person = pick(birthday_options)
			birthday_person_name = birthday_person.real_name
			ADD_TRAIT(birthday_person, TRAIT_BIRTHDAY_BOY, REF(src))
	addtimer(CALLBACK(src, PROC_REF(announce_birthday)), 10 SECONDS)

/datum/station_trait/birthday/proc/check_valid_override()

	var/mob/living/carbon/human/birthday_override_mob = get_mob_by_ckey(birthday_override_ckey)

	if(isnull(birthday_override_mob))
		return FALSE

	if(birthday_override_mob.mind?.assigned_role.job_flags & JOB_CREW_MEMBER)
		birthday_person = birthday_override_mob
		birthday_person_name = birthday_person.real_name
		return TRUE
	else
		return FALSE


/datum/station_trait/birthday/proc/announce_birthday()
	report_message = "纳米传讯全体同仁祝[birthday_person ? birthday_person_name : "员工姓名"]生日快乐。"
	priority_announce("祝[birthday_person ? birthday_person_name : "员工姓名"]生日快乐！纳米传讯祝你[birthday_person ? birthday_person.age + 1 : "255"]岁生日快乐。")
	if(birthday_person)
		playsound(birthday_person, 'sound/items/party_horn.ogg', 50)
		birthday_person.add_mood_event("birthday", /datum/mood_event/birthday)
		birthday_person = null

/datum/station_trait/birthday/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/spawned_mob)
	SIGNAL_HANDLER

	var/obj/item/hat = pick_weight(list(
		/obj/item/clothing/head/costume/party/festive = 12,
		/obj/item/clothing/head/costume/party = 12,
		/obj/item/clothing/head/costume/festive = 2,
		/obj/item/clothing/head/utility/hardhat/cakehat = 1,
	))
	hat = new hat(spawned_mob)
	if(!spawned_mob.equip_to_slot_if_possible(hat, ITEM_SLOT_HEAD, disable_warning = TRUE))
		spawned_mob.equip_to_storage(hat, ITEM_SLOT_BACK, indirect_action = TRUE)
	var/obj/item/toy = pick_weight(list(
		/obj/item/reagent_containers/spray/chemsprayer/party = 4,
		/obj/item/toy/balloon = 2,
		/obj/item/sparkler = 2,
		/obj/item/clothing/mask/party_horn = 2,
		/obj/item/storage/box/tail_pin = 1,
	))
	toy = new toy(spawned_mob)
	if(istype(toy, /obj/item/toy/balloon))
		spawned_mob.equip_to_slot_or_del(toy, ITEM_SLOT_HANDS) //Balloons do not fit inside of backpacks.
	else
		spawned_mob.equip_to_storage(toy, ITEM_SLOT_BACK, indirect_action = TRUE)
	if(birthday_person_name) //Anyone who joins after the annoucement gets one of these.
		var/obj/item/birthday_invite/birthday_invite = new(spawned_mob)
		birthday_invite.setup_card(birthday_person_name)
		if(!spawned_mob.equip_to_slot_if_possible(birthday_invite, ITEM_SLOT_HANDS, disable_warning = TRUE))
			spawned_mob.equip_to_storage(birthday_invite, ITEM_SLOT_BACK, indirect_action = TRUE) //Just incase someone spawns with both hands full.

/obj/item/birthday_invite
	name = "生日邀请函"
	desc = "一张写着今天是某人生日的卡片。"
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY

/obj/item/birthday_invite/proc/setup_card(birthday_name)
	desc = "一张写着今天是[birthday_name]生日的卡片。"
	icon_state = "paperslip_words"
	icon = 'icons/obj/service/bureaucracy.dmi'

/obj/item/clothing/head/costume/party
	name = "派对帽"
	desc = "一顶你必须戴上的劣质纸帽。"
	icon_state = "party_hat"
	greyscale_config =  /datum/greyscale_config/party_hat
	greyscale_config_worn = /datum/greyscale_config/party_hat/worn
	flags_inv = 0
	armor_type = /datum/armor/none
	var/static/list/hat_colors = list(
		COLOR_PRIDE_RED,
		COLOR_PRIDE_ORANGE,
		COLOR_PRIDE_YELLOW,
		COLOR_PRIDE_GREEN,
		COLOR_PRIDE_BLUE,
		COLOR_PRIDE_PURPLE,
	)

/obj/item/clothing/head/costume/party/Initialize(mapload)
	set_greyscale(colors = list(pick(hat_colors)))
	return ..()

/obj/item/clothing/head/costume/party/festive
	name = "节日纸帽"
	icon_state = "xmashat_grey"
	greyscale_config = /datum/greyscale_config/festive_hat
	greyscale_config_worn = /datum/greyscale_config/festive_hat/worn

/datum/station_trait/scryers
	name = "占卜通讯器"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 2
	cost = STATION_TRAIT_COST_LOW
	show_in_report = TRUE
	report_message = "纳米传讯选中了你站进行实验——人人免费配发占卜通讯器！用它轻松、私密地与他人交谈。"

/datum/station_trait/scryers/New()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_after_spawn))

/datum/station_trait/scryers/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/spawned, client/player_client)
	SIGNAL_HANDLER
	if(!ishuman(spawned))
		return
	var/mob/living/carbon/human/humanspawned = spawned
	// Put their silly little scarf or necktie somewhere else
	var/obj/item/silly_little_scarf = humanspawned.wear_neck
	if(silly_little_scarf)
		var/list/backup_slots = list(LOCATION_LPOCKET, LOCATION_RPOCKET, LOCATION_BACKPACK)
		humanspawned.temporarilyRemoveItemFromInventory(silly_little_scarf)
		silly_little_scarf.forceMove(get_turf(humanspawned))
		humanspawned.equip_in_one_of_slots(silly_little_scarf, backup_slots, qdel_on_fail = FALSE)

	var/obj/item/clothing/neck/link_scryer/loaded/new_scryer = new(spawned)
	new_scryer.label = spawned.name
	new_scryer.update_name()

	spawned.equip_to_slot_or_del(new_scryer, ITEM_SLOT_NECK, initial = FALSE)

/datum/station_trait/wallets
	name = "钱包！"
	trait_type = STATION_TRAIT_NEUTRAL
	show_in_report = TRUE
	weight = 5
	cost = STATION_TRAIT_COST_MINIMAL
	report_message = "使用钱包暂时成了潮流，因此站内每个人都获发了一个。"

/datum/station_trait/wallets/New()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_after_spawn))

/datum/station_trait/wallets/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/living_mob, mob/M, joined_late)
	SIGNAL_HANDLER

	var/obj/item/card/id/advanced/id_card = living_mob.get_item_by_slot(ITEM_SLOT_ID)
	if(!istype(id_card))
		return

	living_mob.temporarilyRemoveItemFromInventory(id_card, force=TRUE)

	// "Doc, what's wrong with me?"
	var/obj/item/storage/wallet/wallet = new(src)
	// "You've got a wallet embedded in your chest."
	wallet.add_fingerprint(living_mob, ignoregloves = TRUE)

	living_mob.equip_to_slot_if_possible(wallet, ITEM_SLOT_ID, initial=TRUE)

	id_card.forceMove(wallet)

	var/holochip_amount = id_card.registered_account.account_balance
	new /obj/item/holochip(wallet, holochip_amount)
	id_card.registered_account.adjust_money(-holochip_amount, "System: Withdrawal")

	new /obj/effect/spawner/random/entertainment/wallet_storage(wallet)

	// Put our filthy fingerprints all over the contents
	for(var/obj/item/item in wallet)
		item.add_fingerprint(living_mob, ignoregloves = TRUE)

/// Tells the area map generator to ADD MORE TREEEES
/datum/station_trait/forested
	name = "林木茂盛"
	trait_type = STATION_TRAIT_NEUTRAL
	trait_to_give = STATION_TRAIT_FORESTED
	trait_flags = STATION_TRAIT_PLANETARY
	weight = 10
	show_in_report = TRUE
	report_message = "外面的树可真多。"

/datum/station_trait/linked_closets
	name = "储物柜异常"
	trait_type = STATION_TRAIT_NEUTRAL
	show_in_report = TRUE
	weight = 1
	report_message = "据报告，游离的蓝空间流正在影响你站的储物柜。\
		你可能会丢失一些物品……也可能得到新的！"

/datum/station_trait/linked_closets/on_round_start()
	. = ..()
	var/list/roundstart_closets = GLOB.roundstart_station_closets.Copy()

	/**
	 * The number of links to perform. the chance of a closet being linked are about 1 in 10
	 * There are more than 220 roundstart closets on meta, so, about 22 closets will be affected on average.
	 */
	var/number_of_links = round(length(roundstart_closets) * (rand(400, 430)*0.0001), 1)
	for(var/repetition in 1 to number_of_links)
		var/list/targets = list()
		for(var/how_many in 1 to rand(2,3))
			targets += pick_n_take(roundstart_closets)
		GLOB.closet_teleport_controller.create_new_link(targets)

#define PRO_SKUB "pro-skub"
#define ANTI_SKUB "anti-skub"
#define SKUB_IDFC "i don't frikkin' care"
#define RANDOM_SKUB null //This means that if you forgot to opt in/against/out, there's a 50/50 chance to be pro or anti

/// A trait that lets players choose whether they want pro-skub or anti-skub (or neither), and receive the appropriate equipment.
/datum/station_trait/skub
	name = "斯库布大论战"
	trait_type = STATION_TRAIT_NEUTRAL
	show_in_report = FALSE
	weight = 2
	sign_up_button = TRUE
	/// List of people signed up to be either pro_skub or anti_skub
	var/list/skubbers = list()

/datum/station_trait/skub/New()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_after_spawn))

/* SKYRAT EDIT -- REMOVAL -- I swear, we need to update our UI in near future to account for the new buttons and shit
/datum/station_trait/skub/setup_lobby_button(atom/movable/screen/lobby/button/sign_up/lobby_button)
	RegisterSignal(lobby_button, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_lobby_button_update_overlays))
	lobby_button.desc = "Are you pro-skub or anti-skub? Click to cycle through pro-skub, anti-skub, random and neutral."
	return ..()

/// Let late-joiners jump on this gimmick too.
/datum/station_trait/skub/can_display_lobby_button(client/player)
	return sign_up_button

/// We don't destroy buttons on round start for those who are still in the lobby.
/datum/station_trait/skub/on_round_start()
	return

/datum/station_trait/skub/on_lobby_button_update_icon(atom/movable/screen/lobby/button/sign_up/lobby_button, location, control, params, mob/dead/new_player/user)
	var/mob/player = lobby_button.get_mob()
	var/skub_stance = skubbers[player.ckey]
	switch(skub_stance)
		if(PRO_SKUB)
			lobby_button.base_icon_state = "signup_on"
		if(ANTI_SKUB)
			lobby_button.base_icon_state = "signup"
		else
			lobby_button.base_icon_state = "signup_neutral"

/datum/station_trait/skub/on_lobby_button_click(atom/movable/screen/lobby/button/sign_up/lobby_button, updates)
	var/mob/player = lobby_button.get_mob()
	var/skub_stance = skubbers[player.ckey]
	switch(skub_stance)
		if(PRO_SKUB)
			skubbers[player.ckey] = ANTI_SKUB
			lobby_button.balloon_alert(player, "anti-skub")
		if(ANTI_SKUB)
			skubbers[player.ckey] = SKUB_IDFC
			lobby_button.balloon_alert(player, "don't care")
		if(SKUB_IDFC)
			skubbers[player.ckey] = RANDOM_SKUB
			lobby_button.balloon_alert(player, "on the best side")
		if(RANDOM_SKUB)
			skubbers[player.ckey] = PRO_SKUB
			lobby_button.balloon_alert(player, "pro-skub")

/datum/station_trait/skub/proc/on_lobby_button_update_overlays(atom/movable/screen/lobby/button/sign_up/lobby_button, list/overlays)
	SIGNAL_HANDLER
	var/mob/player = lobby_button.get_mob()
	var/skub_stance = skubbers[player.ckey]
	switch(skub_stance)
		if(PRO_SKUB)
			overlays += "pro_skub"
		if(ANTI_SKUB)
			overlays += "anti_skub"
		if(SKUB_IDFC)
			overlays += "neutral_skub"
		if(RANDOM_SKUB)
			overlays += "random_skub"
*/
/datum/station_trait/skub/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/spawned, client/player_client)
	SIGNAL_HANDLER

	var/skub_stance = skubbers[player_client.ckey]
	if(skub_stance == SKUB_IDFC)
		return

	if((skub_stance == RANDOM_SKUB && prob(50)) || skub_stance == PRO_SKUB)
		var/obj/item/storage/box/stickers/skub/boxie = new(spawned.loc)
		spawned.equip_to_storage(boxie, ITEM_SLOT_BACK, indirect_action = TRUE)
		if(ishuman(spawned))
			var/obj/item/clothing/suit/costume/wellworn_shirt/skub/shirt = new(spawned.loc)
			if(!spawned.equip_to_slot_if_possible(shirt, ITEM_SLOT_OCLOTHING, indirect_action = TRUE))
				shirt.forceMove(boxie)
		return

	var/obj/item/storage/box/stickers/anti_skub/boxie = new(spawned.loc)
	spawned.equip_to_storage(boxie, ITEM_SLOT_BACK, indirect_action = TRUE)
	if(!ishuman(spawned))
		return
	var/obj/item/clothing/suit/costume/wellworn_shirt/skub/anti/shirt = new(spawned.loc)
	if(!spawned.equip_to_slot_if_possible(shirt, ITEM_SLOT_OCLOTHING, indirect_action = TRUE))
		shirt.forceMove(boxie)

#undef PRO_SKUB
#undef ANTI_SKUB
#undef SKUB_IDFC
#undef RANDOM_SKUB

/// Crew don't ever spawn as enemies of the station. Obsesseds, blob infection, space changelings etc can still happen though
/datum/station_trait/background_checks
	name = "全站背景审查"
	report_message = "本班次，我们用一名受过训练的审查员，替换了负责船员背景审查的实习生！\
		不过，敌人可能会另寻途径潜入空间站，所以仍需小心。"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 1
	show_in_report = TRUE
	can_revert = FALSE

	dynamic_threat_id = "Background Checks"

/datum/station_trait/background_checks/New()
	. = ..()
	RegisterSignal(SSdynamic, COMSIG_DYNAMIC_PRE_ROUNDSTART, PROC_REF(modify_config))

/datum/station_trait/background_checks/proc/modify_config(datum/source, list/dynamic_config)
	SIGNAL_HANDLER

	for(var/datum/dynamic_ruleset/ruleset as anything in subtypesof(/datum/dynamic_ruleset))
		if(ruleset.ruleset_flags & RULESET_INVADER)
			continue
		dynamic_config[initial(ruleset.config_tag)] ||= list()
		dynamic_config[initial(ruleset.config_tag)][NAMEOF(ruleset, weight)] = 0
/* BUBBER EDIT REMOVAL BEGIN - Lobby buttons
/datum/station_trait/pet_day
	name = "Bring Your Pet To Work Day"
	trait_type = STATION_TRAIT_NEUTRAL
	show_in_report = FALSE
	weight = 2
	sign_up_button = TRUE

/datum/station_trait/pet_day/New()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_after_spawn))

/datum/station_trait/pet_day/setup_lobby_button(atom/movable/screen/lobby/button/sign_up/lobby_button)
	lobby_button.desc = "Want to bring your innocent pet to a giant metal deathtrap? Click here to customize it!"
	RegisterSignal(lobby_button, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_lobby_button_update_overlays))
	return ..()

/datum/station_trait/pet_day/can_display_lobby_button(client/player)
	return sign_up_button

/datum/station_trait/pet_day/on_round_start()
	return

/datum/station_trait/pet_day/on_lobby_button_click(atom/movable/screen/lobby/button/sign_up/lobby_button, updates)
	var/mob/our_player = lobby_button.get_mob()
	var/client/player_client = our_player.client
	if(isnull(player_client))
		return
	var/datum/pet_customization/customization = GLOB.customized_pets[REF(player_client)]
	if(isnull(customization))
		customization = new(player_client)
	INVOKE_ASYNC(customization, TYPE_PROC_REF(/datum, ui_interact), our_player)

/datum/station_trait/pet_day/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/spawned, client/player_client)
	SIGNAL_HANDLER

	var/datum/pet_customization/customization = GLOB.customized_pets[REF(player_client)]
	if(isnull(customization))
		return
	INVOKE_ASYNC(customization, TYPE_PROC_REF(/datum/pet_customization, create_pet), spawned, player_client)

/datum/station_trait/pet_day/proc/on_lobby_button_update_overlays(atom/movable/screen/lobby/button/sign_up/lobby_button, list/overlays)
	overlays += "select_pet"

*/// BUBBER EDIT REMOVAL END
/// We're pulling a Jim Kramer with this one boys
/datum/station_trait/gmm_spotlight
	name = "银河矿产市场财富聚焦"
	report_message = "本班次，银河矿产市场将展示船员们的财富！每次发薪时，空间站新闻终端都会公布谁拥有最多信用点。"
	trait_type = STATION_TRAIT_NEUTRAL
	trait_to_give = STATION_TRAIT_ECONOMY_ALERTS
	weight = 2
	cost = STATION_TRAIT_COST_LOW
	show_in_report = TRUE

	dynamic_threat_id = "GMM Econ Spotlight"
