/**
 * # Syndicate Produce Orders Console
 *
 * A produce orders console modified to use a specified department account, and only allow express orders
 *
 * This file is based off of order_computer.dm
 * Any changes made to that file should be copied over with discretion
 */

/obj/item/circuitboard/computer/order_console/interdyne
	name = "英特戴恩食材订购控制台"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/computer/order_console/cook/interdyne

/obj/machinery/computer/order_console/cook/interdyne
	name = "英特戴恩食材订购控制台"
	desc = "用于订购新鲜食材等物资的终端。辛迪加船员每一顿营养餐的基石。"
	circuit = /obj/item/circuitboard/computer/order_console/interdyne
	blackbox_key = null
	forced_express = TRUE

	/// The account to add balance
	var/credits_account = ACCOUNT_INT
	/// The resolved bank account
	var/datum/bank_account/synced_bank_account = null

/obj/machinery/computer/order_console/cook/interdyne/post_machine_initialize()
	. = ..()
	synced_bank_account = SSeconomy.get_dep_account(credits_account == "" ? ACCOUNT_CAR : credits_account)

/obj/machinery/computer/order_console/cook/interdyne/ui_data(mob/user)
	var/list/data = ..()
	data["points"] = !synced_bank_account ? 0 : synced_bank_account.account_balance
	return data

/obj/machinery/computer/order_console/cook/interdyne/purchase_items(obj/item/card/id/card, express = FALSE)
	if(!synced_bank_account)
		say("错误：未找到部门账户。请向戈尔莱克斯工业报告。")
		return FALSE
	var/final_cost = round(get_total_cost() * (express ? express_cost_multiplier : cargo_cost_multiplier))
	if(synced_bank_account.adjust_money(-final_cost, "[name]：采购"))
		return TRUE
	say("抱歉，你的[credit_type]不足。")
	return FALSE
