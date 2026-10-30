#define TRANSFORMATION_DURATION 22
/// Will be removed once the transformation is complete.
#define TEMPORARY_TRANSFORMATION_TRAIT "temporary_transformation"
/// Considered "permanent" since we'll be deleting the old mob and the client will be inserted into a new one (without this trait)
#define PERMANENT_TRANSFORMATION_TRAIT "permanent_transformation"

/mob/living/carbon/proc/monkeyize(instant = FALSE)
	if (transformation_timer || HAS_TRAIT(src, TRAIT_NO_TRANSFORM))
		return

	if(ismonkey(src))
		return

	if(instant)
		finish_monkeyize()
		return

	//Make mob invisible and spawn animation
	ADD_TRAIT(src, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)
	Stun(TRANSFORMATION_DURATION, ignore_canstun = TRUE)
	icon = null
	cut_overlays()

	var/obj/effect = new /obj/effect/temp_visual/monkeyify(loc)
	effect.SetInvisibility(invisibility)
	SetInvisibility(INVISIBILITY_MAXIMUM, id=type)

	transformation_timer = addtimer(CALLBACK(src, PROC_REF(finish_monkeyize)), TRANSFORMATION_DURATION, TIMER_UNIQUE)

/mob/living/carbon/proc/finish_monkeyize()
	transformation_timer = null
	REMOVE_TRAIT(src, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)
	icon = initial(icon)
	RemoveInvisibility(type)
	set_species(/datum/species/monkey)
	to_chat(src, span_boldnotice("你现在是[chinese_footprint_species_display(dna.species.name)]了。"))
	name = LOWER_TEXT(dna.species.name)
	regenerate_icons()
	set_name()
	SEND_SIGNAL(src, COMSIG_HUMAN_MONKEYIZE)
	uncuff()
	return src

//////////////////////////           Humanize               //////////////////////////////
//Could probably be merged with monkeyize but other transformations got their own procs, too

/mob/living/carbon/proc/humanize(species = /datum/species/human, instant = FALSE)
	if (transformation_timer || HAS_TRAIT(src, TRAIT_NO_TRANSFORM))
		return

	if(!ismonkey(src))
		return

	if(instant)
		finish_humanize(species)
		return

	//Make mob invisible and spawn animation
	ADD_TRAIT(src, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)
	Stun(TRANSFORMATION_DURATION, ignore_canstun = TRUE)
	icon = null
	cut_overlays()

	var/obj/effect = new /obj/effect/temp_visual/monkeyify/humanify(loc)
	effect.SetInvisibility(invisibility)
	SetInvisibility(INVISIBILITY_MAXIMUM, id=type)

	transformation_timer = addtimer(CALLBACK(src, PROC_REF(finish_humanize), species), TRANSFORMATION_DURATION, TIMER_UNIQUE)


/mob/living/carbon/proc/finish_humanize(species = /datum/species/human)
	transformation_timer = null
	REMOVE_TRAIT(src, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)
	icon = initial(icon)
	RemoveInvisibility(type)
	set_species(species)
	to_chat(src, span_boldnotice("你现在是[chinese_footprint_species_display(dna.species.name)]了。"))
	SEND_SIGNAL(src, COMSIG_MONKEY_HUMANIZE)
	return src

/mob/living/carbon/human/finish_humanize(species = /datum/species/human)
	underwear = "Nude"
	undershirt = "Nude"
	socks = "Nude"
	return ..()

/mob/proc/AIize(client/preference_source, move = TRUE)
	var/list/turf/landmark_loc = list()

	if(!move)
		landmark_loc += loc
	else
		for(var/obj/effect/landmark/start/ai/sloc in GLOB.landmarks_list)
			if(locate(/mob/living/silicon/ai) in sloc.loc)
				continue
			if(sloc.primary_ai)
				LAZYCLEARLIST(landmark_loc)
				landmark_loc += sloc.loc
				break
			landmark_loc += sloc.loc
		if(!length(landmark_loc))
			to_chat(src, "抱歉，找不到空闲的 AI 出生点，只好让你与其他人重叠生成。")
			for(var/obj/effect/landmark/start/ai/sloc in GLOB.landmarks_list)
				landmark_loc += sloc.loc

	if(!length(landmark_loc))
		message_admins("找不到 [src] 的 AI 地标。请联系地图作者！将让其在当前位置生成。")
		landmark_loc += loc

	if(client)
		stop_sound_channel(CHANNEL_LOBBYMUSIC)

	var/mob/living/silicon/ai/our_AI = new(pick(landmark_loc), src)
	. = our_AI

	if(preference_source)
		apply_pref_name(/datum/preference/name/ai, preference_source)
		our_AI.apply_pref_hologram_display(preference_source)
		our_AI.set_core_display_icon(null, preference_source)

	qdel(src)

/mob/living/carbon/AIize(client/preference_source, transfer_after = TRUE)
	if(HAS_TRAIT(src, TRAIT_NO_TRANSFORM))
		return
	ADD_TRAIT(src, TRAIT_NO_TRANSFORM, PERMANENT_TRANSFORMATION_TRAIT)
	Paralyze(1, ignore_canstun = TRUE)
	for(var/obj/item/W in src)
		dropItemToGround(W)
	regenerate_icons()
	icon = null
	SetInvisibility(INVISIBILITY_MAXIMUM)
	return ..()

