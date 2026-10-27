/obj/item/clothing/strapon
	name = "穿戴式假阳具"
	desc = "有时候你需要用特别的方式来羞辱某人。"
	icon_state = "strapon_human"
	base_icon_state = "strapon"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	slot_flags = ITEM_SLOT_BELT
	var/in_hands = FALSE
	var/type_changed = FALSE
	var/strapon_type = "human"
	var/obj/item/strapon_dildo/strapon_item
	var/static/list/strapon_types
	actions_types = list(/datum/action/item_action/take_strapon)

//create radial menu
/obj/item/clothing/strapon/proc/populate_strapon_types()
	strapon_types = list(
		"avian" = image (icon = src.icon, icon_state = "strapon_avian"),
		"canine" = image (icon = src.icon, icon_state = "strapon_canine"),
		"dragon" = image (icon = src.icon, icon_state = "strapon_dragon"),
		"equine" = image (icon = src.icon, icon_state = "strapon_equine"),
		"human" = image (icon = src.icon, icon_state = "strapon_human"))

//to change model
/obj/item/clothing/strapon/click_alt(mob/user)
	if(type_changed)
		return CLICK_ACTION_BLOCKING
	var/choice = show_radial_menu(user, src, strapon_types, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!choice)
		return CLICK_ACTION_BLOCKING
	strapon_type = choice
	update_icon()
	type_changed = TRUE
	return CLICK_ACTION_SUCCESS

//Check if we can change strapon's model
/obj/item/clothing/strapon/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/obj/item/clothing/strapon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	update_icon_state()
	update_icon()
	update_mob_action_buttonss()
	if(!length(strapon_types))
		populate_strapon_types()

//shitcode here, please improve if you can. Genitals overlapping with strapon, doesn't cool!

/obj/item/clothing/strapon/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/affected_mob = user
	var/obj/item/organ/genital/vagina/affected_vagina = affected_mob.get_organ_slot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/womb/affected_womb = affected_mob.get_organ_slot(ORGAN_SLOT_WOMB)
	var/obj/item/organ/genital/penis/affected_penis = affected_mob.get_organ_slot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/affected_testicles = affected_mob.get_organ_slot(ORGAN_SLOT_TESTICLES)

	if(src == affected_mob.belt)
		affected_vagina?.visibility_preference = GENITAL_NEVER_SHOW
		affected_womb?.visibility_preference = GENITAL_NEVER_SHOW
		affected_penis?.visibility_preference = GENITAL_NEVER_SHOW
		affected_testicles?.visibility_preference = GENITAL_NEVER_SHOW
		affected_mob.update_body()
	else
		return

/obj/item/clothing/strapon/dropped(mob/living/user)
	. = ..()
	var/mob/living/carbon/human/affected_mob = user
	var/obj/item/organ/genital/vagina/affected_vagina = affected_mob.get_organ_slot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/womb/affected_womb = affected_mob.get_organ_slot(ORGAN_SLOT_WOMB)
	var/obj/item/organ/genital/penis/affected_penis = affected_mob.get_organ_slot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/affected_testicles = affected_mob.get_organ_slot(ORGAN_SLOT_TESTICLES)

	if(strapon_item && !ismob(loc) && in_hands == TRUE && src != affected_mob.belt)
		qdel(strapon_item)
		in_hands = FALSE

	if(src == affected_mob.belt)
		affected_vagina?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		affected_womb?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		affected_penis?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		affected_testicles?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		affected_mob.update_body()
	else
		return

/obj/item/clothing/strapon/update_icon_state()
	.=..()
	icon_state = "[base_icon_state]_[strapon_type]"

//Functionality stuff
/obj/item/clothing/strapon/proc/update_mob_action_buttonss()
	for(var/datum/action/item_action/take_strapon/action_button in actions_types)
		action_button.button_icon_state = "dildo_[strapon_type]"
		action_button.button_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	update_icon()

//button stuff
/datum/action/item_action/take_strapon
	name = "把假阳具握在手中"
	desc = "把假阳具拿在手里，以便正常使用。"

/datum/action/item_action/take_strapon/Trigger(trigger_flags)
	if(!..())
		return FALSE
	var/obj/item/clothing/strapon/affected_item = target
	if(istype(affected_item))
		affected_item.check()

/obj/item/clothing/strapon/proc/check()
	var/mob/living/carbon/human/user = usr
	if(src == user.belt)
		toggle(user)
	else
		to_chat(user, span_warning("你需要先把假阳具系在腰上才能使用！"))

