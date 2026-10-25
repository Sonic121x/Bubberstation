///Opioids
/datum/addiction/opioids
	name = "阿片类药物"
	description = "患者已对阿片类物质产生依赖。"
	symptoms = "表现出对止痛药的渴望，戒断期间会出现嗜睡、高血压和恶心。"
	withdrawal_stage_messages = list("我浑身酸痛……", "我需要点止痛的东西……", "全身都在疼……我需要阿片类药物！")

/datum/addiction/opioids/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	if(SPT_PROB(10, seconds_per_tick))
		affected_carbon.emote("yawn")

/datum/addiction/opioids/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.apply_status_effect(/datum/status_effect/high_blood_pressure)

/datum/addiction/opioids/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	if(affected_carbon.disgust < DISGUST_LEVEL_DISGUSTED && SPT_PROB(7.5, seconds_per_tick))
		affected_carbon.adjust_disgust(12.5 * seconds_per_tick)

/datum/addiction/opioids/end_withdrawal(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.remove_status_effect(/datum/status_effect/high_blood_pressure)
	affected_carbon.set_disgust(affected_carbon.disgust * 0.5) //half their disgust to help

///Stimulants

/datum/addiction/stimulants
	name = "兴奋剂"
	description = "患者已对兴奋剂物质产生依赖。"
	symptoms = "表现出对兴奋剂的渴望，戒断期间会出现疲劳、迟钝和注意力难以集中。"
	withdrawal_stage_messages = list("你感觉有点累……真需要提提神。", "你开始有点头晕……", "好……累……")

/datum/addiction/stimulants/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.add_actionspeed_modifier(/datum/actionspeed_modifier/stimulants)

/datum/addiction/stimulants/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.apply_status_effect(/datum/status_effect/woozy)

/datum/addiction/stimulants/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.add_movespeed_modifier(/datum/movespeed_modifier/stimulants)

/datum/addiction/stimulants/end_withdrawal(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.remove_actionspeed_modifier(ACTIONSPEED_ID_STIMULANTS)
	affected_carbon.remove_status_effect(/datum/status_effect/woozy)
	affected_carbon.remove_movespeed_modifier(MOVESPEED_ID_STIMULANTS)

///Alcohol
/datum/addiction/alcohol
	name = "酒精"
	description = "患者已对酒精产生依赖。"
	symptoms = "表现出对含酒精饮料的渴望，戒断期间会出现颤抖、幻觉，甚至癫痫发作。"
	withdrawal_stage_messages = list("我该喝一杯了……", "也许酒吧还开着？……", "天啊，我需要喝一杯！")

/datum/addiction/alcohol/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_jitter_if_lower(10 SECONDS * seconds_per_tick)

/datum/addiction/alcohol/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_jitter_if_lower(20 SECONDS * seconds_per_tick)
	affected_carbon.set_hallucinations_if_lower(10 SECONDS)

/datum/addiction/alcohol/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_jitter_if_lower(30 SECONDS * seconds_per_tick)
	affected_carbon.set_hallucinations_if_lower(10 SECONDS)
	if(SPT_PROB(4, seconds_per_tick) && !HAS_TRAIT(affected_carbon, TRAIT_ANTICONVULSANT))
		affected_carbon.apply_status_effect(/datum/status_effect/seizure)

/datum/addiction/hallucinogens
	name = "致幻剂"
	description = "患者已对致幻物质产生依赖。"
	symptoms = "表现出对致幻剂的渴望，戒断期间会感到空虚、视力困难以及与现实的脱节。"
	withdrawal_stage_messages = list("我感到好空虚……", "不知道机器精灵们在忙什么？……", "我需要再次看到那些美丽的颜色！！")

/datum/addiction/hallucinogens/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	var/atom/movable/plane_master_controller/game_plane_master_controller = affected_carbon.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.add_filter("hallucinogen_blur", 10, angular_blur_filter(0, 0, 3))
	game_plane_master_controller.add_filter("hallucinogen_wave", 10, wave_filter(300, 300, 3, 0, WAVE_SIDEWAYS))


/datum/addiction/hallucinogens/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.apply_status_effect(/datum/status_effect/trance, 40 SECONDS, TRUE)

/datum/addiction/hallucinogens/end_withdrawal(mob/living/carbon/affected_carbon)
	. = ..()
	var/atom/movable/plane_master_controller/game_plane_master_controller = affected_carbon.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.remove_filter("hallucinogen_blur")
	game_plane_master_controller.remove_filter("hallucinogen_wave")
	affected_carbon.remove_status_effect(/datum/status_effect/trance, 40 SECONDS, TRUE)

/datum/addiction/maintenance_drugs
	name = "维护区药物"
	description = "患者已对维护区药物产生依赖。"
	symptoms = "表现出对维护区药物的渴望，戒断期间会出现各种适应性变化，\
		例如畏光、麻木、味觉改变、毛发加速生长以及更强的暗视能力。"
	withdrawal_stage_messages = list("", "", "")

/datum/addiction/maintenance_drugs/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

/datum/addiction/maintenance_drugs/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	if(SPT_PROB(7.5, seconds_per_tick))
		affected_carbon.emote("growls")

/datum/addiction/maintenance_drugs/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	if(!ishuman(affected_carbon))
		return
	var/mob/living/carbon/human/affected_human = affected_carbon
	if(affected_human.gender == MALE)
		to_chat(affected_human, span_warning("你的下巴发痒。"))
		affected_human.set_facial_hairstyle("Beard (Full)", update = TRUE)
	//Only like gross food
	var/obj/item/organ/tongue/tongue = affected_carbon.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.liked_foodtypes = GROSS
	tongue.disliked_foodtypes = NONE
	tongue.toxic_foodtypes = ~GROSS

/datum/addiction/maintenance_drugs/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	if(!ishuman(affected_carbon))
		return
	to_chat(affected_carbon, span_warning("你感觉自己适应了黑暗。"))
	ADD_TRAIT(affected_carbon, TRAIT_NIGHT_VISION, type)

/datum/addiction/maintenance_drugs/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	if(!ishuman(affected_carbon))
		return
	var/mob/living/carbon/human/affected_human = affected_carbon
	var/turf/T = get_turf(affected_human)
	if(T.check_lumcount_above(0.5))
		affected_human.add_mood_event("too_bright", /datum/mood_event/bright_light)
		affected_human.adjust_dizzy_up_to(6 SECONDS, 80 SECONDS)
		affected_human.adjust_confusion_up_to(0.5 SECONDS * seconds_per_tick, 20 SECONDS)
	else
		affected_carbon.clear_mood_event("too_bright")

/datum/addiction/maintenance_drugs/end_withdrawal(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)
	//restore tongue's tastes
	var/obj/item/organ/tongue/tongue = affected_carbon.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(tongue)
		tongue.liked_foodtypes = initial(tongue.liked_foodtypes)
		tongue.disliked_foodtypes = initial(tongue.disliked_foodtypes)
		tongue.toxic_foodtypes = initial(tongue.toxic_foodtypes)
	REMOVE_TRAIT(affected_carbon, TRAIT_NIGHT_VISION, type)

///Makes you a hypochondriac - I'd like to call it hypochondria, but "I could use some hypochondria" doesn't work
/datum/addiction/medicine
	name = "药物"
	description = "患者已对药物产生依赖，类似于疑病症。"
	symptoms = "在身体健康的情况下仍表现出对药物的需求，戒断期间\
		会出现阵发性咳嗽、幻觉和扭曲的健康感知。"
	withdrawal_stage_messages = list("", "", "")
	/// Weakref to the "fake alert" hallucination we're giving to the addicted
	var/datum/weakref/fake_alert_ref
	/// Weakref to the "health doll screwup" hallucination we're giving to the addicted
	var/datum/weakref/health_doll_ref

/datum/addiction/medicine/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon)
	. = ..()
	if(!ishuman(affected_carbon))
		return
	var/datum/hallucination/health_doll = affected_carbon.cause_hallucination( \
		/datum/hallucination/fake_health_doll, \
		"药物成瘾", \
		severity = 1, \
		duration = 120 MINUTES, \
	)
	if(!health_doll)
		return
	health_doll_ref = WEAKREF(health_doll)

/datum/addiction/medicine/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	if(SPT_PROB(1, seconds_per_tick))
		affected_carbon.emote("cough")

/datum/addiction/medicine/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	var/list/possibilities = list()

	if(!HAS_TRAIT(affected_carbon, TRAIT_RESISTHEAT))
		possibilities += /datum/hallucination/fake_alert/hot
	if(!HAS_TRAIT(affected_carbon, TRAIT_RESISTCOLD))
		possibilities += /datum/hallucination/fake_alert/cold

	var/obj/item/organ/lungs/lungs = affected_carbon.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(lungs)
		if(lungs.safe_oxygen_min)
			possibilities += /datum/hallucination/fake_alert/need_oxygen
		if(lungs.safe_oxygen_max)
			possibilities += /datum/hallucination/fake_alert/bad_oxygen

	if(!length(possibilities))
		return

	var/datum/hallucination/fake_alert = affected_carbon.cause_hallucination( \
		pick(possibilities), \
		"药物成瘾", \
		duration = 120 MINUTES, \
	)
	if(!fake_alert)
		return
	fake_alert_ref = WEAKREF(fake_alert)

/datum/addiction/medicine/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	if(SPT_PROB(2, seconds_per_tick))
		affected_carbon.emote("cough")

	var/datum/hallucination/fake_health_doll/hallucination = health_doll_ref?.resolve()
	if(QDELETED(hallucination))
		health_doll_ref = null
		return

	if(SPT_PROB(10, seconds_per_tick))
		hallucination.add_fake_limb(severity = 1)
		return

	if(SPT_PROB(5, seconds_per_tick))
		hallucination.increment_fake_damage()
		return

/datum/addiction/medicine/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_crit, type)

