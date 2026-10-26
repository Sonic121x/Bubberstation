// Override of Blood Deficiency quirk for robotic/synthetic species.
// Does not appear in TGUI or the character preferences window.
/datum/quirk/blooddeficiency/synth
	name = "Hydraulic Leak"
	desc = "你体内的液压液正从密封处渗漏。"
	medical_record_text = "患者因液压液流失而需要定期治疗。"
	icon = FA_ICON_GLASS_WATER_DROPLET
	mail_goodies = list(/obj/item/reagent_containers/blood/oil)
	// min_blood = BLOOD_VOLUME_BAD - 25; // TODO: Uncomment after TG PR #70563
	hidden_quirk = TRUE

// If blooddeficiency is added to a synth, this detours to the blooddeficiency/synth quirk.
/datum/quirk/blooddeficiency/add_to_holder(mob/living/new_holder, quirk_transfer = FALSE, client/client_source, unique = TRUE, announce = TRUE)
	if(!issynthetic(new_holder) || type != /datum/quirk/blooddeficiency)
		// Defer to TG blooddeficiency if the character isn't robotic.
		return ..()

	var/datum/quirk/blooddeficiency/synth/bd_synth = new
	qdel(src)
	return bd_synth.add_to_holder(new_holder, quirk_transfer, client_source, unique)
