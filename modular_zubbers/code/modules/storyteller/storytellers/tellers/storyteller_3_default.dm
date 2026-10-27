/datum/storyteller/default
	name = "默认安迪（正常事件/反派抽取）"
	desc = "这是默认的故事讲述者，也是衡量其他所有故事讲述者的基准。\
	它处于其他事件讲述者的中间位置。最适合平均而多样的游戏体验。"
	welcome_text = "如果我把你丢进绞肉机里剁碎……"
	antag_divisor = 8
	storyteller_type = STORYTELLER_TYPE_ALWAYS_AVAILABLE

	tag_multipliers = list(
		TAG_CHAOTIC = 0.7
	)

/datum/storyteller/default/New()
	track_data = new /datum/storyteller_data/tracks
	track_data.threshold_mundane *= CONFIG_GET(number/default_points_threshold_coefficient) * CONFIG_GET(number/default_mundane_points_threshold_coefficient)
	track_data.threshold_moderate *= CONFIG_GET(number/default_points_threshold_coefficient) * CONFIG_GET(number/default_moderate_points_threshold_coefficient)
	track_data.threshold_major *= CONFIG_GET(number/default_points_threshold_coefficient) * CONFIG_GET(number/default_major_points_threshold_coefficient)
	track_data.threshold_crewset *= CONFIG_GET(number/default_points_threshold_coefficient) * CONFIG_GET(number/default_crewset_points_threshold_coefficient)
	track_data.threshold_ghostset *= CONFIG_GET(number/default_points_threshold_coefficient) * CONFIG_GET(number/default_ghostset_points_threshold_coefficient)

/datum/config_entry/number/default_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/default_mundane_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/default_moderate_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/default_major_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/default_crewset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/default_ghostset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

