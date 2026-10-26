/obj/item/circuitboard/computer/order_console/mining/interdyne
	name = "英特戴恩采矿设备售货控制台"
	build_path = /obj/machinery/computer/order_console/mining/interdyne

// Interdyne/DS-2 mining equipment vendor that doesn't need a cargo shuttle to work

/obj/machinery/computer/order_console/mining/interdyne
	name = "英特戴恩采矿设备售货机"
	circuit = /obj/item/circuitboard/computer/order_console/mining/interdyne
	forced_express = TRUE
	express_cost_multiplier = 1
	order_categories = list(
		CATEGORY_MINING,
		CATEGORY_CONSUMABLES,
		CATEGORY_TOYS_DRONE,
		CATEGORY_PKA,
	)

// This is honestly quite terrible but, replaces voucher spawned mining drones with the interdyne subtype at this console
// TODO: Figure out how to do this, since voucher redeeming is now handled by an element
// /obj/machinery/computer/order_console/mining/interdyne/redeem_voucher(obj/item/mining_voucher/voucher, mob/redeemer)
// 	. = ..()
// 	for(var/mob/living/basic/mining_drone/drone in drop_location())
// 		// There could already be an interdyne drone there
// 		if(!istype(drone, /mob/living/basic/mining_drone/interdyne))
// 			qdel(drone)
// 			new /mob/living/basic/mining_drone/interdyne(drop_location())

// Interdyne minebot

/mob/living/basic/mining_drone/interdyne
	name = "\improper 英特戴恩采矿机器人"
	faction = list(FACTION_NEUTRAL, ROLE_SYNDICATE)
