/obj/item/food/cake
	icon = 'icons/obj/food/piecake.dmi'
	abstract_type = /obj/item/food/cake
	bite_consumption = 3
	max_volume = 80
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("cake" = 1)
	foodtypes = GRAIN | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_2
	/// type is spawned 5 at a time and replaces this cake when processed by cutting tool
	var/obj/item/food/cakeslice/slice_type
	/// changes yield of sliced cake, default for cake is 5
	var/yield = 5

/obj/item/food/cake/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/food_storage)

/obj/item/food/cake/make_processable()
	if (slice_type)
		AddElement(/datum/element/processable, TOOL_KNIFE, slice_type, yield, 3 SECONDS, table_required = TRUE, screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/cakeslice
	icon = 'icons/obj/food/piecake.dmi'
	abstract_type = /obj/item/food/cakeslice
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("cake" = 1)
	foodtypes = GRAIN | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cake/plain
	name = "原味蛋糕"
	desc = "一块原味蛋糕，不是谎言。"
	icon_state = "plaincake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 30,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	tastes = list("sweetness" = 2, "cake" = 5)
	foodtypes = GRAIN | DAIRY | SUGAR
	slice_type = /obj/item/food/cakeslice/plain
	///ingredient holder for this cake
	VAR_PROTECTED/cake_holder = /obj/item/food/cake/empty

/obj/item/food/cake/plain/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, cake_holder, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 16)

/obj/item/food/cake/plain/vegan
	name = "纯素原味蛋糕"
	desc = "一块纯素原味蛋糕，不是谎言。"
	tastes = list("cake" = 5)
	foodtypes = GRAIN
	cake_holder = /obj/item/food/cake/empty/vegan
	slice_type = /obj/item/food/cakeslice/plain/vegan

/obj/item/food/cakeslice/plain/vegan
	name = "纯素原味蛋糕片"
	desc = "只是一片纯素蛋糕，足够所有人分享。"
	tastes = list("cake" = 5)
	foodtypes = GRAIN

/obj/item/food/cakeslice/plain
	name = "原味蛋糕片"
	desc = "只是一片蛋糕，足够所有人分享。"
	icon_state = "plaincake_slice"
	tastes = list("sweetness" = 2, "cake" = 5)
	foodtypes = GRAIN | DAIRY | SUGAR

/obj/item/food/cake/empty
	name = "蛋糕"
	desc = "由一位疯狂厨师定制的蛋糕。"
	icon_state = "cake_custom"
	foodtypes = GRAIN | DAIRY | SUGAR
	slice_type = /obj/item/food/cakeslice/empty

/obj/item/food/cakeslice/empty
	name = "蛋糕片"
	desc = "一片由疯狂厨师定制的蛋糕。"
	icon_state = "cake_custom_slice"
	foodtypes = GRAIN | DAIRY | SUGAR

/obj/item/food/cakeslice/empty/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 16)

/obj/item/food/cake/empty/vegan
	name = "纯素蛋糕"
	desc = "由一位极其疯狂的厨师定制的纯素蛋糕。"
	foodtypes = GRAIN
	slice_type = /obj/item/food/cakeslice/empty/vegan

/obj/item/food/cakeslice/empty/vegan
	name = "纯素蛋糕片"
	desc = "一片由极其疯狂的厨师定制的纯素蛋糕。"
	foodtypes = GRAIN

