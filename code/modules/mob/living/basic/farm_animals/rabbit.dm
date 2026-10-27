/**
 * ## Rabbit
 *
 * A creature that hops around with small tails and long ears.
 *
 * This contains the code for both your standard rabbit as well as the subtypes commonly found during Easter.
 *
 */
/mob/living/basic/rabbit
	name = "兔子"
	desc = "最会蹦跶的嬉皮士。"
	icon = 'icons/mob/simple/rabbit.dmi'
	icon_state = "rabbit_white"
	icon_living = "rabbit_white"
	icon_dead = "rabbit_white_dead"
	gender = PLURAL
	mob_biotypes = MOB_ORGANIC | MOB_BEAST
	health = 15
	maxHealth = 15
	mob_size = MOB_SIZE_SMALL
	density = FALSE
	gold_core_spawnable = FRIENDLY_SPAWN
	speak_emote = list("抽着鼻子", "抽动")
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	attack_vis_effect = ATTACK_EFFECT_KICK
	response_harm_continuous = "踢"
	response_harm_simple = "踢"
	attack_verb_continuous = "踢"
	attack_verb_simple = "踢"
	butcher_results = list(/obj/item/food/meat/slab/grassfed = 1)
	unsuitable_cold_damage = 0.5 // Cold damage is 0.5 here to account for low health on the rabbit.
	unsuitable_heat_damage = 0.5 // Heat damage is 0.5 here to account for low health on the rabbit.
	ai_controller = /datum/ai_controller/basic_controller/rabbit
	/// passed to animal_varity as the prefix icon.
	var/icon_prefix = "rabbit"

/datum/emote/rabbit
	abstract_type = /datum/emote/rabbit
	mob_type_allowed_typecache = /mob/living/basic/rabbit
	mob_type_blacklist_typecache = list()

/datum/emote/rabbit/hop
	key = "hop"
	key_third_person = "hops"
	message = "开心地四处蹦跳！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/mob/living/basic/rabbit/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/pet_bonus, "hop")
	AddElement(/datum/element/animal_variety, icon_prefix, pick("brown", "black", "white"), TRUE)
	AddElement(/datum/element/can_be_held)
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_RABBIT, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
	if(prob(20)) // bunny
		name = "小兔"

/datum/ai_controller/basic_controller/rabbit
	behavior_tree_json = "code/modules/mob/living/basic/farm_animals/rabbit.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SAY = list("咪咪。", "啾！", "咪咪？"),
			BB_EMOTE_HEAR = list("蹦跳着。"),
			BB_EMOTE_SEE = list("四处蹦跳。", "上上下下地弹跳。"),
			BB_SPEAK_CHANCE = 10,
		),
	)
	ai_traits = PASSIVE_AI_FLAGS
	ai_movement = /datum/ai_movement/basic_avoidance


/// The easter subtype of rabbits, will lay eggs and say Eastery catchphrases.
/mob/living/basic/rabbit/easter
	icon_state = "easter_rabbit_white"
	icon_living = "easter_rabbit_white"
	icon_dead = "easter_rabbit_white_dead"
	icon_prefix = "easter_rabbit"
	ai_controller = /datum/ai_controller/basic_controller/rabbit/easter
	///passed to the egg_layer component as how many eggs it starts out as able to lay.
	var/initial_egg_amount = 10
	///passed to the egg_layer component as how many eggs it's allowed to hold at most.
	var/max_eggs_held = 8

/mob/living/basic/rabbit/easter/Initialize(mapload)
	. = ..()
	//passed to the egg_layer component as how many eggs it gets when it eats something.
	var/eggs_added_from_eating = rand(1, 4)
	var/list/feed_messages = list("[p_they()] 开心地啃着。", "[p_they()] 开心地大嚼着。")
	AddComponent(/datum/component/egg_layer,\
		/obj/item/surprise_egg,\
		list(/obj/item/food/grown/carrotlike/carrot),\
		feed_messages,\
		list("藏起了一颗蛋。","鬼鬼祟祟地乱窜。","开始弄出巨大的动静。","开始拖沓地挪动。"),\
		initial_egg_amount,\
		eggs_added_from_eating,\
		max_eggs_held,\
	)

/datum/ai_controller/basic_controller/rabbit/easter
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SAY = list("来参加复活节吧！", "快来拿你的蛋！", "人人都有奖品！"),
			BB_EMOTE_HEAR = list("蹦跳着。"),
			BB_EMOTE_SEE = list("四处蹦跳。", "上上下下地弹跳。"),
			BB_SPEAK_CHANCE = 10,
		),
	)


/// Same deal as the standard easter subtype, but these ones are able to brave the cold of space with their handy gas mask.
/mob/living/basic/rabbit/easter/space
	icon_state = "space_rabbit_white"
	icon_living = "space_rabbit_white"
	icon_dead = "space_rabbit_white_dead"
	icon_prefix = "space_rabbit"
	ai_controller = /datum/ai_controller/basic_controller/rabbit/easter/space
	unsuitable_atmos_damage = 0 // Zero because we are meant to survive in space.
	minimum_survivable_temperature = 0 // Minimum Allowable Body Temp, zero because we are meant to survive in space and we have a fucking RABBIT SPACE MASK.
	maximum_survivable_temperature = 1500 // Maximum Allowable Body Temp, 1500 because we might overheat and die in said RABBIT SPACE MASK.
	unsuitable_cold_damage = 0 // Zero because we are meant to survive in space.

/datum/ai_controller/basic_controller/rabbit/easter/space
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SAY = list("唔唔唔！", "唔姆唔姆！", "嗯嗯嗯！"),
			BB_EMOTE_HEAR = list("蹦跳着。"),
			BB_EMOTE_SEE = list("四处蹦跳。", "上上下下地弹跳。"),
			BB_SPEAK_CHANCE = 10,
		),
	)
