/obj/machinery/computer/arcade/amputation
	name = "医疗半机械人的截肢大冒险"
	desc = "屏幕上闪现着一个浑身浴血的医疗半机械人。\
		它的对话气泡写着：“不是<b>胆小鬼</b>就把手伸进机器里！”"
	icon_state = MAP_SWITCH("arcade", "/obj/machinery/computer/arcade")
	circuit = /obj/item/circuitboard/computer/arcade/amputation
	interaction_flags_machine = NONE //borgs can't play, but the illiterate can.

/obj/machinery/computer/arcade/amputation/attack_tk(mob/user)
	return //that's a pretty damn big guillotine

/obj/machinery/computer/arcade/amputation/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!iscarbon(user))
		return
	to_chat(user, span_warning("你将手伸向机器，却在一把染血的铡刀从中伸出时犹豫起来……"))
	user.played_game()
	var/obj/item/bodypart/chopchop = user.get_active_hand()
	if(do_after(user, 5 SECONDS, target = src, extra_checks = CALLBACK(src, PROC_REF(do_they_still_have_that_hand), user, chopchop)))
		playsound(src, 'sound/items/weapons/slice.ogg', 25, TRUE, -1)
		to_chat(user, span_userdanger("铡刀落在你的手臂上，机器将断臂吸了进去！"))
		chopchop.dismember()
		qdel(chopchop)
		user.mind?.adjust_experience(/datum/skill/gaming, 100)
		user.won_game()
		victory_tickets(rand(6,10))
		return
	if(!do_they_still_have_that_hand(user, chopchop))
		to_chat(user, span_warning("铡刀落下了，但你的手似乎早就没了！"))
		playsound(src, 'sound/items/weapons/slice.ogg', 25, TRUE, -1)
	else
		to_chat(user, span_notice("你明智地决定不把手伸进机器。"))
	user.lost_game()

///Makes sure the user still has their starting hand, preventing the user from pulling the arm out and still getting prizes.
/obj/machinery/computer/arcade/amputation/proc/do_they_still_have_that_hand(mob/user, obj/item/bodypart/chopchop)
	if(QDELETED(chopchop) || chopchop.owner != user)
		return FALSE
	return TRUE

///Dispenses wrapped gifts instead of arcade prizes, also known as the ancap christmas tree
/obj/machinery/computer/arcade/amputation/festive
	name = "医疗半机械人的节日截肢大冒险"
	desc = "屏幕上闪现着一个浑身浴血、戴着圣诞帽的医疗半机械人。它的对话气泡写着：“不是<b>胆小鬼</b>就把手伸进机器里！”"
	prize_override = list(/obj/item/gift/anything = 1)
