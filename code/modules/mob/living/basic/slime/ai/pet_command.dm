/datum/pet_command/attack/slime
	speech_commands = list("attack", "sic", "kill", "eat", "feed")
	command_feedback = "咕噜作响"
	pointed_reaction = "并咕噜作响"
	refuse_reaction = "伤心地颤动着"

/datum/pet_command/attack/slime/execute_action(datum/ai_controller/controller)
	var/mob/living/basic/slime/slime_pawn = controller.pawn
	if(isslime(slime_pawn) && slime_pawn.can_feed_on(controller.blackboard[BB_CURRENT_PET_TARGET], check_friendship = TRUE))
		controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, /datum/bt_node/subtree/pet_command/attack/slime)
		return
	return ..()
