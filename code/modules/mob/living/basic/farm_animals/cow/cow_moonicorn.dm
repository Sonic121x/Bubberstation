/// moonicorn subtype, very hostile unless there's some food to be eatin'
/mob/living/basic/cow/moonicorn
	name = "月角牛"
	desc = "传说中的魔法奶牛。它的角能安抚任何被触碰之物，让受害者几乎无力反抗。 \
		受害者，没错，因为尽管外表神秘而奇妙，月角牛却极具攻击性。"
	icon_state = "moonicorn"
	icon_living = "moonicorn"
	icon_dead = "moonicorn_dead"
	icon_gib = null //otherwise does the regular cow gib animation
	faction = list(FACTION_HOSTILE)
	speed = 1
	melee_damage_lower = 25
	melee_damage_upper = 25
	obj_damage = 35
	attack_verb_continuous = "用念力将月角撞向"
	attack_verb_simple = "用念力将你的月角撞向"
	gold_core_spawnable = NO_SPAWN
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	ai_controller = /datum/ai_controller/basic_controller/cow/moonicorn
	food_types = list(/obj/item/food/grown/galaxythistle)
	tame_message = "尊敬地点了点头"
	self_tame_message = "尊敬地点了点头"
	milked_reagent = /datum/reagent/drug/mushroomhallucinogen

/mob/living/basic/cow/moonicorn/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/venomous, /datum/reagent/pax, 5, injection_flags = INJECT_CHECK_PENETRATE_THICK | INJECT_CHECK_IGNORE_SPECIES)
	AddElement(/datum/element/movement_turf_changer, /turf/open/floor/grass/fairy)

/mob/living/basic/cow/moonicorn/setup_eating()
	var/static/list/food_types
	if(!food_types)
		food_types = src.food_types.Copy()
	AddComponent(/datum/component/tameable, food_types = food_types, tame_chance = 25, bonus_tame_chance = 15)

/mob/living/basic/cow/moonicorn/tamed(mob/living/tamer, atom/food)
	. = ..()
	///stop killing my FRIENDS
	APPLY_FACTION_AND_ALLIES_FROM(src, tamer)

/datum/ai_controller/basic_controller/cow/moonicorn
	behavior_tree_json = "code/modules/mob/living/basic/farm_animals/cow/cow_moonicorn.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/allow_items/moonicorn,
		BB_BASIC_MOB_TIP_REACTING = FALSE,
		BB_BASIC_MOB_TIPPER = null,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SAY = list("哞？", "哞", "哞哞哞哞哞"),
			BB_EMOTE_HEAR = list("哞哞叫着。"),
			BB_EMOTE_SEE = list("摇了摇头。"),
			BB_EMOTE_SOUND = list('sound/mobs/non-humanoids/cow/cow.ogg'),
			BB_SPEAK_CHANCE = 1,
		),
	)

///moonicorns will not attack people holding something that could tame them.
/datum/targeting_strategy/basic/allow_items/moonicorn

/datum/targeting_strategy/basic/allow_items/moonicorn/is_valid_target(mob/living/living_mob, atom/the_target, vision_range, datum/ai_controller/controller = null)
	. = ..()
	if(!.)
		return FALSE

	if(isliving(the_target)) //Targeting vs living mobs
		var/mob/living/living_target = the_target
		for(var/obj/item/food/grown/galaxythistle/tame_food in living_target.held_items)
			return FALSE //heyyy this can tame me! let's NOT fight
