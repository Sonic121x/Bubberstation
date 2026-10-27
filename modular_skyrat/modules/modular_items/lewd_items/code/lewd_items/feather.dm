/obj/item/tickle_feather
	name = "挠痒羽毛"
	desc = "一根很能挠痒的羽毛，既能逗人开心，也能恶作剧。"
	icon_state = "feather"
	inhand_icon_state = "feather"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/tickle_feather/attack(mob/living/target, mob/living/user)
	. = ..()
	if(target.stat == DEAD)
		return

	var/mob/living/carbon/human/carbon_target
	if(ishuman(target))
		carbon_target = target
	else if(!iscyborg(target))
		return

	if(!target.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[target] 不愿意让你这么做。"))
		return

	var/message = ""
	switch(user.zone_selected) //to let code know what part of body we gonna tickle
		if(BODY_ZONE_PRECISE_GROIN)
			if(carbon_target && !carbon_target.is_bottomless())
				to_chat(user, span_danger("[target] 的胯部似乎被遮住了！"))
				return

			message = (user == target) ? pick("用 [src] 给自己挠痒",
					"用 [src] 轻轻撩拨自己的肚子") \
				: pick("用 [src] 撩拨 [target] 的肚子",
					"用 [src] 给 [target] 的肚子挠痒",
					"用 [src] 给 [target] 挠痒")
		if(BODY_ZONE_CHEST)
			if(carbon_target)
				var/obj/item/organ/genital/badonkers = carbon_target.get_organ_slot(ORGAN_SLOT_BREASTS)
				if(!badonkers?.is_exposed())
					to_chat(user, span_danger("[target] 的胸部似乎被遮住了！"))
					return

				message = (user == target) ? pick("用 [src] 给自己挠痒",
						"用 [src] 轻轻撩拨自己的乳头") \
					: pick("用 [src] 撩拨 [target] 的乳头",
						"用 [src] 给 [target] 的左乳头挠痒",
						"用 [src] 给 [target] 的右乳头挠痒")
			else
				message = (user == target) ? pick("用 [src] 给自己挠痒",
						"用 [src] 轻轻撩拨自己的合成躯体") \
					: pick("用 [src] 撩拨 [target] 的触觉传感器")
		if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			if(carbon_target && !carbon_target.has_feet(REQUIRE_GENITAL_EXPOSED))
				to_chat(user, span_danger("[target] 的双脚似乎被遮住了！"))
				return

			message = (user == target) ? pick("用 [src] 给自己挠痒",
					"用 [src] 轻轻撩拨自己的双脚") \
				: pick("用 [src] 撩拨 [target] 的双脚",
					"用 [src] 给 [target] 的[user.zone_selected == BODY_ZONE_L_LEG ? "左" : "右"]脚挠痒",
					"用 [src] 给 [target] 的脚趾挠痒")
		if(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM)
			if(carbon_target && !carbon_target.is_topless())
				to_chat(user, span_danger("[target] 的腋下似乎被遮住了！"))
				return

			message = (user == target) ? pick("用 [src] 给自己挠痒",
					"用 [src] 轻轻撩拨自己的腋下") \
				: pick("用 [src] 撩拨 [target] 的右腋下",
					"用 [src] 给 [target] 的[user.zone_selected == BODY_ZONE_L_ARM ? "左" : "右"]腋下挠痒",
					"用 [src] 给 [target] 的腋下挠痒")
		else
			return

	if(prob(70))
		target.try_lewd_autoemote(pick("laugh", "giggle", "twitch", "twitch_s", "moan", ))
	target.do_jitter_animation()
	target.adjust_stamina_loss(4)
	target.add_mood_event("tickled", /datum/mood_event/tickled)
	carbon_target?.adjust_arousal(3)
	user.visible_message(span_purple("[user] [message]!"))
	conditional_pref_sound(loc, \
		pick(
			get_sfx(SFX_CLOTH_DROP), // I duplicate this part of code because im useless shitcoder that can't make it work properly without tons of repeating code blocks
			get_sfx(SFX_CLOTH_PICKUP), // If you can make it better - go ahead, modify it, please.
			get_sfx(SFX_CLOTH_PICKUP),
		), 70, 1, -1)

//Mood boost
/datum/mood_event/tickled
	description = span_nicegreen("呼……刚才被挠痒了。还……挺好玩的！\n")
	mood_change = 0
	timeout = 2 MINUTES
