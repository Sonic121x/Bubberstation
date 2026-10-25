/datum/antagonist/abductor
	name = "\improper 绑架者"
	roundend_category = "abductors"
	antagpanel_category = ANTAG_GROUP_ABDUCTORS
	pref_flag = ROLE_ABDUCTOR
	antag_hud_name = "abductor"
	show_in_antagpanel = FALSE //should only show subtypes
	show_to_ghosts = TRUE
	suicide_cry = "为了母舰！！" // They can't even talk but y'know
	stinger_sound = 'sound/music/antag/ayylien.ogg'
	var/datum/team/abductor_team/team
	var/sub_role
	var/outfit
	var/landmark_type
	var/greet_text
	/// Type path for the associated job datum.
	var/role_job = /datum/job/abductor_agent

/datum/antagonist/abductor/get_preview_icon()
	var/mob/living/carbon/human/dummy/consistent/scientist = new
	var/mob/living/carbon/human/dummy/consistent/agent = new

	scientist.set_species(/datum/species/abductor)
	agent.set_species(/datum/species/abductor)
	// BUBBER EDIT START: fix their colors, oops
	scientist.dna.features[FEATURE_MUTANT_COLOR] = "#E3E3E3"
	agent.dna.features[FEATURE_MUTANT_COLOR] = "#E3E3E3"
	// BUBBER EDIT END

	var/datum/universal_icon/scientist_icon = render_preview_outfit(/datum/outfit/abductor/scientist, scientist)
	scientist_icon.shift(WEST, 8)

	var/datum/universal_icon/agent_icon = render_preview_outfit(/datum/outfit/abductor/agent, agent)
	agent_icon.shift(EAST, 8)

	var/datum/universal_icon/final_icon = scientist_icon
	final_icon.blend_icon(agent_icon, ICON_OVERLAY)

	qdel(scientist)
	qdel(agent)

	return finish_preview_icon(final_icon)

/datum/antagonist/abductor/agent
	name = "\improper 绑架者特工"
	sub_role = "Agent"
	outfit = /datum/outfit/abductor/agent
	landmark_type = /obj/effect/landmark/abductor/agent
	greet_text = "利用你的隐形技术和装备让人类失去行动能力，好让你的科学家同伴进行回收。"
	show_in_antagpanel = TRUE

/datum/antagonist/abductor/scientist
	name = "\improper 绑架者科学家"
	sub_role = "Scientist"
	outfit = /datum/outfit/abductor/scientist
	landmark_type = /obj/effect/landmark/abductor/scientist
	greet_text = "利用你的实验控制台和手术设备监视你的特工，并对被绑架的人类进行实验。"
	show_in_antagpanel = TRUE
	role_job = /datum/job/abductor_scientist

/datum/antagonist/abductor/scientist/onemanteam
	name = "\improper 单人绑架者"
	outfit = /datum/outfit/abductor/scientist/onemanteam
	role_job = /datum/job/abductor_solo

/datum/antagonist/abductor/create_team(datum/team/abductor_team/new_team)
	if(!new_team)
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	team = new_team

/datum/antagonist/abductor/get_team()
	return team

/datum/antagonist/abductor/on_gain()
	owner.set_assigned_role(SSjob.get_job_type(role_job))
	objectives += team.objectives
	finalize_abductor()
	// We don't want abductors to be converted by other antagonists
	owner.add_traits(list(TRAIT_ABDUCTOR_TRAINING, TRAIT_ABDUCTOR_HUD, TRAIT_UNCONVERTABLE), ABDUCTOR_ANTAGONIST)
	return ..()

/datum/antagonist/abductor/on_removal()
	owner.remove_traits(list(TRAIT_ABDUCTOR_TRAINING, TRAIT_ABDUCTOR_HUD, TRAIT_UNCONVERTABLE), ABDUCTOR_ANTAGONIST)
	return ..()

/datum/antagonist/abductor/greet()
	. = ..()
	to_chat(owner.current, span_notice("在你的队友协助下，绑架空间站船员并对他们进行实验！"))
	to_chat(owner.current, span_notice("[greet_text]"))
	owner.announce_objectives()

