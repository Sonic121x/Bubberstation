/datum/antagonist/space_dragon
	name = "\improper 太空龙"
	roundend_category = "space dragons"
	antagpanel_category = ANTAG_GROUP_LEVIATHANS
	pref_flag = ROLE_SPACE_DRAGON
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	/// All space carps created by this antagonist space dragon
	var/list/datum/mind/carp = list()
	/// The innate ability to summon rifts
	var/datum/action/innate/summon_rift/rift_ability
	/// The innate ability to find where rift locations are
	var/datum/action/innate/locate_rift/locate_rift_ability
	/// Current time since the the last rift was activated.  If set to -1, does not increment.
	var/riftTimer = 0
	/// Maximum amount of time which can pass without a rift before Space Dragon despawns.
	var/maxRiftTimer = 300
	/// A list of all of the rifts created by Space Dragon.  Used for setting them all to infinite carp spawn when Space Dragon wins, and removing them when Space Dragon dies.
	var/list/obj/structure/carp_rift/rift_list = list()
	/// How many rifts have been successfully charged
	var/rifts_charged = 0
	/// Whether or not Space Dragon has completed their objective, and thus triggered the ending sequence.
	var/objective_complete = FALSE
	/// What mob to spawn from ghosts using this dragon's rifts
	var/minion_to_spawn = /mob/living/basic/carp/advanced
	/// What AI mobs to spawn from this dragon's rifts
	var/ai_to_spawn = /mob/living/basic/carp
	/// Wavespeak mind linker, to allow telepathy between dragon and carps
	var/datum/component/mind_linker/wavespeak
	/// What areas are we allowed to place rifts in?
	var/list/chosen_rift_areas = list()

/datum/antagonist/space_dragon/greet()
	. = ..()
	to_chat(owner, "<b>我们穿越无尽的时间与空间而来。我们不记得自己从何而来，也不知将往何处去。整个太空都属于我们。\n\
					这是一片空旷的虚空，我们的族群曾是这里的顶级掠食者，几乎没有谁能挑战我们的这一地位。\n\
					但如今，我们发现入侵者散布在我们的领地上，以难以想象的魔法对抗我们的利齿，他们的巢穴如同深空中的点点灯火。\n\
					今天，我们将熄灭其中一盏。</b>")
	to_chat(owner, span_boldwarning("你有五分钟时间寻找一处安全地点放置第一道裂隙。若超过五分钟仍未放置裂隙，你将被送回你来的地方。"))
	owner.announce_objectives()
	owner.current.playsound_local(get_turf(owner.current), 'sound/effects/magic/demon_attack1.ogg', 80)

/datum/antagonist/space_dragon/forge_objectives()
	var/static/list/area/allowed_areas
	if(!allowed_areas)
		// Areas that will prove a challeng for the dragon and are provocative to the crew.
		allowed_areas = typecacheof(list(
			/area/station/command,
			/area/station/engineering,
			/area/station/science,
			/area/station/security,
		))

	var/list/possible_areas = typecache_filter_list(get_sorted_areas(), allowed_areas)
	for(var/area/possible_area as anything in possible_areas)
		if(initial(possible_area.outdoors) || !(possible_area.area_flags & VALID_TERRITORY))
			possible_areas -= possible_area

	for(var/i in 1 to 5)
		chosen_rift_areas += pick_n_take(possible_areas)

	var/datum/objective/summon_carp/summon = new
	objectives += summon
	summon.owner = owner
	summon.update_explanation_text()

/datum/antagonist/space_dragon/on_gain()
	forge_objectives()
	rift_ability = new()
	locate_rift_ability = new()
	owner.set_assigned_role(SSjob.get_job_type(/datum/job/space_dragon))
	return ..()

/datum/antagonist/space_dragon/on_removal()
	owner.set_assigned_role(SSjob.get_job_type(/datum/job/unassigned))
	return ..()

/datum/antagonist/space_dragon/apply_innate_effects(mob/living/mob_override)
	var/mob/living/antag = mob_override || owner.current
	RegisterSignal(antag, COMSIG_LIVING_LIFE, PROC_REF(rift_checks))
	RegisterSignal(antag, COMSIG_LIVING_DEATH, PROC_REF(destroy_rifts))
	antag.add_faction(FACTION_CARP)
	// Give the ability over if we have one
	rift_ability?.Grant(antag)
	locate_rift_ability?.Grant(antag)
	wavespeak = antag.AddComponent( \
		/datum/component/mind_linker, \
		network_name = "波语", \
		chat_color = "#635BAF", \
		signals_which_destroy_us = list(COMSIG_LIVING_DEATH), \
		speech_action_icon = 'icons/mob/actions/actions_space_dragon.dmi', \
		speech_action_icon_state = "wavespeak", \
	)
	RegisterSignal(wavespeak, COMSIG_QDELETING, PROC_REF(clear_wavespeak))

