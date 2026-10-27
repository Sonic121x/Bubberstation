/datum/computer_file/program/budgetorders
	filename = "orderapp"
	filedesc = "纳米传讯购物网络"
	downloader_category = PROGRAM_CATEGORY_SUPPLY
	program_open_overlay = "request"
	extended_desc = "纳米传讯购物网络界面，可使用部门预算账户从货运目录中采购物资。"
	program_flags = PROGRAM_ON_NTNET_STORE | PROGRAM_REQUIRES_NTNET
	can_run_on_flags = PROGRAM_LAPTOP | PROGRAM_PDA
	size = 10
	tgui_id = "NtosCargo"
	program_icon = FA_ICON_CART_FLATBED
	///Are you actually placing orders with it?
	var/requestonly = TRUE
	///Can the tablet see or buy illegal stuff?
	var/contraband = FALSE
	///Is it being bought from a personal account, or is it being done via a budget/cargo?
	var/self_paid = FALSE
	///Can this console approve purchase requests?
	var/can_approve_requests = FALSE
	///What do we say when the shuttle moves with living beings on it.
	var/safety_warning = "出于安全与伦理原因，自动补给穿梭机无法运送活体生物、\
		遗体、机密核武器、邮件、未送达的部门订单箱、辛迪加炸弹、\
		归航信标、不稳定的本征态，或任何装载人工智能的机械。"
	///If you're being raided by pirates, what do you tell the crew?
	var/blockade_warning = "检测到蓝空间不稳定，穿梭机无法移动。"
	///The name of the shuttle template being used as the cargo shuttle. 'cargo' is default and contains critical code. Don't change this unless you know what you're doing.
	var/cargo_shuttle = "cargo"
	///The docking port called when returning to the station.
	var/docking_home = "cargo_home"
	///The docking port called when leaving the station.
	var/docking_away = "cargo_away"
	///If this console can loan the cargo shuttle. Set to false to disable.
	var/stationcargo = TRUE
	///The account this console processes and displays. Independent from the account the shuttle processes.
	var/cargo_account = ACCOUNT_CAR

/datum/computer_file/program/budgetorders/proc/is_visible_pack(mob/user, paccess_to_check, list/access, contraband)
	if(HAS_SILICON_ACCESS(user)) //Borgs can't buy things.
		return FALSE
	if(computer.obj_flags & EMAGGED)
		return TRUE
	else if(contraband) //Hide contrband when non-emagged.
		return FALSE
	if(!paccess_to_check) // No required_access, allow it.
		return TRUE
	if(isAdminGhostAI(user))
		return TRUE

	//Aquire access from the inserted ID card.
	if(!length(access))
		access = computer?.GetAccess()
		if(!length(access))
			return FALSE

	if(paccess_to_check in access)
		return TRUE

	return FALSE

