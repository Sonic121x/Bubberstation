#define OWNER 0
#define STRANGER 1

/datum/brain_trauma/severe/split_personality
	name = "人格分裂"
	desc = "患者的大脑分裂为两个人格，随机交替控制身体。"
	scan_desc = "脑叶完全分离"
	symptoms = "表现出两个不同的人格，交替控制同一具身体，\
		各自拥有独立的记忆、行为和偏好。尽管两个人格都知道对方的存在，\
		他们的欲望和行为可能互相冲突，导致宿主困惑和迷失。"
	gain_text = span_warning("你觉得自己的意识被一分为二了。")
	lose_text = span_notice("你觉得自己又独自一人了。")
	var/current_controller = OWNER
	var/initialized = FALSE //to prevent personalities deleting themselves while we wait for ghosts
	var/mob/living/split_personality/stranger_backseat //there's two so they can swap without overwriting
	var/mob/living/split_personality/owner_backseat
	///The role to display when polling ghost
	var/poll_role = "分裂人格"
	///How long do we give ghosts to respond?
	var/poll_time = 20 SECONDS

/datum/brain_trauma/severe/split_personality/on_gain()
	var/mob/living/brain_owner = owner
	if(brain_owner.stat == DEAD || !GET_CLIENT(brain_owner) || istype(get_area(brain_owner), /area/deathmatch) || HAS_TRAIT(brain_owner, TRAIT_NO_SPLIT_PERSONALITY)) //No use assigning people to a corpse or braindead
		return FALSE
	. = ..()
	make_backseats()

#ifdef UNIT_TESTS
	return // There's no ghosts in the unit test
#endif

	get_ghost()

/datum/brain_trauma/severe/split_personality/proc/make_backseats()
	stranger_backseat = new(owner, src)
	var/datum/action/personality_commune/stranger_spell = new(src)
	stranger_spell.Grant(stranger_backseat)

	owner_backseat = new(owner, src)
	var/datum/action/personality_commune/owner_spell = new(src)
	owner_spell.Grant(owner_backseat)

/// Attempts to get a ghost to play the personality
/datum/brain_trauma/severe/split_personality/proc/get_ghost()
	var/mob/chosen_one = SSpolling.poll_ghosts_for_target(
		question = "你想扮演[span_danger("[owner.real_name]")]的[span_notice(poll_role)]吗？",
		check_jobban = ROLE_PAI,
		poll_time = poll_time,
		checked_target = owner,
		ignore_category = POLL_IGNORE_SPLITPERSONALITY,
		alert_pic = owner,
		role_name_text = poll_role,
	)
	schism(chosen_one)

/// Ghost poll has concluded
/datum/brain_trauma/severe/split_personality/proc/schism(mob/dead/observer/ghost)
	if(isnull(ghost))
		qdel(src)
		return

	stranger_backseat.PossessByPlayer(ghost.ckey)
	stranger_backseat.log_message("became [key_name(owner)]'s split personality.", LOG_GAME)
	message_admins("[ADMIN_LOOKUPFLW(stranger_backseat)]成为了[ADMIN_LOOKUPFLW(owner)]的分裂人格。")


/datum/brain_trauma/severe/split_personality/on_life(seconds_per_tick)
	if(owner.stat == DEAD)
		if(current_controller != OWNER)
			switch_personalities(TRUE)
		qdel(src)
	else if(SPT_PROB(1.5, seconds_per_tick))
		switch_personalities()
	..()

/datum/brain_trauma/severe/split_personality/on_lose()
	if(current_controller != OWNER) //it would be funny to cure a guy only to be left with the other personality, but it seems too cruel
		switch_personalities(TRUE)
	QDEL_NULL(stranger_backseat)
	QDEL_NULL(owner_backseat)
	..()


