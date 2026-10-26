/datum/component/carrier/soulcatcher
	able_to_transfer_to_another_carrier = TRUE
	/// Are ghosts currently able to join this soulcatcher?
	var/ghost_joinable = TRUE
	/// Is the soulcatcher removable from the parent object?
	var/removable = FALSE

	type_of_room_to_create = /datum/carrier_room/soulcatcher

/datum/component/carrier/soulcatcher/New()
	. = ..()
	GLOB.soulcatchers += src

/datum/component/carrier/soulcatcher/Destroy(force, ...)
	GLOB.soulcatchers -= src
	return ..()

/datum/component/carrier/soulcatcher/nifsoft
	single_owner = TRUE

/// Attempts to remove the carrier from the attached object
/datum/component/carrier/soulcatcher/proc/remove_self()
	if(!removable)
		return FALSE

	qdel(src)

/// Returns a list of all of the rooms that a soul can join/transfer into. `ghost_join` checks if the room is accessible to ghosts.
/datum/component/carrier/soulcatcher/get_open_rooms(ghost_join = FALSE)
	var/list/datum/carrier_room/room_list = list()
	for(var/datum/carrier_room/room as anything in carrier_rooms)
		if((ghost_join && !room.joinable) || !check_for_vacancy())
			continue

		room_list += room

	return room_list

/// Attempts to scan the body for the `previous_body component`, returns FALSE if the body is unable to be scanned, otherwise returns TRUE
/datum/component/carrier/soulcatcher/proc/scan_body(mob/living/parent_body, mob/living/user)
	if(!parent_body || !user)
		return FALSE

	var/signal_result = SEND_SIGNAL(parent_body, COMSIG_SOULCATCHER_SCAN_BODY, parent_body)
	if(!signal_result)
		to_chat(user, span_warning("[parent_body] 已经被扫描过了！"))
		return FALSE

	if(istype(parent, /obj/item/handheld_soulcatcher))
		var/obj/item/handheld_soulcatcher/parent_device = parent
		playsound(parent_device, 'modular_skyrat/modules/modular_implants/sounds/default_good.ogg', 50, FALSE, ignore_walls = FALSE)
		parent_device.visible_message(span_notice("[parent_device] 发出提示音：[parent_body] 现已完成扫描。"))

	return TRUE

/datum/carrier_room/soulcatcher
	/// What is the name of the room?
	name = "默认房间"
	/// What is the description of the room?
	room_description = "一座悬浮在太空中的橙色平台，周围环绕着大小不一的反射立方体。眼下这里确实没什么东西。"

/// Attemps to add a ghost to the soulcatcher room.
/datum/carrier_room/soulcatcher/proc/add_soul_from_ghost(mob/dead/observer/ghost)
	if(!ghost || !ghost.ckey)
		return FALSE

	if(!ghost.mind)
		ghost.mind = new /datum/mind(ghost.key)
		ghost.mind.name = ghost.name
		ghost.mind.active = TRUE

	if(!add_soul_from_mind(ghost.mind))
		return FALSE

	return TRUE

/// Converts a mind into a soul and adds the resulting soul to the room.
/datum/carrier_room/proc/add_soul_from_mind(datum/mind/mind_to_add, hide_participant_identity = TRUE)
	if(!mind_to_add)
		return FALSE

	var/datum/component/carrier/parent_soulcatcher = master_carrier.resolve()
	var/datum/parent_object = parent_soulcatcher.parent
	if(!parent_object)
		return FALSE

	var/mob/living/soulcatcher_soul/new_soul = new(parent_object)
	if(mind_to_add.current)
		var/datum/component/previous_body/body_component = mind_to_add.current.AddComponent(/datum/component/previous_body)
		body_component.soulcatcher_soul = WEAKREF(new_soul)

		new_soul.round_participant = TRUE
		new_soul.body_scan_needed = TRUE
		new_soul.previous_body = WEAKREF(mind_to_add.current)

	var/datum/component/carrier_user/soul_component = parent_soulcatcher.add_mob(new_soul, src)
	if(!soul_component)
		return FALSE

	if(hide_participant_identity && new_soul.round_participant)
		soul_component.name = pick(GLOB.last_names) //Until the body is discovered, the soul is a new person.
		soul_component.desc = "[new_soul] 没有可辨认的形态。"

	mind_to_add.transfer_to(new_soul, TRUE)
	current_mobs += new_soul
	soul_component.current_room = WEAKREF(src)

	to_chat(new_soul, span_cyan("你发现自己此刻身处：[name]"))
	to_chat(new_soul, span_notice(room_description))
	to_chat(new_soul, span_doyourjobidiot("你已进入一个灵魂捕手，不要分享你在作为幽灵期间获得的任何信息。如果你在本回合内死亡，在躯体被扫描之前你并不知道自己的身份，标准的失忆规则同样适用。"))
	to_chat(new_soul, span_notice("身处 [src] 期间，你可以使用常规快捷键和动词说话与做表情，除非所有者禁用了这些功能。"))
	to_chat(new_soul, span_notice("你可以随时使用“离开灵魂捕手”动词离开灵魂捕手并返回自己的躯体。"))

	var/atom/parent_atom = parent_object
	if(istype(parent_atom))
		var/turf/soulcatcher_turf = get_turf(parent_soulcatcher.parent)
		var/message_to_log = "[key_name(new_soul)] 在 [loc_name(soulcatcher_turf)] 的 [parent_atom] 内进入了 [src]"
		parent_atom.log_message(message_to_log, LOG_GAME)
		new_soul.log_message(message_to_log, LOG_GAME)

	set_overlay_for_mob(new_soul)
	return TRUE
