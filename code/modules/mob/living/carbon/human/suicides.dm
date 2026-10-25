/mob/living/carbon/human/proc/delayed_suicide()
	suicide_log()
	adjust_brute_loss(max(200 - get_tox_loss() - get_fire_loss() - get_brute_loss() - get_oxy_loss(), 0))
	investigate_log("已自杀身亡。", INVESTIGATE_DEATHS)
	death(FALSE)
	ghostize(FALSE) // Disallows reentering body and disassociates mind
