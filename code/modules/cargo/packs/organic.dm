/datum/supply_pack/organic
	group = "Food & Hydroponics"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/hydroponics
	access_view = ACCESS_HYDROPONICS
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/hydroponics/beekeeping_suits
	name = "养蜂人套装板条箱"
	desc = "养蜂生意火爆？那最好慷慨一点，给植物学送上一份助力，\
		送出两套养蜂人套装！内含两套养蜂人套装及配套头具。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/clothing/head/utility/beekeeper_head = 2,
					/obj/item/clothing/suit/utility/beekeeper_suit = 2,
				)
	crate_name = "养蜂人套装"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/hydroponics/beekeeping_fullkit
	name = "养蜂入门板条箱"
	desc = "蜜蜂蜜蜂蜜蜂。内含三个蜂蜜框、一套养蜂人套装与头盔、\
		一把苍蝇拍、一个蜂屋，当然还有一只纯种的纳米传讯标准蜂后！"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/structure/beebox/unwrenched,
					/obj/item/honey_frame = 3,
					/obj/item/queen_bee/bought,
					/obj/item/clothing/head/utility/beekeeper_head,
					/obj/item/clothing/suit/utility/beekeeper_suit,
					/obj/item/melee/flyswatter,
				)
	crate_name = "养蜂入门板条箱"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/randomized
	test_ignored = TRUE
	crate_name = "食品板条箱"

/datum/supply_pack/organic/randomized/fill(obj/container)
	for(var/i in 1 to 15)
		var/item = pick(contains)
		new item(container)

/datum/supply_pack/organic/randomized/chef
	name = "上等肉类板条箱"
	desc = "全银河最好的肉块。内含随机搭配的异域肉类。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/food/meat/slab/human/mutant/slime,
		/obj/item/food/meat/slab/killertomato,
		/obj/item/food/meat/slab/bear,
		/obj/item/food/meat/slab/xeno,
		/obj/item/food/meat/slab/spider,
		/obj/item/food/meat/rawbacon,
		/obj/item/food/meat/slab/penguin,
		/obj/item/food/spiderleg,
		/obj/item/food/fishmeat/carp,
		/obj/item/food/meat/slab/human,
		/obj/item/food/meat/slab/grassfed,
	)

/datum/supply_pack/organic/randomized/fruits
	name = "水果板条箱"
	desc = "富含维生素。内含一个青柠、一个橙子、一个西瓜、一个苹果、浆果和一个柠檬。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/food/grown/citrus/lime,
		/obj/item/food/grown/citrus/orange,
		/obj/item/food/grown/melonlike/watermelon,
		/obj/item/food/grown/apple,
		/obj/item/food/grown/berries,
		/obj/item/food/grown/citrus/lemon,
	)

/datum/supply_pack/organic/randomized/vegetables
	name = "蔬菜板条箱"
	desc = "在培养槽中种出。内含一个辣椒、一个玉米、一个番茄、一个土豆、一个胡萝卜、一个鸡油菌、一个洋葱、一个南瓜和一根黄瓜。"
	cost = CARGO_CRATE_VALUE * 1.8
	contains = list(
		/obj/item/food/grown/chili,
		/obj/item/food/grown/corn,
		/obj/item/food/grown/tomato,
		/obj/item/food/grown/potato,
		/obj/item/food/grown/carrotlike/carrot,
		/obj/item/food/grown/mushroom/chanterelle,
		/obj/item/food/grown/onion,
		/obj/item/food/grown/pumpkin,
		/obj/item/food/grown/cucumber,
	)

