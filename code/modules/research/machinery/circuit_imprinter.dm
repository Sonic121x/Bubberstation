/obj/machinery/rnd/production/circuit_imprinter
	name = "电路印刷机"
	desc = "制造用于建造机器的电路板。"
	icon_state = "circuit_imprinter"
	base_icon_state = "circuit_imprinter"
	production_animation = "circuit_imprinter_ani"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter
	allowed_buildtypes = IMPRINTER

/obj/machinery/rnd/production/circuit_imprinter/compute_efficiency()
	var/rating = 0
	for(var/datum/stock_part/servo/servo in component_parts)
		rating += servo.tier

	return 0.5 ** max(rating - 1, 0) // One sheet, half sheet, quarter sheet, eighth sheet.

/obj/machinery/rnd/production/circuit_imprinter/flick_animation(datum/material/mat)
	return //we presently have no animation

/obj/machinery/rnd/production/circuit_imprinter/offstation
	name = "古老电路印刷机"
	desc = "制造用于建造机器的电路板。其古老的构造可能限制它打印所有已知技术的能力。"
	allowed_buildtypes = AWAY_IMPRINTER
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/offstation
