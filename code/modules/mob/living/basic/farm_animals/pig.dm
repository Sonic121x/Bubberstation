//pig
/mob/living/basic/pig
	name = "猪"
	desc = "一头肥猪。"
	icon_state = "pig"
	icon_living = "pig"
	icon_dead = "pig_dead"
	gender = MALE
	mob_biotypes = MOB_ORGANIC | MOB_BEAST
	speak_emote = list("哼哼叫","尖叫")
	butcher_results = list(/obj/item/food/meat/slab/pig = 6)
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
	melee_damage_lower = 1
	melee_damage_upper = 2
	health = 50
	maxHealth = 50
	gold_core_spawnable = FRIENDLY_SPAWN
	default_blood_volume = BLOOD_VOLUME_NORMAL
	ai_controller = /datum/ai_controller/basic_controller/pig

/datum/emote/pig
	abstract_type = /datum/emote/pig
	mob_type_allowed_typecache = /mob/living/basic/pig
	mob_type_blacklist_typecache = list()

/datum/emote/pig/oink
	key = "oink"
	key_third_person = "oinks"
	message = "哼哼叫！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = TRUE
	sound = SFX_PIG_OINK

/mob/living/basic/pig/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/pet_bonus, "oink")
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/ai_flee_while_injured)
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_PIG, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
	make_tameable()

///wrapper for the tameable component addition so you can have non tamable cow subtypes
/mob/living/basic/pig/proc/make_tameable()
	var/list/food_types = string_list(list(/obj/item/food/grown/carrotlike/carrot))
	AddComponent(/datum/component/tameable, food_types = food_types, tame_chance = 25, bonus_tame_chance = 15)

/mob/living/basic/pig/tamed(mob/living/tamer, atom/food)
	. = ..()
	AddElement(/datum/element/ridable, /datum/component/riding/creature/pig)
	visible_message(span_notice("[src] 恭敬地哼了一声。"))

/datum/ai_controller/basic_controller/pig
	behavior_tree_json = "code/modules/mob/living/basic/farm_animals/pig.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SAY = list("哼？", "哼", "呼噜"),
			BB_EMOTE_HEAR = list("哼哼着。"),
			BB_EMOTE_SEE = list("四处嗅了嗅。"),
			BB_EMOTE_SOUND = list('sound/mobs/non-humanoids/pig/pig1.ogg', 'sound/mobs/non-humanoids/pig/pig2.ogg'),
			BB_SPEAK_CHANCE = 3,
		),
	)

	ai_traits = PASSIVE_AI_FLAGS
	ai_movement = /datum/ai_movement/basic_avoidance
