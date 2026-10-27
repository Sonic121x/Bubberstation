/obj/item/organ/vocal_cords //organs that are activated through speech with the :x/MODE_KEY_VOCALCORDS channel
	name = "声带"
	icon_state = "appendix"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_VOICE
	gender = PLURAL
	decay_factor = 0 //we don't want decaying vocal cords to somehow matter or appear on scanners since they don't do anything damaged
	healing_factor = 0
	visual = FALSE
	var/list/spans = null

/obj/item/organ/vocal_cords/proc/can_speak_with() //if there is any limitation to speaking with these cords
	return TRUE

/obj/item/organ/vocal_cords/proc/speak_with(message) //do what the organ does
	return

/obj/item/organ/vocal_cords/proc/handle_speech(message) //actually say the message
	owner.say(message, spans = spans, sanitize = FALSE)

/obj/item/organ/adamantine_resonator
	name = "精金谐振器"
	desc = "所有魔像体内都存在精金碎片，源自它们作为纯粹魔法造物的出身。这些碎片被用来“听见”领袖传来的信息。"
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_ADAMANTINE_RESONATOR
	icon_state = "adamantine_resonator"

/obj/item/organ/vocal_cords/adamantine
	name = "精金声带"
	desc = "当精金共振时，附近所有精金碎片都会随之共振。体内含有这种结构的魔像借此向附近的魔像广播信息。"
	actions_types = list(/datum/action/item_action/organ_action/use/adamantine_vocal_cords)
	icon_state = "adamantine_cords"

/datum/action/item_action/organ_action/use/adamantine_vocal_cords/do_effect(trigger_flags)
	var/message = tgui_input_text(owner, "向附近所有魔像共振传递一条信息", "共振", max_length = MAX_MESSAGE_LEN)
	if(!message)
		return FALSE
	if(QDELETED(src) || QDELETED(owner))
		return FALSE
	owner.say(".x[message]")
	return TRUE

/obj/item/organ/vocal_cords/adamantine/handle_speech(message)
	var/msg = span_resonate("[span_name("[owner.real_name]")] 发出共振：“[message]”")
	for(var/player in GLOB.player_list)
		if(iscarbon(player))
			var/mob/living/carbon/speaker = player
			if(speaker.get_organ_slot(ORGAN_SLOT_ADAMANTINE_RESONATOR))
				to_chat(speaker, msg, type = MESSAGE_TYPE_RADIO, avoid_highlighting = speaker == owner)
		else if(isobserver(player))
			var/link = FOLLOW_LINK(player, owner)
			to_chat(player, "[link] [msg]", type = MESSAGE_TYPE_RADIO)
