/obj/structure/displaycase
	name = "展示柜"
	icon = 'icons/obj/structures.dmi'
	icon_state = "glassbox"
	desc = "用来陈列珍贵物品的展示柜。"
	density = TRUE
	anchored = TRUE
	resistance_flags = ACID_PROOF
	armor_type = /datum/armor/structure_displaycase
	max_integrity = 200
	integrity_failure = 0.25
	///The showpiece item inside the case
	var/obj/item/showpiece = null
	///This allows for showpieces that can only hold items if they're the same istype as this.
	var/obj/item/showpiece_type = null
	///Is the displaycase hooked up to a burglar alarm?
	var/alert = TRUE
	///Is the displaycase open at the moment?
	var/open = FALSE
	///If we have a custom glass overlay to use.
	var/custom_glass_overlay = FALSE
	var/obj/item/electronics/airlock/electronics
	///Add type for items on display
	var/start_showpiece_type = null
	///Displaycase is fixed by glass
	var/glass_fix = TRUE
	///Represents a signel source of screaming when broken
	var/datum/alarm_handler/alarm_manager
	///Used for subtypes that have a UI in them. The examine on click while adjecent will not fire, as we already get a popup
	var/autoexamine_while_closed = TRUE

/datum/armor/structure_displaycase
	melee = 30
	bomb = 10
	fire = 70
	acid = 100

/obj/structure/displaycase/Initialize(mapload)
	. = ..()
	if(start_showpiece_type)
		showpiece = new start_showpiece_type (src)
	update_appearance()
	alarm_manager = new(src)

/obj/structure/displaycase/vv_edit_var(vname, vval)
	. = ..()
	if(vname in list(NAMEOF(src, open), NAMEOF(src, showpiece), NAMEOF(src, custom_glass_overlay)))
		update_appearance()

/obj/structure/displaycase/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == electronics)
		electronics = null
	if(gone == showpiece)
		showpiece = null
		update_appearance()

/obj/structure/displaycase/Destroy()
	QDEL_NULL(electronics)
	QDEL_NULL(showpiece)
	QDEL_NULL(alarm_manager)
	return ..()

/obj/structure/displaycase/examine(mob/user)
	. = ..()
	if(alert)
		. += span_notice("已接入防盗系统。")
	if(showpiece)
		. += span_notice("里面有一个[showpiece]。")

///Removes the showpiece from the displaycase
/obj/structure/displaycase/proc/dump()
	if(QDELETED(showpiece))
		return
	showpiece.forceMove(drop_location())

/obj/structure/displaycase/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(src, 'sound/effects/glass/glasshit.ogg', 75, TRUE)
		if(BURN)
			playsound(src, 'sound/items/tools/welder.ogg', 100, TRUE)

/obj/structure/displaycase/atom_deconstruct(disassembled = TRUE)
	dump()
	if(!disassembled)
		new /obj/item/shard(drop_location())
		trigger_alarm()

/obj/structure/displaycase/atom_break(damage_flag)
	. = ..()
	if(!broken)
		set_density(FALSE)
		broken = TRUE
		new /obj/item/shard(drop_location())
		playsound(src, SFX_SHATTER, 70, TRUE)
		update_appearance()
		trigger_alarm()

///Anti-theft alarm triggered when broken.
/obj/structure/displaycase/proc/trigger_alarm()
	if(!alert)
		return
	//var/area/alarmed = get_area(src) SKYRAT EDIT REMOVAL
	//alarmed.burglaralert(src) SKYRAT EDIT REMOVAL

	alarm_manager.send_alarm(ALARM_BURGLAR)
	addtimer(CALLBACK(alarm_manager, TYPE_PROC_REF(/datum/alarm_handler, clear_alarm), ALARM_BURGLAR), 1 MINUTES)

	playsound(src, 'sound/effects/alert.ogg', 50, TRUE)

/obj/structure/displaycase/update_overlays()
	. = ..()
	if(showpiece)
		var/mutable_appearance/showpiece_overlay = mutable_appearance(showpiece.icon, showpiece.icon_state)
		showpiece_overlay.copy_overlays(showpiece)
		showpiece_overlay.transform *= 0.6
		. += showpiece_overlay
	if(custom_glass_overlay)
		return
	if(broken)
		. += "[initial(icon_state)]_broken"
		return
	if(!open)
		. += "[initial(icon_state)]_closed"
		return

