/datum/religion_rites/deaconize/dreamers
	desc = "将某人转化为你的教派成员。对方必须自愿，因此第一次施仪只会邀请其加入。\
		他们将获得与你相同的神圣能力。你最多可授任三名追随者，慎重选择！"
	rite_flags = parent_type::rite_flags & ~RITE_ONE_TIME_USE

/datum/religion_rites/deaconize/dreamers/invoke_effect(mob/living/carbon/human/user, atom/movable/religious_tool)
	if(HAS_TRAIT(potential_deacon, TRAIT_NIGHTMARISH))
		to_chat(user, span_warning("[potential_deacon] 是梦魇，是对 [GLOB.deity] 及其所代表一切的公然亵渎！"))
		return FALSE
	return ..()

/datum/religion_rites/deaconize/dreamers/post_invoke_effects(mob/living/user, atom/religious_tool)
	. = ..()
	if(!istype(GLOB.religious_sect, /datum/religion_sect/dreams))
		return

	var/datum/religion_sect/dreams/sect = GLOB.religious_sect
	sect.deacon_count += 1
	if(sect.deacon_count >= sect.max_deacons)
		sect.rites_list -= type
