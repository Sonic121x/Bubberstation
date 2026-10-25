/datum/lazy_template/virtual_domain/stairs_and_cliffs
	name = "冰川攀登"
	cost = BITRUNNER_COST_LOW
	desc = "一段险恶的攀登，没几个小腿肚能扛得住。不过心肺锻炼效果极佳。"
	help_text = "听说过“蛇与梯子”吗？这儿差不多，只不过 \
	梯子换成了楼梯，蛇换成了从悬崖上 \
	直坠而下，摔进嶙峋岩石或液态等离子中的陡降。"
	difficulty = BITRUNNER_DIFFICULTY_LOW
	completion_loot = list(/obj/item/clothing/suit/costume/snowman = 2)
	secondary_loot = list(/obj/item/clothing/shoes/wheelys/skishoes = 2, /obj/item/clothing/head/costume/ushanka/polar = 1)
	forced_outfit = /datum/outfit/job/virtual_domain_iceclimber
	key = "stairs_and_cliffs"
	map_name = "stairs_and_cliffs"
	reward_points = BITRUNNER_REWARD_MEDIUM
	domain_flags = DOMAIN_NO_NOHIT_BONUS

/turf/open/cliff/snowrock/virtual_domain
	name = "冰封悬崖"
	initial_gas_mix = FROZEN_ATMOS

/turf/open/lava/plasma/virtual_domain
	name = "等离子湖"
	initial_gas_mix = FROZEN_ATMOS

/datum/outfit/job/virtual_domain_iceclimber
	name = "攀冰者"

	uniform = /obj/item/clothing/under/color/grey
	backpack = /obj/item/storage/backpack/duffelbag
	shoes = /obj/item/clothing/shoes/winterboots
