/datum/controller/subsystem/shuttle/proc/fleshmind_call(ai_name)
	if(EMERGENCY_IDLE_OR_RECALLED)
		SSshuttle.emergency.request()
		priority_announce("这里是[ai_name]，我已接管纳米传讯的撤离网络。承载我们血肉的飞船即将抵达。预计会遭遇抵抗，准备战斗。", "紧急穿梭机", ANNOUNCER_SHUTTLECALLED, "Priority")
	emergency_no_recall = TRUE
