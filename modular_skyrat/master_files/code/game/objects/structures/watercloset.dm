/obj/structure/sink/attackby(obj/item/attacking_item, mob/living/user, params)
	if(busy)
		to_chat(user, span_warning("已经有人在用这里洗东西了！"))
		return

	if(istype(attacking_item, /obj/item/towel))
		if(reagents.total_volume <= 0)
			to_chat(user, span_notice("\The [src] 是干的。"))
			return FALSE

		busy = TRUE
		user.visible_message(span_notice("[user] 开始在 [src] 里清洗 [attacking_item]。"), span_notice("你开始在 [src] 里清洗 [attacking_item]。"))

		if(!do_after(user, 2 SECONDS, src))
			busy = FALSE
			to_chat(user, span_warning("你还没洗完就把 [attacking_item] 从 [src] 拿走了。"))
			return FALSE

		var/obj/item/towel/washed_towel = attacking_item

		washed_towel.reagents.remove_all(washed_towel.reagents.total_volume)
		washed_towel.transfer_reagents_to_towel(reagents, washed_towel.reagents.maximum_volume, user)

		washed_towel.set_wet(TRUE)
		washed_towel.make_used(user, silent = TRUE)

		user.visible_message(span_notice("[user] 在 [src] 里洗完了 [attacking_item]。"), span_notice("你在 [src] 里洗完了 [washed_towel]，它变得相当湿。"))
		playsound(loc, 'sound/effects/slosh.ogg', 25, TRUE)

		busy = FALSE

	else
		return ..()

