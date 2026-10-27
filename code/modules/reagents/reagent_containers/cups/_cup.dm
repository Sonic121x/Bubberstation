/obj/item/reagent_containers/cup
	name = "敞口容器"
	abstract_type = /obj/item/reagent_containers/cup
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50)
	volume = 50
	initial_reagent_flags = OPENCONTAINER | DUNKABLE
	resistance_flags = ACID_PROOF
	icon_state = "bottle"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	reagent_container_liquid_sound = SFX_DEFAULT_LIQUID_SLOSH

	/// Like Edible's food type, what kind of drink is this?
	var/drink_type = NONE
	/// The last time we have checked for taste.
	var/last_check_time
	/// How much we drink at once, shot glasses drink more.
	var/gulp_size = 5
	/// Whether the 'bottle' is made of glass or not so that milk cartons dont shatter when someone gets hit by it.
	var/isGlass = FALSE
	/// What kind of chem transfer method does this cup use. Defaults to INGEST
	var/reagent_consumption_method = INGEST
	/// What sound does our consumption play on consuming from the container?
	var/consumption_sound = 'sound/items/drink.ogg'
	/// Whether to allow heating up the contents with a source of flame.
	var/heatable = TRUE
	/// Can we put a lid on this container?
	var/can_lid = FALSE
	/// Does this container have a lid on right now?
	var/has_lid = FALSE
	/// Assembly attached to our lid
	var/obj/item/assembly_holder/lid_assembly = null
	/// Power cell duct-taped to the side of the beaker
	var/obj/item/stock_parts/power_store/cell/attached_cell = null
	/// Have we added wiring to the cell?
	var/cell_wired = FALSE
	/// Visual y-offset for the assembly on our lid
	var/assembly_pixel_y = 0
	/// If TRUE, after we finish drinking, we try to drink again after do_after
	var/loop_drink = FALSE

/obj/item/reagent_containers/cup/Initialize(mapload, vol)
	. = ..()
	if(heatable)
		AddElement(/datum/element/reagents_item_heatable)
	register_context()

/obj/item/reagent_containers/cup/Destroy(force)
	QDEL_NULL(lid_assembly)
	QDEL_NULL(attached_cell)
	return ..()

/obj/item/reagent_containers/cup/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(cell_wired && held_item.tool_behaviour == TOOL_WIRECUTTER)
		context[SCREENTIP_CONTEXT_LMB] = "剪断线路"
		return CONTEXTUAL_SCREENTIP_SET

	if(!can_lid)
		return
	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_ALT_LMB] = lid_assembly ? "卸下组件" : "开合盖子"
		return CONTEXTUAL_SCREENTIP_SET
	if(isnull(lid_assembly) && istype(held_item, /obj/item/assembly_holder))
		context[SCREENTIP_CONTEXT_LMB] = "安装组件"
		return CONTEXTUAL_SCREENTIP_SET
	if(isnull(attached_cell) && !isnull(lid_assembly) && istype(held_item, /obj/item/stock_parts/power_store/cell))
		context[SCREENTIP_CONTEXT_LMB] = "安装电池"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/reagent_containers/cup/examine(mob/user)
	. = ..()
	if(drink_type)
		var/list/types = bitfield_to_list(drink_type, FOOD_FLAGS)
		. += span_notice("标签上写着它含有 [LOWER_TEXT(english_list(types))] 成分。")
	if(can_lid)
		if(has_lid)
			. += span_notice("它用一只亮橙色的橡胶盖密封着[!isnull(lid_assembly) ? "，盖子上还装着一个组件" : ""]。")
		else
			. += span_notice("可以用[EXAMINE_HINT("Alt 点击")]给它盖上盖子密封。")

/**
 * Checks if the mob actually liked drinking this cup.
 *
 * This is a bunch of copypaste from the edible component, consider reworking this to use it!
 */
