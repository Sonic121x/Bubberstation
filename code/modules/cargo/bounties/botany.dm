/datum/bounty/item/botany
	reward = CARGO_CRATE_VALUE * 10
	var/multiplier = 0 //adds bonus reward money; increased for higher tier or rare mutations
	var/bonus_desc //for adding extra flavor text to bounty descriptions
	var/foodtype = "餐点" //same here

/datum/bounty/item/botany/New()
	..()
	description = "中央指挥部的主厨想用[name]制作一道精致的[foodtype]。[bonus_desc]"
	reward += multiplier * (CARGO_CRATE_VALUE * 2)
	required_count = rand(5, 10)

/datum/bounty/item/botany/ambrosia_vulgaris
	name = "普通仙草叶"
	wanted_types = list(/obj/item/food/grown/ambrosia/vulgaris = TRUE)
	foodtype = "炖菜"

/datum/bounty/item/botany/ambrosia_gaia
	name = "盖亚仙草叶"
	wanted_types = list(/obj/item/food/grown/ambrosia/gaia = TRUE)
	multiplier = 4
	foodtype = "炖菜"

/datum/bounty/item/botany/apple_golden
	name = "金苹果"
	wanted_types = list(/obj/item/food/grown/apple/gold = TRUE)
	multiplier = 4
	foodtype = "甜点"

/datum/bounty/item/botany/banana
	name = "香蕉"
	wanted_types = list(
		/obj/item/food/grown/banana = TRUE,
		/obj/item/food/grown/banana/bluespace = FALSE,
	)
	foodtype = "香蕉船"

/datum/bounty/item/botany/banana_bluespace
	name = "蓝空间香蕉"
	wanted_types = list(/obj/item/food/grown/banana/bluespace = TRUE)
	multiplier = 2
	foodtype = "香蕉船"

/datum/bounty/item/botany/beans_koi
	name = "锦鲤豆"
	wanted_types = list(/obj/item/food/grown/koibeans = TRUE)
	multiplier = 2

/datum/bounty/item/botany/berries_death
	name = "死亡浆果"
	wanted_types = list(/obj/item/food/grown/berries/death = TRUE)
	multiplier = 2
	bonus_desc = "他坚称“他知道自己在做什么”。"
	foodtype = "雪葩"

/datum/bounty/item/botany/berries_glow
	name = "发光浆果"
	wanted_types = list(/obj/item/food/grown/berries/glow = TRUE)
	multiplier = 2
	foodtype = "雪葩"

/datum/bounty/item/botany/cannabis
	name = "大麻叶"
	wanted_types = list(
		/obj/item/food/grown/cannabis = TRUE,
		/obj/item/food/grown/cannabis/white = FALSE,
		/obj/item/food/grown/cannabis/death = FALSE,
		/obj/item/food/grown/cannabis/ultimate = FALSE,
	)
	multiplier = 4 //hush money
	bonus_desc = "不要向安保部门提及这批货物。"
	foodtype = "一批“松饼”"

/datum/bounty/item/botany/cannabis_white
	name = "生命草叶"
	wanted_types = list(/obj/item/food/grown/cannabis/white = TRUE)
	multiplier = 6
	bonus_desc = "不要向安保部门提及这批货物。"
	foodtype = "“餐点”"

/datum/bounty/item/botany/cannabis_death
	name = "死亡草叶"
	wanted_types = list(/obj/item/food/grown/cannabis/death = TRUE)
	multiplier = 6
	bonus_desc = "不要向安保部门提及这批货物。"
	foodtype = "“餐点”"

/datum/bounty/item/botany/cannabis_ultimate
	name = "欧米伽草叶"
	wanted_types = list(/obj/item/food/grown/cannabis/ultimate = TRUE)
	multiplier = 6
	bonus_desc = "无论如何都不要向安保部门提及这批货物。"
	foodtype = "一批“布朗尼”"

/datum/bounty/item/botany/wheat
	name = "小麦粒"
	wanted_types = list(/obj/item/food/grown/wheat = TRUE)

/datum/bounty/item/botany/rice
	name = "稻米粒"
	wanted_types = list(/obj/item/food/grown/rice = TRUE)

/datum/bounty/item/botany/chili
	name = "辣椒"
	wanted_types = list(/obj/item/food/grown/chili = TRUE)

/datum/bounty/item/botany/ice_chili
	name = "冰辣椒"
	wanted_types = list(/obj/item/food/grown/icepepper = TRUE)
	multiplier = 2

/datum/bounty/item/botany/ghost_chili
	name = "幽灵辣椒"
	wanted_types = list(/obj/item/food/grown/ghost_chili = TRUE)
	multiplier = 2

