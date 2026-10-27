/datum/ai_controller/basic_controller/cow
	behavior_tree_json = "code/modules/mob/living/basic/farm_animals/cow/cow.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_TIP_REACTING = FALSE,
		BB_BASIC_MOB_TIPPER = null,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SAY = list("哞？", "哞", "哞哞哞哞哞"),
			BB_EMOTE_HEAR = list("哞哞叫着。"),
			BB_EMOTE_SEE = list("摇了摇头。"),
			BB_EMOTE_SOUND = list('sound/mobs/non-humanoids/cow/cow.ogg'),
			BB_SPEAK_CHANCE = 1,
		),
	)

	ai_traits = PASSIVE_AI_FLAGS
	ai_movement = /datum/ai_movement/basic_avoidance

/// While we're tipped over, plead with nearby people instead of doing anything else.
/datum/bt_node/subtree/tip_reaction
	behavior_tree_json = "code/datums/ai/basic_mobs/basic_subtrees/tip_reaction.bt.json"
