// Pre-packaged meals, canned, wrapped, and vended

// Cans
/obj/item/food/canned
	name = "罐装空气"
	desc = "如果你曾好奇空气是从哪来的……"
	food_reagents = list(
		/datum/reagent/oxygen = 6,
		/datum/reagent/nitrogen = 24,
	)
	icon = 'icons/obj/food/canned.dmi'
	icon_state = "peachcan"
	food_flags = FOOD_IN_CONTAINER
	w_class = WEIGHT_CLASS_NORMAL
	max_volume = 30
	w_class = WEIGHT_CLASS_SMALL
	preserved_food = TRUE

/obj/item/food/canned/make_germ_sensitive(mapload)
	return // It's in a can

/obj/item/food/canned/proc/open_can(mob/user)
	to_chat(user, span_notice("你拉开了[src]的拉环。"))
	playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)
	reagents.flags |= OPENCONTAINER
	preserved_food = FALSE

/obj/item/food/canned/attack_self(mob/user)
	if(!is_drainable())
		open_can(user)
		icon_state = "[icon_state]_open"
	return ..()

/obj/item/food/canned/attack(mob/living/target, mob/user, def_zone)
	if (!is_drainable())
		to_chat(user, span_warning("[src]的盖子还没打开！"))
		return FALSE
	return ..()

/obj/item/food/canned/beans
	name = "一罐豆子"
	desc = "会唱歌的豆子，装在一个没那么会唱歌的容器里。"
	icon_state = "beans"
	trash_type = /obj/item/trash/can/food/beans
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/ketchup = 4,
	)
	tastes = list("beans" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/canned/peaches
	name = "罐装桃子"
	desc = "一罐不错的熟桃子，泡在自己的汁水里。"
	icon_state = "peachcan"
	trash_type = /obj/item/trash/can/food/peaches
	food_reagents = list(
		/datum/reagent/consumable/peachjuice = 20,
		/datum/reagent/consumable/sugar = 8,
		/datum/reagent/consumable/nutriment = 2,
	)
	tastes = list("peaches" = 7, "tin" = 1)
	foodtypes = FRUIT | SUGAR

/obj/item/food/canned/peaches/maint
	name = "维修通道桃子"
	desc = "我有一张嘴，我必须进食。"
	icon_state = "peachcanmaint"
	trash_type = /obj/item/trash/can/food/peaches/maint
	tastes = list("peaches" = 1, "tin" = 7)
	venue_value = FOOD_PRICE_EXOTIC

/obj/item/food/canned/tomatoes
	name = "罐装圣马扎诺番茄"
	desc = "一罐优质圣马扎诺番茄，来自意大利南部的丘陵。"
	icon_state = "tomatoescan"
	trash_type = /obj/item/trash/can/food/tomatoes
	food_reagents = list(
		/datum/reagent/consumable/tomatojuice = 20,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("tomato" = 7, "tin" = 1)
	foodtypes = VEGETABLES //fuck you, real life!

/obj/item/food/canned/pine_nuts
	name = "罐装松子"
	desc = "一小罐松子。如果你喜欢，也可以直接吃。"
	icon_state = "pinenutscan"
	trash_type = /obj/item/trash/can/food/pine_nuts
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("pine nuts" = 1)
	foodtypes = NUTS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/canned/envirochow
	name = "狗咬狗环保粮"
	desc = "首款完全可持续的宠物食品，采用古老的英国畜牧技术制成。"
	icon_state = "envirochow"
	trash_type = /obj/item/trash/can/food/envirochow
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("dog food" = 5, "狗肉" = 3)
	foodtypes = MEAT | GROSS
	crafting_complexity = FOOD_COMPLEXITY_1
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/canned/envirochow/attack_animal(mob/living/simple_animal/user, list/modifiers)
	if(!check_buffability(user))
		return ..()
	apply_buff(user)

/obj/item/food/canned/envirochow/attack_basic_mob(mob/living/basic/user, list/modifiers)
	if(!check_buffability(user))
		return ..()
	apply_buff(user)
	return TRUE

/obj/item/food/canned/envirochow/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!check_buffability(interacting_with))
		return NONE
	apply_buff(interacting_with, user)
	return ITEM_INTERACT_SUCCESS

///This proc checks if the mob is able to receive the buff.
/obj/item/food/canned/envirochow/proc/check_buffability(mob/living/hungry_pet)
	if(!isanimal_or_basicmob(hungry_pet)) // Not a pet
		return FALSE
	if(!is_drainable()) // Can is not open
		return FALSE
	if(IS_UNCONSCIOUS_OR_CRIT(hungry_pet)) // Parrot deceased
		return FALSE
	if(hungry_pet.mob_biotypes & (MOB_BEAST|MOB_REPTILE|MOB_BUG))
		return TRUE
	else
		return FALSE // Humans, robots & spooky ghosts not allowed

///This makes the animal eat the food, and applies the buff status effect to them.
/obj/item/food/canned/envirochow/proc/apply_buff(mob/living/simple_animal/hungry_pet, mob/living/dog_mom)
	hungry_pet.apply_status_effect(/datum/status_effect/limited_buff/health_buff) //the status effect keeps track of the stacks
	hungry_pet.visible_message(
		span_notice("[hungry_pet]大口吃起了[src]。"),
		span_nicegreen("你大口吃起了[src]。"),
		span_notice("你听到吧唧吧唧的进食声。"))
	SEND_SIGNAL(src, COMSIG_FOOD_CONSUMED, hungry_pet, dog_mom ? dog_mom : hungry_pet) //If there is no dog mom, we assume the pet fed itself.
	playsound(loc, 'sound/items/eatfood.ogg', rand(30, 50), TRUE)
	qdel(src)

/obj/item/food/canned/squid_ink
	name = "罐装鱿鱼墨"
	desc = "在寻常烹饪中算是古怪的食材，鱿鱼墨能为任何菜肴增添海的味道——同时在这个过程中把它染成乌黑。"
	icon_state = "squidinkcan"
	trash_type = /obj/item/trash/can/food/squid_ink
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/salt = 5)
	tastes = list("seafood" = 7, "tin" = 1)
	foodtypes = SEAFOOD

