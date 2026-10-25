//Pastry is a food that is made from dough which is made from wheat or rye flour.
//This file contains pastries that don't fit any existing categories.
////////////////////////////////////////////MUFFINS////////////////////////////////////////////

/obj/item/food/muffin
	name = "松饼"
	desc = "一块松软美味的小蛋糕。"
	icon_state = "muffin"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("muffin" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR|BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/muffin/berry
	name = "浆果松饼"
	icon_state = "berrymuffin"
	desc = "一块松软美味的小蛋糕，加了浆果。"
	tastes = list("muffin" = 3, "berry" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR|BREAKFAST|FRUIT
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/muffin/booberry
	name = "幽灵浆果松饼"
	icon_state = "berrymuffin"
	alpha = 125
	desc = "我的胃是座坟场！没有活物能解我的嗜血之渴！"
	tastes = list("muffin" = 3, "spookiness" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR|BREAKFAST|FRUIT
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/muffin/booberry/Initialize(mapload, starting_reagent_purity, no_base_reagents)
	. = ..()
	AddComponent(/datum/component/ghost_edible, bite_consumption = bite_consumption)

/obj/item/food/muffin/moffin
	name = "蛾松饼"
	icon_state = "moffin_1"
	base_icon_state = "moffin"
	desc = "一块松软美味的小蛋糕。"
	tastes = list("muffin" = 3, "dust" = 1, "lint" = 1)
	foodtypes = CLOTH|DAIRY|GRAIN|SUGAR|BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/muffin/moffin/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 3)]"

/obj/item/food/muffin/moffin/examine(mob/user)
	. = ..()
	if(!isliving(user))
		return
	var/mob/living/moffin_observer = user
	if(moffin_observer.get_liked_foodtypes() & CLOTH)
		. += span_nicegreen("哦！上面居然还有衣服的碎屑！真好吃！")
	else
		. += span_warning("不过你不太确定上面那层是什么……")

////////////////////////////////////////////WAFFLES////////////////////////////////////////////

/obj/item/food/waffles
	name = "华夫饼"
	desc = "嗯，华夫饼。"
	icon_state = "waffles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("waffles" = 1)
	foodtypes = GRAIN|DAIRY|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/waffles/make_edible()
	. = ..()
	AddComponent(/datum/component/ice_cream_holder, max_scoops = 1, x_offset = -2)

/obj/item/food/soylentgreen
	name = "\improper 绿色索伦特"
	desc = "不是用人做的。真的。" //Totally people.
	icon_state = "soylent_green"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("waffles" = 7, "people" = 1)
	foodtypes = MEAT|GRAIN|DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/soylenviridians
	name = "\improper 素食索伦特"
	desc = "不是用人做的。真的。" //Actually honest for once.
	icon_state = "soylent_yellow"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("waffles" = 7, "the colour green" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/rofflewaffles
	name = "罗弗华夫饼"
	desc = "来自罗弗公司的华夫饼。"
	icon_state = "rofflewaffles"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/drug/mushroomhallucinogen = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("waffles" = 1, "mushrooms" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/rofflewaffles/make_edible()
	. = ..()
	AddComponent(/datum/component/ice_cream_holder, max_scoops = 1, x_offset = -2)

////////////////////////////////////////////OTHER////////////////////////////////////////////

/obj/item/food/cookie
	name = "饼干"
	desc = "饼干！！！"
	icon_state = "COOKIE!!!"
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("cookie" = 1)
	foodtypes = GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cookie/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/cookie/sleepy
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin/chloralhydrate = 10)

/obj/item/food/fortunecookie
	name = "幸运饼干"
	desc = "每块饼干里都有一则真正的预言！"
	icon_state = "fortune_cookie"
	trash_type = /obj/item/paper/paperslip/fortune
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("cookie" = 1)
	foodtypes = GRAIN|SUGAR|DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/fortunecookie/proc/get_fortune()
	var/atom/drop_location = drop_location()

	var/obj/item/paper/fortune = locate(/obj/item/paper) in src
	// If a fortune exists, use that.
	if (fortune)
		fortune.forceMove(drop_location)
		return fortune

	// Otherwise, use a generic one
	var/obj/item/paper/paperslip/fortune/fortune_slip = new trash_type(drop_location)
	// if someone adds lottery tickets in the future, be sure to add random numbers to this
	return fortune_slip

/obj/item/food/fortunecookie/make_leave_trash()
	if(trash_type)
		AddElement(/datum/element/food_trash, trash_type, food_flags, TYPE_PROC_REF(/obj/item/food/fortunecookie, get_fortune))

/obj/item/food/cookie/sugar
	name = "糖饼干"
	desc = "就像你妹妹以前做的那样。"
	icon_state = "sugarcookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 6,
	)
	tastes = list("sweetness" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cookie/sugar/Initialize(mapload, seasonal_changes = TRUE)
	. = ..()
	if(seasonal_changes && check_holidays(FESTIVE_SEASON))
		var/shape = pick("tree", "bear", "santa", "stocking", "present", "cane")
		desc = "一块 [shape] 造型的糖饼干。希望圣诞老人喜欢！"
		icon_state = "sugarcookie_[shape]"

/obj/item/food/chococornet
	name = "巧克力角"
	desc = "哪头是脑袋，粗的那头还是细的那头？"
	icon_state = "chococornet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("biscuit" = 3, "chocolate" = 1)
	foodtypes = JUNKFOOD|GRAIN|DAIRY|SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/oatmeal
	name = "燕麦饼干"
	desc = "饼干与燕麦的完美结合。"
	icon_state = "oatmealcookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("cookie" = 2, "oat" = 1)
	foodtypes = GRAIN|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/raisin
	name = "葡萄干饼干"
	desc = "为什么要在饼干上放葡萄干？"
	icon_state = "raisincookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("cookie" = 1, "raisins" = 1)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/poppypretzel
	name = "罂粟籽椒盐卷饼"
	desc = "全都扭在一起了！"
	icon_state = "poppypretzel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("pretzel" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/plumphelmetbiscuit
	name = "肥盔菇饼干"
	desc = "这是一块精心制作的肥盔菇饼干。原料是切得极细的肥盔菇，以及磨得很细的矮人小麦粉。"
	icon_state = "phelmbiscuit"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("mushroom" = 1, "biscuit" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/plumphelmetbiscuit/Initialize(mapload)
	var/fey = prob(10)
	if(fey)
		name = "极品肥盔菇饼干"
		desc = "微波炉陷入了狂灵之思！它烤出了一块极品肥盔菇饼干！"
		food_reagents = list(
			/datum/reagent/medicine/omnizine = 5,
			/datum/reagent/consumable/nutriment = 1,
			/datum/reagent/consumable/nutriment/vitamin = 1,
		)
	. = ..()
	if(fey)
		reagents.add_reagent(/datum/reagent/medicine/omnizine, 5)

/obj/item/food/cracker
	name = "苏打饼干"
	desc = "这是一块咸味苏打饼干。"
	icon_state = "cracker"
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("cracker" = 1)
	foodtypes = GRAIN
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/khachapuri
	name = "哈恰普里"
	desc = "加鸡蛋和奶酪的面包？"
	icon_state = "khachapuri"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bread" = 1, "egg" = 1, "cheese" = 1)
	foodtypes = GRAIN | MEAT | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cherrycupcake
	name = "樱桃杯子蛋糕"
	desc = "一块带樱桃果粒的甜杯子蛋糕。"
	icon_state = "cherrycupcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("cake" = 3, "cherry" = 1)
	foodtypes = GRAIN|DAIRY|FRUIT|SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cherrycupcake/blue
	name = "蓝樱桃杯子蛋糕"
	desc = "美味杯子蛋糕里藏着蓝樱桃。"
	icon_state = "bluecherrycupcake"
	tastes = list("cake" = 3, "blue cherry" = 1)
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/jupitercupcake
	name = "木星杯子蛋糕"
	desc = "一道静电甜品。"
	icon_state = "jupitercupcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/caramel = 3,
		/datum/reagent/consumable/liquidelectricity = 3,
	)
	tastes = list("cake" = 3, "caramel" = 2, "zap" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES|SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	crafted_food_buff = /datum/status_effect/food/trait/shockimmune

/obj/item/food/honeybun
	name = "蜂蜜面包"
	desc = "一个裹着蜂蜜糖衣的黏甜糕点面包。"
	icon_state = "honeybun"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/honey = 6,
	)
	tastes = list("pastry" = 1, "sweetness" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cannoli
	name = "卡诺里卷"
	desc = "一种西西里点心，吃了会让你变成道上的人。"
	icon_state = "cannoli"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("pastry" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	w_class = WEIGHT_CLASS_TINY
	venue_value = FOOD_PRICE_CHEAP // Pastry base, 3u of sugar and a single. fucking. unit. of. milk. really?
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/icecream
	name = "华夫蛋筒"
	desc = "美味的华夫蛋筒，但没有冰淇淋。"
	icon = 'icons/obj/service/kitchen.dmi'
	icon_state = "icecream_cone_waffle"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("cream" = 2, "waffle" = 1)
	bite_consumption = 4
	foodtypes = DAIRY | SUGAR | GRAIN
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_2
	max_volume = 10 //The max volumes scales up with the number of scoops of ice cream served.
	/// These two variables are used by the ice cream vat. Latter is the one that shows on the UI.
	var/list/ingredients = list(
		/datum/reagent/consumable/flour,
		/datum/reagent/consumable/sugar,
	)
	var/ingredients_text
	/*
	 * Assoc list var used to prefill the cone with ice cream.
	 * Key is the flavour's name (use text defines; see __DEFINES/food.dm or ice_cream_holder.dm),
	 * assoc is the list of args that is going to be used in [flavour/add_flavour()]. Can as well be null for simple flavours.
	 */
	var/list/prefill_flavours

/obj/item/food/icecream/Initialize(mapload, list/prefill_flavours)
	if(ingredients)
		ingredients_text = "需要：[reagent_paths_list_to_text(ingredients)]"
	src.prefill_flavours = prefill_flavours
	return ..()

/obj/item/food/icecream/make_edible()
	. = ..()
	var/max_scoops = check_holidays(ICE_CREAM_DAY) ? DEFAULT_MAX_ICE_CREAM_SCOOPS * 4 : DEFAULT_MAX_ICE_CREAM_SCOOPS
	AddComponent(/datum/component/ice_cream_holder, max_scoops, filled_name = "冰淇淋", change_desc = TRUE, prefill_flavours = prefill_flavours)

/obj/item/food/icecream/chocolate
	name = "巧克力蛋筒"
	desc = "美味的巧克力蛋筒，但没有冰淇淋。"
	icon_state = "icecream_cone_chocolate"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/coco = 1,
	)
	ingredients = list(
		/datum/reagent/consumable/flour,
		/datum/reagent/consumable/sugar,
		/datum/reagent/consumable/coco,
	)

/obj/item/food/icecream/korta
	name = "科尔塔蛋筒"
	desc = "美味的蜥蜴友好蛋筒，但没有冰淇淋。"
	foodtypes = NUTS | SUGAR
	ingredients = list(
		/datum/reagent/consumable/korta_flour,
		/datum/reagent/consumable/sugar,
	)

/obj/item/food/cookie/peanut_butter
	name = "花生酱饼干"
	desc = "一块香甜耐嚼的花生酱饼干。"
	icon_state = "peanut_butter_cookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/peanut_butter = 5,
	)
	tastes = list("peanut butter" = 2, "cookie" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_brownie_batter
	name = "生布朗尼面糊"
	desc = "一坨黏稠的生布朗尼面糊，放进烤箱烤一下吧！"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "raw_brownie_batter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("raw brownie batter" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR
	foodtypes_added_when_cooked = BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_brownie_batter/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/brownie_sheet, rand(20 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/brownie_sheet
	name = "布朗尼坯"
	desc = "一整块未切的烤布朗尼，用刀切开来！"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "brownie_sheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/sugar = 12,
	)
	tastes = list("brownie" = 1, "chocolatey goodness" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/brownie_sheet/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/brownie, 4, 3 SECONDS, table_required = TRUE,  screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/brownie
	name = "布朗尼"
	desc = "一块方形、香甜耐嚼的布朗尼。常是瘾君子的目标。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "brownie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/sugar = 3,
	)
	tastes = list("brownie" = 1, "chocolatey goodness" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/peanut_butter_brownie_batter
	name = "生花生酱布朗尼面糊"
	desc = "一坨黏稠的生花生酱布朗尼面糊，放进烤箱烤一下吧！"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "peanut_butter_brownie_batter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/peanut_butter = 4,
	)
	tastes = list("raw brownie batter" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|NUTS
	foodtypes_added_when_cooked = BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/peanut_butter_brownie_batter/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/peanut_butter_brownie_sheet, rand(20 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/peanut_butter_brownie_sheet
	name = "花生酱布朗尼坯"
	desc = "一整块未切的烤花生酱布朗尼，用刀切开来！"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "peanut_butter_brownie_sheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 24,
		/datum/reagent/consumable/sugar = 16,
		/datum/reagent/consumable/peanut_butter = 20,
	)
	tastes = list("brownie" = 1, "chocolatey goodness" = 1, "peanut butter" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|BREAKFAST|NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/peanut_butter_brownie_sheet/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/peanut_butter_brownie, 4, 3 SECONDS, table_required = TRUE,  screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/peanut_butter_brownie
	name = "花生酱布朗尼"
	desc = "一块方形、香甜耐嚼的花生酱布朗尼。常是瘾君子的目标。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "peanut_butter_brownie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/peanut_butter = 5,
	)
	tastes = list("brownie" = 1, "chocolatey goodness" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|BREAKFAST|NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/crunchy_peanut_butter_tart
	name = "脆花生酱挞"
	desc = "一个迷你派，内馅是花生酱，表面是奶油糖霜和碎坚果。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "crunchy_peanut_butter_tart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/peanut_butter = 5,
	)
	tastes = list("peanut butter" = 1, "peanuts" = 1, "cream" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/chocolate_chip_cookie
	name = "巧克力豆饼干"
	desc = "一块香气怡人的巧克力豆饼干。牛奶在哪儿？"
	icon_state = "COOKIE!!!"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("soft cookie" = 2, "chocolate" = 3)
	foodtypes = GRAIN | SUGAR | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/snickerdoodle
	name = "肉桂糖饼干"
	desc = "一块用香草和肉桂制成的软饼干。"
	icon_state = "snickerdoodle"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("soft cookie" = 2, "vanilla" = 3)
	foodtypes = GRAIN | SUGAR | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/macaron
	name = "马卡龙"
	desc = "一种三明治状甜点，外层是柔软的饼壳，中间是奶油蛋白霜。"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	icon_state = "macaron_1"
	base_icon_state = "macaron"
	tastes = list("wafer" = 2, "creamy meringue" = 3)
	foodtypes = GRAIN | SUGAR | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/macaron/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 4)]"

/obj/item/food/cookie/thumbprint_cookie
	name = "拇指印饼干"
	desc = "中间有拇指大小的凹槽用来填馅的饼干。这一块的馅是樱桃果酱"
	icon_state = "thumbprint_cookie"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("cookie" = 2, "cherry jelly" = 3)
	foodtypes = GRAIN|DAIRY|SUGAR|FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/apple_fritter
	name = "苹果炸饼"
	desc = "这玩意儿看着像一堆挂了糖霜的泥土，吃起来却出奇地酸。闻起来甜得能把你熏晕。"
	icon_state = "apple_fritter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/sugar = 1,
		/datum/reagent/consumable/applejuice = 1,
	)
	tastes = list("apple" = 1, "glaze" = 1)
	foodtypes = GRAIN|FRUIT|FRIED|DAIRY|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
