/obj/machinery/computer/order_console/cook
	name = "食材订购控制台"
	desc = "用于订购新鲜农产品等物资的终端。比找植物学家贵得多，不过也只好如此。"
	circuit = /obj/item/circuitboard/computer/order_console
	order_categories = list(
		CATEGORY_FRUITS_VEGGIES,
		CATEGORY_MILK_EGGS,
		CATEGORY_SAUCES_REAGENTS,
	)
	blackbox_key = "chef"
	announcement_line = "厨房订购的食材将随货运穿梭机送达！请尽快转交厨房！"
	// Discount for items in the chefs category like mining/bitrunning consoles
	cargo_cost_multiplier =  0.65

/obj/machinery/computer/order_console/cook/order_groceries(mob/living/purchaser, obj/item/card/id/card, list/groceries)
	say("感谢购买！货物将随下一班货运穿梭机送达！")
	aas_config_announce(/datum/aas_config_entry/order_console, list(), src, list(radio_channel), capitalize(blackbox_key))
	for(var/datum/orderable_item/ordered_item in groceries)
		if(!(ordered_item.category_index in order_categories))
			groceries.Remove(ordered_item)
			continue
		if(ordered_item in SSshuttle.chef_groceries)
			SSshuttle.chef_groceries[ordered_item] += groceries[ordered_item]
		else
			SSshuttle.chef_groceries[ordered_item] = groceries[ordered_item]