/datum/antagonist/space_dragon/remove_innate_effects(mob/living/mob_override)
	var/mob/living/antag = mob_override || owner.current
	UnregisterSignal(antag, COMSIG_LIVING_LIFE)
	UnregisterSignal(antag, COMSIG_LIVING_DEATH)
	antag.remove_faction(FACTION_CARP)
	rift_ability?.Remove(antag)
	locate_rift_ability?.Remove(antag)
	QDEL_NULL(wavespeak)

/datum/antagonist/space_dragon/Destroy()
	rift_list = null
	carp = null
	QDEL_NULL(rift_ability)
	QDEL_NULL(locate_rift_ability)
	QDEL_NULL(wavespeak)
	chosen_rift_areas.Cut()
	return ..()

/datum/antagonist/space_dragon/get_preview_icon()
	var/datum/universal_icon/icon = uni_icon('icons/mob/nonhuman-player/spacedragon.dmi', "spacedragon")

	icon.blend_color(COLOR_STRONG_VIOLET, ICON_MULTIPLY)
	icon.blend_icon(uni_icon('icons/mob/nonhuman-player/spacedragon.dmi', "spacedragon_overlay_base"), ICON_OVERLAY)

	icon.crop(10, 9, 54, 53)
	icon.scale(ANTAGONIST_PREVIEW_ICON_SIZE, ANTAGONIST_PREVIEW_ICON_SIZE)

	return icon

/datum/antagonist/space_dragon/proc/clear_wavespeak()
	SIGNAL_HANDLER
	wavespeak = null

/**
 * Checks to see if we need to do anything with the current state of the dragon's rifts.
 *
 * A simple update check which sees if we need to do anything based on the current state of the dragon's rifts.
 *
 */
/datum/antagonist/space_dragon/proc/rift_checks()
	if((rifts_charged == 3 || (SSshuttle.emergency.mode == SHUTTLE_DOCKED && rifts_charged > 0)) && !objective_complete)
		victory()
		return
	if(riftTimer == -1)
		return
	riftTimer = min(riftTimer + 1, maxRiftTimer + 1)
	if(riftTimer == (maxRiftTimer - 60))
		to_chat(owner.current, span_boldwarning("你还剩一分钟召唤裂隙！快去！"))
		return
	if(riftTimer >= maxRiftTimer)
		// BUBBER CHANGE START: dragons don't die to not summoning a rift
		to_chat(owner.current, span_boldwarning("你未能及时召唤裂隙！在完成召唤之前，你的移动速度会降低！"))
		owner.current.add_movespeed_modifier(/datum/movespeed_modifier/dragon_depression)
		riftTimer = -1
		// BUBBER CHANGE END

/**
 * Destroys all of Space Dragon's current rifts.
 *
 * QDeletes all the current rifts after removing their references to other objects.
 * Currently, the only reference they have is to the Dragon which created them, so we clear that before deleting them.
 * Currently used when Space Dragon dies or one of his rifts is destroyed.
 */
/datum/antagonist/space_dragon/proc/destroy_rifts()
	if(objective_complete)
		return
	rifts_charged = 0
	ADD_TRAIT(owner.current, TRAIT_RIFT_FAILURE, DRAGON_PORTAL_LOSS) // BUBBER CHANGE
	owner.current.add_movespeed_modifier(/datum/movespeed_modifier/dragon_depression)
	riftTimer = -1
	if(rifts_charged != 3 && !objective_complete) // BUBBER ADDITION
		if(owner.current.stat == DEAD)
			return
		to_chat(owner.current, span_warning("你可以在 5 分钟后再次制造裂隙。"))
		addtimer(CALLBACK(src, PROC_REF(give_rift_ability)), 5 MINUTES)
	SEND_SOUND(owner.current, sound('sound/vehicles/rocketlaunch.ogg'))
	for(var/obj/structure/carp_rift/rift as anything in rift_list)
		rift.dragon = null
		rift_list -= rift
		if(!QDELETED(rift))
			QDEL_NULL(rift)

/datum/antagonist/space_dragon/proc/give_rift_ability()
	if(owner.current.stat == DEAD)
		return
	rift_ability = new()
	rift_ability.Grant(owner.current)

