/mob/living/basic/sheep
	name = "绵羊"
	desc = "以柔软的羊毛和祭祀用途闻名。草的忠实爱好者。"
	icon = 'icons/mob/simple/sheep.dmi'
	icon_state = "sheep"
	icon_dead = "sheep_dead"
	base_icon_state = "sheep"
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC | MOB_BEAST
	speak_emote = list("咩咩叫","咩叫")
	speed = 1.1
	butcher_results = list(/obj/item/food/meat/slab/grassfed = 3)
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	response_harm_continuous = "踢"
	response_harm_simple = "踢"
	attack_verb_continuous = "踢"
	attack_verb_simple = "踢"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	attack_vis_effect = ATTACK_EFFECT_KICK
	health = 50
	maxHealth = 50
	gold_core_spawnable = FRIENDLY_SPAWN
	default_blood_volume = BLOOD_VOLUME_NORMAL
	ai_controller = /datum/ai_controller/basic_controller/sheep

	/// Were we sacrificed by cultists?
	var/cult_converted = FALSE

/mob/living/basic/sheep/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/mob_harvest, \
		harvest_tool = /obj/item/razor, \
		fed_item = /obj/item/food/grown/grass, \
		produced_item_typepath = /obj/item/stack/sheet/cotton/wool, \
		produced_item_desc = "柔软羊毛", \
		max_ready = 10, \
		item_generation_wait = 3 MINUTES, \
		item_reduction_time = 30 SECONDS, \
		item_harvest_time = 5 SECONDS, \
		item_harvest_sound = 'sound/items/handling/surgery/scalpel1.ogg', \
	)
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_SHEEP, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
	RegisterSignal(src, COMSIG_LIVING_CULT_SACRIFICED, PROC_REF(on_sacrificed))

/mob/living/basic/sheep/update_overlays()
	. = ..()
	if(stat == DEAD)
		return
	if(cult_converted)
		. += "hat"

/// Signal proc for [COMSIG_LIVING_CULT_SACRIFICED] to have special interaction with sacrificing a lamb
/mob/living/basic/sheep/proc/on_sacrificed(datum/source, list/invokers)
	SIGNAL_HANDLER

	if(cult_converted)
		for(var/mob/living/cultist as anything in invokers)
			to_chat(cultist, span_cult_italic("[src] 已经被献祭过了！"))
		return STOP_SACRIFICE|SILENCE_SACRIFICE_MESSAGE

	for(var/mob/living/cultist as anything in invokers)
		to_chat(cultist, span_cult_italic("这感觉有点太老套了，你不觉得吗？"))

	cult_converted = TRUE
	INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, say), "咩啊啊啊啊啊！")
	update_appearance(UPDATE_ICON)
	return STOP_SACRIFICE

/mob/living/basic/sheep/vv_edit_var(vname, vval)
	if(vname != NAMEOF(src, cult_converted))
		return ..()

	if(vval == cult_converted)
		return FALSE
	. = ..()
	if(.)
		update_appearance(UPDATE_ICON)

/datum/ai_controller/basic_controller/sheep
	behavior_tree_json = "code/modules/mob/living/basic/farm_animals/sheep.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SAY = list("咩——", "咩啊啊啊啊！", "咩啊"),
			BB_EMOTE_HEAR = list("咩咩叫着。"),
			BB_EMOTE_SEE = list("摇了摇头。", "望着远方。"),
			BB_EMOTE_SOUND = list('sound/mobs/non-humanoids/sheep/sheep1.ogg', 'sound/mobs/non-humanoids/sheep/sheep2.ogg', 'sound/mobs/non-humanoids/sheep/sheep3.ogg'),
			BB_SPEAK_CHANCE = 5,
		),
	)
	ai_traits = PASSIVE_AI_FLAGS
	ai_movement = /datum/ai_movement/basic_avoidance
