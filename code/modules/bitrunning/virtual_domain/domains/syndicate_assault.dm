/datum/lazy_template/virtual_domain/syndicate_assault
	name = "辛迪加突袭"
	announce_to_ghosts = TRUE
	cost = BITRUNNER_COST_MEDIUM
	desc = "登上敌方飞船，夺回被盗的货物。"
	difficulty = BITRUNNER_DIFFICULTY_MEDIUM
	completion_loot = list(/obj/item/toy/plush/nukeplushie = 1)
	help_text = "一群辛迪加特工从空间站偷走了贵重货物。 \
	他们已登上自己的飞船，正试图逃走。潜入他们的飞船，夺回 \
	那个板条箱。 	小心，他们全副武装。"
	is_modular = TRUE
	key = "syndicate_assault"
	map_name = "syndicate_assault"
	mob_modules = list(/datum/modular_mob_segment/syndicate_team)
	reward_points = BITRUNNER_REWARD_MEDIUM
