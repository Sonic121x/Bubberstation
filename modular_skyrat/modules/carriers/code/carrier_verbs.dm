/datum/component/carrier_communicator
	/// What carrier room is the parent mob currently trying to communicate with?
	var/datum/weakref/target_carrier
	/// Is the mob trying to communicate with the carrier they are inside?
	var/carried_mob = FALSE

/datum/component/carrier_communicator/New()
	. = ..()
	var/mob/living/parent_mob = parent
	if(!istype(parent_mob))
		return COMPONENT_INCOMPATIBLE

	ASSIGN_GAME_VERB(src, /mob/living, carrier_say)
	ASSIGN_GAME_VERB(src, /mob/living, carrier_emote)

/datum/component/carrier_communicator/Destroy(force)
	var/mob/living/holder = parent
	if(!istype(holder))
		return FALSE

	UNASSIGN_GAME_VERB(src, /mob/living, carrier_say)
	UNASSIGN_GAME_VERB(src, /mob/living, carrier_emote)
	return ..()

/// Prompts the parent mob to send a say message to the soulcatcher. Returns False if no soulcatcher or message could be found.
GAME_VERB_PROC_DESC(/mob/living, carrier_say, "载体发言", "向你当前锁定的载体房间发送一条说话消息。", "IC")
	var/datum/carrier_room/room_to_send_to = get_current_carrier_room()
	if(!istype(room_to_send_to))
		to_chat(src, span_warning("你没有可以向其发送消息的载体！"))
		return FALSE

	var/message_to_send = tgui_input_text(usr, "输入你想发送的消息", "载体", multiline = TRUE)
	if(!message_to_send)
		return FALSE

	var/message_sender = room_to_send_to.outside_voice
	var/datum/component/carrier_user/carrier_user_component = GetComponent(/datum/component/carrier_user)
	var/datum/component/carrier_communicator/communicator_component = GetComponent(/datum/component/carrier_communicator)
	if(istype(carrier_user_component) && istype(communicator_component) && communicator_component.carried_mob)
		message_sender = carrier_user_component.name

	room_to_send_to.send_message(message_to_send, message_sender)
	return TRUE

/// Prompts the parent mob to send a emote to the soulcatcher. Returns False if no soulcatcher or emote could be found.
GAME_VERB_PROC_DESC(/mob/living, carrier_emote, "载体表情", "向你当前锁定的载体房间发送一条表情。", "IC")
	var/datum/carrier_room/room_to_send_to = get_current_carrier_room()
	if(!istype(room_to_send_to))
		to_chat(src, span_warning("你没有可以向其发送表情的载体！"))
		return FALSE

	var/message_to_send = tgui_input_text(usr, "输入你想发送的表情", "灵魂捕手", multiline = TRUE)
	if(!message_to_send)
		return FALSE

	var/message_sender = room_to_send_to.outside_voice
	var/datum/component/carrier_user/carrier_user_component = GetComponent(/datum/component/carrier_user)
	var/datum/component/carrier_communicator/communicator_component = GetComponent(/datum/component/carrier_communicator)
	if(istype(carrier_user_component) && istype(communicator_component) && communicator_component.carried_mob)
		message_sender = carrier_user_component.name

	room_to_send_to.send_message(message_to_send, message_sender, TRUE)
	return TRUE

/// Attempts to find and return the current carrier room the mob is using.
/mob/living/proc/get_current_carrier_room()
	var/datum/component/carrier_communicator/communicator_component = GetComponent(/datum/component/carrier_communicator)
	if(!communicator_component)
		return FALSE

	var/datum/component/carrier/master_carrier = communicator_component.target_carrier?.resolve()
	if(!istype(master_carrier))
		return FALSE

	var/datum/carrier_room/target_room = master_carrier.targeted_carrier_room
	var/datum/component/carrier_user/carrier_user_component = GetComponent(/datum/component/carrier_user)
	if(communicator_component.carried_mob && istype(carrier_user_component))
		target_room = carrier_user_component.current_room.resolve()
		if(!istype(target_room))
			return FALSE

	if(!Adjacent(master_carrier.parent))
		communicator_component.target_carrier = null
		return FALSE

	return target_room
