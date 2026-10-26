/obj/machinery/computer/station_goal
	name = "空间站目标控制台"
	desc = "用于设定空间站目标的控制台。"
	icon_screen = "comm"
	icon_keyboard = "tech_key"
	req_access = list(ACCESS_CENT_CAPTAIN)
	circuit = /obj/item/circuitboard/computer/station_goal
	light_color = LIGHT_COLOR_BLUE

	var/list/station_goal_cache = list()

	var/goal_assigned = FALSE

/obj/item/circuitboard/computer/station_goal
	name = "空间站目标（计算机电路板）"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/station_goal

/obj/machinery/computer/station_goal/Initialize(mapload)
	. = ..()
	station_goal_cache = subtypesof(/datum/station_goal)

/obj/machinery/computer/station_goal/ui_interact(mob/user)
	. = ..()
	var/list/dat = list("<b>空间站目标选择 - 仅限官方使用</b>")
	if(!goal_assigned)
		dat += "请选择一个要分配给 [station_name()] 的目标"
		for(var/datum/station_goal/iterating_goal as anything in station_goal_cache)
			dat += "<b><a href='byond://?src=[REF(src)];selected_goal=[initial(iterating_goal.name)]'>[initial(iterating_goal.name)]</a></b>"

		dat += "一旦你选择目标，它将被分配给空间站。"
	else
		dat += "<b>目标已分配。</b>"

	var/datum/browser/popup = new(user, "station_goals","空间站目标", 400, 400, src)
	popup.set_content(dat.Join("<br>"))
	popup.open()
	onclose(user, "station_goals")

/obj/machinery/computer/station_goal/Topic(href, href_list)
	if(..())
		return

	if(goal_assigned)
		return

	if(machine_stat & (NOPOWER|BROKEN|MAINT))
		return

	var/selected_goal = href_list["selected_goal"]

	if(href_list["close"])
		usr << browse(null, "window=station_goals")
		return

	for(var/datum/station_goal/iterating_goal as anything in station_goal_cache)
		if(initial(iterating_goal.name) == selected_goal)
			var/datum/station_goal/goal_to_set = new iterating_goal()
			goal_to_set.send_report()
			SSstation.goals_by_type[iterating_goal] = goal_to_set
			goal_assigned = TRUE
			break
	SStgui.update_uis(src)