/obj/structure/displaycase/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(tool.GetID() && !broken)
		if(!allowed(user))
			to_chat(user, span_alert("访问被拒绝。"))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("你[open ? "关上" : "打开"]了[src]。"))
		toggle_lock(user)
		return ITEM_INTERACT_SUCCESS


	if(open && !showpiece)
		insert_showpiece(tool, user)
		return ITEM_INTERACT_SUCCESS //cancel the attack chain, whether we successfully placed an item or not

	if(glass_fix && broken && istype(tool, /obj/item/stack/sheet/glass))
		var/obj/item/stack/sheet/glass/glass_sheet = tool
		if(glass_sheet.get_amount() < 2)
			to_chat(user, span_warning("你需要两块玻璃来修复展示柜！"))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("你开始修复[src]……"))
		if(!do_after(user, 2 SECONDS, target = src))
			return ITEM_INTERACT_BLOCKING

		glass_sheet.use(2)
		broken = FALSE
		atom_integrity = max_integrity
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/structure/displaycase/welder_act(mob/living/user, obj/item/tool)
	if(user.combat_mode || broken)
		return ITEM_INTERACT_SKIP_TO_ATTACK

	if(atom_integrity == max_integrity)
		to_chat(user, span_warning("[src]的状况已经完好！"))
		return ITEM_INTERACT_BLOCKING

	if(!tool.tool_start_check(user, amount=1))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你开始修理[src]……"))
	if(!tool.use_tool(src, user, 40, volume=50))
		return ITEM_INTERACT_BLOCKING

	atom_integrity = max_integrity
	update_appearance()
	to_chat(user, span_notice("你修好了[src]。"))
	return ITEM_INTERACT_SUCCESS

/obj/structure/displaycase/crowbar_act(mob/living/user, obj/item/tool)
	if(alert) //Only applies to the lab cage and player made display cases
		return ITEM_INTERACT_SKIP_TO_ATTACK

	if(broken)
		if(showpiece)
			to_chat(user, span_warning("请先取走陈列的物品！"))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("你移除了损坏的柜子。"))
		qdel(src)
		return ITEM_INTERACT_SUCCESS

	to_chat(user, span_notice("你开始[open ? "关上" : "打开"][src]……"))
	if(!tool.use_tool(src, user, 20))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你[open ? "关上" : "打开"]了[src]。"))
	toggle_lock(user)
	return ITEM_INTERACT_SUCCESS


///Handles placing an item into the display case. Returns TRUE if the item failed to be placed inside the container, useful for descendants
/obj/structure/displaycase/proc/insert_showpiece(obj/item/new_showpiece, mob/user)
	if(showpiece_type && !istype(new_showpiece, showpiece_type))
		to_chat(user, span_notice("这不该放进这种展示柜里。"))
		return TRUE
	if(user.transferItemToLoc(new_showpiece, src))
		showpiece = new_showpiece
		to_chat(user, span_notice("你把[new_showpiece]放上了展台。"))
		update_appearance()

///Opens and closes the display case
/obj/structure/displaycase/proc/toggle_lock(mob/user)
	playsound(src, 'sound/machines/click.ogg', 20, TRUE)
	open = !open
	update_appearance()

/obj/structure/displaycase/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/displaycase/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	if (showpiece && (broken || open))
		to_chat(user, span_notice("你关闭了柜体内置的悬浮力场。"))
		log_combat(user, src, "关闭了悬浮力场")
		dump()
		add_fingerprint(user)
		return
	else
		//prevents remote "kicks" with TK
		if (!Adjacent(user))
			return
		if (!user.combat_mode)
			if(!open && !autoexamine_while_closed)
				return
			if(!user.is_blind())
				user.examinate(src)
			return
		user.visible_message(span_danger("[user]踢了展示柜一脚。"), null, null, COMBAT_MESSAGE_RANGE)
		log_combat(user, src, "踢了")
		user.do_attack_animation(src, ATTACK_EFFECT_KICK)
		take_damage(2)

