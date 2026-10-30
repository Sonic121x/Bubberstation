
/*
 * Bruise wounds
 *
 * Very minor, flavor wounds, for the Coroner to see what may have led up to an individual's death.
 */
/datum/wound_pregen_data/bruised
	abstract = FALSE
	wound_path_to_generate = /datum/wound/bruised
	required_limb_biostate = BIO_FLESH
	required_wounding_type = NONE
	wound_series = WOUND_SERIES_BRUISING

/datum/wound/bruised
	name = "淤青"
	undiagnosed_name = "淤青"
	desc = "患者皮肤上有淤青，显露出挣扎的痕迹。"
	sound_effect = null
	treat_text = "会随时间自行消退。"
	treat_text_short = "最好让它自行恢复。"
	examine_desc = null
	occur_text = "出现了淤青"
	threshold_penalty = 1
	processes = TRUE
	default_scar_file = null
	severity = WOUND_SEVERITY_TRIVIAL
	simple_treat_text = null
	homemade_treat_text = null

	///How many ticks the bruise has left until it disappears. Only ticks away while the victim is alive.
	var/bruise_ticks = 25

/datum/wound/bruised/handle_process(seconds_per_tick)
	if (!victim || HAS_TRAIT(victim, TRAIT_STASIS) || IS_DEAD_OR_FAKING(victim))
		return

	bruise_ticks--
	if(!bruise_ticks)
		qdel(src)

/datum/wound/bruised/on_xadone(power)
	. = ..()
	qdel(src)

/datum/wound/bruised/on_synthflesh(reac_volume)
	. = ..()
	qdel(src)
