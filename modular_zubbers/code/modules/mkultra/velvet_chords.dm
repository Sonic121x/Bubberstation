/obj/item/organ/vocal_cords/velvet
	name = "天鹅绒和弦"
	desc = "这声音让你想要恍神、入睡并服从。"
	icon = 'modular_zubbers/icons/obj/vocal_cords.dmi'
	icon_state = "velvet_chords"
	actions_types = list(/datum/action/item_action/organ_action/velvet)
	spans = list("velvet")

/datum/action/item_action/organ_action/velvet
	name = "天鹅绒和弦"
	desc = "以魅惑的语调说话。右键查看所有命令。"
	var/obj/item/organ/vocal_cords/velvet/chords

/datum/action/item_action/organ_action/velvet/New(Target)
	. = ..()
	chords = Target

/datum/action/item_action/organ_action/velvet/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		ui_interact(clicker)
		return ..()
	var/command = tgui_input_text(owner, "以魅惑的语调说话。", "命令", max_length = MAX_MESSAGE_LEN)
	if(!command)
		return FALSE
	if(QDELETED(src) || QDELETED(owner))
		return FALSE
	for(var/mob/living/people in get_hearers_in_view(DEFAULT_VIEW_RANGE, owner))
		var/datum/status_effect/mkultra/status = people.has_status_effect(/datum/status_effect/mkultra)
		if(isnull(status))
			continue
		if(status.enchanter != owner)
			continue
		if(!status.listener(owner, command))
			return FALSE
	owner.say(".x[command]")


