#define CHALLENGE_TELECRYSTALS 280
#define CHALLENGE_TIME_LIMIT (5 MINUTES)
#define CHALLENGE_SHUTTLE_DELAY (25 MINUTES) // 25 minutes, so the ops have at least 5 minutes before the shuttle is callable.

GLOBAL_LIST_EMPTY(jam_on_wardec)

/obj/item/nuclear_challenge
	name = "宣战书（挑战模式）"
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "nukietalkie"
	inhand_icon_state = "nukietalkie"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	desc = "使用后向目标发送敌对宣言，在对方准备迎击时让你的穿梭机延迟 20 分钟出发。  \
			如此嚣张的举动会引来辛迪加内部强大资助者的注意，他们会为你的小队提供大量额外传送水晶。  \
			必须在五分钟内使用，否则你的资助者会失去兴趣。"
	var/declaring_war = FALSE
	var/uplink_type = /obj/item/uplink/nuclear
	var/announcement_sound = 'sound/announcer/alarm/nuke_alarm.ogg'

/obj/item/nuclear_challenge/attack_self(mob/living/user)
	if(!check_allowed(user))
		return

	declaring_war = TRUE
	var/are_you_sure = tgui_alert(user, "在对[station_name()]宣战之前，请仔细与你的团队商议。你确定要惊动敌方船员吗？你有[DisplayTimeText(CHALLENGE_TIME_LIMIT - world.time - SSticker.round_start_time)]的时间做决定。", "宣战？", list("Yes", "No"))
	declaring_war = FALSE

	if(!check_allowed(user))
		return

	if(are_you_sure != "Yes")
		to_chat(user, span_notice("仔细想想，出其不意其实也不错。"))
		return

	var/war_declaration = "一个辛迪加边缘团体宣称要用核装置彻底摧毁[station_name()]，并挑衅船员尽管来阻止他们。"

	declaring_war = TRUE
	var/custom_threat = tgui_alert(user, "你想自定义你的宣战内容吗？", "自定义？", list("Yes", "No"))
	declaring_war = FALSE

	if(!check_allowed(user))
		return

	if(custom_threat == "Yes")
		declaring_war = TRUE
		war_declaration = tgui_input_text(user, "输入你的自定义宣战内容", "宣战宣言", max_length = MAX_MESSAGE_LEN, multiline = TRUE, encode = FALSE)
		declaring_war = FALSE

	if(!check_allowed(user) || !war_declaration)
		return

	war_was_declared(user, memo = war_declaration)

///Admin only proc to bypass checks and force a war declaration. Button on antag panel.
/obj/item/nuclear_challenge/proc/force_war()
	var/are_you_sure = tgui_alert(usr, "你确定要强制发起宣战吗？[GLOB.player_list.len < CHALLENGE_MIN_PLAYERS ? " 注意，当前玩家数低于要求的限制。" : ""]", "宣战？", list("Yes", "No"))

	if(are_you_sure != "Yes")
		return

	var/war_declaration = "一个辛迪加边缘团体宣称要用核装置彻底摧毁[station_name()]，并挑衅船员尽管来阻止他们。"

	var/custom_threat = tgui_alert(usr, "你想自定义宣战内容吗？", "自定义？", list("Yes", "No"))

	if(custom_threat == "Yes")
		war_declaration = tgui_input_text(usr, "输入你的自定义宣战内容", "宣战宣言", max_length = MAX_MESSAGE_LEN, multiline = TRUE, encode = FALSE)

	if(!war_declaration)
		tgui_alert(usr, "无效的宣战宣言。", "用词不当")
		return

	for(var/obj/item/circuitboard/computer/syndicate_shuttle/board as anything in GLOB.syndicate_shuttle_boards)
		if(board.challenge_start_time)
			tgui_alert(usr, "战争已经宣战过了！", "战争已宣战")
			return

	war_was_declared(memo = war_declaration)

/obj/item/nuclear_challenge/proc/war_was_declared(mob/living/user, memo)
	priority_announce(
		text = memo,
		title = "宣战宣言",
		sound = announcement_sound,
		has_important_message = TRUE,
		sender_override = "核爆特工前哨站",
		color_override = "red",
	)
	if(user)
		to_chat(user, "你引来了辛迪加内部强大势力的注意。 \
			你的小队获得了一批额外的传送水晶奖励。完成任务，伟大的事业在等着你。")

	distribute_tc()
	CONFIG_SET(number/shuttle_refuel_delay, max(CONFIG_GET(number/shuttle_refuel_delay), CHALLENGE_SHUTTLE_DELAY))
	SSblackbox.record_feedback("amount", "nuclear_challenge_mode", 1)

	for(var/obj/item/circuitboard/computer/syndicate_shuttle/board as anything in GLOB.syndicate_shuttle_boards)
		board.challenge_start_time = world.time

	for(var/obj/machinery/computer/camera_advanced/shuttle_docker/dock as anything in GLOB.jam_on_wardec)
		dock.jammed = TRUE

	var/datum/techweb/station_techweb = locate(/datum/techweb/science) in SSresearch.techwebs
	if(station_techweb)
		var/obj/machinery/announcement_system/announcement_system = get_announcement_system(null, null, list(RADIO_CHANNEL_SCIENCE))
		if (!isnull(announcement_system))
			announcement_system.broadcast("依照应急协议，已从纳米传讯研发部收到额外研究数据。", list(RADIO_CHANNEL_SCIENCE), TRUE)
		station_techweb.adjust_points(TECHWEB_POINT_TYPE_GENERIC, TECHWEB_TIER_5_POINTS * 3)

	qdel(src)