/obj/structure/displaycase_chassis
	name = "展示柜底座"
	desc = "展示柜的木制底座。"
	icon = 'icons/obj/structures.dmi'
	icon_state = "glassbox_chassis"
	resistance_flags = FLAMMABLE
	anchored = TRUE
	density = FALSE
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 5)
	///The airlock electronics inserted into the chassis, to be moved to the finished product.
	var/obj/item/electronics/airlock/electronics

/obj/structure/displaycase_chassis/Initialize(mapload)
	. = ..()
	register_context()

/obj/structure/displaycase_chassis/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		return .

	if(held_item.tool_behaviour == TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_LMB] = "拆解"
		return CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/electronics/airlock) && !electronics)
		context[SCREENTIP_CONTEXT_LMB] = "安装电子元件"
		return CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/stock_parts/card_reader))
		context[SCREENTIP_CONTEXT_LMB] = "组装自助售卖托盘"
		return CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/stack/sheet/glass))
		context[SCREENTIP_CONTEXT_LMB] = "完成展示柜"
		return CONTEXTUAL_SCREENTIP_SET
	return .

/obj/structure/displaycase_chassis/examine(mob/user)
	. = ..()
	if(!electronics)
		. += span_notice("你可以安装[EXAMINE_HINT("气闸电子元件")]来设置进出权限。")
	. += span_notice("可以用[EXAMINE_HINT("10 块玻璃")]把[src]完成组装，或用[EXAMINE_HINT("读卡器")]把它变成自助售卖托盘。")

/obj/structure/displaycase_chassis/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	balloon_alert(user, "正在拆解……")
	tool.play_tool_sound(src)
	if(tool.use_tool(src, user, 3 SECONDS))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		new /obj/item/stack/sheet/mineral/wood(drop_location(), 5)
		if(electronics)
			electronics.forceMove(drop_location())
			electronics = null
		qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/structure/displaycase_chassis/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/electronics/airlock))
		balloon_alert(user, "正在安装电子元件……")
		if(!do_after(user, 3 SECONDS, target = src) || !user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING

		electronics = tool
		balloon_alert(user, "电子元件已安装")
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stock_parts/card_reader))
		balloon_alert(user, "正在安装[tool]……")
		if(!do_after(user, 2 SECONDS, target = src))
			return ITEM_INTERACT_BLOCKING

		qdel(tool)
		make_final_result(display_type = /obj/structure/displaycase/forsale)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stack/sheet/glass))
		var/obj/item/stack/sheet/glass/glass_sheets = tool
		if(glass_sheets.get_amount() < 10)
			balloon_alert(user, "需要 10 块玻璃！")
			return ITEM_INTERACT_BLOCKING

		balloon_alert(user, "正在安装玻璃……")
		if(!do_after(user, 2 SECONDS, target = src))
			return ITEM_INTERACT_BLOCKING

		glass_sheets.use(10)
		make_final_result(display_type = /obj/structure/displaycase/noalert)
		return ITEM_INTERACT_SUCCESS

	return NONE

///Makes the final result of the chassis, then deletes itself.
/obj/structure/displaycase_chassis/proc/make_final_result(obj/structure/displaycase/display_type)
	var/obj/structure/displaycase/display = new display_type(loc)
	if(electronics)
		electronics.forceMove(display)
		display.electronics = electronics
		if(electronics.one_access)
			display.req_one_access = electronics.accesses
		else
			display.req_access = electronics.accesses
	qdel(src)

//The lab cage and captain's display case do not spawn with electronics, which is why req_access is needed.
/obj/structure/displaycase/captain
	start_showpiece_type = /obj/item/gun/energy/laser/captain
	req_access = list(ACCESS_CAPTAIN)	//SKYRAT EDIT CHANGE - ORIGINAL: req_access = list(ACCESS_CENT_SPECOPS) //this was intentional, presumably to make it slightly harder for caps to grab their gun roundstart

/obj/structure/displaycase/labcage
	name = "实验笼"
	desc = "一个用于存放有趣生物的玻璃实验容器。"
	start_showpiece_type = /obj/item/clothing/mask/facehugger/lamarr
	req_access = list(ACCESS_RD)

/obj/structure/displaycase/noalert
	alert = FALSE