/obj/item/reagent_containers/cup/proc/checkLiked(fraction, mob/eater)
	if(last_check_time + 5 SECONDS > world.time)
		return FALSE
	if(!ishuman(eater))
		return FALSE
	var/mob/living/carbon/human/gourmand = eater
	//Bruh this breakfast thing is cringe and shouldve been handled separately from food-types, remove this in the future (Actually, just kill foodtypes in general)
	if((drink_type & BREAKFAST) && world.time - SSticker.round_start_time < STOP_SERVING_BREAKFAST)
		gourmand.add_mood_event("breakfast", /datum/mood_event/breakfast)
	last_check_time = world.time

	var/food_taste_reaction = gourmand.get_food_taste_reaction(src, drink_type)
	switch(food_taste_reaction)
		if(FOOD_TOXIC)
			to_chat(gourmand,span_warning("刚才那玩意儿到底是什么鬼？！"))
			gourmand.adjust_disgust(25 + 30 * fraction)
			gourmand.add_mood_event("toxic_food", /datum/mood_event/disgusting_food)
		if(FOOD_DISLIKED)
			to_chat(gourmand,span_notice("那玩意儿味道不太好……"))
			gourmand.adjust_disgust(11 + 15 * fraction)
			gourmand.add_mood_event("gross_food", /datum/mood_event/gross_food)
		if(FOOD_LIKED)
			to_chat(gourmand,span_notice("我爱死这个味道了！"))
			gourmand.adjust_disgust(-5 + -2.5 * fraction)
			gourmand.add_mood_event("fav_food", /datum/mood_event/favorite_food)

/obj/item/reagent_containers/cup/proc/try_drink(mob/living/target_mob, mob/living/user)
	if(!canconsume(target_mob, user))
		return ITEM_INTERACT_BLOCKING

	user.changeNext_move(CLICK_CD_MELEE)
	if(target_mob != user)
		if(DOING_INTERACTION_WITH_TARGET(user, target_mob))
			return ITEM_INTERACT_BLOCKING
		target_mob.visible_message(
			span_danger("[user] 想用 [src] 喂 [target_mob] 一些东西。"),
			span_userdanger("[user] 想用 [src] 喂你一些东西。"),
		)
		if(!do_after(user, 3 SECONDS, target_mob))
			return ITEM_INTERACT_BLOCKING
		if(!reagents || !reagents.total_volume)
			return ITEM_INTERACT_BLOCKING // The drink might be empty after the delay, such as by spam-feeding
		target_mob.visible_message(
			span_danger("[user] 用 [src] 喂了 [target_mob] 一些东西。"),
			span_userdanger("[user] 用 [src] 喂了你一些东西。"),
		)
		if(target_mob.is_blind())
			to_chat(target_mob, span_notice("你感觉有人喂了你一些东西。"))
		log_combat(user, target_mob, "喂食了", reagents.get_reagent_log_string())

	else
		if(loop_drink)
			if(DOING_INTERACTION_WITH_TARGET(user, user))
				return ITEM_INTERACT_BLOCKING
			user.visible_message(
				span_notice("[user] 想从 [src] 里喝一口。"),
				ignored_mobs = list(user),
			)
			to_chat(user, span_notice("你想从 [src] 里喝一口。"))
			if(!do_after(user, 1.25 SECONDS, user))
				return ITEM_INTERACT_BLOCKING
			if(!reagents || !reagents.total_volume)
				return ITEM_INTERACT_BLOCKING
			user.visible_message(
				span_notice("[user] 从 [src] 里喝了一口。"),
				ignored_mobs = list(user),
			)
		to_chat(user, span_notice("你咽下一大口 [src]。"))

	SEND_SIGNAL(src, COMSIG_GLASS_DRANK, target_mob, user)
	SEND_SIGNAL(target_mob, COMSIG_GLASS_DRANK, src, user) // SKYRAT EDIT ADDITION - Hemophages can't casually drink what's not going to regenerate their blood
	var/fraction = min(gulp_size / reagents.total_volume, 1)
	reagents.trans_to(target_mob, gulp_size, transferred_by = user, methods = reagent_consumption_method)
	var/atom/movable/screen/hunger/hunger_bar = user.hud_used?.screen_objects[HUD_MOB_HUNGER]
	if (istype(hunger_bar))
		hunger_bar.update_hunger_bar()
	checkLiked(fraction, target_mob)
	playsound(target_mob, consumption_sound, rand(10, 50), TRUE)
	var/list/datum/disease/diseases_to_add
	for(var/datum/disease/malady as anything in target_mob.get_static_viruses())
		if(malady.spread_flags & DISEASE_SPREAD_CONTACT_FLUIDS)
			LAZYADD(diseases_to_add, malady)
	if(LAZYLEN(diseases_to_add))
		AddComponent(/datum/component/infective, diseases_to_add)
	if(loop_drink)
		return try_drink(target_mob, user) | ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/cup/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!is_open_container())
		return NONE

	if(target.is_refillable()) //Something like a glass. Player probably wants to transfer TO it.
		return try_refill(target, user)

	if(target.is_drainable()) //A dispenser. Transfer FROM it TO us.
		return try_drain(target, user)

	if(isliving(target))
		return try_drink(target, user)

	if(is_drainable())
		return pour_concrete(target, user)

	return NONE