/datum/supply_pack/organic/exoticseeds
	name = "异域种子板条箱"
	desc = "任何有创业精神的植物学家梦寐以求的东西。内含十二种不同种子，\
		其中包括一份复制荚种子和两份神秘种子！"
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_HYDROPONICS
	contains = list(
		/obj/item/seeds/amanita,
		/obj/item/seeds/bamboo,
		/obj/item/seeds/eggplant/eggy,
		/obj/item/seeds/liberty,
		/obj/item/seeds/nettle,
		/obj/item/seeds/plump,
		/obj/item/seeds/replicapod,
		/obj/item/seeds/reishi,
		/obj/item/seeds/rainbow_bunch,
		/obj/item/seeds/seedling,
		/obj/item/seeds/shrub,
		/obj/item/seeds/random = 2,
	)
	crate_name = "异域种子板条箱"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/food
	name = "食品板条箱"
	desc = "用这箱实用食材开始动手做菜吧！\
		内含一打鸡蛋、三根香蕉，以及面粉、大米、牛奶、\
		豆奶、盐、胡椒、酶、糖和猴子肉。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/reagent_containers/condiment/flour,
					/obj/item/reagent_containers/condiment/rice,
					/obj/item/reagent_containers/condiment/milk,
					/obj/item/reagent_containers/condiment/soymilk,
					/obj/item/reagent_containers/condiment/saltshaker,
					/obj/item/reagent_containers/condiment/peppermill,
					/obj/item/storage/fancy/egg_box,
					/obj/item/reagent_containers/condiment/enzyme,
					/obj/item/reagent_containers/condiment/sugar,
					/obj/item/food/meat/slab/monkey,
					/obj/item/food/grown/banana = 3,
				)
	crate_name = "食品板条箱"

/datum/supply_pack/organic/cream_piee
	name = "高产小丑级奶油派板条箱"
	desc = "由奥塞克先进战争研究部设计，\
		这些高产小丑级奶油派由表演与效率的协同驱动。\
		保证提供最大化效果。"
	cost = CARGO_CRATE_VALUE * 12
	contains = list(/obj/item/storage/backpack/duffelbag/clown/cream_pie)
	crate_name = "派对装备板条箱"
	order_flags = ORDER_CONTRABAND
	access = ACCESS_THEATRE
	access_view = ACCESS_THEATRE
	crate_type = /obj/structure/closet/crate/secure
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/datum/supply_pack/organic/hydroponics/supplies
	name = "水培板条箱"
	desc = "种植绝佳花园的物资！内含两瓶氨水、\
		两瓶植物杀手喷雾、一把斧头、耕耘器、植物分析仪，\
		以及一双皮手套和一条植物学家围裙。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/reagent_containers/spray/plantbgone = 2,
					/obj/item/reagent_containers/cup/bottle/ammonia = 2,
					/obj/item/hatchet,
					/obj/item/cultivator,
					/obj/item/plant_analyzer,
					/obj/item/clothing/gloves/botanic_leather,
					/obj/item/clothing/suit/apron,
				)
	crate_name = "水培板条箱"

/datum/supply_pack/organic/hydroponics/hydrotank
	name = "水培背包板条箱"
	desc = "用这个高容量背包板条箱掀起洪水吧。\
		内含 500 单位赋予生命的 H2O。"
	cost = CARGO_CRATE_VALUE * 2
	access = ACCESS_HYDROPONICS
	contains = list(/obj/item/watertank)
	crate_name = "水培背包板条箱"
	crate_type = /obj/structure/closet/crate/secure/hydroponics

/datum/supply_pack/organic/pizza
	name = "披萨板条箱"
	desc = "既然能在更短的时间内拿到五份随机披萨，何必还要去厨房？\
			全银河这一侧最优惠的价格！所有配送保证 99% 无异常。"
	cost = CARGO_CRATE_VALUE * 10 // Best prices this side of the galaxy.
	contains = list()
	crate_name = "披萨板条箱"

	///Whether we've provided an infinite pizza box already this shift or not.
	var/anomalous_box_provided = FALSE
	/// one percent chance for a pizza box to be the ininfite pizza box
	var/infinite_pizza_chance = 1
	/// chance that any one of the pizzas in the crate will have romerol added to it
	var/romerol_chance = 0.2
	///Whether we've provided a bomb pizza box already this shift or not.
	var/boombox_provided = FALSE
	/// three percent chance for a pizza box to be the pizza bomb box
	var/bomb_pizza_chance = 3
	/// 1 in 3 pizza bombs spawned will be a dud
	var/bomb_dud_chance = 33

	/// list of pizza that can randomly go inside of a crate, weighted by how disruptive it would be
	var/list/pizza_types = list(
		/obj/item/food/pizza/margherita = 10,
		/obj/item/food/pizza/meat = 10,
		/obj/item/food/pizza/mushroom = 10,
		/obj/item/food/pizza/vegetable = 10,
		/obj/item/food/pizza/donkpocket = 10,
		/obj/item/food/pizza/dank = 7,
		/obj/item/food/pizza/sassysage = 10,
		/obj/item/food/pizza/pineapple = 10,
		/obj/item/food/pizza/arnold = 3,
		/obj/item/food/pizza/energy = 5
	)

