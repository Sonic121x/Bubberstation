/datum/ai_module/power_apc
	name = "远程供电"
	description = "从远处为 APC 供电"
	one_purchase = TRUE
	power_type = /datum/action/innate/ai/ranged/power_apc
	unlock_text = span_notice("远程 APC 供电系统已上线。")

/datum/action/innate/ai/ranged/power_apc
	name = "远程为 APC 供电"
	desc = "使用后可远程为 APC 供电。"
	button_icon = 'icons/obj/machines/wallmounts.dmi'
	button_icon_state = "apc0"
	ranged_mousepointer = 'icons/effects/mouse_pointers/supplypod_target.dmi'
	enable_text = span_notice("你准备好为你看到的任何 APC 供电。")
	disable_text = span_notice("你不再专注于为 APC 供电。")

/datum/action/innate/ai/ranged/power_apc/do_ability(mob/living/clicker, atom/clicked_on)

	if (!isAI(clicker))
		return FALSE
	var/mob/living/silicon/ai/ai_clicker = clicker

	if(clicker.incapacitated)
		unset_ranged_ability(clicker)
		return FALSE

	if(!isapc(clicked_on))
		clicked_on.balloon_alert(ai_clicker, "这不是 APC！")
		return FALSE

	if(ai_clicker.battery - 50 <= 0)
		to_chat(ai_clicker, span_warning("你的电量不足以给 APC 充电！"))
		return FALSE

	var/obj/machinery/power/apc/apc = clicked_on
	var/obj/item/stock_parts/power_store/cell = apc.get_cell()
	cell.give(STANDARD_BATTERY_CHARGE)
	ai_clicker.battery -= 50



