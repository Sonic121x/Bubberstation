/// The amount of mutadone we can process for strike recovery at once.
#define MUTADONE_HEAL 1

/datum/status_effect/decloning
	id = "decloning"
	tick_interval = 3 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/decloning
	remove_on_fullheal = TRUE

	/// How many strikes our status effect holder has left before they are dusted.
	var/strikes_left = 100

/datum/status_effect/decloning/on_apply()
	if(owner.has_reagent(/datum/reagent/medicine/mutadone))
		return FALSE
	to_chat(owner, span_userdanger("你发现自己的身体开始变形。这可不是什么好兆头。"))
	return TRUE

/datum/status_effect/decloning/on_remove()
	if(!QDELETED(owner)) // bigger problems to worry about
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/decloning)

/datum/status_effect/decloning/tick(seconds_between_ticks)
	if(owner.has_reagent(/datum/reagent/medicine/mutadone, MUTADONE_HEAL * seconds_between_ticks))
		var/strike_restore = MUTADONE_HEAL * seconds_between_ticks

		if(strikes_left <= 50 && strikes_left + strike_restore > 50)
			to_chat(owner, span_notice("你感觉肌肉更容易控制了。"))
			owner.remove_movespeed_modifier(/datum/movespeed_modifier/decloning)
		else if(SPT_PROB(5, seconds_between_ticks))
			to_chat(owner, span_warning("你的身体正在重新生长，恢复原本的位置。"))

		strikes_left = min(strikes_left + strike_restore, 100)

		owner.reagents.remove_reagent(/datum/reagent/medicine/mutadone, MUTADONE_HEAL * seconds_between_ticks)

		if(strikes_left == 100)
			qdel(src)

		return

	if(!SPT_PROB(5, seconds_between_ticks))
		return

	var/strike_reduce = 3
	if(strikes_left > 50 && strikes_left - strike_reduce <= 50)
		to_chat(owner, span_danger("你很难控制自己的肌肉。"))
		owner.add_movespeed_modifier(/datum/movespeed_modifier/decloning)

	strikes_left = max(strikes_left - strike_reduce, 0)

	if(prob(50))
		to_chat(owner, span_danger(pick(
			"你的身体正在崩溃。",
			"你感觉部分肌肉正在抽搐。",
			"你的皮肤摸起来像沙子。",
			"你感觉四肢正在移位。",
		)))
	else if(prob(33))
		to_chat(owner, span_danger("你无法控制地抽搐着。"))
		owner.set_jitter_if_lower(30 SECONDS)

	if(strikes_left == 0)
		owner.visible_message(span_danger("[owner]的皮肤化作了尘埃！"), span_boldwarning("你的皮肤化作了尘埃！"))
		owner.dust()
		return

/datum/status_effect/decloning/get_examine_text()
	switch(strikes_left)
		if(68 to 100)
			return span_warning("[owner]的身体看起来有些变形。")
		if(34 to 67)
			return span_warning("[owner]的身体看起来变形<b>相当严重</b>。")
		if(-INFINITY to 33)
			return span_boldwarning("[owner]的身体看起来已严重畸变！")

/atom/movable/screen/alert/status_effect/decloning
	name = "细胞崩溃"
	desc = "你的身体正在变形，似乎支撑不了多久了。你需要尽快接受治疗。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "dna_melt"

/datum/movespeed_modifier/decloning
	multiplicative_slowdown = 0.7
	blacklisted_movetypes = (FLYING|FLOATING)

#undef MUTADONE_HEAL
