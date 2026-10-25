/datum/wires/suit_storage_unit
	holder_type = /obj/machinery/suit_storage_unit
	proper_name = "防护服储存单元"

/datum/wires/suit_storage_unit/New(atom/holder)
	wires = list(
		WIRE_HACK, WIRE_SAFETY,
		WIRE_ZAP
	)
	add_duds(2)
	..()

/datum/wires/suit_storage_unit/interactable(mob/user)
	if(!..())
		return FALSE
	var/obj/machinery/suit_storage_unit/SSU = holder
	if(SSU.panel_open)
		return TRUE

/datum/wires/suit_storage_unit/get_status()
	var/obj/machinery/suit_storage_unit/SSU = holder
	var/list/status = list()
	status += "紫外线灯泡[SSU.uv_super ? "发出亮光" : "十分暗淡"]。"
	status += "维护指示灯[SSU.safeties ? "熄灭" : "亮起"]。"
	return status

/datum/wires/suit_storage_unit/on_pulse(wire)
	var/obj/machinery/suit_storage_unit/SSU = holder
	switch(wire)
		if(WIRE_HACK)
			SSU.uv_super = !SSU.uv_super
		if(WIRE_SAFETY)
			SSU.safeties = !SSU.safeties
		if(WIRE_ZAP)
			SSU.shock(usr, 100)

/datum/wires/suit_storage_unit/on_cut(wire, mend, source)
	var/obj/machinery/suit_storage_unit/SSU = holder
	switch(wire)
		if(WIRE_HACK)
			SSU.uv_super = !mend
		if(WIRE_SAFETY)
			SSU.safeties = mend
		if(WIRE_ZAP)
			SSU.shock(usr, 100)
