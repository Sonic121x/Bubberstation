

/datum/round_event_control/shuttle_insurance
	name = "穿梭机保险"
	typepath = /datum/round_event/shuttle_insurance
	max_occurrences = 1
	category = EVENT_CATEGORY_BUREAUCRATIC
	description = "一份可疑但合法的保险报价。"

/datum/round_event_control/shuttle_insurance/can_spawn_event(players, allow_magic = FALSE)
	. = ..()
	if(!.)
		return .

	if(!SSeconomy.get_dep_account(ACCOUNT_CAR))
		return FALSE //They can't pay?
	if(SSshuttle.shuttle_purchased == SHUTTLEPURCHASE_FORCED)
		return FALSE //don't do it if there's nothing to insure
	if(istype(SSshuttle.emergency, /obj/docking_port/mobile/emergency/shuttle_build))
		return FALSE //this shuttle prevents the catastrophe event from happening making this event effectively useless
	if(EMERGENCY_AT_LEAST_DOCKED)
		return FALSE //catastrophes won't trigger so no point
	return TRUE

/datum/round_event/shuttle_insurance
	var/ship_name = "\"以防万一\""
	var/datum/comm_message/insurance_message
	var/insurance_evaluation = 0

/datum/round_event/shuttle_insurance/announce(fake)
	priority_announce("收到子空间通讯。所有通讯控制台已开启安全频道。", "收到讯息", SSstation.announcer.get_rand_report_sound())

/datum/round_event/shuttle_insurance/setup()
	ship_name = pick(strings(PIRATE_NAMES_FILE, "rogue_names"))
	for(var/shuttle_id in SSmapping.shuttle_templates)
		var/datum/map_template/shuttle/template = SSmapping.shuttle_templates[shuttle_id]
		if(template.name == SSshuttle.emergency.name) //found you slackin
			insurance_evaluation = template.credit_cost/2
			break
	if(!insurance_evaluation)
		insurance_evaluation = 5000 //gee i dunno

/datum/round_event/shuttle_insurance/start()
	insurance_message = new("穿梭机保险", "嘿，朋友，这里是 [ship_name]。我忍不住注意到你正开着一艘狂野又疯狂的穿梭机，却没有任何保险！太疯狂了。要是它出了什么事呢，嗯？！我们已快速评估了你在本星区的费率，只需缴纳 [insurance_evaluation] 保费，我们便会为你的穿梭机承保，以应对任何灾难。", list("购买保险。","拒绝报价。"))
	insurance_message.answer_callback = CALLBACK(src, PROC_REF(answered))
	GLOB.communications_controller.send_message(insurance_message, unique = TRUE)

/datum/round_event/shuttle_insurance/proc/answered()
	if(EMERGENCY_AT_LEAST_DOCKED)
		priority_announce("朋友们，你们现在买保险绝对是太迟了。我们的代理人不上门服务。",sender_override = ship_name, color_override = "red")
		return
	if(insurance_message && insurance_message.answered == 1)
		var/datum/bank_account/station_balance = SSeconomy.get_dep_account(ACCOUNT_CAR)
		if(!station_balance?.adjust_money(-insurance_evaluation))
			priority_announce("你们汇来的钱不够买穿梭机保险。用太空外行的话说，这叫做诈骗。钱我们留下了，骗子们！", sender_override = ship_name, color_override = "red")
			return
		priority_announce("感谢你购买穿梭机保险！", sender_override = ship_name, color_override = "red")
		SSshuttle.shuttle_insurance = TRUE
