/datum/lazy_template/virtual_domain/xeno_nest
	name = "异形侵扰"
	cost = BITRUNNER_COST_LOW
	desc = "我们的舰载扫描器探测到来源不明的生命体。我们尝试友好接触，但均以失败告终。"
	difficulty = BITRUNNER_DIFFICULTY_LOW
	completion_loot = list(/obj/item/toy/plush/rouny = 1)
	help_text = "你身处一颗遍布敌对生物的荒芜星球。这里有一个板条箱，它并未被藏起，只是受到了保护。\
	做好遭遇抵抗的准备。"
	is_modular = TRUE
	key = "xeno_nest"
	map_name = "xeno_nest"
	mob_modules = list(/datum/modular_mob_segment/xenos)
	reward_points = BITRUNNER_REWARD_LOW
