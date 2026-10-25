// Hey! Listen! Update \config\iceruinblacklist.txt with your new ruins!

/datum/map_template/ruin/icemoon
	prefix = "_maps/RandomRuins/IceRuins/"
	allow_duplicates = FALSE
	cost = 5
	ruin_type = ZTRAIT_ICE_RUINS
	default_area = /area/icemoon/surface/outdoors/unexplored
	has_ceiling = TRUE
	ceiling_turf = /turf/closed/mineral/snowmountain/do_not_chasm
	ceiling_baseturfs = list(/turf/open/misc/asteroid/snow/icemoon/do_not_chasm)

// above ground only

/datum/map_template/ruin/icemoon/gas
	name = "Ice-Ruin Lizard Gas Station"
	id = "lizgasruin"
	description = "一座加油站。似乎刚开业不久，一切都崭新如初。"
	prefix = "_maps/RandomRuins/IceRuins/bubberstation/" //BUBBER ADDITION
	suffix = "icemoon_surface_gas_bubber.dmm" //BUBBER EDIT - ORIGINAL: icemoon_surface_gas.dmm

/datum/map_template/ruin/icemoon/lust
	name = "Ice-Ruin Ruin of Lust"
	id = "lust"
	description = "和你想的可不太一样。"
	suffix = "icemoon_surface_lust.dmm"
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/icemoon/asteroid
	name = "Ice-Ruin Asteroid Site"
	id = "asteroidsite"
	description = "没想到会在这里见到我们吧？"
	suffix = "icemoon_surface_asteroid.dmm"

/datum/map_template/ruin/icemoon/engioutpost
	name = "Ice-Ruin Engineer Outpost"
	id = "engioutpost"
	description = "被一场不幸的事故炸毁了。"
	suffix = "icemoon_surface_engioutpost.dmm"

/datum/map_template/ruin/icemoon/fountain
	name = "Ice-Ruin Fountain Hall"
	id = "ice_fountain"
	description = "喷泉侧面有一条警告。危险：可能存在未注明的副作用，使用后才会显现。"
	prefix = "_maps/RandomRuins/AnywhereRuins/"
	suffix = "fountain_hall.dmm"

/datum/map_template/ruin/icemoon/abandoned_homestead
	name = "Ice-Ruin Abandoned Homestead"
	id = "abandoned_homestead"
	description = "这座农庄曾住着幸福的拓荒家庭。如今住在这里的是饥饿的熊。"
	suffix = "icemoon_underground_abandoned_homestead.dmm"

/datum/map_template/ruin/icemoon/entemology
	name = "Ice-Ruin Insect Research Station"
	id = "bug_habitat"
	description = "一座独立资助的研究哨站，早已废弃。他们的使命是大胆前往昆虫绝不可能生存的地方，寻找虫子。"
	suffix = "icemoon_surface_bughabitat.dmm"

/datum/map_template/ruin/icemoon/pizza
	name = "Ice-Ruin Moffuchi's Pizzeria"
	id = "pizzeria"
	description = "蛾福奇家庭披萨连锁店以价格实惠、能否食用存疑的手工餐点闻名。这家披萨店似乎已经废弃了一段时间。"
	suffix = "icemoon_surface_pizza.dmm"

/datum/map_template/ruin/icemoon/Lodge
	name = "Ice-Ruin Hunters Lodge"
	id = "lodge"
	description = "一座古老的猎人小屋。不知道是否还有人在家？"
	suffix = "icemoon_surface_lodge.dmm"

/datum/map_template/ruin/icemoon/frozen_phonebooth
	name = "Ice-Ruin Frozen Phonebooth"
	id = "frozen_phonebooth"
	description = "纳米传讯为推广全息通讯台而推出的项目。这一座被送到了冰月。"
	suffix = "icemoon_surface_phonebooth.dmm"

/datum/map_template/ruin/icemoon/smoking_room
	name = "Ice-Ruin Smoking Room"
	id = "smoking_room"
	description = "查尔斯·莫尔巴罗长眠于此。他怎么活，就怎么死。"
	suffix = "icemoon_surface_smoking_room.dmm"

/datum/map_template/ruin/icemoon/roro
	name = "Ice-Ruin RoroCo Factory"
	id = "gloves"
	description = "一座生产并包装绝缘手套的工厂。"
	suffix = "icemoon_surface_gloves.dmm"

