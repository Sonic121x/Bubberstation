//Severe traumas, when your brain gets abused way too much.
//These range from very annoying to completely debilitating.
//They cannot be cured with chemicals, and require brain surgery to solve.

/datum/brain_trauma/severe
	abstract_type = /datum/brain_trauma/severe
	resilience = TRAUMA_RESILIENCE_SURGERY

/datum/brain_trauma/severe/mute
	name = "缄默症"
	desc = "患者完全无法说话。"
	scan_desc = "脑部言语中枢严重受损"
	symptoms = "完全无法用口部发声或说话。"
	gain_text = span_warning("你忘了怎么说话！")
	lose_text = span_notice("你突然想起了怎么说话。")

/datum/brain_trauma/severe/mute/on_gain()
	ADD_TRAIT(owner, TRAIT_MUTE, TRAUMA_TRAIT)
	. = ..()

/datum/brain_trauma/severe/mute/on_lose()
	REMOVE_TRAIT(owner, TRAIT_MUTE, TRAUMA_TRAIT)
	..()

/datum/brain_trauma/severe/aphasia
	name = "失语症"
	desc = "患者无法说出或理解任何语言。"
	scan_desc = "脑部语言中枢严重受损"
	symptoms = "完全无法理解或组织语言，只能发出难以理解的声音。"
	gain_text = span_warning("你难以在脑中组织词语……")
	lose_text = span_notice("你突然想起了如何运用语言。")

/datum/brain_trauma/severe/aphasia/on_gain()
	owner.add_blocked_language(subtypesof(/datum/language) - /datum/language/aphasia, source = LANGUAGE_APHASIA)
	owner.grant_language(/datum/language/aphasia, source = LANGUAGE_APHASIA)
	. = ..()

/datum/brain_trauma/severe/aphasia/on_lose()
	if(!QDELING(owner))
		owner.remove_blocked_language(subtypesof(/datum/language), source = LANGUAGE_APHASIA)
		owner.remove_language(/datum/language/aphasia, source = LANGUAGE_APHASIA)

	..()

/datum/brain_trauma/severe/blindness
	name = "脑性失明"
	desc = "患者的大脑不再与眼睛连接。"
	scan_desc = "脑部枕叶严重受损"
	symptoms = "尽管眼睛功能完好，却完全丧失了视力。"
	gain_text = span_warning("你看不见了！")
	lose_text = span_notice("你的视力恢复了。")

/datum/brain_trauma/severe/blindness/on_gain()
	owner.become_blind(TRAUMA_TRAIT)
	. = ..()

/datum/brain_trauma/severe/blindness/on_lose()
	owner.cure_blind(TRAUMA_TRAIT)
	..()

/datum/brain_trauma/severe/paralysis
	name = "瘫痪"
	desc = "患者的大脑无法再控制部分运动功能。"
	scan_desc = "脑性瘫痪"
	symptoms = "特定身体部位完全丧失自主运动能力。"
	gain_text = ""
	lose_text = ""
	var/paralysis_type
	var/list/paralysis_traits = list()
	//for descriptions

/datum/brain_trauma/severe/paralysis/New(specific_type)
	if(specific_type)
		paralysis_type = specific_type
	if(!paralysis_type)
		paralysis_type = pick("full","left","right","arms","legs","r_arm","l_arm","r_leg","l_leg")
	var/subject
	switch(paralysis_type)
		if("full")
			subject = "自己的身体"
			paralysis_traits = list(TRAIT_PARALYSIS_L_ARM, TRAIT_PARALYSIS_R_ARM, TRAIT_PARALYSIS_L_LEG, TRAIT_PARALYSIS_R_LEG)
		if("left")
			subject = "自己的左半身"
			paralysis_traits = list(TRAIT_PARALYSIS_L_ARM, TRAIT_PARALYSIS_L_LEG)
		if("right")
			subject = "自己的右半身"
			paralysis_traits = list(TRAIT_PARALYSIS_R_ARM, TRAIT_PARALYSIS_R_LEG)
		if("arms")
			subject = "自己的双臂"
			paralysis_traits = list(TRAIT_PARALYSIS_L_ARM, TRAIT_PARALYSIS_R_ARM)
		if("legs")
			subject = "自己的双腿"
			paralysis_traits = list(TRAIT_PARALYSIS_L_LEG, TRAIT_PARALYSIS_R_LEG)
		if("r_arm")
			subject = "自己的右臂"
			paralysis_traits = list(TRAIT_PARALYSIS_R_ARM)
		if("l_arm")
			subject = "自己的左臂"
			paralysis_traits = list(TRAIT_PARALYSIS_L_ARM)
		if("r_leg")
			subject = "自己的右腿"
			paralysis_traits = list(TRAIT_PARALYSIS_R_LEG)
		if("l_leg")
			subject = "自己的左腿"
			paralysis_traits = list(TRAIT_PARALYSIS_L_LEG)

	gain_text = span_warning("你再也感觉不到[subject]了！")
	lose_text = span_notice("你又能感觉到[subject]了！")