/obj/item/food/canned/squid_ink/open_can(mob/user)
	. = ..()
	AddComponent(/datum/component/splat, \
		memory_type = /datum/memory/witnessed_inking, \
		smudge_type = /obj/effect/decal/cleanable/food/squid_ink, \
		moodlet_type = /datum/mood_event/inked, \
		splat_color = COLOR_NEARLY_ALL_BLACK, \
		hit_callback = CALLBACK(src, PROC_REF(blind_em)), \
	)

/obj/item/food/canned/squid_ink/proc/blind_em(mob/living/victim, can_splat_on)
	if(can_splat_on)
		victim.adjust_temp_blindness_up_to(2.5 SECONDS, 3 SECONDS)
		victim.adjust_confusion_up_to(2.5 SECONDS, 3 SECONDS)
	victim.visible_message(span_warning("[victim]被[src]喷了一身墨！"), span_userdanger("你被[src]喷了一身墨！"))
	playsound(victim, SFX_DESECRATION, 50, TRUE)

/obj/item/food/canned/chap
	name = "一罐 CHAP"
	desc = "CHAP：碎火腿与猪肉。这款经典的美国罐装肉制品赢得了一场世界大战，然后把数百万军人送回家时附赠了心脏淤塞。"
	icon_state = "chapcan"
	trash_type = /obj/item/trash/can/food/chap
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/salt = 5)
	tastes = list("meat" = 7, "tin" = 1)
	foodtypes = MEAT

/obj/item/food/canned/chap/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/chapslice, 5, 3 SECONDS, table_required = TRUE, screentip_verb = "切开")

/obj/item/food/chapslice
	name = "一片 CHAP"
	desc = "一片薄薄的 CHAP。适合煎炸或做三明治。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chapslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	tastes = list("meat" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/chapslice/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/grilled_chapslice, rand(20 SECONDS, 40 SECONDS), TRUE, TRUE)

/obj/item/food/grilled_chapslice
	name = "烤 CHAP 片"
	desc = "一片油腻滚烫的 CHAP。是均衡饮食的重要组成部分。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chapslice_grilled"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	tastes = list("meat" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL

// DONK DINNER: THE INNOVATIVE WAY TO GET YOUR DAILY RECOMMENDED ALLOWANCE OF SALT... AND THEN SOME!
/obj/item/food/ready_donk
	name = "\improper 咚克即食餐：单身汉餐"
	desc = "一份快捷的咚克晚餐：现在有味道了！"
	icon_state = "ready_donk_bachelor"
	trash_type = /obj/item/trash/ready_donk
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("food?" = 2, "laziness" = 1)
	foodtypes = MEAT | JUNKFOOD
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

	/// What type of ready-donk are we warmed into?
	var/warm_type = /obj/item/food/ready_donk/warm

	/// What reagents should be added when this item is warmed?
	var/static/list/added_reagents = list(/datum/reagent/medicine/omnizine = 3)

/obj/item/food/ready_donk/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE, added_reagents)