/obj/item/food/cake/carrot
	name = "胡萝卜蛋糕"
	desc = "某只狡猾兔子的最爱甜点。不是谎言。"
	icon_state = "carrotcake"
	tastes = list("cake" = 5, "sweetness" = 2, "carrot" = 1)
	foodtypes = GRAIN | DAIRY | VEGETABLES | SUGAR
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/carrot
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/carrot
	name = "胡萝卜蛋糕片"
	desc = "胡萝卜味十足的胡萝卜蛋糕片，胡萝卜对眼睛好！这也不是谎言。"
	icon_state = "carrotcake_slice"
	tastes = list("cake" = 5, "sweetness" = 2, "carrot" = 1)
	foodtypes = GRAIN | DAIRY | VEGETABLES | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/brain
	name = "脑仁蛋糕"
	desc = "一块软塌塌的蛋糕状物体。"
	icon_state = "braincake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/medicine/mannitol = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("cake" = 5, "sweetness" = 2, "brains" = 1)
	foodtypes = GRAIN | DAIRY | MEAT | GORE | SUGAR
	slice_type = /obj/item/food/cakeslice/brain
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/brain
	name = "脑仁蛋糕片"
	desc = "让我跟你说说朊病毒吧。它们很好吃。"
	icon_state = "braincakeslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/medicine/mannitol = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("cake" = 5, "sweetness" = 2, "brains" = 1)
	foodtypes = GRAIN | DAIRY | MEAT | GORE | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/cheese
	name = "芝士蛋糕"
	desc = "危险级别的芝士味。"
	icon_state = "cheesecake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment/protein = 5,
	)
	tastes = list("cake" = 4, "cream cheese" = 3)
	foodtypes = GRAIN | DAIRY | SUGAR
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/cheese
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/cheese
	name = "芝士蛋糕片"
	desc = "一片纯粹的芝士满足。"
	icon_state = "cheesecake_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1.3,
	)
	tastes = list("cake" = 4, "cream cheese" = 3)
	foodtypes = GRAIN | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/orange
	name = "橙子蛋糕"
	desc = "加了橙子的蛋糕。"
	icon_state = "orangecake"
	tastes = list("cake" = 5, "sweetness" = 2, "oranges" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR | ORANGES
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/orange
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/orange
	name = "橙子蛋糕片"
	desc = "只是一片蛋糕，足够所有人分享。"
	icon_state = "orangecake_slice"
	tastes = list("cake" = 5, "sweetness" = 2, "oranges" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR | ORANGES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/lime
	name = "青柠蛋糕"
	desc = "加了青柠的蛋糕。"
	icon_state = "limecake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("cake" = 5, "sweetness" = 2, "unbearable sourness" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/lime
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/lime
	name = "青柠蛋糕片"
	desc = "只是一片蛋糕，足够所有人分享。"
	icon_state = "limecake_slice"
	tastes = list("cake" = 5, "sweetness" = 2, "unbearable sourness" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/lemon
	name = "柠檬蛋糕"
	desc = "加了柠檬的蛋糕。"
	icon_state = "lemoncake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("cake" = 5, "sweetness" = 2, "sourness" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/lemon
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/lemon
	name = "柠檬蛋糕片"
	desc = "只是一片蛋糕，足够所有人分享。"
	icon_state = "lemoncake_slice"
	tastes = list("cake" = 5, "sweetness" = 2, "sourness" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/chocolate
	name = "巧克力蛋糕"
	desc = "加了巧克力的蛋糕。"
	icon_state = "chocolatecake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("cake" = 5, "sweetness" = 1, "chocolate" = 4)
	foodtypes = GRAIN | DAIRY | JUNKFOOD | SUGAR
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/chocolate
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/chocolate
	name = "巧克力蛋糕片"
	desc = "只是一片蛋糕，足够所有人分享。"
	icon_state = "chocolatecake_slice"
	tastes = list("cake" = 5, "sweetness" = 1, "chocolate" = 4)
	foodtypes = GRAIN | DAIRY | JUNKFOOD | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/birthday
	name = "生日蛋糕"
	desc = "生日快乐，小丑……"
	icon_state = "birthdaycake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/sprinkles = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("cake" = 5, "sweetness" = 1)
	foodtypes = GRAIN | DAIRY | JUNKFOOD | SUGAR
	slice_type = /obj/item/food/cakeslice/birthday
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/birthday/make_microwaveable() // super sekrit club
	AddElement(/datum/element/microwavable, /obj/item/clothing/head/utility/hardhat/cakehat)

/obj/item/food/cakeslice/birthday
	name = "生日蛋糕片"
	desc = "属于你生日的一片。"
	icon_state = "birthdaycakeslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sprinkles = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("cake" = 5, "sweetness" = 1)
	foodtypes = GRAIN | DAIRY | JUNKFOOD | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/birthday/energy
	name = "能量蛋糕"
	desc = "卡路里刚好够一整个核爆特工小队。"
	icon_state = "energycake"
	force = 5
	hitsound = 'sound/items/weapons/blade1.ogg'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/sprinkles = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/pwr_game = 10,
		/datum/reagent/consumable/liquidelectricity = 10,
	)
	tastes = list("cake" = 3, "a Vlad's Salad" = 1)
	slice_type = /obj/item/food/cakeslice/birthday/energy
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cake/birthday/energy/make_microwaveable() //super sekriter club
	AddElement(/datum/element/microwavable, /obj/item/clothing/head/utility/hardhat/cakehat/energycake)

/obj/item/food/cake/birthday/energy/proc/energy_bite(mob/living/user)
	to_chat(user, "<font color='red' size='5'>你吃蛋糕时，不小心被嵌在里面的能量剑割伤了自己！</font>")
	user.apply_damage(30, BRUTE, BODY_ZONE_HEAD)
	playsound(user, 'sound/items/weapons/blade1.ogg', 5, TRUE)

/obj/item/food/cake/birthday/energy/attack(mob/living/target_mob, mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM) && target_mob != user) //Prevents pacifists from attacking others directly
		return
	energy_bite(target_mob, user)

/obj/item/food/cakeslice/birthday/energy
	name = "能量蛋糕片"
	desc = "献给奔波中的叛徒。"
	icon_state = "energycakeslice"
	force = 2
	hitsound = 'sound/items/weapons/blade1.ogg'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sprinkles = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/pwr_game = 2,
		/datum/reagent/consumable/liquidelectricity = 2,
	)
	tastes = list("cake" = 3, "a Vlad's Salad" = 1)
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cakeslice/birthday/energy/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_FOOD_EATEN, PROC_REF(bite_taken))