/datum/brain_trauma/severe/paralysis/on_gain()
	. = ..()
	for(var/X in paralysis_traits)
		ADD_TRAIT(owner, X, TRAUMA_TRAIT)


/datum/brain_trauma/severe/paralysis/on_lose()
	..()
	for(var/X in paralysis_traits)
		REMOVE_TRAIT(owner, X, TRAUMA_TRAIT)


/datum/brain_trauma/severe/paralysis/paraplegic
	random_gain = FALSE
	known_trauma = FALSE
	paralysis_type = "legs"
	resilience = TRAUMA_RESILIENCE_ABSOLUTE

/datum/brain_trauma/severe/paralysis/hemiplegic
	random_gain = FALSE
	known_trauma = FALSE
	resilience = TRAUMA_RESILIENCE_ABSOLUTE

/datum/brain_trauma/severe/paralysis/hemiplegic/left
	paralysis_type = "left"

/datum/brain_trauma/severe/paralysis/hemiplegic/right
	paralysis_type = "right"

/datum/brain_trauma/severe/narcolepsy
	name = "发作性睡病"
	desc = "患者可能在正常活动中不由自主地入睡。"
	scan_desc = "创伤性发作性睡病"
	symptoms = "正常活动时突然出现无法控制的困倦或嗜睡发作。"
	gain_text = span_warning("你总是感到昏昏欲睡……")
	lose_text = span_notice("你又感觉清醒而警觉了。")
	/// Odds seconds_per_tick the user falls asleep
	var/sleep_chance = 1
	/// Odds seconds_per_tick the user falls asleep while running
	var/sleep_chance_running = 2
	/// Odds seconds_per_tick the user falls asleep while drowsy
	var/sleep_chance_drowsy = 3
	/// Time values for how long the user will stay drowsy
	var/drowsy_time_minimum = 20 SECONDS
	var/drowsy_time_maximum = 30 SECONDS
	/// Time values for how long the user will stay asleep
	var/sleep_time_minimum = 6 SECONDS
	var/sleep_time_maximum = 6 SECONDS

/datum/brain_trauma/severe/narcolepsy/on_life(seconds_per_tick)
	if(owner.IsSleeping())
		return

	/// If any of these are in the user's blood, return early
	var/static/list/immunity_medicine = list(
		/datum/reagent/medicine/modafinil,
		/datum/reagent/medicine/synaptizine,
	) //don't add too many, as most stimulant reagents already have a drowsy-removing effect
	for(var/medicine in immunity_medicine)
		if(owner.reagents.has_reagent(medicine))
			return

	var/drowsy = !!owner.has_status_effect(/datum/status_effect/drowsiness)
	var/caffeinated = HAS_TRAIT(owner, TRAIT_STIMULATED)
	var/final_sleep_chance = sleep_chance
	if(owner.move_intent == MOVE_INTENT_RUN)
		final_sleep_chance += sleep_chance_running
	if(drowsy)
		final_sleep_chance += sleep_chance_drowsy //stack drowsy ontop of base or running odds with the += operator
	if(caffeinated)
		final_sleep_chance *= 0.5 //make it harder to fall asleep on caffeine

	if(!SPT_PROB(final_sleep_chance, seconds_per_tick))
		return

	//if not drowsy, don't fall asleep but make them drowsy
	if(!drowsy)
		to_chat(owner, span_warning("你感觉很困……"))
		owner.adjust_drowsiness(rand(drowsy_time_minimum, drowsy_time_maximum))
		if(prob(50))
			owner.emote("yawn")
		else if(prob(33)) //rarest message is a custom emote
			owner.visible_message("揉了揉自己的眼睛。", visible_message_flags = EMOTE_MESSAGE)
	//drowsy, so fall asleep. you've had your chance to remedy it
	else
		to_chat(owner, span_warning("你睡着了。"))
		owner.Sleeping(rand(sleep_time_minimum, sleep_time_maximum))
		if(prob(50) && owner.IsSleeping())
			owner.emote("snore")

/datum/brain_trauma/severe/narcolepsy/permanent
	scan_desc = "慢性发作性睡病" //less odds to fall asleep than parent, but sleeps for longer
	sleep_chance = 0.333
	sleep_chance_running = 0.333
	sleep_chance_drowsy = 1
	sleep_time_minimum = 20 SECONDS
	sleep_time_maximum = 30 SECONDS
	known_trauma = FALSE

