///Pipe info
/datum/pipe_info
	///Name of this pipe
	var/name
	///Icon state of this pipe
	var/icon_state
	///Type path of this recipe
	var/id = -1
	/// see code/__DEFINES/pipe_construction.dm
	var/dirtype = PIPE_BENDABLE
	/// Is this pipe layer indenpendent
	var/all_layers

/datum/pipe_info/pipe/New(label, obj/machinery/atmospherics/path, use_five_layers)
	name = label
	id = path
	all_layers = use_five_layers
	icon_state = initial(path.pipe_state)
	var/obj/item/pipe/c = initial(path.construction_type)
	dirtype = initial(c.RPD_type)

/**
 * Get preview image of an pipe
 * Arguments
 *
 * * selected_dir - the direction of the pipe to get preview of
 * * selected - is this pipe meant to be highlighted in the UI
 */
/datum/pipe_info/proc/get_preview(selected_dir, selected = FALSE)
	SHOULD_BE_PURE(TRUE)

	var/list/dirs
	switch(dirtype)
		if(PIPE_STRAIGHT, PIPE_BENDABLE)
			dirs = list("[NORTH]" = "纵向", "[EAST]" = "横向")
			if(dirtype == PIPE_BENDABLE)
				dirs += list("[NORTHWEST]" = "西至北", "[NORTHEAST]" = "北至东",
							"[SOUTHWEST]" = "南至西", "[SOUTHEAST]" = "东至南")
		if(PIPE_TRINARY)
			dirs = list("[NORTH]" = "西南东", "[SOUTH]" = "东北西",
						"[EAST]" = "北西南", "[WEST]" = "南东北")
		if(PIPE_TRIN_M)
			dirs = list("[NORTH]" = "北东南", "[SOUTHWEST]" = "北西南",
						"[NORTHEAST]" = "南东北", "[SOUTH]" = "南西北",
						"[WEST]" = "西北东", "[SOUTHEAST]" = "西南东",
						"[NORTHWEST]" = "东北西", "[EAST]" = "东南西",)
		if(PIPE_UNARY)
			dirs = list("[NORTH]" = "北", "[SOUTH]" = "南", "[WEST]" = "西", "[EAST]" = "东")
		if(PIPE_ONEDIR)
			dirs = list("[SOUTH]" = name)
		if(PIPE_UNARY_FLIPPABLE)
			dirs = list("[NORTH]" = "北", "[EAST]" = "东", "[SOUTH]" = "南", "[WEST]" = "西",
						"[NORTHEAST]" = "北（翻转）", "[SOUTHEAST]" = "东（翻转）", "[SOUTHWEST]" = "南（翻转）", "[NORTHWEST]" = "西（翻转）")
		if(PIPE_ONEDIR_FLIPPABLE)
			dirs = list("[SOUTH]" = name, "[SOUTHEAST]" = "[name]（翻转）")

	var/list/rows = list()
	for(var/dir in dirs)
		var/numdir = text2num(dir)
		var/flipped = ((dirtype == PIPE_TRIN_M && !ispath(id, /obj/structure/disposalpipe)) || (dirtype == PIPE_UNARY_FLIPPABLE) || (dirtype == PIPE_ONEDIR_FLIPPABLE)) && (ISDIAGONALDIR(numdir))
		var/is_variant_selected = selected && (!selected_dir ? FALSE : (dirtype == PIPE_ONEDIR ? TRUE : (numdir == selected_dir)))
		rows += list(list(
			"selected" = is_variant_selected,
			"dir" = dir2text(numdir),
			"dir_name" = dirs[dir],
			"icon_state" = icon_state,
			"flipped" = flipped,
		))

	return rows

//==============================================================================================

///Meter pipe info
/datum/pipe_info/meter
	icon_state = "meter"
	dirtype = PIPE_ONEDIR
	all_layers = TRUE

/datum/pipe_info/meter/New(label)
	name = label

//==============================================================================================

///Disposal pipe info
/datum/pipe_info/disposal/New(label, obj/path, dt=PIPE_UNARY)
	name = label
	id = path

	icon_state = initial(path.icon_state)
	if(ispath(path, /obj/structure/disposalpipe))
		icon_state = "con[icon_state]"

	dirtype = dt


//==============================================================================================

///Transient tube pipe info
/datum/pipe_info/transit/New(label, obj/path, dt=PIPE_UNARY)
	name = label
	id = path
	dirtype = dt
	icon_state = initial(path.icon_state)
	if(dt == PIPE_UNARY_FLIPPABLE)
		icon_state = "[icon_state]_preview"
