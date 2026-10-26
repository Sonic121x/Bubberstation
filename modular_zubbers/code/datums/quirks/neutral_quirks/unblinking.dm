/datum/quirk/unblinking
	name = "Unblinking"
	desc = "不知为何，你的眼睛或其他视觉器官无需眨动就能正常运作。"
	icon = FA_ICON_FACE_FLUSHED
	value = 0
	gain_text = span_danger("你不再觉得需要眨眼。")
	lose_text = span_notice("你又觉得需要眨眼了。")
	medical_record_text = "患者无法眨眼。"
	mob_trait = TRAIT_NO_EYELIDS //Also prevents eye shutting in knockout state and death.

/datum/quirk/unblinking/add(client/client_source)
	. = ..()
	var/obj/item/organ/eyes/eyes = quirk_holder.get_organ_slot(ORGAN_SLOT_EYES)
	if(!eyes)
		return

	eyes.blink_animation = FALSE

	// interrupt the animations
	if(eyes.eyelid_left)
		animate(eyes.eyelid_left, alpha = 0, time = 0)
	if(eyes.eyelid_right)
		animate(eyes.eyelid_right, alpha = 0, time = 0)

/datum/quirk/unblinking/remove()
	. = ..()
	var/obj/item/organ/eyes/eyes = quirk_holder.get_organ_slot(ORGAN_SLOT_EYES)
	if(!eyes)
		return

	eyes.blink_animation = initial(eyes.blink_animation) // some eyes never blinked to begin with
	quirk_holder.update_body()