/datum/brain_trauma/severe/split_personality/proc/switch_personalities(reset_to_owner = FALSE)
	if(QDELETED(owner) || QDELETED(stranger_backseat) || QDELETED(owner_backseat))
		return

	var/mob/living/split_personality/current_backseat
	var/mob/living/split_personality/new_backseat
	if(current_controller == STRANGER || reset_to_owner)
		current_backseat = owner_backseat
		new_backseat = stranger_backseat
	else
		current_backseat = stranger_backseat
		new_backseat = owner_backseat

	if(!current_backseat.client) //Make sure we never switch to a logged off mob.
		return

	current_backseat.log_message("assumed control of [key_name(owner)] due to [src]. (Original owner: [current_controller == OWNER ? owner.key : current_backseat.key])", LOG_GAME)
	to_chat(owner, span_userdanger("你感觉身体的控制权被夺走了……现在由你的另一个人格掌控！"))
	to_chat(current_backseat, span_userdanger("你成功取得了身体的控制权！"))

	//Body to backseat

	var/h2b_id = owner.computer_id
	var/h2b_ip= owner.lastKnownIP
	owner.computer_id = null
	owner.lastKnownIP = null

	new_backseat.ckey = owner.ckey

	new_backseat.name = owner.name

	if(owner.mind)
		new_backseat.mind = owner.mind

	if(!new_backseat.computer_id)
		new_backseat.computer_id = h2b_id

	if(!new_backseat.lastKnownIP)
		new_backseat.lastKnownIP = h2b_ip

	if(reset_to_owner && new_backseat.mind)
		new_backseat.ghostize(FALSE)

	//Backseat to body

	var/s2h_id = current_backseat.computer_id
	var/s2h_ip= current_backseat.lastKnownIP
	current_backseat.computer_id = null
	current_backseat.lastKnownIP = null

	owner.ckey = current_backseat.ckey
	owner.mind = current_backseat.mind

	if(!owner.computer_id)
		owner.computer_id = s2h_id

	if(!owner.lastKnownIP)
		owner.lastKnownIP = s2h_ip

	current_controller = !current_controller


/mob/living/split_personality
	name = "分裂人格"
	real_name = "未知意识"
	var/mob/living/carbon/body
	var/datum/brain_trauma/severe/split_personality/trauma

/mob/living/split_personality/Initialize(mapload, _trauma)
	if(iscarbon(loc))
		body = loc
		name = body.real_name
		real_name = body.real_name
		trauma = _trauma
	return ..()

/mob/living/split_personality/Life(seconds_per_tick = SSMOBS_DT)
	if(QDELETED(body))
		qdel(src) //in case trauma deletion doesn't already do it

	if((body.stat == DEAD && trauma.owner_backseat == src))
		trauma.switch_personalities()
		qdel(trauma)

	//if one of the two ghosts, the other one stays permanently
	if(!body.client && trauma.initialized)
		trauma.switch_personalities()
		qdel(trauma)

	..()

/mob/living/split_personality/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	to_chat(src, span_notice("作为分裂人格，你目前只能旁观。不过，你最终会与当前人格互换位置，获得身体的控制权。"))
	to_chat(src, span_warning("<b>不要自杀，也不要让身体陷入致命险境。你应当像身体的主人一样珍惜它。</b>"))

/mob/living/split_personality/try_speak(message, ignore_spam, forced, filterproof)
	SHOULD_CALL_PARENT(FALSE)
	to_chat(src, span_warning("你无法说话，你的另一个人格正在控制身体！"))
	return FALSE

/mob/living/split_personality/emote(act, type_override = NONE, message = null, intentional = FALSE, force_silence = FALSE, forced = FALSE)
	return FALSE

///////////////BRAINWASHING////////////////////

/datum/brain_trauma/severe/split_personality/brainwashing
	name = "人格分裂"
	desc = "患者的大脑分裂为两个人格，随机交替控制身体。"
	scan_desc = "脑叶完全分离"
	gain_text = ""
	lose_text = span_notice("你摆脱了洗脑。")
	can_gain = FALSE
	known_trauma = FALSE
	var/codeword
	var/objective

