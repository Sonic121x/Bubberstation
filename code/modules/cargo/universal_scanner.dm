#define PAPER_PER_SHEET 10

/obj/item/universal_scanner
	name = "通用扫描仪"
	desc = "一台用于对照纳米传讯出口数据库检查物品、贴上价签，或为自定义自动售货机准备商品的设备。"
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "export scanner"
	worn_icon_state = "electronic"
	inhand_icon_state = "export_scanner"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	/// Which mode is the scanner currently on?
	var/scanning_mode = SCAN_EXPORTS
	/// A list of all available export scanner modes.
	var/list/scale_mode = list()
	/// The paper currently stored by the export scanner.
	var/paper_count = 10
	/// The maximum paper to be stored by the export scanner.
	var/max_paper_count = 20

	/// The price of the item used by price tagger mode.
	var/new_custom_price = 1

	/// The account which is receiving the split profits in sales tagger mode.
	var/datum/bank_account/payments_acc = null
	/// The person who tagged this will receive the sale value multiplied by this number in sales tagger mode.
	var/cut_multiplier = 0.5
	/// Maximum value for cut_multiplier in sales tagger mode.
	var/cut_max = 0.5
	/// Minimum value for cut_multiplier in sales tagger mode.
	var/cut_min = 0.01

/obj/item/universal_scanner/Initialize(mapload)
	. = ..()
	scale_mode = sort_list(list(
		"export scanner" = image(icon = src.icon, icon_state = "export scanner"),
		"price tagger" = image(icon = src.icon, icon_state = "price tagger"),
		"sales tagger" = image(icon = src.icon, icon_state = "sales tagger"),
))
	register_context()

/obj/item/universal_scanner/attack_self(mob/user, modifiers)
	. = ..()
	var/choice = show_radial_menu(user, src, scale_mode, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE
	if(icon_state == "[choice]")
		return FALSE
	switch(choice)
		if("export scanner")
			scanning_mode = SCAN_EXPORTS
		if("price tagger")
			scanning_mode = SCAN_PRICE_TAG
		if("sales tagger")
			scanning_mode = SCAN_SALES_TAG
	icon_state = "[choice]"
	playsound(src, 'sound/machines/click.ogg', 40, TRUE)

/obj/item/universal_scanner/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isobj(interacting_with))
		return NONE
	if(scanning_mode == SCAN_EXPORTS)
		export_scan(interacting_with, user)
		return ITEM_INTERACT_SUCCESS
	if(scanning_mode == SCAN_PRICE_TAG)
		price_tag(interacting_with, user)
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/universal_scanner/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(scanning_mode == SCAN_SALES_TAG && isidcard(tool))
		var/obj/item/card/id/potential_acc = tool
		if(!potential_acc.registered_account)
			to_chat(user, span_warning("这张 ID 卡没有登记账户！"))
			return ITEM_INTERACT_BLOCKING

		if(payments_acc == potential_acc.registered_account)
			to_chat(user, span_notice("该 ID 卡已登记。"))
			return ITEM_INTERACT_BLOCKING

		payments_acc = potential_acc.registered_account
		playsound(src, 'sound/machines/ping.ogg', 40, TRUE)
		to_chat(user, span_notice("[src] 已登记该 ID 卡。给包装好的物品贴标即可生成条形码。"))
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/paper))
		if (paper_count >= max_paper_count)
			to_chat(user, span_notice("[src] 的纸张储备已满。"))
			return ITEM_INTERACT_BLOCKING

		paper_count += PAPER_PER_SHEET
		qdel(tool)
		if (paper_count >= max_paper_count)
			paper_count = max_paper_count
			to_chat(user, span_notice("[src] 的纸张储备现已装满。"))
			return ITEM_INTERACT_SUCCESS

		to_chat(user, span_notice("你补充了 [src] 的纸张储备，还剩 [paper_count] 张。"))
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/universal_scanner/attack_self_secondary(mob/user, modifiers)
	. = ..()
	if(scanning_mode == SCAN_SALES_TAG)
		if(paper_count <= 0)
			to_chat(user, span_warning("你没有纸了！"))
			return
		if(!payments_acc)
			to_chat(user, span_warning("你需要先用 ID 卡刷一下 [src]。"))
			return
		paper_count--
		playsound(src, 'sound/machines/click.ogg', 40, TRUE)
		to_chat(user, span_notice("你打印了一张新的条形码。"))
		var/obj/item/barcode/new_barcode = new /obj/item/barcode(src)
		new_barcode.payments_acc = payments_acc		// The sticker gets the scanner's registered account.
		new_barcode.cut_multiplier = cut_multiplier		// Also the registered percent cut.
		user.put_in_hands(new_barcode)
	if(scanning_mode == SCAN_PRICE_TAG)
		if(loc != user)
			to_chat(user, span_warning("你必须手持 [src] 才能继续！"))
			return
		var/chosen_price = tgui_input_number(user, "设定价格", "价格", new_custom_price)
		if(!chosen_price || QDELETED(user) || QDELETED(src) || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH) || loc != user)
			return
		new_custom_price = chosen_price
		to_chat(user, span_notice("[src] 现在会为物品贴上 [new_custom_price] [MONEY_SYMBOL] 的标签。"))

