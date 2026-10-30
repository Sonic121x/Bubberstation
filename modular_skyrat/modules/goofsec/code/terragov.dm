#define TERRAGOV_AMT "amount"
#define TERRAGOV_VOTES "votes"
#define TERRAGOV_DECLARED "declared"
#define TERRAGOV_FINE_AMOUNT -20000

#define EMERGENCY_RESPONSE_POLICE "WOOP WOOP THAT'S THE SOUND OF THE POLICE"
#define EMERGENCY_RESPONSE_ATMOS "DISCO INFERNO"
#define EMERGENCY_RESPONSE_EMT "AAAAAUGH, I'M DYING, I NEEEEEEEEEED A MEDIC BAG"
#define EMERGENCY_RESPONSE_EMAG "AYO THE PIZZA HERE"

GLOBAL_VAR(caller_of_911)
GLOBAL_VAR(call_911_msg)
GLOBAL_VAR(pizza_order)
GLOBAL_VAR_INIT(terragov_tech_charge, -7500)
GLOBAL_LIST_INIT(pizza_names, list(
	"Dixon Buttes",
	"I. C. Weiner",
	"Seymour Butz",
	"I. P. Freely",
	"Pat Myaz",
	"Vye Agra",
	"Harry Balsack",
	"Lee Nover",
	"Maya Buttreeks",
	"Amanda Hugginkiss",
	"Bwight K. Brute", // Github Copilot suggested dwight from the office like 10 times
	"John Nanotrasen",
	"Mike Rotch",
	"Hugh Jass",
	"Oliver Closeoff",
	"Hugh G. Recktion",
	"Phil McCrevis",
	"Willie Lickerbush",
	"Ben Dover",
	"Steve", // REST IN PEACE MAN
	"Avery Goodlay",
	"Anne Fetamine",
	"Amanda Peon",
	"Tara Newhole",
	"Penny Tration",
	"Joe Mama"
))
GLOBAL_LIST_INIT(emergency_responders, list())
GLOBAL_LIST_INIT(terragov_responder_info, list(
	"911_responders" = list(
		TERRAGOV_AMT = 0,
		TERRAGOV_VOTES = 0,
		TERRAGOV_DECLARED = FALSE
	),
	"swat" = list(
		TERRAGOV_AMT = 0,
		TERRAGOV_VOTES = 0,
		TERRAGOV_DECLARED = FALSE
	),
	"national_guard" = list(
		TERRAGOV_AMT = 0,
		TERRAGOV_VOTES = 0,
		TERRAGOV_DECLARED = FALSE
	),
	"dogginos" = list(
		TERRAGOV_AMT = 0,
		TERRAGOV_VOTES = 0,
		TERRAGOV_DECLARED = FALSE
	),
	"dogginos_manager" = list(
		TERRAGOV_AMT = 0,
		TERRAGOV_VOTES = 0,
		TERRAGOV_DECLARED = FALSE
	)
))
GLOBAL_LIST_INIT(call911_do_and_do_not, list(
	EMERGENCY_RESPONSE_EMT = "在下列情况下你“应当”呼叫急救医疗队：\n\
		大量或过多的尸体、空间站无法处理的紧急医疗状况等等。\n\
		在下列情况下你“不应当”呼叫急救医疗队：\n\
		舰长撞到了脚趾、一具或两具尸体、小规模病毒爆发等等。\n\
		你确定要呼叫急救医疗队吗？",
	EMERGENCY_RESPONSE_POLICE = "在下列情况下你“应当”呼叫执法官：\n\
		安保部无视指挥部、安保部侵犯公民权利、安保部参与哗变、 \
		指挥部/安保部普遍侵犯地球政府公民权利等等。\n\
		在下列情况下你“不应当”呼叫执法官：\n\
		公司事务、追捕逃犯、调解争吵等等。\n\
		你确定要呼叫执法官吗？",
	EMERGENCY_RESPONSE_ATMOS = "在下列情况下你“应当”呼叫高级大气工程队：\n\
		全站大气泄漏、需要大规模处理超物质崩解相关的维修、走廊里无尽的火势，或工程部与大气部无力应对的部门级破口等等。 \n\
		在下列情况下你“不应当”呼叫高级大气工程队：\n\
		图书馆里一个着火的垃圾桶、单个房间破口、供暖问题等等——尤其是在有能干的工程师/大气技术员在场时。\n\
		每名应急响应人员会收取 [abs(GLOB.terragov_tech_charge)] 信用点的响应费用。\n\
		你确定要呼叫高级大气工程队吗？"
))

