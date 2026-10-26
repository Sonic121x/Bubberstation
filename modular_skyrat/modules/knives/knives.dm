//--- BOWIE'S KNIFE (bowie knife)---


/obj/item/knife/bowie
	name = "\improper 博伊刀"
	desc = "边疆拓荒者的经典之作，比起刀更像一把短剑。它拥有全龙骨结构、黄铜护手与刀首、锋利至极的刀尖，以及宽大厚重的刀身。除了不便携，它几乎满足你对一把刀的所有期待。"
	icon = 'modular_skyrat/modules/knives/icons/bowie.dmi'
	icon_state = "bowiehand"
	inhand_icon_state = "bowiehand"
	lefthand_file = 'modular_skyrat/modules/knives/icons/bowie_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/knives/icons/bowie_righthand.dmi'
	worn_icon_state = "knife"
	force = 17 // why was this 20 what the fuck man
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 20
	wound_bonus = 10 //scalpel tier
	exposed_wound_bonus = 20 // Very-bigly

/obj/item/storage/belt/bowie_sheath
	name = "\improper 博伊刀鞘"
	desc = "一只装饰考究的皮革刀鞘，带有黄铜护尖。正中央装有一个大号口袋夹，方便携带这把本来颇为累赘的刀。"
	icon = 'modular_skyrat/modules/knives/icons/bowiepocket.dmi'
	icon_state = "bowiesheath"
	slot_flags = ITEM_SLOT_POCKETS
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE
	interaction_flags_click = NEED_DEXTERITY

/obj/item/storage/belt/bowie_sheath/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 1
	atom_storage.max_total_storage = WEIGHT_CLASS_BULKY
	atom_storage.set_holdable(list(
		/obj/item/knife/bowie,
		))

/obj/item/storage/belt/bowie_sheath/click_alt(mob/user)
	if(length(contents))
		var/obj/item/knife = contents[1]
		user.visible_message(span_notice("[user] 从 [src] 里取出 [knife]。"), span_notice("你从 [src] 里取出 [knife]。"))
		user.put_in_hands(knife)
		update_appearance()
		return CLICK_ACTION_SUCCESS
	else
		to_chat(user, span_warning("[src] 是空的！"))
		return CLICK_ACTION_BLOCKING

/obj/item/storage/belt/bowie_sheath/update_icon_state()
	icon_state = initial(icon_state)
	if(contents.len)
		icon_state += "e-knife"
	return ..()

/obj/item/storage/belt/bowie_sheath/PopulateContents()
	new /obj/item/knife/bowie(src)
	update_appearance()