/**
 * Sets up Space Dragon's victory for completing the objectives.
 *
 * Triggers when Space Dragon completes his objective.
 * Calls the shuttle with a coefficient of 3, making it impossible to recall.
 * Sets all of his rifts to allow for infinite sentient carp spawns
 * Also plays appropriate sounds and CENTCOM messages.
 */
/datum/antagonist/space_dragon/proc/victory()
	objective_complete = TRUE
	permanant_empower()
	var/datum/objective/summon_carp/main_objective = locate() in objectives
	main_objective?.completed = TRUE
	priority_announce("检测到大量生命体正以极高速接近[station_name()]。\
		建议剩余船员尽快撤离。", "[command_name()] 野生生物观测", has_important_message = TRUE)
	sound_to_playing_players('sound/mobs/non-humanoids/space_dragon/space_dragon_roar.ogg', volume = 75)
	for(var/obj/structure/carp_rift/rift as anything in rift_list)
		rift.carp_stored = 999999
		rift.time_charged = rift.max_charge

/**
 * Gives Space Dragon their the rift speed buff permanently and fully heals the user.
 *
 * Gives Space Dragon the enraged speed buff from charging rifts permanently.
 * Only happens in circumstances where Space Dragon completes their objective.
 * Also gives them a full heal.
 */
/datum/antagonist/space_dragon/proc/permanant_empower()
	owner.current.fully_heal()
	owner.current.add_filter("anger_glow", 3, list("type" = "outline", "color" = COLOR_CARP_RIFT_RED, "size" = 5))
	owner.current.add_movespeed_modifier(/datum/movespeed_modifier/dragon_rage)

/**
 * Handles Space Dragon's temporary empowerment after boosting a rift.
 *
 * Empowers and depowers Space Dragon after a successful rift charge.
 * Empowered, Space Dragon regains all his health and becomes temporarily faster for 30 seconds, along with being tinted red.
 */
/datum/antagonist/space_dragon/proc/rift_empower()
	owner.current.fully_heal()
	owner.current.add_filter("anger_glow", 3, list("type" = "outline", "color" = COLOR_CARP_RIFT_RED, "size" = 5))
	owner.current.add_movespeed_modifier(/datum/movespeed_modifier/dragon_rage)
	addtimer(CALLBACK(src, PROC_REF(rift_depower)), 30 SECONDS)

/**
 * Removes Space Dragon's rift speed buff.
 *
 * Removes Space Dragon's speed buff from charging a rift.  This is only called
 * in rift_empower, which uses a timer to call this after 30 seconds.  Also
 * removes the red glow from Space Dragon which is synonymous with the speed buff.
 */
/datum/antagonist/space_dragon/proc/rift_depower()
	owner.current.remove_filter("anger_glow")
	owner.current.remove_movespeed_modifier(/datum/movespeed_modifier/dragon_rage)

/datum/objective/summon_carp
	explanation_text = "召唤 3 道裂隙，让鲤鱼淹没空间站。"

/datum/objective/summon_carp/update_explanation_text()
	var/datum/antagonist/space_dragon/dragon_owner = owner.has_antag_datum(/datum/antagonist/space_dragon)
	if(isnull(dragon_owner))
		return

	var/list/converted_names = list()
	for(var/area/possible_area as anything in dragon_owner.chosen_rift_areas)
		converted_names += possible_area.get_original_area_name()

	explanation_text = initial(explanation_text)
	explanation_text += " 你可能的裂隙位置是：[english_list(converted_names)]"

/datum/antagonist/space_dragon/roundend_report()
	var/list/parts = list()
	var/datum/objective/summon_carp/S = locate() in objectives
	if(S.check_completion())
		parts += "<span class='redtext big'>[name]成功了！空间站周边的太空已被太空鲤鱼夺回！</span>"
	parts += printplayer(owner)
	var/objectives_complete = TRUE
	if(objectives.len)
		parts += printobjectives(objectives)
		for(var/datum/objective/objective in objectives)
			if(!objective.check_completion())
				objectives_complete = FALSE
				break
	if(objectives_complete)
		parts += "<span class='greentext big'>[name]成功了！</span>"
	else
		parts += "<span class='redtext big'>[name]失败了！</span>"

	if(length(carp))
		parts += span_header("<br>协助[name]的有：")
		parts += "<ul class='playerlist'>"
		var/list/players_to_carp_taken = list()
		for(var/datum/mind/carpy as anything in carp)
			players_to_carp_taken[carpy.key] += 1
		var/list = ""
		for(var/carp_user in players_to_carp_taken)
			list += "<li><b>[carp_user]</b>，扮演了 <b>[players_to_carp_taken[carp_user]]</b> 只太空鲤鱼。</li>"
		parts += list
		parts += "</ul>"

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"
