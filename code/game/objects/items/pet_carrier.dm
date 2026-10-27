#define pet_carrier_full(carrier) carrier.occupants.len >= carrier.max_occupants || carrier.occupant_weight >= carrier.max_occupant_weight

//Used to transport little animals without having to drag them across the station.
//Comes with a handy lock to prevent them from running off.
/obj/item/pet_carrier
	name = "宠物笼"
	desc = "一个蓝白相间的大号宠物笼。适合用来把<s>肉送给厨师</s>可爱的小动物带着到处走。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/pet_carrier"
	post_init_icon_state = "pet_carrier_open"
	base_icon_state = "pet_carrier"
	inhand_icon_state = "pet_carrier"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	greyscale_config = /datum/greyscale_config/pet_carrier
	greyscale_config_inhand_left = /datum/greyscale_config/pet_carrier_inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/pet_carrier_inhands_right
	greyscale_colors = COLOR_BLUE
	force = 5
	attack_verb_continuous = list("砸", "搬")
	attack_verb_simple = list("砸", "搬")
	w_class = WEIGHT_CLASS_BULKY
	throw_speed = 2
	throw_range = 3
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	interaction_flags_mouse_drop = NEED_DEXTERITY
	/// Is the pet carrier open? Allows you to collect/remove pets.
	var/open = TRUE
	/// Does this carrier allow locking? Disabled for the small pet carrier.
	var/allows_locking = TRUE
	/// Is this carrier locked? Locks don't require access, just an alt click.
	var/locked = FALSE
	/// List of all mob occupants from inside of the pet carrier.
	var/list/occupants = list()
	/// Combined weight of all mob occupants based on the MOB_SIZE_ defines.
	var/occupant_weight = 0
	/// Maximum number of mobs that can fit in a pet carrier, so you can't have infinite mice or something in one carrier
	var/max_occupants = 3
	/// Maximum weight of a mob that can be carried. This is calculated from the mob sizes of occupants
	var/max_occupant_weight = MOB_SIZE_SMALL

	/// Sound played when the mob carrier is opened.
	var/open_sound = 'sound/items/handling/cardboard_box/cardboard_box_rustle.ogg'
	/// Sound played when the mob carrier is closed.
	var/close_sound = 'sound/items/handling/cardboard_box/cardboardbox_drop.ogg'

/obj/item/pet_carrier/Initialize(mapload)
	. = ..()
	register_context()
	AddElement(/datum/element/cuffable_item)

/obj/item/pet_carrier/Destroy()
	if(occupants.len)
		for(var/V in occupants)
			remove_occupant(V)
	return ..()

/obj/item/pet_carrier/Exited(atom/movable/gone, direction)
	. = ..()
	if(isliving(gone) && (gone in occupants))
		var/mob/living/living_gone = gone
		occupants -= gone
		occupant_weight -= living_gone.mob_size

/obj/item/pet_carrier/examine(mob/user)
	. = ..()
	if(occupants.len)
		for(var/V in occupants)
			var/mob/living/L = V
			. += span_notice("里面有[L]。")
	else
		. += span_notice("里面空空如也。")

	// At some point these need to be converted to contextual screentips
	. += span_notice("在手中激活它以[open ? "关闭" : "打开"]箱门。点击拖拽到地板上即可放出里面的动物。")
	if(!open && allows_locking)
		. += span_notice("按住 Alt 点击以[locked ? "解锁" : "锁定"]箱门。")

/obj/item/pet_carrier/attack_self(mob/living/user)
	if(open)
		to_chat(user, span_notice("你关上了[src]的门。"))
		playsound(user, close_sound, 50, TRUE)
		open = FALSE
	else
		if(locked)
			to_chat(user, span_warning("[src]已锁上！"))
			return
		to_chat(user, span_notice("你打开了[src]的门。"))
		playsound(user, open_sound, 50, TRUE)
		open = TRUE
	update_appearance()

/obj/item/pet_carrier/click_alt(mob/living/user)
	if(open || !allows_locking)
		return CLICK_ACTION_BLOCKING
	locked = !locked
	to_chat(user, span_notice("你把锁扣[locked ? "按下" : "抬起"]。"))
	if(locked)
		playsound(user, 'sound/machines/airlock/boltsdown.ogg', 30, TRUE)
	else
		playsound(user, 'sound/machines/airlock/boltsup.ogg', 30, TRUE)
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/pet_carrier/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(user.combat_mode || !isliving(interacting_with))
		return NONE
	if(!open)
		to_chat(user, span_warning("你需要先打开[src]的门！"))
		return ITEM_INTERACT_BLOCKING
	var/mob/living/target = interacting_with
	if(target.mob_size > max_occupant_weight)
		if(ishuman(target))
			if(HAS_TRAIT(target, TRAIT_CATLIKE_INSTINCT))
				to_chat(user, span_warning("这得需要大量猫薄荷和零食，也许还得有根激光笔，才有可能办到。"))
			else
				to_chat(user, span_warning("一般来说，人类是塞不进宠物笼的。"))
		else
			to_chat(user, span_warning("你感觉[target]并不适合装进[name]。"))
		return ITEM_INTERACT_BLOCKING
	if(user == target)
		to_chat(user, span_warning("你为什么会想这么做？"))
		return ITEM_INTERACT_BLOCKING
	load_occupant(user, target)
	return ITEM_INTERACT_SUCCESS