/// QoL helper for pouring concrete directly from container just by clicking.
/// Easier than splashing onto turf or object, but requires a little delay.
/obj/item/reagent_containers/cup/proc/pour_concrete(atom/target, mob/living/user)
	var/datum/reagent/concrete/concrete = reagents.has_reagent(/datum/reagent/concrete, check_subtypes=TRUE)
	if (!concrete)
		return NONE
	var/pour_amount = concrete.pour_amount(target, user)
	if (!pour_amount)
		return NONE
	if (concrete.volume < pour_amount)
		user.balloon_alert(user, "量不足以倾倒")
		return ITEM_INTERACT_FAILURE
	user.balloon_alert(user, "正在倾倒……")
	user.visible_message(
		span_notice("[user] 开始把混凝土浇到 \a [target] 上。"),
		span_notice("你开始把混凝土浇到 \a [target] 上……"),
	)
	if (!do_after(user, 1 SECONDS, target=target))
		user.balloon_alert(user, "被打断")
		return ITEM_INTERACT_FAILURE
	if(concrete.volume < pour_amount) // check if volume has changed during do_after
		user.balloon_alert(user, "量不足以倾倒")
		return ITEM_INTERACT_FAILURE
	playsound(src, 'sound/effects/slosh.ogg', 25, TRUE)
	concrete.expose_atom(target, pour_amount, TOUCH)
	reagents.remove_reagent(concrete.type, pour_amount)
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/cup/interact_with_atom_secondary(atom/target, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!is_open_container())
		return NONE

	if(target.is_drainable()) //A dispenser. Transfer FROM it TO us.
		return try_drain(target, user)

	return NONE

/obj/item/reagent_containers/cup/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(has_lid && istype(tool, /obj/item/assembly_holder))
		if (lid_assembly)
			to_chat(user, span_warning("[src] 的盖子上已经装了一个组件！"))
			return ITEM_INTERACT_BLOCKING

		if (attach_assembly(tool, user))
			playsound(src, 'sound/machines/click.ogg', 50, TRUE)
			return ITEM_INTERACT_SUCCESS
		return ITEM_INTERACT_BLOCKING

	if (lid_assembly && istype(tool, /obj/item/stock_parts/power_store/cell))
		if (attached_cell)
			to_chat(user, span_warning("[src] 上已经接了 \a [attached_cell]！"))
			return ITEM_INTERACT_BLOCKING

		if (isnull(locate(/obj/item/assembly/igniter) in lid_assembly))
			to_chat(user, span_warning("[lid_assembly] 上没有点火器可以连接 [src]！"))
			return ITEM_INTERACT_BLOCKING

		if (!user.transferItemToLoc(tool, src))
			to_chat(user, span_warning("[tool] 粘在你手上了！"))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("你把 [tool] 装在 [src] 的盖子下方。"))
		add_fingerprint(user)
		log_bomber(user, "把 [tool.name] 安装到了", src)
		attached_cell = tool
		attached_cell.pixel_y = 0
		attached_cell.pixel_z = -4
		update_appearance()
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		return ITEM_INTERACT_SUCCESS

	if (attached_cell && istype(tool, /obj/item/stack/cable_coil))
		if (cell_wired)
			to_chat(user, span_warning("[attached_cell] 已经接到 [lid_assembly] 上了！"))
			return ITEM_INTERACT_BLOCKING

		var/obj/item/stack/cable_coil/cable = tool
		if (!cable.use(5))
			to_chat(user, span_warning("至少需要 5 段线缆才能给 [attached_cell] 接线！"))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("你把 [attached_cell] 接到了 [lid_assembly] 上。"))
		add_fingerprint(user)
		cell_wired = TRUE
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(!is_open_container())
		return NONE

	if(istype(tool, /obj/item/food/egg)) //breaking eggs
		if(reagents.holder_full())
			to_chat(user, span_notice("[src] 是满的。"))
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("你在 [src] 里打碎了 [tool]。"))
		tool.reagents.trans_to(src, tool.reagents.total_volume, transferred_by = user)
		qdel(tool)
		return ITEM_INTERACT_SUCCESS

	return NONE

/*
 * On accidental consumption, make sure the container is partially glass, and continue to the reagent_container proc
 */
