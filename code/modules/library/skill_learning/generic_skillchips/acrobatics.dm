/obj/item/skillchip/acrobatics
	name = "旧款 F058UR7 技能芯片"
	desc = "一款曾经领先时代的技能芯片，能让使用者在翻腾与旋转方面获得奥林匹克级别的高超本体感觉，除此之外一无是处。 \
		它上市后不久便撤出了市场，因为用户过度杂技会损伤芯片的完整性，引发致命的故障。它可真是让“弗斯伯里背越式”名副其实地“摔”了一把！"
	skill_name = "旋感美学"
	skill_description = "让你能以违法且危险的频率翻腾与旋转。"
	skill_icon = FA_ICON_WHEELCHAIR_ALT
	activate_message = span_notice("你突然拥有了一种极其高级而复杂的感知，知道如何优雅地旋转与翻腾。")
	deactivate_message = span_notice("你对旋感美学的神圣掌握彻底消失了。")
	custom_premium_price = PAYCHECK_CREW * 4
	/// set integrity to 1 when mapping for !!FUN!!
	max_integrity = 100
	/// list of emotes whose cd is overridden by this skillchip. can be edited in mapping or ingame
	var/list/affected_emotes = list("spin", "flip", "backflip")
	var/datum/effect_system/basic/spark_spread/sparks
	/// you can use this without lowering integrity! let's be honest. nobody's doing that
	var/allowed_usage = 5
	/// How many seconds does it take for it to recover one allowed usage
	var/reload_charge = 10 SECONDS
	/// current particle effect used for smoking brain
	var/obj/effect/abstract/particle_holder/particle_effect

/obj/item/skillchip/acrobatics/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	RegisterSignal(user, COMSIG_MOB_EMOTE_COOLDOWN_CHECK, PROC_REF(whowee))
	AddElement(/datum/element/obj_regen, 0.01) // 1% regen per SSobj tick.

/obj/item/skillchip/acrobatics/on_deactivate(mob/living/carbon/user, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_EMOTE_COOLDOWN_CHECK)
	RemoveElement(/datum/element/obj_regen, 0.01)

/obj/item/skillchip/acrobatics/Destroy(force)
	QDEL_NULL(sparks)
	QDEL_NULL(particle_effect)
	return ..()

