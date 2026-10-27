/datum/storyteller/npc_war
	name = "蜂群（侧重敌对 NPC）"
	desc = "这位故事讲述者极其优先安排 NPC 反派的生成，以便在回合中持续为战斗岗位提供目标，作为玩家操控反派标准出现率的补充。"
	welcome_text = "战争！呼！它有什么好处？绝对一无是处！"

	tag_multipliers = list(
		TAG_NPC_ANTAG = 4, //fuck em
	)
	population_min = 35
	storyteller_type = STORYTELLER_TYPE_INTENSE

	guarantees_roundstart_crewset = TRUE

	track_data = /datum/storyteller_data/tracks/npc_war

	starting_point_multipliers = list(
		EVENT_TRACK_MUNDANE = 0.6,
		EVENT_TRACK_MODERATE = 0.8,
		EVENT_TRACK_MAJOR = 1,
		EVENT_TRACK_CREWSET = 1,
		EVENT_TRACK_GHOSTSET = 0
	)
	event_repetition_multiplier = 1

/datum/storyteller_data/tracks/npc_war
	threshold_mundane = 1200
	threshold_moderate = 1350
	threshold_major = 2850
	threshold_crewset = 2400
	threshold_ghostset = 6000
