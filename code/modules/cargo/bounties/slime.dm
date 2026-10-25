/datum/bounty/item/slime
	reward = CARGO_CRATE_VALUE * 6

/datum/bounty/item/slime/New()
	..()
	description = "纳米传讯的科研主管正在搜寻稀有而奇特的 [name]。找到它即可获得赏金。"
	reward += rand(0, 4) * 500

/datum/bounty/item/slime/green
	name = "绿色史莱姆提取物"
	wanted_types = list(/obj/item/slime_extract/green = TRUE)

/datum/bounty/item/slime/pink
	name = "粉色史莱姆提取物"
	wanted_types = list(/obj/item/slime_extract/pink = TRUE)

/datum/bounty/item/slime/gold
	name = "金色史莱姆提取物"
	wanted_types = list(/obj/item/slime_extract/gold = TRUE)

/datum/bounty/item/slime/oil
	name = "油质史莱姆提取物"
	wanted_types = list(/obj/item/slime_extract/oil = TRUE)

/datum/bounty/item/slime/black
	name = "黑色史莱姆提取物"
	wanted_types = list(/obj/item/slime_extract/black = TRUE)

/datum/bounty/item/slime/lightpink
	name = "浅粉色史莱姆提取物"
	wanted_types = list(/obj/item/slime_extract/lightpink = TRUE)

/datum/bounty/item/slime/adamantine
	name = "精金史莱姆提取物"
	wanted_types = list(/obj/item/slime_extract/adamantine = TRUE)

/datum/bounty/item/slime/rainbow
	name = "彩虹史莱姆提取物"
	wanted_types = list(/obj/item/slime_extract/rainbow = TRUE)