/// Internal. Polls ghosts and sends in a team of space cops according to the alert level, accompanied by an announcement.
/obj/machinery/computer/communications/proc/call_911(ordered_team)
	var/team_size
	var/cops_to_send
	var/announcement_message = "sussus amogus"
	var/announcer = "地球政府执法部"
	var/poll_question = "fuck you leatherman"
	var/cell_phone_number = "911"
	var/list_to_use = "911_responders"
	switch(ordered_team)
		if(EMERGENCY_RESPONSE_POLICE)
			team_size = 8
			cops_to_send = /datum/antagonist/ert/request_911/police
			announcement_message = "[station_name()] 的船员们，这里是地球政府。我们收到了一份要求执法官立即支援的请求，现已派出 \
				最优秀的执法官前往支援你们的空间站。\n\n\
				如果首批响应人员认为执行任务需要特警支援，或需要举报一通虚假的 911 呼叫，我们会额外派出人员，费用由你站承担，金额为 \
				20,000 美元。\n\n\
				通话记录如下：\n\
				[GLOB.call_911_msg]"
			announcer = "地球政府执法部"
			poll_question = "空间站呼叫了执法官。你愿意响应吗？"
		if(EMERGENCY_RESPONSE_ATMOS)
			team_size = tgui_input_number(usr, "你想派出几名技术员？", "你捅的娄子有多大？", 3, 3, 1)
			cops_to_send = /datum/antagonist/ert/request_911/atmos
			announcement_message = "[station_name()] 的船员们，这里是地球政府 811 调度中心。我们收到报告称你站出现全站结构损伤、大气泄漏、火灾或其他情况，现已 \
				派出一支高级大气工程队前往支援你们的空间站。\n\n\
				通话记录如下：\n\
				[GLOB.call_911_msg]"
			announcer = "地球政府 811 调度中心——高级大气工程队"
			poll_question = "空间站呼叫了高级工程支援小队。你愿意响应吗？"
			cell_phone_number = "911"	//This needs to stay so they can communicate with SWAT
		if(EMERGENCY_RESPONSE_EMT)
			team_size = 8
			cops_to_send = /datum/antagonist/ert/request_911/emt
			announcement_message = "[station_name()] 的船员们，这里是地球政府。我们收到了一份要求医疗立即支援的请求，现已派出 \
				最优秀的急救医疗技术员前往支援你们的空间站。\n\n\
				如果首批响应人员认为执行任务需要特警支援，或需要举报一通虚假的 911 呼叫，我们会额外派出人员，费用由你站承担，金额为 \
				20,000 美元。\n\n\
				通话记录如下：\n\
				[GLOB.call_911_msg]"
			announcer = "地球政府急救医疗队"
			poll_question = "空间站呼叫了医疗支援。你愿意响应吗？"
		if(EMERGENCY_RESPONSE_EMAG)
			team_size = 8
			cops_to_send = /datum/antagonist/ert/pizza/false_call
			announcement_message = "感谢你向多吉诺披萨店下单，[GLOB.pizza_order]！我们马上就把那份超大派对套餐披萨 \
				送过去！\n\n\
				感谢你选择我们的尊享“十五分钟内送达”服务！得益于所有多吉诺配送穿梭机都安装的闪电般曲速引擎，我们的披萨将尽快 \
				送到 [station_name()] 的门口！\n\
				距你所选多吉诺门店的距离：70,000 光年"
			announcer = "多吉诺披萨店"
			poll_question = "空间站订购了价值 35,000 美元的披萨。你愿意去配送吗？"
			cell_phone_number = "Dogginos"
			list_to_use = "dogginos"
	priority_announce(announcement_message, announcer, 'sound/effects/families_police.ogg', has_important_message=TRUE, color_override = "yellow")
	var/list/candidates = SSpolling.poll_ghost_candidates(poll_question, check_jobban = "deathsquad", alert_pic = /obj/item/card/id/advanced/terragov, role_name_text = "地球政府响应小队")

	if(candidates.len)
		//Pick the (un)lucky players
		var/agents_number = min(team_size, candidates.len)

		var/list/spawnpoints = GLOB.emergencyresponseteamspawn
		var/index = 0
		GLOB.terragov_responder_info[list_to_use][TERRAGOV_AMT] = agents_number
		while(agents_number && candidates.len)
			var/spawn_loc = spawnpoints[index + 1]
			//loop through spawnpoints one at a time
			index = (index + 1) % spawnpoints.len
			var/mob/dead/observer/chosen_candidate = pick(candidates)
			candidates -= chosen_candidate
			if(!chosen_candidate.key)
				continue

			//Spawn the body
			var/mob/living/carbon/human/cop = new(spawn_loc)
			chosen_candidate.client.prefs.safe_transfer_prefs_to(cop, is_antag = TRUE)
			cop.key = chosen_candidate.key

			//Give antag datum
			var/datum/antagonist/ert/request_911/ert_antag = new cops_to_send

			cop.mind.add_antag_datum(ert_antag)
			cop.mind.set_assigned_role(SSjob.get_job_type(ert_antag.ert_job_path))
			SSjob.send_to_late_join(cop)
			cop.grant_language(/datum/language/common, source = LANGUAGE_SPAWNER)

			if(cops_to_send == /datum/antagonist/ert/request_911/atmos) // charge for atmos techs
				var/datum/bank_account/station_balance = SSeconomy.get_dep_account(ACCOUNT_CAR)
				station_balance?.adjust_money(GLOB.terragov_tech_charge)
			else
				var/obj/item/gangster_cellphone/phone = new() // biggest gang in the city
				phone.gang_id = cell_phone_number
				phone.name = "[cell_phone_number] 品牌手机"
				phone.w_class = WEIGHT_CLASS_SMALL	//They get that COMPACT phone hell yea
				var/phone_equipped = phone.equip_to_best_slot(cop)
				if(!phone_equipped)
					to_chat(cop, "你的 [phone.name] 已被放在你的脚边。")
					phone.forceMove(get_turf(cop))

			//Logging and cleanup
			log_game("[key_name(cop)] 已被选中担任 [ert_antag.name]。")
			if(cops_to_send == /datum/antagonist/ert/request_911/atmos)
				log_game("已从空间站预算中为 [key_name(cop)] 扣除 [abs(GLOB.terragov_tech_charge)]。")
			agents_number--
	GLOB.cops_arrived = TRUE
	return TRUE

