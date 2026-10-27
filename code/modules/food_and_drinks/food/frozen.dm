/obj/item/food/icecreamsandwich
	name = "冰淇淋三明治"
	desc = "自带包装的便携冰淇淋。"
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "icecreamsandwich"
	w_class = WEIGHT_CLASS_TINY
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/ice = 4,
	)
	tastes = list("冰淇淋" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_2
	crafted_food_buff = /datum/status_effect/food/chilling

/obj/item/food/strawberryicecreamsandwich
	name = "草莓冰淇淋三明治"
	desc = "自带包装的便携草莓味冰淇淋。"
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "strawberryicecreamsandwich"
	w_class = WEIGHT_CLASS_TINY
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/ice = 4,
	)
	tastes = list("冰淇淋" = 2, "浆果" = 2)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_3
	crafted_food_buff = /datum/status_effect/food/chilling

/obj/item/food/spacefreezy
	name = "太空冰爽"
	desc = "太空中最好的冰淇淋。"
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "spacefreezy"
	w_class = WEIGHT_CLASS_TINY
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/bluecherryjelly = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("蓝樱桃" = 2, "冰淇淋" = 2)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3
	crafted_food_buff = /datum/status_effect/food/chilling

/obj/item/food/spacefreezy/make_edible()
	. = ..()
	AddComponent(/datum/component/ice_cream_holder)

/obj/item/food/sundae
	name = "圣代"
	desc = "一道经典甜点。"
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "sundae"
	w_class = WEIGHT_CLASS_SMALL
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/banana = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("冰淇淋" = 1, "香蕉" = 1)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3
	crafted_food_buff = /datum/status_effect/food/chilling

/obj/item/food/sundae/make_edible()
	. = ..()
	AddComponent(/datum/component/ice_cream_holder, y_offset = -2, sweetener = /datum/reagent/consumable/caramel)

/obj/item/food/honkdae
	name = "洪克圣代"
	desc = "小丑最爱的甜点。"
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "honkdae"
	w_class = WEIGHT_CLASS_SMALL
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/banana = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("冰淇淋" = 1, "香蕉" = 1, "一个烂笑话" = 1)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4
	crafted_food_buff = /datum/status_effect/food/chilling

/obj/item/food/honkdae/make_edible()
	. = ..()
	AddComponent(/datum/component/ice_cream_holder, y_offset = -2) //The sugar will react with the banana forming laughter. Honk!

/////////////
//SNOWCONES//
/////////////

/obj/item/food/snowcones //We use this as a base for all other snowcones
	name = "无味雪锥"
	desc = "只是刨冰而已。不过嚼起来还是挺有意思的。"
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "flavorless_sc"
	w_class = WEIGHT_CLASS_SMALL
	trash_type = /obj/item/reagent_containers/cup/glass/sillycup //We dont eat paper cups
	food_reagents = list(
		/datum/reagent/water = 11,
	) // We dont get food for water/juices
	tastes = list("冰" = 1, "水" = 1)
	foodtypes = SUGAR //We use SUGAR as a base line to act in as junkfood, other wise we use fruit
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_2
	crafted_food_buff = /datum/status_effect/food/chilling

/obj/item/food/snowcones/on_craft_completion(list/components, datum/crafting_recipe/food/current_recipe, atom/crafter)
	. = ..()
	// replaces the ice from the input with water
	reagents.remove_reagent(/datum/reagent/consumable/ice, 15)
	reagents.add_reagent(/datum/reagent/water, 11)
	// then add 1u nutriment for free
	reagents.add_reagent(/datum/reagent/consumable/nutriment, 1)
	// the juice component will be transferred in from crafting

/obj/item/food/snowcones/lime
	name = "青柠雪锥"
	desc = "淋在纸杯雪球上的青柠糖浆。"
	icon_state = "lime_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/limejuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "青柠" = 5)
	foodtypes = FRUIT

/obj/item/food/snowcones/lemon
	name = "柠檬雪锥"
	desc = "淋在纸杯雪球上的柠檬糖浆。"
	icon_state = "lemon_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/lemonjuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "柠檬" = 5)
	foodtypes = FRUIT