/obj/structure/displaycase/trophy
	name = "奖杯展示柜"
	desc = "把你的成就奖杯存放在这里，它们将永远留存。"
	integrity_failure = 0
	req_access = list(ACCESS_LIBRARY)
	autoexamine_while_closed = FALSE
	///the key of the player who placed the item in the case
	var/placer_key = ""
	///is the trophy a hologram, not a real item placed by a player?
	var/holographic_showpiece = FALSE
	///are we about to edit
	var/historian_mode = FALSE
	///the trophy message
	var/trophy_message = ""

/obj/structure/displaycase/trophy/Initialize(mapload)
	. = ..()
	GLOB.trophy_cases += src

/obj/structure/displaycase/trophy/Destroy()
	GLOB.trophy_cases -= src
	return ..()

///Creates a showpiece dummy to display, using persistent data
/obj/structure/displaycase/trophy/proc/set_up_trophy(datum/trophy_data/chosen_trophy)
	showpiece = new /obj/item/showpiece_dummy(src, text2path(chosen_trophy.path))
	trophy_message = trim(chosen_trophy.message, MAX_PLAQUE_LEN)
	if(trophy_message == "")
		trophy_message = trim(showpiece.desc, MAX_PLAQUE_LEN)
	placer_key = trim(chosen_trophy.placer_key)
	holographic_showpiece = TRUE
	update_appearance()

/obj/structure/displaycase/trophy/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/key/displaycase))
		return ..()
	toggle_historian_mode(user)
	return ITEM_INTERACT_SUCCESS

/obj/structure/displaycase/trophy/dump()
	if (showpiece)
		if(holographic_showpiece)
			visible_message(span_danger("[showpiece]嘶嘶作响，然后消失了！"))
			do_sparks(number = 1, cardinal_only = FALSE, source = src)
			QDEL_NULL(showpiece)
			holographic_showpiece = FALSE
		else
			..()
		placer_key = ""
		trophy_message = null

/obj/structure/displaycase/trophy/insert_showpiece(obj/item/new_showpiece, mob/user)
	if(..())
		return TRUE
	if(showpiece == new_showpiece)
		placer_key = user.ckey

///Toggles the mode that shows the historian panel on the UI, enabling saving the looks and the trophy message of the current trophy
/obj/structure/displaycase/trophy/proc/toggle_historian_mode(mob/user)
	historian_mode = !historian_mode
	balloon_alert(user, "[historian_mode ? "已启用" : "已停用"]历史学家模式。")
	playsound(src, 'sound/machines/beep/twobeep.ogg', 10, vary = 50)
	SStgui.update_uis(src)

/obj/structure/displaycase/trophy/toggle_lock(mob/user)
	..()
	SStgui.close_uis(src)

/obj/structure/displaycase/trophy/ui_data(mob/user)
	var/list/data = list()
	data["historian_mode"] = historian_mode
	data["holographic_showpiece"] = holographic_showpiece
	data["max_length"] = MAX_PLAQUE_LEN
	data["has_showpiece"] = showpiece ? TRUE : FALSE
	if(showpiece)
		data["showpiece_name"] = capitalize(format_text(showpiece.name))
		data["showpiece_description"] = trophy_message ? format_text(trophy_message) : null
	return data

/obj/structure/displaycase/trophy/ui_static_data(mob/user)
	var/list/data = list()
	if(showpiece)
		data["showpiece_icon"] = icon2base64(getFlatIcon(showpiece, no_anim=TRUE))
	return data

/obj/structure/displaycase/trophy/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("insert_key")
			if(historian_mode)
				return
			var/obj/item/key/displaycase/trophy_key = usr.get_active_held_item()
			if(istype(trophy_key))
				toggle_historian_mode(usr)
				return TRUE
			return
		if("change_message")
			if(showpiece && !holographic_showpiece)
				var/new_trophy_message = tgui_input_text(usr, "让我们创造历史！", "奖杯留言", trophy_message, max_length = MAX_PLAQUE_LEN)
				if(!new_trophy_message)
					return
				trophy_message = new_trophy_message
				return TRUE
		if("lock")
			if(!historian_mode)
				return
			toggle_historian_mode(usr)
			return TRUE

/obj/structure/displaycase/trophy/ui_interact(mob/user, datum/tgui/ui)
	if(open)
		return
	if(isliving(usr))
		var/mob/living/living_usr = usr
		if(living_usr.combat_mode)
			return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Trophycase", name)
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/item/key/displaycase
	name = "馆长钥匙"
	desc = "用来开启馆长展示柜和街机柜的钥匙。"

