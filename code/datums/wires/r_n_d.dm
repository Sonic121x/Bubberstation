/datum/wires/rnd
	holder_type = /obj/machinery/rnd
	proper_name = "研发设备"
	randomize = TRUE

/datum/wires/rnd/New(atom/holder)
	wires = list(
		WIRE_HACK, WIRE_DISABLE,
		WIRE_SHOCK
	)
	add_duds(5)
	..()

/datum/wires/rnd/interactable(mob/user)
	if(!..())
		return FALSE
	var/obj/machinery/rnd/R = holder
	if(R.panel_open)
		return TRUE

/datum/wires/rnd/get_status()
	var/obj/machinery/rnd/R = holder
	var/list/status = list()
	status += "红灯[R.disabled ? "熄灭" : "亮起"]。"
	status += "蓝灯[R.hacked ? "熄灭" : "亮起"]。"
	return status

/datum/wires/rnd/on_pulse(wire)
	set waitfor = FALSE
	var/obj/machinery/rnd/R = holder
	switch(wire)
		if(WIRE_HACK)
			R.hacked = !R.hacked
		if(WIRE_DISABLE)
			R.disabled = !R.disabled

/datum/wires/rnd/on_cut(wire, mend, source)
	var/obj/machinery/rnd/R = holder
	switch(wire)
		if(WIRE_HACK)
			R.hacked = !mend
		if(WIRE_DISABLE)
			R.disabled = !mend