/obj/item/reagent_containers/cup/on_accidental_consumption(mob/living/carbon/M, mob/living/carbon/user, obj/item/source_item, discover_after = TRUE)
	if(isGlass && !custom_materials)
		set_custom_materials(list(SSmaterials.get_material(/datum/material/glass) = 5))//sets it to glass so, later on, it gets picked up by the glass catch (hope it doesn't 'break' things lol)
	return ..()

/// Callback for [datum/component/takes_reagent_appearance] to inherent style footypes
/obj/item/reagent_containers/cup/proc/on_cup_change(datum/glass_style/has_foodtype/style)
	if(!istype(style))
		return
	drink_type = style.drink_type

/// Callback for [datum/component/takes_reagent_appearance] to reset to no foodtypes
/obj/item/reagent_containers/cup/proc/on_cup_reset()
	drink_type = NONE

/obj/item/reagent_containers/cup/update_overlays()
	. = ..()
	if (has_lid)
		. += mutable_appearance(icon, "[icon_state]_lid")
	if (lid_assembly)
		. += lid_assembly
	if (attached_cell)
		. += attached_cell
		if (cell_wired)
			. += mutable_appearance('icons/obj/machines/cell_charger.dmi', "ccharger-[attached_cell.connector_type]-on")

// For player convinience, assume that the lids are rubber and can be pierced with a syringe
/obj/item/reagent_containers/cup/is_refillable()
	return ..() && !has_lid

/obj/item/reagent_containers/cup/is_drainable()
	return ..() && !has_lid

/obj/item/reagent_containers/cup/is_dunkable()
	return ..() && !has_lid

/obj/item/reagent_containers/cup/attack_self(mob/user)
	if (!lid_assembly)
		return ..()
	lid_assembly.attack_self(user)
	return TRUE

/obj/item/reagent_containers/cup/click_alt(mob/user)
	if (!can_lid)
		return NONE

	if (cell_wired)
		balloon_alert(user, "请先剪断线路！")
		return CLICK_ACTION_BLOCKING

	if (attached_cell)
		var/obj/item/our_cell = attached_cell
		// Exited() automatically clears it
		our_cell.forceMove(drop_location())
		user.put_in_hands(our_cell)
		balloon_alert(user, "电池已卸下")
		update_appearance()
		return CLICK_ACTION_SUCCESS

	if (lid_assembly)
		var/obj/item/our_assembly = lid_assembly
		our_assembly.forceMove(drop_location())
		user.put_in_hands(our_assembly)
		balloon_alert(user, "组件已卸下")
		update_appearance()
		return CLICK_ACTION_SUCCESS

	has_lid = !has_lid
	update_appearance()
	balloon_alert(user, "盖子已[has_lid ? "密封" : "打开"]")
	if (has_lid)
		add_container_flags(SEALED_CONTAINER)
	else
		reset_container_flags()
	return CLICK_ACTION_SUCCESS

/obj/item/reagent_containers/cup/wirecutter_act(mob/living/user, obj/item/tool)
	if (user.combat_mode || !cell_wired)
		return NONE

	new /obj/item/stack/cable_coil(drop_location(), 5)
	cell_wired = FALSE
	update_appearance()
	balloon_alert(user, "线路已剪断")
	tool.play_tool_sound(src, 50)
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/cup/proc/attach_assembly(obj/item/assembly_holder/assembly, mob/living/user)
	if (!user.transferItemToLoc(assembly, src))
		to_chat(user, span_warning("[assembly] 粘在你手上了！"))
		return FALSE

	to_chat(user, span_notice("你把 [assembly] 装到了 [src] 的盖子上。"))
	add_fingerprint(user)
	lid_assembly = assembly
	lid_assembly.master = src
	lid_assembly.pixel_y = 0
	lid_assembly.pixel_z = assembly_pixel_y
	lid_assembly.on_attach()
	RegisterSignal(src, COMSIG_IGNITER_ACTIVATE, PROC_REF(on_igniter_activate))
	log_bomber(user, "把 [lid_assembly.name] 安装到了", src)
	update_appearance()
	return TRUE

/obj/item/reagent_containers/cup/on_found(mob/finder)
	. = ..()
	lid_assembly?.on_found(finder)

/obj/item/reagent_containers/cup/Exited(atom/movable/gone, direction)
	. = ..()
	if (gone == lid_assembly)
		lid_assembly = null
		UnregisterSignal(src, COMSIG_IGNITER_ACTIVATE)
		update_appearance()
	else if (gone == attached_cell)
		attached_cell = null
		cell_wired = FALSE
		update_appearance()

