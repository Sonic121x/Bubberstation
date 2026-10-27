/datum/ai_controller/basic_controller/turtle
	behavior_tree_json = "code/modules/mob/living/basic/turtle/turtle.bt.json"
	blackboard = list(
		BB_HAPPY_EMOTIONS = list(
			"兴奋地晃动树冠！",
			"高高抬起头！",
			"热情地摇尾巴！",
		),
		BB_MODERATE_EMOTIONS = list(
			"平视前方，眼睛半闭着。",
			"安静地沐浴在光照中。",
		),
		BB_SAD_EMOTIONS = list(
			"失望地望向地面……",
			"树上的叶子垂了下来……",
		),
	)
	ai_movement = /datum/ai_movement/basic_avoidance