/datum/supply_pack/organic/pizza/fill(obj/structure/closet/crate/new_crate)
	. = ..()
	var/list/rng_pizza_list = pizza_types.Copy()
	var/add_romerol = prob(romerol_chance)
	for(var/i in 1 to 5)
		if(add_anomalous(new_crate))
			continue
		if(add_boombox(new_crate))
			continue
		var/obj/item/pizzabox/pizzabox = add_normal_pizza(new_crate, rng_pizza_list)
		if(add_romerol && pizzabox.pizza)
			pizzabox.pizza.reagents.add_reagent(/datum/reagent/romerol, pizzabox.pizza.slices_left)
			add_romerol = FALSE
			log_game("一份罗梅罗披萨（作为 [pizzabox.pizza]）在披萨板条箱配送中被生成。")
			message_admins("一份罗梅罗披萨（作为 [pizzabox.pizza]）在披萨板条箱配送中被生成。")

/// adds the chance for an infinite pizza box
/datum/supply_pack/organic/pizza/proc/add_anomalous(obj/structure/closet/crate/new_crate)
	if(anomalous_box_provided)
		return FALSE
	if(!prob(infinite_pizza_chance))
		return FALSE
	new /obj/item/pizzabox/infinite(new_crate)
	anomalous_box_provided = TRUE
	log_game("一个异常披萨盒在货运配送期间被放入披萨板条箱。")
	if(prob(50))
		addtimer(CALLBACK(src, PROC_REF(anomalous_pizza_report)), rand(30 SECONDS, 180 SECONDS))
		message_admins("一个异常披萨盒在货运配送期间被放入披萨板条箱。")
	else
		message_admins("一个异常披萨盒在披萨板条箱配送中被静默生成，未附任何指挥报告。")
	return TRUE

/// adds a chance of a pizza bomb replacing a pizza
/datum/supply_pack/organic/pizza/proc/add_boombox(obj/structure/closet/crate/new_crate)
	if(boombox_provided)
		return FALSE
	if(!prob(bomb_pizza_chance))
		return FALSE
	var/boombox_type = (prob(bomb_dud_chance)) ? /obj/item/pizzabox/bomb : /obj/item/pizzabox/bomb/armed
	new boombox_type(new_crate)
	boombox_provided = TRUE
	log_game("一个披萨盒炸弹由披萨板条箱配送生成。")
	message_admins("一个披萨盒炸弹已随披萨板条箱配送抵达。")
	return TRUE

/// adds a randomized pizza from the pizza list
/datum/supply_pack/organic/pizza/proc/add_normal_pizza(obj/structure/closet/crate/new_crate, list/rng_pizza_list)
	var/randomize_pizza = pick_weight(rng_pizza_list)
	rng_pizza_list -= randomize_pizza
	var/obj/item/pizzabox/new_pizza_box = new(new_crate)
	new_pizza_box.pizza = new randomize_pizza(new_pizza_box)
	new_pizza_box.pizza.slice()
	new_pizza_box.boxtag = new_pizza_box.pizza.boxtag
	new_pizza_box.boxtag_set = TRUE
	new_pizza_box.update_appearance(UPDATE_ICON | UPDATE_DESC)
	return new_pizza_box

