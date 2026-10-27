/obj/machinery/mecha_part_fabricator/interdyne
	name="辛迪加牌机甲制造机"
	link_on_init = FALSE
	circuit=/obj/machinery/mecha_part_fabricator/interdyne

/obj/machinery/mecha_part_fabricator/interdyne/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	if(user.has_faction(ROLE_SYNDICATE))
		obj_flags |= EMAGGED
		for(var/found_illegal_mech_nods in SSresearch.techweb_nodes)
			var/datum/techweb_node/illegal_mech_node = SSresearch.techweb_nodes[found_illegal_mech_nods]
			if(!illegal_mech_node?.illegal_mech_node)
				continue
			for(var/id in illegal_mech_node.design_ids)
				var/datum/design/illegal_mech_design = SSresearch.techweb_design_by_id(id)
//				illegal_local_designs |= illegal_mech_design // Fix this if it's broken after.
				cached_designs |= illegal_mech_design
		say("接$收!到错误 设#计。正@在连%接到 ~NULL~ 服务器$。")
		playsound(src, 'sound/machines/uplink/uplinkerror.ogg', 50, TRUE)
		update_static_data_for_all_viewers()
		return TRUE
	else
		to_chat(user, span_warning("你试着点了几下、敲了敲键盘，却完全不明白该怎么操作它"))
		return FALSE

/obj/item/circuitboard/machine/mechfab/interdyne
	name = "辛迪加机甲制造机"
	build_path = /obj/machinery/mecha_part_fabricator/interdyne

