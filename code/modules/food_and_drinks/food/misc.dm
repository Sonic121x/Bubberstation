
////////////////////////////////////////////OTHER////////////////////////////////////////////
/obj/item/food/watermelonslice
	name = "西瓜片"
	desc = "一片多汁的美味。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "watermelonslice"
	food_reagents = list(
		/datum/reagent/water = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("西瓜" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/watermelonslice/juice_typepath()
	return /datum/reagent/consumable/watermelonjuice

/obj/item/food/watermelonmush
	name = "西瓜泥"
	desc = "一坨多汁的美味。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "watermelonpulp"
	food_reagents = list(
		/datum/reagent/water = 2,
		/datum/reagent/consumable/nutriment/vitamin = 0.1,
		/datum/reagent/consumable/nutriment = 0.5,
	)
	tastes = list("西瓜" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/watermelonmush/juice_typepath()
	return /datum/reagent/consumable/watermelonjuice

/obj/item/food/holymelonslice
	name = "圣瓜片"
	desc = "一片神圣的美味。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "holymelonslice"
	food_reagents = list(
		/datum/reagent/water/holywater = 0.5,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("圣瓜" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/holymelonslice/juice_typepath()
	return /datum/reagent/water/holywater

/obj/item/food/holymelonmush
	name = "圣瓜泥"
	desc = "一坨神圣的美味。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "holymelonpulp"
	food_reagents = list(
		/datum/reagent/water/holywater = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.1,
		/datum/reagent/consumable/nutriment = 0.5,
	)
	tastes = list("圣瓜" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/holymelonmush/juice_typepath()
	return /datum/reagent/water/holywater

/obj/item/food/barrelmelonslice
	name = "酒桶瓜片"
	desc = "一片啤酒味的美味。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "barrelmelonslice"
	food_reagents = list(
		/datum/reagent/consumable/ethanol/beer = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("啤酒" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/barrelmelonslice/juice_typepath()
	return /datum/reagent/consumable/ethanol/beer

/obj/item/food/barrelmelonmush
	name = "酒桶瓜泥"
	desc = "一坨啤酒味的美味。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "barrelmelonpulp"
	food_reagents = list(
		/datum/reagent/consumable/ethanol/beer = 2,
		/datum/reagent/consumable/nutriment/vitamin = 0.1,
		/datum/reagent/consumable/nutriment = 0.5,
	)
	tastes = list("啤酒" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/barrelmelonmush/juice_typepath()
	return /datum/reagent/consumable/ethanol/beer

/obj/item/food/appleslice
	name = "苹果片"
	desc = "完美的放学后零食。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "appleslice"
	food_reagents = list(
		/datum/reagent/consumable/applejuice = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("苹果" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/appleslice/juice_typepath()
	return /datum/reagent/consumable/applejuice

/obj/item/food/hugemushroomslice
	name = "巨型蘑菇片"
	desc = "一片巨型蘑菇切片。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "hugemushroomslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("蘑菇" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/hugemushroomslice/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_WALKING_MUSHROOM, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/obj/item/food/popcorn
	name = "爆米花"
	desc = "接下来找家电影院吧。"
	icon_state = "popcorn"
	trash_type = /obj/item/trash/popcorn
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bite_consumption = 0.1 //this snack is supposed to be eating during looooong time. And this it not dinner food! --rastaf0
	tastes = list("爆米花" = 3, "黄油" = 1)
	foodtypes = JUNKFOOD
	eatverbs = list("咬", "小口咬", "啃", "狼吞虎咽", "大声咀嚼")
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/popcorn/salty
	name = "咸味爆米花"
	icon_state = "salty_popcorn"
	desc = "咸味爆米花，永恒的经典。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("盐" = 2, "爆米花" = 1)
	trash_type = /obj/item/trash/popcorn/salty
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/popcorn/caramel
	name = "焦糖爆米花"
	icon_state = "caramel_popcorn"
	desc = "裹着焦糖的爆米花。真甜！"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/caramel = 4,
	)
	tastes = list("焦糖" = 2, "爆米花" = 1)
	foodtypes = JUNKFOOD | SUGAR
	trash_type = /obj/item/trash/popcorn
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/soydope
	name = "大豆糊"
	desc = "用大豆做成的糊状物。"
	icon_state = "soydope"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/protein = 1,
	)
	tastes = list("大豆" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/badrecipe
	name = "烧焦的一团"
	desc = "有人该因为这东西被从厨师降职。"
	icon_state = "badrecipe"
	food_reagents = list(/datum/reagent/toxin/bad_food = 30)
	foodtypes = GROSS
	w_class = WEIGHT_CLASS_SMALL
	preserved_food = TRUE //Can't decompose any more than this
	/// Variable that holds the reference to the stink lines we get when we're moldy, yucky yuck
	var/stink_particles

/obj/item/food/badrecipe/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_GRILL_PROCESS, PROC_REF(OnGrill))
	RegisterSignals(src, list(COMSIG_ITEM_GRILLED_RESULT, COMSIG_ITEM_BAKED_RESULT, COMSIG_ITEM_MICROWAVE_COOKED_RESULT, COMSIG_OBJ_DECOMPOSITION_RESULT), PROC_REF(convert_to_bad_food))
	if(stink_particles)
		add_shared_particles(stink_particles)

///Prevents grilling burnt shit from well, burning.
/obj/item/food/badrecipe/proc/OnGrill()
	SIGNAL_HANDLER
	return COMPONENT_HANDLED_GRILLING

/**
 * The bad food reagent is cleared when cooked rather than just spawned and the reagents of the item this is from are transferred to this instead,
 * So we want to convert most of the consumable reagents into bad food, which is what makes the burned mess a bad thing to eat, taste aside.
 */
/obj/item/food/badrecipe/proc/convert_to_bad_food(atom/source)
	SIGNAL_HANDLER
	var/bad_food_amount = 0
	for(var/datum/reagent/consumable/food_reagent in reagents.reagent_list)
		var/amount_to_remove = food_reagent.volume * rand(6, 8) * 0.1 //around 60% to 80% of the volume is to be converted.
		food_reagent.volume -= amount_to_remove
		bad_food_amount += amount_to_remove
	reagents.update_total()
	reagents.add_reagent(/datum/reagent/toxin/bad_food, bad_food_amount, reagtemp = reagents.chem_temp)

/obj/item/food/badrecipe/Destroy(force)
	if (stink_particles)
		remove_shared_particles(stink_particles)
	return ..()

// We override the parent procs here to prevent burned messes from cooking into burned messes.
/obj/item/food/badrecipe/make_grillable()
	return
/obj/item/food/badrecipe/make_bakeable()
	return

/obj/item/food/badrecipe/moldy
	name = "发霉的一团"
	desc = "一坨腐臭恶心的霉菌与蚂蚁培养物。在那下面的某处，<i>曾经某个时候，</i>确实是食物。"
	food_reagents = list(/datum/reagent/consumable/mold = 30)
	preserved_food = FALSE
	ant_attracting = TRUE
	decomp_type = null
	decomposition_time = 30 SECONDS
	stink_particles = /particles/stink

/obj/item/food/badrecipe/moldy/bacteria
	name = "富含细菌的发霉物"
	desc = "这团腐臭恶心的胆汁状物不仅爬满了昆虫， \
		还挤满了各种微观培养物。<i>你不看它的时候，它会动。</i>"

/obj/item/food/badrecipe/moldy/bacteria/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_MOLD, CELL_VIRUS_TABLE_GENERIC, rand(2, 4), 25)

/obj/item/food/spidereggs
	name = "蜘蛛卵"
	desc = "一簇多汁的蜘蛛卵。不在乎健康时的绝佳配菜。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spidereggs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/toxin = 2,
	)
	tastes = list("蛛网" = 1)
	foodtypes = MEAT | TOXIC | BUGS | EGG
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/spidereggs/processed
	name = "加工蜘蛛卵"
	desc = "一簇多汁的蜘蛛卵。在嘴里爆开，还不会让你生病。"
	icon_state = "spidereggs"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 4)
	tastes = list("蛛网" = 1)
	foodtypes = MEAT | EGG
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/spiderling
	name = "小蜘蛛"
	desc = "它在你手里微微抽搐。呃……"
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "spiderling_dead"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/toxin = 4,
	)
	tastes = list("蛛网" = 1, "内脏" = 2)
	foodtypes = MEAT | TOXIC | BUGS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/melonfruitbowl
	name = "甜瓜水果碗"
	desc = "献给想要体验风味爆炸的人。"
	icon_state = "melonfruitbowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("甜瓜" = 1)
	foodtypes = VEGETABLES|FRUIT|ORANGES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/melonkeg
	name = "甜瓜酒桶"
	desc = "谁知道伏特加也算水果？"
	icon_state = "melonkeg"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/ethanol/vodka = 15,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	max_volume = 80
	bite_consumption = 5
	tastes = list("谷物酒精" = 1, "水果" = 1)
	foodtypes = FRUIT | ALCOHOL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/honeybar
	name = "蜂蜜坚果棒"
	desc = "把燕麦和坚果压成棒状，再用蜂蜜糖浆粘合。"
	icon_state = "honeybar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/honey = 5,
	)
	tastes = list("燕麦" = 3, "坚果" = 2, "蜂蜜" = 1)
	foodtypes = GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/powercrepe
	name = "力量可丽饼"
	desc = "能力越大，可丽饼越大。它看起来像夹果酱的煎饼，但威力十足。"
	icon_state = "powercrepe"
	inhand_icon_state = "powercrepe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/cherryjelly = 5,
	)
	force = 30
	throwforce = 15
	block_chance = 55
	armour_penetration = 80
	block_sound = 'sound/items/weapons/parry.ogg'
	wound_bonus = -50
	attack_verb_continuous = list("拍打", "涂抹")
	attack_verb_simple = list("拍打", "涂抹")
	w_class = WEIGHT_CLASS_BULKY
	tastes = list("樱桃" = 1, "可丽饼" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.7)

/obj/item/food/branrequests
	name = "麸皮需求麦片"
	desc = "一种干麦片，能满足你对麸皮的需求。味道独特，像葡萄干加盐。"
	icon_state = "bran_requests"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/salt = 8,
	)
	tastes = list("麸皮" = 4, "葡萄干" = 3, "盐" = 1)
	foodtypes = SUGAR|GRAIN|FRUIT|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/butter
	name = "一条黄油"
	desc = "一条美味、金黄、油润的好东西。"
	icon_state = "butter"
	food_reagents = list(/datum/reagent/consumable/nutriment/fat = 6)
	tastes = list("黄油" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL
	dog_fashion = /datum/dog_fashion/head/butter
	var/can_stick = TRUE

/obj/item/food/butter/examine(mob/user)
	. = ..()
	if (can_stick)
		. += span_notice("如果你有根杆，就能做<b>棒上黄油</b>。")

/obj/item/food/butter/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stack/rods) || !can_stick)
		return NONE

	var/obj/item/stack/rods/rods = tool
	if(!rods.use(1))//borgs can still fail this if they have no metal
		to_chat(user, span_warning("你没有足够的铁来把 [src] 串到杆上！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把杆插进这条黄油里。"))
	user.temporarilyRemoveItemFromInventory(src)
	var/obj/item/food/butter/on_a_stick/new_item = new(drop_location())
	if (new_item.IsReachableBy(user))
		user.put_in_hands(new_item)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/food/butter/on_a_stick //there's something so special about putting it on a stick.
	name = "棒上黄油"
	desc = "串在杆上的美味、金黄、油润的好东西。"
	icon_state = "butteronastick"
	trash_type = /obj/item/stack/rods
	food_flags = FOOD_FINGER_FOOD
	venue_value = FOOD_PRICE_CHEAP
	can_stick = FALSE

/obj/item/food/butter/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/butterslice, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/butterslice
	name = "黄油片"
	desc = "一片黄油，满足你涂抹黄油的需求。"
	icon_state = "butterslice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("黄油" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/onionrings
	name = "洋葱圈"
	desc = "裹上面糊的洋葱片。"
	icon_state = "onionrings"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3)
	gender = PLURAL
	tastes = list("面糊" = 3, "洋葱" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/pineappleslice
	name = "菠萝片"
	desc = "一片多汁的菠萝。"
	icon_state = "pineapple_slice"
	tastes = list("菠萝" = 1)
	foodtypes = FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/pineappleslice/juice_typepath()
	return /datum/reagent/consumable/pineapplejuice

/obj/item/food/crab_rangoon
	name = "蟹角"
	desc = "它有很多名字，比如蟹肉泡芙、芝士馄饨、蟹肉饺？不管叫什么，都是一口绝妙的奶油芝士蟹味爆发。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "crabrangoon"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("奶油芝士" = 4, "蟹" = 3, "酥脆" = 2)
	foodtypes = MEAT | DAIRY | GRAIN
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/pesto
	name = "青酱"
	desc = "由硬质芝士、盐、香草、大蒜、油和松子混合而成。常用作意面或披萨的酱料，也可抹在面包上吃。"
	icon_state = "pesto"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("青酱" = 1)
	foodtypes = VEGETABLES | DAIRY | NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/tomato_sauce
	name = "番茄酱"
	desc = "番茄酱，配披萨或意面再合适不过。妈妈咪呀！"
	icon_state = "tomato_sauce"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("番茄" = 1, "香草" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/bechamel_sauce
	name = "白酱"
	desc = "一种经典的白色酱汁，常见于多个欧洲文化。"
	icon_state = "bechamel_sauce"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("奶油" = 1)
	foodtypes = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/roasted_bell_pepper
	name = "烤甜椒"
	desc = "一只烤得发黑起泡的甜椒。很适合做酱汁。"
	icon_state = "roasted_bell_pepper"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("甜椒" = 1, "焦香" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/pierogi
	name = "波兰饺子"
	desc = "用未发酵面团包裹咸味或甜味馅料，再放入沸水中煮成的饺子。这个是土豆洋葱馅的。"
	icon_state = "pierogi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("土豆" = 1, "洋葱" = 1)
	foodtypes = GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/stuffed_cabbage
	name = "卷心菜卷"
	desc = "肉末和米饭拌成的咸香馅料，裹在煮熟的卷心菜叶里，再浇上番茄酱。好吃得要命。"
	icon_state = "stuffed_cabbage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("多汁肉" = 1, "米饭" = 1, "卷心菜" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/seaweedsheet
	name = "海苔片"
	desc = "一片用于制作寿司的干海苔。把食材用在它上面即可开始制作自定义寿司！"
	icon_state = "seaweedsheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("海苔" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/seaweedsheet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, /obj/item/food/sushi/empty, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 6)

/obj/item/food/seaweedsheet/saltcane
	name = "干盐蔗叶"
	desc = "一片可用于制作寿司的干盐蔗叶。把食材用在它上面即可开始制作自定义寿司！"
	icon_state = "seaweedsheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("海苔" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/granola_bar
	name = "燕麦棒"
	desc = "燕麦、坚果、水果和巧克力混合干燥后压成的有嚼劲的棒。太空徒步时是极好的零食。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "granola_bar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("燕麦" = 1, "坚果" = 1, "巧克力" = 1, "葡萄干" = 1)
	foodtypes = GRAIN|NUTS|FRUIT|SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/onigiri
	name = "饭团"
	desc = "一团熟米饭包裹馅料，捏成三角形并用海苔包裹。还可以加馅料！"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "onigiri"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("米饭" = 1, "干海苔" = 1)
	foodtypes = VEGETABLES|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/onigiri/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, /obj/item/food/onigiri/empty, CUSTOM_INGREDIENT_ICON_NOCHANGE, max_ingredients = 4)

// empty onigiri for custom onigiri
/obj/item/food/onigiri/empty
	name = "饭团"
	desc = "一团熟米饭包裹馅料，捏成三角形并用海苔包裹。"
	icon_state = "onigiri"
	foodtypes = VEGETABLES|GRAIN
	tastes = list()

/obj/item/food/pacoca
	name = "帕索卡"
	desc = "一种传统的巴西甜点，由花生碎、糖和盐压成圆柱状。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "pacoca"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("花生" = 1, "甜味" = 1)
	foodtypes = NUTS | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/pickle
	name = "腌黄瓜"
	desc = "一根微微皱缩、颜色发暗的黄瓜。闻起来有点酸，却极其诱人。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "pickle"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/pickle = 1,
		/datum/reagent/medicine/antihol = 2,
	)
	tastes = list("腌黄瓜" = 1, "香料" = 1, "盐水" = 2)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/pickle/juice_typepath()
	return /datum/reagent/consumable/pickle

/obj/item/food/pickle/make_edible()
	. = ..()
	AddComponentFrom(SOURCE_EDIBLE_INNATE, /datum/component/edible, check_liked = CALLBACK(src, PROC_REF(check_liked)))

/obj/item/food/pickle/proc/check_liked(mob/living/carbon/human/consumer)
	var/obj/item/organ/liver/liver = consumer.get_organ_slot(ORGAN_SLOT_LIVER)
	if(!HAS_TRAIT(consumer, TRAIT_AGEUSIA) && liver && HAS_TRAIT(liver, TRAIT_CORONER_METABOLISM))
		return FOOD_LIKED

/obj/item/food/springroll
	name = "春卷"
	desc = "一盘用半透明米纸包裹新鲜蔬菜的春卷，配甜辣酱。你要么爱它，要么恨它。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "springroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("米纸" = 1, "香料" = 1, "爽脆蔬菜" = 1)
	foodtypes = GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cheese_pierogi
	name = "芝士波兰饺子"
	desc = "用未发酵面团包裹咸味或甜味馅料，再放入沸水中煮成的饺子。这个是土豆芝士馅的。"
	icon_state = "cheese_pierogi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("土豆" = 1, "芝士" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/meat_pierogi
	name = "肉馅波兰饺子"
	desc = "用未发酵面团包裹咸味或甜味馅料，再放入沸水中煮成的饺子。这个是土豆肉馅的。"
	icon_state = "meat_pierogi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("土豆" = 1, "芝士" = 1)
	foodtypes = GRAIN | VEGETABLES | MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/stuffed_eggplant
	name = "酿茄子"
	desc = "烤熟的半只茄子，内瓤挖出后与肉、芝士和蔬菜混合再填回。"
	icon_state = "stuffed_eggplant"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("熟茄子" = 5, "芝士" = 4, "肉末" = 3, "蔬菜" = 2)
	foodtypes = VEGETABLES | MEAT | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/moussaka
	name = "穆萨卡"
	desc = "一道分层的地中海菜肴，由茄子、混合蔬菜和肉做成，表面覆盖白酱。可切片"
	icon_state = "moussaka"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 30,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 20,
	)
	tastes = list("熟茄子" = 5, "土豆" = 1, "烤蔬菜" = 2, "肉" = 4, "白酱" = 3)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/moussaka/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/moussaka_slice, 4, 3 SECONDS, table_required = TRUE,  screentip_verb = "切")