/datum/map_template/ruin/icemoon/shoe_facotry
	name = "Ice-Ruin Shoe Factory"
	id = "shoe_factory"
	description = "一座废弃的制鞋厂。"
	prefix = "_maps/RandomRuins/AnywhereRuins/"
	suffix = "shoe_factory.dmm"
	allow_duplicates = FALSE
	cost = 10

// above and below ground together

/datum/map_template/ruin/icemoon/entemology
	name = "Ice-Ruin Insect Research Station"
	id = "bug_habitat"
	description = "一座独立资助的研究哨站，早已废弃。他们的使命是大胆前往昆虫绝不可能生存的地方，寻找虫子。"
	suffix = "icemoon_surface_bughabitat.dmm"

/datum/map_template/ruin/icemoon/pizza
	name = "Ice-Ruin Moffuchi's Pizzeria"
	id = "pizzeria"
	description = "蛾福奇家庭披萨连锁店以价格实惠、能否食用存疑的手工餐点闻名。这家披萨店似乎已经废弃了一段时间。"
	suffix = "icemoon_surface_pizza.dmm"

/datum/map_template/ruin/icemoon/frozen_phonebooth
	name = "Ice-Ruin Frozen Phonebooth"
	id = "frozen_phonebooth"
	description = "纳米传讯为推广全息通讯台而推出的项目。这一座被送到了冰月。"
	suffix = "icemoon_surface_phonebooth.dmm"

/datum/map_template/ruin/icemoon/smoking_room
	name = "Ice-Ruin Smoking Room"
	id = "smoking_room"
	description = "查尔斯·莫尔巴罗长眠于此。他怎么活，就怎么死。"
	suffix = "icemoon_surface_smoking_room.dmm"

// above and below ground together

/datum/map_template/ruin/icemoon/mining_site
	name = "Ice-Ruin Mining Site"
	id = "miningsite"
	description = "一处矿场遗址，人们曾在这里用原始工具开采矿石。"
	suffix = "icemoon_surface_mining_site.dmm"
	always_place = TRUE
	always_spawn_with = list(/datum/map_template/ruin/icemoon/underground/mining_site_below = PLACE_BELOW)
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/icemoon/underground/mining_site_below
	name = "Ice-Ruin Mining Site Underground"
	id = "miningsite-underground"
	description = "谁能想到梯子这么有用呢？"
	suffix = "icemoon_underground_mining_site.dmm"
	has_ceiling = FALSE
	unpickable = TRUE
	enclosed_for_terrain = TRUE

// below ground only

/datum/map_template/ruin/icemoon/underground
	name = "Ice-Ruin underground ruin"
	ruin_type = ZTRAIT_ICE_RUINS_UNDERGROUND
	default_area = /area/icemoon/underground/unexplored

/datum/map_template/ruin/icemoon/underground/abandonedvillage
	name = "Ice-Ruin Abandoned Village"
	id = "abandonedvillage"
	description = "谁知道里面藏着什么？"
	suffix = "icemoon_underground_abandoned_village.dmm"
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/icemoon/underground/library
	name = "Ice-Ruin Buried Library"
	id = "buriedlibrary"
	description = "一座曾经宏伟的图书馆，如今埋没于冰月深处。"
	suffix = "icemoon_underground_library.dmm"
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/icemoon/underground/wrath
	name = "Ice-Ruin Ruin of Wrath"
	id = "wrath"
	description = "你将战斗、战斗，永不停歇地战斗。"
	suffix = "icemoon_underground_wrath.dmm"
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/icemoon/underground/hermit
	name = "Ice-Ruin Frozen Shack"
	id = "hermitshack"
	description = "一位孤独隐士的避难所，他在这里艰难度日。"
	suffix = "icemoon_underground_hermit.dmm"

/datum/map_template/ruin/icemoon/underground/lavaland
	name = "Ice-Ruin Lavaland Incursion"
	id = "lavalandsite"
	description = "看来我们从未真正离开过你，对吧？"
	suffix = "icemoon_underground_lavaland.dmm"
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/icemoon/underground/puzzle
	name = "Ice-Ruin Ancient Puzzle"
	id = "puzzle"
	description = "一个有待解开的谜。"
	suffix = "icemoon_underground_puzzle.dmm"

/datum/map_template/ruin/icemoon/underground/bathhouse
	name = "Ice-Ruin Bath House"
	id = "bathhouse"
	description = "一处温暖而安全的地方。"
	suffix = "icemoon_underground_bathhouse.dmm"