/obj/item/showpiece_dummy
	name = "全息复制品"

/obj/item/showpiece_dummy/Initialize(mapload, path)
	. = ..()
	var/obj/item/item_path = path
	name = initial(item_path.name)
	desc = initial(item_path.desc)
	icon = initial(item_path.icon)
	icon_state = initial(item_path.icon_state)

/obj/structure/displaycase/forsale
	name = "自助售卖托盘"
	icon = 'icons/obj/machines/display.dmi'
	icon_state = "laserbox"
	custom_glass_overlay = TRUE
	desc = "带有 ID 卡刷卡器的展示柜。用你的 ID 卡购买其中的物品。"
	density = FALSE
	max_integrity = 100
	req_access = null
	alert = FALSE //No, we're not calling the fire department because someone stole your cookie.
	glass_fix = FALSE //Fixable with tools instead.
	pass_flags = PASSTABLE ///Can be placed and moved onto a table.
	autoexamine_while_closed = FALSE
	///The price of the item being sold. Altered by grab intent ID use.
	var/sale_price = 20
	///The Account which will receive payment for purchases. Set by the first ID to swipe the tray.
	var/datum/bank_account/payments_acc = null

/obj/structure/displaycase/forsale/update_icon_state()
	icon_state = "[initial(icon_state)][broken ? "_broken" : (open ? "_open" : (!showpiece ? "_empty" : null))]"
	return ..()

/obj/structure/displaycase/forsale/update_overlays()
	. = ..()
	if(!broken && !open)
		. += "[initial(icon_state)]_overlay"

/obj/structure/displaycase/forsale/insert_showpiece(obj/item/new_showpiece, mob/user)
	if(..())
		return TRUE
	update_static_data_for_all_viewers()

/obj/structure/displaycase/forsale/dump()
	..()
	update_static_data_for_all_viewers()

/obj/structure/displaycase/forsale/toggle_lock()
	..()
	SStgui.update_uis(src)

/obj/structure/displaycase/forsale/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Vendatray", name)
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/structure/displaycase/forsale/ui_data(mob/user)
	var/list/data = list()
	data["owner_name"] = payments_acc ? payments_acc.account_holder : null
	data["product_name"] = showpiece ?capitalize(format_text(showpiece.name)) : null
	data["registered"] = payments_acc ? TRUE : FALSE
	data["product_cost"] = sale_price
	data["tray_open"] = open
	return data

/obj/structure/displaycase/forsale/ui_static_data(mob/user)
	var/list/data = list()
	data["product_icon"] = showpiece ? icon2base64(getFlatIcon(showpiece, no_anim=TRUE)) : null
	return data

/obj/structure/displaycase/forsale/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	var/obj/item/card/id/potential_acc
	if(isliving(usr))
		var/mob/living/L = usr
		potential_acc = L.get_idcard(hand_first = TRUE)
	switch(action)
		if("Buy")
			if(!showpiece)
				to_chat(usr, span_notice("没有东西可卖。"))
				return TRUE
			if(broken)
				to_chat(usr, span_notice("[src]似乎已经损坏。"))
				return TRUE
			if(!payments_acc)
				to_chat(usr, span_notice("[src]尚未注册。"))
				return TRUE
			if(!usr.can_perform_action(src, FORBID_TELEKINESIS_REACH))
				return TRUE
			if(!potential_acc)
				to_chat(usr, span_notice("未检测到 ID 卡。"))
				return
			var/datum/bank_account/account = potential_acc.registered_account
			if(!account)
				to_chat(usr, span_notice("[potential_acc]没有登记账户！"))
				return
			if(!account.has_money(sale_price))
				to_chat(usr, span_notice("你没有足够的资金购买它。"))
				return TRUE
			else
				account.adjust_money(-sale_price, "展示柜：[capitalize(showpiece.name)]")
				if(payments_acc)
					payments_acc.adjust_money(sale_price, "展示柜：[capitalize(showpiece.name)]")
				usr.put_in_hands(showpiece)
				to_chat(usr, span_notice("你花 [sale_price] [MONEY_NAME]买下了[showpiece]。"))
				playsound(src, 'sound/effects/cashregister.ogg', 40, TRUE)
				flick("[initial(icon_state)]_vend", src)
				showpiece = null
				update_appearance()
				update_static_data_for_all_viewers()
				return TRUE
		if("Open")
			if(!payments_acc)
				to_chat(usr, span_notice("[src]尚未注册。"))
				return TRUE
			if(!potential_acc || !potential_acc.registered_account)
				return
			if(!check_access(potential_acc))
				playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, TRUE)
				return
			toggle_lock()
		if("Register")
			if(payments_acc)
				return
			if(!potential_acc || !potential_acc.registered_account)
				return
			if(!check_access(potential_acc))
				playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, TRUE)
				return
			payments_acc = potential_acc.registered_account
			playsound(src, 'sound/machines/click.ogg', 20, TRUE)
		if("Adjust")
			if(!check_access(potential_acc) || potential_acc.registered_account != payments_acc)
				playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, TRUE)
				return

			var/new_price_input = tgui_input_number(usr, "这台自助售卖托盘的售价", "新价格", 10, 1000)
			if(!new_price_input || QDELETED(usr) || QDELETED(src))
				return
			if(payments_acc != potential_acc.registered_account)
				to_chat(usr, span_warning("[src]拒绝了你的新价格。"))
				return
			if(!usr.can_perform_action(src, FORBID_TELEKINESIS_REACH))
				to_chat(usr, span_warning("你需要靠近一点！"))
				return
			sale_price = new_price_input
			to_chat(usr, span_notice("价格已设为 [sale_price]。"))
			SStgui.update_uis(src)
			return TRUE
	. = TRUE

