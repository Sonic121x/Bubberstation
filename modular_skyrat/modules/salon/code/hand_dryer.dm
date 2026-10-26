/obj/machinery/dryer
	name = "干手机"
	desc = "蜥蜴之息3000型，一款实验性干手机。"
	icon = 'modular_skyrat/modules/salon/icons/dryer.dmi'
	icon_state = "dryer"
	density = FALSE
	anchored = TRUE
	var/busy = FALSE

/obj/machinery/dryer/attack_hand(mob/user)
	if(iscyborg(user) || isAI(user))
		return

	if(!can_interact(user))
		return

	if(busy)
		to_chat(user, span_warning("已经有人在这里烘干了。"))
		return

	to_chat(user, span_notice("你开始烘干双手。"))
	playsound(src, 'modular_skyrat/modules/salon/sound/drying.ogg', 50)
	add_fingerprint(user)
	busy = TRUE
	if(do_after(user, 4 SECONDS, src))
		busy = FALSE
		user.visible_message("[user]用[src]烘干了双手。")
	else
		busy = FALSE
