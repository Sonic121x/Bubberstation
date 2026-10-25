/obj/item/wallframe/light_fixture
	name = "灯具框架"
	desc = "用于建造灯具。"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "tube-construct-item"
	result_path = /obj/structure/light_construct
	wall_external = TRUE

/obj/item/wallframe/light_fixture/find_support_structure(atom/structure)
	return istype(structure, /obj/structure/window) ? structure : ..()

/obj/item/wallframe/light_fixture/try_build(atom/support, mob/user)
	var/area/A = get_area(user)
	if(A.always_unpowered)
		balloon_alert(user, "无法放置在此区域！")
		return FALSE
	return ..()

/obj/item/wallframe/light_fixture/small
	name = "小型灯具框架"
	icon_state = "bulb-construct-item"
	result_path = /obj/structure/light_construct/small
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT)

/obj/item/wallframe/light_fixture/try_build(turf/on_wall, user)
	if(!..())
		return
	var/area/local_area = get_area(user)
	if(!local_area.static_lighting)
		to_chat(user, span_warning("你无法在此区域放置 [src]！"))
		return
	return TRUE

/obj/item/wallframe/light_fixture/small/attack_self(mob/user)
	var/turf/local_turf = get_turf(user)
	var/area/local_area = get_area(user)
	if(!isturf(user.loc) || !isfloorturf(local_turf))
		balloon_alert(user, "无法放置在这里！")
		return
	if(local_area.always_unpowered || !local_area.static_lighting)
		balloon_alert(user, "无法放置在此区域！")
		return
	for(var/obj/object in local_turf)
		if(object.density && !(object.obj_flags & IGNORE_DENSITY) || object.obj_flags & BLOCKS_CONSTRUCTION)
			balloon_alert(user, "有东西挡住了！")
			return
	if(local_turf.underfloor_accessibility < UNDERFLOOR_INTERACTABLE)
		balloon_alert(user, "先拆除地板！")
		return
	if(locate(/obj/structure/light_construct/floor) in local_turf)
		balloon_alert(user, "这里已经有灯了！")
		return
	if(locate(/obj/machinery/light/floor) in local_turf)
		balloon_alert(user, "这里已经有灯了！")
		return

	playsound(src.loc, 'sound/machines/click.ogg', 75, TRUE)
	user.visible_message(span_notice("[user.name] 把 [src] 固定到了地板上。"),
		span_notice("你把 [src] 固定到了地板上。"),
		span_hear("你听到咔哒声。"))

	new /obj/structure/light_construct/floor(local_turf)
	qdel(src)

