/datum/lazy_template/virtual_domain/meta_central
	name = "元站中枢"
	cost = BITRUNNER_COST_LOW
	desc = "时不时会有工人向纳米传讯索要权利。这可无利可图。"
	difficulty = BITRUNNER_DIFFICULTY_LOW
	forced_outfit = /datum/outfit/job/security/mod
	help_text = "用获准的暴力回应工人的诉求。回收可能散落四处的贵重材料。记住你的训练内容：永远先假定有罪，他们可以在医疗区里招供……大概是这样吧。"
	is_modular = TRUE
	key = "meta_central"
	map_name = "meta_central"
	mob_modules = list(/datum/modular_mob_segment/revolutionary)
	reward_points = BITRUNNER_REWARD_LOW
	announce_to_ghosts = TRUE