/obj/item/food/cakeslice/birthday/energy/attack(mob/living/target_mob, mob/living/user)
	if(HAS_TRAIT(user, TRAIT_PACIFISM) && target_mob != user) //Prevents pacifists from attacking others directly
		balloon_alert(user, "那很危险！")
		return FALSE
	return ..()

/obj/item/food/cakeslice/birthday/energy/proc/bite_taken(datum/source, mob/living/eater, mob/living/feeder)
	SIGNAL_HANDLER
	to_chat(eater, "<font color='red' size='5'>你吃蛋糕片时，不小心被嵌在里面的能量匕首割伤了自己！</font>")
	if(eater != feeder)
		log_combat(feeder, eater, "fed an energy cake to", src)
	eater.apply_damage(18, BRUTE, BODY_ZONE_HEAD)
	playsound(eater, 'sound/items/weapons/blade1.ogg', 5, TRUE)

/obj/item/food/cake/apple
	name = "苹果蛋糕"
	desc = "中心填着苹果的蛋糕。"
	icon_state = "applecake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("cake" = 5, "sweetness" = 1, "apple" = 1)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/apple
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/apple
	name = "苹果蛋糕片"
	desc = "一片天堂般的蛋糕。"
	icon_state = "applecakeslice"
	tastes = list("cake" = 5, "sweetness" = 1, "apple" = 1)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/slimecake
	name = "史莱姆蛋糕"
	desc = "用史莱姆做成的蛋糕。大概没带电。"
	icon_state = "slimecake"
	tastes = list("cake" = 5, "sweetness" = 1, "slime" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	slice_type = /obj/item/food/cakeslice/slimecake
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/slimecake
	name = "史莱姆蛋糕片"
	desc = "一片史莱姆蛋糕。"
	icon_state = "slimecake_slice"
	tastes = list("cake" = 5, "sweetness" = 1, "slime" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/pumpkinspice
	name = "南瓜香料蛋糕"
	desc = "填着真南瓜的空心蛋糕。"
	icon_state = "pumpkinspicecake"
	tastes = list("cake" = 5, "sweetness" = 1, "pumpkin" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR|VEGETABLES
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/pumpkinspice
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/pumpkinspice
	name = "南瓜香料蛋糕片"
	desc = "一片香辣可口的南瓜蛋糕。"
	icon_state = "pumpkinspicecakeslice"
	tastes = list("cake" = 5, "sweetness" = 1, "pumpkin" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR|VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/berry_vanilla_cake // blackberry strawberries vanilla cake
	name = "黑莓草莓香草蛋糕"
	desc = "一块原味蛋糕，内馅是各式黑莓与草莓！"
	icon_state = "blackbarry_strawberries_cake_vanilla_cake"
	tastes = list("blackberry" = 2, "strawberries" = 2, "vanilla" = 2, "sweetness" = 2, "cake" = 3)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	slice_type = /obj/item/food/cakeslice/berry_vanilla_cake
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/berry_vanilla_cake
	name = "黑莓草莓香草蛋糕片"
	desc = "只是一片蛋糕，内馅是各式黑莓与草莓！"
	icon_state = "blackbarry_strawberries_cake_vanilla_slice"
	tastes = list("blackberry" = 2, "strawberries" = 2, "vanilla" = 2, "sweetness" = 2, "cake" = 3)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/berry_chocolate_cake // blackbarry strawberries chocolate cake <- this is a relic from before resprite
	name = "草莓巧克力蛋糕"
	desc = "一块顶着五颗草莓的巧克力蛋糕。不知为何，这种造型的蛋糕对 SELF 中的 AI 来说格外赏心悦目。"
	icon_state = "liars_cake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/coco = 5,
	)
	tastes = list("blackberry" = 2, "strawberries" = 2, "chocolate" = 2, "sweetness" = 2, "cake" = 3)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	slice_type = /obj/item/food/cakeslice/berry_chocolate_cake
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cakeslice/berry_chocolate_cake
	name = "草莓巧克力蛋糕片"
	desc = "一片顶着五颗草莓的蛋糕。 \
		不知为何，这种造型的蛋糕对 SELF 中的 AI 来说格外赏心悦目。"
	icon_state = "liars_slice"
	tastes = list("strawberries" = 2, "chocolate" = 2, "sweetness" = 2, "cake" = 3)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cake/holy_cake
	name = "天使蛋糕"
	desc = "为天使与牧师共同打造的蛋糕！内含圣水。"
	icon_state = "holy_cake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/water/holywater = 10,
	)
	tastes = list("cake" = 5, "sweetness" = 1, "clouds" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	slice_type = /obj/item/food/cakeslice/holy_cake_slice

/obj/item/food/cakeslice/holy_cake_slice
	name = "天使蛋糕片"
	desc = "一片天堂般的蛋糕。"
	icon_state = "holy_cake_slice"
	tastes = list("cake" = 5, "sweetness" = 1, "clouds" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR

/obj/item/food/cake/pound_cake
	name = "磅蛋糕"
	desc = "为快速填饱肚子而做的浓缩蛋糕。"
	icon_state = "pound_cake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 60,
		/datum/reagent/consumable/nutriment/vitamin = 20,
	)
	tastes = list("cake" = 5, "sweetness" = 5, "batter" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR | JUNKFOOD
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/pound_cake_slice
	yield = 7
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cakeslice/pound_cake_slice
	name = "磅蛋糕片"
	desc = "一片为快速填饱肚子而做的浓缩蛋糕。"
	icon_state = "pound_cake_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("cake" = 5, "sweetness" = 5, "batter" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR | JUNKFOOD
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cake/hardware_cake
	name = "硬件蛋糕"
	desc = "用电子板做成的“蛋糕”，还在渗酸液……"
	icon_state = "hardware_cake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/toxin/acid = 15,
		/datum/reagent/fuel/oil = 15,
	)
	tastes = list("acid" = 3, "metal" = 4, "glass" = 5)
	foodtypes = GRAIN|DAIRY|SUGAR|GROSS
	slice_type = /obj/item/food/cakeslice/hardware_cake_slice
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT)

/obj/item/food/cakeslice/hardware_cake_slice
	name = "硬件蛋糕片"
	desc = "一片电子板，配点酸液。"
	icon_state = "hardware_cake_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/toxin/acid = 3,
		/datum/reagent/fuel/oil = 3,
	)
	tastes = list("acid" = 3, "metal" = 4, "glass" = 5)
	foodtypes = GRAIN|DAIRY|SUGAR|GROSS
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT / 5)

