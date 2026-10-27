#define CANDLE_LUMINOSITY 2
#define PAIN_DEFAULT 9

/obj/item/bdsm_candle
	name = "大豆蜡烛"
	desc = "一支低熔点蜡烛。"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	icon_state = "candle_pink_off"
	base_icon_state = "candle"
	inhand_icon_state = "candle_pink_off"
	w_class = WEIGHT_CLASS_TINY
	light_color = LIGHT_COLOR_FIRE
	heat = 600
	/// Current color of the candle, can be changed and affects sprite
	var/current_color = "pink"
	/// If the color has been changed before
	var/color_changed = FALSE
	/// If the candle is on
	var/lit = FALSE
	/// If the candle should spawn lit
	var/start_lit = FALSE
	/// Static list used for displaying colors in the radial selection menu
	var/static/list/candle_designs
	/// Static list of possible colors for the candle
	var/static/list/candlelights = list(
		"pink" = LIGHT_COLOR_FIRE,
		"teal" = COLOR_CYAN,
	)

//to change color of candle
//create radial menu
/obj/item/bdsm_candle/proc/populate_candle_designs()
	candle_designs = list(
		"pink" = image(icon = src.icon, icon_state = "candle_pink_lit"),
		"teal" = image(icon = src.icon, icon_state = "candle_teal_lit"),
	)

/obj/item/bdsm_candle/proc/update_brightness()
	set_light_on(lit)
	update_light()

/obj/item/bdsm_candle/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/obj/item/bdsm_candle/Initialize(mapload)
	. = ..()
	update_icon()
	update_icon_state()
	if(start_lit)
		light()
	if(!length(candle_designs))
		populate_candle_designs()

/obj/item/bdsm_candle/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_color]_[lit ? "lit" : "off"]"
	inhand_icon_state = "[base_icon_state]_[current_color]_[lit ? "lit" : "off"]"

/obj/item/bdsm_candle/attackby(obj/item/object, mob/user, params)
	var/msg = object.ignition_effect(src, user)
	update_brightness()
	if(msg)
		light(msg)
	else
		return ..()

/obj/item/bdsm_candle/fire_act(exposed_temperature, exposed_volume)
	if(!lit)
		light()
		update_brightness()
	return ..()

/obj/item/bdsm_candle/get_temperature()
	return lit * heat

/obj/item/bdsm_candle/proc/light(show_message)
	if(lit)
		return
	lit = TRUE
	if(show_message)
		usr.visible_message(show_message)
	set_light(CANDLE_LUMINOSITY)
	START_PROCESSING(SSobj, src)
	update_icon()
	update_brightness()

/obj/item/bdsm_candle/proc/put_out_candle()
	if(!lit)
		return
	lit = FALSE
	update_icon()
	set_light(0)
	return TRUE

/obj/item/bdsm_candle/extinguish()
	put_out_candle()
	return ..()

/obj/item/bdsm_candle/process(seconds_per_tick)
	if(!lit)
		return PROCESS_KILL
	open_flame()
	update_brightness()

/obj/item/bdsm_candle/examine(mob/user)
	. = ..()
	if(!color_changed && !lit)
		. += span_notice("按住 Alt 点击可更换颜色。")
	else if(lit)
		. += span_notice("按住 Alt 点击可熄灭火焰。")