/datum/antagonist/abductor/proc/finalize_abductor()
	//Equip
	var/mob/living/carbon/human/new_abductor = owner.current
	new_abductor.set_species(/datum/species/abductor)
	// BUBBER EDIT START - Apply body part updates after setting mutant colors.
	var/list/body_colors = new_abductor.client?.prefs.read_preference(/datum/preference/tri_color/mutant_colors)
	if(length(body_colors))
		new_abductor.dna.features[FEATURE_MUTANT_COLOR] = body_colors[1]
		for(var/obj/item/bodypart/part as anything in new_abductor.get_bodyparts())
			part.add_color_override(body_colors[1], LIMB_COLOR_AYYLMAO + 1)
	new_abductor.update_body_parts(update_limb_data = TRUE)
	// BUBBER EDIT END
	var/obj/item/organ/tongue/abductor/abductor_tongue = new_abductor.get_organ_slot(ORGAN_SLOT_TONGUE)
	abductor_tongue.mothership = "[team.name]"

	new_abductor.real_name = "[team.name] [sub_role]"
	new_abductor.equipOutfit(outfit)

	// If we have a team skincolor, apply it here. Applied by admins or 2% chance of natural occurance
	if(!isnull(team.team_skincolor) && new_abductor.dna.features[FEATURE_MUTANT_COLOR] == COLOR_WHITE) //Bubber edit: Apply team skin color if the abductor has the default white color
		for(var/obj/item/bodypart/part as anything in new_abductor.get_bodyparts())
			part.should_draw_greyscale = TRUE
			part.add_color_override(team.team_skincolor, LIMB_COLOR_AYYLMAO)

		new_abductor.update_body_parts(update_limb_data = TRUE)

	// We require that the template be loaded here, so call it in a blocking manner, if its already done loading, this won't block
	SSmapping.lazy_load_template(LAZY_TEMPLATE_KEY_ABDUCTOR_SHIPS)
	//Teleport to ship
	for(var/obj/effect/landmark/abductor/LM in GLOB.landmarks_list)
		if(istype(LM, landmark_type) && LM.team_number == team.team_number)
			new_abductor.forceMove(LM.loc)
			break

/datum/antagonist/abductor/scientist/on_gain()
	owner.add_traits(list(TRAIT_ABDUCTOR_SCIENTIST_TRAINING), ABDUCTOR_ANTAGONIST)
	return ..()

/datum/antagonist/abductor/scientist/on_removal()
	owner.remove_traits(list(TRAIT_ABDUCTOR_SCIENTIST_TRAINING), ABDUCTOR_ANTAGONIST)
	return ..()

/datum/antagonist/abductor/scientist/apply_innate_effects(mob/living/mob_override)
	var/mob/living/glorp = mob_override || owner.current
	RegisterSignal(glorp, COMSIG_LIVING_OPERATING_ON, PROC_REF(add_surgery))

/datum/antagonist/abductor/scientist/remove_innate_effects(mob/living/mob_override)
	var/mob/living/glorp = mob_override || owner.current
	UnregisterSignal(glorp, COMSIG_LIVING_OPERATING_ON)

/datum/antagonist/abductor/scientist/proc/add_surgery(datum/source, atom/movable/operating_on, list/possible_operations)
	SIGNAL_HANDLER

	var/static/list/ayy_operations
	if(!length(ayy_operations))
		ayy_operations = list()
		ayy_operations += /datum/surgery_operation/basic/tend_wounds/combo/upgraded/master
		ayy_operations += /datum/surgery_operation/basic/viral_bonding
		ayy_operations += /datum/surgery_operation/limb/add_plastic // unlocks advanced plastic surgery
		ayy_operations += /datum/surgery_operation/limb/bionecrosis
		ayy_operations += /datum/surgery_operation/limb/clamp_bleeders/abductor
		ayy_operations += /datum/surgery_operation/limb/close_skin/abductor
		ayy_operations += /datum/surgery_operation/limb/incise_organs/abductor
		ayy_operations += /datum/surgery_operation/limb/incise_skin/abductor
		ayy_operations += /datum/surgery_operation/limb/organ_manipulation/external/abductor
		ayy_operations += /datum/surgery_operation/limb/organ_manipulation/internal/abductor
		ayy_operations += /datum/surgery_operation/limb/retract_skin/abductor
		ayy_operations += /datum/surgery_operation/limb/unclamp_bleeders/abductor
		ayy_operations += /datum/surgery_operation/organ/fix_wings // i guess
		ayy_operations += typesof(/datum/surgery_operation/limb/bioware)
		ayy_operations += typesof(/datum/surgery_operation/organ/brainwash)
		ayy_operations += typesof(/datum/surgery_operation/organ/lobotomy)
		ayy_operations += typesof(/datum/surgery_operation/organ/pacify)

	possible_operations |= ayy_operations

