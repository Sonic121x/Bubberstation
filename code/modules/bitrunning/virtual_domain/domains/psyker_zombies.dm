/datum/lazy_template/virtual_domain/psyker_zombies
	name = "感染域"
	cost = BITRUNNER_COST_MEDIUM
	desc = "虚拟世界中又一个无人问津的角落。这一处因僵尸病毒而不得不被废弃。 \
		警告——虚拟域不支持视觉显示。本任务必须依靠回声定位完成。"
	difficulty = BITRUNNER_DIFFICULTY_MEDIUM
	completion_loot = list(/obj/item/radio/headset/psyker = 1) //Looks cool, might make your local burdened chaplain happy.
	forced_outfit = /datum/outfit/echolocator
	help_text = "这片曾经深受喜爱的虚拟域已被病毒侵蚀，变得不稳定、千疮百孔，而且到处都是僵尸！ \
		附近应该有一个神秘盒子，能帮你武装起来。拿起武器，完成网络警察未竟的事业！"
	key = "psyker_zombies"
	map_name = "psyker_zombies"
	reward_points = BITRUNNER_REWARD_HIGH
