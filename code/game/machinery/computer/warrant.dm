/obj/machinery/computer/warrant
	name = "安保罚单控制台"
	desc = "用于查看尚未缴清的罚单。"
	icon_state = MAP_SWITCH("computer", "/obj/machinery/computer/warrant")
	icon_screen = "security"
	icon_keyboard = "security_key"
	circuit = /obj/item/circuitboard/computer/warrant
	light_color = COLOR_SOFT_RED
	/// The state of the printer
	var/printing = FALSE

/obj/machinery/computer/warrant/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "WarrantConsole", name)
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/machinery/computer/warrant/ui_data(mob/user)
	var/list/data = list()

	var/list/records = list()

	for(var/datum/record/crew/target in GLOB.manifest.general)
		if(!length(target.citations))
			continue

		var/list/citations = list()

		for(var/datum/crime/citation/warrant as anything in target.citations)
			if(!warrant.valid)
				continue

			var/list/entry = list(list(
				author = warrant.author,
				details = warrant.details,
				fine = warrant.fine,
				fine_name = warrant.name,
				fine_ref = REF(warrant),
				paid = warrant.paid,
				time = warrant.time,
			))

			citations += entry

		var/list/record = list(list(
			citations = citations,
			crew_name = target.name,
			crew_ref = REF(target),
			notes = target.security_note,
			rank = target.rank,
		))

		records += record
	data["records"] = records

	return data

/obj/machinery/computer/warrant/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return FALSE

	switch(action)
		if("pay")
			pay_fine(usr, params)
			return TRUE

		if("print")
			ui.close()
			print_bounty(usr, params)
			return TRUE

		if("refresh")
			return TRUE

	return FALSE

/// Pays towards a listed fine.
/obj/machinery/computer/warrant/proc/pay_fine(mob/user, list/params)
	var/datum/record/crew/target = locate(params["crew_ref"]) in GLOB.manifest.general
	if(!target)
		return FALSE

	var/datum/crime/citation/warrant = locate(params["fine_ref"]) in target.citations
	if(!warrant)
		return FALSE

	if(!isliving(user) || issilicon(user))
		to_chat(user, span_warning("访问被拒绝"))
		playsound(src, 'sound/machines/terminal/terminal_error.ogg', 100, TRUE)
		return FALSE

	var/mob/living/player = user
	var/obj/item/card/id/auth = player.get_idcard(TRUE)
	if(!auth)
		to_chat(user, span_warning("访问被拒绝：未检测到身份证。"))
		playsound(src, 'sound/machines/terminal/terminal_error.ogg', 100, TRUE)
		return FALSE

	var/datum/bank_account/account = auth.registered_account
	if(!account?.account_holder || account.account_holder == "Unassigned")
		to_chat(user, span_warning("访问被拒绝：身份证未关联账户。"))
		playsound(src, 'sound/machines/terminal/terminal_error.ogg', 100, TRUE)
		return FALSE

	var/amount = params["amount"]
	if(!amount || !isnum(amount) || amount <= 0 || amount > warrant.fine || !account.adjust_money(-amount, "为[target.name]缴纳罚款"))
		to_chat(user, span_warning("访问被拒绝：金额无效。"))
		playsound(src, 'sound/machines/terminal/terminal_error.ogg', 100, TRUE)
		return FALSE

	account.bank_card_talk("你为[target.name]总额[warrant.fine][MONEY_SYMBOL]的罚款支付了[amount][MONEY_SYMBOL]。")
	log_econ("[amount][MONEY_SYMBOL] was transferred from [user]'s transaction to [target.name]'s [warrant.fine][MONEY_SYMBOL] fine")
	SSblackbox.record_feedback("amount", "credits_transferred", amount)
	warrant.pay_fine(amount)

	if(amount >= 100 && target?.name != user)
		var/list/titles = list(
			"一位匿名恩人",
			"一位慷慨的公民",
			"一位好心人",
			"一位乐善好施的人",
			"一位友善的人",
			"一位热心的陌生人",
		)
		warrant.alert_owner(user, src, target.name, "[pick(titles)]为你的罚款支付了[amount][MONEY_SYMBOL]。")

	var/datum/bank_account/sec_account = SSeconomy.get_dep_account(ACCOUNT_SEC)
	sec_account.adjust_money(amount)
	SSblackbox.ReportCitation(REF(warrant), paid = warrant.paid)

	if(warrant.fine != 0 || target.name == user)
		return TRUE

	warrant.alert_owner(user, src, target.name, "你的一张待缴罚单已全额付清。")
	warrant.valid = FALSE
	return TRUE

/// Finishes printing, resets the printer.
/obj/machinery/computer/warrant/proc/print_finish(obj/item/paper/bounty)
	printing = FALSE
	playsound(src, 'sound/machines/terminal/terminal_eject.ogg', 100, TRUE)
	bounty.forceMove(loc)

	return TRUE

/// Prints a bounty for a listed fine.
/obj/machinery/computer/warrant/proc/print_bounty(mob/user, list/params)
	if(printing)
		balloon_alert(user, "打印机忙碌中")
		playsound(src, 'sound/machines/terminal/terminal_error.ogg', 100, TRUE)
		return FALSE

	var/datum/record/crew/target = locate(params["crew_ref"]) in GLOB.manifest.general
	if(!target)
		return FALSE

	var/datum/crime/citation/warrant = locate(params["fine_ref"]) in target.citations
	if(!warrant?.fine)
		return FALSE

	var/bounty_text = "<center><h2><b>[target.name]的悬赏单</b><h2></center><BR>"
	bounty_text += "<center>通缉事由：[warrant.name]</h2></center><br><br>"
	bounty_text += "<b>详情：</b><br>[warrant.details]<br>"
	bounty_text += "<b>发给：</b><br>[usr]<br>"
	bounty_text += "<b>签发时间：</b><br>[warrant.time]<br>"
	bounty_text += "<b>备注：</b><br>[!target.security_note ? "无。" : target.security_note]<br><br>"
	bounty_text += "<center><b>罚款：</b>[warrant.fine][MONEY_NAME]</center>"

	printing = TRUE
	balloon_alert(user, "正在打印")
	playsound(src, 'sound/machines/printer.ogg', 100, TRUE)

	var/obj/item/paper/bounty = new(null)
	bounty.name = "[target.name]的悬赏单"
	bounty.desc = "针对[target.name]的[warrant.fine][MONEY_SYMBOL]悬赏单。"
	bounty.add_raw_text(bounty_text)
	bounty.update_icon()

	addtimer(CALLBACK(src, PROC_REF(print_finish), bounty), 2 SECONDS)

	return TRUE