/obj/item/reagent_containers/cup/proc/on_igniter_activate(datum/source, obj/item/assembly/igniter/igniter)
	SIGNAL_HANDLER
	// We've got an attached cell wired up, so we'll try to spend all of its current first
	if (attached_cell && cell_wired)
		var/power_spent = attached_cell.use(attached_cell.charge())
		// Power cell was rigged
		if (QDELETED(src))
			return

		// We'll be nerfing plasma and welding fuel as they're very easy to get and make for boring bombs
		if (power_spent > 0 && (reagents.spark_act(power_spent, SPARK_ACT_ENCLOSED | SPARK_ACT_WEAKEN_COMMON) & SPARK_ACT_DESTRUCTIVE))
			qdel(src)
			return

	// Igniters heat, condensers chill
	var/igniter_temp = igniter.get_temperature()
	if (igniter_temp > 0)
		reagents.expose_temperature(igniter_temp)

/obj/item/reagent_containers/cup/beaker
	name = "烧杯"
	desc = "一个烧杯。最多可容纳 50 单位。"
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "beaker"
	inhand_icon_state = "beaker"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	worn_icon_state = "beaker"
	custom_materials = list(/datum/material/glass=SMALL_MATERIAL_AMOUNT*5)
	fill_icon_thresholds = list(0, 1, 20, 40, 60, 80, 100)
	pickup_sound = 'sound/items/handling/beaker_pickup.ogg'
	drop_sound = 'sound/items/handling/beaker_place.ogg'
	sound_vary = TRUE
	can_lid = TRUE
	assembly_pixel_y = 4

/obj/item/reagent_containers/cup/beaker/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/reagent_containers/cup/beaker/get_part_rating()
	return reagents.maximum_volume

/obj/item/reagent_containers/cup/beaker/jar
	name = "蜂蜜罐"
	desc = "用来装蜂蜜的罐子。最多可容纳 50 单位的甜蜜享受。"
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "vapour"
	can_lid = FALSE

/obj/item/reagent_containers/cup/beaker/large
	name = "大烧杯"
	desc = "一个大烧杯。最多可容纳 100 单位。"
	icon_state = "beakerlarge"
	custom_materials = list(/datum/material/glass= SHEET_MATERIAL_AMOUNT*1.25)
	volume = 100
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100)
	fill_icon_thresholds = list(0, 1, 20, 40, 60, 80, 100)
	assembly_pixel_y = 8

/obj/item/reagent_containers/cup/beaker/plastic
	name = "特大烧杯"
	desc = "一个特大号烧杯。最多可容纳 120 单位。"
	icon_state = "beakerwhite"
	inhand_icon_state = "beaker_white"
	custom_materials = list(/datum/material/glass=SHEET_MATERIAL_AMOUNT*1.25, /datum/material/plastic=SHEET_MATERIAL_AMOUNT * 1.5)
	volume = 120
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,60,120)
	fill_icon_thresholds = list(0, 1, 10, 20, 40, 60, 80, 100)
	assembly_pixel_y = 8

/obj/item/reagent_containers/cup/beaker/meta
	name = "超材料烧杯"
	desc = "一个大烧杯。最多可容纳 180 单位。"
	icon_state = "beakergold"
	inhand_icon_state = "beaker_gold"
	custom_materials = list(/datum/material/glass=SHEET_MATERIAL_AMOUNT*1.25, /datum/material/plastic=SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/gold=HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium=HALF_SHEET_MATERIAL_AMOUNT)
	volume = 180
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,60,120,180)
	fill_icon_thresholds = list(0, 1, 10, 25, 35, 50, 60, 80, 100)
	assembly_pixel_y = 10

/obj/item/reagent_containers/cup/beaker/noreact
	name = "低温休眠烧杯"
	desc = "一个低温休眠烧杯，可储存化学品而不发生 \
		反应。最多可容纳 50 单位。"
	icon_state = "beakernoreact"
	inhand_icon_state = "beaker_cryo"
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 1.5)
	initial_reagent_flags = OPENCONTAINER | NO_REACT
	volume = 50
	amount_per_transfer_from_this = 10
	can_lid = FALSE

