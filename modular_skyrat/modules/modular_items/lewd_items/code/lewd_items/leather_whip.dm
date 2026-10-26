//Yes, whip is mask item, because character can take it in mouth. For some BDSM scenarios it would be cool, but if you make it better with same functionality - go ahead, make me proud.

/obj/item/clothing/mask/leatherwhip
	name = "皮鞭"
	desc = "用于支配的工具。以你喜欢的方式带来疼痛。"
	icon_state = "leather_whip_pink_hard"
	worn_icon_state = "leather_whip"
	base_icon_state = "leather"
	inhand_icon_state = null
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/items/weapons/whip.ogg'
	clothing_flags = INEDIBLE_CLOTHING
	//When taking that thing in mouth
	flags_cover = MASKCOVERSMOUTH
	var/modifies_speech = TRUE
	/// If the color of the toy has been changed before
	var/color_changed = FALSE
	/// If the form (or size) of the toy has been changed before
	var/form_changed = FALSE
	/// Current color of the toy, can be changed, affects sprite
	var/current_whip_color = "pink"
	/// Current form of the toy, can be changed, affects sprite
	var/current_whip_form = "whip"
	/// If the whip is hitting weak or hard
	var/current_whip_type = "hard"
	/// A list of designs of the whip for use in the radial selection menu
	var/static/list/whip_designs
	/// A list of forms of the whip for use in the radial selection menu
	var/static/list/whip_forms
	/// A list of types of the whip for use in the radial selection menu
	var/static/list/whip_types
	/// Mutable appearance containing the whip's overlay
	var/mutable_appearance/whip_overlay

	/// Phrases to be said when the player attempts to talk when their speech is being modified
	var/list/moans = list("Mmmph...", "Hmmphh", "Mmmfhg", "Gmmmh...")
	/// Lower probability phrases to be said when talking.
	var/list/moans_alt = list("Mhgm...", "Hmmmp!...", "GMmmhp!")
	/// Probabilty that `moans_alt` is used instead of `moans`
	var/moans_alt_probability = 5

/obj/item/clothing/mask/leatherwhip/worn_overlays(isinhands = FALSE)
	. = ..()
	. = list()
	if(!isinhands)
		. += whip_overlay

