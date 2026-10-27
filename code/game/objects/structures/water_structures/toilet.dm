/obj/structure/toilet
	name = "马桶"
	desc = "HT-451，一款扭矩旋转式的小件废物处理装置。这一台看起来出奇地干净。"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "toilet00" //The first number represents if the toilet lid is up, the second is if the cistern is open.
	base_icon_state = "toilet"
	density = FALSE
	anchored = TRUE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)

	/// Boolean if whether the toilet is currently flushing.
	var/flushing = FALSE
	/// Boolean if the toilet seat is up.
	var/cover_open = FALSE
	/// Boolean if the cistern is up, allowing items to be put in/out.
	var/cistern_open = FALSE
	/// The combined weight of all items in the cistern put together.
	var/w_items = 0
	/// Reference to the mob being given a swirlie.
	var/mob/living/swirlie
	/// Lazylist of items in the cistern.
	var/list/cistern_items
	/// Lazylist of fish in the toilet, not to be mixed with the items in the cistern. Max of 3
	var/list/fishes
	/// Does the toilet have a water recycler to recollect its water supply?
	var/has_water_reclaimer = TRUE
	/// Units of water to reclaim per second
	var/reclaim_rate = 0.5
	/// What reagent does the toilet flush with
	var/reagent_id = /datum/reagent/water
	/// How much reagent can the cistern contain
	var/reagent_capacity = 200
	/// Item stuck in the basin of the toilet
	var/obj/item/stuck_item = null

/obj/structure/toilet/Initialize(mapload, has_water_reclaimer = null)
	. = ..()
	cover_open = round(rand(0, 1))
	if(!isnull(has_water_reclaimer))
		src.has_water_reclaimer = has_water_reclaimer
	update_appearance(UPDATE_ICON)
	if(mapload && SSmapping.level_trait(z, ZTRAIT_STATION))
		AddComponent(/datum/component/fishing_spot, GLOB.preset_fish_sources[/datum/fish_source/toilet])
	AddElement(/datum/element/fish_safe_storage)
	register_context()
	create_reagents(reagent_capacity)
	if(src.has_water_reclaimer)
		reagents.add_reagent(reagent_id, reagent_capacity)
	AddComponent(/datum/component/plumbing/simple_demand/extended)

/obj/structure/toilet/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(user.pulling && isliving(user.pulling))
		context[SCREENTIP_CONTEXT_LMB] = "按头冲水"
	if(cover_open)
		if(isnull(held_item))
			if(LAZYLEN(fishes))
				context[SCREENTIP_CONTEXT_LMB] = "抓鱼"
		else if(istype(held_item, /obj/item/fish))
			context[SCREENTIP_CONTEXT_LMB] = "放入鱼"
		else if(istype(held_item, /obj/item/plunger))
			context[SCREENTIP_CONTEXT_LMB] = "疏通"
		else if(held_item.w_class <= WEIGHT_CLASS_SMALL)
			context[SCREENTIP_CONTEXT_LMB] = "放入物品"
	else if(cistern_open)
		if(isnull(held_item))
			context[SCREENTIP_CONTEXT_LMB] = "查看水箱"
		else if(held_item.tool_behaviour == TOOL_SCREWDRIVER && has_water_reclaimer)
			context[SCREENTIP_CONTEXT_LMB] = "拆下回收器"
		else if(istype(held_item, /obj/item/stock_parts/water_recycler) && !has_water_reclaimer)
			context[SCREENTIP_CONTEXT_LMB] = "安装回收器"
		else
			context[SCREENTIP_CONTEXT_LMB] = "放入物品"
	context[SCREENTIP_CONTEXT_RMB] = "冲水"
	context[SCREENTIP_CONTEXT_ALT_LMB] = "[cover_open ? "合上" : "打开"] 马桶盖"
	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/toilet/examine(mob/user)
	. = ..()
	if(cover_open)
		if(LAZYLEN(fishes))
			. += span_notice("你能看见马桶里有鱼，大概可以捞一条出来。")
		if(stuck_item)
			. += span_notice("[src]的盆里好像有什么小东西……")
	if(cistern_open && has_water_reclaimer)
		. += span_notice("已安装了水循环器，用两颗螺丝固定着。")
		. += span_notice("显示屏显示：剩余液体 [reagents.total_volume]/[reagents.maximum_volume]。")