/datum/bounty/item/botany/citrus_lime
	name = "青柠"
	wanted_types = list(/obj/item/food/grown/citrus/lime = TRUE)
	foodtype = "雪葩"

/datum/bounty/item/botany/citrus_lemon
	name = "柠檬"
	wanted_types = list(/obj/item/food/grown/citrus/lemon = TRUE)
	foodtype = "雪葩"

/datum/bounty/item/botany/citrus_oranges
	name = "橙子"
	wanted_types = list(/obj/item/food/grown/citrus/orange = TRUE)
	bonus_desc = "不要送柠檬或青柠。" //I vanted orahnge!
	foodtype = "雪葩"

/datum/bounty/item/botany/eggplant
	name = "茄子"
	wanted_types = list(/obj/item/food/grown/eggplant = TRUE)
	bonus_desc = "不要与“蛋茄”混淆。"

/datum/bounty/item/botany/eggplant_eggy
	name = "蛋茄"
	wanted_types = list(/obj/item/food/grown/eggy = TRUE)
	bonus_desc = "不要与茄子混淆。"
	multiplier = 2

/datum/bounty/item/botany/kudzu
	name = "葛藤荚"
	wanted_types = list(/obj/item/food/grown/kudzupod = TRUE)
	bonus_desc = "请存放于干燥阴暗处。"
	multiplier = 4

/datum/bounty/item/botany/watermelon
	name = "西瓜"
	wanted_types = list(/obj/item/food/grown/melonlike/watermelon = TRUE)
	foodtype = "甜点"

/datum/bounty/item/botany/watermelon_holy
	name = "圣瓜"
	wanted_types = list(/obj/item/food/grown/melonlike/holymelon = TRUE)
	multiplier = 2
	foodtype = "甜点"

/datum/bounty/item/botany/glowshroom
	name = "荧光菇"
	wanted_types = list(
		/obj/item/food/grown/mushroom/glowshroom = TRUE,
		/obj/item/food/grown/mushroom/glowshroom/glowcap = FALSE,
		/obj/item/food/grown/mushroom/glowshroom/shadowshroom = FALSE,
	)
	foodtype = "煎蛋卷"

/datum/bounty/item/botany/glowshroom_cap
	name = "辉光菇"
	wanted_types = list(/obj/item/food/grown/mushroom/glowshroom/glowcap = TRUE)
	multiplier = 2
	foodtype = "煎蛋卷"

/datum/bounty/item/botany/glowshroom_shadow
	name = "暗影菇"
	wanted_types = list(/obj/item/food/grown/mushroom/glowshroom/shadowshroom = TRUE)
	multiplier = 2
	foodtype = "煎蛋卷"

/datum/bounty/item/botany/nettles_death
	name = "死亡荨麻"
	wanted_types = list(/obj/item/food/grown/nettle/death = TRUE)
	multiplier = 2
	bonus_desc = "处理时请做好防护。"
	foodtype = "奶酪"

/datum/bounty/item/botany/pineapples
	name = "菠萝"
	wanted_types = list(/obj/item/food/grown/pineapple = TRUE)
	bonus_desc = "不可供人食用。"
	foodtype = "烟灰缸"

/datum/bounty/item/botany/tomato
	name = "番茄"
	wanted_types = list(
		/obj/item/food/grown/tomato = TRUE,
		/obj/item/food/grown/tomato/blue = FALSE,
	)

/datum/bounty/item/botany/tomato_bluespace
	name = "蓝空间番茄"
	wanted_types = list(/obj/item/food/grown/tomato/blue/bluespace = TRUE)
	multiplier = 4

/datum/bounty/item/botany/oatz
	name = "燕麦"
	wanted_types = list(/obj/item/food/grown/oat = TRUE)
	multiplier = 2
	foodtype = "一批燕麦粥"
	bonus_desc = "深蹲配燕麦。我们的燕麦断货了。"

/datum/bounty/item/botany/bonfire
	name = "点燃的篝火"
	description = "我们的太空取暖器出了故障，中央指挥部的货运人员开始觉得冷了。种些木头，送一摊点燃的篝火过去给他们取暖。"
	wanted_types = list(/obj/structure/bonfire = TRUE)

/datum/bounty/item/botany/bonfire/applies_to(obj/O)
	if(!..())
		return FALSE
	var/obj/structure/bonfire/B = O
	return !!B.burning

/datum/bounty/item/botany/cucumber
	name = "黄瓜"
	wanted_types = list(/obj/item/food/grown/cucumber = TRUE)