/obj/item/clothing/mask/leatherwhip/equipped(mob/equipper, slot)
	. = ..()
	if ((slot & ITEM_SLOT_MASK) && modifies_speech)
		RegisterSignal(equipper, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	else
		UnregisterSignal(equipper, COMSIG_MOB_SAY)

/obj/item/clothing/mask/leatherwhip/dropped(mob/dropper)
	. = ..()
	UnregisterSignal(dropper, COMSIG_MOB_SAY)

// Speech handler for moansing when talking
/obj/item/clothing/mask/leatherwhip/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER
	speech_args[SPEECH_MESSAGE] = pick((prob(moans_alt_probability) && LAZYLEN(moans_alt)) ? moans_alt : moans)
	conditional_pref_sound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f4.ogg'), 70, 1, -1)

/// Radial menu helper
/obj/item/clothing/mask/leatherwhip/proc/populate_whip_designs()
	whip_designs = list(
		"pink" = image(icon = src.icon, icon_state = "leather_whip_pink_hard"),
		"teal" = image(icon = src.icon, icon_state = "leather_whip_teal_hard"))

/// Radial menu helper
/obj/item/clothing/mask/leatherwhip/proc/populate_whip_forms()
	whip_forms = list(
		"whip" = image(icon = src.icon, icon_state = "leather_whip_pink_hard"),
		"crotch" = image(icon = src.icon, icon_state = "leather_crotch_pink_hard"))

/// Radial menu helper
/obj/item/clothing/mask/leatherwhip/proc/populate_whip_types()
	whip_types = list(
		"weak" = image(icon = src.icon, icon_state = "leather_whip_pink_weak"),
		"hard" = image(icon = src.icon, icon_state = "leather_crotch_pink_hard"))

/obj/item/clothing/mask/leatherwhip/equipped(mob/target, slot)
	. = ..()

	update_icon_state()

	whip_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi', "[base_icon_state]_[current_whip_form]", ABOVE_MOB_LAYER + 0.1) //two arguments. Yes, all mob layer. Fuck person who was working on genitals, they're working wrong.ABOVE_NORMAL_TURF_LAYER

	update_icon()
	update_appearance()
	update_overlays(UPDATE_OVERLAYS)

/obj/item/clothing/mask/leatherwhip/examine(mob/user)
	. = ..()
	if(!color_changed)
		. += span_notice("按住 Alt 点击可更换颜色。")
	else if(!form_changed)
		. += span_notice("按住 Alt 点击可更换款式。")

//to change color
/obj/item/clothing/mask/leatherwhip/click_alt(mob/user)
	if(!color_changed)
		var/choice = chinese_skyrat_item_radial(user, src, whip_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
		if(!choice)
			return CLICK_ACTION_BLOCKING
		current_whip_color = choice
		update_icon()
		update_icon_state()
		color_changed = TRUE
		return CLICK_ACTION_SUCCESS
	else if(!form_changed)
		var/choice = chinese_skyrat_item_radial(user, src, whip_forms, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
		if(!choice)
			return CLICK_ACTION_BLOCKING
		current_whip_form = choice
		update_icon()
		update_icon_state()
		form_changed = TRUE
		return CLICK_ACTION_SUCCESS
	return CLICK_ACTION_BLOCKING

/// A check to see if the radial menu can be used
/obj/item/clothing/mask/leatherwhip/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/obj/item/clothing/mask/leatherwhip/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	update_icon_state()
	update_icon()
	if(!length(whip_designs))
		populate_whip_designs()
	if(!length(whip_forms))
		populate_whip_forms()
	if(!length(whip_types))
		populate_whip_types()

	update_icon_state()

	whip_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi', "[base_icon_state]_[current_whip_form]", ABOVE_MOB_LAYER + 0.1) //two arguments. Yes, all mob layer. Fuck person who was working on genitals, they're working wrong.ABOVE_NORMAL_TURF_LAYER

	update_icon()
	update_appearance()
	update_overlays(UPDATE_OVERLAYS)

/obj/item/clothing/mask/leatherwhip/update_icon_state()
	. = ..()
	icon_state = icon_state = "[base_icon_state]_[current_whip_form]_[current_whip_color]_[current_whip_type]"
	inhand_icon_state = "[base_icon_state]_[current_whip_form]_[current_whip_color]_[current_whip_type]"
	worn_icon_state = "[base_icon_state]_[current_whip_form]"

//safely discipline someone without damage
/obj/item/clothing/mask/leatherwhip/attack(mob/living/target, mob/living/user)
	. = ..()
	if(target.stat == DEAD)
		return

	var/mob/living/carbon/human/carbon_target
	if(ishuman(target))
		carbon_target = target
	else if(!iscyborg(target))
		return

	var/message = ""
	//and there is code for successful check, so we are whipping someone
	if(!target.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[target] 不愿意让你这么做。"))
		return

	switch(user.zone_selected) //to let code know what part of body we gonna whip
		if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			if(carbon_target && !carbon_target.has_feet())
				to_chat(user, span_danger("[target] 似乎没有双腿！"))
				return

			if(current_whip_type == "hard")
				message = (user == target) ? pick("用 [src] 把自己绊倒",
						"用 [src] 将自己放倒在地") \
					: pick("用 [src] 将 [target] 绊倒在地",
						"用 [src] 使 [target] 跪下")

				if(prob(60))
					target.try_lewd_autoemote(pick("gasp", "shiver"))
				if(prob(10))
					target.apply_status_effect(/datum/status_effect/subspace)
				target.Paralyze(1)//don't touch it. It's domination tool, it should have ability to put someone on kneels. I already inserted check for PREF YOU CAN'T ABUSE THIS ITEM
				target.adjust_pain(5)
				conditional_pref_sound(loc, 'sound/items/weapons/whip.ogg', 100)
			else
				message = (user == target) ? pick("用 [src] 把自己绊倒",
						"用 [src] 轻轻将自己放倒在地") \
					: pick("用 [src] 将 [target] 绊倒在地",
						"用 [src] 使 [target] 跪下")
				if(prob(30))
					target.try_lewd_autoemote(pick("gasp", "shiver"))
				if(prob(10))
					target.apply_status_effect(/datum/status_effect/subspace)
				target.Paralyze(1)
				target.adjust_pain(3)
				conditional_pref_sound(loc, 'sound/items/weapons/whip.ogg', 60)

		if(BODY_ZONE_HEAD)
			message = (user == target) ? pick("把 [src] 缠在自己脖子上，勒住自己",
					"用 [src] 勒住自己") \
				: pick("用 [src] 勒住 [target]",
					"把 [src] 缠在 [target] 的脖子上")
			if(prob(70))
				target.try_lewd_autoemote(pick("gasp", "choke", "moan"))
			carbon_target?.adjust_arousal(3)
			target.adjust_pain(5)
			conditional_pref_sound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 80)

		if(BODY_ZONE_PRECISE_GROIN)
			if(carbon_target && !carbon_target.is_bottomless())
				to_chat(user, span_danger("[target] 的臀部似乎被遮住了！"))
				return
			if(current_whip_type == "weak")
				message = (user == target) ? pick("用 [src] 抽打自己",
						"用 [src] 鞭打自己") \
					: pick("用 [src] 戏弄般抽打 [target] 的大腿",
						"用 [src] 鞭打 [target]", "用 [src] 无情地鞭打 [target]")
				if(prob(70))
					target.try_lewd_autoemote(pick("moan", "twitch"))
				if(prob(10))
					target.apply_status_effect(/datum/status_effect/subspace)
				carbon_target?.adjust_arousal(5)
				target.adjust_pain(5)
				target.apply_status_effect(/datum/status_effect/spanked)
				if(HAS_TRAIT(target, TRAIT_MASOCHISM) || HAS_TRAIT(target, TRAIT_BIMBO))
					target.add_mood_event("pervert spanked", /datum/mood_event/perv_spanked)
				conditional_pref_sound(loc, 'sound/items/weapons/whip.ogg', 60)

			else
				message = (user == target) ? pick("用 [src] 粗暴地鞭打自己",
						"用 [src] 鞭打自己") \
					: pick("用 [src] 戏弄般抽打 [target] 的大腿",
						"用 [src] 鞭打 [target]",
						"用 [src] 无情地鞭打 [target]")
				if(prob(70))
					target.try_lewd_autoemote(pick("moan", "twitch", "twitch_s", "scream"))
				if(prob(10))
					target.apply_status_effect(/datum/status_effect/subspace)
				carbon_target?.adjust_arousal(3)
				target.adjust_pain(8)
				target.apply_status_effect(/datum/status_effect/spanked)
				if(HAS_TRAIT(target, TRAIT_MASOCHISM) || HAS_TRAIT(target, TRAIT_BIMBO))
					target.add_mood_event("pervert spanked", /datum/mood_event/perv_spanked)
				conditional_pref_sound(loc, 'sound/items/weapons/whip.ogg', 100)
		else
			if(current_whip_type == "hard")
				message = (user == target) ? pick("用 [src] 惩戒自己",
						"用 [src] 抽打自己") \
					: pick("用 [src] 抽打 [target]",
						"用 [src] 管教 [target]",
						"用 [src] 惩戒 [target]")
				if(prob(10))
					target.apply_status_effect(/datum/status_effect/subspace)
				target.do_jitter_animation()
				target.adjust_pain(7)
				conditional_pref_sound(loc, 'sound/items/weapons/whip.ogg', 100)

			else
				message = (user == target) ? pick("用 [src] 鞭打自己",
						"用 [src] 抽打自己") \
					: pick("用 [src] 戏弄般抽打 [target]",
						"用 [src] 惩戒 [target]",
						"用 [src] 轻轻抽打 [target]")
				if(prob(30))
					target.try_lewd_autoemote(pick("moan", "twitch"))
				if(prob(10))
					target.apply_status_effect(/datum/status_effect/subspace)
				target.do_jitter_animation()
				target.adjust_pain(4)
				carbon_target?.adjust_arousal(5)
				conditional_pref_sound(loc, 'sound/items/weapons/whip.ogg', 60)

	user.visible_message(span_purple("[user] [message]!"))

//toggle low pain mode. Because sometimes screaming isn't good
/obj/item/clothing/mask/leatherwhip/attack_self(mob/user)
	switch(current_whip_type)
		if("hard")
			current_whip_type = "weak"
			to_chat(user, span_notice("[src] 变软了。轻柔模式！"))
		if("weak")
			current_whip_type = "hard"
			to_chat(user, span_notice("[src] 变硬了。有人需要受到惩罚！"))
	update_icon()
	update_icon_state()
