/datum/antagonist/ninja
	name = "\improper 太空忍者"
	antagpanel_category = ANTAG_GROUP_NINJAS
	pref_flag = ROLE_NINJA
	antag_hud_name = "ninja"
	hijack_speed = 1
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	antag_moodlet = /datum/mood_event/focused
	suicide_cry = "为了蜘蛛氏族！！"
	preview_outfit = /datum/outfit/ninja_preview
	can_assign_self_objectives = TRUE
	ui_name = "AntagInfoNinja"
	default_custom_objective = "摧毁空间站的重要基础设施，且不被发现。"
	desensitized_modifier = DESENSITIZED_THRESHOLD
	///Whether or not this ninja will obtain objectives
	var/give_objectives = TRUE

/**
 * Proc that equips the space ninja outfit on a given individual.  By default this is the owner of the antagonist datum.
 *
 * Proc that equips the space ninja outfit on a given individual.  By default this is the owner of the antagonist datum.
 * Arguments:
 * * ninja - The human to receive the gear
 * * Returns a proc call on the given human which will equip them with all the gear.
 */
/datum/antagonist/ninja/proc/equip_space_ninja(mob/living/carbon/human/ninja = owner.current)
	return ninja.equip_species_outfit(/datum/outfit/ninja)

/**
 * Proc that adds the proper memories to the antag datum
 *
 * Proc that adds the ninja starting memories to the owner of the antagonist datum.
 */
/datum/antagonist/ninja/proc/addMemories()
	antag_memory += "我是强大蜘蛛氏族的精英雇佣兵。一名<font color='red'><B>太空忍者</B></font>！<br>"
	antag_memory += "突袭是我的武器，阴影是我的护甲。没有它们，我什么都不是。<br>"

/datum/objective/cyborg_hijack
	explanation_text = "使用你的手套转化至少一个半机械人，协助你破坏空间站。"

/datum/objective/door_jack
	///How many doors that need to be opened using the gloves to pass the objective
	var/doors_required = 0

/datum/objective/plant_explosive
	var/area/detonation_location

/datum/objective/security_scramble
	explanation_text = "在安保控制台上使用你的手套，将所有人设为逮捕状态至少一次。注意，你一旦开始，AI 就会收到警报！"

/datum/objective/terror_message
	explanation_text = "在通讯控制台上使用你的手套，为空间站带来另一种威胁。注意，你一旦开始，AI 就会收到警报！"

/datum/objective/research_secrets
	explanation_text = "在研究与发展服务器上使用你的手套，破坏科研工作。注意，你一旦开始，AI 就会收到警报！"

/**
 * Proc that adds all the ninja's objectives to the antag datum.
 *
 * Proc that adds all the ninja's objectives to the antag datum.  Called when the datum is gained.
 */
/datum/antagonist/ninja/proc/addObjectives()
	//Cyborg Hijack: Flag set to complete in the DrainAct in ninjaDrainAct.dm
	var/datum/objective/hijack = new /datum/objective/cyborg_hijack()
	objectives += hijack

	// Break into science and mess up their research. Only add this objective if the similar steal objective is possible.
	var/datum/objective/research_secrets/sabotage_research = new /datum/objective/research_secrets()
	objectives += sabotage_research

	//Door jacks, flag will be set to complete on when the last door is hijacked
	var/datum/objective/door_jack/doorobjective = new /datum/objective/door_jack()
	doorobjective.doors_required = rand(15,40)
	doorobjective.explanation_text = "使用你的手套入侵空间站上的 [doorobjective.doors_required] 个气闸。"
	objectives += doorobjective

	//SKYRAT EDIT START
	if(length(get_crewmember_minds()) >= BOMB_POP_REQUIREMENT)
		//Explosive plant, the bomb will register its completion on priming
		var/datum/objective/plant_explosive/bombobjective = new /datum/objective/plant_explosive()
		for(var/sanity in 1 to 100) // 100 checks at most.
			var/area/selected_area = pick(GLOB.areas)
			if(!is_station_level(selected_area.z) || !(selected_area.area_flags & VALID_TERRITORY))
				continue
			bombobjective.detonation_location = selected_area
			break
		if(bombobjective.detonation_location)
			bombobjective.explanation_text = "在[bombobjective.detonation_location]引爆你的初始炸弹。注意，该炸弹在其他任何地方都不会生效！"
			objectives += bombobjective
	//SKYRAT EDIT END

	//Security Scramble, set to complete upon using your gloves on a security console
	var/datum/objective/securityobjective = new /datum/objective/security_scramble()
	objectives += securityobjective

	//Message of Terror, set to complete upon using your gloves a communication console
	var/datum/objective/communicationobjective = new /datum/objective/terror_message()
	objectives += communicationobjective

	//Survival until end
	var/datum/objective/survival = new /datum/objective/survive()
	survival.owner = owner
	objectives += survival

/datum/antagonist/ninja/greet()
	. = ..()
	SEND_SOUND(owner.current, sound('sound/music/antag/ninja_greeting.ogg'))
	to_chat(owner.current, span_danger("我是强大蜘蛛氏族的精英雇佣兵！"))
	to_chat(owner.current, span_warning("突袭是我的武器，阴影是我的护甲。没有它们，我什么都不是。"))
	to_chat(owner.current, span_notice("空间站位于你的[dir2text(get_dir(owner.current, locate(world.maxx/2, world.maxy/2, owner.current.z)))]方向。扔出一枚忍者镖是前往那里的好办法。"))
	owner.announce_objectives()

/datum/antagonist/ninja/on_gain() // BUBBER EDIT BEGIN- WHOLE PROC EDITS
	var/mob/living/carbon/human/operative = owner.current
	if(give_objectives)
		addObjectives()
	addMemories()
	operative.client?.prefs?.safe_transfer_prefs_to(operative)
	operative.dna.update_dna_identity()
	operative.dna.species.pre_equip_species_outfit(null, operative)
	operative.regenerate_icons()

	equip_space_ninja(owner.current)
	owner.current.add_quirk(/datum/quirk/freerunning, announce = FALSE)
	owner.current.add_quirk(/datum/quirk/light_step, announce = FALSE)
	owner.current.mind.set_assigned_role(SSjob.get_job_type(/datum/job/space_ninja))
	operative.mind.active = TRUE // BUBBER EDIT END
	return ..()

/datum/antagonist/ninja/admin_add(datum/mind/new_owner,mob/admin)
	new_owner.set_assigned_role(SSjob.get_job_type(/datum/job/space_ninja))
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] 将 [key_name_admin(new_owner)] 设为了忍者。")
	log_admin("[key_name(admin)] 将 [key_name(new_owner)] 设为了忍者。")

/datum/antagonist/ninja/on_respawn(mob/new_character)
	equip_space_ninja()
	var/turf/spawnpoint = find_space_spawn()
	if(spawnpoint)
		new_character.forceMove(spawnpoint)
	return TRUE
