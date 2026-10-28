// Migrated TG Bounties

/datum/bounty/item/assistant/strange_object
	name = "奇怪物体"
	description = "纳米传讯对奇怪的物体产生了兴趣。在维护区找一个，然后立刻送往中央指挥部。"
	reward = CARGO_CRATE_VALUE * 2.4
	wanted_types = list(/obj/item/relic = TRUE)

/datum/bounty/item/assistant/scooter
	name = "滑板车"
	description = "纳米传讯认定步行纯属浪费。往中央指挥部运一辆滑板车，让运作快起来。"
	reward = CARGO_CRATE_VALUE * 2.16 // the mat hoffman
	wanted_types = list(/obj/vehicle/ridden/scooter = TRUE)
	include_subtypes = FALSE

/datum/bounty/item/assistant/skateboard
	name = "滑板"
	description = "纳米传讯认定步行纯属浪费。往中央指挥部运一块滑板，让运作快起来。"
	reward = CARGO_CRATE_VALUE * 1.8 // the tony hawk
	wanted_types = list(
		/obj/vehicle/ridden/scooter/skateboard = TRUE,
		/obj/item/melee/skateboard = TRUE,
	)

/datum/bounty/item/assistant/stunprod
	name = "电击棒"
	description = "中央指挥部需要一根电击棒来对付异见分子。做一根，然后运过来。"
	reward = CARGO_CRATE_VALUE * 2.6
	wanted_types = list(/obj/item/melee/baton/security/cattleprod = TRUE)

/datum/bounty/item/assistant/spear
	name = "长矛"
	description = "中央指挥部的安保部队正在削减预算。只要运来一套长矛，你就能拿到报酬。"
	reward = CARGO_CRATE_VALUE * 4
	required_count = 5
	wanted_types = list(/obj/item/spear = TRUE)

/datum/bounty/item/assistant/toolbox
	name = "装满的工具箱"
	description = "中央指挥部正缺能干活的人手。给他们运一只装满的工具箱作为解决方案，内含螺丝刀、扳手、焊接工具、撬棍、分析仪和剪线钳。"
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(/obj/item/storage/toolbox = TRUE)
	/// List of tools that we want to see sorted into a toolbox
	var/static/list/static_packing_list = list(
		/obj/item/screwdriver,
		/obj/item/wrench,
		/obj/item/weldingtool,
		/obj/item/crowbar,
		/obj/item/analyzer,
		/obj/item/wirecutters,
	)

/datum/bounty/item/assistant/toolbox/applies_to(obj/shipped)
	var/list/packing_list = static_packing_list.Copy()
	for(var/obj/item_contents as anything in shipped.contents)
		for(var/match_type in packing_list)
			if(istype(item_contents, match_type))
				packing_list -= match_type
				break
		if(!length(packing_list))
			return ..()
	return FALSE

/datum/bounty/item/assistant/toolbox/ship(obj/shipped)
	. = ..()
	for(var/obj/object as anything in shipped.contents)
		if(!is_type_in_list(object, static_packing_list))
			object.forceMove(shipped.drop_location())

/datum/bounty/item/assistant/statue
	name = "雕像"
	description = "中央指挥部想为大厅定制一座有艺术感的雕像。方便时运一座过来。"
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(/obj/structure/statue = TRUE)

/datum/bounty/item/assistant/baseball_bat
	name = "棒球棍"
	description = "中央指挥部正掀起棒球热！行行好，给他们运些棒球棍，好让管理层实现儿时的梦想。"
	reward = CARGO_CRATE_VALUE * 4
	required_count = 5
	wanted_types = list(/obj/item/melee/baseball_bat = TRUE)

/datum/bounty/item/assistant/donut
	name = "甜甜圈"
	description = "中央指挥部的安保部队在与辛迪加的交锋中损失惨重。运些甜甜圈去提振士气。"
	reward = CARGO_CRATE_VALUE * 6
	required_count = 6
	wanted_types = list(/obj/item/food/donut = TRUE)

/datum/bounty/item/assistant/monkey_hide
	name = "猴子皮"
	description = "中央指挥部的一位科学家想用猴子皮测试产品。你的任务是弄到猴子皮并运过来。"
	reward = CARGO_CRATE_VALUE * 3
	wanted_types = list(/obj/item/stack/sheet/animalhide/carbon/monkey = TRUE)

/datum/bounty/item/assistant/comfy_chair
	name = "舒适座椅"
	description = "帕特指挥官对自己的椅子很不满意，声称它弄疼了自己的背。运几把替代品过去哄哄他。"
	reward = CARGO_CRATE_VALUE * 3
	required_count = 5
	wanted_types = list(/obj/structure/chair/comfy = TRUE)

/datum/bounty/item/assistant/monkey_cubes
	name = "猴子方块"
	description = "由于近期的一起基因事故，中央指挥部急需猴子。你的任务是运送猴子方块。"
	reward = CARGO_CRATE_VALUE * 4
	required_count = 3
	wanted_types = list(/obj/item/food/monkeycube = TRUE)

