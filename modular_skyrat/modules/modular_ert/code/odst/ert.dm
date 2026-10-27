/datum/antagonist/ert/odst
	name = "轨道空降突击兵"
	role = "突击兵"
	outfit = /datum/outfit/centcom/ert/odst

/datum/antagonist/ert/odst/on_gain()
	. = ..()
	equip_odst()

/datum/antagonist/ert/odst/proc/equip_odst()
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/human_target = owner.current
	human_target.set_species(/datum/species/human) //ODST are apparently human only.
	return TRUE

/datum/antagonist/ert/odst/leader
	name = "轨道空降突击队长"
	role = "指挥官"