/datum/brain_trauma/severe/split_personality/brainwashing/New(obj/item/organ/brain/B, _permanent, _codeword, _objective)
	..()
	if(_codeword)
		codeword = _codeword
	else
		codeword = pick(strings("ion_laws.json", "ionabstract")\
			| strings("ion_laws.json", "ionobjects")\
			| strings("ion_laws.json", "ionadjectives")\
			| strings("ion_laws.json", "ionthreats")\
			| strings("ion_laws.json", "ionfood")\
			| strings("ion_laws.json", "iondrinks"))

/datum/brain_trauma/severe/split_personality/brainwashing/on_gain()
	. = ..()
	var/mob/living/split_personality/traitor/traitor_backseat = stranger_backseat
	traitor_backseat.codeword = codeword
	traitor_backseat.objective = objective

/datum/brain_trauma/severe/split_personality/brainwashing/make_backseats()
	stranger_backseat = new /mob/living/split_personality/traitor(owner, src, codeword, objective)
	owner_backseat = new(owner, src)

/datum/brain_trauma/severe/split_personality/brainwashing/get_ghost()
	set waitfor = FALSE
	var/mob/chosen_one = SSpolling.poll_ghosts_for_target("你想扮演[span_danger("[owner.real_name]")]被洗脑的意识吗？", poll_time = 7.5 SECONDS, checked_target = stranger_backseat, alert_pic = owner, role_name_text = "被洗脑的意识")
	if(chosen_one)
		stranger_backseat.PossessByPlayer(chosen_one.ckey)
	else
		qdel(src)

/datum/brain_trauma/severe/split_personality/brainwashing/on_life(seconds_per_tick)
	return //no random switching

/datum/brain_trauma/severe/split_personality/brainwashing/handle_hearing(datum/source, list/hearing_args)
	if(HAS_TRAIT(owner, TRAIT_DEAF) || owner == hearing_args[HEARING_SPEAKER] || !owner.has_language(hearing_args[HEARING_LANGUAGE]))
		return

	var/message = hearing_args[HEARING_RAW_MESSAGE]
	if(findtext(message, codeword))
		hearing_args[HEARING_RAW_MESSAGE] = replacetext(message, codeword, span_warning("[codeword]"))
		addtimer(CALLBACK(src, TYPE_PROC_REF(/datum/brain_trauma/severe/split_personality, switch_personalities)), 1 SECONDS)

/datum/brain_trauma/severe/split_personality/brainwashing/handle_speech(datum/source, list/speech_args)
	if(findtext(speech_args[SPEECH_MESSAGE], codeword))
		speech_args[SPEECH_MESSAGE] = "" //oh hey did you want to tell people about the secret word to bring you back?

/mob/living/split_personality/traitor
	name = "分裂人格"
	real_name = "未知意识"
	var/objective
	var/codeword

/mob/living/split_personality/traitor/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	to_chat(src, span_notice("作为被洗脑的人格，你目前只能旁观。不过，听到特定暗号后，你可能会与当前人格互换位置，获得身体的控制权。"))
	to_chat(src, span_notice("你的激活暗号是：<b>[codeword]</b>"))
	if(objective)
		to_chat(src, span_notice("你的主人给你留下了一个目标：<b>[objective]</b>。取得控制权后，不惜一切代价完成它。"))

/datum/brain_trauma/severe/split_personality/blackout
	name = "酒精诱发中枢神经损伤"
	desc = "患者饮入的酒精暂时损害了中枢神经系统，阻碍记忆形成，导致认知能力下降和意识迟钝。"
	scan_desc = "酒精诱发中枢神经损伤"
	symptoms = "过量饮酒导致暂时断片，随后出现困惑、迷失，醒来后的几分钟内\
		意识状态几乎完全改变。在此期间，患者可能表现出\
		精细动作能力受损、惊人的疼痛耐受力，以及完全失忆。"
	gain_text = span_warning("糟了，喝得太多了。你断片了……")
	lose_text = "你醒来时极度困惑，宿醉难忍。你只记得自己喝了很多酒……发生了什么？"
	poll_role = "断片的醉汉"
	random_gain = FALSE
	poll_time = 10 SECONDS
	/// Duration of effect, tracked in seconds, not deciseconds. qdels when reaching 0.
	var/duration_in_seconds = 180