/datum/bounty/item/assistant/ied
	name = "简易爆炸装置"
	description = "纳米传讯位于中央指挥部的最高安全监狱正在进行人员训练。运几枚简易爆炸装置，用作训练工具。"
	reward = CARGO_CRATE_VALUE * 6 // Boosted from default since they've been made harder to make.
	required_count = 3
	wanted_types = list(/obj/item/grenade/iedcasing = TRUE)

/datum/bounty/item/assistant/toys
	name = "街机玩具"
	description = "副总裁的儿子在电视屏上看到了新玩具的广告，现在他整天念叨个没完。运些街机玩具过去，好让他少抱怨几句。"
	reward = CARGO_CRATE_VALUE * 8
	required_count = 5
	wanted_types = list(/obj/item/toy = TRUE)

/datum/bounty/item/assistant/paper_bin
	name = "纸盒"
	description = "我们会计部的纸全用完了。急需一批新货。"
	reward = CARGO_CRATE_VALUE * 5
	required_count = 5
	wanted_types = list(/obj/item/paper_bin = TRUE)

/datum/bounty/item/assistant/crayons
	name = "蜡笔"
	description = "琼斯博士的孩子又把我们的蜡笔全吃了。请把你的寄给我们。"
	reward = CARGO_CRATE_VALUE * 4
	required_count = 7 // Edited down to 7. There's only 7 in a pack.
	wanted_types = list(/obj/item/toy/crayon = TRUE)

/datum/bounty/item/assistant/water_tank
	name = "水箱"
	description = "我们的水培舱需要更多水。找一只水箱运给我们。"
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/structure/reagent_dispensers/watertank = TRUE)

/datum/bounty/item/assistant/pneumatic_cannon
	name = "气动加农炮"
	description = "我们正在研究用气动加农炮能把超物质碎片发射出多大的力道。尽快给我们送一台。"
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(/obj/item/pneumatic_cannon/ghetto = TRUE)

/datum/bounty/item/assistant/improvised_shells
	name = "垃圾弹壳"
	description = "我们的助手民兵把铁材料全吃光了。为了阻止他们拿空间站财物做子弹，我们急需垃圾弹壳。"
	reward = CARGO_CRATE_VALUE * 4
	required_count = 5
	wanted_types = list(/obj/item/ammo_casing/junk = TRUE)

/datum/bounty/item/assistant/flamethrower
	name = "火焰喷射器"
	description = "我们这里蛾灾泛滥，请送一台火焰喷射器来协助处理。"
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(/obj/item/flamethrower = TRUE)

/datum/bounty/item/assistant/fish
	name = "鱼"
	description = "我们需要鱼来充实水族箱。死亡或从货运购买的鱼只能按一半价格支付。"
	reward = CARGO_CRATE_VALUE * 9.5
	required_count = 4
	wanted_types = list(/obj/item/fish = TRUE, /obj/item/storage/fish_case = TRUE)
	///the penalty for shipping dead/bought fish, which can subtract up to half the reward in total.
	var/shipping_penalty

/datum/bounty/item/assistant/fish/New()
	..()
	shipping_penalty = reward * 0.5 / required_count

/datum/bounty/item/assistant/fish/applies_to(obj/shipped)
	. = ..()
	if(!.)
		return
	var/obj/item/fish/fishie = shipped
	if(istype(shipped, /obj/item/storage/fish_case))
		fishie = locate() in shipped
		if(!fishie || !is_type_in_typecache(fishie, wanted_types))
			return FALSE
	return can_ship_fish(fishie)

/datum/bounty/item/assistant/fish/proc/can_ship_fish(obj/item/fish/fishie)
	return TRUE

/datum/bounty/item/assistant/fish/ship(obj/shipped)
	. = ..()
	if(!.)
		return
	var/obj/item/fish/fishie = shipped
	if(istype(shipped, /obj/item/storage/fish_case))
		fishie = locate() in shipped
	if(fishie.status == FISH_DEAD || HAS_TRAIT(fishie, TRAIT_FISH_LOW_PRICE))
		reward -= shipping_penalty

///A subtype of the fish bounty that requires fish with a specific fluid type
/datum/bounty/item/assistant/fish/fluid
	reward = CARGO_CRATE_VALUE * 12
	///The required fluid type of the fish for it to be shipped
	var/fluid_type

/datum/bounty/item/assistant/fish/fluid/New()
	..()
	fluid_type = pick(AQUARIUM_FLUID_FRESHWATER, AQUARIUM_FLUID_SALTWATER, AQUARIUM_FLUID_SULPHWATEVER)
	name = "[chinese_aquarium_fluid_display(fluid_type)]鱼"
	description = "我们需要[chinese_aquarium_fluid_display(fluid_type)]鱼来充实水族箱。死亡或从货运购买的鱼只能按一半价格支付。"

