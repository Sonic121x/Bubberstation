/datum/action/cooldown/spell/pointed/blind
	name = "致盲"
	desc = "暂时让单个目标失明。"
	button_icon_state = "blind"
	ranged_mousepointer = 'icons/effects/mouse_pointers/blind_target.dmi'

	sound = 'sound/effects/magic/blind.ogg'
	school = SCHOOL_TRANSMUTATION
	cooldown_time = 30 SECONDS
	cooldown_reduction_per_rank = 6.25 SECONDS

	invocation = "STI KALY."
	invocation_type = INVOCATION_WHISPER
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC

	active_msg = "你准备致盲一个目标……"

	/// The amount of blind to apply
	var/eye_blind_duration = 20 SECONDS
	/// The amount of blurriness to apply
	var/eye_blur_duration = 40 SECONDS

/datum/action/cooldown/spell/pointed/blind/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE
	if(!ishuman(cast_on))
		return FALSE

	var/mob/living/carbon/human/human_target = cast_on
	return !human_target.is_blind()

/datum/action/cooldown/spell/pointed/blind/cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(cast_on.can_block_magic(antimagic_flags))
		to_chat(cast_on, span_notice("你的眼睛有些发痒，但很快就过去了。"))
		to_chat(owner, span_warning("法术没有产生任何效果！"))
		return FALSE

	to_chat(cast_on, span_warning("你的双眼剧痛难忍！"))
	cast_on.adjust_temp_blindness(eye_blind_duration)
	cast_on.set_eye_blur_if_lower(eye_blur_duration)
	return TRUE
