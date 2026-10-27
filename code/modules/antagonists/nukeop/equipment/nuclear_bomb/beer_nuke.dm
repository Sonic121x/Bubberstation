/// A fake nuke that actually contains beer.
/obj/machinery/nuclearbomb/beer
	name = "\improper 纳米传讯牌核裂变炸药"
	desc = "纳米传讯企业战争部较为成功的成果之一，其核裂变炸药以生产成本低廉、杀伤效果惊人而闻名。标牌上说明，虽然这台特定装置已经退役，但每座纳米传讯空间站都配有同等型号，以防万一。所有舰长都会小心看管引爆所需的磁盘——至少标牌上是这么说的。背面似乎装了个龙头。"
	proper_bomb = FALSE
	is_on_minimap = FALSE
	/// The keg located within the beer nuke.
	var/obj/structure/reagent_dispensers/keg/beer/keg
	/// Reagent that is produced once the nuke detonates.
	var/flood_reagent = /datum/reagent/consumable/ethanol/beer
	/// Round event control we might as well keep track of instead of locating every time
	var/datum/round_event_control/scrubber_overflow/every_vent/overflow_control

/obj/machinery/nuclearbomb/beer/Initialize(mapload)
	. = ..()
	keg = new(src)
	QDEL_NULL(core)
	overflow_control = locate(/datum/round_event_control/scrubber_overflow/every_vent) in SSevents.control

/obj/machinery/nuclearbomb/beer/Destroy()
	UnregisterSignal(overflow_control, COMSIG_CREATED_ROUND_EVENT)
	. = ..()

/obj/machinery/nuclearbomb/beer/examine(mob/user)
	. = ..()
	if(keg.reagents.total_volume)
		. += span_notice("里面还剩 [keg.reagents.total_volume] 单位。")
	else
		. += span_danger("里面空了。")

/obj/machinery/nuclearbomb/beer/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!tool.is_refillable())
		return ..()
	tool.interact_with_atom(keg, user) // redirect refillable containers to the keg, allowing them to be filled
	return ITEM_INTERACT_SUCCESS

/obj/machinery/nuclearbomb/beer/actually_explode()
	if(core)
		return ..()
	//Unblock roundend, we're not actually exploding.
	SSticker.roundend_check_paused = FALSE
	var/turf/bomb_location = get_turf(src)
	if(!bomb_location)
		disarm_nuke()
		return
	if(is_station_level(bomb_location.z))
		addtimer(CALLBACK(src, PROC_REF(really_actually_explode)), 11 SECONDS)
	else
		visible_message(span_notice("[src]不祥地嘶嘶冒泡。"))
		addtimer(CALLBACK(src, PROC_REF(local_foam)), 11 SECONDS)

/obj/machinery/nuclearbomb/beer/disarm_nuke(mob/disarmer)
	exploding = FALSE
	exploded = TRUE
	return ..()

/obj/machinery/nuclearbomb/beer/proc/local_foam()
	do_foam(200, src, get_turf(src), flood_reagent, 100)
	disarm_nuke()

/obj/machinery/nuclearbomb/beer/really_actually_explode(detonation_status)
	if(core)
		return ..()
	//if it's always hooked in it'll override admin choices
	RegisterSignal(overflow_control, COMSIG_CREATED_ROUND_EVENT, PROC_REF(on_created_round_event))
	disarm_nuke()
	overflow_control.run_event(event_cause = "一枚啤酒核弹")

/// signal sent from overflow control when it fires an event
/obj/machinery/nuclearbomb/beer/proc/on_created_round_event(datum/round_event_control/source_event_control, datum/round_event/scrubber_overflow/every_vent/created_event)
	SIGNAL_HANDLER
	UnregisterSignal(overflow_control, COMSIG_CREATED_ROUND_EVENT)
	created_event.forced_reagent_type = flood_reagent
