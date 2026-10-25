/mob/living/basic/roro
	name = "罗罗"
	desc = "一种圆滚滚、尖嘴巴的小外星生物。它长得非常像绝缘手套。"
	icon_state = "roro"
	icon_living = "roro"
	icon_dead = "roro_dead"
	mob_biotypes = MOB_ORGANIC
	speed = 0.5
	maxHealth = 50
	health = 50

	butcher_results = list(
		/obj/item/clothing/gloves/color/yellow = 1
	)

	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "驱赶"
	response_disarm_simple = "驱赶"

	melee_damage_lower = 1
	melee_damage_upper = 4
	attack_verb_continuous = "轻咬"
	attack_verb_simple = "轻咬"
	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE

	melee_attack_cooldown = 0.5 SECONDS
	speak_emote = list("啼鸣")

	unsuitable_atmos_damage = 0
	unsuitable_cold_damage = 0
	unsuitable_heat_damage = 0

	faction = list(FACTION_HOSTILE)

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_retaliate

/datum/emote/roro
	abstract_type = /datum/emote/roro
	mob_type_allowed_typecache = /mob/living/basic/roro
	mob_type_blacklist_typecache = list()

/datum/emote/roro/warble
	key = "warble"
	key_third_person = "warbles"
	message = "愉快地啼鸣！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = TRUE
	sound = SFX_RORO_WARBLE

/mob/living/basic/roro/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/pet_bonus, "warble")
	AddElement(/datum/element/ai_retaliate)

/datum/ai_controller/basic_controller/roro
	behavior_tree_json = "code/modules/mob/living/basic/space_fauna/roro.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_traits = DEFAULT_AI_FLAGS | STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance
