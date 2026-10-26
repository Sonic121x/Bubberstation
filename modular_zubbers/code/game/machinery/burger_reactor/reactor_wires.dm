#define WIRE_VENT_DIRECTION "Vent Direction"
#define WIRE_VENT_POWER "Vent Power"
#define WIRE_TAMPER "Tamper"
#define WIRE_FACTORY_RESET "Factory Reset"

/datum/wires/rbmk2
	holder_type = /obj/machinery/power/rbmk2
	proper_name = "RB-MK2"

/datum/wires/rbmk2/New(atom/holder)
	wires = list(
		WIRE_ACTIVATE,
		WIRE_THROW,
		WIRE_VENT_POWER,
		WIRE_VENT_DIRECTION,
		WIRE_SAFETY,
		WIRE_LIMIT,
		WIRE_POWER,
		WIRE_TAMPER,
	)
	. = ..()

/datum/wires/rbmk2/emp_pulse()
	return TRUE //Handled already in the RBMK.

/datum/wires/rbmk2/interactable(mob/user)
	if(!..())
		return FALSE
	var/obj/machinery/power/rbmk2/M = holder
	return M.panel_open

/datum/wires/rbmk2/get_status()
	var/obj/machinery/power/rbmk2/M = holder
	. = list()
	. += "电力指示灯[M.power && M.powernet ? "亮着黄光" : "已熄灭"]。"
	. += "棒体指示灯[M.stored_rod ? "亮着紫光" : "已熄灭"]。"
	. += "运行指示灯[M.active ? "亮着绿光" : "已熄灭"]。"
	. += "安全指示灯[M.safety ? "亮着蓝光" : "闪着红光"]。"

	if(M.auto_vent_upgrade && M.auto_vent)
		. += "通风指示灯[M.venting ? "亮着黄光" : "闪着红光"]。"
	else if(M.vent_reverse_direction)
		. += "通风指示灯[M.venting ? "交替闪着橙光和白光" : "闪着红光"]。"
	else
		. += "通风指示灯[M.venting ? "亮着绿光" : "闪着红光"]。"

	. += "冷却限制器显示：[M.cooling_limiter < M.cooling_limiter_max ? "[M.cooling_limiter]%" : "自动"]"
	. += "防篡改指示灯[M.tampered ? "闪着红光" : "亮着绿光"]。"

/datum/wires/rbmk2/on_pulse(wire)
	var/obj/machinery/power/rbmk2/M = holder
	switch(wire)
		if(WIRE_FACTORY_RESET)
			M.auto_vent_upgrade = FALSE
			M.safeties_upgrade = FALSE
			M.overclocked_upgrade = FALSE
		if(WIRE_ACTIVATE)
			M.toggle_active(usr)
		if(WIRE_THROW)
			M.remove_rod(usr,do_throw=TRUE)
		if(WIRE_VENT_POWER)
			M.toggle_vents(usr)
			if(isliving(usr))
				M.shock(usr,0.125)
		if(WIRE_VENT_DIRECTION)
			M.toggle_reverse_vents(usr)
		if(WIRE_SAFETY)
			M.toggle_active(usr,FALSE)
		if(WIRE_LIMIT)
			M.cooling_limiter = (M.cooling_limiter + 10) % (M.cooling_limiter_max+10)
		if(WIRE_POWER)
			if(isliving(usr))
				M.shock(usr,0.5)
		if(WIRE_TAMPER)
			M.tampered = TRUE

/datum/wires/rbmk2/on_cut(wire, mend, source)
	var/obj/machinery/power/rbmk2/M = holder
	switch(wire)
		if(WIRE_ACTIVATE)
			M.toggle_active(usr,mend)
		if(WIRE_THROW)
			if(mend)
				M.remove_rod(usr,do_throw=TRUE)
		if(WIRE_VENT_POWER)
			M.toggle_vents(usr,mend)
			if(isliving(usr))
				M.shock(usr,0.25)
		if(WIRE_VENT_DIRECTION)
			if(mend)
				M.toggle_reverse_vents(usr,FALSE)
		if(WIRE_SAFETY)
			M.safety = mend
			if(!mend)
				var/turf/T = get_turf(M)
				if(usr)
					message_admins("[ADMIN_LOOKUPFLW(usr)]在[ADMIN_VERBOSEJMP(T)]剪断了[src]的安全线。")
					usr.log_message("cut the safety wire of [M]", LOG_GAME)
					M.investigate_log("had the safety wire cut by [key_name(usr)] at [AREACOORD(M)].", INVESTIGATE_ENGINE)
				else
					message_admins("[src]的安全线在[ADMIN_VERBOSEJMP(T)]被剪断")
					log_game("[src] had the safety wire cut at [AREACOORD(T)]")
					M.investigate_log("had the safety wire cut at [AREACOORD(T)]", INVESTIGATE_ENGINE)
		if(WIRE_LIMIT)
			M.cooling_limiter = mend ? initial(M.cooling_limiter) : 0
		if(WIRE_POWER)
			M.power = mend
			if(!mend)
				var/turf/T = get_turf(M)
				if(usr)
					message_admins("[ADMIN_LOOKUPFLW(usr)]在[ADMIN_VERBOSEJMP(T)]剪断了[src]的电力线。")
					usr.log_message("cut the power wire of [M]", LOG_GAME)
					M.investigate_log("had the power wire cut by [key_name(usr)] at [AREACOORD(M)].", INVESTIGATE_ENGINE)
				else
					message_admins("[src]的电力线在[ADMIN_VERBOSEJMP(T)]被剪断")
					log_game("[src] had the power wire cut at [AREACOORD(T)]")
					M.investigate_log("had the power wire cut at [AREACOORD(T)]", INVESTIGATE_ENGINE)
			if(isliving(usr))
				M.shock(usr)
		if(WIRE_TAMPER)
			M.tampered = TRUE

/datum/wires/rbmk2/can_reveal_wires(mob/user)
	if(HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		return TRUE
	return ..()


#undef WIRE_VENT_DIRECTION
#undef WIRE_VENT_POWER
#undef WIRE_TAMPER
#undef WIRE_FACTORY_RESET
