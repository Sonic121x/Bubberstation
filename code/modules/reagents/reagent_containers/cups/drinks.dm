////////////////////////////////////////////////////////////////////////////////
/// Drinks.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_containers/cup/glass
	name = "饮料"
	desc = "真好喝"
	icon = 'icons/obj/drinks/drinks.dmi'
	icon_state = "glass_empty"
	abstract_type = /obj/item/reagent_containers/cup/glass
	possible_transfer_amounts = list(5,10,15,20,25,30,50)
	resistance_flags = NONE

	isGlass = TRUE
	attack_verb_continuous = list("砸碎", "猛击")
	attack_verb_simple = list("砸碎", "猛击")

/obj/item/reagent_containers/cup/glass/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum, do_splash = TRUE)
	. = ..()
	if(!.) //if the bottle wasn't caught
		smash(hit_atom, throwingdatum?.get_thrower(), throwingdatum)

/obj/item/reagent_containers/cup/glass/proc/smash(atom/target, atom/thrower, datum/thrownthing/throwingdatum, break_top = FALSE)
	if(!isGlass)
		return FALSE
	if(QDELING(src) || !target) //Invalid loc
		return FALSE
	if(ismob(thrower) && bartender_check(target, thrower) && throwingdatum)
		return FALSE
	var/splash_target = QDELETED(target) ? target.drop_location() : target
	var/splash_thrower = ismob(thrower) ? thrower : null
	splash_reagents(splash_target, splash_thrower, allow_closed_splash = TRUE)
	var/obj/item/broken_bottle/broken = new (loc)
	broken.mimic_broken(src, target, break_top)
	post_smash(target, thrower, throwingdatum, broken)
	qdel(src)
	target.Bumped(broken) //BUBBERSTATION CHANGE: RETURNS THE BROKEN BOTTLE.
	return broken //BUBBERSTATION CHANGE: RETURNS THE BROKEN BOTTLE.

/obj/item/reagent_containers/cup/glass/proc/post_smash(atom/target, atom/thrower, datum/thrownthing/throwingdatum, obj/item/broken_bottle/broken)
	return

/obj/item/reagent_containers/cup/glass/bullet_act(obj/projectile/proj)
	. = ..()
	if(QDELETED(src))
		return
	if(proj.damage > 0 && proj.damage_type == BRUTE)
		var/atom/T = get_turf(src)
		smash(T)


/obj/item/reagent_containers/cup/glass/trophy
	name = "锡杯"
	desc = "人人都有奖杯。"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "pewter_cup"
	w_class = WEIGHT_CLASS_TINY
	force = 1
	throwforce = 1
	amount_per_transfer_from_this = 5
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT)
	has_variable_transfer_amount = FALSE
	volume = 5
	obj_flags = CONDUCTS_ELECTRICITY
	resistance_flags = FIRE_PROOF
	isGlass = FALSE

/obj/item/reagent_containers/cup/glass/trophy/gold_cup
	name = "金杯"
	desc = "你是赢家！"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "golden_cup"
	inhand_icon_state = "golden_cup"
	w_class = WEIGHT_CLASS_BULKY
	force = 14
	throwforce = 10
	amount_per_transfer_from_this = 20
	custom_materials = list(/datum/material/gold=HALF_SHEET_MATERIAL_AMOUNT)
	volume = 150

/obj/item/reagent_containers/cup/glass/trophy/gold_cup/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item) //closed handles

/obj/item/reagent_containers/cup/glass/trophy/silver_cup
	name = "银杯"
	desc = "最佳输家！"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "silver_cup"
	w_class = WEIGHT_CLASS_NORMAL
	force = 10
	throwforce = 8
	amount_per_transfer_from_this = 15
	custom_materials = list(/datum/material/silver=SMALL_MATERIAL_AMOUNT*8)
	volume = 100

/obj/item/reagent_containers/cup/glass/trophy/silver_cup/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item) //closed handle

/obj/item/reagent_containers/cup/glass/trophy/bronze_cup
	name = "铜杯"
	desc = "好歹你上榜了！"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "bronze_cup"
	w_class = WEIGHT_CLASS_SMALL
	force = 5
	throwforce = 4
	amount_per_transfer_from_this = 10
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT * 4)
	volume = 25

///////////////////////////////////////////////Drinks
//Notes by Darem: Drinks are simply containers that start preloaded. Unlike condiments, the contents can be ingested directly
// rather then having to add it to something else first. They should only contain liquids. They have a default container size of 50.
// Formatting is the same as food.

