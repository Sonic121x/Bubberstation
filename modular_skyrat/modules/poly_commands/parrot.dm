/*
* Parrot commands: Made modular
*/

/mob/living/basic/parrot
	/// Whether the parrot is on a human's shoulder or not
	var/buckled_to_human

/*
* Parrot commands: new code
*/

/mob/living/basic/parrot/proc/check_command(message, speaker)
	return FALSE // Simply return false for non-Poly parrots

/mob/living/basic/parrot/poly/check_command(message, speaker)
	var/mob/living/carbon/human/human_target = speaker
	if(!istype(human_target))
		return FALSE
	if(!(human_target.mind?.assigned_role.title == JOB_CHIEF_ENGINEER))
		return FALSE
	if(!(findtext(message, "poly")))
		return FALSE
	if(findtext(message, "perch") || findtext(message, "up"))
		command_perch(speaker)
		return TRUE
	else if(findtext(message, "off") || findtext(message, "down"))
		command_hop_off(speaker)
		return TRUE
	else
		return FALSE

/mob/living/basic/parrot/toggle_perched(perched)
	. = ..()
	if(!perched)
		buckled_to_human = FALSE

/mob/living/basic/parrot/poly/proc/command_perch(mob/living/carbon/human/human_target)
	if(!buckled)
		buckled_to_human = FALSE
	if(LAZYLEN(human_target.buckled_mobs) >= human_target.max_buckled_mobs)
		return
	if(buckled_to_human)
		manual_emote("困惑地看着[human_target]，轻声啼叫。")
		return
	if(get_dist(src, human_target) > 1 || buckled) // Only adjacent
		manual_emote("朝[human_target]歪了歪头，随后大声啼叫，留在原地。")
		return
	manual_emote("乖巧地跳上[human_target]的肩膀，短暂张开双翼后安稳地停了下来。")
	if(start_perching(human_target))
		buckled_to_human = TRUE

/mob/living/basic/parrot/poly/proc/command_hop_off(mob/living/carbon/human/human_target)
	if(!buckled)
		buckled_to_human = FALSE
	if(!buckled_to_human || !buckled)
		manual_emote("困惑地看着[human_target]，轻声啼叫。")
		return

	if(buckled)
		to_chat(src, span_notice("你不再停在[human_target]身上。"))
		buckled.unbuckle_mob(src, TRUE)
		manual_emote("啼叫着从[human_target]身上跳下，飞走了。")

