/datum/brain_trauma/hypnosis
	name = "催眠"
	desc = "患者的潜意识完全受某个词语或句子支配，思想和行动都围绕着它。"
	scan_desc = "循环思维模式"
	symptoms = "执着于某个特定词语或短句。这种执着可能改变其行为，\
		例如优先采取与该短句有关的行动，而忽略工作、自身需求或社交。"
	gain_text = ""
	lose_text = ""
	resilience = TRAUMA_RESILIENCE_SURGERY
	/// Associated antag datum, used for displaying objectives and antag hud
	var/datum/antagonist/hypnotized/antagonist
	var/hypnotic_phrase = ""
	var/regex/target_phrase

/datum/brain_trauma/hypnosis/New(phrase)
	if(!phrase)
		qdel(src)
		return
	hypnotic_phrase = phrase
	try
		target_phrase = new("(\\b[REGEX_QUOTE(hypnotic_phrase)]\\b)","ig")
	catch(var/exception/e)
		stack_trace("[e] on [e.file]:[e.line]")
		qdel(src)
	..()

/datum/brain_trauma/hypnosis/on_gain()
	message_admins("[ADMIN_LOOKUPFLW(owner)]被短句“[hypnotic_phrase]”催眠了。")
	owner.log_message("was hypnotized with the phrase '[hypnotic_phrase]'.", LOG_GAME)
	to_chat(owner, span_reallybig(span_hypnophrase("[hypnotic_phrase]")))
	to_chat(owner, span_notice("[pick(list(
			"不知为何，这些话听起来……很有道理。你觉得自己应该照做。",
			"这些话在你脑海中不断回响。你完全被它们吸引住了。",
			"你感觉脑海中的一部分在反复念着这些话。你必须照做。",
			"你感觉自己的思绪都集中到了这句话上……似乎怎么也挥之不去。",
			"你的头很痛，但脑中只有这句话。它一定至关重要。",
	))]"))
	to_chat(owner, span_boldwarning("你已被这句话催眠。你必须遵从这些话。\
		如果它不是明确的命令，你可以自行解释具体做法，但必须将这些话视为最高优先事项。"))
	var/atom/movable/screen/alert/hypnosis/hypno_alert = owner.throw_alert(ALERT_HYPNOSIS, /atom/movable/screen/alert/hypnosis)
	owner.mind.add_antag_datum(/datum/antagonist/hypnotized)
	antagonist = owner.mind.has_antag_datum(/datum/antagonist/hypnotized)
	antagonist.trauma = src

	// Add the phrase to objectives
	var/datum/objective/fixation = new ()
	fixation.explanation_text = hypnotic_phrase
	fixation.completed = TRUE
	antagonist.objectives = list(fixation)

	hypno_alert.desc = "\"[hypnotic_phrase]\"……你的思绪似乎执着于这个念头。"
	. = ..()

/datum/brain_trauma/hypnosis/on_lose()
	message_admins("[ADMIN_LOOKUPFLW(owner)]不再受短句“[hypnotic_phrase]”催眠。")
	owner.log_message("is no longer hypnotized with the phrase '[hypnotic_phrase]'.", LOG_GAME)
	to_chat(owner, span_userdanger("你突然从催眠中清醒过来。“[hypnotic_phrase]”这句话对你而言不再重要了。"))
	owner.clear_alert(ALERT_HYPNOSIS)
	..()
	if (!isnull(antagonist))
		antagonist.trauma = null
	owner.mind.remove_antag_datum(/datum/antagonist/hypnotized)
	antagonist = null

/datum/brain_trauma/hypnosis/on_life(seconds_per_tick)
	..()
	if(SPT_PROB(1, seconds_per_tick))
		if(prob(50))
			to_chat(owner, span_hypnophrase("<i>...[LOWER_TEXT(hypnotic_phrase)]...</i>"))
		else
			owner.cause_hallucination( \
				/datum/hallucination/chat, \
				"hypnosis", \
				force_radio = TRUE, \
				specific_message = span_hypnophrase("[hypnotic_phrase]"), \
			)

/datum/brain_trauma/hypnosis/handle_hearing(datum/source, list/hearing_args)
	if(HAS_TRAIT(owner, TRAIT_DEAF) || owner == hearing_args[HEARING_SPEAKER])
		return
	hearing_args[HEARING_RAW_MESSAGE] = target_phrase.Replace(hearing_args[HEARING_RAW_MESSAGE], span_hypnophrase("$1"))