/obj/item/universal_scanner/item_ctrl_click(mob/user)
	. = CLICK_ACTION_BLOCKING
	if(scanning_mode == SCAN_SALES_TAG)
		payments_acc = null
		to_chat(user, span_notice("你清除了已登记的账户。"))
		return CLICK_ACTION_SUCCESS

/obj/item/universal_scanner/click_alt(mob/user)
	if(!scanning_mode == SCAN_SALES_TAG)
		return CLICK_ACTION_BLOCKING
	var/potential_cut = input("你希望向已登记的卡支付多少分成？","利润百分比（[round(cut_min*100)]% - [round(cut_max*100)]%）") as num|null
	if(!potential_cut)
		cut_multiplier = initial(cut_multiplier)
	cut_multiplier = clamp(round(potential_cut/100, cut_min), cut_min, cut_max)
	to_chat(user, span_notice("带有条形码的包裹售出后，可获得 [round(cut_multiplier*100)]% 的利润分成。"))
	return CLICK_ACTION_SUCCESS

/obj/item/universal_scanner/examine(mob/user)
	. = ..()
	. += span_notice("可用条形码：[paper_count]/[max_paper_count]。可用纸张补充。")

	if(scanning_mode == SCAN_SALES_TAG)
		. += span_notice("目前售出利润分成设为 [round(cut_multiplier*100)]%。<b>Alt 点击</b>可更改。")
		if(payments_acc)
			. += span_notice("<b>Ctrl 点击</b>可清除已登记的账户。")

	if(scanning_mode == SCAN_PRICE_TAG)
		. += span_notice("当前自定义价格设为 [new_custom_price] [MONEY_SYMBOL]。<b>右键点击</b>可更改。")

/obj/item/universal_scanner/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	switch(scanning_mode)
		if(SCAN_SALES_TAG)
			context[SCREENTIP_CONTEXT_LMB] = "给包裹贴标"
			context[SCREENTIP_CONTEXT_ALT_LMB] = "更改价格"
			context[SCREENTIP_CONTEXT_CTRL_LMB] = "清除目标账户"
			context[SCREENTIP_CONTEXT_ALT_LMB] = "更改分成百分比"
		if(SCAN_PRICE_TAG)
			context[SCREENTIP_CONTEXT_LMB] = "给物品定价"
			context[SCREENTIP_CONTEXT_RMB] = "设定价格"
		if(SCAN_EXPORTS)
			context[SCREENTIP_CONTEXT_LMB] = "扫描出口价值"
	return CONTEXTUAL_SCREENTIP_SET
/**
 * Scans an object, target, and provides its export value based on selling to the cargo shuttle, to mob/user.
 */