/datum/computer_file/program/budgetorders/ui_data(mob/user)
	var/list/data = list()
	data["location"] = SSshuttle.supply.getStatusText()
	data["department"] = "货运部"

	var/datum/bank_account/buyer = SSeconomy.get_dep_account(cargo_account)
	var/obj/item/card/id/id_card = computer.stored_id?.GetID()
	if(id_card?.registered_account?.account_job?.paycheck_department)
		buyer = SSeconomy.get_dep_account(id_card?.registered_account.account_job.paycheck_department)
		if((ACCESS_BUDGET in id_card.access))
			requestonly = FALSE
			can_approve_requests = TRUE
			// If buyer is a departmental budget, replaces "Cargo" with that budget - we're not using the cargo budget here
			data["department"] = "[buyer.account_holder] 申购"
		else
			requestonly = TRUE
			can_approve_requests = FALSE
	else
		requestonly = TRUE
	if(buyer)
		data["points"] = buyer.account_balance
	// To recap above because it's kind of a mess, here's all the options:
		//Head of staff ID card: Can approve, buy, and make purchases using their own departmental budgets.
		//ID card, not a head of staff: can request items from cargo using departmental budget.
		//No ID card, can request items from cargo using the cargo budget.

	//Otherwise static data, that is being applied in ui_data as the crates visible and buyable are not static, and are determined by inserted ID.
	data["requestonly"] = requestonly
	data["supplies"] = list()
	for(var/pack in SSshuttle.supply_packs)
		var/datum/supply_pack/P = SSshuttle.supply_packs[pack]
		if(P.order_flags & ORDER_INVISIBLE)
			continue
		if(!is_visible_pack(user, P.access_view , null, (P.order_flags & ORDER_CONTRABAND)) || (P.order_flags & ORDER_EMAG_ONLY))
			continue
		if(!data["supplies"][P.group])
			data["supplies"][P.group] = list(
				"name" = P.group,
				"packs" = list()
			)
		if(((P.order_flags & ORDER_EMAG_ONLY) && ((P.order_flags & ORDER_CONTRABAND) && !contraband) || ((P.order_flags & ORDER_SPECIAL) && !(P.order_flags & ORDER_SPECIAL_ENABLED)) || (P.order_flags & ORDER_POD_ONLY) || (P.order_flags & ORDER_INTERDYNE_ONLY))) // BUBBER EDIT
			continue

		var/obj/item/first_item = length(P.contains) > 0 ? P.contains[1] : null
		data["supplies"][P.group]["packs"] += list(list(
			"name" = P.name,
			"cost" = P.get_cost(),
			"id" = pack,
			"desc" = P.desc || P.name, // If there is a description, use it. Otherwise use the pack's name.
			"first_item_icon" = first_item?.icon,
			"first_item_icon_state" = first_item?.icon_state,
			"goody" = P.order_flags & ORDER_GOODY,
			"access" = P.access,
			"contains" = P.get_contents_ui_data(),
		))

	//Data regarding the User's capability to buy things.
	data["away"] = SSshuttle.supply.getDockedId() == docking_away
	data["self_paid"] = self_paid
	data["docked"] = SSshuttle.supply.mode == SHUTTLE_IDLE
	data["loan"] = !!SSshuttle.shuttle_loan
	data["loan_dispatched"] = SSshuttle.shuttle_loan && SSshuttle.shuttle_loan.dispatched
	data["can_send"] = FALSE //There is no situation where I want the app to be able to send the shuttle AWAY from the station, but conversely is fine.
	data["can_approve_requests"] = can_approve_requests
	data["app_cost"] = TRUE
	var/message = "请记得盖章并交回补给清单。"
	if(SSshuttle.centcom_message)
		message = SSshuttle.centcom_message
	if(SSshuttle.supply_blocked)
		message = blockade_warning
	data["message"] = message
	var/cart_list = list()
	for(var/datum/supply_order/order in SSshuttle.shopping_list)
		if(cart_list[order.pack.name])
			cart_list[order.pack.name][1]["amount"]++
			cart_list[order.pack.name][1]["cost"] += order.get_final_cost()
			if(order.department_destination)
				cart_list[order.pack.name][1]["dep_order"]++
			if(!isnull(order.paying_account))
				cart_list[order.pack.name][1]["paid"]++
			continue

		cart_list[order.pack.name] = list(list(
			"cost_type" = order.cost_type,
			"object" = order.pack.name,
			"cost" = order.get_final_cost(),
			"id" = order.id,
			"amount" = 1,
			"orderer" = order.orderer,
			"paid" = !isnull(order.paying_account), //number of orders purchased privatly
			"dep_order" = !!order.department_destination, //number of orders purchased by a department
			"can_be_cancelled" = order.can_be_cancelled,
		))
	data["cart"] = list()
	for(var/item_id in cart_list)
		data["cart"] += cart_list[item_id]


	data["requests"] = list()
	for(var/datum/supply_order/order in SSshuttle.request_list)
		var/datum/supply_pack/pack = order.pack
		data["requests"] += list(list(
			"object" = pack.name,
			"cost" = pack.get_cost(),
			"orderer" = order.orderer,
			"reason" = order.reason,
			"id" = order.id,
			"account" = order.paying_account ? order.paying_account.account_holder : "货运部"
		))

	return data

