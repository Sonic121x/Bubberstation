//Strained Muscles: Temporary speed boost at the cost of rapid damage
//Limited because of space suits and such; ideally, used for a quick getaway

/datum/action/changeling/strained_muscles
	name = "紧绷肌肉"
	desc = "我们进化出减少肌肉中酸性物质堆积的能力，使我们能移动得远为迅速。"
	helptext = "这种紧绷会让我们疲惫，并很快陷入力竭。太空服等标准负重限制依然有效。无法在低等形态下使用。"
	button_icon_state = "strained_muscles"
	category = "utility"
	chemical_cost = 0
	dna_cost = 1
	req_human = TRUE
	var/stacks = 0 //Increments every 5 seconds; damage increases over time
	active = FALSE //Whether or not you are a hedgehog
	disabled_by_fire = FALSE

/datum/action/changeling/strained_muscles/sting_action(mob/living/carbon/user)
	..()
	active = !active
	if(active)
		to_chat(user, span_notice("我们的肌肉紧绷、变得强健。"))
	else
		user.remove_movespeed_modifier(/datum/movespeed_modifier/strained_muscles)
		to_chat(user, span_notice("我们的肌肉放松下来。"))
		if(stacks >= 10)
			to_chat(user, span_danger("我们力竭倒下。"))
			user.Paralyze(60)
			user.emote("gasp")

	INVOKE_ASYNC(src, PROC_REF(muscle_loop), user)

	return TRUE

/datum/action/changeling/strained_muscles/Remove(mob/user)
	user.remove_movespeed_modifier(/datum/movespeed_modifier/strained_muscles)
	return ..()

/datum/action/changeling/strained_muscles/proc/muscle_loop(mob/living/carbon/user)
	while(active)
		if(QDELETED(src) || QDELETED(user))
			return

		user.add_movespeed_modifier(/datum/movespeed_modifier/strained_muscles)
		if(IS_UNCONSCIOUS_OR_CRIT(user) || user.staminaloss >= 90)
			active = !active
			to_chat(user, span_notice("我们的肌肉没了绷紧的力气，松弛下来。"))
			user.Paralyze(40)
			user.remove_movespeed_modifier(/datum/movespeed_modifier/strained_muscles)
			break

		stacks++

		user.adjust_stamina_loss(stacks * 1.3) //At first the changeling may regenerate stamina fast enough to nullify fatigue, but it will stack

		if(stacks == 11) //Warning message that the stacks are getting too high
			to_chat(user, span_warning("我们的腿真的开始疼了……"))

		sleep(4 SECONDS)

	while(!active && stacks) //Damage stacks decrease fairly rapidly while not in sanic mode
		if(QDELETED(src) || QDELETED(user))
			return

		stacks--
		sleep(2 SECONDS)
