/// Send player in not-quiet cryopod. If with_paper = TRUE, place a paper with notification under player.
/mob/proc/send_to_cryo(with_paper = FALSE)
	//effect
	playsound(loc, 'sound/effects/magic/Repulse.ogg', 100, 1)
	do_sparks(5, 1, get_turf(loc))

	//make a paper if need
	if(with_paper)
		var/obj/item/paper/cryo_paper = new /obj/item/paper(loc)
		cryo_paper.name = "通知 - [name]"
		cryo_paper.add_raw_text("我们万分抱歉，[name][job ? "（[job]）" : ""]因暂时不便说明的原因，不得不被送回低温休眠库。<br><br>此致，<br><i>纳米传讯突发睡眠障碍防治局</i>")
		cryo_paper.update_appearance()
	//find cryopod
	for(var/obj/machinery/cryopod/cryo in GLOB.valid_cryopods)
		if(!cryo.occupant && cryo.state_open && !cryo.panel_open) //free, opened, and panel closed?
			if(buckled)
				buckled.unbuckle_mob(src, TRUE)
			if(buckled_mobs)
				for(var/mob/buckled_mob in buckled_mobs)
					unbuckle_mob(buckled_mob)
			cryo.close_machine(src) //put player
			break