/// tells crew that an infinite pizza box exists, half of the time, based on a roll in the anamolous box proc
/datum/supply_pack/organic/pizza/proc/anomalous_pizza_report()
	print_command_report("[station_name()]，我部异常材料处报告一件物品遗失，极有可能已在一次例行货运\
	配送中被送往贵站。请检查该批配送附带的所有板条箱与清单，若找到该物品请予归还。该物品外观类似标准的 <b>\[数据已清除\]</b>，应被视为 \
	<b>\[已涂黑\]</b>，并可在方便时归还。请注意，异常产出的物品会专门与开启异常的那个个体精确调谐；无论\
	其物种为何，该个体都会觉得该物品可食用，并且按其个人定义味道极佳——这些定义因人和物种而差异巨大。")

/datum/supply_pack/organic/potted_plants
	name = "盆栽板条箱"
	desc = "用这些可爱的植物给空间站增添生气！内含从纳米传讯盆栽研究部随机挑选的\
		五盆盆栽。\
		投掷后保修失效。"
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(/obj/item/kirbyplants/random = 5)
	crate_name = "盆栽板条箱"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/organic/seeds
	name = "种子板条箱"
	desc = "大事始于微末。内含十五种不同种子。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/seeds/chili,
					/obj/item/seeds/cotton,
					/obj/item/seeds/berry,
					/obj/item/seeds/corn,
					/obj/item/seeds/eggplant,
					/obj/item/seeds/tomato,
					/obj/item/seeds/soya,
					/obj/item/seeds/wheat,
					/obj/item/seeds/wheat/rice,
					/obj/item/seeds/carrot,
					/obj/item/seeds/sunflower,
					/obj/item/seeds/rose,
					/obj/item/seeds/chanter,
					/obj/item/seeds/potato,
					/obj/item/seeds/sugarcane,
					/obj/item/seeds/cucumber,
				)
	crate_name = "种子板条箱"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/grill
	name = "烧烤入门套件"
	desc = "嘿老爸，我饿了。嗨，饿了，我是全新的烧烤入门套件，\
		只要 5000 信用点，现在就来买！内含一台烤架和燃料。"
	cost = CARGO_CRATE_VALUE * 4
	crate_type = /obj/structure/closet/crate
	contains = list(
		/obj/item/stack/sheet/mineral/coal/five,
		/obj/item/kitchen/tongs,
		/obj/item/reagent_containers/cup/soda_cans/monkey_energy,
		/obj/machinery/grill/unwrenched,
	)
	crate_name = "烧烤入门套件板条箱"
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE

/datum/supply_pack/organic/grillfuel
	name = "烧烤燃料套件"
	desc = "内含丙烷和丙烷配件。\
		（注：不含任何真正的丙烷。）"
	cost = CARGO_CRATE_VALUE * 4
	crate_type = /obj/structure/closet/crate
	contains = list(/obj/item/stack/sheet/mineral/coal/ten,
					/obj/item/reagent_containers/cup/soda_cans/monkey_energy,
				)
	crate_name = "烧烤燃料套件板条箱"
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE

/datum/supply_pack/organic/tiziran_supply
	name = "提兹拉补给箱"
	desc = "来自蜥蜴帝国腹地的一箱包装好的补给品。\
		内含多种提兹拉食材与基础食品。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/storage/box/tiziran_goods,
					/obj/item/storage/box/tiziran_cans,
					/obj/item/storage/box/tiziran_meats,
				)
	crate_name = "\improper 提兹拉补给箱"
	crate_type = /obj/structure/closet/crate/cardboard/tiziran
	test_ignored = TRUE

/datum/supply_pack/organic/mothic_supply
	name = "蛾族补给箱"
	desc = "来自蛾族舰队的一箱剩余补给品。\
		内含多种蛾族食材与基础食品。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/storage/box/mothic_goods,
					/obj/item/storage/box/mothic_cans_sauces,
					/obj/item/storage/box/mothic_rations,
				)
	crate_name = "\improper 蛾族补给箱"
	crate_type = /obj/structure/closet/crate/cardboard/mothic

