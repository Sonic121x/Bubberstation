/*
*	BIMBO
*/

/datum/brain_trauma
	///Whether the trauma will be displayed on a scanner or kiosk
	var/display_scanner = TRUE

/datum/brain_trauma/very_special
	abstract_type = /datum/brain_trauma/very_special

/datum/brain_trauma/very_special/bimbo
	name = "永久性激素紊乱"
	desc = "患者完全丧失了组织语言的能力，并表现出极度的性兴奋。"
	scan_desc = "永久性激素紊乱"
	gain_text = span_purple("你的思绪变得混沌，却让你欲火焚身。")
	lose_text = span_warning("舒适的凉意蔓延全身，你又能清晰地思考了。")
	//people need to be able to gain it through the chemical OD
	can_gain = TRUE
	//people should not be able to randomly get this trauma
	random_gain = FALSE
	//we don't want this to be displayed on a scanner
	display_scanner = FALSE
	resilience = TRAUMA_RESILIENCE_LOBOTOMY
	///how satisfied the person is, gained through climaxing
	//max is 300, min is 0
	var/satisfaction = 300
	///how stressed the person is, gained through zero satisfaction
	//max is 300, min is 0
	var/stress = 0

	COOLDOWN_DECLARE(desire_cooldown)
	///The time between each desire message within company
	var/desire_cooldown_number = 30 SECONDS
	///The list of manual emotes that will be done when unsatisfied
	var/static/list/lust_emotes = list(
		"喘息着，身体微微颤抖。",
		"轻轻上下抚摸自己，感受每一寸肌肤。",
		"将手指放进嘴里，轻轻咬住。",
		"双手扶着臀部，缓缓扭动。",
		"微微歪头，发出呻吟。"
	)

/**
 * If we are not satisfied, this will be ran through
 */
/datum/brain_trauma/very_special/bimbo/proc/try_unsatisfied()
	var/mob/living/carbon/human/human_owner = owner
	//we definitely need an owner; but if you are satisfied, just return
	if(satisfaction || !human_owner)
		return FALSE
	//we need to feel consequences for being unsatisfied
	//the message that will be sent to the owner at the end
	var/lust_message = "你的呼吸开始变得灼热……"
	//we are using if statements so that it slowly becomes more and more to the person
	human_owner.manual_emote(pick(lust_emotes))
	if(stress >= 60)
		human_owner.set_jitter_if_lower(40 SECONDS)
		lust_message = "你的全身肌肤泛起一阵静电般的酥麻……"
	if(stress >= 120)
		human_owner.set_eye_blur_if_lower(20 SECONDS)
		lust_message = "你的视线开始模糊，体内的热度不断攀升……"
	if(stress >= 180)
		owner.adjust_hallucinations(60 SECONDS)
		lust_message = "你开始幻想能对别人做些什么……"
	if(stress >= 240)
		human_owner.adjust_stamina_loss(30)
		lust_message = "你的身体烫得厉害，几乎不愿听从使唤……"
	if(stress >= 300)
		human_owner.adjust_oxy_loss(40)
		lust_message = "你感到脖子绷紧，越发紧绷……"
	to_chat(human_owner, span_purple(lust_message))
	return TRUE

/**
 * If we have climaxed, return true
 */
/datum/brain_trauma/very_special/bimbo/proc/check_climaxed()
	if(owner.has_status_effect(/datum/status_effect/climax))
		stress = 0
		satisfaction = 300
		return TRUE
	return FALSE

/datum/brain_trauma/very_special/bimbo/on_life()
	var/mob/living/carbon/human/human_owner = owner

	//Check if we climaxed, if so, just stop for now
	if(check_climaxed())
		return
	//if we are satisfied, slowly lower satisfaction as well as stress
	if(satisfaction)
		satisfaction = clamp(satisfaction - 1, 0, 300)
		stress = clamp(stress - 1, 0, 300)
	//since we are not satisfied, increase our stress
	else
		stress = clamp(stress + 1, 0, 300)

	human_owner.adjust_arousal(10)
	if(human_owner.pleasure < 80)
		human_owner.adjust_pleasure(5)

	//Anything beyond this obeys a cooldown system because we don't want to spam it
	if(!COOLDOWN_FINISHED(src, desire_cooldown))
		return
	COOLDOWN_START(src, desire_cooldown, desire_cooldown_number)

	//if we are unsatisfied, do this code block and then stop
	if(try_unsatisfied())
		return

	//Anything beyond this requires company
	if(!in_company())
		//since you aren't within company, you won't be satisfied
		satisfaction = clamp(satisfaction - 1, 0, 1000)
		to_chat(human_owner, span_purple("身边没有人，让你感到好孤独……"))
		return

	switch(satisfaction)
		if(0 to 100)
			to_chat(human_owner, span_purple("你再也受不了了，现在就需要一个伴侣！"))
		if(101 to 150)
			to_chat(human_owner, span_purple("你想和那人来一场。没错，至少能打六分。"))
		if(151 to 200)
			to_chat(human_owner, span_purple("你的衣服感觉越来越紧。"))
		if(201 to 250)
			to_chat(human_owner, span_purple("欲望蒙蔽了你的判断。"))
		if(251 to 1000)
			to_chat(human_owner, span_purple("天哪，这里真热……"))

