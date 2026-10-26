/obj/item/pneumatic_cannon/load_item(obj/item/I, mob/user) //we make this compatable with the master file incase of future updates.
	if(!can_load_item(I, user))
		return FALSE
	if(user)
		if(istype(I, /obj/item/storage/toolbox/emergency/turret/mag_fed))
			to_chat(user, span_warning("你准备将 \the [I] 装入 \the [src]。此操作将阻止装入其他物品！"))
			if(!do_after(user, 15)) //adding a warning and a delay so it cant just be invo-juggle-spammed.
				return FALSE
	return ..()

/obj/item/pneumatic_cannon/can_load_item(obj/item/I, mob/user)
	. = ..()
	if(!.)
		return
	if(locate(/obj/item/storage/toolbox/emergency/turret/mag_fed) in src) //If loaded with a turret, stops more from being put in
		if(user)
			to_chat(user, span_warning("\The [I] 被 \the [src] 的装填器挡住了！"))
		return FALSE
	if(istype(I, /obj/item/storage/toolbox/emergency/turret/mag_fed) && length(loadedItems) >= 1)
		if(user)
			to_chat(user, span_warning("\The [I] 需要一门空炮！"))
		return FALSE
