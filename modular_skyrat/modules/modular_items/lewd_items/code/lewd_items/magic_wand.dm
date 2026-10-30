#define MAGIC_WAND_MODE_OFF "off"
#define MAGIC_WAND_MODE_LOW "low"
#define MAGIC_WAND_MODE_MEDIUM "medium"
#define MAGIC_WAND_MODE_HIGH "high"

/obj/item/clothing/sextoy/magic_wand
	name = "魔法按摩棒"
	desc = "不知道它哪里有魔法，但只要按下按钮，就会发出有趣的振动。"
	icon_state = "magicwand_off"
	base_icon_state = "magicwand"
	worn_icon_state = "magicwand"
	inhand_icon_state = "magicwand"
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	/// What mode the vibrator is on
	var/vibration_mode = MAGIC_WAND_MODE_OFF
	/// Looping sound called on process()
	var/datum/looping_sound/lewd/vibrator/low/soundloop1
	/// Looping sound called on process()
	var/datum/looping_sound/lewd/vibrator/medium/soundloop2
	/// Looping sound called on process()
	var/datum/looping_sound/lewd/vibrator/high/soundloop3
	/// Mutable appearance for the human overlay of this itme
	var/mutable_appearance/magicwand_overlay
	w_class = WEIGHT_CLASS_TINY
	lewd_slot_flags = LEWD_SLOT_VAGINA | LEWD_SLOT_PENIS

//some stuff for making overlay of this item. Why? Because.
/obj/item/clothing/sextoy/magic_wand/worn_overlays(isinhands = FALSE)
	. = ..()
	. = list()
	if(!isinhands)
		. += magicwand_overlay

/obj/item/clothing/sextoy/magic_wand/Initialize(mapload)
	. = ..()

	magicwand_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi', "magicwand", -BODY_FRONT_UNDER_CLOTHES) //two arguments

	update_icon_state()
	update_icon()
	update_appearance()

	//soundloop
	soundloop1 = new(src, FALSE)
	soundloop2 = new(src, FALSE)
	soundloop3 = new(src, FALSE)

/obj/item/clothing/sextoy/magic_wand/Destroy()
	QDEL_NULL(soundloop1)
	QDEL_NULL(soundloop2)
	QDEL_NULL(soundloop3)
	return ..()

/obj/item/clothing/sextoy/magic_wand/create_moth_snack()
	return null

/obj/item/clothing/sextoy/magic_wand/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[vibration_mode]"

/obj/item/clothing/sextoy/magic_wand/lewd_equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(vibration_mode == MAGIC_WAND_MODE_OFF || !istype(user))
		return
	if(src == user.penis || src == user.vagina)
		START_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/magic_wand/dropped(mob/user, slot)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/magic_wand/process(seconds_per_tick)
	var/mob/living/carbon/human/current_user = loc
	if(!istype(current_user) || current_user.stat == DEAD)
		return FALSE

	var/adjustment_amount = 0
	switch(vibration_mode)
		if(MAGIC_WAND_MODE_LOW)
			if(current_user.arousal < 30)
				adjustment_amount = 0.6

		if(MAGIC_WAND_MODE_MEDIUM)
			if(current_user.arousal < 60)
				adjustment_amount = 0.8

		if(MAGIC_WAND_MODE_HIGH)
			adjustment_amount = 1

	if(!adjustment_amount)
		return

	current_user.adjust_arousal(adjustment_amount * seconds_per_tick)
	current_user.adjust_pleasure(adjustment_amount * seconds_per_tick)

