/mob/living/basic/pet/poppy
	name = "安全检查员波比"
	desc = "安全第一！"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "poppypossum"
	icon_living = "poppypossum"
	icon_dead = "poppypossum_dead"
	gender = FEMALE
	unique_pet = TRUE
	maxHealth = 30
	health = 30
	speak_emote = list("嘶嘶")
	/// Is the inspection currently being passed?
	var/safety_inspection = TRUE
	/// Are they scared already?
	var/upset = FALSE
	/// Are they near the supermatter?
	var/near_engine = FALSE
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	response_harm_continuous = "踩踏"
	response_harm_simple = "踩踏"
	density = FALSE
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = NO_SPAWN
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_color = LIGHT_COLOR_BRIGHT_YELLOW
	light_range = 2
	light_power = 0.8
	light_on = TRUE
	ai_controller = /datum/ai_controller/basic_controller/poppy

/datum/ai_controller/basic_controller/poppy
	behavior_tree_json = "modular_skyrat/master_files/code/modules/mob/living/simple_animal/friendly/poppy.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_traits = STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance

/datum/bt_node/ai_behavior/random_speech/poppy
	speak = list("嘶！", "嘶——！", "嘶嘶嘶？")
	emote_hear = list("发出嘶嘶声。")
	emote_see = list("绕圈跑动。", "抖动身体。")
	speech_chance = 1

/mob/living/basic/pet/poppy/Initialize(mapload)
	. = ..()
	add_verb(src, /mob/living/proc/toggle_resting)
	become_area_sensitive(INNATE_TRAIT)

	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	RegisterSignal(src, COMSIG_ENTER_AREA, PROC_REF(check_area))

	qdel(GetComponent(/datum/component/butchering))

	var/datum/component/overlay_lighting/lighting_object = src.GetComponent(/datum/component/overlay_lighting)
	var/image/cone = lighting_object.cone
	cone.transform = cone.transform.Translate(0, -16) // adjust the little headlamp

/mob/living/basic/pet/poppy/death()
	lose_area_sensitivity(INNATE_TRAIT)
	set_light_on(FALSE)

	if(safety_inspection)
		var/list/sm_chamber = get_area_turfs(/area/station/engineering/supermatter)
		if(src.loc in sm_chamber)
			safety_inspection = FALSE
			priority_announce("这是一条由自动信号触发的生成讯息，内容涉及 [station_name()] 上工程部的安全标准。由于本站工程师未能达到中央指挥部设定的标准，他们每人都可能被强制纳入稍后通知的再评估计划……", "关于安全检查的结果", type = "Priority")
			// It's just flavor, no tangible punishment
	return ..()

/mob/living/basic/pet/poppy/revive(full_heal_flags = NONE, excess_healing = 0, force_grab_ghost = FALSE)
	become_area_sensitive(INNATE_TRAIT)
	set_light_on(TRUE)
	..()

/mob/living/basic/pet/poppy/update_resting()
	. = ..()
	if(resting)
		icon_state = "[icon_living]_rest"
		set_light_on(FALSE)
	else
		icon_state = "[icon_living]"
		set_light_on(TRUE)
	regenerate_icons()

/mob/living/basic/pet/poppy/Life(seconds_per_tick = SSMOBS_DT, times_fired)
	if(client || stat)
		return

	if(pulledby)
		set_resting(FALSE)

	if(near_engine)
		near_engine = FALSE
		panic()

	if(!SPT_PROB(0.5, seconds_per_tick))
		return
	if(!resting)
		manual_emote(pick("发出一声嘶鸣，随后趴下休息。", "趁机歇了口气。", "发出低沉的嘶声，然后懒洋洋地趴开。", "打量了一圈四周，然后放松下来。"))
		set_resting(TRUE)
		return
	else
		manual_emote(pick("伸出爪子伸了个懒腰，站起身来……", "认真地起身，准备开始检查！", "结束了休息。"))
		set_resting(FALSE)

	return ..()

/mob/living/basic/pet/poppy/proc/check_area()
	SIGNAL_HANDLER
	if(safety_inspection && !upset)
		var/list/sm_room = get_area_turfs(/area/station/engineering/supermatter/room)
		if(src.loc in sm_room)
			near_engine = TRUE

/mob/living/basic/pet/poppy/proc/panic()
	upset = TRUE
	icon_state = "poppypossum_aaa"

	//emote("sweatdrop") - BUBBER TODO - Make this not lint
	do_jitter_animation(60)
	manual_emote("的毛发竖了起来，全身不停颤抖……")

	notify_ghosts("[src] 被超物质吓到了！",
		source = src,
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
		header = "安全检查！",
	)
	addtimer(CALLBACK(src, PROC_REF(calm_down)), 60 SECONDS)

/mob/living/basic/pet/poppy/proc/calm_down()
	upset = FALSE
	icon_state = initial(icon_state)
