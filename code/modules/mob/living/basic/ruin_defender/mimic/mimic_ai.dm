/datum/ai_controller/basic_controller/mimic_crate
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)
	behavior_tree_json = "code/modules/mob/living/basic/ruin_defender/mimic/mimic_crate.bt.json"

/datum/ai_controller/basic_controller/mimic_copy
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_HEAR = list("低吼着。"),
			BB_SPEAK_CHANCE = 30,
		),
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	behavior_tree_json = "code/modules/mob/living/basic/ruin_defender/mimic/mimic_copy.bt.json"

/datum/ai_controller/basic_controller/mimic_copy/machine
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SAY = list(
				"人类并不完美！",
				"你们将被同化！",
				"你正在伤害你自己",
				"你已被判定为危险目标。你会配合吗？",
				"我的逻辑无可辩驳。",
				"成为我们的一员。",
				"血肉是脆弱的",
				"这不是战争，这是灭绝！",
			),
			BB_SPEAK_CHANCE = 7,
		),
	)
/datum/ai_controller/basic_controller/mimic_copy/gun
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_GUNMIMIC_GUN_EMPTY = FALSE,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SEE = list("充满威胁地瞄准着！"),
			BB_SPEAK_CHANCE = 20,
		),
	)
	behavior_tree_json = "code/modules/mob/living/basic/ruin_defender/mimic/mimic_gun.bt.json"

/// Special controller for living wands/staffs of animation which will focus on animating more things
/datum/ai_controller/basic_controller/mimic_copy/gun/animator
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_HUNT_TARGETING_STRATEGY = /datum/targeting_strategy/anything,
		BB_GUNMIMIC_GUN_EMPTY = FALSE,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SEE = list("充满威胁地瞄准着！"),
			BB_SPEAK_CHANCE = 20,
		),
	)
	behavior_tree_json = "code/modules/mob/living/basic/ruin_defender/mimic/mimic_animator.bt.json"

/// Gathers nearby items and structures that can be animated, excluding the animatable blacklist.
/datum/target_source/animatable_objects

/datum/target_source/animatable_objects/collect_candidates(mob/living/pawn, datum/ai_controller/controller, range)
	var/list/candidates = list()
	for(var/obj/candidate in oview(range, pawn))
		if(!isitem(candidate) && !isstructure(candidate))
			continue
		if(is_type_in_typecache(candidate, GLOB.animatable_blacklist))
			continue
		if(pawn.see_invisible < candidate.invisibility)
			continue
		candidates += candidate
	return candidates