/datum/brain_trauma/severe/monophobia
	name = "独处恐惧症"
	desc = "患者在身边没有其他人时会感到不适和痛苦，造成可能致命的压力。"
	scan_desc = "独处恐惧症"
	symptoms = "独处时产生强烈的恐惧和焦虑，经常导致恐慌发作、\
		恶心、心跳加速，严重时还会昏厥、呕吐或心力衰竭。"
	gain_text = span_warning("你感觉无比孤独……")
	lose_text = span_notice("你觉得独自一人也能安全无恙了。")

/datum/brain_trauma/severe/monophobia/on_gain()
	. = ..()
	owner.AddComponentFrom(REF(src), /datum/component/fearful, list(/datum/terror_handler/vomiting, /datum/terror_handler/simple_source/monophobia))

/datum/brain_trauma/severe/monophobia/on_lose(silent)
	. = ..()
	owner.RemoveComponentSource(REF(src), /datum/component/fearful)

/datum/brain_trauma/severe/discoordination
	name = "协调障碍"
	desc = "患者无法使用复杂工具或机械。"
	scan_desc = "严重协调障碍"
	symptoms = "完全无法执行需要精细动作或协调能力的任务，例如使用工具或操作机械。"
	gain_text = span_warning("你几乎无法控制自己的双手！")
	lose_text = span_notice("你感觉又能控制自己的双手了。")

/datum/brain_trauma/severe/discoordination/on_gain()
	. = ..()
	owner.apply_status_effect(/datum/status_effect/discoordinated)

/datum/brain_trauma/severe/discoordination/on_lose()
	owner.remove_status_effect(/datum/status_effect/discoordinated)
	return ..()

/datum/brain_trauma/severe/pacifism
	name = "创伤性非暴力倾向"
	desc = "患者极不愿意以暴力方式伤害他人。"
	scan_desc = "和平综合征"
	symptoms = "完全无法说服自己对他人实施暴力或伤害，\
		经常竭力回避冲突以及可能引发暴力的情况。"
	gain_text = span_notice("你感到出奇地平和。")
	lose_text = span_notice("你不再受到不得伤人的念头束缚了。")

/datum/brain_trauma/severe/pacifism/on_gain()
	ADD_TRAIT(owner, TRAIT_PACIFISM, TRAUMA_TRAIT)
	. = ..()

/datum/brain_trauma/severe/pacifism/on_lose()
	REMOVE_TRAIT(owner, TRAIT_PACIFISM, TRAUMA_TRAIT)
	..()

/datum/brain_trauma/severe/hypnotic_stupor
	name = "催眠性木僵"
	desc = "患者容易陷入极度恍惚，使其极易受到暗示。"
	scan_desc = "梦境反馈循环"
	symptoms = "突然陷入深度木僵或出神状态，期间极易受到外界暗示，\
		经常出现感知或行为改变、被灌输记忆等情况，严重时会危及自己或他人。"
	gain_text = span_warning("你感到有些恍惚。")
	lose_text = span_notice("你觉得脑中的迷雾散去了。")

/datum/brain_trauma/severe/hypnotic_stupor/on_lose() //hypnosis must be cleared separately, but brain surgery should get rid of both anyway
	..()
	owner.remove_status_effect(/datum/status_effect/trance)

/datum/brain_trauma/severe/hypnotic_stupor/on_life(seconds_per_tick)
	..()
	if(SPT_PROB(0.5, seconds_per_tick) && !owner.has_status_effect(/datum/status_effect/trance))
		owner.apply_status_effect(/datum/status_effect/trance, rand(100,300), FALSE)

/datum/brain_trauma/severe/hypnotic_trigger
	name = "催眠触发"
	desc = "患者的潜意识中被设定了触发短句，会使其陷入易受暗示的出神状态。"
	scan_desc = "梦境反馈循环"
	gain_text = span_warning("你感觉怪怪的，仿佛刚忘记了什么重要的事。")
	lose_text = span_notice("你觉得心头的重担卸下了。")
	random_gain = FALSE
	known_trauma = FALSE
	var/trigger_phrase = "Nanotrasen"

/datum/brain_trauma/severe/hypnotic_trigger/New(phrase)
	..()
	if(phrase)
		trigger_phrase = phrase

/datum/brain_trauma/severe/hypnotic_trigger/on_lose() //hypnosis must be cleared separately, but brain surgery should get rid of both anyway
	..()
	owner.remove_status_effect(/datum/status_effect/trance)