/datum/supply_pack/organic/syrup
	name = "咖啡糖浆盒"
	desc = "一盒各式糖浆，能让你美味的咖啡更加致糖尿病。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/reagent_containers/cup/bottle/syrup_bottle/caramel,
		/obj/item/reagent_containers/cup/bottle/syrup_bottle/liqueur,
		/obj/item/reagent_containers/cup/bottle/syrup_bottle/korta_nectar,
	)
	crate_name = "咖啡糖浆盒"
	crate_type = /obj/structure/closet/crate/cardboard

/datum/supply_pack/organic/syrup_contraband
	order_flags = ORDER_CONTRABAND
	name = "违禁糖浆盒"
	desc = "一盒装着的非法咖啡糖浆。持有这些物品将按银河刑法典受到处罚。"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(
		/obj/item/reagent_containers/cup/bottle/syrup_bottle/laughsyrup = 2,
	)
	crate_name = "非法糖浆盒"
	crate_type = /obj/structure/closet/crate/cardboard

/datum/supply_pack/organic/cooking_oil
	name = "食用油桶"
	desc = "这种高级食用油几乎能让任何东西变得可口。\
	从等离子切割器到辛迪加炸弹，只要能塞进炸锅，就是一份小食。\
	内含一桶食用油。"
	cost = CARGO_CRATE_VALUE * 4.75
	contains = list(/obj/structure/reagent_dispensers/cooking_oil)
	crate_name = "食用油板条箱"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/organic/beer_keg
	name = "啤酒桶"
	desc = "开始你的轮班……或者结束它的完美方式。\
	内含满满一桶纳米传讯酿造的劣质酒精饮料，\
	在辛苦了一天没死之后正适合放松一下。"
	cost = CARGO_CRATE_VALUE * 6.25
	contains = list(/obj/structure/reagent_dispensers/keg/beer)
	crate_name = "啤酒桶板条箱"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/organic/nutraslop
	name = "营养糊分餐盘"
	desc = "用纳米传讯以往所有烹饪……创新成果打造出的烹饪杰作。\
	只要咬一口就能让你回味起昨天监狱口粮的味道。\
	内含一个装满营养糊的分餐盘。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/structure/reagent_dispensers/servingdish/unanchored)
	crate_name = "营养糊分餐盘板条箱"


/datum/supply_pack/organic/hydroponics/soil_normal
	name = "NT-Ag 盆栽土板条箱"
	desc = "一箱袋装的普通商用土壤。"
	cost = CARGO_CRATE_VALUE * 2
	crate_name = "盆栽土板条箱"
	contains = list(
		/obj/item/soil_sack = 5,
	)

/datum/supply_pack/organic/hydroponics/soil_vermaculite
	name = "NT-Ag 蛭石板条箱"
	desc = "一箱袋装 NT-Ag 蛭石。你最爱的膨胀矿物！"
	cost = CARGO_CRATE_VALUE * 2
	crate_name = "蛭石板条箱"
	contains = list(
		/obj/item/soil_sack/vermaculite = 3,
	)

/datum/supply_pack/organic/hydroponics/soil_gel
	name = "NT-Ag 水凝胶珠板条箱"
	desc = "一箱袋装预水化的超吸水凝胶珠。大家都喜欢漂亮的珠子。"
	cost = CARGO_CRATE_VALUE * 2
	crate_name = "水凝胶珠板条箱"
	contains = list(
		/obj/item/soil_sack/gel = 3,
	)


/datum/supply_pack/organic/hydroponics/soil_coir
	name = "NT-Ag 科尔塔椰糠板条箱"
	desc = "一箱袋装科尔塔根椰糠。适合开办蘑菇农场！"
	cost = CARGO_CRATE_VALUE * 3
	crate_name = "科尔塔椰糠板条箱"
	contains = list(
		/obj/item/soil_sack/coir = 3,
	)

/datum/supply_pack/organic/hydroponics/soil_worm
	name = "NT-Ag 蚯蚓粪板条箱"
	desc = "一箱袋装蚯蚓堆肥。不含蚯蚓！或者……？"
	cost = CARGO_CRATE_VALUE * 4
	crate_name = "蚯蚓粪板条箱"
	contains = list(
		/obj/item/soil_sack/worm = 3,
	)
