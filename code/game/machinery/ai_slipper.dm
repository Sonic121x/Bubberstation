/obj/machinery/ai_slipper
	name = "泡沫喷射器"
	desc = "可远程启动的泡沫喷射器，用于控制人群。"
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "ai-slipper0"
	base_icon_state = "ai-slipper"
	layer = ABOVE_OPEN_TURF_LAYER
	plane = FLOOR_PLANE
	max_integrity = 200
	armor_type = /datum/armor/machinery_ai_slipper

	var/uses = 20
	COOLDOWN_DECLARE(foam_cooldown)
	var/cooldown_time = 10 SECONDS // just about enough cooldown time so you cant waste foam
	req_access = list(ACCESS_AI_UPLOAD)

/datum/armor/machinery_ai_slipper
	melee = 50
	bullet = 20
	laser = 20
	energy = 20
	fire = 50
	acid = 30

/obj/machinery/ai_slipper/examine(mob/user)
	. = ..()
	. += span_notice("剩余泡沫可使用<b>[uses]</b>次。")

/obj/machinery/ai_slipper/update_icon_state()
	if(machine_stat & BROKEN)
		return ..()
	if((machine_stat & NOPOWER) || !COOLDOWN_FINISHED(src, foam_cooldown) || !uses)
		icon_state = "[base_icon_state]0"
		return ..()
	icon_state = "[base_icon_state]1"
	return ..()

/obj/machinery/ai_slipper/interact(mob/user)
	if(!allowed(user))
		to_chat(user, span_danger("访问被拒绝。"))
		return
	if(!uses)
		to_chat(user, span_warning("[src]的泡沫已用尽，无法启动！"))
		return
	if(!COOLDOWN_FINISHED(src, foam_cooldown))
		to_chat(user, span_warning("[src]还需<b>[DisplayTimeText(COOLDOWN_TIMELEFT(src, foam_cooldown))]</b>才能再次启动！"))
		return
	var/datum/effect_system/fluid_spread/foam/foam = new(loc, 4, holder = src)
	foam.start()
	uses--
	to_chat(user, span_notice("你启动了[src]。剩余泡沫可使用<b>[uses]</b>次。"))
	COOLDOWN_START(src, foam_cooldown,cooldown_time)
	power_change()
	addtimer(CALLBACK(src, PROC_REF(power_change)), cooldown_time)
