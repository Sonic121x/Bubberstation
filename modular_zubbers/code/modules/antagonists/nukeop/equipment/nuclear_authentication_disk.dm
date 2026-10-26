#define GRACE_PERIOD 45 MINUTES
#define LONEOP_DELAY 3

/obj/item/disk/nuclear/unsecured_process(last_move)
	//If there is no assigned captain, then don't run the event.
	if(!SSjob || !SSjob.assigned_captain)
		return

	if(last_move < world.time - GRACE_PERIOD)
		begin_nuclear_assault()

/obj/item/disk/nuclear/proc/begin_nuclear_assault()
	priority_announce(
		"警报:::检测到辛迪加通讯:::核认证磁盘位置已被锁定:::核打击即将来临——\
		预计[LONEOP_DELAY]分钟后抵达。\
		\n\
		\n\
		建议:::拿石头砸你们的舰长。",
		"军事指挥部预警系统",
		'sound/machines/engine_alert/engine_alert3.ogg',
		has_important_message = TRUE,
		color_override = "red"
	)

	var/datum/component/keep_me_secure/our_component = GetComponent(/datum/component/keep_me_secure)
	our_component.last_move = world.time

	addtimer(CALLBACK(src, PROC_REF(spawn_loneop)), LONEOP_DELAY MINUTES)

	message_admins("由于核认证磁盘未妥善保管，一名单独行动的核特工将在[LONEOP_DELAY]分钟后生成。")

/obj/item/disk/nuclear/proc/spawn_loneop()
	var/datum/round_event_control/operative/loneop = locate(/datum/round_event_control/operative) in SSgamemode.control
	if (!istype(loneop))
		return
	loneop.run_event(FALSE, event_cause = "核认证磁盘未妥善保管")

/datum/antagonist/nukeop/lone/on_gain()
	. = ..()

	var/datum/component/uplink/uplink = owner.find_syndicate_uplink()
	uplink?.uplink_handler?.telecrystals += 5 // extra for the warning

#undef GRACE_PERIOD
#undef LONEOP_DELAY
