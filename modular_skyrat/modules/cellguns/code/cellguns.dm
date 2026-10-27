/obj/item/gun/energy/cell_loaded //The basic cell loaded gun
	name = "电池装填枪"
	desc = "一种通过装填电池来获得弹药类型的能量枪。"

	/// List containing what cells are allowed to be installed by the gun. This includes all subtypes.
	var/list/allowed_cells = list()
	/// The maximum amount of cells that a cell loaded gun can hold at once.
	var/maxcells = 3
	/// A list that contains the currently installed cells.
	var/list/installedcells = list()

	automatic_charge_overlays = FALSE //This is needed because Cell based guns use their own custom overlay system.

/obj/item/gun/energy/cell_loaded/give_gun_safeties()
	return

/obj/item/gun/energy/cell_loaded/examine(mob/user)
	. = ..()
	if(maxcells)
		. += "已占用 <b>[installedcells.len]</b> / <b>[maxcells]</b> 个电池槽。"
		. += span_info("空手按下 Alt+单击，可以从弹膛中取出最近插入的电池。")

		for(var/cell in installedcells)
			. += span_notice("弹膛中装有一块 [cell]。") //Shows what cells are currently inside of the gun

/// Handles insertion of weapon cells
/obj/item/gun/energy/cell_loaded/attackby(obj/item/weaponcell/used_cell, mob/user)
	if(is_type_in_list(used_cell, allowed_cells)) // Checks allowed_cells to see if the gun is able to load the cells.
		if(installedcells.len >= maxcells) //Prevents the user from loading any cells past the maximum cell allowance
			to_chat(user, span_notice("[src] 已装满，取出一块电池以腾出空间。"))
			return

		var/obj/item/weaponcell/cell = used_cell
		if(!user.transferItemToLoc(cell, src))
			return

		playsound(loc, 'sound/machines/click.ogg', 50, 1)
		to_chat(user, span_notice("你装上了 [cell]。"))
		ammo_type += new cell.ammo_type(src)
		installedcells += cell
	else
		..()

/obj/item/gun/energy/cell_loaded/update_overlays()
	. = ..()
	var/overlay_icon_state = icon_state
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]

	if(modifystate)
		if(single_shot_type_overlay)
			var/mutable_appearance/full_overlay = mutable_appearance(icon, "[icon_state]_full")
			full_overlay.color = shot.select_color
			. += new /mutable_appearance(full_overlay)
		overlay_icon_state += "_charge"

	var/ratio = get_charge_ratio()
	ratio = get_charge_ratio()

	if(!ratio && display_empty)
		. += "[icon_state]_empty"
		return

	var/mutable_appearance/charge_overlay = mutable_appearance(icon, overlay_icon_state)

	if(!shot.select_color)
		return

	charge_overlay.color = shot.select_color

	for(var/i in 0 to ratio)
		charge_overlay.pixel_x = ammo_x_offset * (i - 1)
		charge_overlay.pixel_y = ammo_y_offset * (i - 1)
		. += new /mutable_appearance(charge_overlay)

/obj/item/gun/energy/cell_loaded/click_alt(mob/user, modifiers)
	if(!installedcells.len) //Checks to see if there is a cell inside of the gun, before removal.
		to_chat(user, span_notice("[src] 里没有电池"))
		return CLICK_ACTION_BLOCKING

	to_chat(user, span_notice("你取出一块电池"))
	var/obj/item/last_cell = installedcells[installedcells.len]

	if(last_cell)
		last_cell.forceMove(drop_location())
		user.put_in_hands(last_cell)

	installedcells -= last_cell
	ammo_type.len--
	select_fire(user)
	return CLICK_ACTION_SUCCESS

/// A cellgun used for debug, it is able to use any weaponcell.
/obj/item/gun/energy/cell_loaded/alltypes
	name = "全类型枪"
	allowed_cells = list(/obj/item/weaponcell)
