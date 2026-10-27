//Overrides TG's version of the proc - only changes are the examine texts, and the extra DNR check
/mob/living/carbon/human/generate_death_examine_text()
	var/mob/dead/observer/ghost = get_ghost(TRUE, TRUE)
	// var/t_He = p_They()
	// var/t_is = p_are()
	//This checks to see if the body is revivable
	if((key || !get_organ_by_type(/obj/item/organ/brain) || ghost?.can_reenter_corpse))
		return span_deadsay("瘫软无力、毫无反应；偶尔还会抽搐一下，也许还能被救回来……！")
	else
		return span_deadsay("瘫软无力、毫无反应；已经没有任何生命迹象，并且已损伤到无法复苏……")

///copies over clothing preferences like underwear to another human
/mob/living/carbon/human/copy_clothing_prefs(mob/living/carbon/human/destination)
	. = ..()

	destination.bra = bra
	destination.bra_color = bra_color