/obj/item/food/snowcones/apple
	name = "苹果雪锥"
	desc = "淋在纸杯雪球上的苹果糖浆。"
	icon_state = "amber_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/applejuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "苹果" = 5)
	foodtypes = FRUIT

/obj/item/food/snowcones/grape
	name = "葡萄雪锥"
	desc = "淋在纸杯雪球上的葡萄糖浆。"
	icon_state = "grape_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/grapejuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "葡萄" = 5)
	foodtypes = FRUIT

/obj/item/food/snowcones/orange
	name = "橙子雪锥"
	desc = "淋在纸杯雪球上的橙子糖浆。"
	icon_state = "orange_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/orangejuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "橙子" = 5)
	foodtypes = FRUIT | ORANGES

/obj/item/food/snowcones/blue
	name = "蓝樱桃雪锥"
	desc = "淋在纸杯雪球上的蓝樱桃糖浆，真稀罕！"
	icon_state = "blue_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/bluecherryjelly = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "蓝" = 5, "樱桃" = 5)
	foodtypes = FRUIT

/obj/item/food/snowcones/red
	name = "樱桃雪锥"
	desc = "淋在纸杯雪球上的樱桃糖浆。"
	icon_state = "red_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/cherryjelly = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "红" = 5, "樱桃" = 5)
	foodtypes = FRUIT

/obj/item/food/snowcones/berry
	name = "浆果雪锥"
	desc = "淋在纸杯雪球上的浆果糖浆。"
	icon_state = "berry_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/berryjuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "浆果" = 5)
	foodtypes = FRUIT

/obj/item/food/snowcones/fruitsalad
	name = "水果沙拉雪锥"
	desc = "柑橘类糖浆的美妙混合，淋在纸杯雪球上。"
	icon_state = "fruitsalad_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/lemonjuice = 5,
		/datum/reagent/consumable/limejuice = 5,
		/datum/reagent/consumable/orangejuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "橙子" = 5, "青柠" = 5, "柠檬" = 5, "柑橘" = 5, "沙拉" = 5)
	foodtypes = FRUIT | ORANGES

/obj/item/food/snowcones/pineapple
	name = "菠萝雪锥"
	desc = "淋在纸杯雪球上的菠萝糖浆。"
	icon_state = "pineapple_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/pineapplejuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "菠萝" = 5)
	foodtypes = PINEAPPLE //Pineapple to allow all that like pineapple to enjoy

/obj/item/food/snowcones/mime
	name = "默剧演员雪锥"
	desc = "..."
	icon_state = "mime_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nothing = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "虚无" = 5)
	foodtypes = SUGAR

/obj/item/food/snowcones/clown
	name = "小丑雪锥"
	desc = "淋在纸杯雪球上的笑声。"
	icon_state = "clown_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/laughter = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "笑话" = 5, "脑冻" = 5, "欢乐" = 5)
	foodtypes = SUGAR | FRUIT

/obj/item/food/snowcones/soda
	name = "太空可乐雪锥"
	desc = "淋在纸杯雪球上的太空可乐。"
	icon_state = "soda_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/space_cola = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "可乐" = 5)
	foodtypes = SUGAR

/obj/item/food/snowcones/spacemountainwind
	name = "太空山风雪锥"
	desc = "淋在纸杯雪球上的太空山风。"
	icon_state = "mountainwind_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/spacemountainwind = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "山风" = 5)
	foodtypes = SUGAR


/obj/item/food/snowcones/pwrgame
	name = "电玩能量雪锥"
	desc = "淋在纸杯雪球上的电玩能量汽水。"
	icon_state = "pwrgame_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/pwr_game = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "正道" = 5, "盐" = 5, "水水" = 5)
	foodtypes = SUGAR

/obj/item/food/snowcones/honey
	name = "蜂蜜雪锥"
	desc = "淋在纸杯雪球上的蜂蜜。"
	icon_state = "amber_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/honey = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "花" = 5, "甜味" = 5, "蜡" = 1)
	foodtypes = SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/snowcones/rainbow
	name = "彩虹雪锥"
	desc = "纸杯里一颗色彩缤纷的雪球。"
	icon_state = "rainbow_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/laughter = 25,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "阳光" = 5, "光" = 5, "史莱姆" = 5, "颜料" = 3, "云" = 3)
	foodtypes = SUGAR

