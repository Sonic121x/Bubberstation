/datum/wires/atmosshieldgen
	proper_name = "气密护盾发生器"
	randomize = FALSE
	holder_type = /obj/machinery/atmos_shield_gen

/datum/wires/atmosshieldgen/New(atom/holder)
	wires = list(WIRE_ACTIVATE)
	return ..()

/datum/wires/atmosshieldgen/on_pulse(wire)
	var/obj/machinery/atmos_shield_gen/generator = holder
	if(!generator.anchored)
		return
	generator.toggle()
