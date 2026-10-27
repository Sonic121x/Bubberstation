/obj/item/delivery
	icon = 'icons/obj/storage/wrapping.dmi' //ICON OVERRIDEN IN SKYRAT AESTHETICS - SEE MODULE
	inhand_icon_state = "deliverypackage"
	obj_flags = UNIQUE_RENAME | RENAME_NO_DESC
	var/giftwrapped = 0
	var/sort_tag = 0
	var/obj/item/paper/note
	var/obj/item/barcode/sticker

/obj/item/delivery/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_DISPOSING, PROC_REF(disposal_handling))

/**
 * Initial check if manually unwrapping
 */
/obj/item/delivery/proc/attempt_pre_unwrap_contents(mob/user, time = 1.5 SECONDS)
	to_chat(user, span_notice("你开始拆开包裹……"))
	return do_after(user, time, target = user)

/**
 * Signals for unwrapping.
 */
/obj/item/delivery/proc/unwrap_contents()
	if(!sticker)
		return
	for(var/atom/movable/movable_content as anything in contents)
		SEND_SIGNAL(movable_content, COMSIG_ITEM_UNWRAPPED)

/**
 * Effects after completing unwrapping
 */
/obj/item/delivery/proc/post_unwrap_contents(mob/user, rip_open = TRUE)
	var/turf/turf_loc = get_turf(user || src)
	if(rip_open)
		playsound(loc, 'sound/items/poster/poster_ripped.ogg', 50, TRUE)
		new /obj/effect/decal/cleanable/wrapping(turf_loc)
	else
		playsound(loc, 'sound/items/box_cut.ogg', 50, TRUE)
		new /obj/item/stack/package_wrap/one(turf_loc)
	for(var/atom/movable/movable_content as anything in contents)
		movable_content.forceMove(turf_loc)

	qdel(src)

/obj/item/delivery/contents_explosion(severity, target)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			SSexplosions.high_mov_atom += contents
		if(EXPLODE_HEAVY)
			SSexplosions.med_mov_atom += contents
		if(EXPLODE_LIGHT)
			SSexplosions.low_mov_atom += contents

/obj/item/delivery/atom_deconstruct(dissambled = TRUE)
	unwrap_contents()
	post_unwrap_contents()

/obj/item/delivery/examine(mob/user)
	. = ..()
	if(note)
		if(!in_range(user, src))
			. += span_info("上面附着 [EXAMINE_HINT(note.name)]。你在这里读不到内容。")
		else
			. += span_info("上面附着 [EXAMINE_HINT(note.name)]……")
			. += note.examine(user)
	if(sticker)
		. += span_notice("侧面贴着一张 [EXAMINE_HINT("条形码")]，包裹已被标记为 [EXAMINE_HINT("出口货物")]。")
	if(sort_tag)
		. += span_notice("上面贴着一张 [EXAMINE_HINT("分拣标签")]，目的地设为 [EXAMINE_HINT("[GLOB.TAGGERLOCATIONS[sort_tag]]。")]")

/obj/item/delivery/proc/disposal_handling(disposal_source, obj/structure/disposalholder/disposal_holder, obj/machinery/disposal/disposal_machine, hasmob)
	SIGNAL_HANDLER
	if(!hasmob)
		disposal_holder.destinationTag = sort_tag

/obj/item/delivery/relay_container_resist_act(mob/living/user, obj/container)
	if(ismovable(loc))
		var/atom/movable/movable_loc = loc //can't unwrap the wrapped container if it's inside something.
		movable_loc.relay_container_resist_act(user, container)
		return
	to_chat(user, span_notice("你抵住 [container] 的背面，开始用力推，想撕开外面的包装。"))
	if(do_after(user, 5 SECONDS, target = container))
		if(!user || IS_UNCONSCIOUS_OR_CRIT(user) || user.loc != container || container.loc != src)
			return
		to_chat(user, span_notice("你成功拆掉了 [container] 的包装！"))
		container.forceMove(loc)
		unwrap_contents()
		post_unwrap_contents(user)
	else
		if(user.loc == src) //so we don't get the message if we resisted multiple times and succeeded.
			to_chat(user, span_warning("你没能拆掉 [container] 的包装！"))

