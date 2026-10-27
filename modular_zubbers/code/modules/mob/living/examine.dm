//Overrides TG's version of the proc - only changes are the examine texts, and the extra DNR check
/mob/living/carbon/human/generate_death_examine_text()
	var/mob/dead/observer/ghost = get_ghost(TRUE, TRUE)
	// Chinese examine text does not require an English subject pronoun.
	// Chinese examine text does not require an English copula.
	//This checks to see if the body is revivable
	if(key || !get_organ_by_type(/obj/item/organ/brain) || ghost?.can_reenter_corpse)
		return span_deadsay("其身体软瘫，毫无反应；没有任何生命迹象……")
	else
		return span_deadsay("其身体软瘫，毫无反应；没有任何生命迹象，灵魂也已经离去……")