/obj/item/reagent_containers/cup/beaker/bluespace
	name = "蓝空间烧杯"
	desc = "一个蓝空间烧杯，由实验性蓝空间技术驱动，\
		结合了古巴元素与皮特化合物。最多可容纳 \
		300 单位。"
	icon_state = "beakerbluespace"
	inhand_icon_state = "beaker_bluespace"
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)
	volume = 300
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100,300)
	can_lid = FALSE

/obj/item/reagent_containers/cup/beaker/meta/omnizine
	list_reagents = list(/datum/reagent/medicine/omnizine = 180)

/obj/item/reagent_containers/cup/beaker/meta/sal_acid
	list_reagents = list(/datum/reagent/medicine/sal_acid = 180)

/obj/item/reagent_containers/cup/beaker/meta/oxandrolone
	list_reagents = list(/datum/reagent/medicine/oxandrolone = 180)

/obj/item/reagent_containers/cup/beaker/meta/pen_acid
	list_reagents = list(/datum/reagent/medicine/pen_acid = 180)

/obj/item/reagent_containers/cup/beaker/meta/atropine
	list_reagents = list(/datum/reagent/medicine/atropine = 180)

/obj/item/reagent_containers/cup/beaker/meta/salbutamol
	list_reagents = list(/datum/reagent/medicine/salbutamol = 180)

/obj/item/reagent_containers/cup/beaker/meta/rezadone
	list_reagents = list(/datum/reagent/medicine/rezadone = 180)

/obj/item/reagent_containers/cup/beaker/cryoxadone
	list_reagents = list(/datum/reagent/medicine/cryoxadone = 30)

/obj/item/reagent_containers/cup/beaker/sulfuric
	list_reagents = list(/datum/reagent/toxin/acid = 50)

/obj/item/reagent_containers/cup/beaker/slime
	list_reagents = list(/datum/reagent/toxin/slimejelly = 50)

/obj/item/reagent_containers/cup/beaker/large/libital
	name = "利比妥储备罐（稀释）"
	list_reagents = list(/datum/reagent/medicine/c2/libital = 10,/datum/reagent/medicine/granibitaluri = 40)

/obj/item/reagent_containers/cup/beaker/large/aiuri
	name = "艾尤里储备罐（稀释）"
	list_reagents = list(/datum/reagent/medicine/c2/aiuri = 10, /datum/reagent/medicine/granibitaluri = 40)

/obj/item/reagent_containers/cup/beaker/large/multiver
	name = "穆尔提弗储备罐（稀释）"
	list_reagents = list(/datum/reagent/medicine/c2/multiver = 10, /datum/reagent/medicine/granibitaluri = 40)

/obj/item/reagent_containers/cup/beaker/large/epinephrine
	name = "肾上腺素储备罐（稀释）"
	list_reagents = list(/datum/reagent/medicine/epinephrine = 50)

/obj/item/reagent_containers/cup/beaker/synthflesh
	list_reagents = list(/datum/reagent/medicine/c2/synthflesh = 50)

/obj/item/reagent_containers/cup/beaker/synthflesh/named
	name = "合成肉液烧杯"

/obj/item/reagent_containers/cup/bucket
	name = "水桶"
	desc = "是个水桶。右键点击可以把拖把里的东西挤进去。" //SKYRAT EDIT CHANGE - ORIGINAL: desc = "It's a bucket."
	icon = 'icons/obj/service/janitor.dmi'
	worn_icon = 'icons/mob/clothing/head/utility.dmi'
	icon_state = "bucket"
	inhand_icon_state = "bucket"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	fill_icon_state = "bucket"
	fill_icon_thresholds = list(50, 90)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2)
	w_class = WEIGHT_CLASS_NORMAL
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100) //SKYRAT EDIT CHANGE
	volume = 100 //SKYRAT EDIT CHANGE
	flags_inv = HIDEHAIR
	slot_flags = ITEM_SLOT_HEAD
	resistance_flags = NONE
	armor_type = /datum/armor/cup_bucket
	slot_equipment_priority = list( \
		ITEM_SLOT_BACK, ITEM_SLOT_ID,\
		ITEM_SLOT_ICLOTHING, ITEM_SLOT_OCLOTHING,\
		ITEM_SLOT_MASK, ITEM_SLOT_HEAD, ITEM_SLOT_NECK,\
		ITEM_SLOT_FEET, ITEM_SLOT_GLOVES,\
		ITEM_SLOT_EARS, ITEM_SLOT_EYES,\
		ITEM_SLOT_BELT, ITEM_SLOT_SUITSTORE,\
		ITEM_SLOT_LPOCKET, ITEM_SLOT_RPOCKET,\
		ITEM_SLOT_DEX_STORAGE
	)