/obj/item/food/moussaka_slice
	name = "穆萨卡切片"
	desc = "一道分层的地中海菜肴，由茄子、混合蔬菜和肉做成，表面覆盖白酱。美味极了！"
	icon_state = "moussaka_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
	)
	tastes = list("熟茄子" = 5, "土豆" = 1, "烤蔬菜" = 2, "肉" = 4, "白酱" = 3)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT / 4)

/obj/item/food/candied_pineapple
	name = "糖渍菠萝"
	desc = "一块裹上糖并干燥成有嚼劲零食的菠萝。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	icon_state = "candied_pineapple_1"
	base_icon_state = "candied_pineapple"
	tastes = list("糖" = 2, "有嚼劲的菠萝" = 4)
	foodtypes = SUGAR|FRUIT|PINEAPPLE
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/candied_pineapple/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 3)]"

/obj/item/food/raw_pita_bread
	name = "生皮塔饼"
	desc = "一张黏手的生皮塔饼圆片。"
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "raw_pita_bread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("面团" = 2)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_pita_bread/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/pita_bread, rand(15 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/raw_pita_bread/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pita_bread, rand(15 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/pita_bread
	name = "皮塔饼"
	desc = "一种源自地中海的多用途甜味薄饼。"
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "pita_bread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("皮塔饼" = 2)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/tzatziki_sauce
	name = "酸奶黄瓜酱"
	desc = "一种以大蒜为基底的酱汁或蘸料，广泛用于地中海与中东料理。搭配皮塔饼或蔬菜蘸着吃就已十分美味。"
	icon_state = "tzatziki_sauce"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("大蒜" = 4, "黄瓜" = 2, "橄榄油" = 2)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/tzatziki_and_pita_bread
	name = "酸奶黄瓜酱配皮塔饼"
	desc = "酸奶黄瓜酱，现在配上皮塔饼来蘸。健康与美味兼得。"
	icon_state = "tzatziki_and_pita_bread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("皮塔饼" = 4, "酸奶黄瓜酱" = 2, "橄榄油" = 2)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/grilled_beef_gyro
	name = "烤牛肉希腊卷"
	desc = "一道传统希腊菜，把肉和番茄、卷心菜、洋葱、酸奶黄瓜酱一起裹进皮塔饼。"
	icon_state = "grilled_beef_gyro"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("皮塔饼" = 4, "嫩肉" = 2, "酸奶黄瓜酱" = 2, "混合蔬菜" = 2)
	foodtypes = VEGETABLES | GRAIN | MEAT
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/vegetarian_gyro
	name = "素食希腊卷"
	desc = "一道传统希腊卷，用黄瓜替代了肉。风味依旧浓郁，营养也很丰富。"
	icon_state = "vegetarian_gyro"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 12,
	)
	tastes = list("皮塔饼" = 4, "黄瓜" = 2, "酸奶黄瓜酱" = 2, "混合蔬菜" = 2)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_4