/obj/item/food/ready_donk/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, added_reagents)

/obj/item/food/ready_donk/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览着包装盒背面……</i>")
	. += "\t[span_info("咚克即食餐：咚克公司产品。")]"
	. += "\t[span_info("加热说明：打开包装盒并刺破封膜，放入微波炉高火加热 2 分钟。食用前静置 60 秒。产品会很烫。")]"
	. += "\t[span_info("每 200 克含：钠 8 克；脂肪 25 克，其中饱和脂肪 22 克；糖 2 克。")]"
	return .

/obj/item/food/ready_donk/warm
	name = "温热的咚克即食餐：单身汉餐"
	desc = "一份快捷的咚克晚餐，现在有味道了！而且还是热的！"
	icon_state = "ready_donk_bachelor_warm"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/medicine/omnizine = 3,
	)
	tastes = list("food?" = 2, "laziness" = 1)

	// Don't burn your warn ready donks.
	warm_type = /obj/item/food/badrecipe

/obj/item/food/ready_donk/mac_n_cheese
	name = "\improper 咚克即食餐：咚克意面"
	desc = "几秒钟就能吃到的霓虹橙色芝士通心粉！"
	icon_state = "ready_donk_mac"
	tastes = list("cheesy pasta" = 2, "laziness" = 1)
	foodtypes = GRAIN | DAIRY | JUNKFOOD

	warm_type = /obj/item/food/ready_donk/warm/mac_n_cheese

/obj/item/food/ready_donk/warm/mac_n_cheese
	name = "温热的咚克即食餐：咚克意面"
	desc = "霓虹橙色芝士通心粉，即开即食！"
	icon_state = "ready_donk_mac_warm"
	tastes = list("cheesy pasta" = 2, "laziness" = 1)
	foodtypes = GRAIN | DAIRY | JUNKFOOD

/obj/item/food/ready_donk/donkhiladas
	name = "\improper 咚克即食餐：咚克玉米卷饼"
	desc = "咚克公司的招牌咚克玉米卷饼，配咚克酱，带来“正宗”的墨西哥风味。"
	icon_state = "ready_donk_mex"
	tastes = list("enchiladas" = 2, "laziness" = 1)
	foodtypes = GRAIN | DAIRY | MEAT | VEGETABLES | JUNKFOOD

	warm_type = /obj/item/food/ready_donk/warm/donkhiladas

/obj/item/food/ready_donk/warm/donkhiladas
	name = "温热的咚克即食餐：咚克玉米卷饼"
	desc = "咚克公司的招牌咚克玉米卷饼，配咚克酱，热得像墨西哥的太阳。"
	icon_state = "ready_donk_mex_warm"
	tastes = list("enchiladas" = 2, "laziness" = 1)
	foodtypes = GRAIN | DAIRY | MEAT | VEGETABLES | JUNKFOOD

/obj/item/food/ready_donk/nachos_grandes //which translates to... big nachos
	name = "\improper 咚克即食餐：咚克太阳系列博里托斯玉米片（大份）"
	desc = "用咚克经典的玉米片大份装为比赛日做好准备，它可是咚克太阳系列赛的赞助商！博里托斯玉米片堆满芝士、香辣肉和豆子，另附鳄梨酱、皮科酱和咚克酱。准备开球！"
	icon_state = "ready_donk_nachos"
	tastes = list("nachos" = 2, "laziness" = 1)
	foodtypes = GRAIN | DAIRY | MEAT | VEGETABLES | JUNKFOOD

	warm_type = /obj/item/food/ready_donk/warm/nachos_grandes