/obj/item/reagent_containers/cup/bucket/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item)

/datum/armor/cup_bucket
	melee = 10
	fire = 75
	acid = 50

/obj/item/reagent_containers/cup/bucket/wooden
	name = "木桶"
	icon_state = "woodbucket"
	inhand_icon_state = "woodbucket"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 3)
	resistance_flags = FLAMMABLE
	armor_type = /datum/armor/bucket_wooden

/datum/armor/bucket_wooden
	melee = 10
	acid = 50

/obj/item/reagent_containers/cup/bucket/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/mop))
		if(reagents.total_volume < 1)
			user.balloon_alert(user, "是空的！")
			return ITEM_INTERACT_BLOCKING
		reagents.trans_to(tool, 5, transferred_by = user)
		user.balloon_alert(user, "浸湿了 [tool]")
		playsound(src, 'sound/effects/slosh.ogg', 25, TRUE)
		return ITEM_INTERACT_SUCCESS
	if(isprox(tool)) //This works with wooden buckets for now. Somewhat unintended, but maybe someone will add sprites for it soon(TM)
		to_chat(user, span_notice("你把 [tool] 放进了 [src]。"))
		qdel(tool)
		var/obj/item/bot_assembly/cleanbot/new_cleanbot_ass = new(null, src)
		user.put_in_hands(new_cleanbot_ass)
		return ITEM_INTERACT_SUCCESS

	return ..()

// BUBBER EDIT ADDITION BEGIN - LIQUIDS
/obj/item/reagent_containers/cup/bucket/item_interaction_secondary(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/mop))
		if(tool.reagents.total_volume == 0)
			user.balloon_alert(user, "拖把是干的！")
			return ITEM_INTERACT_BLOCKING
		if(reagents.total_volume == reagents.maximum_volume)
			user.balloon_alert(user, "容器已满！")
			return ITEM_INTERACT_BLOCKING
		tool.reagents.remove_all(tool.reagents.total_volume * SQUEEZING_DISPERSAL_RATIO)
		tool.reagents.trans_to(src, tool.reagents.total_volume, transferred_by = user)
		user.balloon_alert(user, "已挤干拖把")
		return ITEM_INTERACT_SUCCESS

	. = ..()
// BUBBER EDIT ADDITION END - LIQUIDS

/obj/item/reagent_containers/cup/bucket/equipped(mob/user, slot)
	. = ..()
	if (slot & ITEM_SLOT_HEAD)
		if(reagents.total_volume)
			to_chat(user, span_userdanger("[src] 里的东西洒了你一身！"))
			reagents.expose(user, TOUCH)
			reagents.clear_reagents()
		update_container_flags(NONE)

/obj/item/reagent_containers/cup/bucket/dropped(mob/user)
	. = ..()
	reset_container_flags()

/obj/item/reagent_containers/cup/bucket/equip_to_best_slot(mob/M)
	if(reagents.total_volume) //If there is water in a bucket, don't quick equip it to the head
		var/index = slot_equipment_priority.Find(ITEM_SLOT_HEAD)
		slot_equipment_priority.Remove(ITEM_SLOT_HEAD)
		. = ..()
		slot_equipment_priority.Insert(index, ITEM_SLOT_HEAD)
		return
	return ..()

/obj/item/pestle
	name = "研杵"
	desc = "一件古老的简易工具，配合研钵用来研磨或榨取物品。"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "pestle"
	force = 7
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)

/obj/item/reagent_containers/cup/mortar
	name = "研钵"
	desc = "一只造型特殊、源自古代设计的碗。可以用研杵把放入其中的物品捣碎或榨汁；不过与现代方法不同，这个过程缓慢又耗费体力。"
	desc_controls = "按住 Alt 点击可取出物品。"
	icon_state = "mortar"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50, 100)
	volume = 100
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 3)
	resistance_flags = FLAMMABLE
	initial_reagent_flags = OPENCONTAINER
	var/obj/item/grinded

/obj/item/reagent_containers/cup/mortar/click_alt(mob/user)
	if(!grinded)
		return CLICK_ACTION_BLOCKING
	grinded.forceMove(drop_location())
	grinded = null
	balloon_alert(user, "已取出")
	return CLICK_ACTION_SUCCESS