/datum/addiction/medicine/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	if(SPT_PROB(5, seconds_per_tick))
		affected_carbon.emote("cough")

	var/datum/hallucination/fake_health_doll/hallucination = health_doll_ref?.resolve()
	if(!QDELETED(hallucination) && SPT_PROB(5, seconds_per_tick))
		hallucination.increment_fake_damage()
		return

	if(SPT_PROB(65, seconds_per_tick))
		return

	if(IS_UNCONSCIOUS_OR_CRIT(affected_carbon))
		return

	var/obj/item/organ/organ = pick(affected_carbon.organs)
	if(organ.low_threshold)
		to_chat(affected_carbon, organ.low_threshold_passed)
		return

	else if (organ.high_threshold_passed)
		to_chat(affected_carbon, organ.high_threshold_passed)
		return

	to_chat(affected_carbon, span_warning("你感到 [organ.name] 里有一阵隐痛。"))

/datum/addiction/medicine/end_withdrawal(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_crit, type)
	QDEL_NULL(fake_alert_ref)
	QDEL_NULL(health_doll_ref)

/* SKYRAT EDIT REMOVAL START - MOVED TO MODULAR.
///Nicotine
/datum/addiction/nicotine
	name = "nicotine"
	description = "Patient has developed a dependence on nicotine."
	symptoms = "Expresses a desire for nicotine products, and when in withdrawal, experiences jitteriness, coughing, and difficulty concentrating."
	addiction_relief_treshold = MIN_NICOTINE_ADDICTION_REAGENT_AMOUNT //much less because your intake is probably from ciggies
	withdrawal_stage_messages = list("Feel like having a smoke...", "Getting antsy. Really need a smoke now.", "I can't take it! Need a smoke NOW!")

	medium_withdrawal_moodlet = /datum/mood_event/nicotine_withdrawal_moderate
	severe_withdrawal_moodlet = /datum/mood_event/nicotine_withdrawal_severe

/datum/addiction/nicotine/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_jitter_if_lower(10 SECONDS * seconds_per_tick)

/datum/addiction/nicotine/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_jitter_if_lower(20 SECONDS * seconds_per_tick)
	if(SPT_PROB(2, seconds_per_tick))
		affected_carbon.emote("cough")

/datum/addiction/nicotine/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_jitter_if_lower(30 SECONDS * seconds_per_tick)
	if(SPT_PROB(5, seconds_per_tick))
		affected_carbon.emote("cough")
*/ // SKYRAT EDIT REMOVAL END
