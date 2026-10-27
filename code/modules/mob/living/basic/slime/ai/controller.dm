/datum/ai_controller/basic_controller/slime
	blackboard = list(
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/slime_food,
		BB_SLIME_RABID = FALSE,
		BB_SLIME_HUNGER_DISABLED = FALSE,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SAY = list("咕噜……","兹兹……",""),
			BB_EMOTE_HEAR = list("咕噜作响。"),
			BB_EMOTE_SEE = list("亮了一下，随后又暗下去。","在原地弹跳。", "颤动着！","抖动着！"),
			BB_SPEAK_CHANCE = 1,
		),
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	behavior_tree_json = "code/modules/mob/living/basic/slime/ai/slime.bt.json"