/obj/item/delivery/update_icon_state()
	. = ..()
	icon_state = giftwrapped ? "gift[base_icon_state]" : base_icon_state

/obj/item/delivery/update_overlays()
	. = ..()
	if(sort_tag)
		. += "[base_icon_state]_sort"
	if(note)
		. += "[base_icon_state]_note"
	if(sticker)
		. += "[base_icon_state]_barcode"

/obj/item/delivery/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/dest_tagger))
		var/relevant_tag = astype(tool, /obj/item/dest_tagger).currTag
		if(sort_tag == relevant_tag)
			return ITEM_INTERACT_BLOCKING
		var/tag = uppertext(GLOB.TAGGERLOCATIONS[relevant_tag])
		to_chat(user, span_notice("*[tag]*"))
		sort_tag = relevant_tag
		playsound(loc, 'sound/machines/beep/twobeep_high.ogg', 100, TRUE)
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stack/wrapping_paper))
		if(giftwrapped)
			return ITEM_INTERACT_BLOCKING
		var/obj/item/stack/wrapping_paper/wrapping_paper = tool
		if(!wrapping_paper.use(3))
			to_chat(user, span_warning("你需要更多纸！"))
			return ITEM_INTERACT_BLOCKING
		user.visible_message(span_notice("[user] 用节日包装纸把包裹包了起来！"))
		giftwrapped = TRUE
		greyscale_config = text2path("/datum/greyscale_config/gift[icon_state]")
		set_greyscale(colors = wrapping_paper.greyscale_colors)
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/paper))
		if(note)
			to_chat(user, span_warning("这个包裹已经附有一张便条了！"))
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			to_chat(user, span_warning("不知为何，你无法附上 [tool]！"))
			return ITEM_INTERACT_BLOCKING
		user.visible_message(span_notice("[user] 把 [tool] 附到了 [src] 上。"), span_notice("你把 [tool] 附到了 [src] 上。"))
		note = tool
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/universal_scanner))
		var/obj/item/universal_scanner/sales_tagger = tool
		if(sales_tagger.scanning_mode != SCAN_SALES_TAG)
			return ITEM_INTERACT_BLOCKING
		if(sticker)
			to_chat(user, span_warning("这个包裹已经贴有条形码了！"))
			return ITEM_INTERACT_BLOCKING
		if(!(sales_tagger.payments_acc))
			to_chat(user, span_warning("请先用 ID 卡刷一下 [sales_tagger]！"))
			return ITEM_INTERACT_BLOCKING
		if(sales_tagger.paper_count <= 0)
			to_chat(user, span_warning("[sales_tagger] 没纸了！"))
			return ITEM_INTERACT_BLOCKING
		user.visible_message(span_notice("[user] 给 [src] 贴上了一张条形码。"), span_notice("你给 [src] 贴上了一张条形码。"))
		sales_tagger.paper_count -= 1
		sticker = new /obj/item/barcode(src)
		sticker.payments_acc = sales_tagger.payments_acc	//new tag gets the tagger's current account.
		sticker.cut_multiplier = sales_tagger.cut_multiplier	//same, but for the percentage taken.

		for(var/obj/wrapped_item in get_all_contents())
			if(HAS_TRAIT(wrapped_item, TRAIT_NO_BARCODES))
				continue
			wrapped_item.AddComponent(/datum/component/pricetag, list(sticker.payments_acc), sales_tagger.cut_multiplier)
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/barcode))
		var/obj/item/barcode/stickerA = tool
		if(sticker)
			to_chat(user, span_warning("这个包裹已经贴有条形码了！"))
			return ITEM_INTERACT_BLOCKING
		if(!(stickerA.payments_acc))
			to_chat(user, span_warning("这张条形码似乎无效。看来只能当垃圾了。"))
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			to_chat(user, span_warning("不知为何，你无法附上 [tool]！"))
			return ITEM_INTERACT_BLOCKING
		sticker = stickerA
		for(var/obj/wrapped_item in get_all_contents())
			if(HAS_TRAIT(wrapped_item, TRAIT_NO_BARCODES))
				continue
			wrapped_item.AddComponent(/datum/component/pricetag, list(sticker.payments_acc), sticker.cut_multiplier)
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/boxcutter))
		var/obj/item/boxcutter/boxcutter_item = tool
		if(!HAS_TRAIT(boxcutter_item, TRAIT_TRANSFORM_ACTIVE))
			balloon_alert(user, "先推出开箱刀的刀片！")
			return ITEM_INTERACT_BLOCKING
		if(!attempt_pre_unwrap_contents(user, time = 0.5 SECONDS))
			return ITEM_INTERACT_BLOCKING
		unwrap_contents()
		post_unwrap_contents(user, rip_open = FALSE)
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/delivery/nameformat(input, user)
	playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
	return "[name] ([input])" // This just repeatedly adds new labels, but i think that's intentional?

