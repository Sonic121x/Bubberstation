/datum/religion_rites/banish_nightmare
	name = "放逐梦魇"
	desc = "将梦魇的尸体（或其心脏）放逐回它来自的地方。在守护空间站梦境的过程中，\
		你将获得恩宠。若献上心脏，你将得到一份特殊祝福。"
	favor_cost = 0
	ritual_length = 20 SECONDS

/datum/religion_rites/banish_nightmare/New()
	. = ..()
	ritual_invocations = list(
		"我们击败了可怕的梦魇，这肆虐我们空间站的灾祸！……",
		"借 [GLOB.deity] 的力量，我们将它逐出！……",
		"这个梦境的入侵者在此没有容身之地……",
		"愿它不再侵扰我们的羊群。",
	)

/datum/religion_rites/banish_nightmare/perform_rite(mob/living/user, atom/religious_tool)
	var/has_nightmare = FALSE
	for(var/mob/living/carbon/human/nightmare in get_turf(religious_tool))
		if(HAS_TRAIT(nightmare, TRAIT_NIGHTMARISH))
			has_nightmare = TRUE
			break

	for(var/obj/item/organ/organ in get_turf(religious_tool))
		if(istype(organ, /obj/item/organ/heart/nightmare))
			has_nightmare = TRUE
			break

	if(!has_nightmare)
		to_chat(user, span_warning("没有可放逐的梦魇尸体或心脏！"))
		return FALSE

	return ..()

/datum/religion_rites/banish_nightmare/post_invoke_effects(mob/living/user, atom/religious_tool)
	. = ..()
	var/favor = 0
	var/give_heart = FALSE
	for(var/mob/living/carbon/human/nightmare in get_turf(religious_tool))
		if(!HAS_TRAIT(nightmare, TRAIT_NIGHTMARISH))
			continue

		if(istype(nightmare.get_organ_slot(ORGAN_SLOT_HEART), /obj/item/organ/heart/nightmare))
			give_heart += 1
			favor += 100

		nightmare.dust(just_ash = TRUE, drop_items = TRUE, give_moodlet = FALSE, force =TRUE)
		favor += 200

	for(var/obj/item/organ/organ in get_turf(religious_tool))
		if(!istype(organ, /obj/item/organ/heart/nightmare))
			continue

		qdel(organ)
		favor += 100
		give_heart += 1

	if(favor <= 0)
		CRASH("Banish nightmare rite invoked without finding a nightmare or nightmare heart to banish.")

	GLOB.religious_sect.adjust_favor(favor, user)
	if(give_heart)
		for(var/i in 1 to give_heart)
			new /obj/item/organ/heart/evolved/sacred/dreamer(get_turf(religious_tool))
		playsound(religious_tool, 'sound/effects/pray.ogg', 50, TRUE, frequency = 0.5)
		to_chat(user, span_hypnophrase("[GLOB.deity] 祝福了你。"))
	else
		to_chat(user, span_hypnophrase("[GLOB.deity] 对你微笑。"))
	user.add_mood_event("banish_nightmare", /datum/mood_event/banish_nightmare)

/datum/mood_event/banish_nightmare
	mood_change = 4
	description = "我放逐了一个梦魇，守护了我们的梦境！"
	timeout = 10 MINUTES

/obj/item/organ/heart/evolved/sacred/dreamer
	name = "受祝福的神圣心脏"
	desc = "放逐暗影！"
	maxHealth = STANDARD_ORGAN_THRESHOLD * 1.5
	/// Magic charges we block
	var/charges = 3

/obj/item/organ/heart/evolved/sacred/dreamer/on_life(seconds_per_tick)
	healing_probability = 5
	if(HAS_TRAIT(owner, TRAIT_DREAMING))
		healing_probability += 7.5
	if(IS_UNCONSCIOUS(owner))
		healing_probability += 7.5
	return ..()

/obj/item/organ/heart/evolved/sacred/dreamer/on_blocked()
	charges -= 1
	addtimer(CALLBACK(src, PROC_REF(recharge)), 1 MINUTES)
	playsound(owner, 'sound/effects/health/slowbeat.ogg', 80)

/obj/item/organ/heart/evolved/sacred/dreamer/check_block()
	return charges > 0

/obj/item/organ/heart/evolved/sacred/dreamer/proc/recharge()
	charges += 1