/obj/machinery/computer/communications/proc/pre_911_check(mob/user)
	if (!authenticated_as_silicon_or_captain(user))
		return FALSE

	if (GLOB.cops_arrived)
		to_chat(user, span_warning("本班次已经呼叫过 911 了！"))
		playsound(src, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)
		return FALSE

	if (!issilicon(user))
		var/obj/item/held_item = user.get_active_held_item()
		var/obj/item/card/id/id_card = held_item?.GetID()
		if (!istype(id_card))
			to_chat(user, span_warning("你需要刷一下你的 ID！"))
			playsound(src, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)
			return FALSE
		if (!(ACCESS_CAPTAIN in id_card.access))
			to_chat(user, span_warning("你无权这么做！"))
			playsound(src, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)
			return FALSE
	else
		to_chat(user, "控制台拒绝让你以人工智能或半机械人的身份拨打 911！")
		return FALSE
	return TRUE

/obj/machinery/computer/communications/proc/calling_911(mob/user, called_group_pretty = "急救医疗队", called_group = EMERGENCY_RESPONSE_EMT)
	message_admins("[ADMIN_LOOKUPFLW(user)] 正在考虑呼叫地球政府[called_group_pretty]。")
	var/call_911_msg_are_you_sure = "你确定要拨打 911 吗？虚假的 911 呼叫会导致 20,000 美元罚款以及 5 年超级监狱 \
		刑期。"
	if(tgui_alert(user, call_911_msg_are_you_sure, "拨打 911", list("No", "Yes")) != "Yes")
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] 已确认知晓虚假 911 呼叫的后果。")
	if(tgui_alert(user, GLOB.call911_do_and_do_not[called_group], "呼叫[called_group_pretty]", list("No", "Yes")) != "Yes")
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] 已阅读并确认关于何时应当与不应当呼叫[called_group_pretty]的建议。")
	var/reason_to_call_911 = tgui_input_text(user, "你想为了什么呼叫 911 [called_group_pretty]？", "拨打 911", null, MAX_MESSAGE_LEN)
	if(!reason_to_call_911)
		to_chat(user, "你决定不拨打 911。")
		return
	GLOB.cops_arrived = TRUE
	GLOB.call_911_msg = reason_to_call_911
	GLOB.caller_of_911 = user.name
	log_game("[key_name(user)] 因以下原因呼叫了地球政府[called_group_pretty]：\n[GLOB.call_911_msg]")
	message_admins("[ADMIN_LOOKUPFLW(user)] 因以下原因呼叫了地球政府[called_group_pretty]：\n[GLOB.call_911_msg]")
	deadchat_broadcast(" 因以下原因呼叫了地球政府[called_group_pretty]：\n[GLOB.call_911_msg]", span_name("[user.real_name]"), user, message_type = DEADCHAT_ANNOUNCEMENT)

	call_911(called_group)
	to_chat(user, span_notice("授权已确认。911 呼叫已派往地球政府[called_group_pretty]。"))
	playsound(src, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)

/datum/antagonist/ert/request_911
	name = "911 响应人员"
	antag_hud_name = "hud_spacecop"
	suicide_cry = "为了地球政府！！"
	var/department = "某堆破事"

