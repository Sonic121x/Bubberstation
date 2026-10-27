/datum/wound/muscle/robotic
	sound_effect = 'sound/effects/wounds/blood1.ogg'

/datum/wound_pregen_data/muscle/robotic
	required_limb_biostate = (BIO_METAL)

/datum/wound/muscle/robotic/moderate
	name = "伺服过载"
	desc = "一个伺服电机已超负荷运转，在休息之前将以降低的效率工作。"
	treat_text = "在受伤肢体上紧紧打上夹板，并充分休息与睡眠。"
	examine_desc = "动作显得迟缓"
	occur_text = "抖动了一下，随后动作变得迟缓"
	treat_text_short = "纱布包扎并休息"
	severity = WOUND_SEVERITY_MODERATE
	interaction_efficiency_penalty = 1.5
	limp_slowdown = 2
	limp_chance = 30
	threshold_penalty = 15
	status_effect_type = /datum/status_effect/wound/muscle/robotic/moderate
	regen_ticks_needed = 90

/datum/wound_pregen_data/muscle/robotic/servo
	abstract = FALSE
	wound_path_to_generate = /datum/wound/muscle/robotic/moderate
	threshold_minimum = 35

/datum/wound/muscle/robotic/severe
	name = "活塞力竭"
	sound_effect = 'sound/effects/wounds/blood2.ogg'
	desc = "一个重要的液压活塞被严重过度使用，在恢复之前完全失去功能。"
	treat_text = "在受伤肢体上紧紧打上夹板，并充分休息与睡眠。"
	examine_desc = "僵硬地垂着，末端向外张开"
	occur_text = "完全僵住，似乎锁死在了某个姿势"
	treat_text_short = "纱布包扎并休息"
	severity = WOUND_SEVERITY_SEVERE
	interaction_efficiency_penalty = 2
	limp_slowdown = 5
	limp_chance = 40
	threshold_penalty = 35
	disabling = TRUE
	status_effect_type = /datum/status_effect/wound/muscle/robotic/severe
	regen_ticks_needed = 150

/datum/wound_pregen_data/muscle/robotic/hydraulic
	abstract = FALSE

	wound_path_to_generate = /datum/wound/muscle/robotic/severe
	threshold_minimum = 80

