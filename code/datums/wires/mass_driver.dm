/datum/wires/mass_driver
	holder_type = /obj/machinery/mass_driver
	proper_name = "质量投射器"

/datum/wires/mass_driver/New(atom/holder)
	wires = list(WIRE_LAUNCH, WIRE_SAFETIES)
	..()

/datum/wires/mass_driver/on_pulse(wire)
	var/obj/machinery/mass_driver/the_mass_driver = holder
	switch(wire)
		if(WIRE_LAUNCH)
			the_mass_driver.drive()
			holder.visible_message(span_notice("驱动机构启动了。"))
		if(WIRE_SAFETIES)
			the_mass_driver.power = 3
			holder.visible_message(span_notice("你听到质量投射器发出令人不安的嗡鸣声。"))

/datum/wires/mass_driver/on_cut(wire, mend, source)
	var/obj/machinery/mass_driver/the_mass_driver = holder
	switch(wire)
		if(WIRE_SAFETIES)
			if(the_mass_driver.power > 1) 
				the_mass_driver.power = 1
				holder.visible_message(span_notice("质量投射器的嗡鸣声停止了。"))