/obj/item/bdsm_candle/click_alt(mob/user)
	if(!lit && !color_changed)
		var/choice = chinese_skyrat_item_radial(user, src, candle_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
		if(!choice)
			return CLICK_ACTION_BLOCKING
		current_color = choice
		light_color = candlelights[choice]
		update_icon()
		update_brightness()
		color_changed = TRUE
		return CLICK_ACTION_SUCCESS
	else
		if(!put_out_candle())
			return CLICK_ACTION_BLOCKING
		user.visible_message(span_notice("[user] 熄灭了 [src]。"))
		return CLICK_ACTION_SUCCESS

/*
*	WAX DROPPING
*/

/obj/item/bdsm_candle/attack(mob/living/carbon/human/attacked, mob/living/carbon/human/user)
	. = ..()
	if(attacked.stat == DEAD)
		return
	if(!istype(attacked))
		return

	var/message = ""
	if(!attacked.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[attacked] 似乎不愿意让你这么做。"))
		return
	if(!lit)
		to_chat(user, span_danger("必须点燃 [src] 才能产生蜡液！"))
		return
	switch(user.zone_selected) //to let code know what part of body we gonna wax
		if(BODY_ZONE_PRECISE_GROIN)
			var/obj/item/organ/genital/penis = attacked.get_organ_slot(ORGAN_SLOT_PENIS)
			var/obj/item/organ/genital/vagina = attacked.get_organ_slot(ORGAN_SLOT_VAGINA)
			var/penis_message = (user == attacked) ? pick("将蜡液滴在自己的阴茎上，愉悦地呻吟",
						"将蜡液滴在自己身上，任其流到阴茎上") \
					: pick("将蜡液直接滴在 [attacked] 的阴茎上，带来些许瘙痒",
						"将 [src] 的热蜡滴在 [attacked] 的阴茎上，使其微微颤抖",
						"倾斜蜡烛，让 [src] 的蜡液滴在 [attacked] 的阴茎上，使其呻吟")

			var/vagina_message = (user == attacked) ? pick("将蜡液滴在自己身上，任其流到阴道处",
						"将蜡液滴在自己的阴部，愉悦地呻吟") \
					: pick("将蜡液滴在 [attacked] 的阴道处",
						"倾斜蜡烛，让蜡液缓缓滴到 [attacked] 的阴道处",
						"倾斜蜡烛，让 [src] 的蜡液滴在 [attacked] 的阴部，使其呻吟")

			if(vagina?.is_exposed() && penis?.is_exposed())
				message = pick(penis_message, vagina_message)
			else if(penis?.is_exposed())
				message = penis_message
			else if(vagina?.is_exposed())
				message = vagina_message
			else if(attacked.is_bottomless())
				message = (user == attacked) ? pick("将蜡液滴在自己身上，任其流到腹部，愉悦地呻吟",
						"将蜡液滴在自己的肚子上") \
					: pick("将蜡液滴在 [attacked] 的腹部",
						"倾斜蜡烛，让蜡液缓缓滴到 [attacked] 的肚子上",
						"倾斜蜡烛，让 [src] 的蜡液滴在 [attacked] 的胯部，使其呻吟")
			else
				to_chat(user, span_danger("[attacked] 的胯部似乎被遮住了！"))
				return
			attacked.adjust_pain(PAIN_DEFAULT)

		if(BODY_ZONE_CHEST)
			var/obj/item/organ/genital/breasts = attacked.get_organ_slot(ORGAN_SLOT_BREASTS)
			if(breasts?.is_exposed())
				var/breasts_or_nipples = breasts ? ORGAN_SLOT_BREASTS : ORGAN_SLOT_NIPPLES
				message = (user == attacked) ? pick("将蜡液滴在自己的[chinese_skyrat_item_label(breasts_or_nipples)]上，尽情释放欲望",
						"将蜡液直接滴在自己的[breasts ? "乳房" : "胸部"]上，感到一阵晕眩") \
					: pick("将 [src] 缓缓滴落的蜡液倒在 [attacked] 的[chinese_skyrat_item_label(breasts_or_nipples)]上，使其露出享受的神情",
						"倾斜蜡烛，蜡液刚滴到 [attacked] 的[chinese_skyrat_item_label(breasts_or_nipples)]上，对方便颤抖起来",
						"倾斜蜡烛，热蜡刚滴到 [attacked] 的[chinese_skyrat_item_label(breasts_or_nipples)]上，对方便愉悦地轻声呻吟")
				attacked.adjust_pain(PAIN_DEFAULT * 0.66)

			else
				to_chat(user, span_danger("[attacked] 的胸部似乎被遮住了！"))
				return
		else
			return
	attacked.do_jitter_animation()
	if(prob(50))
		attacked.try_lewd_autoemote(pick("twitch_s" , "gasp", "shiver"))
	user.visible_message(span_purple("[user] [message]!"))
	conditional_pref_sound(loc, pick('modular_zubbers/sound/lewd/vax1.ogg',
						'modular_zubbers/sound/lewd/vax2.ogg'), 70, TRUE)

#undef CANDLE_LUMINOSITY
#undef PAIN_DEFAULT