/mob/proc/Robotize(delete_items = FALSE)
	var/mob/living/silicon/robot/new_borg = transform_into_mob(/mob/living/silicon/robot, delete_items)

	if(!new_borg)
		return

	if(new_borg.client)
		new_borg.set_gender(new_borg.client)
		if(new_borg.client.prefs.read_preference(/datum/preference/name/cyborg) != DEFAULT_CYBORG_NAME)
			new_borg.apply_pref_name(/datum/preference/name/cyborg, new_borg.client)

	if(new_borg.mmi)
		new_borg.mmi.set_name(real_name)

	new_borg.job = JOB_CYBORG
	new_borg.notify_ai(AI_NOTIFICATION_NEW_BORG)

	if(new_borg.ckey && is_banned_from(new_borg.ckey, JOB_CYBORG))
		INVOKE_ASYNC(new_borg, TYPE_PROC_REF(/mob/living/silicon/robot, replace_banned_cyborg))
	return new_borg

/mob/living/silicon/robot/proc/replace_banned_cyborg()
	to_chat(src, "<b>你已被禁止担任半机械人！如果想避免今后再发生这种情况，请申诉解除职业封禁！</b>")
	ghostize(FALSE)

	var/mob/chosen_one = SSpolling.poll_ghosts_for_target("你想扮演 [span_notice(name)] 吗？", check_jobban = JOB_CYBORG, poll_time = 5 SECONDS, checked_target = src, alert_pic = src, role_name_text = "半机械人")
	if(chosen_one)
		message_admins("[key_name_admin(chosen_one)] 已接管（[key_name_admin(src)]），以替补一名被封禁的玩家。")
		key = chosen_one.key

/mob/proc/become_overmind(starting_points = OVERMIND_STARTING_POINTS)
	var/mob/eye/blob/B = new /mob/eye/blob(get_turf(src), starting_points)
	B.PossessByPlayer(key)
	. = B
	qdel(src)

//human -> alien
/mob/proc/Alienize()
	var/mob/living/carbon/alien/adult/new_xeno = transform_into_mob(pick(/mob/living/carbon/alien/adult/hunter, /mob/living/carbon/alien/adult/sentinel, /mob/living/carbon/alien/adult/drone))
	if(!new_xeno)
		return

	to_chat(new_xeno, span_boldnotice("你现在是异形了。嘶嘶——。"))

/mob/proc/slimeize(reproduce)
	var/mob/living/basic/slime/new_slime = transform_into_mob(/mob/living/basic/slime)
	if(!new_slime)
		return
	if(reproduce)
		var/number = pick(1400;2, 3, 4) //reproduce (has a small chance of producing 3 or 4 offspring)
		for(var/i in 2 to number)
			var/mob/living/basic/slime/brainless_child = new /mob/living/basic/slime(new_slime.loc)
			brainless_child.set_nutrition(round(nutrition/number))
			step_away(brainless_child, new_slime)

	new_slime.set_combat_mode(TRUE)
	to_chat(new_slime, span_boldnotice("你现在是史莱姆了。咕噜咕噜。"))

/mob/proc/corgize()
	var/mob/living/basic/pet/dog/corgi/new_corgi = transform_into_mob(/mob/living/basic/pet/dog/corgi)
	if(!new_corgi)
		return
	new_corgi.set_combat_mode(TRUE)
	to_chat(new_corgi, span_boldnotice("你现在是柯基了。汪汪！"))

/**
 * Turns the source atom into a crab crab, the peak of evolutionary design.
 */
/mob/proc/crabize()
	var/mob/living/basic/crab/new_crab = transform_into_mob(/mob/living/basic/crab)
	if(!new_crab)
		return
	to_chat(new_crab, span_boldnotice("你进化成了螃蟹！"))
	new_crab.set_combat_mode(TRUE)

/mob/proc/gorillize(genetics_gorilla = FALSE)
	var/mob/living/basic/gorilla/ideal_body = transform_into_mob(genetics_gorilla ? /mob/living/basic/gorilla/genetics : /mob/living/basic/gorilla)
	if(!ideal_body)
		return
	SSblackbox.record_feedback("amount", "gorillas_created", 1)
	to_chat(ideal_body, span_boldnotice("你现在是大猩猩了。喔嘎喔嘎！"))
	ideal_body.set_combat_mode(TRUE)
	return ideal_body

/mob/proc/Animalize()
	var/list/mobtypes = valid_typesof(/mob/living/simple_animal) + valid_typesof(/mob/living/basic)
	var/mobpath = tgui_input_list(usr, "要把 [src] 变成哪种生物？", "选择类型", sort_list(mobtypes, GLOBAL_PROC_REF(cmp_typepaths_asc)))
	if(isnull(mobpath))
		return

	var/mob/living/new_mob = transform_into_mob(mobpath)
	if(!new_mob)
		return
	new_mob.set_combat_mode(TRUE)
	to_chat(new_mob, span_boldnotice("你感觉自己更……像动物了。"))

///Creates a new mob, deletes the old one, transfers old mob into new mob
/mob/proc/transform_into_mob(mob_path, delete_items = FALSE)
	if(HAS_TRAIT(src, TRAIT_NO_TRANSFORM))
		return

	if(!delete_items)
		for(var/obj/item/detritus in get_equipped_items(INCLUDE_POCKETS|INCLUDE_HELD))
			dropItemToGround(detritus, TRUE)

	var/mob/new_mob = new mob_path(get_turf(src))
	if(mind)
		mind.transfer_to(new_mob)
	else
		new_mob.PossessByPlayer(key)

	qdel(src)
	return new_mob

#undef PERMANENT_TRANSFORMATION_TRAIT
#undef TEMPORARY_TRANSFORMATION_TRAIT
#undef TRANSFORMATION_DURATION