/obj/item/pet_carrier/relaymove(mob/living/user, direction)
	if(open)
		loc.visible_message(span_notice("[user]从[src]里爬了出来！"), \
		span_warning("[user]从[src]里跳了出来！"))
		remove_occupant(user)
		return
	else if(!locked)
		loc.visible_message(span_notice("[user]推开了[src]的门！"), \
		span_warning("[user]推开了[src]的门！"))
		open = TRUE
		update_appearance()
		return
	else if(user.client)
		container_resist_act(user)

/obj/item/pet_carrier/container_resist_act(mob/living/user)
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	if(user.mob_size <= MOB_SIZE_SMALL)
		to_chat(user, span_notice("你把一条肢体伸出[src]的栅栏，摸索着寻找锁扣……（这需要一些时间。）"))
		to_chat(loc, span_warning("你看到[user]伸手穿过栅栏，摸索着寻找锁扣！"))
		if(!do_after(user, rand(300, 400), target = user) || open || !locked || !(user in occupants))
			return
		loc.visible_message(span_warning("[user]伸手穿过栅栏，拨动了[src]上的锁扣！"), null, null, null, user)
		to_chat(user, span_bolddanger("成了！锁扣弹开了！"))
		locked = FALSE
		playsound(src, 'sound/machines/airlock/boltsup.ogg', 30, TRUE)
		update_appearance()
	else
		loc.visible_message(span_warning("有什么东西在顶门，[src]开始晃动起来！"), null, null, null, user)
		to_chat(user, span_notice("你开始向外顶[src]……（这大约需要 20 秒。）"))
		if(!do_after(user, 20 SECONDS, target = user) || open || !locked || !(user in occupants))
			return
		loc.visible_message(span_warning("[user]从[src]里挤了出来！"), null, null, null, user)
		to_chat(user, span_notice("你顶着锁扣的阻力撞开[src]的门，跌了出来！"))
		locked = FALSE
		open = TRUE
		update_appearance()
		remove_occupant(user)

/obj/item/pet_carrier/update_icon_state()
	if(open)
		icon_state = "[base_icon_state]_open"
		return ..()
	icon_state = "[base_icon_state]_[!occupants.len ? "closed" : "occupied"]_[locked ? "locked" : "unlocked"]"
	return ..()

/obj/item/pet_carrier/mouse_drop_dragged(atom/over_atom, mob/user, src_location, over_location, params)
	if(isopenturf(over_atom) && open && occupants.len)
		user.visible_message(span_notice("[user]卸下了[src]。"), \
		span_notice("你把[src]里的动物卸到[over_atom]上。"))
		for(var/V in occupants)
			remove_occupant(V, over_atom)

/obj/item/pet_carrier/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(!locked)
		context[SCREENTIP_CONTEXT_LMB] = open ? "关闭箱门" : "打开箱门"
		return TRUE
	if(allows_locking)
		context[SCREENTIP_CONTEXT_ALT_LMB] = locked ? "解锁箱门" : "锁定箱门"
		return  TRUE

/obj/item/pet_carrier/proc/load_occupant(mob/living/user, mob/living/target)
	if(pet_carrier_full(src))
		to_chat(user, span_warning("[src]已经装得太满了！"))
		return
	user.visible_message(span_notice("[user]开始把[target]装进[src]。"), \
	span_notice("你开始把[target]装进[src]……"), null, null, target)
	to_chat(target, span_userdanger("[user]开始把你装进[name]！"))
	if(!do_after(user, 3 SECONDS, target))
		return
	if(target in occupants)
		return
	if(pet_carrier_full(src)) //Run the checks again, just in case
		to_chat(user, span_warning("[src]已经装得太满了！"))
		return
	user.visible_message(span_notice("[user]把[target]装进了[src]！"), \
	span_notice("你把[target]装进了[src]。"), null, null, target)
	to_chat(target, span_userdanger("[user]把你装进了[name]！"))
	add_occupant(target)

/obj/item/pet_carrier/proc/add_occupant(mob/living/occupant)
	if((occupant in occupants) || !istype(occupant))
		return
	occupant.forceMove(src)
	occupants += occupant
	occupant_weight += occupant.mob_size

/obj/item/pet_carrier/proc/remove_occupant(mob/living/occupant, turf/new_turf)
	if(!(occupant in occupants) || !istype(occupant))
		return
	occupant.forceMove(new_turf ? new_turf : drop_location())
	occupants -= occupant
	occupant_weight -= occupant.mob_size
	occupant.setDir(SOUTH)

/obj/item/pet_carrier/biopod
	name = "生物舱"
	desc = "用途难以名状的外星装置。也能用来装宠物。"
	icon = 'icons/obj/pet_carrier.dmi'
	icon_state = "biopod_open"
	post_init_icon_state = null
	base_icon_state = "biopod"
	inhand_icon_state = "biopod"
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = null

/obj/item/pet_carrier/small
	name = "小型宠物笼"
	desc = "用于携带微型动物的小型宠物笼。"
	icon = 'icons/obj/pet_carrier.dmi'
	icon_state = "small_carrier_open"
	post_init_icon_state = null
	w_class = WEIGHT_CLASS_NORMAL
	base_icon_state = "small_carrier"
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = null

	max_occupants = 1
	allows_locking = FALSE

/obj/item/pet_carrier/small/mouse
	name = "小型老鼠笼"
	desc = "用于携带微型动物的小型宠物笼。这个看起来是为老鼠准备的。"
	icon_state = "small_carrier_occupied_unlocked"
	open = FALSE

/obj/item/pet_carrier/small/mouse/Initialize(mapload)
	var/mob/living/basic/mouse/hero_mouse = new /mob/living/basic/mouse(src)
	add_occupant(hero_mouse) //mouse hero
	return ..()

#undef pet_carrier_full