/obj/item/food/popsicle
	name = "虫子冰棒"
	desc = "嗯……这东西本不该存在。"
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "popsicle_stick_s"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("甲虫汁")
	trash_type = /obj/item/popsicle_stick
	w_class = WEIGHT_CLASS_SMALL
	foodtypes = DAIRY | SUGAR
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_3
	crafted_food_buff = /datum/status_effect/food/chilling

	var/overlay_state = "creamsicle_o" //This is the edible part of the popsicle.
	var/bite_states = 4 //This value value is used for correctly setting the bite_consumption to ensure every bite changes the sprite. Do not set to zero.
	var/bitecount = 0


/obj/item/food/popsicle/Initialize(mapload)
	. = ..()
	bite_consumption = reagents.total_volume / bite_states
	update_icon() // make sure the popsicle overlay is primed so it's not just a stick until you start eating it

/obj/item/food/popsicle/make_edible()
	. = ..()
	AddComponentFrom(SOURCE_EDIBLE_INNATE, /datum/component/edible, after_eat = CALLBACK(src, PROC_REF(after_bite)))

/obj/item/food/popsicle/update_overlays()
	. = ..()
	if(!bitecount)
		. += initial(overlay_state)
		return
	. += "[initial(overlay_state)]_[min(bitecount, 3)]"

/obj/item/food/popsicle/proc/after_bite(mob/living/eater, mob/living/feeder, bitecount)
	src.bitecount = bitecount
	update_appearance()

/obj/item/popsicle_stick
	name = "冰棒棍"
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "popsicle_stick"
	desc = "这根谦卑的小木棍通常承载着一份冷冻甜点，此刻它似乎已经从扛起世界的重负中解脱了。"
	custom_materials = list(/datum/material/wood = SMALL_MATERIAL_AMOUNT * 0.20)
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY
	force = 0

/obj/item/food/popsicle/creamsicle_orange
	name = "橙子奶油冰棒"
	desc = "一支经典的橙子奶油冰棒。阳光般的冷冻甜点。"
	food_reagents = list(
		/datum/reagent/consumable/orangejuice = 4,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	foodtypes = FRUIT | DAIRY | SUGAR | ORANGES
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/popsicle/creamsicle_berry
	name = "浆果奶油冰棒"
	desc = "一支鲜艳的浆果奶油冰棒。非常莓好的冷冻甜点。"
	food_reagents = list(
		/datum/reagent/consumable/berryjuice = 4,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	overlay_state = "creamsicle_m"
	foodtypes = FRUIT | DAIRY | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/popsicle/jumbo
	name = "巨无霸冰淇淋"
	desc = "一支覆满浓郁巧克力的豪华冰淇淋。它看起来比你记忆中的小了一些。"
	food_reagents = list(
		/datum/reagent/consumable/hot_coco = 4,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 3,
		/datum/reagent/consumable/sugar = 2,
	)
	overlay_state = "jumbo"
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/popsicle/licorice_creamsicle
	name = "\improper 虚空棒™"
	desc = "一支咸味甘草冰淇淋。咸味的冷冻甜点。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/salt = 1,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 1,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("咸甘草")
	overlay_state = "licorice_creamsicle"
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cornuto
	name = "科尔努托"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "cornuto"
	desc = "一支那不勒斯风的香草巧克力冰淇淋蛋筒。上面撒着一层焦糖坚果，颇有威势。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/hot_coco = 4,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 4,
		/datum/reagent/consumable/sugar = 2,
	)
	tastes = list("碎榛子", "华夫饼")
	foodtypes = GRAIN|DAIRY|SUGAR
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	crafted_food_buff = /datum/status_effect/food/chilling

/obj/item/food/popsicle/meatsicle
	name = "肉冰棒"
	desc = "生肉、糖浆与木棍构成的恐怖造物，然后被冻住。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/fat = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	overlay_state = "meatsicle"
	foodtypes = RAW | MEAT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)
