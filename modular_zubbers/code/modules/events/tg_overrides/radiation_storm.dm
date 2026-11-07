/datum/round_event/radiation_storm/announce(fake)
	priority_announce(
		text = "检测到空间站附近存在高强度辐射。建议空间站全体船员前往空间站的技术隧道躲避。",
		title = "辐射警报",
		sound = ANNOUNCER_RADIATION,
	)
	// we trigger the airlocks for a bit to not immediately give away that it's fake
	if(fake && !GLOB.emergency_access)
		make_maint_all_access(silent = TRUE)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(revoke_maint_all_access), FALSE), 90 SECONDS)
