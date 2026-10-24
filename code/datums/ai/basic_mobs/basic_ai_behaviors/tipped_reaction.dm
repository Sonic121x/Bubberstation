///A tipped-over mob looks to a nearby person for help, then resigns itself to its fate.
/datum/bt_node/ai_behavior/tipped_reaction
	/// Blackboard key holding the mob that tipped us over.
	var/tipper_key = BB_BASIC_MOB_TIPPER
	/// Blackboard key holding whether we are still reacting to being tipped.
	var/reacting_key = BB_BASIC_MOB_TIP_REACTING

/datum/bt_node/ai_behavior/tipped_reaction/perform(seconds_per_tick, datum/ai_controller/controller)
	var/mob/living/carbon/tipper = controller.blackboard[tipper_key]

	var/mob/living/carbon/savior
	// look for someone in a radius around us for help. If our original tipper is in range, prioritize them
	for(var/mob/living/carbon/potential_aid in oview(3, get_turf(controller.pawn)))
		if(potential_aid == tipper)
			savior = tipper
			break
		savior = potential_aid

	var/seen_message
	var/self_message
	if(prob(75) && savior)
		var/text = pick("恳求地", "哀求地", "带着认命的神情")
		seen_message = "[controller.pawn][text]看着[savior]。"
		self_message = "你[text]看着[savior]。"
	else
		seen_message = "[controller.pawn]似乎已经认命了。"
		self_message = "你认命了。"
	controller.pawn.visible_message(span_notice("[seen_message]"), span_notice("[self_message]"))
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/bt_node/ai_behavior/tipped_reaction/finish_action(datum/ai_controller/controller, succeeded)
	. = ..()
	//I'VE SAID MY PEACE...
	controller.set_blackboard_key(reacting_key, FALSE)
	controller.clear_blackboard_key(tipper_key)
