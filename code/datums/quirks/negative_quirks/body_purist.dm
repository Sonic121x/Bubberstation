/datum/quirk/body_purist
	name = "Body Purist"
	desc = "你认为身体如同圣殿，其天然形态就是完美的化身。因此，你厌恶以非天然部件进行改造的想法，无论是机械植入物、义肢还是其他类似的东西。"
	icon = FA_ICON_PERSON_RAYS
	value = -2
	gain_text = span_danger("你开始厌恶机械植入物的存在。")
	lose_text = span_notice("也许机械改造没那么糟。现在你能够接受身体强化和义肢了。")
	medical_record_text = "患者表示极度厌恶非天然身体部件及身体改造。"
	hardcore_value = 3
	mail_goodies = list(/obj/item/paper/pamphlet/cybernetics)
	var/cybernetics_level = 0

/datum/quirk/body_purist/add(client/client_source)
	check_cybernetics()
	RegisterSignal(quirk_holder, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_organ_gain))
	RegisterSignal(quirk_holder, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(on_organ_lose))
	RegisterSignal(quirk_holder, COMSIG_CARBON_ATTACH_LIMB, PROC_REF(on_limb_gain))
	RegisterSignal(quirk_holder, COMSIG_CARBON_REMOVE_LIMB, PROC_REF(on_limb_lose))

/datum/quirk/body_purist/remove()
	UnregisterSignal(quirk_holder, list(
		COMSIG_CARBON_GAIN_ORGAN,
		COMSIG_CARBON_LOSE_ORGAN,
		COMSIG_CARBON_ATTACH_LIMB,
		COMSIG_CARBON_REMOVE_LIMB,
	))
	quirk_holder.clear_mood_event("body_purist")

/datum/quirk/body_purist/proc/check_cybernetics()
	var/mob/living/carbon/owner = quirk_holder
	if(!istype(owner))
		return
	for(var/obj/item/bodypart/limb as anything in owner.get_bodyparts())
		if(IS_ROBOTIC_LIMB(limb))
			cybernetics_level++
	for(var/obj/item/organ/organ as anything in owner.organs)
		if(IS_ROBOTIC_ORGAN(organ) && !(organ.organ_flags & ORGAN_HIDDEN))
			cybernetics_level++
	update_mood()

/datum/quirk/body_purist/proc/update_mood()
	quirk_holder.clear_mood_event("body_purist")
	if(cybernetics_level)
		quirk_holder.add_mood_event("body_purist", /datum/mood_event/body_purist, -cybernetics_level * 10)

/datum/quirk/body_purist/proc/on_organ_gain(datum/source, obj/item/organ/new_organ, special)
	SIGNAL_HANDLER
	if(IS_ROBOTIC_ORGAN(new_organ) && !(new_organ.organ_flags & ORGAN_HIDDEN)) //why the fuck are there 2 of them
		cybernetics_level++
		update_mood()

/datum/quirk/body_purist/proc/on_organ_lose(datum/source, obj/item/organ/old_organ, special)
	SIGNAL_HANDLER
	if(IS_ROBOTIC_ORGAN(old_organ) && !(old_organ.organ_flags & ORGAN_HIDDEN))
		cybernetics_level--
		update_mood()

/datum/quirk/body_purist/proc/on_limb_gain(datum/source, obj/item/bodypart/new_limb, special)
	SIGNAL_HANDLER
	if(IS_ROBOTIC_LIMB(new_limb))
		cybernetics_level++
		update_mood()

/datum/quirk/body_purist/proc/on_limb_lose(datum/source, obj/item/bodypart/old_limb, special, dismembered)
	SIGNAL_HANDLER
	if(IS_ROBOTIC_LIMB(old_limb))
		cybernetics_level--
		update_mood()
