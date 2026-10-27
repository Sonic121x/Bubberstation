/*
Slimecrossing Mobs
	Mobs and effects added by the slimecrossing system.
	Collected here for clarity.
*/

/// Slime transformation power - from Burning Black
/datum/action/cooldown/spell/shapeshift/slime_form
	name = "史莱姆变形"
	desc = "从人类变成史莱姆，或者再变回来！"
	button_icon_state = "transformslime"
	cooldown_time = 0 SECONDS

	invocation_type = INVOCATION_NONE
	spell_requirements = NONE

	convert_damage_type = TOX
	possible_shapes = list(/mob/living/basic/slime/transformed_slime)

	/// If TRUE, we self-delete (remove ourselves) the next time we turn back into a human
	var/remove_on_restore = FALSE

/datum/action/cooldown/spell/shapeshift/slime_form/do_unshapeshift(mob/living/caster)
	. = ..()
	if(!.)
		return

	if(remove_on_restore)
		qdel(src)

/// Transformed slime - from Burning Black
/mob/living/basic/slime/transformed_slime

// Just in case.
/mob/living/basic/slime/transformed_slime/reproduce()
	to_chat(src, span_warning("我无法繁殖……")) // Mood
	return

//Slime corgi - Chilling Pink
/mob/living/basic/pet/dog/corgi/puppy/slime
	name = "\improper 史莱姆柯基幼犬"
	real_name = "史莱姆柯基幼犬"
	desc = "一只可爱得让人受不了的粉色史莱姆柯基幼犬。"
	icon_state = "slime_puppy"
	icon_living = "slime_puppy"
	icon_dead = "slime_puppy_dead"
	can_be_shaved = FALSE
	gold_core_spawnable = NO_SPAWN
	speak_emote = list("咕噜作响", "冒泡", "汪汪叫")

/mob/living/basic/pet/dog/corgi/puppy/slime/update_dog_speech(list/speech_data)
	speech_data[BB_EMOTE_SAY] = string_list(list())
	speech_data[BB_EMOTE_HEAR] = string_list(list("嘟嘟冒泡！", "噗叽。", "啪嗒！"))
	speech_data[BB_EMOTE_SEE] = string_list(list("把黏液弄得满地都是。", "瘫倒在地。", "晃来晃去！"))
