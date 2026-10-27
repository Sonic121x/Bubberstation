/// Where do we draw gorilla held overlays?
#define GORILLA_HANDS_LAYER 1



GLOBAL_LIST_INIT(strippable_gorilla_items, create_strippable_list(list(
	/datum/strippable_item/hand/left,
	/datum/strippable_item/hand/right)))

/**
 * Like a bigger monkey
 * They make a lot of noise and punch limbs off unconscious folks
 */
/mob/living/basic/gorilla
	name = "大猩猩"
	desc = "一种地栖的、以草食为主的大型猿类，通常栖息在非洲中部的森林中，但如今已远离故土。"
	icon = 'icons/mob/simple/gorilla.dmi'
	icon_state = "crawling"
	icon_living = "crawling"
	icon_dead = "dead"
	health_doll_icon = "crawling"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	maxHealth = 220
	health = 220
	initial_language_holder = /datum/language_holder/monkey
	response_help_continuous = "戳了戳"
	response_help_simple = "戳了戳"
	response_disarm_continuous = "挑衅"
	response_disarm_simple = "挑衅"
	response_harm_continuous = "捶"
	response_harm_simple = "捶"
	speed = -0.1
	melee_attack_cooldown = CLICK_CD_MELEE
	melee_damage_lower = 25
	melee_damage_upper = 30
	damage_coeff = list(BRUTE = 1, BURN = 1.5, TOX = 1.5, STAMINA = 1, OXY = 1.5)
	obj_damage = 40
	attack_verb_continuous = "猛捶"
	attack_verb_simple = "猛捶"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	unique_name = TRUE
	ai_controller = /datum/ai_controller/basic_controller/gorilla
	faction = list(FACTION_MONKEY, FACTION_JUNGLE)
	butcher_results = list(/obj/item/food/meat/slab/gorilla = 4, /obj/effect/gibspawner/generic/animal = 1)
	max_grab = GRAB_KILL
	/// How likely our meaty fist is to stun someone
	var/paralyze_chance = 20
	/// A counter for when we can scream again
	var/oogas = 0
	/// Types of things we want to find and eat
	var/static/list/gorilla_food = list(
		/obj/item/food/bread/banana,
		/obj/item/food/breadslice/banana,
		/obj/item/food/cnds/banana_honk,
		/obj/item/food/grown/banana,
		/obj/item/food/popsicle/topsicle/banana,
		/obj/item/food/salad/fruit,
		/obj/item/food/salad/jungle,
		/obj/item/food/sundae,
	)

/mob/living/basic/gorilla/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_ADVANCEDTOOLUSER, TRAIT_CAN_STRIP, TRAIT_CHUNKYFINGERS), ROUNDSTART_TRAIT)
	AddElement(/datum/element/wall_tearer, allow_reinforced = FALSE)
	AddElement(/datum/element/dextrous, can_throw = TRUE)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_BAREFOOT)
	AddElement(/datum/element/basic_eating, heal_amt = 10, food_types = gorilla_food)
	AddComponent(
		/datum/component/amputating_limbs, \
		surgery_time = 0 SECONDS, \
		surgery_verb = "捶下",\
	)
	AddComponent(/datum/component/personal_crafting)
	AddComponent(/datum/component/basic_inhands, y_offset = -1)
	AddElement(/datum/element/strippable, GLOB.strippable_gorilla_items)

	ai_controller?.set_blackboard_key(BB_BASIC_FOODS, typecacheof(gorilla_food))

/mob/living/basic/gorilla/examine(mob/user)
	. = ..()
	if (!HAS_MIND_TRAIT(user, TRAIT_EXAMINE_FITNESS))
		return
	. += span_notice("这只动物看起来体格处于巅峰状态，可它这辈子大概一天都没锻炼过。 \
		那未被开发的潜力几乎令人恐惧。")

/mob/living/basic/gorilla/update_overlays()
	. = ..()
	if (is_holding_items())
		. += "standing_overlay"

/mob/living/basic/gorilla/update_icon_state()
	. = ..()
	if (stat == DEAD)
		return
	icon_state = is_holding_items() ? "standing" : "crawling"

/mob/living/basic/gorilla/update_held_items()
	. = ..()
	update_appearance(UPDATE_ICON)
	if (is_holding_items())
		add_movespeed_modifier(/datum/movespeed_modifier/gorilla_standing)
	else
		remove_movespeed_modifier(/datum/movespeed_modifier/gorilla_standing)

/mob/living/basic/gorilla/melee_attack(mob/living/target, list/modifiers, ignore_cooldown)
	. = ..()
	if (!. || !isliving(target))
		return
	ooga_ooga()
	if (prob(paralyze_chance))
		target.Paralyze(2 SECONDS)
		visible_message(span_danger("[src] 把 [target] 撞倒了！"))
	else
		target.throw_at(get_edge_target_turf(target, dir), range = rand(1, 2), speed = 7, thrower = src)

/mob/living/basic/gorilla/gib(drop_bitflags = DROP_BRAIN)
	if(!(drop_bitflags & DROP_BRAIN))
		return ..()
	var/mob/living/brain/gorilla_brain = new(drop_location())
	gorilla_brain.name = real_name
	gorilla_brain.real_name = real_name
	mind?.transfer_to(gorilla_brain)
	return ..()