/obj/item/food/ready_donk/warm/nachos_grandes
	name = "温热的咚克即食餐：咚克太阳系列博里托斯玉米片（大份）"
	desc = "用咚克经典的玉米片大份装为比赛日做好准备，它可是咚克太阳系列赛的赞助商！博里托斯玉米片堆满芝士、香辣肉和豆子，另附鳄梨酱、皮科酱和咚克酱。上桌时比坂本的快球还烫！"
	icon_state = "ready_donk_nachos_warm"
	tastes = list("nachos" = 2, "laziness" = 1)
	foodtypes = GRAIN | DAIRY | MEAT | VEGETABLES | JUNKFOOD

/obj/item/food/ready_donk/donkrange_chicken
	name = "\improper 咚克即食餐：咚克散养鸡"
	desc = "一道中式经典，咚克原味香辣橙汁鸡，配爆炒辣椒与洋葱，浇在蒸米饭上。"
	icon_state = "ready_donk_orange"
	tastes = list("orange chicken" = 2, "laziness" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES | JUNKFOOD

	warm_type = /obj/item/food/ready_donk/warm/donkrange_chicken

/obj/item/food/ready_donk/warm/donkrange_chicken
	name = "温热的咚克即食餐：咚克散养鸡"
	desc = "一道中式经典，咚克原味香辣橙汁鸡，配爆炒辣椒与洋葱，浇在蒸米饭上，上桌时比龙的吐息还烫。"
	icon_state = "ready_donk_orange_warm"
	tastes = list("orange chicken" = 2, "laziness" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES | JUNKFOOD

/obj/item/food/ready_donk/salisbury_steak
	name = "\improper 咚克即食餐咚克原味系列：索尔兹伯里牛排"
	desc = "原版之最：一大块压制成型的牛肉，浇满棕色肉汁，配一份土豆泥。最好找台电视边看边吃。"
	icon_state = "ready_donk_salisbury"
	tastes = list("salisbury steak" = 2, "laziness" = 1)
	foodtypes = MEAT | VEGETABLES | JUNKFOOD

	warm_type = /obj/item/food/ready_donk/warm/salisbury_steak

/obj/item/food/ready_donk/warm/salisbury_steak
	name = "温热的咚克即食餐咚克原味系列：索尔兹伯里牛排"
	desc = "原版之最：一大块压制成型的牛肉，浇满棕色肉汁，配一份土豆泥。它几乎和季终集一样火热。"
	icon_state = "ready_donk_salisbury_warm"
	tastes = list("salisbury steak" = 2, "laziness" = 1)
	foodtypes = MEAT | VEGETABLES | JUNKFOOD

/obj/item/food/ready_donk/country_chicken
	name = "\improper 咚克即食餐咚克原味系列：乡村炸鸡"
	desc = "电视晚餐经典之作：“酥脆”炸鸡配乡村肉汁、土豆泥和青豆。"
	icon_state = "ready_donk_chicken"
	tastes = list("country-fried chicken" = 2, "laziness" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES | JUNKFOOD

	warm_type = /obj/item/food/ready_donk/warm/country_chicken

/obj/item/food/ready_donk/warm/country_chicken
	name = "温热的咚克即食餐咚克原味系列：乡村炸鸡"
	desc = "电视晚餐经典之作：“酥脆”炸鸡配乡村肉汁、土豆泥和青豆。趁热吃！"
	icon_state = "ready_donk_chicken_warm"
	tastes = list("country-fried chicken" = 2, "laziness" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES | JUNKFOOD

// Rations
/obj/item/food/rationpack
	name = "口粮包"
	desc = "一块方形棒状物，可惜<i>看起来</i>像巧克力，装在毫无特色的灰色包装里。它曾救过士兵的命——通常是靠挡子弹。"
	icon_state = "rationpack"
	bite_consumption = 3
	junkiness = 15
	tastes = list("cardboard" = 3, "sadness" = 3)
	foodtypes = null //Don't ask what went into them. You're better off not knowing.
	food_reagents = list(
		/datum/reagent/consumable/nutriment/stabilized = 10,
		/datum/reagent/consumable/nutriment = 2,
	) //Won't make you fat. Will make you question your sanity.

///Override for checkliked callback
/obj/item/food/rationpack/make_edible()
	. = ..()
	AddComponentFrom(SOURCE_EDIBLE_INNATE, /datum/component/edible, check_liked = CALLBACK(src, PROC_REF(check_liked)))

/obj/item/food/rationpack/proc/check_liked(mob/mob) //Nobody likes rationpacks. Nobody.
	return FOOD_DISLIKED
