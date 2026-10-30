#define DEFAULT_AROUSAL_INCREASE 4
#define DEFAULT_PLEASURE_INCREASE 2

#define VIB_OFF "off"
#define VIB_LOW "low"
#define VIB_MEDIUM "medium"
#define VIB_HIGH "hard"

//This code huge and blocky, but we're working on update for... my god, 4 months. If you can upgrade it - do it, but don't remove or break something, test carefully. This item is insertable.
/obj/item/clothing/sextoy/vibrator
	name = "振动棒"
	desc = "哇，真是件……有趣的东西。不知道这个红色按钮是做什么的……"
	icon_state = "vibrator_pink_off"
	base_icon_state = "vibrator"
	inhand_icon_state = "vibrator_pink"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	lewd_slot_flags = LEWD_SLOT_VAGINA | LEWD_SLOT_ANUS
	/// If the toy is on or not
	var/toy_on = FALSE
	/// Current color of the toy, can be changed and affects sprite
	var/current_color = "pink"
	/// If the color has been changed before
	var/color_changed = FALSE
	/// Current vibration mode of the toy
	var/vibration_mode = VIB_OFF
	/// Looping sound used for the toy's audible bit
	var/datum/looping_sound/lewd/vibrator/low/soundloop1
	/// Looping sound used for the toy's audible bit
	var/datum/looping_sound/lewd/vibrator/medium/soundloop2
	/// Looping sound used for the toy's audible bit
	var/datum/looping_sound/lewd/vibrator/high/soundloop3
	/// Static list of designs of the toy, used for the color selection radial menu
	var/static/list/vibrator_designs
	w_class = WEIGHT_CLASS_TINY

//create radial menu
/obj/item/clothing/sextoy/vibrator/proc/populate_vibrator_designs()
	vibrator_designs = list(
		"pink" = image (icon = src.icon, icon_state = "vibrator_pink_low"),
		"teal" = image(icon = src.icon, icon_state = "vibrator_teal_low"),
		"red" = image(icon = src.icon, icon_state = "vibrator_red_low"),
		"yellow" = image(icon = src.icon, icon_state = "vibrator_yellow_low"),
		"green" = image(icon = src.icon, icon_state = "vibrator_green_low"))

/obj/item/clothing/sextoy/vibrator/examine(mob/user)
	. = ..()
	if(!color_changed)
		. += span_notice("按住 Alt 点击可更换款式。")

/obj/item/clothing/sextoy/vibrator/click_alt(mob/user)
	if(color_changed)
		return
	var/choice = chinese_skyrat_item_radial(user, src, vibrator_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!choice)
		return CLICK_ACTION_BLOCKING
	current_color = choice
	update_icon_state()
	update_icon()
	color_changed = TRUE
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/sextoy/vibrator/Initialize(mapload)
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(vibrator_designs))
		populate_vibrator_designs()

	//soundloop
	soundloop1 = new(src, FALSE)
	soundloop2 = new(src, FALSE)
	soundloop3 = new(src, FALSE)

/obj/item/clothing/sextoy/vibrator/Destroy()
	QDEL_NULL(soundloop1)
	QDEL_NULL(soundloop2)
	QDEL_NULL(soundloop3)
	return ..()

/obj/item/clothing/sextoy/vibrator/create_moth_snack()
	return null

/obj/item/clothing/sextoy/vibrator/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_color]_[vibration_mode]"
	inhand_icon_state = "[base_icon_state]_[current_color]"

/obj/item/clothing/sextoy/vibrator/lewd_equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!istype(user))
		return
	if(is_inside_lewd_slot(user))
		START_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/vibrator/dropped(mob/user, slot)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/vibrator/process(seconds_per_tick)
	var/mob/living/carbon/human/user = loc
	if(!istype(user))
		return
	if(toy_on)
		if(vibration_mode == VIB_LOW && user.arousal < 40) //prevent non-stop cumming from wearing this thing
			user.adjust_arousal(0.7 * seconds_per_tick)
			user.adjust_pleasure(0.7 * seconds_per_tick)
		if(vibration_mode == VIB_MEDIUM && user.arousal < 70)
			user.adjust_arousal(1 * seconds_per_tick)
			user.adjust_pleasure(1 * seconds_per_tick)
		if(vibration_mode == VIB_HIGH) //no mercy
			user.adjust_arousal(1.5 * seconds_per_tick)
			user.adjust_pleasure(1.5 * seconds_per_tick)
	else if(!toy_on && user.arousal < 30)
		user.adjust_arousal(0.5 * seconds_per_tick)
		user.adjust_pleasure(0.5 * seconds_per_tick)

//SHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODE
/obj/item/clothing/sextoy/vibrator/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	. = ..()
	if(target.stat == DEAD)
		return
	if(!istype(target))
		return

	var/message = ""
	if(!toy_on)
		to_chat(user, span_notice("必须先开启 [src] 才能使用！"))
		return
	if(!target.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[target] 似乎不愿意让你这么做。"))
		return

	var/vibration_adj = ""
	switch(vibration_mode)
		if(VIB_LOW)
			vibration_adj = pick("轻轻地", "轻柔地")
		if(VIB_HIGH)
			vibration_adj = pick("粗暴地", "猛烈地")

	switch(user.zone_selected) //to let code know what part of body we gonna vibe
		if(BODY_ZONE_PRECISE_GROIN)
			var/obj/item/organ/genital/penis = target.get_organ_slot(ORGAN_SLOT_PENIS)
			var/obj/item/organ/genital/vagina = target.get_organ_slot(ORGAN_SLOT_VAGINA)
			var/penis_message = (user == target) ? pick("用 [src] 按摩自己的阴茎",
					"用 [src] [vibration_adj]挑逗自己的阴茎") \
				: pick("用 [src] [vibration_adj]按摩 [target] 的阴茎",
					"拿 [src] [vibration_adj]按摩 [target] 的阴茎",
					"将按摩棒抵在 [target] 的阴茎上")
			var/vagina_message = (user == target) ? pick("用 [src] 按摩自己的阴道",
						"用 [src] [vibration_adj]挑逗自己的阴部") \
					: pick("用 [src] [vibration_adj]按摩 [target] 的阴道",
						"用 [src] [vibration_adj]按摩 [target] 的胯部",
						"将按摩棒抵在 [target] 的阴部")
			if(vagina?.is_exposed() && penis?.is_exposed())
				message = pick(penis_message, vagina_message)
			else if(vagina?.is_exposed())
				message = vagina_message
			else if(penis?.is_exposed())
				message = penis_message
			else
				to_chat(user, span_danger("[target] 的胯部似乎被遮住了！"))
				return

			target.adjust_arousal(DEFAULT_AROUSAL_INCREASE)
			target.adjust_pleasure(DEFAULT_PLEASURE_INCREASE)
			if(prob(50))
				target.try_lewd_autoemote(pick("twitch_s", "moan", "blush"))

		if(BODY_ZONE_CHEST)
			var/obj/item/organ/genital/breasts = target.get_organ_slot(ORGAN_SLOT_BREASTS)
			if(breasts?.is_exposed())
				var/breasts_or_nipples = breasts ? ORGAN_SLOT_BREASTS : ORGAN_SLOT_NIPPLES
				message = (user == target) ? pick("用 [src] 按摩自己的[chinese_skyrat_item_label(breasts_or_nipples)]",
						"用 [src] [vibration_adj]挑逗自己的乳房") \
					: pick("用 [src] [vibration_adj]挑逗 [target] 的[chinese_skyrat_item_label(breasts_or_nipples)]",
						"用 [src] [vibration_adj]按摩 [target] 的[breasts ? "乳房" : "乳头"]",
						"用 [src] 挑逗 [target] 的[breasts ? "乳房" : "乳头"]",
						"用 [src] 摩擦 [target] 的[breasts ? "乳房" : "乳头"]")
			else
				to_chat(user, span_danger("[target] 的胸部似乎被遮住了！"))
				return

			target.adjust_arousal(DEFAULT_AROUSAL_INCREASE)
			target.adjust_pleasure(DEFAULT_PLEASURE_INCREASE * 0.5)
			if(prob(30))
				target.try_lewd_autoemote(pick("twitch_s", "moan"))
		else
			return
	user.visible_message(span_purple("[user] [message]!"))
	conditional_pref_sound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE)

/obj/item/clothing/sextoy/vibrator/attack_self(mob/user, obj/item/attack_item)
	toggle_mode()
	switch(vibration_mode)
		if(VIB_LOW)
			to_chat(user, span_notice("振动模式现为低档。嗡……"))
		if(VIB_MEDIUM)
			to_chat(user, span_notice("振动模式现为中档。嗡嗡！"))
		if(VIB_HIGH)
			to_chat(user, span_notice("振动模式现为高档。小心使用。"))
		if(VIB_OFF)
			to_chat(user, span_notice("振动棒已关闭。欢乐时光结束了？"))
	update_icon()
	update_icon_state()

/obj/item/clothing/sextoy/vibrator/proc/toggle_mode()
	switch(vibration_mode)
		if(VIB_OFF)
			vibration_mode = VIB_LOW
			toy_on = TRUE
			conditional_pref_sound(loc, 'sound/items/weapons/magin.ogg', 20, TRUE)
			soundloop1.start()
		if(VIB_LOW)
			vibration_mode = VIB_MEDIUM
			conditional_pref_sound(loc, 'sound/items/weapons/magin.ogg', 20, TRUE)
			soundloop1.stop()
			soundloop2.start()
		if(VIB_MEDIUM)
			vibration_mode = VIB_HIGH
			conditional_pref_sound(loc, 'sound/items/weapons/magin.ogg', 20, TRUE)
			soundloop2.stop()
			soundloop3.start()
		if(VIB_HIGH)
			vibration_mode = VIB_OFF
			toy_on = FALSE
			conditional_pref_sound(loc, 'sound/items/weapons/magout.ogg', 20, TRUE)
			soundloop3.stop()

#undef DEFAULT_AROUSAL_INCREASE
#undef DEFAULT_PLEASURE_INCREASE

#undef VIB_OFF
#undef VIB_LOW
#undef VIB_MEDIUM
#undef VIB_HIGH
