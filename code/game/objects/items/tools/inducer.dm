/obj/item/inducer
	name = "感应充电器"
	desc = "一种通过感应方式为内部电池和蓄电装置充电的工具。"
	icon = 'icons/obj/tools.dmi'
	icon_state = "inducer-engi"
	inhand_icon_state = "inducer-engi"
	inside_belt_icon_state = "inducer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	force = 7
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

	/// Multiplier that determines the speed at which this inducer works at.
	var/power_transfer_multiplier = 1
	/// Is the battery hatch opened
	var/opened = FALSE
	/// The cell for used in recharging cycles
	var/obj/item/stock_parts/power_store/powerdevice = /obj/item/stock_parts/power_store/battery/high
	/// Are we in the process of recharging something
	var/recharging = FALSE

/obj/item/inducer/Initialize(mapload)
	. = ..()

	if(ispath(powerdevice))
		powerdevice = new powerdevice(src)

	register_context()

	update_appearance(UPDATE_OVERLAYS)

/obj/item/inducer/Destroy(force)
	QDEL_NULL(powerdevice)
	. = ..()

/obj/item/inducer/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == powerdevice)
		powerdevice = null

/obj/item/inducer/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = NONE

	if(isnull(held_item))
		if(opened && !QDELETED(powerdevice))
			context[SCREENTIP_CONTEXT_LMB] = "取出电池"
			. = CONTEXTUAL_SCREENTIP_SET
		return

	if(opened)
		if(istype(held_item, /obj/item/stock_parts/power_store) && QDELETED(powerdevice))
			context[SCREENTIP_CONTEXT_LMB] = "装入电池"
			return CONTEXTUAL_SCREENTIP_SET

		if(istype(held_item, /obj/item/stack/sheet/mineral/plasma) && !QDELETED(powerdevice))
			context[SCREENTIP_CONTEXT_LMB] = "为电池充电"
			return CONTEXTUAL_SCREENTIP_SET

	if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
		context[SCREENTIP_CONTEXT_LMB] = "[opened ? "关闭" : "打开"]面板"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/inducer/examine(mob/living/user)
	. = ..()

	. += examine_hints(user)

/**
 * Gives description for this inducer
 * Arguments
 *
 * * mob/living/user - the mob we are returning the description to
 */
/obj/item/inducer/proc/examine_hints(mob/living/user)
	PROTECTED_PROC(TRUE)
	SHOULD_BE_PURE(TRUE)

	. = list()

	var/obj/item/stock_parts/power_store/our_cell = get_cell(src, user)
	if(!QDELETED(our_cell))
		. += span_notice("其显示屏显示：[display_energy(our_cell.charge)]。")
		if(opened)
			. += span_notice("可以用空手取出电池。")
			. += span_notice("可以用等离子体板为电池充电。")
	else
		. += span_warning("它缺少电池。")

	. += span_notice("其电池仓可以用[EXAMINE_HINT("螺丝刀")][opened ? "关上" : "打开"]。")

/obj/item/inducer/update_overlays()
	. = ..()
	if(!opened)
		return
	. += "inducer-[!QDELETED(powerdevice) ? "bat" : "nobat"]"

/obj/item/inducer/get_cell()
	return powerdevice

/obj/item/inducer/emp_act(severity)
	. = ..()
	if(!QDELETED(powerdevice) && !(. & EMP_PROTECT_CONTENTS))
		powerdevice.emp_act(severity)

/obj/item/inducer/screwdriver_act(mob/living/user, obj/item/tool)
	. = NONE

	if(!tool.use_tool(src, user, delay = 0))
		return

	opened = !opened
	to_chat(user, span_notice("你[opened ? "打开" : "关上"]了电池仓。"))
	update_appearance(UPDATE_OVERLAYS)

	return ITEM_INTERACT_SUCCESS

/obj/item/inducer/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = NONE

	if(user.combat_mode || !istype(tool) || tool.flags_1 & HOLOGRAM_1 || tool.item_flags & ABSTRACT)
		return ITEM_INTERACT_SKIP_TO_ATTACK

	if(istype(tool, /obj/item/stock_parts/power_store))
		if(!opened)
			balloon_alert(user, "请先打开！")
			return ITEM_INTERACT_FAILURE

		if(!QDELETED(powerdevice))
			balloon_alert(user, "已装有电池！")
			return ITEM_INTERACT_FAILURE

		if(!user.transferItemToLoc(tool, src))
			balloon_alert(user, "卡在手里了！")
			return ITEM_INTERACT_FAILURE

		powerdevice = tool
		return ITEM_INTERACT_SUCCESS

	else if(istype(tool, /obj/item/stack/sheet/mineral/plasma) && !QDELETED(powerdevice))
		if(!powerdevice.used_charge())
			balloon_alert(user, "已充满电！")
			return ITEM_INTERACT_FAILURE

		tool.use(1)
		powerdevice.give(1.5 * STANDARD_CELL_CHARGE)
		balloon_alert(user, "电池已充电")

		return ITEM_INTERACT_SUCCESS

