/obj/item/circuitboard/machine/rodstopper
	name = "铁棒拦截器（机器电路板）"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rodstopper
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/obj/item/stack/sheet/plasteel = 1,
	)

/obj/machinery/rodstopper
	name = "铁棒拦截器"
	desc = "一台能够阻止不可移动铁棒的先进机器。"
	icon = 'modular_skyrat/modules/rod-stopper/icons/rodstopper.dmi'
	icon_state = "rodstopper"
	density = TRUE
	use_power = NO_POWER_USE
	circuit = /obj/item/circuitboard/machine/rodstopper
	layer = BELOW_OBJ_LAYER

/obj/machinery/rodstopper/examine(mob/user)
	. = ..()
	. += span_warning("它拦住铁棒时会引发局部现实坍缩，请保持距离！")

/obj/machinery/rodstopper/Initialize(mapload)
	. = ..()
	warn_area()

/obj/machinery/rodstopper/proc/warn_area()
	playsound(src, 'sound/announcer/alarm/bloblarm.ogg', 100)
	say("警告！请撤离此区域！否则你将立即灰飞烟灭！")
	addtimer(CALLBACK(src, PROC_REF(warn_area)), 15 SECONDS, TIMER_OVERRIDE|TIMER_UNIQUE) // the sound is 7 seconds, however.
