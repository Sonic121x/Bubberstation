/datum/storyteller/bomb
	name = "爆破（侧重破坏性事件）"
	desc = "这位故事讲述者会倾向于安排更多破坏性事件。适合在你有一整支工程团队的时候。或者没人的时候，因为他们全都进低温休眠舱了。"
	welcome_text = "有人给我们装了个炸弹。"
	track_data = /datum/storyteller_data/tracks/bomb

	tag_multipliers = list(
		TAG_DESTRUCTIVE = 1.5
	)
	population_min = 25
	antag_divisor = 10
	storyteller_type = STORYTELLER_TYPE_INTENSE

/datum/storyteller/bomb/New()
	track_data = new /datum/storyteller_data/tracks/bomb
	track_data.threshold_mundane *= CONFIG_GET(number/bomb_points_threshold_coefficient) * CONFIG_GET(number/bomb_mundane_points_threshold_coefficient)
	track_data.threshold_moderate *= CONFIG_GET(number/bomb_points_threshold_coefficient) * CONFIG_GET(number/bomb_moderate_points_threshold_coefficient)
	track_data.threshold_major *= CONFIG_GET(number/bomb_points_threshold_coefficient) * CONFIG_GET(number/bomb_major_points_threshold_coefficient)
	track_data.threshold_crewset *= CONFIG_GET(number/bomb_points_threshold_coefficient) * CONFIG_GET(number/bomb_crewset_points_threshold_coefficient)
	track_data.threshold_ghostset *= CONFIG_GET(number/bomb_points_threshold_coefficient) * CONFIG_GET(number/bomb_ghostset_points_threshold_coefficient)

/datum/storyteller_data/tracks/bomb
	threshold_mundane = 1800
	threshold_moderate = 1400
	threshold_major = 5500

/datum/config_entry/number/bomb_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/bomb_mundane_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/bomb_moderate_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/bomb_major_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/bomb_crewset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/bomb_ghostset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0