/obj/item/inducer/interact_with_atom(atom/movable/interacting_with, mob/living/user, list/modifiers)
	. = NONE

	if(HAS_TRAIT(interacting_with, TRAIT_COMBAT_MODE_SKIP_INTERACTION))
		return

	if(user.combat_mode || !istype(interacting_with) || interacting_with.flags_1 & HOLOGRAM_1)
		return ITEM_INTERACT_SKIP_TO_ATTACK

	//basic checks
	if(opened)
		balloon_alert(user, "请先关上！")
		return ITEM_INTERACT_FAILURE

	if(recharging || (!isturf(interacting_with) && user.loc == interacting_with))
		return ITEM_INTERACT_FAILURE

	if(!ISADVANCEDTOOLUSER(user))
		to_chat(user, span_warning("你不够灵巧，无法使用[src]！"))
		return ITEM_INTERACT_FAILURE

	var/obj/item/stock_parts/power_store/our_cell = get_cell(src, user)

	if(QDELETED(our_cell))
		balloon_alert(user, "未安装电池！")
		return ITEM_INTERACT_FAILURE

	if(!our_cell.charge)
		balloon_alert(user, "没有电量！")
		return ITEM_INTERACT_FAILURE

	var/obj/item/stock_parts/power_store/target_cell = interacting_with.get_cell(src, user)

	if(QDELETED(target_cell))
		return ITEM_INTERACT_FAILURE

	if(!target_cell.used_charge())
		balloon_alert(user, "已充满电！")
		return ITEM_INTERACT_FAILURE

	//begin recharging
	recharging = TRUE
	user.visible_message(span_notice("[user]开始用[src]为[interacting_with]充电。"), span_notice("你开始用[src]为[interacting_with]充电。"))

	var/done_any = FALSE
	while(target_cell.used_charge())
		if(!do_after(user, 1 SECONDS, target = user))
			break

		//transfer of charge
		var/transferred = min(our_cell.charge, target_cell.used_charge(), target_cell.rating_base * target_cell.rating * power_transfer_multiplier)
		if(!transferred)
			break
		our_cell.use(target_cell.give(transferred))

		//update all appearances
		our_cell.update_appearance()
		target_cell.update_appearance()
		interacting_with.update_appearance()

		//sparks & update
		do_sparks(1, FALSE, interacting_with)
		done_any = TRUE

	recharging = FALSE

	// Only show a message if we succeeded at least once
	if(done_any)
		user.visible_message(span_notice("[user]为[interacting_with]充好了电！"), span_notice("你为[interacting_with]充好了电！"))

	return ITEM_INTERACT_SUCCESS

/obj/item/inducer/attack_self(mob/user)
	if(opened && !QDELETED(powerdevice))
		user.visible_message(span_notice("[user]从[src]中取出了[powerdevice]！"), span_notice("你取出了[powerdevice]。"))
		powerdevice.update_appearance()
		user.put_in_hands(powerdevice)
		update_appearance(UPDATE_OVERLAYS)

/obj/item/inducer/empty
	powerdevice = null
	opened = TRUE

/obj/item/inducer/orderable
	powerdevice = /obj/item/stock_parts/power_store/battery/upgraded
	opened = FALSE

/obj/item/inducer/sci
	icon_state = "inducer-sci"
	inhand_icon_state = "inducer-sci"
	inside_belt_icon_state = "inducer-sci"
	desc = "一种通过感应方式为内部电池充电的工具。这一个采用科研配色，功率不如工程版。"
	powerdevice = null
	opened = TRUE

/obj/item/inducer/syndicate
	icon_state = "inducer-syndi"
	inhand_icon_state = "inducer-syndi"
	inside_belt_icon_state = "inducer-syndi"
	desc = "一种通过感应方式为内部电池充电的工具。这一个采用可疑的配色，似乎经过改装，能以快得多的速度传输电量。"
	power_transfer_multiplier = 2 // 2x the base speed
	powerdevice = /obj/item/stock_parts/power_store/battery/super

/obj/item/inducer/cyborg
	name = "模块化感应充电器"
	icon = 'icons/obj/tools.dmi'
	icon_state = "inducer-engi"

/obj/item/inducer/cyborg/examine_hints(mob/living/user)
	. = list()

	var/obj/item/stock_parts/power_store/our_cell = get_cell(src, user)
	if(!QDELETED(our_cell))
		. += span_notice("其显示屏显示：[display_energy(our_cell.charge)]。")
		if(opened)
			. += span_notice("可以用等离子体板为电池充电。")
	else
		. += span_warning("它缺少电池。")
	. += span_notice("其电池仓可以用[EXAMINE_HINT("螺丝刀")][opened ? "关上" : "打开"]。")

/obj/item/inducer/cyborg/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	return NONE

/obj/item/inducer/cyborg/interact_with_atom(atom/movable/interacting_with, mob/living/user, list/modifiers)
	if(iscyborg(user) && iscyborg(interacting_with))
		balloon_alert(user, "无法为此物充电！")
		return ITEM_INTERACT_FAILURE
	return ..()