/datum/antagonist/abductor/admin_add(datum/mind/new_owner,mob/admin)
	var/list/current_teams = list()
	for(var/datum/team/abductor_team/T in GLOB.antagonist_teams)
		current_teams[T.name] = T
	var/choice = tgui_input_list(admin,"添加到哪个队伍？", "绑架者队伍", current_teams + "new team")
	if (choice == "new team")
		team = new
		if(tgui_alert(admin, "使用自定义肤色？", "外星喷漆器", list("Yes", "No")) == "Yes")
			// Keep in mind the darker colors don't look all that great, but it's easier to just reference an existing color list than make a new one
			var/colorchoice = tgui_input_list(admin, "选择哪种颜色？", "外星喷漆器", GLOB.color_list_ethereal + "Custom Color")
			if(colorchoice == "Custom Color")
				colorchoice = tgui_color_picker(admin, "选择新颜色", "外星喷漆器", COLOR_WHITE)
			else
				colorchoice = GLOB.color_list_ethereal[colorchoice]
			team.team_skincolor = colorchoice
	else if(choice in current_teams)
		team = current_teams[choice]
	else
		return
	new_owner.add_antag_datum(src)
	log_admin("[key_name(usr)] 将 [key_name(new_owner)] 设为 [name]（[choice]）！")
	message_admins("[key_name_admin(usr)] 将 [key_name_admin(new_owner)] 设为 [name]（[choice]）！")

/datum/antagonist/abductor/get_admin_commands()
	. = ..()
	.["Equip"] = CALLBACK(src, PROC_REF(admin_equip))

/datum/antagonist/abductor/proc/admin_equip(mob/admin)
	if(!ishuman(owner.current))
		to_chat(admin, span_warning("这只能对类人生效！"))
		return
	var/mob/living/carbon/human/new_abductor = owner.current
	var/gear = tgui_alert(admin,"特工或科学家装备", "装备", list("Agent", "Scientist"))
	if(gear)
		if(gear == "Agent")
			new_abductor.equipOutfit(/datum/outfit/abductor/agent)
		else
			new_abductor.equipOutfit(/datum/outfit/abductor/scientist)

/datum/team/abductor_team
	member_name = "\improper 绑架者"
	var/team_number
	var/static/team_count = 1
	///List of all brainwashed victims' minds
	var/list/datum/mind/abductees = list()
	/// If we will recolor these aliens, this value gets changed. Has a really small chance to occur naturally, but admins can change this to anything they want.
	var/team_skincolor = null

/datum/team/abductor_team/New()
	..()
	team_number = team_count++
	name = "母舰 [pick(GLOB.greek_letters)]" //TODO Ensure unique and actual alieny names
	add_objective(new /datum/objective/experiment)
	// Some aliens can be green as a treat
	if(prob(check_holidays(APRIL_FOOLS) ? 50 : 2) && isnull(team_skincolor))
		team_skincolor = COLOR_EMERALD

/datum/team/abductor_team/roundend_report()
	var/list/result = list()

	var/won = TRUE
	for(var/datum/objective/O in objectives)
		if(!O.check_completion())
			won = FALSE
	if(won)
		result += "<span class='greentext big'>[name] 小队完成了任务！</span>"
	else
		result += "<span class='redtext big'>[name] 小队任务失败。</span>"

	result += span_header("来自 [name] 的绑架者有：")
	for(var/datum/mind/abductor_mind in members)
		result += printplayer(abductor_mind)
	result += printobjectives(objectives)

	return "<div class='panel redborder'>[result.Join("<br>")]</div>"

// LANDMARKS
/obj/effect/landmark/abductor
	var/team_number = 1

/obj/effect/landmark/abductor/agent
	icon_state = "abductor_agent"
/obj/effect/landmark/abductor/scientist
	icon_state = "abductor"

// OBJECTIVES
/datum/objective/experiment
	target_amount = 6

/datum/objective/experiment/New()
	explanation_text = "对 [target_amount] 名人类进行实验。"

/datum/objective/experiment/check_completion()
	for(var/obj/machinery/abductor/experiment/E as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/abductor/experiment))
		if(!istype(team, /datum/team/abductor_team))
			return FALSE
		var/datum/team/abductor_team/T = team
		if(E.team_number == T.team_number)
			return E.points >= target_amount
	return FALSE
