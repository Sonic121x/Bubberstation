/datum/action/changeling/absorb_dna
	name = "吸收 DNA"
	desc = "吸收受害者的 DNA。需要我们先掐住对方。"
	button_icon_state = "absorb_dna"
	chemical_cost = 0
	dna_cost = CHANGELING_POWER_INNATE
	req_human = TRUE
	///if we're currently absorbing, used for sanity
	var/is_absorbing = FALSE
	var/datum/looping_sound/changeling_absorb/absorbing_loop

/datum/action/changeling/absorb_dna/can_sting(mob/living/carbon/owner)
	if(!..())
		return

	if(is_absorbing)
		owner.balloon_alert(owner, "已在吸收中！")
		return

	if(!owner.pulling || !iscarbon(owner.pulling))
		owner.balloon_alert(owner, "需要抓住目标！")
		return
	if(owner.grab_state <= GRAB_NECK)
		owner.balloon_alert(owner, "需要更紧的抓握！")
		return

	var/mob/living/carbon/target = owner.pulling
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(owner)
	return changeling.can_absorb_dna(target)

/datum/action/changeling/absorb_dna/sting_action(mob/owner)
	SHOULD_CALL_PARENT(FALSE) // the only reason to call parent is for proper blackbox logging, and we do that ourselves in a snowflake way

	var/datum/antagonist/changeling/changeling = IS_CHANGELING(owner)
	var/mob/living/carbon/human/target = owner.pulling
	is_absorbing = TRUE

	if(!attempt_absorb(target))
		return

	SSblackbox.record_feedback("nested tally", "changeling_powers", 1, list("Absorb DNA", "4"))
	owner.visible_message(span_danger("[owner]吸干了[target]的体液！"), span_notice("我们吸收了[target]。"))

	if(target.client && target.mind)
		var/mob/eye/imaginary_friend/hivemind/new_member = new(target.loc)
		new_member.AddComponent(/datum/component/temporary_body, old_mind = target.mind, return_on_revive = TRUE)
		new_member.real_name = target.real_name
		new_member.gender = target.gender
		new_member.human_icon = get_flat_human_icon(null, target.mind.assigned_role, target.client.prefs)
		new_member.PossessByPlayer(target.ckey)
		new_member.attach_to_owner(owner)

	var/true_absorbtion = (!isnull(target.client) || !isnull(target.mind) || !isnull(target.last_mind))
	if (!true_absorbtion)
		to_chat(owner, span_changeling(span_bold("你吸收了[target]，但其孱弱的 DNA 不足以满足你的饥渴。")))

	if(!changeling.has_profile_with_dna(target.dna))
		changeling.add_new_profile(target)
		if (true_absorbtion)
			changeling.true_absorbs++

	if(owner.nutrition < NUTRITION_LEVEL_WELL_FED)
		owner.set_nutrition(min((owner.nutrition + target.nutrition), NUTRITION_LEVEL_WELL_FED))

	// Absorb a lizard, speak Draconic.
	owner.copy_languages(target, LANGUAGE_ABSORB)

	if(target.mind && owner.mind)//if the victim and owner have minds
		absorb_memories(target)

	qdel(absorbing_loop)
	is_absorbing = FALSE

	changeling.adjust_chemicals(10)
	if (true_absorbtion)
		changeling.can_respec++

	if(target.stat != DEAD)
		target.investigate_log("has died from being changeling absorbed.", INVESTIGATE_DEATHS)
	target.death(FALSE)
	target.Drain()
	return TRUE

