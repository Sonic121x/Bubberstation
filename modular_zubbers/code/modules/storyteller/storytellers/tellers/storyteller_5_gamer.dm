/datum/storyteller/gamer
	name = "重度（侧重船员反派生成）"
	desc = "这位故事讲述者优先安排以战斗为主的遭遇和混乱，不过由于玩家的自主行动，实际的混乱程度可能难以预测。破坏性事件的数量会减少。"
	welcome_text = "欢迎来到玩家型故事讲述者。现在管理员求助量增加了 50%！"

	track_data = /datum/storyteller_data/tracks/gamer

	tag_multipliers = list(
		TAG_COMBAT = 1.5,
		TAG_DESTRUCTIVE = 0.7,
		TAG_CHAOTIC = 1.3
	)
	population_min = 35
	antag_divisor = 5
	storyteller_type = STORYTELLER_TYPE_INTENSE

/datum/storyteller/gamer/New()
	track_data = new /datum/storyteller_data/tracks/gamer
	track_data.threshold_mundane *= CONFIG_GET(number/gamer_points_threshold_coefficient) * CONFIG_GET(number/gamer_mundane_points_threshold_coefficient)
	track_data.threshold_moderate *= CONFIG_GET(number/gamer_points_threshold_coefficient) * CONFIG_GET(number/gamer_moderate_points_threshold_coefficient)
	track_data.threshold_major *= CONFIG_GET(number/gamer_points_threshold_coefficient) * CONFIG_GET(number/gamer_major_points_threshold_coefficient)
	track_data.threshold_crewset *= CONFIG_GET(number/gamer_points_threshold_coefficient) * CONFIG_GET(number/gamer_crewset_points_threshold_coefficient)
	track_data.threshold_ghostset *= CONFIG_GET(number/gamer_points_threshold_coefficient) * CONFIG_GET(number/gamer_ghostset_points_threshold_coefficient)

/datum/storyteller_data/tracks/gamer
	threshold_moderate = 1300
	threshold_major = 4000
	threshold_crewset = 2000
	threshold_ghostset = 4800

/datum/config_entry/number/gamer_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/gamer_mundane_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/gamer_moderate_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/gamer_major_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/gamer_crewset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/gamer_ghostset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0
