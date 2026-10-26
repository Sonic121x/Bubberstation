/datum/chemical_reaction/quaalude
	results = list(/datum/reagent/drug/quaalude = 4)
	required_reagents = list(/datum/reagent/consumable/lemonjuice = 2, /datum/reagent/hydrogen = 1, /datum/reagent/chlorine = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG


/datum/reagent/drug/quaalude
	name = "安眠酮"
	description = "使使用者放松，陷入迷醉的催眠状态。布鲁克林孩子们最爱的药物。" //THAT WAS THE BEST FUCKIN DRUG EVER MADE
	color = "#ffe669"
	overdose_threshold = 20
	ph = 8
	taste_description = "柠檬"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED


/datum/reagent/drug/quaalude/on_mob_metabolize(mob/living/carbon/affected_carbon)
	. = ..()
	if(affected_carbon.hud_used)
		var/atom/movable/plane_master_controller/game_plane_master_controller = affected_carbon.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
		game_plane_master_controller.add_filter("quaalude_wave", 10, wave_filter(300, 300, 3, 0, WAVE_SIDEWAYS))


/datum/reagent/drug/quaalude/on_mob_life(mob/living/carbon/affected_carbon, seconds_per_tick, times_fired)
	if(SPT_PROB(2.5, seconds_per_tick))
		var/high_message = pick("你感到很放松。", "你觉得自己飘到了月球上。", "你觉得自己能为一片安眠酮走二十英里。")
		to_chat(affected_carbon, span_notice(high_message))

	affected_carbon.set_drugginess(1 MINUTES * REM * seconds_per_tick)
	affected_carbon.adjust_slurring_up_to(30 SECONDS, 2 MINUTES)
	affected_carbon.set_dizzy_if_lower(5 * REM * seconds_per_tick * 2 SECONDS)
	affected_carbon.adjust_stamina_loss(-5 * REM * seconds_per_tick, 0)

	if(SPT_PROB(3.5, seconds_per_tick))
		affected_carbon.emote(pick("laugh", "drool"))

	if(SPT_PROB(1, seconds_per_tick) && !HAS_TRAIT(affected_carbon, TRAIT_FLOORED))
		affected_carbon.visible_message(span_danger("[affected_carbon]双腿发软，连自己的体重都撑不住了！"))
		affected_carbon.Knockdown(90, TRUE)
		affected_carbon.drop_all_held_items()

	return ..()


/datum/reagent/drug/quaalude/on_mob_end_metabolize(mob/living/carbon/affected_carbon)
	. = ..()
	if(affected_carbon.hud_used != null)
		var/atom/movable/plane_master_controller/game_plane_master_controller = affected_carbon.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
		game_plane_master_controller.remove_filter("quaalude_wave")


/datum/reagent/drug/quaalude/overdose_process(mob/living/affected_carbon, seconds_per_tick, times_fired)
	var/kidfrombrooklyn_message = pick("把他妈的安眠酮还回来！", "告诉你，我能为一片安眠酮走二十英里！", "没什么比他妈的安眠酮更棒了！")

	if(SPT_PROB(1.5, seconds_per_tick))
		affected_carbon.say(kidfrombrooklyn_message)

	affected_carbon.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.25 * REM * seconds_per_tick)
	affected_carbon.adjust_tox_loss(0.25 * REM * seconds_per_tick, 0)
	affected_carbon.adjust_drowsiness(0.5 SECONDS * REM * normalise_creation_purity() * seconds_per_tick)

	if(SPT_PROB(3.5, seconds_per_tick))
		affected_carbon.emote("twitch")

	return TRUE
