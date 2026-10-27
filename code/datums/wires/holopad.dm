/datum/wires/holopad
	holder_type = /obj/machinery/holopad
	proper_name = "全息平台"

/datum/wires/holopad/interactable(mob/user)
	var/obj/machinery/holopad/holopad = holder

	return holopad.panel_open ? ..() : FALSE

/datum/wires/holopad/New(atom/holder)
	wires = list(
		WIRE_LOOP_MODE,
		WIRE_REPLAY_MODE
	)
	return ..()

/datum/wires/holopad/get_status()
	var/obj/machinery/holopad/holopad = holder
	var/list/status = list()
	status += "紫灯[holopad.loop_mode ? "亮起" : "熄灭"]。"
	status += "红灯[holopad.replay_mode ? "亮起" : "熄灭"]。"
	return status

/datum/wires/holopad/on_pulse(wire)
	var/obj/machinery/holopad/holopad = holder
	switch(wire)
		if(WIRE_LOOP_MODE)
			holopad.loop_mode = !holopad.loop_mode
		if(WIRE_REPLAY_MODE)
			if (!holopad.replay_mode)
				holopad.replay_start()
				holopad.replay_mode = TRUE
			else
				holopad.replay_stop()
				holopad.replay_mode = FALSE
	return ..()

/datum/wires/holopad/on_cut(wire, mend, source)
	var/obj/machinery/holopad/holopad = holder
	if(wire == WIRE_REPLAY_MODE)
		if(mend)
			holopad.replay_stop()
			holopad.replay_mode = FALSE
		else
			holopad.replay_start()
			holopad.replay_mode = TRUE
	return ..()