/datum/computer_file/program/budgetorders/ui_static_data(mob/user)
	var/list/data = list()
	data["max_order"] = CARGO_MAX_ORDER
	data["displayed_currency_full_name"] = " [MONEY_NAME]"
	data["displayed_currency_name"] = " [MONEY_SYMBOL]"
	return data

/datum/computer_file/program/budgetorders/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/mob/user = ui.user
	switch(action)
		if("send")
			if(!SSshuttle.supply.canMove())
				computer.say(safety_warning)
				return
			if(SSshuttle.supply_blocked)
				computer.say(blockade_warning)
				return
			if(SSshuttle.supply.getDockedId() == docking_home)
				SSshuttle.moveShuttle(cargo_shuttle, docking_away, TRUE)
				computer.say("补给穿梭机正在离站。")
				user.investigate_log("将补给穿梭机送离了站。", INVESTIGATE_CARGO)
			else
				user.investigate_log("召回了补给穿梭机。", INVESTIGATE_CARGO)
				computer.say("已召回补给穿梭机，将在 [SSshuttle.supply.timeLeft(600)] 分钟后抵达。")
				SSshuttle.moveShuttle(cargo_shuttle, docking_home, TRUE)
			. = TRUE
		if("loan")
			if(!SSshuttle.shuttle_loan)
				return
			if(SSshuttle.supply_blocked)
				computer.say(blockade_warning)
				return
			else if(SSshuttle.supply.mode != SHUTTLE_IDLE)
				return
			else if(SSshuttle.supply.getDockedId() != docking_away)
				return
			else if(stationcargo != TRUE)
				return
			else
				SSshuttle.shuttle_loan.loan_shuttle()
				computer.say("补给穿梭机已租借给中央指挥部。")
				user.investigate_log("接受了一次穿梭机租借事件。", INVESTIGATE_CARGO)
				user.log_message("接受了一次穿梭机租借事件。", LOG_GAME)
				. = TRUE
		if("add")
			var/id = text2path(params["id"]) || params["id"]
			var/datum/supply_pack/pack = SSshuttle.supply_packs[id]
			if(!istype(pack))
				return
			if((pack.order_flags & (ORDER_EMAG_ONLY | ORDER_POD_ONLY | ORDER_INTERDYNE_ONLY | ORDER_CONTRABAND)) || ((pack.order_flags & ORDER_SPECIAL) && !(pack.order_flags & ORDER_SPECIAL_ENABLED))) // BUBBER EDIT
				return

			var/name = "*未提供*"
			var/rank = "*未提供*"
			var/ckey = user.ckey
			var/mob/living/carbon/human/hwoman
			if(ishuman(user))
				hwoman = user
				rank = hwoman.get_assignment(hand_first = TRUE)
			else if(issilicon(user))
				name = user.real_name
				rank = "硅基单位"

			// Our account that we want to end up paying with.
			var/datum/bank_account/account
			// Our ID card that we want to pull from for identification. Modifies either name, account, or neither depending on function.
			var/obj/item/card/id/id_card_customer = computer.stored_id?.GetID()
			if(!id_card_customer)
				id_card_customer = hwoman?.get_idcard(TRUE) //Grab from hands/mob if there's no id_card slot to prioritize.
			name = id_card_customer?.registered_account.account_holder

			if(self_paid)
				if(!istype(id_card_customer))
					computer.say("未检测到 ID 卡。")
					return
				if(IS_DEPARTMENTAL_CARD(id_card_customer))
					computer.say("[id_card_customer] 不能用于采购。")
					return
				account = id_card_customer.registered_account
				name = id_card_customer.registered_account.account_holder
				if(!istype(account))
					computer.say("银行账户无效。")
					return

			var/reason = ""
			var/datum/bank_account/personal_department
			if((requestonly && !self_paid) || !(computer.stored_id?.GetID()))
				reason = tgui_input_text(user, "原因", name, max_length = MAX_MESSAGE_LEN)
				if(isnull(reason) || ..())
					return

			if(id_card_customer?.registered_account?.account_job && !self_paid) //Find a budget to pull from
				personal_department = SSeconomy.get_dep_account(id_card_customer.registered_account.account_job.paycheck_department)
				if(!(personal_department.account_holder == "Cargo Budget"))
					var/dept_choice = tgui_alert(user, "这是为哪个部门申请的？", "选择申请部门", list("Cargo Budget", "[personal_department.account_holder]"))
					if(!dept_choice)
						return
					if(dept_choice == "Cargo Budget")
						personal_department = null

			if((pack.order_flags & ORDER_GOODY) && !self_paid && !pack.allow_non_private_purchase) // BUBBER EDIT - allow_non_private_purchase check, matches orderconsole.dm and expressconsole.dm
				playsound(computer, 'sound/machines/buzz/buzz-sigh.ogg', 50, FALSE)
				computer.say("错误：小型板条箱只能使用个人账户购买。")
				return

			if(SSshuttle.supply.get_order_count(pack) == OVER_ORDER_LIMIT)
				playsound(computer, 'sound/machines/buzz/buzz-sigh.ogg', 50, FALSE)
				computer.say("错误：单次最多只能订购 [CARGO_MAX_ORDER] 份同种货箱。")
				return

			if(!self_paid)
				account = personal_department

			var/turf/T = get_turf(computer)
			var/datum/supply_order/SO = new(pack, name, rank, ckey, reason, account)
			if(computer.stored_paper >= 1)
				SO.generateRequisition(T)
				computer.stored_paper -= 1
				if(computer.stored_paper <= 4)
					computer.say("纸张存储仅剩 [computer.stored_paper] 张纸，请补充！")
					if(computer.stored_paper <= 1)
						computer.say("仅剩 1 张纸，请补充！")
			else
				computer.say("无法打印申购单，纸张存储已空，请补充纸张！")
			if((requestonly && !self_paid) || !(computer.stored_id?.GetID()))
				SSshuttle.request_list += SO
			else
				SSshuttle.shopping_list += SO
				if(self_paid)
					computer.say("订单已处理，费用将在送达时从 [account.account_holder] 的银行账户扣除。")
			playsound(computer, 'sound/effects/coin2.ogg', 40, TRUE)
			. = TRUE
		if("remove")
			var/id = text2num(params["id"])
			for(var/datum/supply_order/SO in SSshuttle.shopping_list)
				if(SO.id == id)
					SSshuttle.shopping_list -= SO
					. = TRUE
					break
		if("clear")
			for(var/datum/supply_order/cancelled_order in SSshuttle.shopping_list)
				if(cancelled_order.department_destination || cancelled_order.can_be_cancelled)
					continue //don't cancel other department's orders or orders that can't be cancelled
				SSshuttle.shopping_list -= cancelled_order
			. = TRUE
		if("approve")
			var/id = text2num(params["id"])
			for(var/datum/supply_order/SO in SSshuttle.request_list)
				if(SO.id == id)
					var/obj/item/card/id/id_card = computer.stored_id?.GetID()
					if(id_card && id_card?.registered_account)
						SO.paying_account = SSeconomy.get_dep_account(id_card?.registered_account?.account_job.paycheck_department)
					SSshuttle.request_list -= SO
					SSshuttle.shopping_list += SO
					. = TRUE
					break
		if("deny")
			var/id = text2num(params["id"])
			for(var/datum/supply_order/SO in SSshuttle.request_list)
				if(SO.id == id)
					SSshuttle.request_list -= SO
					. = TRUE
					break
		if("denyall")
			SSshuttle.request_list.Cut()
			. = TRUE
		if("toggleprivate")
			self_paid = !self_paid
			. = TRUE
	if(.)
		post_signal(cargo_shuttle)

/datum/computer_file/program/budgetorders/proc/post_signal(command)

	var/datum/radio_frequency/frequency = SSradio.return_frequency(FREQ_STATUS_DISPLAYS)

	if(!frequency)
		return

	var/datum/signal/status_signal = new(list("command" = command))
	frequency.post_signal(src, status_signal)