/**
 * If we have another human in view, return true
 */
/datum/brain_trauma/very_special/bimbo/proc/in_company()
	for(var/mob/living/carbon/human/human_check in oview(owner, 4))
		if(!istype(human_check))
			continue
		return TRUE
	return FALSE

/datum/brain_trauma/very_special/bimbo/handle_speech(datum/source, list/speech_args)
	if(!HAS_TRAIT(owner, TRAIT_BIMBO)) //You have the trauma but not the trait, go ahead and fail here
		return ..()
	var/message = speech_args[SPEECH_MESSAGE]
	var/list/split_message = splittext(message, " ") //List each word in the message
	for (var/i in 1 to length(split_message))
		if(findtext(split_message[i], "*") || findtext(split_message[i], ";") || findtext(split_message[i], ":"))
			continue
		if(prob(10))
			var/insert_muffle = pick("... Mmmph...", "... Hmmphh...", "... Gmmmh...", "... Fmmmmph...")
			split_message[i] = split_message[i] + insert_muffle

	message = jointext(split_message, " ")
	speech_args[SPEECH_MESSAGE] = message

/datum/brain_trauma/very_special/bimbo/on_gain()
	. = ..()
	owner.add_mood_event("bimbo", /datum/mood_event/bimbo)
	if(!HAS_TRAIT_FROM(owner, TRAIT_BIMBO, TRAIT_LEWDCHEM))
		ADD_TRAIT(owner, TRAIT_BIMBO, TRAIT_LEWDCHEM)
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech), override=TRUE)
	if(!HAS_TRAIT_FROM(owner, TRAIT_MASOCHISM, TRAIT_APHRO))
		ADD_TRAIT(owner, TRAIT_MASOCHISM, TRAIT_APHRO)

/datum/brain_trauma/very_special/bimbo/on_lose()
	. = ..()
	owner.clear_mood_event("bimbo")
	if(HAS_TRAIT_FROM(owner, TRAIT_BIMBO, TRAIT_LEWDCHEM))
		REMOVE_TRAIT(owner, TRAIT_BIMBO, TRAIT_LEWDCHEM)
	UnregisterSignal(owner, COMSIG_MOB_SAY)
	if(HAS_TRAIT_FROM(owner, TRAIT_MASOCHISM, TRAIT_APHRO))
		REMOVE_TRAIT(owner, TRAIT_MASOCHISM, TRAIT_APHRO)

//Mood boost
/datum/mood_event/bimbo
	description = span_purple("好……无助……太喜欢了！\n")

/*
*	MASOCHISM
*/

/datum/quirk
	/// Is this a quirk disabled by disabling the ERP config?
	var/erp_quirk = FALSE

/datum/quirk/masochism
	name = "Masochism"
	desc = "疼痛会给你带来难以言喻的快感。"
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_MASOCHISM
	gain_text = span_danger("你突然渴望感受疼痛……")
	lose_text = span_notice("哎哟！疼痛又……只剩下疼了！好痛！")
	medical_record_text = "受检者有受虐倾向。"
	icon = FA_ICON_HEART_BROKEN
	erp_quirk = TRUE

/datum/quirk/masochism/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	ADD_TRAIT(affected_human, TRAIT_MASOCHISM, TRAIT_LEWDQUIRK)
	affected_human.pain_limit = 60

/datum/quirk/masochism/remove()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	REMOVE_TRAIT(affected_human, TRAIT_MASOCHISM, TRAIT_LEWDQUIRK)
	affected_human.pain_limit = 0

/*
*	NEVERBONER
*/

/datum/brain_trauma/very_special/neverboner
	name = "性欲丧失"
	desc = "患者完全丧失了性兴趣。"
	scan_desc = "性欲缺失"
	gain_text = span_notice("你不再感到性欲。")
	lose_text = span_notice("舒适的暖意蔓延全身。")
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_ABSOLUTE

/datum/brain_trauma/very_special/neverboner/on_gain()
	. = ..()
	var/mob/living/carbon/human/affected_human = owner
	ADD_TRAIT(affected_human, TRAIT_NEVERBONER, TRAIT_APHRO)

