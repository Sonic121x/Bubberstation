/datum/antagonist/ghoul/proc/give_warning(atom/source, danger_level, vampire_warning_message, ghoul_warning_message)
	SIGNAL_HANDLER
	if(ghoul_warning_message)
		to_chat(owner, ghoul_warning_message)

/**
 * Returns a Ghouls's examine strings.
 * Args:
 * viewer - The person examining.
 */
/datum/antagonist/ghoul/proc/return_ghoul_examine(mob/living/viewer)
	if((!viewer.mind && !isobserver(viewer)) || !iscarbon(owner.current))
		return FALSE
	var/mob/living/carbon/carbon_current = owner.current
	// Target must be a Ghoul
	// Default String
	var/returnString = "\[<span class='warning'>"
	var/returnIcon = ""
	// Ghouls and Bloodsuckers recognize eachother, while Monster Hunters can see Ghouls.
	if(!IS_BLOODSUCKER(viewer) && !IS_GHOUL(viewer) && !IS_MONSTERHUNTER(viewer) && !isobserver(viewer))
		return FALSE
	// Am I Viewer's Ghoul?
	if(master.owner == viewer.mind)
		returnString += "这名[chinese_footprint_species_display(carbon_current.dna.species.name)]身上带有你的印记！"
		returnIcon = "[icon2html('modular_zubbers/icons/misc/language.dmi', world, "ghoul")]"
	// Am I someone ELSE'S Ghoul?
	else if(IS_BLOODSUCKER(viewer) || IS_MONSTERHUNTER(viewer) || isobserver(viewer))
		returnString += "这名[chinese_footprint_species_display(carbon_current.dna.species.name)]身上带有<span class='boldwarning'>[master.return_full_name()][master.broke_masquerade ? "（已违背避世戒律）" : ""]</span>的印记。"
		returnIcon = "[icon2html('modular_zubbers/icons/misc/language.dmi', world, "ghoul_grey")]"
	// Are you serving the same master as I am?
	else if(viewer.mind.has_antag_datum(/datum/antagonist/ghoul) in master.ghouls)
		returnString += "对方身上带有你主人的印记。"
		returnIcon = "[icon2html('modular_zubbers/icons/misc/language.dmi', world, "ghoul")]"
	// You serve a different Master than I do.
	else
		returnString += "对方身上带有另一位吸血鬼的印记。"
		returnIcon = "[icon2html('modular_zubbers/icons/misc/language.dmi', world, "ghoul_grey")]"

	returnString += "</span>\]" // \n"  Don't need spacers. Using . += "" in examine.dm does this on its own.
	return returnIcon + returnString

/// Used when your Master teaches you a new Power.
/datum/antagonist/ghoul/proc/BuyPower(datum/action/cooldown/power, list_to_add_to = powers)
	for(var/datum/action/current_powers as anything in list_to_add_to)
		if(current_powers.type == power.type)
			return FALSE
	power = new power()
	list_to_add_to += power
	power.Grant(owner.current)
	log_uplink("[key_name(owner.current)] 购买了 [power]。")
	return TRUE

/datum/antagonist/ghoul/proc/LevelUpPowers()
	for(var/datum/action/cooldown/bloodsucker/power in powers)
		power.level_current++

/// Called when we are made into the Favorite Ghoul
/datum/antagonist/ghoul/proc/make_special(datum/antagonist/ghoul/ghoul_type)
	//store what we need
	var/datum/mind/ghoul_owner = owner
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = master

	//remove our antag datum
	silent = TRUE
	ghoul_owner.remove_antag_datum(/datum/antagonist/ghoul)

	//give our new one
	var/datum/antagonist/ghoul/ghouldatum = new ghoul_type(ghoul_owner)
	ghouldatum.master = bloodsuckerdatum
	ghouldatum.silent = TRUE
	ghoul_owner.add_antag_datum(ghouldatum)
	ghouldatum.silent = FALSE

	//send alerts of completion
	to_chat(master, span_danger("你已将 [ghoul_owner.current] 转化为你的[ghouldatum.name]！心灵护盾将无法再解除对方的血仆身份！"))
	to_chat(ghoul_owner, span_notice("鲜血滴落在你的身上，你感觉与主人的联系更加紧密……你现在是[ghouldatum.name]了！"))
	ghoul_owner.current.playsound_local(null, 'sound/effects/magic/mutate.ogg', 75, FALSE, pressure_affected = FALSE)
