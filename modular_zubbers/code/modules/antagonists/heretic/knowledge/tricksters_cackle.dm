// prestidigitation
/datum/heretic_knowledge/spell/tricksters_cackle
	name = "诡戏者的承诺"
	desc = "让你能选择若干派对戏法和实用小能力，如清洁、喷洒彩纸等。右键选择模式，左键施放。（无需施法媒介）"
	gain_text = "诡戏者名副其实，最爱耍弄花招。祂手中总握着一副牌，或许也会是一支画笔。向这位神灵微笑、眨眼，\
	祂也许就会赐下自己的承诺。"
	drafting_tier = 1
	drafting_cost = 1 // has actual uses - free cleaning? free synth-compatible healing? yes please
	action_to_add = /datum/action/cooldown/spell/pointed/tricksters_cackle

/datum/action/cooldown/spell/pointed/tricksters_cackle
	name = "诡戏者的承诺"
	desc = "让你能选择若干派对戏法和实用小能力。右键选择模式，左键施放。"
	var/static/list/modes = list(
		"Spawn Confetti" = 5 SECONDS,
		"Clean" = 2 SECONDS,
		"Add A Glow To Any Item" = 10 SECONDS,
		"Enhance Taste & Add Healing To Food" = 50 SECONDS,
		//"ignite" = list(10 SECONDS, image(icon = 'icons/obj/cigarettes.dmi', icon_state = "zippo")),
	)
	var/static/list/modes_to_images = list(
		"Spawn Confetti" = image(icon = 'icons/obj/toys/toy.dmi', icon_state = "party_popper"),
		"Clean" = image(icon = 'icons/obj/watercloset.dmi', icon_state = "soap"),
		"Add A Glow To Any Item" = image(icon = 'icons/obj/lighting.dmi', icon_state = "lantern"),
		"Enhance Taste & Add Healing To Food" = image(icon = 'icons/obj/food/burgerbread.dmi', icon_state = "hburger"),
		//"ignite" = list(10 SECONDS, image(icon = 'icons/obj/cigarettes.dmi', icon_state = "zippo")),
	)
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/obj/food/burgerbread.dmi'
	sound = null
	school = SCHOOL_EVOCATION // no focus needed babe
	antimagic_flags = MAGIC_RESISTANCE
	invocation_type = INVOCATION_NONE // sneaky spell
	spell_requirements = NONE
	button_icon_state = "hburger"
	cooldown_time = 5 SECONDS
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS

	var/mode = "Spawn Confetti"

/datum/action/cooldown/spell/pointed/tricksters_cackle/Trigger(mob/clicker, trigger_flags, atom/target)
	var/right_clicked = !!(trigger_flags & TRIGGER_SECONDARY_ACTION)
	if (right_clicked)
		mode = chinese_heretic_trick_radial(clicker, modes_to_images)
		if (isnull(mode))
			return TRUE
		cooldown_time = modes[mode]
		clicker.balloon_alert(clicker, "已选择[chinese_heretic_trick_display(mode)]")
		return TRUE
	else
		return ..()

/datum/action/cooldown/spell/pointed/tricksters_cackle/is_valid_target(atom/cast_on)
	return TRUE // self casting is a-ok

