

/obj/machinery/computer/order_console/mining
	name = "采矿装备订购控制台"
	desc = "面向矿工的装备商店，可在此消费矿石兑换机发放的积分。"
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "mining"
	icon_keyboard = null
	icon_screen = null
	circuit = /obj/item/circuitboard/computer/order_console/mining
	cooldown_time = 10 SECONDS //just time to let you know your order went through.
	cargo_cost_multiplier = 0.65
	express_cost_multiplier = 1
	purchase_tooltip = @{"你购买的物品将送至货运部，
	希望他们会帮忙送来。
	比速递便宜35%。"}
	express_tooltip = @{"立即送达你购买的物品。"}
	credit_type = MONEY_MINING_SYMBOL
	generate_map_preview = FALSE

	order_categories = list(
		CATEGORY_MINING,
		CATEGORY_CONSUMABLES,
		CATEGORY_TOYS_DRONE,
		CATEGORY_PKA,
	)
	blackbox_key = "mining"
	announcement_line = "矿工订购的装备将随货运穿梭机送达！请尽快转交矿工！"

/obj/machinery/computer/order_console/mining/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/voucher_redeemer, /obj/item/mining_voucher, /datum/voucher_set/mining)
	AddElement(/datum/element/voucher_redeemer, /obj/item/suit_voucher, /datum/voucher_set/mining_suit) // Bubber Addition - SEVA suit voucher selection

/obj/machinery/computer/order_console/mining/subtract_points(final_cost, obj/item/card/id/card)
	if(final_cost <= card.registered_account.mining_points)
		card.registered_account.mining_points -= final_cost
		return TRUE
	return FALSE

/obj/machinery/computer/order_console/mining/order_groceries(mob/living/purchaser, obj/item/card/id/card, list/groceries)
	var/list/things_to_order = list()
	for(var/datum/orderable_item/item as anything in groceries)
		things_to_order[item.purchase_path] = groceries[item]

	var/datum/supply_pack/custom/mining_pack = new(
		purchaser = purchaser, \
		cost = get_total_cost(), \
		contains = things_to_order,
	)
	var/datum/supply_order/disposable/new_order = new(
		pack = mining_pack,
		orderer = purchaser,
		orderer_rank = "采矿售货机",
		orderer_ckey = purchaser.ckey,
		reason = "",
		paying_account = card.registered_account,
		department_destination = null,
		coupon = null,
		charge_on_purchase = FALSE,
		manifest_can_fail = FALSE,
		cost_type = credit_type,
		can_be_cancelled = FALSE,
	)
	say("感谢购买！货物将随下一班货运穿梭机送达！")
	aas_config_announce(/datum/aas_config_entry/order_console, list(), src, list(radio_channel), capitalize(blackbox_key))
	SSshuttle.shopping_list += new_order

/obj/machinery/computer/order_console/mining/retrieve_points(obj/item/card/id/id_card)
	return round(id_card.registered_account.mining_points)

/obj/machinery/computer/order_console/mining/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(!.)
		flick("mining-deny", src)

/obj/machinery/computer/order_console/mining/update_icon_state()
	icon_state = "[initial(icon_state)][powered() ? null : "-off"]"
	return ..()

/**********************Mining Equipment Voucher**********************/

/obj/item/mining_voucher
	name = "采矿兑换券"
	desc = "可兑换一件装备的凭证，请在采矿装备售货机上使用。"
	icon = 'icons/obj/mining.dmi'
	icon_state = "mining_voucher"
	w_class = WEIGHT_CLASS_TINY

/**********************Mining Point Card**********************/

#define TO_USER_ID "转存卡 → 身份证"
#define TO_POINT_CARD "身份证 → 转存卡"

/obj/item/card/mining_point_card
	name = "采矿积分转存卡"
	desc = "用于转存采矿积分的小型可重复使用卡片。刷身份证即可开始转存。"
	icon_state = "data_1"

	///Amount of points this card contains.
	var/points = 0

/obj/item/card/mining_point_card/examine(mob/user)
	. = ..()
	. += span_notice("卡内有[points]积分。")

/obj/item/card/mining_point_card/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!isidcard(tool))
		return NONE
	var/obj/item/card/id/attacking_id = tool
	balloon_alert(user, "正在开始转存")
	var/point_movement = tgui_alert(user, "要将积分转入身份证，还是从身份证转入转存卡？", "采矿积分转存", list(TO_USER_ID, TO_POINT_CARD))
	if(!point_movement)
		return ITEM_INTERACT_BLOCKING
	var/amount = tgui_input_number(user, "要转存多少积分？身份证余额：[attacking_id.registered_account.mining_points]，转存卡余额：[points]", "转存积分", min_value = 0, round_value = 1)
	if(!amount)
		return ITEM_INTERACT_BLOCKING
	switch(point_movement)
		if(TO_USER_ID)
			if(amount > points)
				amount = points
			attacking_id.registered_account.mining_points += amount
			points -= amount
			to_chat(user, span_notice("你将[amount]采矿积分从[src]转入[attacking_id]。"))
			return ITEM_INTERACT_SUCCESS
		if(TO_POINT_CARD)
			if(amount > attacking_id.registered_account.mining_points)
				amount = attacking_id.registered_account.mining_points
			attacking_id.registered_account.mining_points -= amount
			points += amount
			to_chat(user, span_notice("你将[amount]采矿积分从[attacking_id]转入[src]。"))
			return ITEM_INTERACT_SUCCESS
	return NONE

#undef TO_POINT_CARD
#undef TO_USER_ID
