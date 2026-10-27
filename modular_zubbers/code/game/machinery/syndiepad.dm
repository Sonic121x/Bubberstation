///The amount of time it takes for the pad to warm up
#define SYN_BOUNTY_PAD_WARM_TIME 6 SECONDS

/**
 * # Syndicate Pad & Pad Terminal
 *
 * A citizen pad modified to accept goods and return money to a specified account
 *
 * This file is based off of civilian_bounties.dm
 * Any changes made to that file should be copied over with discretion
 */

///Pad for the Syndicate Bounty Control.
/obj/item/circuitboard/machine/syndiepad
	name = "英特戴恩悬赏交货平台"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/piratepad/syndiepad
	req_components = list(
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/micro_laser = 1
	)

/obj/machinery/piratepad/syndiepad
	name = "英特戴恩悬赏交货平台"
	desc = "一台经过戈尔莱克斯工业破解的标准纳米传讯公民悬赏平台，\
	可将任何非活体物品出售给遥远星区外的黑市\
	进行处理。概不退货！"
	circuit = /obj/item/circuitboard/machine/syndiepad
	var/warmup_reduction = 0

/obj/machinery/piratepad/syndiepad/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!.)
		return default_deconstruction_crowbar(tool)

/obj/machinery/piratepad/syndiepad/RefreshParts()
	. = ..()
	var/T = -2
	for(var/datum/stock_part/micro_laser/micro_laser in component_parts)
		T += micro_laser.tier

	for(var/datum/stock_part/scanning_module/scanning_module in component_parts)
		T += scanning_module.tier

	warmup_reduction = T * (0.5 SECONDS)

///Computer for activating the bounty pad
/obj/item/circuitboard/computer/syndiepad
	name = "英特戴恩悬赏控制终端"
	build_path = /obj/machinery/computer/piratepad_control/syndiepad

/obj/machinery/computer/piratepad_control/syndiepad
	name = "英特戴恩悬赏控制终端"
	desc = "用于改装公民悬赏平台的破解控制台。\
	戈尔莱克斯工业荣誉出品。"
	status_report = "已准备交货。"
	icon_screen = "civ_bounty"
	icon_keyboard = "syndie_key"
	warmup_time = SYN_BOUNTY_PAD_WARM_TIME
	circuit = /obj/item/circuitboard/computer/syndiepad
	export_market = EXPORT_MARKET_STATION

	/// The account to add balance
	var/credits_account = ACCOUNT_INT
	/// The resolved bank account
	var/datum/bank_account/synced_bank_account = null

/obj/machinery/computer/piratepad_control/syndiepad/post_machine_initialize()
	. = ..()
	synced_bank_account = SSeconomy.get_dep_account(credits_account == "" ? ACCOUNT_CAR : credits_account)

/obj/machinery/computer/piratepad_control/syndiepad/ui_data(mob/user)
	points = !synced_bank_account ? 0 : synced_bank_account.account_balance
	. = ..()

/obj/machinery/computer/piratepad_control/syndiepad/recalc()
	if(!safe_to_sell())
		return
	. = ..()

/obj/machinery/computer/piratepad_control/syndiepad/send()
	var/obj/machinery/piratepad/syndiepad/pad = pad_ref?.resolve()
	if(!safe_to_sell())
		sending = FALSE
		reset_icon(pad)
		return
	if(!synced_bank_account) /// Resolve the account
		synced_bank_account = SSeconomy.get_dep_account(credits_account == "" ? ACCOUNT_CAR : credits_account)
		if(!synced_bank_account)
			status_report = "错误：未找到部门账户。请向戈尔莱克斯工业报告。"
			sending = FALSE
			reset_icon(pad)
			return
	points = 0
	. = ..()
	if(points)
		/// Waiter! Waiter! More boomer-shooter sound effect references please!!
		if(prob(1))
			playsound(pad, 'modular_zubbers/sound/machines/syndiepad_alt1.ogg', 70, FALSE) /// HL1
		else if(prob(1))
			playsound(pad, 'modular_zubbers/sound/machines/syndiepad_alt2.ogg', 70, FALSE) /// TF2
		else
			playsound(pad, 'modular_zubbers/sound/machines/syndiepad.ogg', 70, FALSE) /// Quake
		synced_bank_account.adjust_money(points)
	points = synced_bank_account.account_balance

/obj/machinery/computer/piratepad_control/syndiepad/start_sending()
	var/obj/machinery/piratepad/syndiepad/pad = pad_ref?.resolve()
	if(pad && istype(pad, /obj/machinery/piratepad/syndiepad))
		warmup_time = clamp(SYN_BOUNTY_PAD_WARM_TIME - pad.warmup_reduction, 1 SECONDS, SYN_BOUNTY_PAD_WARM_TIME)
	. = ..()

/obj/machinery/computer/piratepad_control/syndiepad/proc/safe_to_sell()
	var/obj/machinery/piratepad/syndiepad/pad = pad_ref?.resolve()
	if(!pad)
		status_report = "错误：未找到平台。请重新将平台连接到控制台后继续。"
		return FALSE
	for(var/atom/movable/AM in get_turf(pad))
		if(AM == pad)
			continue
		for(var/atom/exporting_atom in AM.get_all_contents()) /// Reuse the cargo blacklist logic here to ensure we're not deleting something important forever
			if((is_type_in_typecache(exporting_atom, GLOB.blacklisted_cargo_types) || HAS_TRAIT(exporting_atom, TRAIT_BANNED_FROM_CARGO_SHUTTLE)) && !istype(exporting_atom, /obj/docking_port))
				status_report = "错误：平台上检测到黑名单物品（[format_text(exporting_atom.name)]）。请将其移走后重新扫描。"
				return FALSE
	return TRUE

/obj/machinery/computer/piratepad_control/syndiepad/proc/reset_icon(obj/machinery/piratepad/syndiepad/pad)
	if(!pad)
		return
	pad.finish_sending()

#undef SYN_BOUNTY_PAD_WARM_TIME

//Tarkon Pad
/obj/item/circuitboard/machine/syndiepad/tarkon
	name = "塔肯悬赏交货平台"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/piratepad/syndiepad/tarkon
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT)

/obj/machinery/piratepad/syndiepad/tarkon
	name = "塔肯悬赏交货平台"
	desc = "塔肯工业使用的标准悬赏交货平台，\
	可将任何非活体物品送往遥远的星区之外\
	进行处理。概不退货！"
	circuit = /obj/item/circuitboard/machine/syndiepad/tarkon

/obj/item/circuitboard/computer/syndiepad/tarkon
	name = "塔肯悬赏控制终端"
	build_path = /obj/machinery/computer/piratepad_control/syndiepad/tarkon
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT)

/obj/machinery/computer/piratepad_control/syndiepad/tarkon
	name = "塔肯悬赏控制终端"
	desc = "用于旧型号公民悬赏平台的控制台。"
	circuit = /obj/item/circuitboard/computer/syndiepad/tarkon
	credits_account = ACCOUNT_TAR