/datum/brain_trauma/very_special/neverboner/on_lose()
	. = ..()
	var/mob/living/carbon/human/affected_human = owner
	REMOVE_TRAIT(affected_human, TRAIT_NEVERBONER, TRAIT_APHRO)

/*
*	SADISM
*/

/datum/quirk/sadism
	name = "Sadism"
	desc = "看到别人痛苦会令你愉悦。"
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_SADISM
	gain_text = span_danger("你突然想让别人感到疼痛。")
	lose_text = span_notice("他人的痛苦不再能满足你。")
	medical_record_text = "受检者有施虐倾向。"
	icon = FA_ICON_HAMMER
	erp_quirk = TRUE

/datum/quirk/sadism/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	affected_human.gain_trauma(/datum/brain_trauma/very_special/sadism, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/sadism/remove()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	affected_human?.cure_trauma_type(/datum/brain_trauma/very_special/sadism, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/brain_trauma/very_special/sadism
	name = "施虐倾向"
	desc = "他人受苦时，受检者的大脑快感中枢更为活跃。"
	scan_desc = "施虐倾向"
	gain_text = span_purple("你想伤害别人。")
	lose_text = span_notice("你又能感到同情了。")
	can_gain = TRUE
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_ABSOLUTE

/datum/brain_trauma/very_special/sadism/on_life(seconds_per_tick, times_fired)
	var/mob/living/carbon/human/affected_mob = owner
	if(!owner.has_status_effect(/datum/status_effect/climax_cooldown) && affected_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp) && someone_suffering())
		affected_mob.adjust_arousal(2)
		owner.add_mood_event("sadistic", /datum/mood_event/sadistic)
	else
		owner.clear_mood_event("sadistic")

/datum/brain_trauma/very_special/sadism/proc/someone_suffering()
	if(owner.is_blind())
		return FALSE
	for(var/mob/living/carbon/human/iterated_mob in oview(owner, 4))
		if(!isliving(iterated_mob)) //ghosts ain't people
			continue
		if(!istype(iterated_mob)) //only count mobs of type mob/living/human/...
			continue
		if(iterated_mob.stat == DEAD) //don't count dead targets either
			continue
		if(iterated_mob.pain >= 10)
			return TRUE
	return FALSE

//Shibari update quirks: Rope bunny and rigger. One have additional mood bonus (0) and exist for same reason as ananas affinity, other one can faster tie ropes on character because why not.
//Rope bunny code
/datum/quirk/ropebunny
	name = "Rope bunny"
	desc = "你喜欢被捆绑。"
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_ROPEBUNNY
	medical_record_text = "受检者喜爱束缚。"
	gain_text = span_danger("不知为何，你非常想被束缚起来。")
	lose_text = span_notice("被束缚不再让你兴奋。")
	icon = FA_ICON_HANDCUFFS
	erp_quirk = TRUE

/datum/quirk/ropebunny/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	ADD_TRAIT(affected_mob, TRAIT_ROPEBUNNY, TRAIT_LEWDQUIRK)

/datum/quirk/ropebunny/remove()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	REMOVE_TRAIT(affected_mob, TRAIT_ROPEBUNNY, TRAIT_LEWDQUIRK)

//Rigger code
/datum/quirk/rigger
	name = "Rigger"
	desc = "你觉得在身体上编织绳结是一件美妙的事。"
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_RIGGER
	medical_record_text = "受检者打绳结时格外灵巧。"
	gain_text = span_danger("你突然对编织绳结有了远胜以往的理解。")
	lose_text = span_notice("绳结又变得复杂难懂了。")
	icon = FA_ICON_CHAIN_BROKEN
	erp_quirk = TRUE

/datum/quirk/rigger/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	ADD_TRAIT(affected_mob, TRAIT_RIGGER, TRAIT_LEWDQUIRK)

/datum/quirk/rigger/remove()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	REMOVE_TRAIT(affected_mob, TRAIT_RIGGER, TRAIT_LEWDQUIRK)
/datum/mood_event/sadistic
	description = span_purple("别人的痛苦让我更加快乐。\n")

/*
*	EMPATH BONUS
*/

/// Used in the empathy component
/mob/living/carbon/human/proc/get_arousal_info()
	switch(arousal)
		if(AROUSAL_MINIMUM_DETECTABLE to AROUSAL_LOW)
			return span_purple("其脸颊微微泛红。")
		if(AROUSAL_LOW to AROUSAL_MEDIUM)
			return span_purple("其相当兴奋，脑中似乎翻腾着情色的念头。")
		if(AROUSAL_HIGH to AROUSAL_AUTO_CLIMAX_THRESHOLD)
			return span_purple("其已经欲火焚身。")
		if(AROUSAL_AUTO_CLIMAX_THRESHOLD to INFINITY)
			return span_purple("其极度兴奋，无法忍受的欲望让其精疲力尽。")
