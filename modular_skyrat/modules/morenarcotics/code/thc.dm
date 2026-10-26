/obj/item/food/grown/cannabis/on_grind()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_DRIED))
		reagents.clear_reagents()
		reagents.add_reagent(/datum/reagent/drug/thc/hash, 0.15 * seed.potency)
		return TRUE

/datum/chemical_reaction/hash
	required_reagents = list(/datum/reagent/drug/thc/hash = 10)
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/hash/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/reagent_containers/hash(location)

/datum/chemical_reaction/dabs
	required_reagents = list(/datum/reagent/drug/thc = 20)
	required_temp = 420 //haha very funny
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/dabs/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/reagent_containers/hash/dabs(location)

//shit for effects
/datum/mood_event/stoned
	description = span_nicegreen("你现在彻底嗨了……\n")
	mood_change = 6
	timeout = 3 MINUTES

/atom/movable/screen/alert/stoned
	name = "迷醉"
	desc = "你嗨得神志不清了！哇哦……"
	icon_state = "high"

//the reagent itself
/datum/reagent/drug/thc
	name = "四氢大麻酚（THC）"
	description = "存在于大麻中的化学物质，是其主要的精神活性成分。"
	color = "#cfa40c"
	overdose_threshold = 30 //just gives funny effects, but doesnt hurt you; thc has no actual known overdose
	ph = 6
	taste_description = "臭鼬味"

/datum/reagent/drug/thc/concentrated
	name = "浓缩四氢大麻酚"
	description = "纯净浓缩形态的四氢大麻酚。"

/datum/reagent/drug/thc/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	var/high_message = pick("你感到很放松。", "你觉得自己嗨得不行。", "你觉得自己彻底瘫软了……")
	if(M.hud_used!=null)
		var/atom/movable/plane_master_controller/game_plane_master_controller = M.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
		game_plane_master_controller.add_filter("weed_blur", 10, angular_blur_filter(0, 0, 0.45))
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(M, span_notice("[high_message]"))
	M.add_mood_event("stoned", /datum/mood_event/stoned, name)
	M.throw_alert("stoned", /atom/movable/screen/alert/stoned)
	M.sound_environment_override = SOUND_ENVIRONMENT_DRUGGED
	M.set_dizzy_if_lower(5 * REM * seconds_per_tick * 2 SECONDS)
	M.adjust_nutrition(-1 * REM * seconds_per_tick) //munchies
	if(SPT_PROB(3.5, seconds_per_tick))
		M.emote(pick("laugh","giggle"))
	..()

/datum/reagent/drug/thc/on_mob_end_metabolize(mob/living/carbon/M)
	. = ..()
	if(M.hud_used!=null)
		var/atom/movable/plane_master_controller/game_plane_master_controller = M.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
		game_plane_master_controller.remove_filter("weed_blur")
	M.clear_alert("stoned")
	M.sound_environment_override = SOUND_ENVIRONMENT_NONE

/datum/reagent/drug/thc/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	var/cg420_message = pick("这可太猛了……", "我的天哪……",)
	if(SPT_PROB(1.5, seconds_per_tick))
		M.say("[cg420_message]")
	M.adjust_drowsiness(0.2 SECONDS * REM * normalise_creation_purity() * seconds_per_tick)
	if(SPT_PROB(3.5, seconds_per_tick))
		M.emote("cough")
	..()
	. = TRUE

/datum/reagent/drug/thc/hash //only exists to generate hash object
	name = "大麻脂"
	description = "浓缩的大麻提取物，用水烟壶吸食时效果更强。"
	color = "#cfa40c"
