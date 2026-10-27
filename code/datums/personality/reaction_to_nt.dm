/datum/personality/nt
	groups = list(PERSONALITY_GROUP_NT)
	processes = TRUE
	/// What mood event to apply when seeing NT propaganda
	var/mood_event_type

/datum/personality/nt/proc/can_see_nt_propaganda(mob/living/subject)
	for(var/obj/structure/sign/nearby in view(subject, 5))
		if(istype(nearby, /obj/structure/sign/nanotrasen))
			return TRUE
		if(istype(nearby, /obj/structure/sign/poster/official/nanotrasen_logo))
			return TRUE

	return FALSE

/datum/personality/nt/on_tick(mob/living/subject, seconds_per_tick)
	if(can_see_nt_propaganda(subject))
		subject.add_mood_event("nt_personality", mood_event_type)
	else
		subject.clear_mood_event("nt_personality")

/datum/personality/nt/remove_from_mob(mob/living/who)
	. = ..()
	who.clear_mood_event("nt_personality")

/datum/personality/nt/loyalist
	savefile_key = "loyalist"
	name = "忠诚"
	desc = "我对空间站和中央指挥部的信念至死不渝！"
	pos_gameplay_desc = "喜欢公司的海报和标牌"
	mood_event_type = /datum/mood_event/nt_loyalist

/datum/personality/nt/disillusioned
	savefile_key = "disillusioned"
	name = "理想破灭"
	desc = "纳米传讯已经变了。这不是我当初加入时所期待的。"
	neg_gameplay_desc = "不喜欢公司的海报和标牌"
	mood_event_type = /datum/mood_event/nt_disillusioned