///Extracted from squids, or any fish with the ink fish trait.
/obj/item/food/ink_sac
	name = "墨囊"
	desc = "来自某种鱼或软体动物的墨囊。可以用加工机做成罐头。"
	icon_state = "ink_sac"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/salt = 5)
	tastes = list("海鲜" = 3)
	foodtypes = SEAFOOD|RAW

/obj/item/food/ink_sac/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/splat, \
		memory_type = /datum/memory/witnessed_inking, \
		smudge_type = /obj/effect/decal/cleanable/food/squid_ink, \
		moodlet_type = /datum/mood_event/inked, \
		splat_color = COLOR_NEARLY_ALL_BLACK, \
		hit_callback = CALLBACK(src, PROC_REF(blind_em)), \
	)

/obj/item/food/ink_sac/proc/blind_em(mob/living/victim, can_splat_on)
	if(can_splat_on)
		victim.adjust_temp_blindness_up_to(2.5 SECONDS, 3 SECONDS)
		victim.adjust_confusion_up_to(2.5 SECONDS, 3 SECONDS)
	victim.visible_message(span_warning("[victim] 被 [src] 喷了一身墨！"), span_userdanger("你被 [src] 喷了一身墨！"))
	playsound(victim, SFX_DESECRATION, 50, TRUE)