/obj/item/reagent_containers/cup/glass/coffee
	name = "强劲咖啡"
	desc = "小心，你即将享用的饮料非常烫。"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "coffee"
	base_icon_state = "coffee"
	list_reagents = list(/datum/reagent/consumable/coffee = 30)
	resistance_flags = FREEZE_PROOF
	isGlass = FALSE
	drink_type = BREAKFAST

	/// Is our lid currently removed?
	var/lid_open = FALSE

/obj/item/reagent_containers/cup/glass/coffee/no_lid
	icon_state = "coffee_empty"
	list_reagents = null
	lid_open = TRUE

/obj/item/reagent_containers/cup/glass/coffee/examine(mob/user)
	. = ..()
	. += span_notice("按住 Alt 点击可开合杯盖。")
	return

/obj/item/reagent_containers/cup/glass/coffee/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_LMB] = "[lid_open ? "盖上" : "取下"]杯盖"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/reagent_containers/cup/glass/coffee/click_alt(mob/user)
	lid_open = !lid_open
	update_icon_state()
	return CLICK_ACTION_SUCCESS

/obj/item/reagent_containers/cup/glass/coffee/update_icon_state()
	if(lid_open)
		icon_state = reagents.total_volume ? "[base_icon_state]_full" : "[base_icon_state]_empty"
	else
		icon_state = base_icon_state
	return ..()

/obj/item/reagent_containers/cup/glass/ice
	name = "冰杯"
	desc = "小心，冰很凉，别咬。"
	custom_price = PAYCHECK_LOWER * 0.6
	icon_state = "icecup"
	list_reagents = list(/datum/reagent/consumable/ice = 30)
	isGlass = FALSE

/obj/item/reagent_containers/cup/glass/ice/prison
	name = "脏冰杯"
	desc = "要么是纳米传讯的供水被污染了，要么这台机器真的在卖柠檬、巧克力和樱桃味的雪泥。"
	list_reagents = list(/datum/reagent/consumable/ice = 25, /datum/reagent/consumable/liquidgibs = 5)

/obj/item/reagent_containers/cup/glass/mug // parent type is literally just so empty mug sprites are a thing
	name = "马克杯"
	desc = "用有格调的马克杯装着的饮品。"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "tea_empty"
	base_icon_state = "tea"
	inhand_icon_state = "coffee"

/obj/item/reagent_containers/cup/glass/mug/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item)

/obj/item/reagent_containers/cup/glass/mug/update_icon_state()
	icon_state = "[base_icon_state][reagents.total_volume ? null : "_empty"]"
	return ..()

/obj/item/reagent_containers/cup/glass/mug/tea
	name = "紫公爵茶"
	desc = "侮辱紫公爵就是侮辱太空女王！谁敢糟蹋这杯茶，任何体面的绅士都会与你决斗。"
	icon_state = "tea"
	list_reagents = list(/datum/reagent/consumable/tea = 30)

/obj/item/reagent_containers/cup/glass/mug/coco
	name = "荷兰热可可"
	desc = "产自太空南美洲。"
	icon_state = "tea"
	list_reagents = list(/datum/reagent/consumable/hot_coco = 15, /datum/reagent/consumable/sugar = 5)
	drink_type = SUGAR
	resistance_flags = FREEZE_PROOF
	custom_price = PAYCHECK_CREW * 1.2

/obj/item/reagent_containers/cup/glass/mug/nanotrasen
	name = "\improper 纳米传讯马克杯"
	desc = "用来彰显你对公司自豪感的马克杯。"
	icon_state = "mug_nt_empty"
	base_icon_state = "mug_nt"

/obj/item/reagent_containers/cup/glass/coffee_cup
	name = "咖啡杯"
	desc = "一种热成型塑料咖啡杯。理论上也能用来装其他热饮，如果你敢于冒险的话。"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "coffee_cup_e"
	base_icon_state = "coffee_cup"
	possible_transfer_amounts = list(10)
	volume = 30
	isGlass = FALSE

/obj/item/reagent_containers/cup/glass/coffee_cup/update_icon_state()
	icon_state = reagents.total_volume ? base_icon_state : "[base_icon_state]_e"
	return ..()

/obj/item/reagent_containers/cup/glass/dry_ramen
	name = "杯装拉面"
	desc = "只需加入 5 毫升水，自动加热！这味道让你想起学生时代。全新咸香口味！"
	icon_state = "ramen"
	list_reagents = list(/datum/reagent/consumable/dry_ramen = 15, /datum/reagent/consumable/salt = 3)
	drink_type = GRAIN
	isGlass = FALSE
	custom_price = PAYCHECK_CREW * 0.9

