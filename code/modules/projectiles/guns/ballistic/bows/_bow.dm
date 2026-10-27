
/obj/item/gun/ballistic/bow
	icon = 'icons/obj/weapons/bows/bows.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/bows_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/bows_righthand.dmi'
	name = "弓"
	desc = "在如今这个年代显得格格不入，但至少它很可靠。"
	icon_state = "bow"
	inhand_icon_state = "bow"
	base_icon_state = "bow"
	load_sound = 'sound/items/weapons/gun/general/ballistic_click.ogg'
	fire_sound = 'sound/items/weapons/gun/bow/bow_fire.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/bow
	force = 15
	pinless = TRUE
	attack_verb_continuous = list("抽打", "甩击")
	attack_verb_simple = list("抽打", "甩击")
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	internal_magazine = TRUE
	cartridge_wording = "箭"
	bolt_type = BOLT_TYPE_NO_BOLT
	click_on_low_ammo = FALSE
	must_hold_to_load = TRUE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	about_to_shoot_inside_mail_text = "它的弓弦已经拉满了！"
	/// whether the bow is drawn back
	var/drawn = FALSE

/obj/item/gun/ballistic/bow/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][drawn ? "_drawn" : ""]"

/obj/item/gun/ballistic/bow/update_overlays()
	. = ..()
	if(chambered)
		. += "[chambered.base_icon_state][drawn ? "_drawn" : ""]"

/obj/item/gun/ballistic/bow/click_alt(mob/user)
	if(isnull(chambered))
		return CLICK_ACTION_BLOCKING

	user.put_in_hands(chambered)
	chambered = magazine.get_round()
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/gun/ballistic/bow/proc/drop_arrow()
	chambered.forceMove(drop_location())
	chambered = magazine.get_round()
	update_appearance()

/obj/item/gun/ballistic/bow/chamber_round(spin_cylinder, replace_new_round)
	if(chambered || !magazine)
		return
	chambered = magazine.get_round()
	RegisterSignal(chambered, COMSIG_MOVABLE_MOVED, PROC_REF(clear_chambered))
	update_appearance()

/obj/item/gun/ballistic/bow/clear_chambered(datum/source)
	. = ..()
	drawn = FALSE

/obj/item/gun/ballistic/bow/attack_self(mob/user)
	if(!chambered)
		balloon_alert(user, "还没搭箭！")
		return
	balloon_alert(user, "[drawn ? "弓弦已松开" : "弓弦已拉满"]")
	drawn = !drawn
	playsound(src, 'sound/items/weapons/gun/bow/bow_draw.ogg', 25, TRUE)
	update_appearance()

/obj/item/gun/ballistic/bow/try_fire_gun(atom/target, mob/living/user, params)
	if(!chambered)
		return FALSE
	if(!drawn)
		to_chat(user, span_warning("没拉弓就放弦，箭无力地掉到了地上。"))
		drop_arrow()
		return FALSE
	return ..() //fires, removing the arrow

/obj/item/gun/ballistic/bow/postfire_empty_checks(last_shot_succeeded)
	if(!chambered && !get_ammo())
		drawn = FALSE
		update_appearance()

/obj/item/gun/ballistic/bow/equipped(mob/user, slot, initial)
	. = ..()
	if(slot != ITEM_SLOT_HANDS && chambered)
		balloon_alert(user, "箭掉了出来！")
		if(drawn)
			playsound(src, 'sound/items/weapons/gun/bow/bow_fire.ogg', 25, TRUE)
		drop_arrow()


/obj/item/gun/ballistic/bow/dropped(mob/user, silent)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(drop_arrow_if_not_held)), 0.1 SECONDS)

/obj/item/gun/ballistic/bow/proc/drop_arrow_if_not_held()
	if(ismob(loc) || !chambered)
		return
	if(drawn)
		playsound(src, 'sound/items/weapons/gun/bow/bow_fire.ogg', 25, TRUE)
	drop_arrow()

/obj/item/gun/ballistic/bow/shoot_with_empty_chamber(mob/living/user)
	return //no clicking sounds please

/obj/item/ammo_box/magazine/internal/bow
	name = "弓弦"
	ammo_type = /obj/item/ammo_casing/arrow
	max_ammo = 1
	start_empty = TRUE
	caliber = CALIBER_ARROW