/obj/item/food/cake/vanilla_cake
	name = "香草蛋糕"
	desc = "一块香草糖霜蛋糕。"
	icon_state = "vanillacake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/sugar = 15,
		/datum/reagent/consumable/vanilla = 15,
	)
	tastes = list("cake" = 1, "sugar" = 1, "vanilla" = 10)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR
	slice_type = /obj/item/food/cakeslice/vanilla_slice
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/vanilla_slice
	name = "香草蛋糕片"
	desc = "一片香草糖霜蛋糕。"
	icon_state = "vanillacake_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/vanilla = 3,
	)
	tastes = list("cake" = 1, "sugar" = 1, "vanilla" = 10)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/clown_cake
	name = "小丑蛋糕"
	desc = "一块画着小丑脸的滑稽蛋糕。"
	icon_state = "clowncake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/banana = 15,
	)
	tastes = list("cake" = 1, "sugar" = 1, "joy" = 10)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR
	slice_type = /obj/item/food/cakeslice/clown_slice
	crafting_complexity = FOOD_COMPLEXITY_5
	crafted_food_buff = /datum/status_effect/food/trait/waddle

/obj/item/food/cakeslice/clown_slice
	name = "小丑蛋糕片"
	desc = "一片烂笑话和傻道具。"
	icon_state = "clowncake_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/banana = 3,
	)
	tastes = list("cake" = 1, "sugar" = 1, "joy" = 10)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_5
	crafted_food_buff = /datum/status_effect/food/trait/waddle

