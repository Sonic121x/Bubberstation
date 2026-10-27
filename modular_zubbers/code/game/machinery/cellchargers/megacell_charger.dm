/obj/machinery/cell_charger/mega
	name = "巨型电池充电器"
	desc = "为大型电池充电的设备。"
	icon_state = "ccharger_mega"
	circuit = /obj/item/circuitboard/machine/megacell_charger
	charge_rate = 0.5 * STANDARD_BATTERY_RATE

/obj/machinery/cell_charger/mega/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stock_parts/power_store/battery) || panel_open)
		return NONE

	if(machine_stat & BROKEN)
		to_chat(user, span_warning("[src]坏了！"))
		return ITEM_INTERACT_BLOCKING
	if(!anchored)
		to_chat(user, span_warning("[src]没有固定在地面上！"))
		return ITEM_INTERACT_BLOCKING
	if(charging)
		to_chat(user, span_warning("充电器里已经有电池了！"))
		return ITEM_INTERACT_BLOCKING

	var/area/charge_area = get_area(src)
	if(!isarea(charge_area))
		return ITEM_INTERACT_BLOCKING
	if(!charge_area.power_equip) // There's no APC in this area, don't try to cheat power!
		to_chat(user, span_warning("你试图插入电池时，[src]闪烁红光！"))
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING

	charging = tool
	user.visible_message(
		span_notice("[user]将电池插入[src]。"),
		span_notice("你将电池插入[src]。"),
	)
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/cell_charger/mega/RefreshParts()
	. = ..()
	var/tier_total
	for(var/datum/stock_part/capacitor/capacitor in component_parts)
		tier_total += capacitor.tier
	charge_rate = tier_total * (initial(charge_rate) / 3)
