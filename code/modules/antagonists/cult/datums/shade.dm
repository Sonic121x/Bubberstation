/datum/antagonist/cult/shade
	name = "\improper 血教暗影"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	antagpanel_category = ANTAG_GROUP_HORRORS
	///The time this player was most recently released from a soulstone.
	var/release_time
	///The time needed after release time to enable rune invocation.
	var/invoke_delay = (1 MINUTES)

/datum/antagonist/cult/shade/check_invoke_validity()
	if(isnull(release_time))
		to_chat(owner.current, span_alert("你无法在灵魂石内部唤起符文！"))
		return FALSE

	if(release_time + invoke_delay > world.time)
		to_chat(owner.current, span_alert("你还没有聚集足够的能量来唤起符文。你需要离开灵魂石再等一段时间！"))
		return FALSE
	return TRUE
