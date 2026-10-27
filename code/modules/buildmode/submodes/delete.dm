/datum/buildmode_mode/delete
	key = "delete"

/datum/buildmode_mode/delete/show_help(client/builder)
	to_chat(builder, span_purple(boxed_message(
		"[span_bold("删除一个物体")] -> 左键点击 obj/turf/mob\n\
		[span_bold("删除某类型的所有物体")] -> 右键点击 obj/turf/mob"))
	)

/datum/buildmode_mode/delete/handle_click(client/c, params, object)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, LEFT_CLICK))
		if(isturf(object))
			var/turf/T = object
			T.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		else if(isatom(object))
			qdel(object)

	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(check_rights(R_DEBUG|R_SERVER)) //Prevents buildmoded non-admins from breaking everything.
			if(isturf(object))
				return
			var/atom/deleting = object
			var/action_type = tgui_alert(usr,"严格类型（[deleting.type]）还是类型及其所有子类型？",,list("Strict type","Type and subtypes","Cancel"))
			if(action_type == "Cancel" || !action_type)
				return

			if(tgui_alert(usr,"你确实确定要删除类型 [deleting.type] 的所有实例吗？",,list("Yes","No")) != "Yes")
				return

			if(tgui_alert(usr,"需要二次确认。要删除吗？",,list("Yes","No")) != "Yes")
				return

			var/O_type = deleting.type
			switch(action_type)
				if("Strict type")
					var/i = 0
					for(var/atom/Obj in world)
						if(Obj.type == O_type)
							i++
							qdel(Obj)
						CHECK_TICK
					if(!i)
						to_chat(usr, "不存在该类型的实例")
						return
					log_admin("[key_name(usr)] 删除了类型 [O_type] 的所有实例（已删除 [i] 个实例） ")
					message_admins(span_notice("[key_name(usr)] 删除了类型 [O_type] 的所有实例（已删除 [i] 个实例） "))
				if("Type and subtypes")
					var/i = 0
					for(var/Obj in world)
						if(istype(Obj,O_type))
							i++
							qdel(Obj)
						CHECK_TICK
					if(!i)
						to_chat(usr, "不存在该类型的实例")
						return
					log_admin("[key_name(usr)] 删除了类型 [O_type] 及其子类型的所有实例（已删除 [i] 个实例） ")
					message_admins(span_notice("[key_name(usr)] 删除了类型 [O_type] 及其子类型的所有实例（已删除 [i] 个实例） "))