/obj/item/clothing/sextoy/magic_wand/attack(mob/living/target, mob/living/user)
	. = ..()
	if(target.stat == DEAD)
		return

	var/mob/living/carbon/human/carbon_target
	if(ishuman(target))
		carbon_target = target
	else if(!iscyborg(target))
		return

	if(!target.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[target] 似乎不愿意让你这么做。"))
		return FALSE

	var/message = ""
	if(vibration_mode == MAGIC_WAND_MODE_OFF)
		to_chat(user, span_warning("必须先开启玩具才能使用！"))
		return FALSE

	var/first_adjective = ""
	var/second_adjective = ""

	switch(vibration_mode)
		if(MAGIC_WAND_MODE_LOW)
			first_adjective = "轻轻地"
			second_adjective = "轻柔地"

		if(MAGIC_WAND_MODE_HIGH)
			first_adjective = "粗暴地"
			second_adjective = "猛烈地"

	switch(user.zone_selected)
		if(BODY_ZONE_PRECISE_GROIN)
			if(carbon_target)
				var/obj/item/organ/genital/penis = carbon_target.get_organ_slot(ORGAN_SLOT_PENIS)
				var/obj/item/organ/genital/vagina = carbon_target.get_organ_slot(ORGAN_SLOT_VAGINA)

				if(!vagina && !penis)
					return FALSE

				if(!(vagina?.is_exposed() || penis?.is_exposed()))
					to_chat(user, span_danger("[carbon_target] 的胯部似乎被遮住了！"))
					return FALSE

				var/target_organs = list()
				if(penis?.is_exposed())
					target_organs += "penis"

				if(vagina?.is_exposed())
					target_organs += "vagina"

				if(!length(target_organs))
					return FALSE

				var/organ_to_use = pick(target_organs)
				message = (user == target) ? pick("用 [src] 按摩自己的[chinese_skyrat_item_label(organ_to_use)]",
						"用 [src] [first_adjective]挑逗自己的[chinese_skyrat_item_label(organ_to_use)]") \
					: pick("用 [src] [second_adjective]按摩 [target] 的[chinese_skyrat_item_label(organ_to_use)]",
						"用 [src] [first_adjective]按摩 [target] 的[chinese_skyrat_item_label(organ_to_use)]",
						"将振动棒抵在 [target] 的[chinese_skyrat_item_label(organ_to_use)]上")
				carbon_target.adjust_arousal(vibration_mode == MAGIC_WAND_MODE_LOW ? 4 : (vibration_mode == MAGIC_WAND_MODE_HIGH ? 8 : 5))
				carbon_target.adjust_pleasure(vibration_mode == MAGIC_WAND_MODE_LOW ? 2 : (vibration_mode == MAGIC_WAND_MODE_HIGH ? 10 : 5))
			else
				message = (user == target) ? pick("用 [src] 按摩自己的合成生殖器",
						"用 [src] [first_adjective]挑逗自己的合成生殖器") \
					: pick("用 [src] [second_adjective]按摩 [target] 的合成生殖器",
						"用 [src] [first_adjective]按摩 [target] 的合成生殖器",
						"将振动棒抵在 [target] 的合成生殖器上")

		if(BODY_ZONE_CHEST)
			if(carbon_target)
				var/obj/item/organ/genital/breasts = carbon_target.get_organ_slot(ORGAN_SLOT_BREASTS)
				if(!breasts?.is_exposed())
					to_chat(user, span_danger("[target] 的胸部似乎被遮住了！"))
					return FALSE

				var/breasts_or_nipples = breasts ? ORGAN_SLOT_BREASTS : ORGAN_SLOT_NIPPLES
				message = (user == target) ? pick("用 [src] 按摩自己的[chinese_skyrat_item_label(breasts_or_nipples)]",
						"用 [src] [first_adjective]挑逗自己的[breasts ? "乳房" : "乳头"]") \
					: pick("用 [src] [second_adjective]挑逗 [target] 的[chinese_skyrat_item_label(breasts_or_nipples)]",
						"用 [src] [vibration_mode == MAGIC_WAND_MODE_LOW ? "慢慢地" : ""]按摩 [target] 的[breasts ? "乳房" : "乳头"]",
						"用 [src] 挑逗 [target] 的[breasts ? "乳房" : "乳头"]")
				carbon_target.adjust_arousal((vibration_mode == MAGIC_WAND_MODE_LOW ? 3 : (vibration_mode == MAGIC_WAND_MODE_HIGH ? 7 : 4)))
				carbon_target.adjust_pleasure((vibration_mode == MAGIC_WAND_MODE_LOW ? 1 : (vibration_mode == MAGIC_WAND_MODE_HIGH ? 9 : 4)))
			else
				message = (user == target) ? pick("用 [src] 按摩自己的触觉传感器",
						"用 [src] [first_adjective]挑逗自己的触觉传感器") \
					: pick("用 [src] [second_adjective]挑逗 [target] 的触觉传感器",
						"用 [src] [vibration_mode == MAGIC_WAND_MODE_LOW ? "慢慢地" : ""]按摩 [target] 的触觉传感器",
						"用 [src] 挑逗 [target] 的触觉传感器")
		else
			to_chat(user, span_warning("请对胯部或胸部使用按摩棒！"))
			return FALSE

	if(prob(30))
		target.try_lewd_autoemote(pick("twitch_s", "moan"))

	user.visible_message(span_purple("[user] [message]!"))
	conditional_pref_sound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', (vibration_mode == MAGIC_WAND_MODE_LOW ? 10 : (vibration_mode == MAGIC_WAND_MODE_HIGH ? 30 : 20)), TRUE, pref_to_check = /datum/preference/toggle/erp/sex_toy_sounds)

/obj/item/clothing/sextoy/magic_wand/attack_self(mob/user)
	toggle_mode()

	switch(vibration_mode)
		if(MAGIC_WAND_MODE_LOW)
			to_chat(user, span_notice("振动模式已切换为低档。嗡……"))
		if(MAGIC_WAND_MODE_MEDIUM)
			to_chat(user, span_notice("振动模式已切换为中档。嗡嗡！"))
		if(MAGIC_WAND_MODE_HIGH)
			to_chat(user, span_notice("振动模式已切换为高档。小心使用。"))
		if(MAGIC_WAND_MODE_OFF)
			to_chat(user, span_notice("[src] 已关闭。欢乐时光结束了？"))

	update_icon()
	update_icon_state()

/// Toggle between toy modes in a specific order
/obj/item/clothing/sextoy/magic_wand/proc/toggle_mode()
	if(vibration_mode != "high")
		conditional_pref_sound(loc, 'sound/items/weapons/magin.ogg', 20, TRUE)

	switch(vibration_mode)
		if("off")
			soundloop1.start()
			vibration_mode = MAGIC_WAND_MODE_LOW

		if("low")
			soundloop1.stop()
			soundloop2.start()
			vibration_mode = MAGIC_WAND_MODE_MEDIUM

		if("medium")
			soundloop2.stop()
			soundloop3.start()
			vibration_mode = MAGIC_WAND_MODE_HIGH

		if("high")
			conditional_pref_sound(loc, 'sound/items/weapons/magout.ogg', 20, TRUE)
			soundloop3.stop()
			vibration_mode = MAGIC_WAND_MODE_OFF

#undef MAGIC_WAND_MODE_OFF
#undef MAGIC_WAND_MODE_LOW
#undef MAGIC_WAND_MODE_MEDIUM
#undef MAGIC_WAND_MODE_HIGH