/obj/structure/toilet/examine_more(mob/user)
	. = ..()
	if(cistern_open && LAZYLEN(cistern_items))
		. += span_notice("你能看见水箱里有 [cistern_items.len] 件物品。")

/obj/structure/toilet/Destroy(force)
	. = ..()
	QDEL_LAZYLIST(fishes)
	QDEL_LAZYLIST(cistern_items)
	QDEL_NULL(stuck_item)

/obj/structure/toilet/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone in cistern_items)
		LAZYREMOVE(cistern_items, gone)
		if (isitem(gone))
			var/obj/item/removed_item = gone
			w_items -= removed_item.w_class
		return
	if(gone in fishes)
		LAZYREMOVE(fishes, gone)
	else if(gone == stuck_item)
		stuck_item = null

/obj/structure/toilet/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(swirlie)
		user.changeNext_move(CLICK_CD_MELEE)
		playsound(src.loc, SFX_SWING_HIT, 25, TRUE)
		swirlie.visible_message(span_danger("[user]把马桶圈狠狠砸在[swirlie]的头上！"), span_userdanger("[user]把马桶圈狠狠砸在了你的头上！"), span_hear("你听到瓷器回荡的响声。"))
		log_combat(user, swirlie, "swirlied (brute)")
		swirlie.adjust_brute_loss(5)
		return

	if(user.pulling && isliving(user.pulling))
		user.changeNext_move(CLICK_CD_MELEE)
		var/mob/living/grabbed_mob = user.pulling
		if(user.grab_state < GRAB_AGGRESSIVE)
			to_chat(user, span_warning("你需要抓得更紧！"))
			return
		if(grabbed_mob.loc != get_turf(src))
			to_chat(user, span_warning("[grabbed_mob]必须位于[src]上！"))
			return
		if(swirlie)
			return
		if(cover_open)
			if(!reagents.total_volume)
				to_chat(user, span_notice("[src]里是干的！"))
				return
			grabbed_mob.visible_message(span_danger("[user]开始把[grabbed_mob]的头按进马桶里冲水！"), span_userdanger("[user]开始把你的头按进马桶里冲水……"))
			swirlie = grabbed_mob
			var/was_alive = (swirlie.stat != DEAD)
			if(!do_after(user, 3 SECONDS, target = src, timed_action_flags = IGNORE_HELD_ITEM))
				swirlie = null
				return
			if(!reagents.total_volume)
				to_chat(user, span_notice("[src]里是干的！"))
				return
			grabbed_mob.visible_message(span_danger("[user]把[grabbed_mob]的头按进马桶里冲了水！"), span_userdanger("[user]把你的头按进马桶里冲了水！"), span_hear("你听到马桶冲水的声音。"))
			if(iscarbon(grabbed_mob))
				var/mob/living/carbon/carbon_grabbed = grabbed_mob
				if(!carbon_grabbed.internal)
					log_combat(user, carbon_grabbed, "swirlied (oxy)")
					carbon_grabbed.adjust_oxy_loss(5)
			else
				log_combat(user, grabbed_mob, "swirlied (oxy)")
				grabbed_mob.adjust_oxy_loss(5)
			if(was_alive && swirlie.stat == DEAD && swirlie.client)
				swirlie.client.give_award(/datum/award/achievement/misc/swirlie, swirlie) // just like space high school all over again!
			swirlie = null
		else
			playsound(src.loc, 'sound/effects/bang.ogg', 25, TRUE)
			grabbed_mob.visible_message(span_danger("[user]把[grabbed_mob.name]狠狠撞向[src]！"), span_userdanger("[user]把你狠狠撞向[src]！"))
			log_combat(user, grabbed_mob, "toilet slammed")
			grabbed_mob.adjust_brute_loss(5)
		return

	if(cistern_open && !cover_open && IsReachableBy(user))
		if(!LAZYLEN(cistern_items))
			to_chat(user, span_notice("水箱是空的。"))
			return
		var/obj/item/random_cistern_item = pick(cistern_items)
		if(ishuman(user))
			user.put_in_hands(random_cistern_item)
		else
			random_cistern_item.forceMove(drop_location())
		to_chat(user, span_notice("你在水箱里找到了[random_cistern_item]。"))
		return

	if(!flushing && LAZYLEN(fishes) && cover_open)
		var/obj/item/random_fish = pick(fishes)
		if(ishuman(user))
			user.put_in_hands(random_fish)
		else
			random_fish.forceMove(drop_location())
		to_chat(user, span_notice("你把[random_fish]从马桶里捞了出来，可怜的家伙。"))