/datum/map_template/ruin/icemoon/underground/wendigo_cave
	name = "Ice-Ruin Wendigo Cave"
	id = "wendigocave"
	description = "深入野兽的血盆大口。"
	suffix = "icemoon_underground_wendigo_cave.dmm"

/datum/map_template/ruin/icemoon/underground/free_golem
	name = "Ice-Ruin Free Golem Ship"
	id = "golem-ship"
	description = "这艘船里活动着由贵重金属构成、步履笨重的人形生物。它们经常外出采矿，再用某种方法把矿物变成更多同类。\
	它们似乎很重视研究和个人自由，还有按地质学取名字？"
	prefix = "_maps/RandomRuins/AnywhereRuins/"
	suffix = "golem_ship.dmm"

/datum/map_template/ruin/icemoon/underground/mailroom
	name = "Ice-Ruin Frozen-over Post Office"
	id = "mailroom"
	description = "你所有的工资支票都到这里来了。署名：管理层。"
	suffix = "icemoon_underground_mailroom.dmm"
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/icemoon/underground/biodome
	name = "Ice-Ruin Syndicate Bio-Dome"
	id = "biodome"
	description = "不受约束的实验酿成了灾难。"
	suffix = "icemoon_underground_syndidome.dmm"

/datum/map_template/ruin/icemoon/underground/frozen_comms
	name = "Ice-Ruin Frozen Communicatons Outpost"
	id = "frozen_comms"
	description = "三峰电台，让二十一世纪零零年代永驻。"
	suffix = "icemoon_underground_frozen_comms.dmm"

/datum/map_template/ruin/icemoon/underground/comms_agent
	name = "Ice-Ruin Listening Post"
	id = "icemoon_comms_agent"
	description = "检测到了无线电信号，源头正是这堆完全无辜的雪。"
	suffix = "icemoon_underground_comms_agent.dmm"
	//begin bubber edit
	unpickable = TRUE
	//end bubber edit

/datum/map_template/ruin/icemoon/underground/syndie_lab
	name = "Ice-Ruin Syndicate Lab"
	id = "syndie_lab"
	description = "供辛迪加特工使用的小型实验室和生活区。"
	suffix = "icemoon_underground_syndielab.dmm"
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/icemoon/underground/o31
	name = "Ice-Ruin Outpost 31"
	id = "o31"
	description = "死寂得令人起疑。里面可能有巨型生物，也可能没有。"
	suffix = "icemoon_underground_outpost31.dmm"

//TODO: Bottom-Level ONLY Spawns after Refactoring Related Code
/datum/map_template/ruin/icemoon/underground/plasma_facility
	name = "Ice-Ruin Abandoned Plasma Facility"
	id = "plasma_facility"
	description = "弗蕾亚多年的等离子矿开采活动滋生了不少传言。据说那些遭受虐待而死的采掘工人的鬼魂已经回来，\
	向他们的前雇主复仇。公司提醒所有员工：传言终究只是传言，不过是用来吓唬不听话的小孩去睡觉的故事。"
	suffix = "icemoon_underground_abandoned_plasma_facility.dmm"

/datum/map_template/ruin/icemoon/underground/hotsprings
	name = "Ice-Ruin Hot Springs"
	id = "hotsprings"
	description = "放松下来泡一泡，绝不会出事，我保证！"
	suffix = "icemoon_underground_hotsprings.dmm"
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/icemoon/underground/vent
	name = "Ice-Ruin Icemoon Ore Vent"
	id = "ore_vent_i"
	description = "一个喷出矿石的喷口。似乎是自然现象。" //Make this a subtype that only spawns medium and large vents. Some smalls will go to the top level.
	suffix = "icemoon_underground_ore_vent.dmm"
	allow_duplicates = TRUE
	cost = 0
	mineral_cost = 1
	always_place = TRUE

/datum/map_template/ruin/icemoon/ruin/vent
	name = "Ice-Ruin Surface Icemoon Ore Vent"
	id = "ore_vent_i"
	description = "一个喷出矿石的喷口。似乎是自然现象。比地下的喷口更小。"
	suffix = "icemoon_surface_ore_vent.dmm"
	allow_duplicates = TRUE
	cost = 0
	mineral_cost = 1
	always_place = TRUE
