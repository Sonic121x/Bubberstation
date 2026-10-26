ADMIN_VERB(reset_tram, R_DEBUG|R_ADMIN, "重置电车", "重置电车控制器或其内容。", ADMIN_CATEGORY_DEBUG)
	var/datum/transport_controller/linear/tram/broken_controller
	var/selected_transport_id = tgui_input_list(user, "哪一辆电车？", "脱离轨道", SStransport.debug_tram_list)
	if(isnull(selected_transport_id))
		return
	var/reset_type = tgui_input_list(user, "要多大力度地重置？", "它坏得有多严重", list("清空电车内容", "控制器", "控制器与内容", "删除数据", "取消"))

	if(isnull(reset_type) || reset_type == "取消")
		return

	for(var/datum/transport_controller/linear/tram/transport as anything in SStransport.transports_by_type[TRANSPORT_TYPE_TRAM])
		if(transport.specific_transport_id == selected_transport_id)
			broken_controller = transport
			break

	if(isnull(broken_controller))
		to_chat(user, span_warning("找不到 ID 为 [selected_transport_id] 的运输控制器数据！"))
		return

	switch(reset_type)
		if("清空电车内容")
			var/selection = tgui_alert(user, "清空时包含玩家生物吗？", "内容重置 [selected_transport_id]", list("内容", "内容与玩家", "取消"))
			switch(selection)
				if("内容")
					broken_controller.reset_lift_contents(foreign_objects = TRUE, foreign_non_player_mobs = TRUE, consider_player_mobs = FALSE)
					message_admins("[key_name_admin(user)] 对电车 ID [selected_transport_id] 执行了内容重置。")
					log_transport("TC: [selected_transport_id]: [key_name_admin(user)] performed a contents reset.")
				if("内容与玩家")
					broken_controller.reset_lift_contents(foreign_objects = TRUE, foreign_non_player_mobs = TRUE, consider_player_mobs = TRUE)
					message_admins("[key_name_admin(user)] 对电车 ID [selected_transport_id] 执行了内容与玩家生物重置。")
					log_transport("TC: [selected_transport_id]: [key_name_admin(user)] performed a contents and player mob reset.")
				else
					return

		if("控制器")
			log_transport("TC: [selected_transport_id]: [key_name_admin(user)] performed a controller reset, force operational.")
			message_admins("[key_name_admin(user)] 对电车 ID [selected_transport_id] 执行了控制器重置。")
			broken_controller.set_operational(TRUE)
			broken_controller.reset_position()

		if("控制器与内容")
			var/selection = tgui_alert(user, "清空时包含玩家生物吗？", "内容重置 [selected_transport_id]", list("内容", "内容与玩家", "取消"))
			switch(selection)
				if("内容")
					message_admins("[key_name_admin(user)] 对电车 ID [selected_transport_id] 执行了内容与控制器重置。")
					log_transport("TC: [selected_transport_id]: [key_name_admin(user)] performed a contents reset. Controller reset, force operational.")
					broken_controller.reset_lift_contents(foreign_objects = TRUE, foreign_non_player_mobs = TRUE, consider_player_mobs = FALSE)
				if("内容与玩家")
					message_admins("[key_name_admin(user)] 对电车 ID [selected_transport_id] 执行了内容/玩家/控制器重置。")
					log_transport("TC: [selected_transport_id]: [key_name_admin(user)] performed a contents and player mob reset. Controller reset, force operational.")
					broken_controller.reset_lift_contents(foreign_objects = TRUE, foreign_non_player_mobs = TRUE, consider_player_mobs = TRUE)
				else
					return

			broken_controller.set_operational(TRUE)
			broken_controller.reset_position()

		if("删除数据")
			var/confirm = tgui_alert(user, "删除 [selected_transport_id] 后本回合将无法恢复。你确定吗？", "删除电车 ID [selected_transport_id]", list("是", "取消"))
			if(confirm != "是")
				return

			var/obj/machinery/transport/tram_controller/tram_cabinet = broken_controller.paired_cabinet
			if(!isnull(tram_cabinet))
				tram_cabinet.controller_datum = null
				tram_cabinet.update_appearance()

			broken_controller.cycle_doors(CYCLE_OPEN, BYPASS_DOOR_CHECKS)
			broken_controller.estop()
			qdel(broken_controller)
			message_admins("[key_name_admin(user)] 对电车 ID [selected_transport_id] 执行了数据删除。")