/obj/item/skillchip/acrobatics/proc/whowee(mob/living/carbon/bozo, emote_key, emote_intentional)
	SIGNAL_HANDLER

	if(!(emote_key in affected_emotes))
		return

	if(allowed_usage)
		allowed_usage--
		addtimer(CALLBACK(src, PROC_REF(charge)), reload_charge)
		return COMPONENT_EMOTE_COOLDOWN_BYPASS

	take_damage(1, sound_effect = FALSE)

	if(!sparks)
		sparks = new(src, 5, FALSE)
		sparks.attach(src)

	// minimum roll is by default capped at 50, with the min value lowering as integrity is reduced.
	var/mintegrity = clamp(50 - (100 - get_integrity()), 1, 100)
	switch(rand(mintegrity, get_integrity())) // 1 to 100 but gets worse every time
		// CRIT FAIL
		if(1)
			bozo.visible_message(span_userdanger("[bozo] 的脑袋突然向外炸开了！"))

			explosion(bozo, light_impact_range = 2, adminlog = TRUE, explosion_cause = src)
			// WITNESS THE GORE
			for(var/mob/living/splashed in view(2, bozo))
				if(bozo.has_status_effect(/datum/status_effect/grouped/blindness))
					to_chat(splashed, span_userdanger("有什么东西溅到了你身上"))
				else
					to_chat(splashed, span_userdanger("你被一阵血雨糊住了眼睛！"))
				splashed.Stun(1 SECONDS)
				splashed.Knockdown(2 SECONDS)
				splashed.set_eye_blur_if_lower(15 SECONDS)
				splashed.adjust_confusion(4 SECONDS)

			// GORE
			var/obj/item/bodypart/bozopart = bozo.get_bodypart(BODY_ZONE_HEAD)
			if(bozopart)
				var/datum/wound/cranial_fissure/crit_wound = new()
				crit_wound.apply_wound(bozopart)
			/*
				var/list/droppage_candidates = bozo.get_organs_for_zone(BODY_ZONE_HEAD, include_children = TRUE)
				if(droppage_candidates)
					var/obj/thing_to_drop = pick(droppage_candidates)
					thing_to_drop.forceMove(bozo.drop_location())
			*/ //WHY DOESNTY IT OWRK

			// does not necessarily kill you directly. instead it causes cranial fissure + something to drop from your head. could be eyes, tongue, ears, brain, even implants
			new /obj/effect/gibspawner/generic(get_turf(bozo), bozo)
			sparks.amount = 15
			sparks.start()

			qdel(src)
		// last chance to stop
		if(7 to 9)
			bozo.visible_message(
				span_danger("[bozo] 似乎短路了！"),
				span_userdanger("你的大脑短路了！"),
			)
			// if they're susceptible to electrocution, confuse them
			if(bozo.electrocute_act(15, bozo, 1, SHOCK_NOGLOVES|SHOCK_NOSTUN))
				bozo.adjust_confusion(15 SECONDS)
				bozo.set_eye_blur_if_lower(10 SECONDS)
			// but the rest of the effects will happen either way
			bozo.adjust_organ_loss(ORGAN_SLOT_BRAIN, 20 - get_integrity())
			sparks.amount = 5
			sparks.start()

		// brain Smoking. you should probably stop now
		if(13 to 15)
			// if already hot, light 'em up
			var/particle_path = /particles/smoke/steam/mild
			if(bozo.has_status_effect(/datum/status_effect/temperature_over_time/chip_overheat))
				bozo.adjust_fire_stacks(11 - get_integrity())
				bozo.ignite_mob()
				bozo.visible_message(
					span_danger("[bozo] 的脑袋着火了！"),
					span_userdanger("你的头太疼了，感觉像是烧了起来！"),
				)
				ASYNC
					bozo.emote("scream")
				if(particle_effect?.type == particle_path)
					return
				particle_path = /particles/smoke/steam/bad
			else
				bozo.visible_message(
					span_danger("[bozo] 的脑袋开始冒烟了！"),
					span_userdanger("你的大脑感觉像是烧了起来！"),
				)

				// increase smokiness if already smoking
				if(particle_effect?.type == /particles/smoke/steam/mild)
					particle_path = /particles/smoke/steam
				else
					particle_path = /particles/smoke/steam/mild

			bozo.adjust_confusion(4 SECONDS)
			bozo.set_eye_blur_if_lower(3 SECONDS)

			particle_effect = new(bozo, particle_path)
			// roughly head position.
			// dont know how to make this not hardcoded
			particle_effect.set_particle_position(-2, 12, 0)
			bozo.apply_status_effect(/datum/status_effect/temperature_over_time/chip_overheat, 15 SECONDS)
			QDEL_IN(particle_effect, 15 SECONDS)
			sparks.amount = 10
			sparks.start()

		// hey, something isn't right...
		if(16 to 50)
			bozo.visible_message(
				span_warning("[bozo] 的脑袋冒出了火花。"),
			)

			sparks.amount = rand(1, 2)
			sparks.start()

	return COMPONENT_EMOTE_COOLDOWN_BYPASS

/obj/item/skillchip/acrobatics/proc/charge()
	allowed_usage++

/obj/item/skillchip/acrobatics/kiss
	name = "原型编号 807 - K1SS 技能芯片"
	desc = "研发技能芯片时一次随意的实验酿成了这场灾难。所有参与者都发誓至死保密，但看来有人把这个错误放了出去。"
	skill_name = "ERROERERROROROEROEORROER"
	skill_description = "错误：未找到描述"
	skill_icon = FA_ICON_KISS_BEAM
	activate_message = span_userdanger("这是个错误。")
	deactivate_message = span_userdanger("这个错误结束了。")
	custom_premium_price = PAYCHECK_CREW * 500
	max_integrity = 25
	affected_emotes = list("kiss")
	allowed_usage = 1
	reload_charge = 30 SECONDS
