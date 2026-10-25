/datum/action/changeling/adrenaline
	name = "基因刺激"
	desc = "我们将体内化学物质浓缩成强效兴奋剂，让我们的躯体在抵御失能方面强壮得惊人。消耗 25 单位化学物质。"
	helptext = "无视任何已使我们昏迷的状态，并向我们的躯体注入四单位变形怪肾上腺素；在效果持续期间，我们的躯体会恢复大量耐力，并完全无视痛苦与疲劳。"
	button_icon_state = "adrenaline"
	category = "combat"
	chemical_cost = 25 // similar cost to biodegrade, as they serve similar purposes
	dna_cost = 2
	req_human = FALSE
	req_stat = STABLE
	disabled_by_fire = TRUE

//Recover from stuns.
/datum/action/changeling/adrenaline/sting_action(mob/living/carbon/user)
	..()

	// Get us standing up.
	user.SetAllImmobility(0)
	user.set_stamina_loss(0)
	user.set_resting(FALSE, instant = TRUE)

	user.reagents.add_reagent(/datum/reagent/medicine/changelingadrenaline, 4) //Tank 5 consecutive baton hits

	to_chat(user, span_changeling("这股为我们的生理量身打造的兴奋剂带来的猛烈冲击令人精神振奋。我们绝不会被制服。"))

	return TRUE