/obj/structure/displaycase/forsale/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(isidcard(tool))
		//Card Registration
		var/obj/item/card/id/potential_acc = tool
		if(!potential_acc.registered_account)
			to_chat(user, span_warning("这张 ID 卡没有登记账户！"))
			return ITEM_INTERACT_BLOCKING

		if(payments_acc != potential_acc.registered_account)
			return ITEM_INTERACT_BLOCKING

		toggle_lock()
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/modular_computer))
		return ITEM_INTERACT_BLOCKING

	SStgui.update_uis(src)
	return ITEM_INTERACT_SUCCESS

/obj/structure/displaycase/forsale/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	if(atom_integrity <= (integrity_failure * max_integrity))
		to_chat(user, span_notice("你开始重新校准[src]的悬浮力场……"))
		if(do_after(user, 2 SECONDS, target = src))
			broken = FALSE
			atom_integrity = max_integrity
			update_appearance()
		return TRUE

/obj/structure/displaycase/forsale/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(open && !user.combat_mode)
		if(anchored)
			to_chat(user, span_notice("你开始解除[src]的固定……"))
		else
			to_chat(user, span_notice("你开始固定[src]……"))
		if(I.use_tool(src, user, 16, volume=50))
			if(QDELETED(I))
				return
			if(anchored)
				to_chat(user, span_notice("你解除了[src]的固定。"))
			else
				to_chat(user, span_notice("你固定了[src]。"))
			set_anchored(!anchored)
			return TRUE
	else if(!open && !user.combat_mode)
		to_chat(user, span_notice("要移动[src]，必须先打开它。"))
		return

/obj/structure/displaycase/forsale/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	payments_acc = null
	req_access = list()
	balloon_alert(user, "账户所有者已重置")
	to_chat(user, span_warning("[src]的读卡器嘶嘶作响，冒起了烟。"))
	return TRUE

/obj/structure/displaycase/forsale/examine(mob/user)
	. = ..()
	if(showpiece && !open)
		. += span_notice("[showpiece]正以 [sale_price] [MONEY_NAME]的价格出售。")
	if(broken)
		. += span_notice("[src]正在冒火花，悬浮力场发生器似乎过载了。用多功能工具可以修好。")

/obj/structure/displaycase/forsale/atom_break(damage_flag)
	. = ..()
	if(!broken)
		broken = TRUE
		playsound(src, SFX_SHATTER, 70, TRUE)
		update_appearance()
		trigger_alarm() //In case it's given an alarm anyway.

/obj/structure/displaycase/forsale/kitchen
	desc = "带有 ID 卡刷卡器的展示柜。用你的 ID 卡购买其中的物品。供调酒师和厨师使用。"
	req_one_access = list(ACCESS_KITCHEN, ACCESS_BAR)