/datum/action/cooldown/spell/pointed/tricksters_cackle/cast(atom/cast_on)
	. = ..()

	switch (mode)
		if ("Spawn Confetti")
			var/turf/start = owner.loc
			var/range = 3
			if (!istype(start))
				return FALSE

			var/obj/effect/decal/chempuff/reagent_puff = new(start)
			reagent_puff.create_reagents(500)
			reagent_puff.reagents.add_reagent(/datum/reagent/confetti, 15)
			reagent_puff.user = owner
			reagent_puff.stream = FALSE

			var/turf/target_turf = get_turf(cast_on)
			if(target_turf == start) // Don't need to bother movelooping if we don't move
				reagent_puff.setDir(owner.dir)
				reagent_puff.spray_down_turf(target_turf)
				reagent_puff.end_life()
				return

			var/datum/move_loop/our_loop = GLOB.move_manager.move_towards_legacy(reagent_puff, cast_on, 2, timeout = range * 2, flags = MOVEMENT_LOOP_START_FAST, priority = MOVEMENT_ABOVE_SPACE_PRIORITY)
			reagent_puff.RegisterSignal(our_loop, COMSIG_QDELETING, TYPE_PROC_REF(/obj/effect/decal/chempuff, loop_ended))
			reagent_puff.RegisterSignal(our_loop, COMSIG_MOVELOOP_POSTPROCESS, TYPE_PROC_REF(/obj/effect/decal/chempuff, check_move))

			playsound(owner, 'sound/effects/snap.ogg', 30)

			owner.visible_message(
				span_warning("[owner]用手指比出三角形。你听见鬣狗的怪笑，随后——一串彩纸突然从指间喷出！"),
				span_notice("你比出三角秘符，正如诡戏者所承诺的，一串彩纸从你的指间飞出！")
			)
			return TRUE
		if ("Clean")
			if (!cast_on.Adjacent(owner))
				owner.balloon_alert(owner, "太远了！")
				return FALSE
			cast_on.wash(CLEAN_SCRUB)
			owner.visible_message(
				span_warning("[owner]用手指比出圆形。你听见鬣狗的抽鼻声，随后——[cast_on]突然变得一尘不染！"),
				span_notice("你比出圆形秘符，正如诡戏者所承诺的，[cast_on]突然变得干干净净！")
			)
			cast_on.balloon_alert_to_viewers("清洁完毕！")
			return TRUE
		if ("Add A Glow To Any Item")
			if (!cast_on.Adjacent(owner))
				owner.balloon_alert(owner, "太远了！")
				return FALSE
			if (!isitem(cast_on))
				owner.balloon_alert(owner, "不是物品！")
				return FALSE
			if (cast_on.light != null)
				owner.balloon_alert(owner, "已经在发光！")
				return FALSE
			cast_on.set_light(
				3,
				3,
				"#ffcc66"
			)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(unset_trickster_light), cast_on), 120 SECONDS)
			owner.visible_message(
				span_warning("[owner]用手指比出菱形。你听见鬣狗的低哼，随后——[cast_on]突然亮起橙色光芒！"),
				span_notice("你比出菱形秘符，正如诡戏者所承诺的，[cast_on]突然发起光来！")
			)
			cast_on.balloon_alert_to_viewers("发光了！")
			return TRUE
		if ("Enhance Taste & Add Healing To Food")
			if (!cast_on.Adjacent(owner))
				owner.balloon_alert(owner, "太远了！")
				return FALSE
			if (!IS_EDIBLE(cast_on))
				owner.balloon_alert(owner, "不能食用！")
				return FALSE
			if (HAS_TRAIT(cast_on, TRAIT_TRICKSTER_TASTE))
				owner.balloon_alert(owner, "已经强化过了！")
				return FALSE
			ADD_TRAIT(cast_on, TRAIT_TRICKSTER_TASTE, REF(src))
			cast_on.reagents?.add_reagent(/datum/reagent/medicine/omnizine/heretic, 5)

			owner.visible_message(
				span_warning("[owner]用手指比出方形。你听见鬣狗的哼鸣，随后——[cast_on]看起来突然更加诱人了……"),
				span_notice("你比出方形秘符，正如诡戏者所承诺的，[cast_on]突然变得更加美味诱人！")
			)

			RegisterSignal(cast_on, COMSIG_FOOD_GET_EXTRA_COMPLEXITY, PROC_REF(get_food_boost))

			cast_on.balloon_alert_to_viewers("真美味……")

			return TRUE

	return FALSE

/datum/reagent/medicine/omnizine/heretic
	name = "诡戏者的怪笑"
	description = "笑吧，笑吧，一笑置之！反正一切都只是一场戏！"
	color = "#d8c7b7"
	healing = 0.3 // slightly better than protozine
	chemical_flags = NONE // synths can heal from it
	process_flags = REAGENT_ORGANIC|REAGENT_SYNTHETIC

/datum/reagent/medicine/omnizine/heretic/on_mob_metabolize(mob/living/affected_mob)
	. = ..()

	affected_mob.emote("laugh")

/datum/action/cooldown/spell/pointed/proc/get_food_boost(datum/signal_source, list/extra_complexity)
	SIGNAL_HANDLER

	extra_complexity[1] = extra_complexity[1] + 2 // bonus

/proc/unset_trickster_light(atom/target)
	target.set_light(
		0,
		0
	)
	target.visible_message(span_warning("[target]的光芒消退了……"))