/mob/living/basic/gorilla/can_use_guns(obj/item/gun)
	to_chat(src, span_warning("你这粗壮的手指实在太大了，根本扣不进扳机护圈！"))
	return FALSE

/// Assert your dominance with audio cues
/mob/living/basic/gorilla/proc/ooga_ooga()
	if (isnull(client))
		return // Sorry NPCs
	oogas -= 1
	if(oogas > 0)
		return
	oogas = rand(2,6)
	emote("ooga")

/// Gorillas are slower when carrying something
/datum/movespeed_modifier/gorilla_standing
	blacklisted_movetypes = (FLYING|FLOATING)
	multiplicative_slowdown = 1.2

/// A smaller gorilla summoned via magic
/mob/living/basic/gorilla/lesser
	name = "小型大猩猩"
	desc = "一只青春期的大猩猩。它也许尚未成年，但就像香蕉一样，这意味着它更结实、更难嚼！"
	maxHealth = 120
	health = 120
	speed = 0.35
	melee_damage_lower = 10
	melee_damage_upper = 15
	obj_damage = 15
	ai_controller = /datum/ai_controller/basic_controller/gorilla/lesser
	butcher_results = list(/obj/item/food/meat/slab/gorilla = 2)
	initial_size = 0.75

/// Cargo's wonderful mascot, the tranquil box-carrying ape
/mob/living/basic/gorilla/cargorilla
	name = "货运大猩猩" // Overriden, normally
	icon = 'icons/mob/simple/cargorillia.dmi'
	desc = "货运部的宠物大猩猩。它身上似乎还纹着“我爱妈妈”的纹身。"
	maxHealth = 200
	health = 200
	faction = list(FACTION_NEUTRAL, FACTION_MONKEY, FACTION_JUNGLE)
	unique_name = FALSE
	ai_controller = null

/mob/living/basic/gorilla/cargorilla/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_PACIFISM, INNATE_TRAIT)
	AddComponent(/datum/component/crate_carrier)

/// big fucking gorilla version of pun pun. be afraid.
/mob/living/basic/gorilla/bar
	name = "潘潘" //C A N O N, allegedly
	desc = "酒吧的猴子。有件事发展得可怕地顺利。"
	icon = 'icons/mob/simple/bargorilla.dmi'
	faction = list(FACTION_NEUTRAL, FACTION_MONKEY, FACTION_JUNGLE)
	unique_name = FALSE
	ai_controller = /datum/ai_controller/monkey/pun_pun
	pass_flags = parent_type::pass_flags | PASSTABLE //he cant serve the GUESTS otherwise okay?


/mob/living/basic/gorilla/bar/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_PAWN_POSSESSED_BY_AI_CONTROLLER, PROC_REF(on_possessed_by_ai_controller))
	gorrilify_punpun_ai()

	if(!GLOB.the_one_and_only_punpun)
		GLOB.the_one_and_only_punpun = src

/// Signal handler for when an ai controller possesses us, reapplies our gorilla-specific ai tweaks if it's a monkey controller
/mob/living/basic/gorilla/bar/proc/on_possessed_by_ai_controller(datum/source, datum/ai_controller/source_controller)
	SIGNAL_HANDLER
	if(!istype(source_controller, /datum/ai_controller/monkey))
		return
	gorrilify_punpun_ai()

/mob/living/basic/gorilla/bar/proc/gorrilify_punpun_ai()
	ai_controller?.override_blackboard_key(BB_SONG_LINES, GORILLA_SONG)
	ai_controller?.override_blackboard_key(BB_EMOTE_KEY, "ooga")
	ai_controller?.override_blackboard_key(BB_EMOTE_CHANCE, 50)
	ai_controller?.set_behavior_tree_override(SUBPLAN_ID_MONKEY_COMBAT, /datum/bt_node/subtree/bar_gorilla_combat)

/mob/living/basic/gorilla/bar/Destroy()
	if(GLOB.the_one_and_only_punpun == src)
		GLOB.the_one_and_only_punpun = null
	return ..()

/// A version of the gorilla achieved by reaching enough genetic damage as a monkey
/mob/living/basic/gorilla/genetics
	name = "实验大猩猩"
	maxHealth = 180
	health = 180
	desc = "一只经由“先进基因科学”创造的大猩猩。虽然不如野生同类那般强壮，这只猿类依然相当能打。"
	melee_damage_lower = 15
	melee_damage_upper = 18
	obj_damage = 25
	speed = 0.1
	paralyze_chance = 0
	initial_size = 0.9

/mob/living/basic/gorilla/hostile
	name = "野生大猩猩"
	maxHealth = 180
	health = 180
	desc = "一只经由“先进基因科学”创造的大猩猩。虽然不如野生同类那般强壮，这只猿类依然相当能打。"
	melee_damage_lower = 15
	melee_damage_upper = 18
	obj_damage = 25
	speed = 0.1
	paralyze_chance = 0
	initial_size = 0.9
	faction = list(FACTION_HOSTILE)

/mob/living/basic/gorilla/genetics/Initialize(mapload)
	. = ..()
	qdel(GetComponent(/datum/component/amputating_limbs))

#undef GORILLA_HANDS_LAYER
