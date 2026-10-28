/datum/phystool_mode/build_mode
	name = "建造模式"
	desc = "使用左键进行建造，使用右键进行移除，在手中使用以在结构之间选择。"

	var/atom/selected_atom

/datum/phystool_mode/build_mode/use_act(mob/user)
	. = ..()

	var/list/choise = list(
		"Wall mode" = image(icon = 'icons/turf/walls.dmi', icon_state = "wall3"),
		"Turf mode" = image(icon = 'icons/turf/walls.dmi', icon_state = "floor"),
		"Structure mode" = image(icon = 'icons/obj/doors/airlocks/external/external.dmi', icon_state = "closed")
	)
	var/choised_mode = show_radial_menu(user, user, choise, require_near = TRUE)
	if(!choised_mode)
		user.balloon_alert(user, "请选择一个！")
		return FALSE
	var/list/pick = list()
	if(choised_mode == "Wall mode")
		pick = init_subtypes_w_path_keys(/turf/closed/wall)
	if(choised_mode == "Turf mode")
		pick = init_subtypes_w_path_keys(/turf/open)
		for(var/turf/open/space/T in pick)
			pick -= T
	if(choised_mode == "Structure mode")
		pick = init_subtypes_w_path_keys(/obj/machinery/door)
	selected_atom = tgui_input_list(user, "选定的对象：", "工具枪施工", pick)
	return TRUE

/datum/phystool_mode/build_mode/secondnary_act(atom/target, mob/user)
	. = ..()

	if(iswallturf(target))
		var/turf/T = target
		T.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		return TRUE
	else if(istype(target, /obj/machinery/door))
		qdel(target)
		return TRUE

/datum/phystool_mode/build_mode/main_act(atom/target, mob/user)
	. = ..()

	if(!selected_atom)
		user.balloon_alert(user, "请先选择对象！")
		return FALSE
	if(!isopenturf(target))
		user.balloon_alert(user, "被阻挡！")
		return FALSE
	var/turf/T = target
	if(T.is_blocked_turf())
		user.balloon_alert(user, "被阻挡！")
		return FALSE
	if(!isturf(selected_atom))
		T.place_on_top(selected_atom)
		return TRUE
	T.TerraformTurf(selected_atom, selected_atom, flags = CHANGETURF_INHERIT_AIR)
	return TRUE