/datum/action/changeling/absorb_dna/proc/absorb_memories(mob/living/carbon/human/target)
	var/datum/mind/suckedbrain = target.mind

	var/datum/antagonist/changeling/changeling = IS_CHANGELING(owner)

	for(var/memory_type in suckedbrain.memories)
		var/datum/memory/stolen_memory = suckedbrain.memories[memory_type]
		changeling.stolen_memories[stolen_memory.name] = stolen_memory.generate_story(STORY_CHANGELING_ABSORB, STORY_FLAG_NO_STYLE)
	suckedbrain.wipe_memory()

	for(var/datum/antagonist/antagonist_datum as anything in suckedbrain.antag_datums)
		var/list/all_objectives = antagonist_datum.objectives.Copy()
		if(antagonist_datum.antag_memory)
			changeling.antag_memory += "[target] 的反派记忆：[antagonist_datum.antag_memory]。"
		if(!LAZYLEN(all_objectives))
			continue
		changeling.antag_memory += " 目标："
		var/obj_count = 1
		for(var/datum/objective/objective as anything in all_objectives)
			if(!objective) //nulls? in my objective list? it's more likely than you think.
				continue
			changeling.antag_memory += " 目标 #[obj_count++]：[objective.explanation_text]。"
			var/list/datum/mind/other_owners = objective.get_owners() - suckedbrain
			if(!other_owners.len)
				continue
			for(var/datum/mind/conspirator as anything in other_owners)
				changeling.antag_memory += " 目标同谋：[conspirator.name]。"
	changeling.antag_memory += " 这就是[target]所知的全部了。 "

	//Some of target's recent speech, so the changeling can attempt to imitate them better.
	//Recent as opposed to all because rounds tend to have a LOT of text.

	var/list/recent_speech = target.copy_recent_speech()

	if(recent_speech.len)
		changeling.antag_memory += "以下是[target]的一些说话方式，我们该好好研究，好更逼真地冒充对方："
		to_chat(owner, span_boldnotice("以下是[target]的一些说话方式，我们该好好研究，好更逼真地冒充对方！"))
		for(var/spoken_memory in recent_speech)
			changeling.antag_memory += " \"[spoken_memory]\""
			to_chat(owner, span_notice("\"[spoken_memory]\""))
		changeling.antag_memory += "。我们再没有关于[target]说话方式的线索了。 "
		to_chat(owner, span_boldnotice("我们再没有关于[target]说话方式的线索了。"))


	var/datum/antagonist/changeling/target_ling = IS_CHANGELING(target)
	if(target_ling)//If the target was a changeling, suck out their extra juice and objective points!
		to_chat(owner, span_boldnotice("[target]曾是我们的一员。我们已吸收了其力量。"))

		// Gain half of their genetic points.
		var/genetic_points_to_add = round(target_ling.total_genetic_points / 2)
		changeling.genetic_points += genetic_points_to_add
		changeling.total_genetic_points += genetic_points_to_add

		// And half of their chemical charges.
		var/chems_to_add = round(target_ling.total_chem_storage / 2)
		changeling.adjust_chemicals(chems_to_add)
		changeling.total_chem_storage += chems_to_add

		// And of course however many they've absorbed, we've absorbed
		changeling.absorbed_count += target_ling.absorbed_count

		// Lastly, make them not a ling anymore. (But leave their objectives for round-end purposes).
		var/list/copied_objectives = target_ling.objectives.Copy()
		target.mind.remove_antag_datum(/datum/antagonist/changeling)
		var/datum/antagonist/fallen_changeling/fallen = target.mind.add_antag_datum(/datum/antagonist/fallen_changeling)
		fallen.objectives = copied_objectives

/datum/action/changeling/absorb_dna/proc/attempt_absorb(mob/living/carbon/human/target)
	for(var/absorbing_iteration in 1 to 3)
		switch(absorbing_iteration)
			if(1)
				to_chat(owner, span_notice("这个生物与我们兼容。我们必须保持不动……"))
			if(2)
				owner.visible_message(span_warning("[owner]伸出了口器！"), span_notice("我们伸出了口器。"))
			if(3)
				absorbing_loop = new(owner, start_immediately = TRUE)
				owner.visible_message(span_danger("[owner]用口器刺入了[target]！"), span_notice("我们用口器刺入[target]。"))
				to_chat(target, span_userdanger("你感到一阵尖锐的刺痛！"))
				target.take_overall_damage(40)

		SSblackbox.record_feedback("nested tally", "changeling_powers", 1, list("Absorb DNA", "[absorbing_iteration]"))
		if(!do_after(owner, 15 SECONDS, target, cog_icon = null))
			owner.balloon_alert(owner, "被打断了！")
			qdel(absorbing_loop)
			is_absorbing = FALSE
			return FALSE
	return TRUE

/mob/eye/imaginary_friend/hivemind
	name = "蜂巢意识成员"
	desc = "在变形怪蜂巢意识这片汪洋中漂荡的一缕思绪。"
	distance_allowance = 5
	require_los = TRUE
	hidden = TRUE
	/// Don't spam the hivemind on login logout
	var/alerted = FALSE

/mob/eye/imaginary_friend/hivemind/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CHANGELING_HIVEMIND, INNATE_TRAIT)
	var/datum/action/innate/exit_hivemind/exit_action = new(src)
	exit_action.Grant(src)

/mob/eye/imaginary_friend/hivemind/Login()
	. = ..()
	client.eye = owner || src

