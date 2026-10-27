/datum/bounty/item/chef/birthday_cake
	name = "生日蛋糕"
	description = "纳米传讯的生日快到了！给中央指挥部送一个生日蛋糕来庆祝吧！"
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(
		/obj/item/food/cake/birthday = TRUE,
		/obj/item/food/cakeslice/birthday = TRUE
	)

/datum/bounty/reagent/chef/soup
	name = "汤"
	description = "为了平息流浪者的起义，纳米传讯将为所有低薪工人提供汤。"

/datum/bounty/reagent/chef/soup/New()
	. = ..()
	required_volume = pick(10, 15, 20, 25)
	wanted_reagent = pick(subtypesof(/datum/reagent/consumable/nutriment/soup))
	reward = CARGO_CRATE_VALUE * round(required_volume / 3)
	// In the future there could be tiers of soup bounty corresponding to soup difficulty
	// (IE, stew is harder to make than tomato soup, so it should reward more)
	description += " 请给我们送来 [required_volume] 单位的[initial(wanted_reagent.name)]。"

/datum/bounty/item/chef/popcorn
	name = "爆米花袋"
	description = "高层想办一场电影之夜。请为这个场合送几袋爆米花。"
	reward = CARGO_CRATE_VALUE * 6
	required_count = 3
	wanted_types = list(/obj/item/food/popcorn = TRUE)

/datum/bounty/item/chef/onionrings
	name = "洋葱圈"
	description = "纳米传讯正在纪念土星日。请送来洋葱圈，表达空间站的支持。"
	reward = CARGO_CRATE_VALUE * 6
	required_count = 3
	wanted_types = list(/obj/item/food/onionrings = TRUE)

/datum/bounty/item/chef/icecreamsandwich
	name = "冰淇淋三明治"
	description = "高层一直不停地嚷嚷着要冰淇淋三明治。请送一些过来。"
	reward = CARGO_CRATE_VALUE * 8
	required_count = 3
	wanted_types = list(/obj/item/food/icecreamsandwich = TRUE)

/datum/bounty/item/chef/strawberryicecreamsandwich
	name = "草莓冰淇淋三明治"
	description = "高层一直不停地嚷嚷着要更有风味的冰淇淋三明治。请送一些过来。"
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(/obj/item/food/strawberryicecreamsandwich = TRUE)

/datum/bounty/item/chef/bread
	name = "面包"
	description = "中央规划出了问题，面包价格飞涨。请送来一些面包以缓解紧张局势。"
	reward = CARGO_CRATE_VALUE * 2
	wanted_types = list(
		/obj/item/food/bread = TRUE,
		/obj/item/food/breadslice = TRUE,
		/obj/item/food/bun = TRUE,
		/obj/item/food/pizzabread = TRUE,
		/obj/item/food/rawpastrybase = TRUE,
	)

/datum/bounty/item/chef/pie
	name = "派"
	description = "3.14159？不！中央指挥部管理层要的是能吃的派！请送一整块。"
	reward = 3142 //Screw it I'll do this one by hand
	wanted_types = list(/obj/item/food/pie = TRUE)

/datum/bounty/item/chef/salad
	name = "沙拉或米饭碗"
	description = "中央指挥部管理层正在大力养生。你的订单是送来沙拉或米饭碗。"
	reward = CARGO_CRATE_VALUE * 6
	required_count = 3
	wanted_types = list(/obj/item/food/salad = TRUE)

/datum/bounty/item/chef/carrotfries
	name = "胡萝卜条"
	description = "夜视力关乎生死！订单是一批胡萝卜条。"
	reward = CARGO_CRATE_VALUE * 7
	required_count = 3
	wanted_types = list(/obj/item/food/carrotfries = TRUE)

/datum/bounty/item/chef/superbite
	name = "超级大咬汉堡"
	description = "塔布斯指挥官认为自己能创下竞食世界纪录。他只需要有人给他送一个超级大咬汉堡。"
	reward = CARGO_CRATE_VALUE * 24
	wanted_types = list(/obj/item/food/burger/superbite = TRUE)