/obj/structure/toilet/click_alt(mob/living/user)
	if(flushing)
		return CLICK_ACTION_BLOCKING
	cover_open = !cover_open
	update_appearance(UPDATE_ICON)
	return CLICK_ACTION_SUCCESS

/obj/structure/toilet/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(flushing)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(reagents.total_volume <= 50)
		to_chat(user, span_notice("你按下冲水扳手，但什么也没发生。"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	flushing = TRUE
	var/something_stuck = !isnull(stuck_item)
	if(!something_stuck && LAZYLEN(fishes))
		for(var/obj/item/fish/fish as anything in fishes)
			if(fish.w_class >= WEIGHT_CLASS_NORMAL)
				something_stuck = TRUE
				break

	if(something_stuck)
		reagents.create_foam(/datum/effect_system/fluid_spread/foam, 10, notification = span_danger("[src]溢了出来，水箱里的东西洒得到处都是！"), log = TRUE)
	else
		reagents.remove_all(50)

	begin_reclamation()
	playsound(src, 'sound/machines/toilet_flush.ogg', cover_open ? 40 : 20, TRUE)
	if(cover_open && (dir & SOUTH))
		update_appearance(UPDATE_OVERLAYS)
		flick_overlay_view(mutable_appearance(icon, "[base_icon_state]-water-flick"), 3 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(end_flushing)), 4 SECONDS)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/toilet/update_icon_state()
	icon_state = "[base_icon_state][cover_open][cistern_open]"
	return ..()

/obj/structure/toilet/update_overlays()
	. = ..()
	if(!flushing && cover_open)
		. += "[base_icon_state]-water"

/obj/structure/toilet/dump_contents()
	for(var/obj/toilet_item in (cistern_items + fishes))
		toilet_item.forceMove(drop_location())
	stuck_item?.forceMove(drop_location())

/obj/structure/toilet/atom_deconstruct(dissambled = TRUE)
	dump_contents()
	drop_custom_materials()
	if(has_water_reclaimer)
		new /obj/item/stock_parts/water_recycler(drop_location())

/obj/structure/toilet/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(user.combat_mode)
		return NONE

	add_fingerprint(user)
	if(cover_open && istype(tool, /obj/item/fish))
		if(LAZYLEN(fishes) >= 3)
			to_chat(user, span_warning("鱼太多了，先把它们冲下去吧。"))
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			to_chat(user, span_warning("[tool]粘在你手上了！"))
			return ITEM_INTERACT_BLOCKING
		var/obj/item/fish/the_fish = tool
		if(the_fish.status == FISH_DEAD)
			to_chat(user, span_warning("你把[tool]放进了[src]，愿它安息。"))
		else
			to_chat(user, span_notice("你把[tool]放进了[src]，希望没人会想念它！"))
		LAZYADD(fishes, tool)
		return ITEM_INTERACT_SUCCESS

	if(cistern_open)
		if(istype(tool, /obj/item/stock_parts/water_recycler))
			if(has_water_reclaimer)
				to_chat(user, span_warning("[src]已经安装了水循环器。"))
				return ITEM_INTERACT_BLOCKING

			playsound(src, 'sound/machines/click.ogg', 20, TRUE)
			qdel(tool)
			has_water_reclaimer = TRUE
			begin_reclamation()
			return ITEM_INTERACT_SUCCESS

		if(tool.w_class > WEIGHT_CLASS_NORMAL)
			to_chat(user, span_warning("[tool]放不进去！"))
			return ITEM_INTERACT_BLOCKING
		if(w_items + tool.w_class > WEIGHT_CLASS_HUGE)
			to_chat(user, span_warning("水箱满了！"))
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			to_chat(user, span_warning("[tool]粘在你手上，你无法把它放进水箱！"))
			return ITEM_INTERACT_BLOCKING
		add_cistern_item(tool)
		to_chat(user, span_notice("你小心翼翼地把[tool]放进水箱。"))
		return ITEM_INTERACT_SUCCESS

	if(!cover_open)
		return NONE

	if(!is_reagent_container(tool))
		if(tool.w_class > WEIGHT_CLASS_SMALL)
			return NONE

		if(stuck_item)
			to_chat(user, span_warning("已经有东西堵住[src]的排水管了！"))
			return ITEM_INTERACT_BLOCKING

		if(!user.transferItemToLoc(tool, src))
			to_chat(user, span_warning("[tool]粘在你手上了！"))
			return ITEM_INTERACT_BLOCKING

		stuck_item = tool
		to_chat(user, span_notice("你把[tool]丢进了[src]的盆里。"))
		return ITEM_INTERACT_SUCCESS

	if(reagents.total_volume <= 0)
		to_chat(user, span_notice("[src]里是干的。"))
		return ITEM_INTERACT_BLOCKING

	if(istype(tool, /obj/item/food/monkeycube))
		var/obj/item/food/monkeycube/cube = tool
		cube.Expand()
		return ITEM_INTERACT_SUCCESS

	var/obj/item/reagent_containers/container = tool
	if(!container.is_refillable())
		return NONE

	if(container.reagents.holder_full())
		to_chat(user, span_notice("[container]装满了。"))
		return ITEM_INTERACT_BLOCKING

	reagents.trans_to(container, container.amount_per_transfer_from_this, transferred_by = user)
	begin_reclamation()
	to_chat(user, span_notice("你从[src]里装满了[container]。真恶心。"))
	return ITEM_INTERACT_SUCCESS

/// Hides an item inside the toilet for later retrievalk
/obj/structure/toilet/proc/add_cistern_item(obj/item/thing)
	if (isitem(thing))
		w_items += thing.w_class
	LAZYADD(cistern_items, thing)

/obj/structure/toilet/crowbar_act(mob/living/user, obj/item/tool)
	to_chat(user, span_notice("你开始[cistern_open ? "盖上" : "揭开"]水箱的盖子……"))
	playsound(loc, 'sound/effects/stonedoor_openclose.ogg', 50, TRUE)
	if(tool.use_tool(src, user, 30))
		user.visible_message(
			span_notice("[user][cistern_open ? "盖上了" : "揭开了"]水箱的盖子！"),
			span_notice("你[cistern_open ? "盖上了" : "揭开了"]水箱的盖子！"),
			span_hear("你听到瓷器摩擦的声音。"))
		cistern_open = !cistern_open
		update_appearance(UPDATE_ICON_STATE)
	return ITEM_INTERACT_SUCCESS

/obj/structure/toilet/screwdriver_act(mob/living/user, obj/item/tool)
	if(!cistern_open)
		to_chat(user, span_warning("你需要先打开[src]的水箱！"))
		return ITEM_INTERACT_BLOCKING

	if(!has_water_reclaimer)
		to_chat(user, span_warning("[src]没有安装水回收器。"))
		return ITEM_INTERACT_BLOCKING

	tool.play_tool_sound(src)
	has_water_reclaimer = FALSE
	new /obj/item/stock_parts/water_recycler(drop_location())
	to_chat(user, span_notice("你从[src]上拆下了水回收器。"))
	return ITEM_INTERACT_SUCCESS

/obj/structure/toilet/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	deconstruct()
	return ITEM_INTERACT_SUCCESS

/obj/structure/toilet/plunger_act(obj/item/plunger/attacking_plunger, mob/living/user, reinforced)
	user.balloon_alert_to_viewers("疯狂疏通中……")
	if(!do_after(user, 3 SECONDS, target = src))
		return TRUE
	user.balloon_alert_to_viewers("疏通完毕")
	reagents.expose(get_turf(src), TOUCH) //splash on the floor
	reagents.clear_reagents()
	begin_reclamation()
	if(stuck_item)
		stuck_item.forceMove(drop_location())
		stuck_item = null
	return TRUE

///Ends the flushing animation and updates overlays if necessary
/obj/structure/toilet/proc/end_flushing()
	flushing = FALSE
	if(cover_open && (dir & SOUTH))
		update_appearance(UPDATE_OVERLAYS)
	QDEL_LAZYLIST(fishes)

/obj/structure/toilet/proc/begin_reclamation()
	START_PROCESSING(SSobj, src)

/obj/structure/toilet/process(seconds_per_tick)
	// Water reclamation complete?
	if(!has_water_reclaimer || reagents.total_volume >= reagents.maximum_volume)
		return PROCESS_KILL
	reagents.add_reagent(reagent_id, reclaim_rate * seconds_per_tick)

/obj/structure/toilet/greyscale
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	custom_materials = null
	has_water_reclaimer = FALSE

/obj/structure/toilet/secret
	var/secret_type = null

/obj/structure/toilet/secret/Initialize(mapload)
	. = ..()
	if(!secret_type)
		return
	var/obj/item/secret = new secret_type(src)
	secret.desc += " 这是个秘密！"
	add_cistern_item(secret)

///A toilet made of meat that only drops remains when deconstructed, often unleashed unto this cursed plane of existence by hopeless people off'ing themselves with experi-scanners.
/obj/structure/toilet/greyscale/flesh
	desc = "一团令人毛骨悚然的融合血肉，外形却像标准型号的 HT-451 马桶。它究竟是怎么运作的，你完全想不明白。\
	这一台似乎是用科研部某位尽职员工的血肉做成的。"

/obj/structure/toilet/greyscale/flesh/Initialize(mapload, mob/living/suicide)
	. = ..()
	///The suicide victim's brain that will be placed inside the toilet's cistern
	var/obj/item/organ/brain/toilet_brain
	if(suicide)
		toilet_brain = suicide.get_organ_slot(ORGAN_SLOT_BRAIN)
		for(var/obj/item/thing in suicide)
			if (suicide.transferItemToLoc(thing, newloc = src, silent = TRUE))
				add_cistern_item(thing)
		suicide.gib(DROP_BRAIN) //we delete everything but the brain, as it's going to be moved to the cistern
		set_custom_materials(list(SSmaterials.get_material(/datum/material/meat/mob_meat, suicide) = SHEET_MATERIAL_AMOUNT))
	else
		toilet_brain = new(drop_location())
		set_custom_materials(list(/datum/material/meat = SHEET_MATERIAL_AMOUNT))

	if (toilet_brain)
		toilet_brain.forceMove(src)
		add_cistern_item(toilet_brain)

//this also prevents the toilet from dropping meat sheets. if you want to cheese the meat exepriments, sacrifice more people
/obj/structure/toilet/greyscale/flesh/atom_deconstruct(dissambled = TRUE)
	for(var/obj/toilet_item in cistern_items)
		toilet_item.forceMove(drop_location())
	new /obj/effect/decal/remains/human(loc)
