/obj/machinery/space_heater/wall_mounted
	name = "壁挂式空调机组"
	desc = "一种用于大规模场景的紧凑型加热/制冷设备，可安装在墙上，不占地方。 \
		它从最近的区域电力控制器取电；内部电池为加热/制冷机构缓冲供电。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/space_heater.dmi'
	anchored = TRUE
	density = FALSE
	circuit = null
	heating_energy = STANDARD_CELL_RATE * 0.2
	efficiency = 30
	cell = null
	/// What this repacks into when its wrenched off a wall
	var/repacked_type = /obj/item/wallframe/wall_heater

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/space_heater/wall_mounted, 29)

/obj/machinery/space_heater/wall_mounted/with_cell
	cell = /obj/item/stock_parts/power_store/cell/high

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/space_heater/wall_mounted/with_cell, 29)

/obj/machinery/space_heater/wall_mounted/Initialize(mapload)
	. = ..()
	if(mapload)
		find_and_mount_on_atom()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	RemoveElement(/datum/element/elevation, pixel_shift = 8)
	RemoveElement(/datum/element/climbable)
	START_PROCESSING(SSobj, src)

/obj/machinery/space_heater/wall_mounted/RefreshParts()
	. = ..()
	heating_energy = STANDARD_CELL_RATE * 0.2
	efficiency = 30

/obj/machinery/space_heater/wall_mounted/process_atmos(seconds_per_tick)
	..()
	//charge the cell -- should be less than the heat energy expended
	if(!isnull(cell))
		var/main_draw = STANDARD_CELL_RATE * 0.15 * seconds_per_tick
		if(!main_draw)
			return
		var/charge_given = charge_cell(main_draw, cell, grid_only = TRUE)
		if(charge_given)
			use_energy(charge_given * 0.5) //uses extra over head of energy to charge
	return


/obj/machinery/space_heater/wall_mounted/default_deconstruction_crowbar()
	return

/obj/machinery/space_heater/wall_mounted/default_unfasten_wrench(mob/living/user, obj/item/wrench, time)
	user.balloon_alert(user, "拆解中……")
	wrench.play_tool_sound(src)
	if(wrench.use_tool(src, user, 1 SECONDS))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		deconstruct(TRUE)
		return

/obj/machinery/space_heater/wall_mounted/on_deconstruction(disassembled)
	if(disassembled)
		var/obj/item/wallframe/wall_heater/frame = new repacked_type(drop_location())
		frame.cell = cell
		cell?.forceMove(frame)
	else
		cell.forceMove(drop_location())
	cell = null
	return ..()

// Wallmount for creating the heaters

/obj/item/wallframe/wall_heater
	name = "未安装的空调机组"
	desc = "一种用于小规模场景的紧凑型加热/制冷设备，可安装在墙上，不占地方。 \
		不过，与其他更独立的太空加热器一样，它仍然需要电池供电才能运作。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/space_heater.dmi'
	icon_state = "sheater-off"
	w_class = WEIGHT_CLASS_NORMAL
	result_path = /obj/machinery/space_heater/wall_mounted
	pixel_shift = 29
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT,
	)
	/// lazy-initialized cell stored in the actual heater (so that it can start with one without making a new one every placement)
	var/obj/item/stock_parts/power_store/cell = /obj/machinery/space_heater::cell

/obj/item/wallframe/wall_heater/after_attach(obj/machinery/space_heater/wall_mounted/attached_to)
	. = ..()
	if(!istype(attached_to))
		return
	if(ispath(cell))
		cell = new cell
	attached_to.cell = cell
	cell?.forceMove(attached_to)
	cell = null

/obj/item/wallframe/wall_heater/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stock_parts/power_store/cell))
		return NONE
	if(ispath(cell))
		cell = new cell
	playsound(src, 'sound/machines/click.ogg', 75, TRUE)
	user.transferItemToLoc(tool, src)
	if(!isnull(cell))
		user.put_in_hands(cell)
		user.balloon_alert(user, "已更换")
	cell = tool
	return ITEM_INTERACT_SUCCESS

/obj/item/wallframe/wall_heater/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(isnull(cell))
		return SECONDARY_ATTACK_CALL_NORMAL
	if(ispath(cell))
		cell = new cell
	playsound(src, 'sound/machines/click.ogg', 75, TRUE)
	user.put_in_hands(cell)
	cell = null
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/wallframe/wall_heater/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("它装有一块 [ispath(cell) ? cell::name : cell.name]，可以更换。")
	else
		. += span_notice("它是空的。你可以插入一块[span_bold("电池")]。")

/obj/item/wallframe/wall_heater/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(!isnull(cell) && isnull(held_item))
		context[SCREENTIP_CONTEXT_RMB] = "取出电池"
		. = CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/stock_parts/power_store))
		context[SCREENTIP_CONTEXT_LMB] = "插入电池"
		. = CONTEXTUAL_SCREENTIP_SET
