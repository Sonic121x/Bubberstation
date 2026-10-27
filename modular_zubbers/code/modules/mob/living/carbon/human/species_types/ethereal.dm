/datum/species/ethereal/get_species_description()
	return list("以太人来自斯普劳特星球，这个神权社会 \
		按种姓在社交上彼此分隔，并信奉扶助弱者与 \
		受压迫者的教义。",)

/datum/species/ethereal/on_species_gain(mob/living/carbon/human/new_ethereal, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	var/datum/action/sing_tones/sing_action = new
	sing_action.Grant(new_ethereal)