/datum/antagonist/ert/request_911/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>你不是纳米传讯的员工。你为地球政府工作，职务是[role]。</font></B>"
	missiondesc += "<BR>你正在响应空间站的紧急呼叫，为地球政府[department]提供即时援助！\n"
	missiondesc += "<BR>使用背包里的手机与其他首批响应人员联络！\n"
	missiondesc += "<BR><B>911 通话记录如下</B>："
	missiondesc += "<BR> [GLOB.call_911_msg]"
	missiondesc += "<BR><B>你的任务</B>："
	missiondesc += "<BR> <B>1.</B> 联系 [GLOB.caller_of_911] 并协助他们解决问题。"
	missiondesc += "<BR> <B>2.</B> 保护、确保并维护 [station_name()] 上地球政府公民的权利。"
	missiondesc += "<BR> <B>3.</B> 如果你认为自己陷入危险、因危险状况无法完成被指派的工作， \
		或认为这通 911 呼叫是误报，你可以使用背包里的特警支援呼叫器，投票请求派一支特警队来协助处理。"
	missiondesc += "<BR> <B>4.</B> 当你在空间站上的工作结束后，使用背包里的传送离场工具，把你自己 \
		以及你正在拖拽的人一起传送离场。"
	to_chat(owner, missiondesc)
	var/mob/living/greeted_mob = owner.current
	greeted_mob.playsound_local(greeted_mob, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/outfit/request_911
	name = "911 Response: Base"
	back = /obj/item/storage/backpack/duffelbag/cops
	backpack_contents = list(/obj/item/terragov_reporter/swat_caller = 1)

	id_trim = /datum/id_trim/space_police

/datum/outfit/request_911/post_equip(mob/living/carbon/human/human_to_equip, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/ID_to_give = human_to_equip.wear_id
	if(istype(ID_to_give))
		shuffle_inplace(ID_to_give.access) // Shuffle access list to make NTNet passkeys less predictable
		ID_to_give.registered_name = human_to_equip.real_name
		if(human_to_equip.age)
			ID_to_give.registered_age = human_to_equip.age
		ID_to_give.update_label()
		ID_to_give.update_icon()
		human_to_equip.update_ID_card()

/obj/item/modular_computer/pda/request_911
	name = "地球政府 PDA"
	desc = "一台小型实验性微型计算机，达到了地球政府 911 响应人员的标准。"
	icon_state = "/obj/item/modular_computer/pda/request_911"
	greyscale_config = /datum/greyscale_config/tablet/captain
	greyscale_colors = "#EAEAEA#66CCFF#FFCC00#5F5F5F"
	max_capacity = parent_type::max_capacity * 2
	inserted_item = /obj/item/pen/fountain
	long_ranged = TRUE
	starting_programs = list(
	)

/obj/item/modular_computer/pda/request_911/police
	name = "地球政府执法官 PDA"
	icon_state = "/obj/item/modular_computer/pda/request_911/police"
	greyscale_colors = "#EAEAEA#66CCFF#FFD900#CC5075"
	inserted_item = /obj/item/pen/red/security
	starting_programs = list(
		/datum/computer_file/program/records/security,
	)

/obj/item/modular_computer/pda/request_911/atmos
	name = "地球政府大气部 PDA"
	icon_state = "/obj/item/modular_computer/pda/request_911/atmos"
	greyscale_colors = "#EAEAEA#66CCFF#FFD900#7DDEFF"
	starting_programs = list(
		/datum/computer_file/program/atmosscan,
		/datum/computer_file/program/alarm_monitor,
		/datum/computer_file/program/supermatter_monitor,
	)

/obj/item/modular_computer/pda/request_911/emt
	name = "地球政府医疗部 PDA"
	icon_state = "/obj/item/modular_computer/pda/request_911/emt"
	greyscale_colors = "#EAEAEA#66CCFF#FFD900#7284D4"
	starting_programs = list(
		/datum/computer_file/program/records/medical,
		/datum/computer_file/program/radar/lifeline,
		/datum/computer_file/program/supermatter_monitor,
	)

/*
*	POLICE
*/

/datum/antagonist/ert/request_911/police
	name = "执法官"
	role = "执法官"
	department = "执法官"
	outfit = /datum/outfit/request_911/police

/datum/outfit/request_911/police
	name = "911 Response: Marshal"
	back = /obj/item/storage/backpack/satchel
	uniform = /obj/item/clothing/under/sol_peacekeeper
	suit = /obj/item/clothing/suit/armor/vest/det_suit/terra
	gloves = /obj/item/clothing/gloves/color/white
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_sec/alt
	head = /obj/item/clothing/head/soft/black
	suit_store = /obj/item/gun/energy/disabler
	belt = /obj/item/storage/belt/security/full
	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/gun/ballistic/revolver/sol
	id = /obj/item/card/id/advanced/terragov
	accessory = /obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed911
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/ammo_box/c35sol = 1,
		/obj/item/terragov_reporter/swat_caller = 1,
		/obj/item/beamout_tool = 1,
		/obj/item/taperecorder = 1,
		/obj/item/storage/box/evidence = 1,
		/obj/item/modular_computer/pda/request_911/police = 1,
		/obj/item/holosign_creator/security = 1,
	)

	id_trim = /datum/id_trim/terragov

/*
*	ADVANCED ATMOSPHERICS
*/

/datum/antagonist/ert/request_911/atmos
	name = "高级大气技术员"
	role = "高级大气技术员"
	department = "高级大气工程队"
	outfit = /datum/outfit/request_911/atmos

/datum/outfit/request_911/atmos
	name = "811 Response: Advanced Atmospherics"
	back = /obj/item/mod/control/pre_equipped/advanced/atmos
	uniform = /obj/item/clothing/under/rank/engineering/atmospheric_technician/skyrat/utility/advanced
	shoes = /obj/item/clothing/shoes/jackboots/peacekeeper
	ears = /obj/item/radio/headset/headset_terragov/atmos
	mask = /obj/item/clothing/mask/gas/atmos/glass
	belt = /obj/item/storage/belt/utility/full/powertools/ircd
	suit_store = /obj/item/tank/internals/oxygen/yellow
	id = /obj/item/card/id/advanced/terragov
	r_pocket = /obj/item/modular_computer/pda/request_911/atmos
	l_pocket = /obj/item/holosign_creator/atmos
	accessory = /obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed811
	backpack_contents = list(/obj/item/storage/box/rcd_ammo = 1,
		/obj/item/storage/box/smart_metal_foam = 1,
		/obj/item/multitool = 1,
		/obj/item/extinguisher/advanced = 1,
		/obj/item/rwd/loaded = 1,
		/obj/item/beamout_tool = 1,
		/obj/item/terragov_reporter/swat_caller = 1,
		/obj/item/inducer = 1,
	)
	id_trim = /datum/id_trim/terragov/atmos

/obj/item/radio/headset/headset_terragov/atmos
	name = "\improper 地球政府高级大气耳机"
	desc = "地球政府响应小队使用的耳机。"
	icon_state = "med_headset"
	keyslot = /obj/item/encryptionkey/headset_terragov/atmos
	radiosound = 'modular_skyrat/modules/radiosound/sound/radio/security.ogg'

/obj/item/encryptionkey/headset_terragov/atmos
	name = "\improper 地球政府高级大气加密密钥"
	icon_state = "/obj/item/encryptionkey/headset_terragov/atmos"
	post_init_icon_state = "cypherkey_medical"
	special_channels = RADIO_SPECIAL_CENTCOM
	channels = list(RADIO_CHANNEL_TERRAGOV = 1, RADIO_CHANNEL_ENGINEERING = 1, RADIO_CHANNEL_COMMAND = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_medical
	greyscale_colors = "#ebebeb#2b2793"

/*
*	EMT
*/

/datum/antagonist/ert/request_911/emt
	name = "急救医疗技术员"
	role = "急救员"
	department = "急救医疗队"
	outfit = /datum/outfit/request_911/emt

/datum/outfit/request_911/emt
	name = "911 Response: EMT"
	back = /obj/item/storage/backpack/medic
	uniform = /obj/item/clothing/under/sol_emt
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/headset_med
	mask = /obj/item/clothing/mask/gas/alt
	head = /obj/item/clothing/head/helmet/toggleable/sf_hardened/emt
	id = /obj/item/card/id/advanced/terragov
	suit = /obj/item/clothing/suit/armor/sf_hardened/emt
	gloves = /obj/item/clothing/gloves/latex/nitrile
	belt = /obj/item/storage/backpack/duffelbag/deforest_medkit/stocked
	suit_store = /obj/item/tank/internals/emergency_oxygen/engi
	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/storage/medkit/civil_defense
	r_hand = /obj/item/storage/backpack/duffelbag/deforest_surgical/stocked
	accessory = /obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/emergency_bed = 1,
		/obj/item/terragov_reporter/swat_caller = 1,
		/obj/item/beamout_tool = 1,
		/obj/item/defibrillator/compact/loaded = 1,
		/obj/item/modular_computer/pda/request_911/emt = 1,
		/obj/item/holosign_creator/medical = 1,
		/obj/item/holosign_creator/medical/treatment_zone = 1,
	)

	id_trim = /datum/id_trim/terragov

/datum/antagonist/ert/request_911/condom_destroyer
	name = "武装特警"
	role = "特警"
	department = "警察"
	outfit = /datum/outfit/request_911/condom_destroyer

/datum/antagonist/ert/request_911/condom_destroyer/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>你不是纳米传讯的员工。你为地球政府工作，职务是[role]。</font></B>"
	missiondesc += "<BR>你在这里是为 911 首批响应人员提供支援，因为他们已请求你的协助。\n"
	missiondesc += "<BR><B>你的任务</B>："
	missiondesc += "<BR> <B>1.</B> 使用背包里的手机联系首批响应人员，弄清当前状况。"
	missiondesc += "<BR> <B>2.</B> 逮捕任何妨碍首批响应人员工作的人。"
	missiondesc += "<BR> <B>3.</B> 若嫌疑人拒不就范，或空间站拒绝配合，可在逮捕中使用致命武力。"
	missiondesc += "<BR> <B>4.</B> 如果你认为空间站正在从事叛国行为，并向首批响应人员和特警开火，请使用 \
		背包里的叛国举报器呼叫军方。"
	missiondesc += "<BR> <B>5.</B> 当你在空间站上的工作结束后，使用背包里的传送离场工具，把你自己 \
		以及你正在拖拽的人一起传送离场。"
	to_chat(owner, missiondesc)
	var/mob/living/greeted_mob = owner.current
	greeted_mob.playsound_local(greeted_mob, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/outfit/request_911/condom_destroyer
	name = "911 Response: Armed S.W.A.T. Officer"
	back = /obj/item/storage/backpack
	uniform = /obj/item/clothing/under/sol_peacekeeper
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/tackler/combat
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_sec/alt
	head = /obj/item/clothing/head/helmet/sf_peacekeeper
	belt = /obj/item/gun/energy/e_gun
	suit = /obj/item/clothing/suit/armor/sf_peacekeeper
	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/terragov
	l_hand = /obj/item/gun/ballistic/automatic/sol_rifle
	accessory = /obj/item/clothing/accessory/bubber/galfedribbon/rank4
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = 3,
		/obj/item/terragov_reporter/treason_reporter = 1,
		/obj/item/beamout_tool = 1,
	)

	id_trim = /datum/id_trim/terragov

/datum/antagonist/ert/request_911/treason_destroyer
	name = "地球政府维和人员"
	role = "列兵"
	department = "军方"
	outfit = /datum/outfit/request_911/treason_destroyer

/datum/antagonist/ert/request_911/treason_destroyer/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>你不是纳米传讯的员工。你为地球政府工作，职务是[role]。</font></B>"
	missiondesc += "<BR>你在这里是为了接管 [station_name()]，因为据我们的特警队报告，站内人员正在从事叛国行为。\n"
	missiondesc += "<BR><B>你的任务</B>："
	missiondesc += "<BR> <B>1.</B> 通过手机联系特警队和首批响应人员，向他们了解情况。"
	missiondesc += "<BR> <B>2.</B> 逮捕所有参与叛国行为的嫌疑人。"
	missiondesc += "<BR> <B>3.</B> 代表地球政府接管空间站，并启动撤离程序，把未涉案的公民 \
		带离现场。"
	missiondesc += "<BR> <B>4.</B> 如果你需要使用致命武力，那就用，但只在必要时。"
	to_chat(owner, missiondesc)
	var/mob/living/greeted_mob = owner.current
	greeted_mob.playsound_local(greeted_mob, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/outfit/request_911/treason_destroyer
	name = "911 Response: TerraGov Military"

	uniform = /obj/item/clothing/under/sol_peacekeeper
	head = /obj/item/clothing/head/helmet/sf_sacrificial
	mask = /obj/item/clothing/mask/gas/alt
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/sf_sacrificial
	shoes = /obj/item/clothing/shoes/jackboots

	back = /obj/item/storage/backpack
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_sec/alt
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/flashlight/seclite
	id = /obj/item/card/id/advanced/terragov
	r_hand = /obj/item/gun/ballistic/automatic/sol_rifle
	backpack_contents = list(
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/sacrificial_face_shield = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = 4,
	)

	id_trim = /datum/id_trim/terragov

/obj/item/terragov_reporter
	name = "地球政府汇报器"
	desc = "在手中使用，可投票请求地球政府支援。若你队伍中有一半人投票赞成，特警将被派出。"
	icon = 'modular_skyrat/modules/goofsec/icons/reporter.dmi'
	icon_state = "reporter_off"
	w_class = WEIGHT_CLASS_SMALL
	/// Was the reporter turned on?
	var/activated = FALSE
	/// What antagonist should be required to use the reporter?
	var/type_to_check = /datum/antagonist/ert/request_911
	/// What table should we be incrementing votes in and checking against in the terragov responders global?
	var/type_of_callers = "911_responders"
	/// What source should be supplied for the announcement message?
	var/announcement_source = "Terran Government S.W.A.T."
	/// Should the station be issued a fine when the vote completes?
	var/fine_station = TRUE
	/// What poll message should we show to the ghosts when they are asked to join the squad?
	var/ghost_poll_msg = "example crap"
	/// How many ghosts should we pick from the applicants to become members of the squad?
	var/amount_to_summon = 4
	/// What antagonist type should we give to the ghosts?
	var/type_to_summon = /datum/antagonist/ert/request_911/condom_destroyer
	/// What table should be be incrementing amount in in the terragov responders global?
	var/summoned_type = "swat"
	/// What name and ID should be on the cell phone given to the squad members?
	var/cell_phone_number = "911"
	/// What jobban should we be checking for the ghost polling?
	var/jobban_to_check = ROLE_DEATHSQUAD
	/// What announcement message should be displayed if the vote succeeds?
	var/announcement_message = "Example announcement message"

/obj/item/terragov_reporter/proc/pre_checks(mob/user)
	if(GLOB.terragov_responder_info[type_of_callers][TERRAGOV_AMT] == 0)
		to_chat(user, span_warning("没有响应人员。你大概是用管理员权限把它刷出来的吧。请不要这么做。"))
		return FALSE
	if(!user.mind.has_antag_datum(type_to_check))
		to_chat(user, span_warning("你不知道该怎么用这东西！"))
		return FALSE
	return TRUE

/obj/item/terragov_reporter/proc/questions(mob/user)
	return TRUE

/obj/item/terragov_reporter/attack_self(mob/user, modifiers)
	. = ..()
	if(!pre_checks(user))
		return
	if(!activated && !GLOB.terragov_responder_info[type_of_callers][TERRAGOV_DECLARED])
		if(!questions(user))
			return
		activated = TRUE
		icon_state = "reporter_on"
		GLOB.terragov_responder_info[type_of_callers][TERRAGOV_VOTES]++
		var/current_votes = GLOB.terragov_responder_info[type_of_callers][TERRAGOV_VOTES]
		var/amount_of_responders = GLOB.terragov_responder_info[type_of_callers][TERRAGOV_AMT]
		to_chat(user, span_warning("你已激活该设备。 \
		当前票数：[current_votes]/[amount_of_responders]。"))
		if(current_votes >= amount_of_responders * 0.5)
			GLOB.terragov_responder_info[type_of_callers][TERRAGOV_DECLARED] = TRUE
			if(fine_station)
				var/datum/bank_account/station_balance = SSeconomy.get_dep_account(ACCOUNT_CAR)
				station_balance?.adjust_money(TERRAGOV_FINE_AMOUNT) // paying for the gas to drive all the fuckin' way out to the frontier

			priority_announce(announcement_message, announcement_source, 'sound/effects/families_police.ogg', has_important_message = TRUE, color_override = "yellow")
			var/list/candidates = SSpolling.poll_ghost_candidates(ghost_poll_msg, jobban_to_check)

			if(candidates.len)
				//Pick the (un)lucky players
				var/agents_number = min(amount_to_summon, candidates.len)
				GLOB.terragov_responder_info[summoned_type][TERRAGOV_AMT] = agents_number

				var/list/spawnpoints = GLOB.emergencyresponseteamspawn
				var/index = 0
				while(agents_number && candidates.len)
					var/spawn_loc = spawnpoints[index + 1]
					//loop through spawnpoints one at a time
					index = (index + 1) % spawnpoints.len
					var/mob/dead/observer/chosen_candidate = pick(candidates)
					candidates -= chosen_candidate
					if(!chosen_candidate.key)
						continue

					//Spawn the body
					var/mob/living/carbon/human/cop = new(spawn_loc)
					chosen_candidate.client.prefs.safe_transfer_prefs_to(cop, is_antag = TRUE)
					cop.key = chosen_candidate.key

					//Give antag datum
					var/datum/antagonist/ert/request_911/ert_antag = new type_to_summon

					cop.mind.add_antag_datum(ert_antag)
					cop.mind.set_assigned_role(SSjob.get_job_type(ert_antag.ert_job_path))
					SSjob.send_to_late_join(cop)
					cop.grant_language(/datum/language/common, source = LANGUAGE_SPAWNER)

					var/obj/item/gangster_cellphone/phone = new() // biggest gang in the city
					phone.gang_id = cell_phone_number
					phone.name = "[cell_phone_number] 品牌手机"
					var/phone_equipped = phone.equip_to_best_slot(cop)
					if(!phone_equipped)
						to_chat(cop, "你的 [phone.name] 已被放在你的脚边。")
						phone.forceMove(get_turf(cop))

					//Logging and cleanup
					log_game("[key_name(cop)] 已被选中担任 [ert_antag.name]。")
					agents_number--

/obj/item/terragov_reporter/swat_caller
	name = "特警支援呼叫器"
	desc = "在手中使用，可投票请求地球政府特警支援。若你队伍中有一半人投票赞成，特警将被派出。"
	type_to_check = /datum/antagonist/ert/request_911
	type_of_callers = "911_responders"
	announcement_source = "地球政府特警"
	fine_station = TRUE
	ghost_poll_msg = "太阳联邦 911 服务部门请求了特警支援。你愿意成为特警队员吗？"
	amount_to_summon = 6
	type_to_summon = /datum/antagonist/ert/request_911/condom_destroyer
	summoned_type = "swat"
	announcement_message = "各位船员，你们好。我们的应急服务部门请求了特警支援，原因可能是船员 \
		妨碍他们执行任务，或是有人虚报 911 呼叫。我们已就此向空间站开出了 20,000 美元的账单，用以支付向 \
		你站派出第二支应急响应队伍的开销。请配合上述特警队员的一切要求。"

/obj/item/terragov_reporter/swat_caller/questions(mob/user)
	var/question = "当前情况是否需要额外的特警支援、是否涉及空间站阻挠你执行任务， \
		或涉及空间站虚报 911 呼叫并需要对报案人实施逮捕？"
	if(tgui_alert(user, question, "特警支援呼叫器", list("No", "Yes")) != "Yes")
		to_chat(user, "你决定不请求特警支援。")
		return FALSE
	message_admins("[ADMIN_LOOKUPFLW(user)] 已投票请求召集特警支援。")
	return TRUE

/obj/item/terragov_reporter/treason_reporter
	name = "叛国举报器"
	desc = "在手中使用，可投票认定空间站正在从事叛国行为。若你队伍中有一半人投票赞成，军方将接手处理。"
	type_to_check = /datum/antagonist/ert/request_911/condom_destroyer
	type_of_callers = "swat"
	announcement_source = "地球政府国民警卫队"
	fine_station = FALSE
	ghost_poll_msg = "空间站已决定从事叛国行为。你愿意加入地球政府军队吗？"
	amount_to_summon = 12
	type_to_summon = /datum/antagonist/ert/request_911/treason_destroyer
	summoned_type = "national_guard"
	announcement_message = "空间站的船员们。你们拒绝配合首批响应人员与特警队的工作，并对他们发动了攻击， \
		致使他们尽管身处地球政府疆域之内，却无法执行地球政府的意志。\n\
		因此，我们以叛国罪指控责任人。其刑罚为死刑，或不少于二十五年的超级监狱监禁。\n\
		叛国是重罪。我们的军队已在前往你站的途中。他们将直接接管空间站，并 \
		从现场撤离平民。\n\
		未涉案的公民，请做好撤离准备。服从地球政府军事人员下达的一切命令。\n\
		所有正在从事叛国行为的人，放下武器投降。拒不配合者可能会遭到致命武力。"

/obj/item/terragov_reporter/treason_reporter/questions(mob/user)
	var/list/list_of_questions = list(
		"叛国罪，是指攻击自己负有效忠义务的国家政权的罪行。本空间站位于地球政府疆域之内， \
			尽管归纳米传讯所有，却对地球政府负有效忠义务。今天空间站是否犯下了这一罪行？",
		"空间站船员是否在安保部和/或指挥部的指使下袭击了你或特警队？",
		"空间站船员是否在安保部和/或指挥部的指使下主动阻挠你和特警队完成目标？",
		"你和你的特警同伴是否无力独自处理该问题？",
		"你绝对确定要宣布空间站从事叛国行为吗？误用此功能可能且将会导致 \
			对你的账号采取管理措施。"
	)
	for(var/question in list_of_questions)
		if(tgui_alert(user, question, "叛国举报器", list("No", "Yes")) != "Yes")
			to_chat(user, "你决定不宣布空间站犯有叛国罪。")
			return FALSE
	message_admins("[ADMIN_LOOKUPFLW(user)] 已在管理层面确认知晓虚假叛国指控的后果， \
		并投票认定空间站正在从事叛国行为。")
	return TRUE

/obj/item/terragov_reporter/pizza_managers
	name = "多吉诺不配合客户举报器"
	desc = "在手中使用，若空间站拒绝支付其披萨费用，可投票请求多吉诺区域经理前来。 \
		若你配送小队中有一半人投票赞成，多吉诺区域经理将被派出。"
	type_to_check = /datum/antagonist/ert/pizza/false_call
	type_of_callers = "dogginos"
	announcement_message = "各位尊敬的老主顾，你们好！我们的配送司机报告说，你们似乎对订单付款有些异议， \
		而你们是在离你站距离排名银河第七远的那家多吉诺下的单。我们想要确保最高的客户满意度，同时也兼顾 \
		员工满意度。\n\
		我们已派出几位最优秀的区域经理前去处理此事。\n\
		希望你们吃得开心，也希望我们很快就能收到 35,000 美元的账单，以及给我们司机的 15% 小费！"
	announcement_source = "多吉诺披萨店"
	fine_station = FALSE
	ghost_poll_msg = "多吉诺正派出区域经理，前去催促空间站付清拖欠的披萨钱。你准备好来做客户关系了吗？"
	amount_to_summon = 8
	type_to_summon = /datum/antagonist/ert/pizza/leader/false_call
	summoned_type = "dogginos_manager"
	cell_phone_number = "Dogginos"

/obj/item/terragov_reporter/pizza_managers/questions(mob/user)
	if(tgui_alert(user, "空间站是否拒绝支付其 35,000 美元的账单，其中还包括给配送司机的 15% 小费？", "多吉诺不配合客户举报器", list("No", "Yes")) != "Yes")
		to_chat(user, "你决定不请求管理层协助你的配送。")
		return FALSE
	message_admins("[ADMIN_LOOKUPFLW(user)] 已投票请求召集多吉诺管理层处理欠款问题。")
	return TRUE

/datum/antagonist/ert/pizza/false_call
	outfit = /datum/outfit/centcom/ert/pizza/false_call

/datum/outfit/centcom/ert/pizza/false_call
	backpack_contents = list(
		/obj/item/storage/box/survival,
		/obj/item/knife,
		/obj/item/storage/box/ingredients/italian,
		/obj/item/terragov_reporter/pizza_managers,
	)
	r_hand = /obj/item/pizzabox/meat
	l_hand = /obj/item/pizzabox/vegetable

/datum/antagonist/ert/pizza/false_call/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>你不是纳米传讯的员工。你为多吉诺披萨店工作，是一名配送员。</font></B>"
	missiondesc += "<BR>你来这里是为了配送多吉诺的披萨！\n"
	missiondesc += "<BR>使用背包里的手机与其他多吉诺员工联络！\n"
	missiondesc += "<BR><B>你的任务</B>："
	missiondesc += "<BR> <B>1.</B> 配送 [GLOB.pizza_order] 订购的披萨。"
	missiondesc += "<BR> <B>2.</B> 收取账单，共计 35,000 美元，另加给配送司机的 15% 小费。"
	missiondesc += "<BR> <B>3.</B> 如果他们拒绝付款，你可以召集多吉诺区域经理来协助解决问题。"
	to_chat(owner, missiondesc)

/datum/antagonist/ert/pizza/leader/false_call/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>你不是纳米传讯的员工。你为多吉诺披萨店工作，是一名区域经理。</font></B>"
	missiondesc += "<BR>你来这里是为了解决与一些拒绝付款的顾客之间的纠纷！\n"
	missiondesc += "<BR>使用背包里的手机与其他多吉诺员工联络！\n"
	missiondesc += "<BR><B>你的任务</B>："
	missiondesc += "<BR> <B>1.</B> 向 [GLOB.pizza_order] 收取欠款，共计 35,000 美元，另加给配送司机的 15% 小费。"
	missiondesc += "<BR> <B>2.</B> 用一切必要手段收取欠款。你背包里那把千度高温刀会帮上忙。"
	to_chat(owner, missiondesc)

/obj/item/beamout_tool
	name = "传送离场工具" // TODO, find a way to make this into drop pods cuz that's cooler visually
	desc = "使用它以开始漫长的传送离场流程，返回地球政府空域。它会把你正在拖拽的人一起带走。"
	icon = 'modular_skyrat/modules/goofsec/icons/reporter.dmi'
	icon_state = "beam_me_up_scotty"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/beamout_tool/attack_self(mob/user, modifiers)
	. = ..()
	if(!user.mind.has_antag_datum(/datum/antagonist/ert))
		to_chat(user, span_warning("你不明白该如何使用这个装置。"))
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] 已开始使用传送离场工具进行传送离场。")
	to_chat(user, "你已开始传送离场流程。请等待光束抵达空间站。")
	user.balloon_alert(user, "已开始传送离场")
	if(do_after(user, 30 SECONDS))
		to_chat(user, "你已完成传送离场流程，正在返回地球政府。")
		message_admins("[ADMIN_LOOKUPFLW(user)] 已将自己传送离场。")
		if(isliving(user))
			var/mob/living/living_user = user
			if(living_user.pulling)
				if(ishuman(living_user.pulling))
					var/mob/living/carbon/human/beamed_human = living_user.pulling
					message_admins("[ADMIN_LOOKUPFLW(user)] 已将 [ADMIN_LOOKUPFLW(beamed_human)] 一并传送离场。")
				else
					message_admins("[ADMIN_LOOKUPFLW(user)] 已将 [living_user.pulling] 一并传送离场。")
				var/turf/pulling_turf = get_turf(living_user.pulling)
				playsound(pulling_turf, 'sound/effects/magic/Repulse.ogg', 100, 1)
				do_sparks(10, 1, pulling_turf)
				qdel(living_user.pulling)
			var/turf/user_turf = get_turf(living_user)
			playsound(user_turf, 'sound/effects/magic/Repulse.ogg', 100, 1)
			do_sparks(10, 1, user_turf)
			qdel(user)
	else
		user.balloon_alert(user, "传送离场已取消")

#undef TERRAGOV_AMT
#undef TERRAGOV_VOTES
#undef TERRAGOV_DECLARED
#undef TERRAGOV_FINE_AMOUNT

#undef EMERGENCY_RESPONSE_POLICE
#undef EMERGENCY_RESPONSE_ATMOS
#undef EMERGENCY_RESPONSE_EMT
#undef EMERGENCY_RESPONSE_EMAG