/datum/bounty/item/chef/poppypretzel
	name = "罂粟椒盐卷饼"
	description = "中央指挥部需要一个解雇人事主管的理由。送一份罂粟椒盐卷饼过去，让他药检必定不合格。"
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/item/food/poppypretzel = TRUE)

/datum/bounty/item/chef/cubancarp
	name = "古巴鲤鱼"
	description = "为庆祝卡斯特罗二十七世诞生，请送一条古巴鲤鱼到中央指挥部。"
	reward = CARGO_CRATE_VALUE * 16
	wanted_types = list(/obj/item/food/cubancarp = TRUE)

/datum/bounty/item/chef/hotdog
	name = "热狗"
	description = "纳米传讯正在举办口味测试，以评选最佳热狗配方。请送来你们空间站的版本参赛。"
	reward = CARGO_CRATE_VALUE * 16
	wanted_types = list(/obj/item/food/hotdog = TRUE)

/datum/bounty/item/chef/eggplantparm
	name = "帕尔马茄子"
	description = "一位著名歌手即将抵达中央指挥部，其合同要求只为他供应帕尔马茄子。请送一些过来！"
	reward = CARGO_CRATE_VALUE * 7
	required_count = 3
	wanted_types = list(/obj/item/food/eggplantparm = TRUE)

/datum/bounty/item/chef/muffin
	name = "松饼"
	description = "松饼人来访中央指挥部，但他忘了带自己的松饼！你的订单就是弥补这一疏忽。"
	reward = CARGO_CRATE_VALUE * 6
	required_count = 3
	wanted_types = list(/obj/item/food/muffin = TRUE)

/datum/bounty/item/chef/chawanmushi
	name = "茶碗蒸"
	description = "纳米传讯希望改善与姊妹公司日本传讯的关系。请立即送来茶碗蒸。"
	reward = CARGO_CRATE_VALUE * 16
	wanted_types = list(/obj/item/food/chawanmushi = TRUE)

/datum/bounty/item/chef/kebab
	name = "烤肉串"
	description = "把烤肉串全部从空间站清走，你就是最佳食物。送往中央指挥部将其清出现场。"
	reward = CARGO_CRATE_VALUE * 7
	required_count = 3
	wanted_types = list(/obj/item/food/kebab = TRUE)

/datum/bounty/item/chef/soylentgreen
	name = "绿色营养饼"
	description = "中央指挥部听闻“绿色营养饼”这款产品好评如潮，很想尝一尝。若能满足他们，可期待一份愉快的奖金。"
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(/obj/item/food/soylentgreen = TRUE)

/datum/bounty/item/chef/pancakes
	name = "煎饼"
	description = "在纳米传讯，我们把员工视为家人。你知道家人最喜欢什么吗？煎饼。请送一打（十三个）。"
	reward = CARGO_CRATE_VALUE * 10
	required_count = 13
	wanted_types = list(/obj/item/food/pancakes = TRUE)

/datum/bounty/item/chef/nuggies
	name = "鸡块"
	description = "副总裁的儿子一直吵着要吃鸡块。你能送一些过来吗？"
	reward = CARGO_CRATE_VALUE * 8
	required_count = 6
	wanted_types = list(/obj/item/food/nugget = TRUE)

/datum/bounty/item/chef/corgifarming //Butchering is a chef's job.
	name = "柯基毛皮"
	description = "温斯坦海军上将的太空游艇需要换新内饰。一打柯基毛皮应该就够了。"
	reward = CARGO_CRATE_VALUE * 60 //that's a lot of dead dogs
	required_count = 12
	wanted_types = list(/obj/item/stack/sheet/animalhide/corgi = TRUE)

/datum/bounty/item/chef/pickles
	name = "腌黄瓜"
	description = "食品管制部门缺少足够的腌黄瓜，无法妥善品评几种不同的烈酒。"
	reward = CARGO_CRATE_VALUE * 10
	required_count = 7
	wanted_types = list(/obj/item/food/pickle = TRUE)