/obj/item/food/cake/trumpet
	name = "太空人蛋糕"
	desc = "一块太空人喇叭花糖霜蛋糕。"
	icon_state = "trumpetcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/berryjuice = 5,
	)
	tastes = list("cake" = 4, "violets" = 2, "jam" = 2)
	foodtypes = GRAIN|DAIRY|FRUIT|SUGAR|VEGETABLES
	slice_type = /obj/item/food/cakeslice/trumpet
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cakeslice/trumpet
	name = "太空人蛋糕片"
	desc = "一块太空人喇叭花糖霜蛋糕。"
	icon_state = "trumpetcakeslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/cream = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/berryjuice = 1,
	)
	tastes = list("cake" = 4, "violets" = 2, "jam" = 2)
	foodtypes = GRAIN|DAIRY|FRUIT|SUGAR|VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cake/brioche
	name = "布里欧修蛋糕"
	desc = "一圈甜味糖霜小面包。"
	icon_state = "briochecake"
	tastes = list("cake" = 4, "butter" = 2, "cream" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	slice_type = /obj/item/food/cakeslice/brioche
	yield = 6
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cakeslice/brioche
	name = "布里欧修蛋糕片"
	desc = "美味的甜面包。还需要别的什么吗？"
	icon_state = "briochecake_slice"
	tastes = list("cake" = 4, "butter" = 2, "cream" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cake/pavlova
	name = "帕夫洛娃"
	desc = "甜美的浆果帕夫洛娃。诞生于新西兰，却以一位俄罗斯芭蕾舞者命名……而且经科学证明是晚宴上的最佳甜点！"
	icon_state = "pavlova"
	tastes = list("meringue" = 5, "creaminess" = 1, "berries" = 1)
	foodtypes = DAIRY | FRUIT | SUGAR
	slice_type = /obj/item/food/cakeslice/pavlova
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/pavlova/nuts
	name = "坚果帕夫洛娃"
	foodtypes = NUTS | FRUIT | SUGAR
	slice_type = /obj/item/food/cakeslice/pavlova/nuts

/obj/item/food/cakeslice/pavlova
	name = "帕夫洛娃蛋糕片"
	desc = "一片开裂的帕夫洛娃，上面堆满浆果。 \
		你甚至切得让更多浆果落到了自己这片上，多么令人愉悦的邪恶啊。"
	icon_state = "pavlova_slice"
	tastes = list("meringue" = 5, "creaminess" = 1, "berries" = 1)
	foodtypes = DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/pavlova/nuts
	foodtypes = NUTS | FRUIT | SUGAR

/obj/item/food/cake/fruit
	name = "英式水果蛋糕"
	desc = "正经好蛋糕，对吧？"
	icon_state = "fruitcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/sugar = 10,
		/datum/reagent/consumable/cherryjelly = 5,
	)
	tastes = list("dried fruit" = 5, "treacle" = 2, "christmas" = 2)
	force = 7
	throwforce = 7
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	slice_type = /obj/item/food/cakeslice/fruit
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cakeslice/fruit
	name = "英式水果蛋糕片"
	desc = "正经好蛋糕片，对吧？"
	icon_state = "fruitcake_slice1"
	base_icon_state = "fruitcake_slice"
	tastes = list("dried fruit" = 5, "treacle" = 2, "christmas" = 2)
	force = 2
	throwforce = 2
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cakeslice/fruit/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state][rand(1,3)]"