/datum/brain_trauma/severe/hypnotic_trigger/handle_hearing(datum/source, list/hearing_args)
	if(HAS_TRAIT(owner, TRAIT_DEAF) || owner == hearing_args[HEARING_SPEAKER])
		return

	var/regex/reg = new("(\\b[REGEX_QUOTE(trigger_phrase)]\\b)","ig")

	if(findtext(hearing_args[HEARING_RAW_MESSAGE], reg))
		addtimer(CALLBACK(src, PROC_REF(hypnotrigger)), 1 SECONDS) //to react AFTER the chat message
		hearing_args[HEARING_RAW_MESSAGE] = reg.Replace(hearing_args[HEARING_RAW_MESSAGE], span_hypnophrase("*********"))

/datum/brain_trauma/severe/hypnotic_trigger/proc/hypnotrigger()
	to_chat(owner, span_warning("这些话触动了你内心深处的某种东西，你感觉意识正逐渐远去……"))
	owner.apply_status_effect(/datum/status_effect/trance, rand(100,300), FALSE)

/datum/brain_trauma/severe/dyslexia
	name = "读写障碍"
	desc = "患者无法阅读或书写。"
	scan_desc = "读写障碍"
	symptoms = "阅读和书写能力严重受损，经常混淆字母与词语，\
		难以完成读取扫描仪或填写文书等需要读写能力的任务。"
	gain_text = span_warning("你难以阅读或书写……")
	lose_text = span_notice("你突然想起了如何读写。")

/datum/brain_trauma/severe/dyslexia/on_gain()
	ADD_TRAIT(owner, TRAIT_ILLITERATE, TRAUMA_TRAIT)
	. = ..()

/datum/brain_trauma/severe/dyslexia/on_lose()
	REMOVE_TRAIT(owner, TRAIT_ILLITERATE, TRAUMA_TRAIT)
	..()

/datum/brain_trauma/severe/kleptomaniac
	name = "盗窃癖"
	desc = "患者容易产生偷东西的行为。"
	scan_desc = "盗窃癖"
	symptoms = "无法控制偷取附近物品的冲动，通常并无需求或理由，\
		导致可能影响日常生活和社交的强迫性盗窃行为。"
	gain_text = span_warning("你突然很想把那个东西拿走。肯定没人会注意到。")
	lose_text = span_notice("你不再有顺走东西的冲动了。")
	/// Cooldown between allowing steal attempts
	COOLDOWN_DECLARE(steal_cd)

/datum/brain_trauma/severe/kleptomaniac/on_gain()
	. = ..()
	RegisterSignal(owner, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(damage_taken))

/datum/brain_trauma/severe/kleptomaniac/on_lose()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOB_APPLY_DAMAGE)

/datum/brain_trauma/severe/kleptomaniac/proc/damage_taken(datum/source, damage_amount, damage_type, ...)
	SIGNAL_HANDLER
	// While you're fighting someone (or dying horribly) your mind has more important things to focus on than pocketing stuff
	if(damage_amount >= 5 && (damage_type == BRUTE || damage_type == BURN || damage_type == STAMINA))
		COOLDOWN_START(src, steal_cd, 12 SECONDS)

/datum/brain_trauma/severe/kleptomaniac/on_life(seconds_per_tick)
	if(owner.usable_hands <= 0)
		return
	if(!SPT_PROB(5, seconds_per_tick))
		return
	if(!COOLDOWN_FINISHED(src, steal_cd))
		return
	if(!owner.has_active_hand() || !owner.get_empty_held_indexes())
		return

	// If our main hand is full, that means our offhand is empty, so try stealing with that
	var/steal_to_offhand = !!owner.get_active_held_item()
	var/curr_index = owner.active_hand_index
	var/pre_dir = owner.dir
	if(steal_to_offhand)
		owner.swap_hand(owner.get_inactive_hand_index())

	var/list/stealables = list()
	for(var/obj/item/potential_stealable in oview(1, owner))
		if(potential_stealable.w_class >= WEIGHT_CLASS_BULKY)
			continue
		if(potential_stealable.anchored || !(potential_stealable.interaction_flags_item & INTERACT_ITEM_ATTACK_HAND_PICKUP))
			continue
		stealables += potential_stealable

	for(var/obj/item/stealable as anything in shuffle(stealables))
		if(!stealable.IsReachableBy(owner) || stealable.IsObscured())
			continue
		// Try to do a raw click on the item with one of our empty hands, to pick it up (duh)
		owner.log_message("attempted to pick up (kleptomania)", LOG_ATTACK, color = "orange")
		owner.ClickOn(stealable)
		// No feedback message. Intentional, you may not even realize you picked up something
		break

	if(steal_to_offhand)
		owner.swap_hand(curr_index)
	owner.setDir(pre_dir)
	// Gives you a small buffer - not to avoid spam, but to make it more subtle / less predictable
	COOLDOWN_START(src, steal_cd, 8 SECONDS)