/mob/eye/imaginary_friend/hivemind/greet()

	var/greet_message = ""
	greet_message += separator_hr(span_danger(span_slightly_larger("你已被变形怪吸收！")))
	greet_message += "你现在是变形怪蜂巢意识的一部分，可以通过说话与他们自由交流。\
		你的知识或许对他们有用……"
	greet_message += "<br>如果你更愿意旁观，也可以选择<a href='byond://?src=[REF(src)];exit_hivemind=1'>退出蜂巢意识</a> \
		转为旁观。"
	greet_message += "<br>无论如何，如果你的身体或大脑被复活，你都会正常回到其中。"

	to_chat(src, boxed_message(span_changeling(greet_message)))

	if(!alerted)
		alerted = TRUE
		alert_hivemind("你感觉到[real_name]出现在了蜂巢意识中。")

/mob/eye/imaginary_friend/hivemind/send_speech(message, range, obj/source, bubble_type, list/spans, datum/language/message_language, list/message_mods = list(), forced)
	// chops any message mods, even though they won't actually do anything
	message = get_message_mods(message, message_mods)
	// forces message through the changeling saymode
	var/datum/saymode/changeling/saymode = SSradio.saymodes[/datum/saymode/changeling::key]
	saymode.handle_message(src, message, spans, message_language, message_mods)

/mob/eye/imaginary_friend/hivemind/Topic(href, list/href_list)
	. = ..()
	if(href_list["exit_hivemind"] && !QDELETED(src))
		exit_hivemind()

/mob/eye/imaginary_friend/hivemind/proc/exit_hivemind()
	var/response = tgui_alert(src, "你确定要退出蜂巢意识吗？\
		退出后无法再进入，但你仍可被复活。", "确认退出", list("Exit", "Stay"))
	if(response != "Exit" || QDELETED(src))
		return
	ghostize(TRUE)

/mob/eye/imaginary_friend/hivemind/ghostize(can_reenter_corpse, forced)
	. = ..()
	if(forced)
		return

	alert_hivemind("你感觉到[real_name]从蜂巢意识中消失了。")
	if(!QDELING(src))
		qdel(src)

/mob/eye/imaginary_friend/hivemind/proc/alert_hivemind(message)
	var/datum/saymode/changeling/saymode = SSradio.saymodes[/datum/saymode/changeling::key]
	for(var/mob/ling_mob as anything in saymode.get_lings() - src)
		to_chat(ling_mob, span_changeling("<i>[message]</i>"))

/mob/eye/imaginary_friend/hivemind/attach_to_owner(mob/living/imaginary_friend_owner)
	. = ..()
	client?.eye = owner
	if(locate(/datum/action/changeling/eject_from_hivemind) in owner.actions)
		return
	var/datum/action/changeling/eject_from_hivemind/ejector = new(owner)
	ejector.Grant(owner)

/mob/eye/imaginary_friend/hivemind/Destroy()
	for(var/mob/eye/imaginary_friend/hivemind/other_member in owner.imaginary_group - src)
		return ..()

	var/datum/action/changeling/eject_from_hivemind/ejector = locate() in owner.actions
	qdel(ejector)
	return ..()

/datum/action/innate/exit_hivemind
	name = "退出蜂巢意识"
	desc = "永久退出变形怪蜂巢意识。之后你仍可能被复活。"
	// button_icon_state = "exit_hivemind"

/datum/action/innate/exit_hivemind/Activate()
	var/mob/eye/imaginary_friend/hivemind/member = owner
	member.exit_hivemind()

/// Allow the changeling to nuke people griffing them
/datum/action/changeling/eject_from_hivemind
	name = "逐出蜂巢意识"
	desc = "将一名不受欢迎的成员逐出蜂巢意识。"
	// button_icon_state = "eject_hivemind"
	chemical_cost = 0
	dna_cost = CHANGELING_POWER_UNOBTAINABLE

/datum/action/changeling/eject_from_hivemind/sting_action(mob/living/user)
	var/list/freeloaders = list()
	for(var/mob/eye/imaginary_friend/hivemind/freeloader in user.imaginary_group)
		freeloaders[freeloader.real_name] = freeloader

	if(!length(freeloaders))
		stack_trace("Tried to eject from hivemind with no hivemind members!")
		qdel(src)
		return FALSE

	var/chosen = tgui_input_list(owner, "选择要逐出蜂巢意识的成员。", "逐出蜂巢意识成员", freeloaders)
	var/mob/eye/imaginary_friend/hivemind/freeloader = freeloaders[chosen]
	if(QDELETED(freeloader) || QDELETED(src))
		return FALSE

	to_chat(freeloader, span_userdanger("你已被逐出变形怪蜂巢意识！"))
	qdel(freeloader)
	..()
	return TRUE