/**
 * # Wrapped up crates and lockers - too big to carry.
 */
/obj/item/delivery/big
	name = "大包裹"
	desc = "一个大型投递包裹。"
	icon_state = "deliverycloset"
	density = TRUE
	interaction_flags_item = 0 // Disable the ability to pick it up. Wow!
	layer = BELOW_OBJ_LAYER
	pass_flags_self = PASSSTRUCTURE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND
	w_class = WEIGHT_CLASS_GIGANTIC

/obj/item/delivery/big/interact(mob/user)
	if(!attempt_pre_unwrap_contents(user))
		return
	unwrap_contents()
	post_unwrap_contents()

/**
 * # Wrapped up items small enough to carry.
 */
/obj/item/delivery/small
	name = "包裹"
	desc = "一个棕色纸包装的投递包裹。"
	icon_state = "deliverypackage3"

/obj/item/delivery/small/attack_self(mob/user)
	if(!attempt_pre_unwrap_contents(user))
		return
	user.temporarilyRemoveItemFromInventory(src, TRUE)
	unwrap_contents()
	for(var/atom/movable/movable_content as anything in contents)
		user.put_in_hands(movable_content)
	post_unwrap_contents(user)

/obj/item/delivery/small/attack_self_tk(mob/user)
	if(ismob(loc))
		var/mob/M = loc
		M.temporarilyRemoveItemFromInventory(src, TRUE)
		for(var/atom/movable/movable_content as anything in contents)
			M.put_in_hands(movable_content)
	else
		for(var/atom/movable/movable_content as anything in contents)
			movable_content.forceMove(loc)

	unwrap_contents()
	post_unwrap_contents(user)
	return ITEM_INTERACT_BLOCKING

/obj/item/dest_tagger
	name = "目的地标签器"
	desc = "用于设置已妥善包装包裹的目的地。"
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "cargo tagger"
	worn_icon_state = "cargotagger"
	var/currTag = 0 //Destinations are stored in code\globalvars\lists\flavor_misc.dm
	var/locked_destination = FALSE //if true, users can't open the destination tag window to prevent changing the tagger's current destination
	w_class = WEIGHT_CLASS_TINY
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.5)

/obj/item/dest_tagger/borg
	name = "半机械人目的地标签器"
	desc = "用于骗过垃圾邮件网络，让它以为你是一个无害的包裹。它也能当作普通目的地标签器使用。"

/obj/item/dest_tagger/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 开始给自己标记最终目的地！看起来是想自杀！"))
	if (islizard(user))
		to_chat(user, span_notice("*地狱*"))//lizard nerf
	else
		to_chat(user, span_notice("*天堂*"))
	playsound(src, 'sound/machines/beep/twobeep_high.ogg', 100, TRUE)
	return BRUTELOSS

/** Standard TGUI actions */
/obj/item/dest_tagger/ui_interact(mob/user, datum/tgui/ui)
	add_fingerprint(user)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DestinationTagger", name)
		ui.set_autoupdate(FALSE)
		ui.open()

/** If the user dropped the tagger */
/obj/item/dest_tagger/ui_state(mob/user)
	return GLOB.inventory_state

/** User activates in hand */
/obj/item/dest_tagger/attack_self(mob/user)
	if(!locked_destination)
		ui_interact(user)
		return

/** Data sent to TGUI window */
/obj/item/dest_tagger/ui_data(mob/user)
	var/list/data = list()
	data["locations"] = GLOB.TAGGERLOCATIONS
	data["currentTag"] = currTag
	return data