/obj/item/universal_scanner/proc/export_scan(obj/target, mob/user)
	var/datum/export_report/report = export_item_and_contents(target, dry_run = TRUE)
	var/price = 0
	for(var/exported_datum in report.total_amount)
		price += report.total_value[exported_datum]

	var/message = "已扫描 [target]"
	var/warning = FALSE
	if(length(target.contents))
		message = "已扫描 [target] 及其内容"
		if(price)
			message += "，总价值：<b>[price]</b> [MONEY_NAME]"
		else
			message += "，没有出口价值"
			warning = TRUE
		if(!report.all_contents_scannable)
			message += "（检测到无法确定的价值，最终价值可能不同）"
		message += "。"
	else
		if(!report.all_contents_scannable)
			message += "，无法确定价值。"
			warning = TRUE
		else if(price)
			message += "，价值：<b>[price]</b> [MONEY_NAME]。"
		else
			message += "，没有出口价值。"
			warning = TRUE
	if(warning)
		to_chat(user, span_warning(message))
	else
		to_chat(user, span_notice(message))

	if(price)
		playsound(src, 'sound/machines/terminal/terminal_select.ogg', 50, vary = TRUE)

	if(istype(target, /obj/item/delivery))
		var/obj/item/delivery/parcel = target
		if(!parcel.sticker)
			return
		var/obj/item/barcode/our_code = parcel.sticker
		to_chat(user, span_notice("检测到出口条形码！该包裹出口时，款项将支付给 [our_code.payments_acc.account_holder]，\
			并分给其 [our_code.cut_multiplier * 100]% 的份额（已反映在上方记录的价值中）。"))

	if(istype(target, /obj/item/barcode))
		var/obj/item/barcode/our_code = target
		to_chat(user, span_notice("检测到出口条形码！该条形码若贴附于包裹，款项将支付给 [our_code.payments_acc.account_holder]，\
			并分给其 [our_code.cut_multiplier * 100]% 的份额。"))

	if(ishuman(user))
		var/mob/living/carbon/human/scan_human = user
		if(istype(target, /obj/item/bounty_cube))
			var/obj/item/bounty_cube/cube = target
			var/datum/bank_account/scanner_account = scan_human.get_bank_account()

			if(!istype(get_area(cube), /area/shuttle/supply))
				to_chat(user, span_warning("未检测到穿梭机放置位置。处理小费未登记。"))

			else if(cube.bounty_handler_account)
				to_chat(user, span_warning("处理小费的银行账户已登记！"))

			else if(scanner_account)
				cube.AddComponent(/datum/component/pricetag, list(scanner_account), cube.handler_tip, FALSE)

				cube.bounty_handler_account = scanner_account
				cube.bounty_handler_account.bank_card_talk("处理小费[price ? "<b>[price * cube.handler_tip]</b> [MONEY_NAME_SINGULAR] " : ""]的银行账户已成功登记。")

				for(var/datum/bank_account/shareholder in cube.bounty_holder_accounts)
					if(shareholder != cube.bounty_handler_account) //No need to send a tracking update to the person scanning it
						shareholder.bank_card_talk("<b>[cube]</b> 已在 <b>[get_area(cube)]</b> 被 <b>[scan_human] ([scan_human.job])</b> 扫描。")

			else
				to_chat(user, span_warning("未检测到银行账户。处理小费未登记。"))

/**
 * Scans an object, target, and sets its custom_price variable to new_custom_price, presenting it to the user.
 */
/obj/item/universal_scanner/proc/price_tag(obj/target, mob/user)
	if(isitem(target))
		var/obj/item/selected_target = target
		selected_target.custom_price = new_custom_price
		to_chat(user, span_notice("你将 [selected_target] 的价格设为 [new_custom_price] [MONEY_SYMBOL]。"))

/**
 * check_menu: Checks if we are allowed to interact with a radial menu
 *
 * Arguments:
 * * user The mob interacting with a menu
 */
/obj/item/universal_scanner/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/obj/item/barcode
	name = "条形码标签"
	desc = "一枚与某位船员账户关联的小标签。将其贴附到包装好的物品上，可为该账户分得该物品利润的一部分。"
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "barcode"
	w_class = WEIGHT_CLASS_TINY
	//All values inherited from the sales tagger it came from.
	///The bank account assigned to pay out to from the sales tagger.
	var/datum/bank_account/payments_acc = null
	///The percentage of profit to give to the payments_acc, from 0 to 1.
	var/cut_multiplier = 0.5

#undef PAPER_PER_SHEET