/datum/bounty/item/assistant/fish/fluid/can_ship_fish(obj/item/fish/fishie)
	return (fluid_type in GLOB.fish_compatible_fluid_types[fishie.required_fluid_type])

// Bubber Bounties

/datum/bounty/item/assistant/towels
	name = "毛巾"
	description = "有放射性的蛾子把中央指挥部更衣室里的东西吃得一干二净。我们急需更多毛巾。"
	reward = CARGO_CRATE_VALUE * 6
	required_count = 6
	wanted_types = list(/obj/item/towel = TRUE)

/datum/bounty/item/assistant/clipboards
	name = "写字板"
	description = "这里有点乱套了，给中央指挥部送些写字板，让一切重回正轨。"
	reward = CARGO_CRATE_VALUE * 4
	required_count = 4
	wanted_types = list(/obj/item/clipboard = TRUE)

/datum/bounty/item/assistant/mousetraps
	name = "捕鼠夹"
	description = "中央指挥部里正酝酿一场啮齿动物叛乱。给我们送些捕鼠夹，帮忙挡住它们。"
	reward = CARGO_CRATE_VALUE * 3.75
	required_count = 4
	wanted_types = list(/obj/item/assembly/mousetrap = TRUE)

/datum/bounty/item/assistant/dancefloor
	name = "灯线地板砖"
	description = "中央指挥部的休闲区实在缺乏气氛。帮我们接好一片舞池地板，好让气氛热闹起来。务必保证它们是完整的！"
	reward = CARGO_CRATE_VALUE * 9
	required_count = 9
	wanted_types = list(/obj/item/stack/tile/light = TRUE)

/datum/bounty/item/assistant/toysword
	name = "玩具剑"
	description = "经历了上次那场……事故之后，中央指挥部安保部队想找更安全的训练方式。给他们送些玩具剑玩玩。"
	reward = CARGO_CRATE_VALUE * 8
	required_count = 3
	wanted_types = list(/obj/item/toy/sword = TRUE)

/datum/bounty/item/assistant/bolas
	name = "流星锤"
	description = "一只被人类化的猴子逃出了收容，还给自己裹满了食用油。请送些流星锤来，好让中央指挥部抓住它。"
	reward = CARGO_CRATE_VALUE * 5
	required_count = 5
	wanted_types = list(/obj/item/restraints/legcuffs/bola = TRUE)

/datum/bounty/item/assistant/coffin
	name = "棺材"
	description = "一只深受喜爱的空间站宠物被发现死掉了。请立刻运一口棺材过来，好让哀悼流程尽快走完。"
	reward = CARGO_CRATE_VALUE * 3 //Coffins themselves export for 100 credits, but this is a bounty. Plus, you'd only get 50% when wrapping them with barcodes.
	wanted_types = list(/obj/structure/closet/crate/coffin = TRUE)

/datum/bounty/item/assistant/cargo_shelf
	name = "货运货架"
	description = "中央指挥部的包装设施有点挤了，给我们送些货运货架套件，好腾出空间。"
	reward = CARGO_CRATE_VALUE * 3
	required_count = 4
	wanted_types = list(/obj/item/rack_parts/cargo_shelf = TRUE)

/datum/bounty/item/assistant/duffelbag
	name = "行李袋"
	description = "中央指挥部的助手旅要跑长途，需要行李袋。立刻运一些过来。"
	reward = CARGO_CRATE_VALUE * 5
	required_count = 6
	wanted_types = list(/obj/item/storage/backpack/duffelbag = TRUE)

/datum/bounty/item/assistant/watermelon
	name = "西瓜"
	description = "办公室新流行起了瓜水。给中央指挥部送些西瓜，好让我们榨上几壶。"
	reward = CARGO_CRATE_VALUE * 6
	required_count = 6
	wanted_types = list(/obj/item/food/grown/melonlike/watermelon = TRUE)

/datum/bounty/item/assistant/dogbed
	name = "狗床"
	description = "经历了一连串不幸事件后，中央指挥部发现自己需要一张狗床。请立即送一张过来。"
	reward = CARGO_CRATE_VALUE * 3
	wanted_types = list(/obj/structure/bed/dogbed = TRUE)

/datum/bounty/item/assistant/blueprints
	name = "简陋蓝图"
	description = "中央指挥部正在民用领域寻找有创造力的人。把你的简陋蓝图运给我们。"
	reward = CARGO_CRATE_VALUE * 5.75
	wanted_types = list(/obj/item/shuttle_blueprints/crude = TRUE)

/datum/bounty/item/assistant/wheelchair
	name = "电动轮椅"
	description = "指挥部的一些年长成员行动有些不便。给我们送一台电动轮椅，好让他们行动更方便。"
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(/obj/vehicle/ridden/wheelchair/motorized = TRUE)

/datum/bounty/item/assistant/trapdoor
	name = "活板门套件"
	description = "关于为什么需要这个，我们还是不细说了。给中央指挥部运一套活板门套件，你就会得到报酬。"
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(/obj/item/trapdoor_kit = TRUE)
