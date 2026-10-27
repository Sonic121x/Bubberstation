/datum/ai_controller/basic_controller/deer
	behavior_tree_json = "code/modules/mob/living/basic/farm_animals/deer/deer.bt.json"
	blackboard = list(
		BB_STATIONARY_MOVE_TO_TARGET = TRUE,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SAY = list("呦呦呦？", "呦呦", "呦—————"),
			BB_EMOTE_HEAR = list("呦呦叫着。"),
			BB_EMOTE_SEE = list("摇了摇头。"),
			BB_SPEAK_CHANCE = 1,
		),
	)
	ai_traits = PASSIVE_AI_FLAGS
	ai_movement = /datum/ai_movement/basic_avoidance

/// Munches grass with a happy little emote.
/datum/bt_node/ai_behavior/hunt_target/deer_graze
	always_reset_target = TRUE
	hunt_cooldown = 15 SECONDS

/datum/bt_node/ai_behavior/hunt_target/deer_graze/target_caught(mob/living/hunter, atom/hunted)
	var/static/list/possible_emotes = list("吃起了草！", "大口嚼着草！", "咀嚼着草！")
	hunter.manual_emote(pick(possible_emotes))


/// Splashes happily in the water.
/datum/bt_node/ai_behavior/hunt_target/deer_drink
	always_reset_target = TRUE
	hunt_cooldown = 20 SECONDS

/datum/bt_node/ai_behavior/hunt_target/deer_drink/target_caught(mob/living/hunter, atom/hunted)
	var/static/list/possible_emotes = list("喝起了水！", "在水中起舞！", "开心地泼着水！")
	hunter.manual_emote(pick(possible_emotes))


/// Claims a tree as home territory.
/datum/bt_node/ai_behavior/hunt_target/deer_mark
	always_reset_target = TRUE
	hunt_cooldown = 15 SECONDS

/datum/bt_node/ai_behavior/hunt_target/deer_mark/target_caught(mob/living/hunter, atom/hunted)
	hunter.manual_emote("用蹄子标记了 [hunted]！")
	hunter.ai_controller?.set_blackboard_key(BB_DEER_TREEHOME, hunted)


/// Rests by its home tree, then won't feel the need to rest again for a while.
/datum/bt_node/ai_behavior/deer_rest
	/// How long we stand resting once we arrive (kept RUNNING via the cooldown).
	var/rest_duration = 15 SECONDS
	/// Minimum/maximum time before we want to rest again.
	var/minimum_time = 2 MINUTES
	var/maximum_time = 4 MINUTES
	///ID for the rest timer
	var/timerid
	///Are we napping?
	var/sleeping

/datum/bt_node/ai_behavior/deer_rest/setup(datum/ai_controller/controller)
	. = ..()
	timerid = addtimer(CALLBACK(src, PROC_REF(finish_action), controller, TRUE), rest_duration, TIMER_UNIQUE | TIMER_STOPPABLE)

/datum/bt_node/ai_behavior/deer_rest/perform(seconds_per_tick, datum/ai_controller/controller)
	if(sleeping)
		return AI_BEHAVIOR_DELAY
	var/mob/living/living_pawn = controller.pawn
	var/static/list/possible_emotes = list("歇了歇腿……", "打了个哈欠打起盹来……", "蜷起身子休息……")
	living_pawn.manual_emote(pick(possible_emotes))
	sleeping = TRUE
	return AI_BEHAVIOR_DELAY

/datum/bt_node/ai_behavior/deer_rest/finish_action(datum/ai_controller/controller, succeeded)
	. = ..()
	deltimer(timerid)
	timerid = null
	sleeping = FALSE
	controller.set_blackboard_key(BB_DEER_NEXT_REST_TIMER, world.time + rand(minimum_time, maximum_time))

/// Plays with another deer, spinning around them.
/datum/bt_node/ai_behavior/deer_play
	/// Blackboard key holding the deer we're playing with.
	var/friend_key = BB_DEER_PLAYFRIEND

/datum/bt_node/ai_behavior/deer_play/perform(seconds_per_tick, datum/ai_controller/controller)
	var/atom/friend = controller.blackboard[friend_key]
	if(QDELETED(friend))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED
	var/static/list/possible_emotes = list("一起玩耍", "一起跳舞", "一起庆祝")
	var/mob/living/living_pawn = controller.pawn
	living_pawn.manual_emote("和 [friend] [pick(possible_emotes)]！")
	living_pawn.spin(spintime = 4, speed = 1)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/bt_node/ai_behavior/deer_play/finish_action(datum/ai_controller/controller, succeeded)
	. = ..()
	controller.clear_blackboard_key(friend_key)
