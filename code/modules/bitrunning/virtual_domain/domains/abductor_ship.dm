/datum/lazy_template/virtual_domain/abductor_ship
	name = "绑架者飞船"
	cost = BITRUNNER_COST_MEDIUM
	desc = "登上绑架者飞船，拿走他们的宝贝。"
	difficulty = BITRUNNER_DIFFICULTY_MEDIUM
	completion_loot = list(/obj/item/toy/plush/abductor/agent = 1)
	help_text = "一艘绑架者母舰在不知不觉中进入了敌对环境。 \
	他们目前正准备带着装备和战利品撤离该区域，其中包括 \
	那只板条箱。 	小心，他们以先进的武器著称。"
	is_modular = TRUE
	key = "abductor_ship"
	map_name = "abductor_ship"
	mob_modules = list(/datum/modular_mob_segment/abductor_agents)
	reward_points = BITRUNNER_REWARD_MEDIUM
	forced_outfit = /datum/outfit/bitductor