/obj/item/clothing/strapon/proc/toggle(mob/living/carbon/human/user)
	conditional_pref_sound(user, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 40, TRUE)
	var/obj/item/held = user.get_active_held_item()
	var/obj/item/unheld = user.get_inactive_held_item()

	if(in_hands == TRUE)
		if(istype(held, /obj/item/strapon_dildo))
			qdel(held)
			user.visible_message(span_notice("[user] 把假阳具收了回去。"))
			in_hands = FALSE
			return

		else if(istype(unheld, /obj/item/strapon_dildo))
			qdel(unheld)
			user.visible_message(span_notice("[user] 把假阳具收了回去。"))
			in_hands = FALSE
			return

		else if(held == null)
			if(istype(unheld, /obj/item/strapon_dildo) && unheld.item_flags == ABSTRACT | HAND_ITEM)
				if(src == user.belt)
					qdel(unheld)
					//CODE FOR PUTTING STRAPON IN HANDS
					strapon_item = new()
					user.put_in_hands(strapon_item)
					strapon_item.strapon_type = strapon_type
					strapon_item.update_icon_state()
					strapon_item.update_icon()
					user.visible_message(span_notice("[user] 威胁性地把假阳具握在手中。"))
					in_hands = TRUE
					return
		else
			user.visible_message(span_notice("[user] 想把假阳具握在手中，但手上并不空！"))
			return
	else
		strapon_item = new()
		user.put_in_hands(strapon_item)
		strapon_item.strapon_type = strapon_type
		strapon_item.update_icon_state()
		strapon_item.update_icon()
		user.visible_message(span_notice("[user] 威胁性地把假阳具握在手中。"))
		in_hands = TRUE
		return

/obj/item/strapon_dildo
	name = "穿戴式假阳具"
	desc = "一件用来威慑与无情的道具。"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	icon_state = "dildo_human"
	base_icon_state = "dildo"
	inhand_icon_state = "nothing"
	force = 0
	throwforce = 0
	item_flags = ABSTRACT | HAND_ITEM | DROPDEL
	var/strapon_type = "human" //Default var, but we always getting var from strapon_type from item on top

/obj/item/strapon_dildo/Initialize(mapload)
	. = ..()
	update_icon_state()
	update_icon()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_STRAPON)

/obj/item/strapon_dildo/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[strapon_type]"

/obj/item/strapon_dildo/attack(mob/living/carbon/human/hit_mob, mob/living/carbon/human/user)
	if(hit_mob == user)
		return
	. = ..()
	if(!istype(hit_mob, /mob/living/carbon/human))
		return

	var/message = ""
	var/obj/item/organ/genital/vagina = hit_mob.get_organ_slot(ORGAN_SLOT_VAGINA)
	if(hit_mob.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		switch(user.zone_selected) //to let code know what part of body we gonna fuck
			if(BODY_ZONE_PRECISE_GROIN)
				if(vagina)
					if(hit_mob.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
						message = pick("用 [src] 轻轻摩擦 [hit_mob] 的阴道", "用 [src] 操进 [hit_mob] 的阴道", "把 [src] 狠狠塞进 [hit_mob] 的小穴", "用 [src] 挑逗 [hit_mob] 的小穴")
						hit_mob.adjust_arousal(6)
						hit_mob.adjust_pleasure(8)
						if(prob(40))
							hit_mob.try_lewd_autoemote(pick("twitch_s", "moan"))
						user.visible_message(span_purple("[user][message]！"))
						conditional_pref_sound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 60, TRUE)
					else
						to_chat(user, span_danger("[hit_mob] 的裆部被遮住了！"))
						return
				else
					to_chat(user, span_danger("[hit_mob] 没有适合这么做的性器官！"))
					return

			if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES) //Mouth only. Sorry, perverts. No eye/ear penetration for you today.
				if(!hit_mob.is_mouth_covered())
					message = pick("用 [src] 操进 [hit_mob] 的嘴里", "把 [src] 捅进 [hit_mob] 的喉咙深处，让 [hit_mob] 喘不过气", "强迫 [hit_mob] 含住 [src]", "把 [src] 插进 [hit_mob] 的喉咙")
					hit_mob.adjust_arousal(4)
					hit_mob.adjust_pleasure(1)
					hit_mob.adjust_oxy_loss(1.5)
					if(prob(70))
						hit_mob.try_lewd_autoemote(pick("gasp", "moan"))
					user.visible_message(span_purple("[user][message]！"))
					conditional_pref_sound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 40, TRUE)

				else
					to_chat(user, span_danger("[hit_mob] 的嘴被遮住了！"))
					return

			else
				if(hit_mob.is_bottomless())
					message = pick("用 [src] 操进 [hit_mob] 的屁股", "用 [src] 操进 [hit_mob] 的肛门", "把 [src] 狠狠捅进 [hit_mob] 的屁股", "用 [src] 粗暴地操着 [hit_mob] 的屁股，让 [hit_mob] 爽得翻起了白眼")
					hit_mob.adjust_arousal(5)
					hit_mob.adjust_pleasure(5)
					if(prob(60))
						hit_mob.try_lewd_autoemote(pick("twitch_s", "moan", "shiver"))
					user.visible_message(span_purple("[user][message]！"))
					conditional_pref_sound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 100, TRUE)

				else
					to_chat(user, span_danger("[hit_mob] 的肛门被遮住了！"))
					return
	else
		to_chat(user, span_danger("[hit_mob] 不想让你这么做。"))
		return
