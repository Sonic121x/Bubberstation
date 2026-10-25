/datum/bounty/item/mining/goliath_steaks
	name = "熔岩烤歌利亚牛排"
	description = "自从食堂开始只供应猴子和猴子副产品以来，帕夫洛夫海军上将就一直在绝食抗议。她要求得到熔岩烤歌利亚牛排。"
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(/obj/item/food/meat/steak/goliath = TRUE)

/datum/bounty/item/mining/goliath_boat
	name = "歌利亚皮艇"
	description = "门科夫指挥官想参加一年一度的熔岩地帆船赛。他请你们的船匠建造一艘人类已知最快的船。"
	reward = CARGO_CRATE_VALUE * 20
	wanted_types = list(/obj/vehicle/ridden/lavaboat = TRUE)

/datum/bounty/item/mining/bone_oar
	name = "骨制船桨"
	description = "门科夫指挥官需要船桨来参加一年一度的熔岩地帆船赛。运一对过去。"
	reward = CARGO_CRATE_VALUE * 8
	required_count = 2
	wanted_types = list(/obj/item/oar = TRUE)

//SKYRAT EDIT REMOVAL
/*
/datum/bounty/item/mining/bone_axe
	name = "Bone Axe"
	description = "Station 12 has had their fire axes stolen by marauding clowns. Ship them a bone axe as a replacement."
	reward = CARGO_CRATE_VALUE * 15
	wanted_types = list(/obj/item/fireaxe/boneaxe = TRUE)
*/
//END SKYRAT EDIT REMOVAL

/datum/bounty/item/mining/bone_armor
	name = "骨制护甲"
	description = "14 号空间站自愿让他们的蜥蜴人船员参与防弹护甲测试。运送一些骨制护甲过去。"
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(/obj/item/clothing/suit/armor/bone = TRUE)

/datum/bounty/item/mining/skull_helmet
	name = "骷髅头盔"
	description = "42 号空间站的安保主管明天过生日！我们想用一顶时尚的骷髅头盔给她一个惊喜。"
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(/obj/item/clothing/head/helmet/skull = TRUE)

/datum/bounty/item/mining/bone_talisman
	name = "骨制护符"
	description = "14 号空间站的科研主管声称异教骨制护符能保护佩戴者。运送几个过去，好让他们开始测试。"
	reward = CARGO_CRATE_VALUE * 15
	required_count = 3
	wanted_types = list(/obj/item/clothing/accessory/talisman = TRUE)
/datum/bounty/item/mining/watcher_wreath
	name = "守望者花环"
	description = "14 号空间站的科研主管认为他们在某些异教信仰的文化符号上即将取得突破。运送几个守望者花环过去供分析。"
	include_subtypes = FALSE
	reward = CARGO_CRATE_VALUE * 15
	required_count = 3
	wanted_types = list(/obj/item/clothing/neck/wreath = TRUE)

/datum/bounty/item/mining/icewing_wreath
	name = "冰翼花环"
	description = "我们从 14 号空间站的科研主管那里收到了一些……奇怪的消息。而且他们说的话大部分都不连贯。但显然他们想要一个冰翼花环。你能寄一个过去吗？"
	reward = CARGO_CRATE_VALUE * 30
	required_count = 1
	wanted_types = list(/obj/item/clothing/neck/wreath/icewing = TRUE)

//SKYRAT EDIT REMOVAL
/*
/datum/bounty/item/mining/bone_dagger
	name = "Bone Daggers"
	description = "Central Command's canteen is undergoing budget cuts. Ship over some bone daggers so our chef can keep working."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(/obj/item/knife/combat/bone = TRUE)
*/
//END SKYRAT EDIT REMOVAL

/datum/bounty/item/mining/polypore_mushroom
	name = "蘑菇碗"
	description = "杰布中尉打碎了他最喜欢的蘑菇碗。寄一个新的过去让他开心一下吧，好吗？"
	reward = CARGO_CRATE_VALUE * 15 //5x mushroom shavings
	wanted_types = list(/obj/item/reagent_containers/cup/bowl/mushroom_bowl = TRUE)

/datum/bounty/item/mining/inocybe_mushroom
	name = "蘑菇伞盖"
	description = "我们的植物学家声称他能从任何植物中蒸馏出美味的烈酒。让我们看看他会用伊诺西贝蘑菇伞盖做出什么。"
	reward = CARGO_CRATE_VALUE * 9
	required_count = 3
	wanted_types = list(/obj/item/food/grown/ash_flora/mushroom_cap = TRUE)

/datum/bounty/item/mining/porcini_mushroom
	name = "蘑菇叶"
	description = "据说牛肝菌蘑菇叶具有治疗功效。我们的研究人员想验证这一说法。"
	reward = CARGO_CRATE_VALUE * 9
	required_count = 3
	wanted_types = list(/obj/item/food/grown/ash_flora/mushroom_leaf = TRUE)
