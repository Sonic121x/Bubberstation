/obj/machinery/computer/shuttle/ferry
	name = "运输渡船控制台"
	desc = "一台控制运输渡船的控制台。"
	circuit = /obj/item/circuitboard/computer/ferry
	shuttleId = "ferry"
	possible_destinations = "ferry_home;ferry_away;ferry_ntf" //SKYRAT EDIT CHANGE
	req_access = list(ACCESS_CENT_GENERAL)
	var/allow_silicons = FALSE
	var/allow_emag = FALSE

/obj/machinery/computer/shuttle/ferry/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(!allow_emag)
		balloon_alert(user, "防火墙过于强大！")
		return FALSE
	return ..()

/obj/machinery/computer/shuttle/ferry/attack_ai()
	return allow_silicons ? ..() : FALSE

/obj/machinery/computer/shuttle/ferry/attack_robot()
	return allow_silicons ? ..() : FALSE

/obj/machinery/computer/shuttle/ferry/request
	name = "渡船控制台"
	circuit = /obj/item/circuitboard/computer/ferry/request
	possible_destinations = "ferry_home;ferry_away;ferry_ntf" //SKYRAT EDIT CHANGE
	req_access = list(ACCESS_CENT_GENERAL)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