/** User clicks a button on the tagger */
/obj/item/dest_tagger/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("change")
			var/new_tag = round(text2num(params["index"]))
			if(new_tag == currTag || new_tag < 1 || new_tag > length(GLOB.TAGGERLOCATIONS))
				return
			currTag = new_tag
	return TRUE

/obj/item/sales_tagger
	name = "销售标签器"
	desc = "一台扫描器，可以给包装好的物品贴上出售标签，并将利润分给你和货运部。"
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "sales tagger"
	worn_icon_state = "salestagger"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_BELT
	///The account which is receiving the split profits.
	var/datum/bank_account/payments_acc = null
	var/paper_count = 10
	var/max_paper_count = 20
	///The person who tagged this will receive the sale value multiplied by this number.
	var/cut_multiplier = 0.5
	///Maximum value for cut_multiplier.
	var/cut_max = 0.5
	///Minimum value for cut_multiplier.
	var/cut_min = 0.01

/obj/item/sales_tagger/examine(mob/user)
	. = ..()
	. += span_notice("[src] 还有 [paper_count]/[max_paper_count] 张可用条形码。可用纸张补充。")
	. += span_notice("售出后的利润分成目前设为 [round(cut_multiplier*100)]%。<b>Alt 点击</b>可更改。")
	if(payments_acc)
		. += span_notice("<b>Ctrl 点击</b>可清除已注册账户。")

/obj/item/sales_tagger/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(isidcard(tool))
		var/obj/item/card/id/potential_acc = tool
		if(!potential_acc.registered_account)
			to_chat(user, span_warning("这张 ID 卡没有注册账户！"))
			return ITEM_INTERACT_BLOCKING
		if(payments_acc == potential_acc.registered_account)
			to_chat(user, span_notice("ID 卡已注册。"))
			return ITEM_INTERACT_BLOCKING
		payments_acc = potential_acc.registered_account
		playsound(src, 'sound/machines/ping.ogg', 40, TRUE)
		to_chat(user, span_notice("[src] 登记了这张 ID 卡。给包装好的物品贴标签即可生成条形码。"))
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/paper))
		if ((paper_count >= max_paper_count))
			to_chat(user, span_notice("[src] 的纸张储备已满。"))
			return ITEM_INTERACT_BLOCKING
		paper_count += 10
		qdel(tool)
		if (paper_count >= max_paper_count)
			paper_count = max_paper_count
			to_chat(user, span_notice("[src] 的纸张储备现在已满。"))
			return ITEM_INTERACT_SUCCESS
		to_chat(user, span_notice("你补充了 [src] 的纸张储备，还剩 [paper_count] 张。"))
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/sales_tagger/attack_self(mob/user)
	. = ..()
	if(paper_count <= 0)
		to_chat(user, span_warning("你没纸了！"))
		return
	if(!payments_acc)
		to_chat(user, span_warning("你需要先用 ID 卡刷一下 [src]。"))
		return
	paper_count -= 1
	playsound(src, 'sound/machines/click.ogg', 40, TRUE)
	to_chat(user, span_notice("你打印了一张新条形码。"))
	var/obj/item/barcode/new_barcode = new /obj/item/barcode(src)
	new_barcode.payments_acc = payments_acc		// The sticker gets the scanner's registered account.
	new_barcode.cut_multiplier = cut_multiplier		// Also the registered percent cut.
	user.put_in_hands(new_barcode)

/obj/item/sales_tagger/item_ctrl_click(mob/user)
	payments_acc = null
	to_chat(user, span_notice("你清除了已注册账户。"))
	return CLICK_ACTION_SUCCESS

/obj/item/sales_tagger/click_alt(mob/user)
	var/potential_cut = input("你想向已注册的卡片支付多少？","利润分成比例（[round(cut_min*100)]% - [round(cut_max*100)]%）") as num|null
	if(!potential_cut)
		cut_multiplier = initial(cut_multiplier)
	cut_multiplier = clamp(round(potential_cut/100, cut_min), cut_min, cut_max)
	to_chat(user, span_notice("[round(cut_multiplier*100)]% 的利润将在带条形码的包裹售出后发放。"))
	return CLICK_ACTION_SUCCESS