/datum/brain_trauma/severe/split_personality/blackout/on_gain()
	. = ..()

	if(QDELETED(src))
		return

	RegisterSignal(owner, COMSIG_ATOM_SPLASHED, PROC_REF(on_splashed))
	notify_ghosts(
		"[owner.real_name]喝到断片了！",
		source = owner,
		header = "兄弟，我现在根本没醉",
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
	)
	var/datum/status_effect/inebriated/inebriation = owner.has_status_effect(/datum/status_effect/inebriated)
	inebriation?.iron_liver = TRUE

/datum/brain_trauma/severe/split_personality/blackout/on_lose()
	. = ..()
	owner.add_mood_event("hang_over", /datum/mood_event/hang_over)
	UnregisterSignal(owner, COMSIG_ATOM_SPLASHED)
	var/datum/status_effect/inebriated/inebriation = owner.has_status_effect(/datum/status_effect/inebriated)
	inebriation?.iron_liver = FALSE

/datum/brain_trauma/severe/split_personality/blackout/proc/on_splashed()
	SIGNAL_HANDLER
	if(prob(20))//we don't want every single splash to wake them up now do we
		qdel(src)

/datum/brain_trauma/severe/split_personality/blackout/on_life(seconds_per_tick)
	if(current_controller == OWNER && stranger_backseat)//we should only start transitioning after the other personality has entered
		owner.overlay_fullscreen("fade_to_black", /atom/movable/screen/fullscreen/blind)
		owner.clear_fullscreen("fade_to_black", animated = 4 SECONDS)
		switch_personalities()
	if(owner.stat == DEAD)
		if(current_controller != OWNER)
			switch_personalities(TRUE)
		qdel(src)
		return
	if(duration_in_seconds <= 0)
		qdel(src)
		return
	else if(duration_in_seconds <= 60 && !(duration_in_seconds % 20))
		to_chat(owner, span_warning("你还有[duration_in_seconds]秒就要醒酒了！"))
	if(prob(10) && !HAS_TRAIT(owner, TRAIT_DISCOORDINATED_TOOL_USER))
		ADD_TRAIT(owner, TRAIT_DISCOORDINATED_TOOL_USER, TRAUMA_TRAIT)
		owner.balloon_alert(owner, "灵巧度暂时降低！")
		//We then send a callback to automatically re-add the trait
		addtimer(TRAIT_CALLBACK_REMOVE(owner, TRAIT_DISCOORDINATED_TOOL_USER, TRAUMA_TRAIT), 10 SECONDS)
		addtimer(CALLBACK(owner, TYPE_PROC_REF(/atom, balloon_alert), owner, "灵巧度恢复！"), 10 SECONDS)
	if(prob(15))
		playsound(owner,'sound/mobs/humanoids/human/hiccup/sf_hiccup_male_01.ogg', 50)
		owner.emote("hiccup")
	//too drunk to feel anything
	//if they're to this point, they're likely dying of liver damage
	//and not accounting for that, the split personality is temporary
	owner.adjust_stamina_loss(-25)
	duration_in_seconds -= seconds_per_tick

/mob/living/split_personality/blackout
	name = "断片的醉汉"
	real_name = "醉酒意识"

/mob/living/split_personality/blackout/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	to_chat(src, span_notice("你是宿主意识中烂醉如泥的残余！请演好这个角色，在所到之处留下困惑和混乱。"))
	to_chat(src, span_boldwarning("虽然你喝醉了，但你没有自杀倾向。不要自杀，也不要让身体陷入危险。你可以像小丑一样稍微恶作剧，但不得杀人，也不得制造让身体陷入危险或可能受伤的局面。"))

#undef OWNER
#undef STRANGER
