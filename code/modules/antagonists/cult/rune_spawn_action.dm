//after a delay, creates a rune below you. for constructs creating runes.
/datum/action/innate/cult/create_rune
	name = "召唤符文"
	desc = "召唤一枚符文"
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"

	var/obj/effect/rune/rune_type
	var/cooldown = 0
	var/base_cooldown = 1800
	var/scribe_time = 60
	var/damage_interrupt = TRUE
	var/action_interrupt = TRUE
	var/obj/effect/temp_visual/cult/rune_spawn/rune_word_type
	var/obj/effect/temp_visual/cult/rune_spawn/rune_innerring_type
	var/obj/effect/temp_visual/cult/rune_spawn/rune_center_type
	var/rune_color

/datum/action/innate/cult/create_rune/IsAvailable(feedback = FALSE)
	if(!rune_type || cooldown > world.time)
		return FALSE
	return ..()

/datum/action/innate/cult/create_rune/proc/turf_check(turf/T)
	if(!T)
		return FALSE
	if(isspaceturf(T))
		to_chat(owner, span_warning("你无法在太空中刻写符文！"))
		return FALSE
	if(locate(/obj/effect/rune) in T)
		to_chat(owner, span_cult("这里已经有一枚符文了。"))
		return FALSE
	if(!is_station_level(T.z) && !is_mining_level(T.z))
		to_chat(owner, span_warning("此处的帷幕还不够薄弱。"))
		return FALSE
	return TRUE


/datum/action/innate/cult/create_rune/Activate()
	var/turf/T = get_turf(owner)
	if(!turf_check(T))
		return
	var/chosen_keyword
	if(initial(rune_type.req_keyword))
		chosen_keyword = tgui_input_text(owner, "为新符文输入一个关键词。", "力量之语", max_length = MAX_NAME_LEN)
		if(!chosen_keyword || !turf_check(T))
			return
//the outer ring is always the same across all runes
	var/obj/effect/temp_visual/cult/rune_spawn/R1 = new(T, scribe_time, rune_color)
//the rest are not always the same, so we need types for em
	var/obj/effect/temp_visual/cult/rune_spawn/R2
	if(ispath(rune_word_type, /obj/effect/temp_visual/cult/rune_spawn))
		R2 = new rune_word_type(T, scribe_time, rune_color)
	var/obj/effect/temp_visual/cult/rune_spawn/R3
	if(ispath(rune_innerring_type, /obj/effect/temp_visual/cult/rune_spawn))
		R3 = new rune_innerring_type(T, scribe_time, rune_color)
	var/obj/effect/temp_visual/cult/rune_spawn/R4
	if(ispath(rune_center_type, /obj/effect/temp_visual/cult/rune_spawn))
		R4 = new rune_center_type(T, scribe_time, rune_color)

	cooldown = base_cooldown + world.time
	owner.update_mob_action_buttons()
	addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob, update_mob_action_buttons)), base_cooldown + 1)
	var/list/mob_health = null
	if(damage_interrupt && isliving(owner))
		var/mob/living/as_living = owner
		mob_health = list(as_living.health)
	var/scribe_mod = scribe_time
	if(istype(T, /turf/open/floor/engine/cult))
		scribe_mod *= 0.5
	playsound(T, 'sound/effects/magic/enter_blood.ogg', 100, FALSE)

	if(do_after(owner, scribe_mod, owner, action_interrupt ? DO_AFTER_CHECK_NEXT_MOVE : NONE, extra_checks = !isnull(mob_health) ? CALLBACK(src, PROC_REF(check_health), owner, mob_health) : null))
		new rune_type(owner.loc, chosen_keyword)
		return

	qdel(R1)
	if(R2)
		qdel(R2)
	if(R3)
		qdel(R3)
	if(R4)
		qdel(R4)
	cooldown = 0
	owner.update_mob_action_buttons()

/datum/action/innate/cult/create_rune/proc/check_health(mob/living/user, old_health)
	if(user.health < old_health[1])
		return FALSE

	old_health[1] = user.health
	return TRUE

//teleport rune
/datum/action/innate/cult/create_rune/tele
	name = "召唤传送符文"
	desc = "在你的位置召唤一枚传送符文，仿佛它一直就在那里……"
	button_icon_state = "telerune"
	rune_type = /obj/effect/rune/teleport
	rune_word_type = /obj/effect/temp_visual/cult/rune_spawn/rune2
	rune_innerring_type = /obj/effect/temp_visual/cult/rune_spawn/rune2/inner
	rune_center_type = /obj/effect/temp_visual/cult/rune_spawn/rune2/center
	rune_color = RUNE_COLOR_TELEPORT

/datum/action/innate/cult/create_rune/wall
	name = "召唤屏障符文"
	desc = "在你的位置召唤一枚激活的屏障符文，仿佛它一直就在那里……"
	button_icon_state = "barrier"
	rune_type = /obj/effect/rune/wall
	rune_word_type = /obj/effect/temp_visual/cult/rune_spawn/rune4
	rune_innerring_type = /obj/effect/temp_visual/cult/rune_spawn/rune4/inner
	rune_center_type = /obj/effect/temp_visual/cult/rune_spawn/rune4/center
	rune_color = RUNE_COLOR_DARKRED

/datum/action/innate/cult/create_rune/revive
	name = "召唤复活符文"
	desc = "在你的位置召唤一枚复活符文，仿佛它一直就在那里……"
	button_icon_state = "revive"
	rune_type = /obj/effect/rune/raise_dead
	rune_word_type = /obj/effect/temp_visual/cult/rune_spawn/rune1
	rune_innerring_type = /obj/effect/temp_visual/cult/rune_spawn/rune1/inner
	rune_center_type = /obj/effect/temp_visual/cult/rune_spawn/rune1/center
	rune_color = RUNE_COLOR_MEDIUMRED