/obj/item/reagent_containers/cup/glass/waterbottle
	name = "瓶装水"
	desc = "一瓶在古老地球灌装厂灌装的水。"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "smallbottle"
	inhand_icon_state = null
	list_reagents = list(/datum/reagent/water = 49.5, /datum/reagent/fluorine = 0.5)//see desc, don't think about it too hard
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)
	volume = 50
	amount_per_transfer_from_this = 10
	fill_icon_thresholds = list(0, 10, 25, 50, 75, 80, 90)
	isGlass = FALSE
	// The 2 bottles have separate cap overlay icons because if the bottle falls over while bottle flipping the cap stays fucked on the moved overlay
	var/cap_icon = 'icons/obj/drinks/drink_effects.dmi'
	var/cap_icon_state = "bottle_cap_small"
	var/start_capped = TRUE
	var/cap_lost = FALSE
	var/mutable_appearance/cap_overlay
	var/flip_chance = 10
	custom_price = PAYCHECK_LOWER * 0.8
	reagent_container_liquid_sound = SFX_PLASTIC_BOTTLE_LIQUID_SLOSH

/obj/item/reagent_containers/cup/glass/waterbottle/Initialize(mapload)
	cap_overlay = mutable_appearance(cap_icon, cap_icon_state)
	. = ..()
	if(start_capped)
		// this is not done via initial_reagent_flags because it represents state
		update_container_flags(SEALED_CONTAINER | TRANSPARENT)
		update_appearance()

/obj/item/reagent_containers/cup/glass/waterbottle/update_overlays()
	. = ..()
	if(!is_open_container())
		. += cap_overlay

/obj/item/reagent_containers/cup/glass/waterbottle/examine(mob/user)
	. = ..()
	if(cap_lost)
		. += span_notice("瓶盖似乎不见了。")
	else if(!is_open_container())
		. += span_notice("瓶盖紧紧盖着以防洒出。按住 Alt 点击可取下瓶盖。")
	else
		. += span_notice("瓶盖已取下。按住 Alt 点击可盖上瓶盖。")

/obj/item/reagent_containers/cup/glass/waterbottle/click_alt(mob/user)
	if(cap_lost)
		to_chat(user, span_warning("瓶盖似乎不见了！它跑哪去了？"))
		return CLICK_ACTION_BLOCKING

	var/fumbled = HAS_TRAIT(user, TRAIT_CLUMSY) && prob(5)
	if(!is_open_container() || fumbled)
		reset_container_flags()
		animate(src, transform = null, time = 2, loop = 0)
		if(fumbled)
			to_chat(user, span_warning("你手忙脚乱地摆弄 [src] 的瓶盖！瓶盖掉到地上，然后就这么消失了。它到底去哪了？"))
			cap_lost = TRUE
		else
			to_chat(user, span_notice("你取下了 [src] 的瓶盖。"))
			playsound(loc, 'sound/items/handling/reagent_containers/plastic_bottle/bottle_cap_open.ogg', 50, TRUE)
	else
		update_container_flags(SEALED_CONTAINER | TRANSPARENT)
		to_chat(user, span_notice("你给 [src] 盖上了瓶盖。"))
		playsound(loc, 'sound/items/handling/reagent_containers/plastic_bottle/bottle_cap_close.ogg', 50, TRUE)
	update_appearance()
	return CLICK_ACTION_SUCCESS

// heehoo bottle flipping
/obj/item/reagent_containers/cup/glass/waterbottle/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(QDELETED(src))
		return
	if(is_open_container() || !reagents.total_volume)
		return
	if(prob(flip_chance)) // landed upright
		src.visible_message(span_notice("[src] 直立着地！"))
		var/mob/living/thrower = throwingdatum?.get_thrower()
		if(istype(thrower))
			thrower.add_mood_event("bottle_flip", /datum/mood_event/bottle_flip)
	else // landed on its side
		animate(src, transform = matrix(prob(50)? 90 : -90, MATRIX_ROTATE), time = 3, loop = 0)

/obj/item/reagent_containers/cup/glass/waterbottle/pickup(mob/user)
	. = ..()
	animate(src, transform = null, time = 1, loop = 0)

/obj/item/reagent_containers/cup/glass/waterbottle/empty
	list_reagents = list()
	start_capped = FALSE

/obj/item/reagent_containers/cup/glass/waterbottle/large
	desc = "一瓶新鲜的商用大瓶装水。"
	icon_state = "largebottle"
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3)
	list_reagents = list(/datum/reagent/water = 100)
	volume = 100
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100)
	cap_icon_state = "bottle_cap"