/obj/item/food/cake/plum
	name = "李子蛋糕"
	desc = "中心填着李子的蛋糕。"
	icon_state = "plumcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/impurity/rosenol = 8,
	)
	tastes = list("cake" = 5, "sweetness" = 1, "plum" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/plum
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/plum
	name = "李子蛋糕片"
	desc = "一片李子蛋糕。"
	icon_state = "plumcakeslice"
	tastes = list("cake" = 5, "sweetness" = 1, "plum" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/wedding
	name = "婚礼蛋糕"
	desc = "一块昂贵的多层蛋糕。"
	icon_state = "weddingcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 40,
		/datum/reagent/consumable/sugar = 30,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("cake" = 3, "frosting" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	slice_type = /obj/item/food/cakeslice/wedding
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/wedding
	name = "婚礼蛋糕片"
	desc = "按照传统，结婚的两人会互相喂一片蛋糕。"
	icon_state = "weddingcake_slice"
	tastes = list("cake" = 3, "frosting" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR

/obj/item/food/cake/pineapple_cream_cake
	name = "菠萝奶油蛋糕"
	desc = "一块色彩鲜艳的蛋糕，上面铺着一层厚奶油和菠萝。"
	icon_state = "pineapple_cream_cake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 30,
		/datum/reagent/consumable/sugar = 15,
		/datum/reagent/consumable/nutriment/vitamin = 15,
	)
	tastes = list("cake" = 2, "cream" = 3, "pineapple" = 4)
	foodtypes = GRAIN | DAIRY | SUGAR | FRUIT | PINEAPPLE
	slice_type = /obj/item/food/cakeslice/pineapple_cream_cake
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/pineapple_cream_cake
	name = "菠萝奶油蛋糕片"
	desc = "一块色彩鲜艳的蛋糕，上面铺着一层厚奶油和菠萝。"
	icon_state = "pineapple_cream_cake_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("cake" = 2, "cream" = 3, "pineapple" = 4)
	foodtypes = GRAIN | DAIRY | SUGAR | FRUIT | PINEAPPLE
	crafting_complexity = FOOD_COMPLEXITY_3
