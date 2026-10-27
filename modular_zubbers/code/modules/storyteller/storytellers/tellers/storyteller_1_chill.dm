/datum/storyteller/chill
	name = "轻度（事件/反派抽取较少）"
	desc = "与其他故事讲述者相比，这位故事讲述者的事件和反派抽取会少一些，尤其是涉及战斗、破坏或混乱的内容。\
	它是所有故事讲述者中最不折腾的，但仍然保留了一些调味。最适合以角色扮演为主、偶尔穿插少量事件和反派的回合。"
	welcome_text = "如果你在冰盒站上投给这位故事讲述者，那你可真没创意。"

	track_data = /datum/storyteller_data/tracks/chill

	guarantees_roundstart_crewset = FALSE
	tag_multipliers = list(
		TAG_COMBAT = 0.3,
		TAG_DESTRUCTIVE = 0.3,
		TAG_CHAOTIC = 0.1
	)
	antag_divisor = 32
	storyteller_type = STORYTELLER_TYPE_CALM

/datum/storyteller/chill/New()
	track_data = new /datum/storyteller_data/tracks/chill
	track_data.threshold_mundane *= CONFIG_GET(number/chill_points_threshold_coefficient) * CONFIG_GET(number/chill_mundane_points_threshold_coefficient)
	track_data.threshold_moderate *= CONFIG_GET(number/chill_points_threshold_coefficient) * CONFIG_GET(number/chill_moderate_points_threshold_coefficient)
	track_data.threshold_major *= CONFIG_GET(number/chill_points_threshold_coefficient) * CONFIG_GET(number/chill_major_points_threshold_coefficient)
	track_data.threshold_crewset *= CONFIG_GET(number/chill_points_threshold_coefficient) * CONFIG_GET(number/chill_crewset_points_threshold_coefficient)
	track_data.threshold_ghostset *= CONFIG_GET(number/chill_points_threshold_coefficient) * CONFIG_GET(number/chill_ghostset_points_threshold_coefficient)

/datum/storyteller_data/tracks/chill
	threshold_mundane = 1800
	threshold_moderate = 2700
	threshold_major = 16000
	threshold_crewset = 3200
	threshold_ghostset = 20000

/datum/config_entry/number/chill_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/chill_mundane_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/chill_moderate_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/chill_major_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/chill_crewset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/chill_ghostset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0