/obj/item/reagent_containers/cup/glass/waterbottle/large/empty
	list_reagents = list()
	start_capped = FALSE

// Admin spawn
/obj/item/reagent_containers/cup/glass/waterbottle/relic
	name = "神秘瓶子"
	desc = "一个和水瓶很相似的瓶子，不过上面用马克笔涂写了一些字。它似乎散发着某种能量。"
	flip_chance = 100 // FLIPP

/obj/item/reagent_containers/cup/glass/waterbottle/relic/Initialize(mapload)
	var/reagent_id = get_random_reagent_id()
	var/datum/reagent/random_reagent = new reagent_id
	list_reagents = list(random_reagent.type = 50)
	. = ..()
	desc += span_notice("上面写着“[random_reagent.name]”。")
	update_appearance()


/obj/item/reagent_containers/cup/glass/sillycup
	name = "纸杯"
	desc = "一个纸质水杯。"
	icon_state = "water_cup_e"
	possible_transfer_amounts = list(10)
	volume = 10
	isGlass = FALSE
	custom_materials = list(/datum/material/paper = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/reagent_containers/cup/glass/sillycup/update_icon_state()
	icon_state = reagents.total_volume ? "water_cup" : "water_cup_e"
	return ..()

/obj/item/reagent_containers/cup/glass/bottle/juice/smallcarton
	name = "小纸盒"
	desc = "一个小纸盒，用来装饮料。"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "juicebox"
	volume = 15
	drink_type = NONE
	custom_materials = list(/datum/material/cardboard = SHEET_MATERIAL_AMOUNT)

/obj/item/reagent_containers/cup/glass/bottle/juice/smallcarton/Initialize(mapload, vol)
	. = ..()
	AddComponent( \
		/datum/component/takes_reagent_appearance, \
		on_icon_changed = CALLBACK(src, PROC_REF(on_cup_change)), \
		on_icon_reset = CALLBACK(src, PROC_REF(on_cup_reset)), \
		base_container_type = /obj/item/reagent_containers/cup/glass/bottle/juice/smallcarton, \
	)

/obj/item/reagent_containers/cup/glass/colocup
	name = "科洛杯"
	desc = "一种廉价量产的杯子，常见于各种派对。出于某种原因，它们似乎从来不会变成红色……"
	icon = 'icons/obj/drinks/colo.dmi'
	icon_state = "colocup"
	inhand_icon_state = "colocup"
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)
	possible_transfer_amounts = list(5, 10, 15, 20)
	volume = 20
	amount_per_transfer_from_this = 5
	isGlass = FALSE
	/// Allows the lean sprite to display upon crafting
	var/random_sprite = TRUE

/obj/item/reagent_containers/cup/glass/colocup/Initialize(mapload)
	. = ..()
	pixel_x = rand(-4,4)
	pixel_y = rand(-4,4)
	if(!random_sprite)
		return
	icon_state = "colocup[rand(0, 6)]"
	if(icon_state == "colocup6")
		desc = "一种廉价量产的杯子，常见于各种派对。哇，这一个居然是红色的！什么鬼？"

/obj/item/reagent_containers/cup/glass/colocup/lean
	name = "紫水"
	desc = "一杯那种紫色饮料，就是让你嗨成“嗨宝”的玩意儿。"
	icon_state = "lean"
	list_reagents = list(/datum/reagent/consumable/lean = 20)
	random_sprite = FALSE

//////////////////////////drinkingglass and shaker//
//Note by Darem: This code handles the mixing of drinks. New drinks go in three places: In Chemistry-Reagents.dm (for the drink
// itself), in Chemistry-Recipes.dm (for the reaction that changes the components into the drink), and here (for the drinking glass
// icon states.


/obj/item/reagent_containers/cup/glass/shaker
	name = "摇壶"
	desc = "用来调酒的金属摇壶。"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "shaker"
	custom_materials = list(/datum/material/iron= HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	amount_per_transfer_from_this = 10
	volume = 100
	isGlass = FALSE
	interaction_flags_click = NEED_HANDS|FORBID_TELEKINESIS_REACH
	/// Whether or not poured drinks should use custom names and descriptions
	var/using_custom_drinks = FALSE
	/// Name custom drinks will have
	var/custom_drink_name = "自定义饮品"
	/// Description custom drinks will have
	var/custom_drink_desc = "由你最喜欢的调酒师调制！"

/obj/item/reagent_containers/cup/glass/shaker/Initialize(mapload)
	. = ..()
	if(prob(10))
		name = "\improper 纳米传讯二十周年纪念摇壶"
		desc += " 上面印着醒目的纳米传讯标志。"
		icon_state = "shaker_n"

/obj/item/reagent_containers/cup/glass/shaker/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_LMB] = "[using_custom_drinks ? "禁用" : "启用"]自定义饮品"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/reagent_containers/cup/glass/shaker/examine(mob/user)
	. = ..()
	. += span_notice("按住 Alt 点击可[using_custom_drinks ? "禁用" : "启用"]自定义饮品命名")
	if(using_custom_drinks)
		. += span_notice("从这只摇壶倒出的饮品将使用以下名称：[custom_drink_name]")
		. += span_notice("从这只摇壶倒出的饮品将使用以下描述：[custom_drink_desc]")

