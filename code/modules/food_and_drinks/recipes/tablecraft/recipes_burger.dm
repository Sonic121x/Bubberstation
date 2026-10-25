
// see code/module/crafting/table.dm

////////////////////////////////////////////////BURGERS////////////////////////////////////////////////


/datum/crafting_recipe/food/humanburger
	name = "人肉汉堡"
	reqs = list(
		/obj/item/food/bun = 1,
		/obj/item/food/patty/human = 1
	)
	result = /obj/item/food/burger/human
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/burger
	name = "原味汉堡"
	reqs = list(
			/obj/item/food/patty/plain = 1,
			/obj/item/food/bun = 1
	)

	result = /obj/item/food/burger/plain
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/corgiburger
	name = "柯基汉堡"
	reqs = list(
			/obj/item/food/patty/corgi = 1,
			/obj/item/food/bun = 1
	)

	result = /obj/item/food/burger/corgi
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/appendixburger
	name = "阑尾汉堡"
	reqs = list(
		/obj/item/organ/appendix = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/appendix
	added_foodtypes = MEAT | GORE
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/brainburger
	name = "脑汉堡"
	reqs = list(
		/obj/item/organ/brain = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/brain
	added_foodtypes = MEAT | GORE
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/xenoburger
	name = "异形汉堡"
	reqs = list(
		/obj/item/food/patty/xeno = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/xeno
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/bearger
	name = "熊汉堡"
	reqs = list(
		/obj/item/food/patty/bear = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/bearger
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/fishburger
	name = "鱼肉汉堡"
	reqs = list(
		/obj/item/food/fishmeat = 1,
		/obj/item/food/bun = 1,
		/obj/item/food/cheese/wedge = 1
	)
	result = /obj/item/food/burger/fish
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/tofuburger
	name = "豆腐汉堡"
	reqs = list(
		/obj/item/food/tofu = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/tofu
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/ghostburger
	name = "幽灵汉堡"
	reqs = list(
		/obj/item/ectoplasm = 1,
		/datum/reagent/consumable/salt = 2,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/ghost
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/clownburger
	name = "小丑汉堡"
	reqs = list(
		/obj/item/clothing/mask/gas/clown_hat = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/clown
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/mimeburger
	name = "默剧汉堡"
	reqs = list(
		/obj/item/clothing/mask/gas/mime = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/mime
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/redburger
	name = "红色汉堡"
	reqs = list(
		/obj/item/food/patty/plain = 1,
		/obj/item/toy/crayon/red = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/red
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/orangeburger
	name = "橙色汉堡"
	reqs = list(
		/obj/item/food/patty/plain = 1,
		/obj/item/toy/crayon/orange = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/orange
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/yellowburger
	name = "黄色汉堡"
	reqs = list(
		/obj/item/food/patty/plain = 1,
		/obj/item/toy/crayon/yellow = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/yellow
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/greenburger
	name = "绿色汉堡"
	reqs = list(
		/obj/item/food/patty/plain = 1,
		/obj/item/toy/crayon/green = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/green
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/blueburger
	name = "蓝色汉堡"
	reqs = list(
		/obj/item/food/patty/plain = 1,
		/obj/item/toy/crayon/blue = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/blue
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/purpleburger
	name = "紫色汉堡"
	reqs = list(
		/obj/item/food/patty/plain = 1,
		/obj/item/toy/crayon/purple = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/purple
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/blackburger
	name = "黑色汉堡"
	reqs = list(
		/obj/item/food/patty/plain = 1,
		/obj/item/toy/crayon/black = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/black
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/whiteburger
	name = "白色汉堡"
	reqs = list(
		/obj/item/food/patty/plain = 1,
		/obj/item/toy/crayon/white = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/white
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/spellburger
	name = "魔法汉堡"
	reqs = list(
		/obj/item/clothing/head/wizard = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/spell
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/bigbiteburger
	name = "大口咬汉堡"
	reqs = list(
		/obj/item/food/patty/plain = 3,
		/obj/item/food/bun = 1,
		/obj/item/food/cheese/wedge = 2
	)
	result = /obj/item/food/burger/bigbite
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/superbiteburger
	name = "超级大口咬汉堡"
	reqs = list(
		/datum/reagent/consumable/salt = 5,
		/datum/reagent/consumable/blackpepper = 5,
		/obj/item/food/patty/plain = 5,
		/obj/item/food/grown/tomato = 4,
		/obj/item/food/cheese/wedge = 3,
		/obj/item/food/boiledegg = 1,
		/obj/item/food/meat/bacon = 1,
		/obj/item/food/bun = 1,
		/obj/item/food/pickle = 1,

	)
	result = /obj/item/food/burger/superbite
	removed_foodtypes = BREAKFAST
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/slimeburger
	name = "果冻汉堡"
	reqs = list(
		/datum/reagent/toxin/slimejelly = 5,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/jelly/slime
	added_foodtypes = TOXIC
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/jellyburger
	name = "果冻汉堡"
	reqs = list(
			/datum/reagent/consumable/cherryjelly = 5,
			/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/jelly/cherry
	added_foodtypes = FRUIT
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/fivealarmburger
	name = "五级警报汉堡"
	reqs = list(
			/obj/item/food/patty/plain = 1,
			/obj/item/food/grown/ghost_chili = 2,
			/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/fivealarm
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/ratburger
	name = "老鼠汉堡"
	reqs = list(
			/obj/item/food/deadmouse = 1,
			/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/rat
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/baseballburger
	name = "全垒打棒球汉堡"
	reqs = list(
			/obj/item/melee/baseball_bat = 1,
			/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/baseball
	added_foodtypes = GROSS
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/baconburger
	name = "培根汉堡"
	reqs = list(
			/obj/item/food/meat/bacon = 3,
			/obj/item/food/bun = 1
	)

	result = /obj/item/food/burger/baconburger
	removed_foodtypes = BREAKFAST
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/empoweredburger
	name = "强化汉堡"
	reqs = list(
			/obj/item/stack/sheet/mineral/plasma = 2,
			/obj/item/food/bun = 1
	)
	requirements_mats_blacklist = list(/obj/item/stack/sheet/mineral/plasma)
	result = /obj/item/food/burger/empoweredburger
	added_foodtypes = TOXIC
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/catburger
	name = "猫汉堡"
	reqs = list(
		/obj/item/food/bun = 1,
		/obj/item/food/patty/plain = 1,
		/obj/item/organ/ears/cat = 1,
		/obj/item/organ/tail/cat = 1,
	)
	result = /obj/item/food/burger/catburger
	added_foodtypes = GORE
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/crabburger
	name = "蟹肉汉堡"
	reqs = list(
			/obj/item/food/meat/crab = 2,
			/obj/item/food/bun = 1
	)

	result = /obj/item/food/burger/crab
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/cheeseburger
	name = "芝士汉堡"
	reqs = list(
			/obj/item/food/patty/plain = 1,
			/obj/item/food/bun = 1,
			/obj/item/food/cheese/wedge = 1,
	)
	result = /obj/item/food/burger/cheese
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/soylentburger
	name = "人造食品汉堡"
	reqs = list(
			/obj/item/food/soylentgreen = 1, //two full meats worth.
			/obj/item/food/bun = 1,
			/obj/item/food/cheese/wedge = 2,
	)
	result = /obj/item/food/burger/soylent
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/ribburger
	name = "麦肋排"
	reqs = list(
			/obj/item/food/bbqribs = 1,     //The sauce is already included in the ribs
			/obj/item/food/onion_slice = 1, //feel free to remove if too burdensome.
			/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/rib
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/mcguffin
	name = "麦高芬"
	reqs = list(
			/obj/item/food/friedegg = 1,
			/obj/item/food/meat/bacon = 2,
			/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/mcguffin
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/chickenburger
	name = "鸡肉三明治"
	reqs = list(
			/obj/item/food/patty/chicken = 1,
			/datum/reagent/consumable/mayonnaise = 5,
			/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/chicken
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/crazyhamburger
	name = "疯狂汉堡"
	reqs = list(
			/obj/item/food/patty/plain = 2,
			/obj/item/food/bun = 1,
			/obj/item/food/cheese/wedge = 2,
			/obj/item/food/grown/chili = 1,
			/obj/item/food/grown/cabbage = 1,
			/obj/item/toy/crayon/green = 1,
			/obj/item/flashlight/flare = 1,
			/datum/reagent/consumable/nutriment/fat/oil = 15
	)
	result = /obj/item/food/burger/crazy
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/sloppy_moe
	name = "邋遢莫伊汉堡"
	reqs = list(
			/obj/item/food/bun = 1,
			/obj/item/food/meat/cutlet = 2,
			/obj/item/food/onion_slice = 1,
			/datum/reagent/consumable/bbqsauce = 5,
	)
	result = /obj/item/food/burger/sloppy_moe
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/kortaburger
	name = "原味根面包汉堡"
	reqs = list(
			/obj/item/food/patty/plain = 1,
			/obj/item/food/rootroll = 1
	)
	result = /obj/item/food/burger/plain/korta
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/ratkorta
	name = "老鼠根面包汉堡"
	reqs = list(
			/obj/item/food/deadmouse = 1,
			/obj/item/food/rootroll = 1
	)
	result = /obj/item/food/burger/rat/korta
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/rootguffin
	name = "根面包麦高芬"
	reqs = list(
			/obj/item/food/friedegg = 1,
			/obj/item/food/meat/bacon = 2,
			/obj/item/food/rootroll = 1
	)
	result = /obj/item/food/burger/rootguffin
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/rootrib
	name = "根面包肋排"
	reqs = list(
			/obj/item/food/bbqribs = 1,     //The sauce is already included in the ribs
			/obj/item/food/onion_slice = 1, //feel free to remove if too burdensome.
			/obj/item/food/rootroll = 1
	)
	result = /obj/item/food/burger/rootrib
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/rootchicken
	name = "鸡肉根面包三明治"
	reqs = list(
			/obj/item/food/patty/chicken = 1,
			/datum/reagent/consumable/mayonnaise = 5,
			/obj/item/food/rootroll = 1
	)
	result = /obj/item/food/burger/rootchicken
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/rootfish
	name = "鱼肉根面包汉堡"
	reqs = list(
		/obj/item/food/fishmeat = 1,
		/obj/item/food/rootroll = 1
	)
	result = /obj/item/food/burger/rootfish
	dish_category = DISH_BURGER

/datum/crafting_recipe/food/sloppyroot
	name = "嘶邋遢莫伊汉堡"
	reqs = list(
			/obj/item/food/rootroll = 1,
			/obj/item/food/meat/cutlet = 2,
			/obj/item/food/onion_slice = 1,
			/datum/reagent/consumable/bbqsauce = 5,
	)
	result = /obj/item/food/burger/sloppyroot
	dish_category = DISH_BURGER
