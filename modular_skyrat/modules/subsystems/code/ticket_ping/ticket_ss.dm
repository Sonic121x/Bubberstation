/// Pings admins every (time chosen in config) for all open tickets/OPFOR applications
SUBSYSTEM_DEF(ticket_ping)
	name = "Ticket Ping"
	ss_flags = SS_BACKGROUND
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 3 MINUTES

/datum/controller/subsystem/ticket_ping/Initialize()
	if(CONFIG_GET(number/ticket_ping_frequency) < 1)
		ss_flags |= SS_NO_FIRE
		return SS_INIT_NO_NEED

	wait = CONFIG_GET(number/ticket_ping_frequency)
	return SS_INIT_SUCCESS

/datum/controller/subsystem/ticket_ping/fire(resumed)
	var/valid_ahelps
	var/valid_opfors
	for(var/datum/admin_help/ahelp in GLOB.ahelp_tickets.active_tickets)
		if(ahelp.handler || ahelp.ticket_ping_stop || !ahelp.ticket_ping)
			continue
		valid_ahelps++

	for(var/datum/opposing_force/opfor in SSopposing_force.submitted_applications)
		if(opfor.handling_admin || !opfor.ticket_ping)
			continue
		valid_opfors++

	if(!valid_ahelps && !valid_opfors)
		return
	var/pending_count
	if(!valid_ahelps)
		pending_count = valid_opfors
	else
		pending_count = valid_ahelps + valid_opfors
	message_admins(span_adminnotice("目前共有[pending_count]项待处理事务：[valid_ahelps ? "[valid_ahelps]条管理员工单" : ""][(valid_ahelps && valid_opfors) ? "以及" : ""][valid_opfors ? "[valid_opfors]份敌对势力申请" : ""]。"))
	for(var/client/staff as anything in GLOB.admins)
		if(staff?.prefs.read_preference(/datum/preference/toggle/admin/ticket_ping))
			SEND_SOUND(staff, sound('modular_skyrat/modules/subsystems/sounds/soft_ping.ogg'))
			window_flash(staff, ignorepref = TRUE)
