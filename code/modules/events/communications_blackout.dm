/datum/round_event_control/communications_blackout
	name = "通讯中断"
	typepath = /datum/round_event/communications_blackout
	weight = 30
	category = EVENT_CATEGORY_ENGINEERING
	description = "对所有电信设备施加强力电磁脉冲，使所有通讯中断一段时间。"
	min_wizard_trigger_potency = 0
	max_wizard_trigger_potency = 3

/datum/round_event/communications_blackout
	announce_when = 1

/datum/round_event/communications_blackout/announce(fake)
	var/alert = pick( "检测到电离层异常。临时通讯中断即将发生。请联系你*%fj00)`5vc-BZZT",
		"检测到电离层异常。临时通讯中*3mga;b4;'1v¬-BZZZT",
		"检测到电离层异常。临时通#MCi46:5.;@63-BZZZZT",
		"检测到电离层异'fZ\\kg5_0-BZZZZZT",
		"电离层:%£ MCayj^j<.3-BZZZZZZT",
		"#4nd%;f4y6,>£%-BZZZZZZZT",
	)

	for(var/mob/living/silicon/ai/A in GLOB.ai_list) //AIs are always aware of communication blackouts.
		to_chat(A, "<br>[span_warning("<b>[alert]</b>")]<br>")
		to_chat(A, span_notice("记住，你可以右键点击全息投影台来通过它传输，并用 \".[/datum/saymode/holopad::key]\" 通过它说话。"))

	if(prob(30) || fake) //most of the time, we don't want an announcement, so as to allow AIs to fake blackouts.
		priority_announce(alert, "异常警报", sound = ANNOUNCER_COMMSBLACKOUT) //SKYRAT EDIT CHANGE - ORIGINAL: priority_announce(alert, "Anomaly Alert")


/datum/round_event/communications_blackout/start()
	for(var/obj/machinery/telecomms/shhh as anything in GLOB.telecomm_machines)
		shhh.emp_act(EMP_HEAVY)
	for(var/datum/transport_controller/linear/tram/transport as anything in SStransport.transports_by_type[TRANSPORT_TYPE_TRAM])
		if(!isnull(transport.home_controller))
			var/obj/machinery/transport/tram_controller/tcomms/controller = transport.home_controller
			controller.emp_act(EMP_HEAVY)
