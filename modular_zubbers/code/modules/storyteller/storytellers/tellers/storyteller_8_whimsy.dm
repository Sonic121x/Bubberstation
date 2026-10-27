/datum/storyteller/whimsy
	name = "奇趣（事件较少，偏重搞怪）"
	desc = "这位故事讲述者会生成大量事件，但会降低战斗与混乱的优先级，只留下那些不会杀死玩家或造成破坏的日常事件。"
	welcome_text = "我只是个傻乎乎的小家伙！！！！！！"

	tag_multipliers = list(
		TAG_NPC_ANTAG = 0.3,
		TAG_COMBAT = 0.3,
		TAG_DESTRUCTIVE = 0.3,
		TAG_CHAOTIC = 0.1
	)
	antag_divisor = 32
	storyteller_type = STORYTELLER_TYPE_CALM

	guarantees_roundstart_crewset = FALSE

	track_data = /datum/storyteller_data/tracks/whimsy

	starting_point_multipliers = list(
		EVENT_TRACK_MUNDANE = 0.6,
		EVENT_TRACK_MODERATE = 0.8,
		EVENT_TRACK_MAJOR = 1,
		EVENT_TRACK_CREWSET = 1,
		EVENT_TRACK_GHOSTSET = 0
	)
	event_repetition_multiplier = 1

/datum/storyteller_data/tracks/whimsy
	threshold_mundane = 1200
	threshold_moderate = 1600
	threshold_major = 16000
	threshold_crewset = 3200
	threshold_ghostset = 20000