/obj/item/reagent_containers/cup/mortar/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(istype(tool, /obj/item/pestle))
		if(!grinded)
			to_chat(user, span_warning("没有东西可以研磨！"))
			return ITEM_INTERACT_BLOCKING
		if(user.get_stamina_loss() > 50)
			to_chat(user, span_warning("你太累了，干不动了！"))
			return ITEM_INTERACT_BLOCKING
		var/list/choose_options = list(
			"研磨" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_grind"),
			"榨汁" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_juice")
		)
		var/picked_option = show_radial_menu(user, src, choose_options, radius = 38, require_near = TRUE)
		if(!grinded || !in_range(src, user) || !user.is_holding(tool) || !picked_option)
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("你开始研磨……"))
		if(!do_after(user, 2.5 SECONDS, target = src))
			return ITEM_INTERACT_BLOCKING
		user.adjust_stamina_loss(40)
		switch(picked_option)
			if("榨汁")
				return juice_item(grinded, user) ? ITEM_INTERACT_BLOCKING : ITEM_INTERACT_SUCCESS
			if("研磨")
				return grind_item(grinded, user) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("你试图研磨研钵本身，而不是 [grinded]。你失败了。"))
		return ITEM_INTERACT_BLOCKING
	if(grinded)
		to_chat(user, span_warning("里面已经有东西了！"))
		return ITEM_INTERACT_BLOCKING
	if(!tool.blend_requirements(src, user))
		return ITEM_INTERACT_BLOCKING
	if((length(tool.grind_results()) || tool.reagents?.total_volume) && user.transferItemToLoc(tool, src))
		grinded = tool
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/reagent_containers/cup/mortar/blended(obj/item/blended_item, grinded)
	src.grinded = null

	return ..()

/obj/item/reagent_containers/cup/mortar/proc/grind_item(obj/item/item, mob/living/carbon/human/user)
	if(item.flags_1 & HOLOGRAM_1)
		to_chat(user, span_notice("你试着研磨 [item]，但它消散了！"))
		qdel(item)
		return

	if(!item.grind(reagents, user))
		if(isstack(item))
			to_chat(user, span_notice("[src] 试着尽可能多地研磨 [item]。"))
		else
			to_chat(user, span_danger("你没能把 [item] 研磨成功。"))
		return

	to_chat(user, span_notice("你把 [item] 研磨成了细腻的粉末。"))

/obj/item/reagent_containers/cup/mortar/proc/juice_item(obj/item/item, mob/living/carbon/human/user)
	if(item.flags_1 & HOLOGRAM_1)
		to_chat(user, span_notice("你试着榨取 [item]，但它消散了！"))
		qdel(item)
		return

	if(!item.juice(reagents, user))
		to_chat(user, span_notice("你没能把 [item] 榨出汁来。"))
		return

	to_chat(user, span_notice("你把 [item] 榨成了细腻的液体。"))

//Coffeepots: for reference, a standard cup is 30u, to allow 20u for sugar/sweetener/milk/creamer
/obj/item/reagent_containers/cup/coffeepot
	name = "咖啡壶"
	desc = "一把大壶，用来倒出那种凡人只知其名为“咖啡”的职场生活甘露。可装 4 标准杯。"
	volume = 120
	icon_state = "coffeepot"
	fill_icon_state = "coffeepot"
	fill_icon_thresholds = list(0, 1, 30, 60, 100)
	custom_materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/reagent_containers/cup/coffeepot/bluespace
	name = "蓝空间咖啡壶"
	desc = "书呆子们能折腾出的最先进咖啡壶：流线造型；刻度线；连接着一个用于储存咖啡的口袋维度；没错，它样样齐全。可装 8 标准杯。"
	volume = 240
	icon_state = "coffeepot_bluespace"
	fill_icon_thresholds = null
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)

///Test tubes created by chem master and pandemic and placed in racks
/obj/item/reagent_containers/cup/tube
	name = "试管"
	desc = "一支小试管。"
	icon_state = "test_tube"
	fill_icon_state = "tube"
	inhand_icon_state = "atoxinbottle"
	worn_icon_state = "beaker"
	possible_transfer_amounts = list(5, 10, 15, 30)
	volume = 30
	fill_icon_thresholds = list(0, 1, 20, 40, 60, 80, 100)
	can_lid = TRUE

/obj/item/reagent_containers/cup/tube/attach_assembly(obj/item/assembly_holder/assembly, mob/living/user)
	to_chat(user, span_warning("[src] 的盖子太小，装不下 [assembly]！"))
	return FALSE
