/datum/round_event_control/shuttle_catastrophe
	name = "穿梭机灾难"
	typepath = /datum/round_event/shuttle_catastrophe
	weight = 10
	max_occurrences = 1
	category = EVENT_CATEGORY_BUREAUCRATIC
	description = "用随机穿梭机替换应急穿梭机。"
	admin_setup = list(/datum/event_admin_setup/warn_admin/shuttle_catastrophe, /datum/event_admin_setup/listed_options/shuttle_catastrophe)

/datum/round_event_control/shuttle_catastrophe/can_spawn_event(players, allow_magic = FALSE)
	. = ..()
	if(!.)
		return .

	if(SSshuttle.shuttle_purchased == SHUTTLEPURCHASE_FORCED)
		return FALSE //don't do it if its already been done
	if(istype(SSshuttle.emergency, /obj/docking_port/mobile/emergency/shuttle_build))
		return FALSE //don't undo manual player engineering, it also would unload people and ghost them, there's just a lot of problems
	if(EMERGENCY_AT_LEAST_DOCKED)
		return FALSE //don't remove all players when its already on station or going to centcom
	return TRUE

/datum/round_event/shuttle_catastrophe
	var/datum/map_template/shuttle/new_shuttle

/datum/round_event/shuttle_catastrophe/announce(fake)
	var/cause = pick("遭到了 [syndicate_name()] 特工的袭击", "神秘地被传送走了", "的加油船员发生了哗变",
		"被发现引擎被盗", "\[已删节\]", "飞向落日，然后融化了", "从一头非常聪明的牛那里学到了什么，便自行离去",
		"上面装有克隆设备", "的穿梭机检查员把穿梭机挂成了倒挡而不是驻车挡，导致穿梭机撞进了机库")
	var/message = "你的应急穿梭机[cause]。 "

	if(SSshuttle.shuttle_insurance)
		message += "幸运的是，你的穿梭机保险已承担了维修费用！"
		if(SSeconomy.get_dep_account(ACCOUNT_CAR))
			message += " 由于开支得当，你获得了来自 [command_name()] 的奖金。"
	else
		message += "在另行通知之前，你的替换穿梭机将是 [new_shuttle.name]。"
	priority_announce(message, "[command_name()] 航天工程部")

/datum/round_event/shuttle_catastrophe/setup()
	if(SSshuttle.shuttle_insurance || !isnull(new_shuttle)) //If an admin has overridden it don't re-roll it
		return
	var/list/valid_shuttle_templates = list()
	for(var/shuttle_id in SSmapping.shuttle_templates)
		var/datum/map_template/shuttle/template = SSmapping.shuttle_templates[shuttle_id]
		if(!isnull(template.who_can_purchase) && template.credit_cost < INFINITY) //if we could get it from the communications console, it's cool for us to get it here
			valid_shuttle_templates += template
	new_shuttle = pick(valid_shuttle_templates)

/datum/round_event/shuttle_catastrophe/start()
	if(SSshuttle.shuttle_insurance)
		var/datum/bank_account/station_balance = SSeconomy.get_dep_account(ACCOUNT_CAR)
		station_balance?.adjust_money(8000)
		return
	SSshuttle.shuttle_purchased = SHUTTLEPURCHASE_FORCED
	SSshuttle.unload_preview()
	// We need to move our docking port back in case a crashlanding shuttle has been purchased previously
	for(var/obj/docking_port/stationary/port as anything in SSshuttle.stationary_docking_ports)
		if(port.shuttle_id != "emergency_home")
			continue
		var/turf/initial_loc = locate(port.initial_x, port.initial_y, port.initial_z)
		port.forceMove(initial_loc)
		break
	SSshuttle.existing_shuttle = SSshuttle.emergency
	SSshuttle.action_load(new_shuttle, replace = TRUE)
	log_shuttle("穿梭机灾难设置了一艘新穿梭机：[new_shuttle.name]。")

/datum/event_admin_setup/warn_admin/shuttle_catastrophe
	warning_text = "这将卸载当前停靠的应急穿梭机，并抹除其中的一切。仍要继续吗？"
	snitch_text = "在一艘穿梭机已停靠时强行触发了穿梭机灾难。"

/datum/event_admin_setup/warn_admin/shuttle_catastrophe/should_warn()
	return EMERGENCY_AT_LEAST_DOCKED || istype(SSshuttle.emergency, /obj/docking_port/mobile/emergency/shuttle_build)

/datum/event_admin_setup/listed_options/shuttle_catastrophe
	input_text = "选择指定的穿梭机？"
	normal_run_option = "随机穿梭机"

/datum/event_admin_setup/listed_options/shuttle_catastrophe/get_list()
	var/list/valid_shuttle_templates = list()
	for(var/shuttle_id in SSmapping.shuttle_templates)
		var/datum/map_template/shuttle/template = SSmapping.shuttle_templates[shuttle_id]
		if(!isnull(template.who_can_purchase) && template.credit_cost < INFINITY) //Even admins cannot force the cargo shuttle to act as an escape shuttle
			valid_shuttle_templates += template
	return valid_shuttle_templates

/datum/event_admin_setup/listed_options/shuttle_catastrophe/apply_to_event(datum/round_event/shuttle_catastrophe/event)
	event.new_shuttle = chosen