/obj/item/nuclear_challenge/proc/distribute_tc()
	var/list/orphans = list()
	var/list/uplinks = list()

	for (var/datum/mind/M in get_antag_minds(/datum/antagonist/nukeop))
		if (iscyborg(M.current))
			continue
		var/datum/component/uplink/uplink = M.find_syndicate_uplink()
		if (!uplink)
			orphans += M.current
			continue
		uplinks += uplink

	var/tc_to_distribute = CHALLENGE_TELECRYSTALS
	var/tc_per_nukie = round(tc_to_distribute / (length(orphans)+length(uplinks)))

	for (var/datum/component/uplink/uplink in uplinks)
		uplink.uplink_handler.add_telecrystals(tc_per_nukie)
		tc_to_distribute -= tc_per_nukie

	for (var/mob/living/L in orphans)
		var/TC = new /obj/item/stack/telecrystal(L.drop_location(), tc_per_nukie)
		to_chat(L, span_warning("找不到你的上行链路，因此你那份团队额外传送水晶已被蓝空间传送到了你的[L.put_in_hands(TC) ? "手上" : "脚边"]。"))
		tc_to_distribute -= tc_per_nukie

	if (tc_to_distribute > 0) // What shall we do with the remainder...
		for (var/mob/living/basic/carp/pet/cayenne/C in GLOB.mob_living_list)
			if (C.stat != DEAD)
				var/obj/item/stack/telecrystal/TC = new(C.drop_location(), tc_to_distribute)
				TC.throw_at(get_step(C, C.dir), 3, 3)
				C.visible_message(span_notice("[C]咳出了一颗消化了一半的传送水晶"),span_notice("你咳出了一颗消化了一半的传送水晶！"))
				break


/obj/item/nuclear_challenge/proc/check_allowed(mob/living/user)
	if(declaring_war)
		to_chat(user, span_boldwarning("你已经在宣战流程中了！快下定决心吧。"))
		return FALSE
	if(GLOB.player_list.len < CHALLENGE_MIN_PLAYERS)
		to_chat(user, span_boldwarning("敌方船员人数太少，不值得对他们宣战。"))
		return FALSE
	if(!user.onSyndieBase())
		to_chat(user, span_boldwarning("你必须身处基地才能使用这个。"))
		return FALSE
	if(world.time - SSticker.round_start_time > CHALLENGE_TIME_LIMIT)
		to_chat(user, span_boldwarning("现在宣布敌对行动已经太迟了。你的资助者正忙于其他计划，你只能用手头的东西将就了。"))
		return FALSE
	for(var/obj/item/circuitboard/computer/syndicate_shuttle/board as anything in GLOB.syndicate_shuttle_boards)
		if(board.moved)
			to_chat(user, span_boldwarning("穿梭机已经被移动过了！你已丧失宣战的权利。"))
			return FALSE
		if(board.challenge_start_time)
			to_chat(user, span_boldwarning("战争已经宣战过了！"))
			return FALSE
	return TRUE

/obj/item/nuclear_challenge/clownops
	uplink_type = /obj/item/uplink/clownop
	announcement_sound = 'sound/announcer/alarm/clownops.ogg'

/// Subtype that does nothing but plays the war op message. Intended for debugging
/obj/item/nuclear_challenge/literally_just_does_the_message
	name = "“宣战宣言”"
	desc = "这是辛迪加的宣战玩意儿，但它只会播放响亮的音效和消息，别的什么都不做。"
	var/admin_only = TRUE

/obj/item/nuclear_challenge/literally_just_does_the_message/check_allowed(mob/living/user)
	if(admin_only && !check_rights_for(user.client, R_SPAWN|R_FUN|R_DEBUG))
		to_chat(user, span_hypnophrase("你不该拥有这个！"))
		return FALSE

	return TRUE

/obj/item/nuclear_challenge/literally_just_does_the_message/war_was_declared(mob/living/user, memo)
#ifndef TESTING
	// Reminder for our friends the admins
	var/are_you_sure = tgui_alert(user, "最后提醒一句，虚假宣战是个糟糕的主意，而且是的，\
		这个会执行全套流程，所以做事要小心。", "别这么做", list("I'm sure", "You're right"))
	if(are_you_sure != "I'm sure")
		return
#endif

	priority_announce(
		text = memo,
		title = "宣战宣言",
		sound = announcement_sound,
		has_important_message = TRUE,
		sender_override = "核爆特工前哨站",
		color_override = "red",
	)

/obj/item/nuclear_challenge/literally_just_does_the_message/distribute_tc()
	return

#undef CHALLENGE_TELECRYSTALS
#undef CHALLENGE_TIME_LIMIT
#undef CHALLENGE_SHUTTLE_DELAY