/obj/item/reagent_containers/cup/glass/shaker/click_alt(mob/user)
	if(using_custom_drinks)
		using_custom_drinks = FALSE
		disable_custom_drinks()
		balloon_alert(user, "已禁用自定义饮品")
		return CLICK_ACTION_BLOCKING

	var/new_name = reject_bad_text(tgui_input_text(user, "饮品名称", "设定饮品名称", custom_drink_name, 45, FALSE), 64)
	if(!new_name)
		balloon_alert(user, "饮品名称无效！")
		using_custom_drinks = FALSE
		return CLICK_ACTION_BLOCKING

	if(!user.can_perform_action(src, NEED_HANDS|FORBID_TELEKINESIS_REACH))
		return CLICK_ACTION_BLOCKING

	var/new_desc = reject_bad_text(tgui_input_text(user, "饮品描述", "设定饮品描述", custom_drink_desc, 64, TRUE), 128)
	if(!new_desc)
		balloon_alert(user, "饮品描述无效！")
		using_custom_drinks = FALSE
		return CLICK_ACTION_BLOCKING

	if(!user.can_perform_action(src, NEED_HANDS|FORBID_TELEKINESIS_REACH))
		return CLICK_ACTION_BLOCKING

	using_custom_drinks = TRUE
	custom_drink_name = new_name
	custom_drink_desc = new_desc

	enable_custom_drinks()
	balloon_alert(user, "现在倒出的是自定义饮品")
	return CLICK_ACTION_SUCCESS

/obj/item/reagent_containers/cup/glass/shaker/proc/enable_custom_drinks()
	RegisterSignal(src, COMSIG_REAGENTS_CUP_TRANSFER_TO, PROC_REF(handle_transfer))

/obj/item/reagent_containers/cup/glass/shaker/proc/disable_custom_drinks()
	UnregisterSignal(src, COMSIG_REAGENTS_CUP_TRANSFER_TO)

/obj/item/reagent_containers/cup/glass/shaker/proc/handle_transfer(atom/origin, atom/target)
	SIGNAL_HANDLER
	// Should only work on drinking/shot glasses
	if(!istype(target, /obj/item/reagent_containers/cup/glass/drinkingglass))
		return

	var/obj/item/reagent_containers/cup/glass/drinkingglass/target_glass = target
	target_glass.name = custom_drink_name
	target_glass.desc = custom_drink_desc
	ADD_TRAIT(target_glass, TRAIT_WAS_RENAMED, SHAKER_LABEL_TRAIT)

/obj/item/reagent_containers/cup/glass/flask
	name = "随身酒壶"
	desc = "每个优秀的太空人都知道，走到哪都该带上几品脱威士忌。"
	custom_price = PAYCHECK_COMMAND * 2
	icon = 'icons/obj/drinks/bottles.dmi'
	worn_icon_state = "flask"
	icon_state = "flask"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*2.5)
	volume = 60
	isGlass = FALSE

/obj/item/reagent_containers/cup/glass/flask/gold
	name = "舰长的酒壶"
	desc = "属于舰长的金质酒壶。"
	worn_icon_state = "flask_gold"
	icon_state = "flask_gold"
	custom_materials = list(/datum/material/gold=SMALL_MATERIAL_AMOUNT*5)

/obj/item/reagent_containers/cup/glass/flask/det
	name = "侦探的酒壶"
	desc = "侦探唯一真正的朋友。"
	worn_icon_state = "detflask"
	icon_state = "detflask"
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 30)

/obj/item/reagent_containers/cup/glass/flask/det/minor
	list_reagents = list(/datum/reagent/consumable/applejuice = 30)

/obj/item/reagent_containers/cup/glass/mug/britcup
	name = "茶杯"
	desc = "印有英国国旗的杯子。"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "britcup_empty"
	base_icon_state = "britcup"
	volume = 30
