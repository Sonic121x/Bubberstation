/obj/item/flatpack/export_gate
	name = "悬赏立方体出口闸门"
	board = /obj/item/circuitboard/machine/export_gate
	custom_premium_price = PAYCHECK_CREW * 1.5

/obj/item/flatpack/export_gate/Initialize(mapload)
	. = ..()
	var/turf/our_turf = get_turf(src)
	new /obj/item/paper/fluff/export_gate(our_turf)

/obj/item/flatpack/export_gate/multitool_act(mob/living/user, obj/item/tool)
	if(isturf(loc))
		var/turf/location = loc
		if(!locate(/obj/machinery/conveyor) in location)
			balloon_alert(user, "需要传送带！")
			return ITEM_INTERACT_BLOCKING

	return ..()

/obj/item/flatpack/materials_market
	name = "材料进口市场"
	board = /obj/item/circuitboard/machine/materials_market
	custom_premium_price = PAYCHECK_CREW * 1.5
