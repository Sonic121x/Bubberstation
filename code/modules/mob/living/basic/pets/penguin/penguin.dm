/mob/living/basic/pet/penguin
	abstract_type = /mob/living/basic/pet/penguin

	icon = 'icons/mob/simple/penguins.dmi'
	gender = FEMALE

	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻敲"
	response_disarm_simple = "轻敲"
	response_harm_continuous = "踢"
	response_harm_simple = "踢"

	faction = list(FACTION_NEUTRAL)
	mob_biotypes = MOB_ORGANIC|MOB_BEAST|MOB_AQUATIC
	ai_controller = /datum/ai_controller/basic_controller/penguin
	///it can lay an egg?
	var/can_lay_eggs = TRUE
	///the egg it carries
	var/obj/carried_egg

/datum/emote/penguin
	abstract_type = /datum/emote/penguin
	mob_type_allowed_typecache = /mob/living/basic/pet/penguin
	mob_type_blacklist_typecache = list()

/datum/emote/penguin/honk
	key = "honk"
	key_third_person = "honks"
	message = "开心地鸣叫着！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/mob/living/basic/pet/penguin/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_MOB_CAN_DIG, TRAIT_NODROWN, TRAIT_SWIMMER), INNATE_TRAIT)
	AddElement(/datum/element/cultist_pet)
	AddElement(/datum/element/wears_collar)
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/ai_flee_while_injured)
	AddElement(/datum/element/pet_bonus, "honk")
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_PENGUIN, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
	AddComponent(/datum/component/profound_fisher)
	AddElementTrait(TRAIT_WADDLING, INNATE_TRAIT, /datum/element/waddling)

	var/static/list/delicious_food = list(/obj/item/fish)
	AddElement(/datum/element/basic_eating, heal_amt = 10, food_types = delicious_food)
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, typecacheof(delicious_food))

	if(!can_lay_eggs)
		return
	AddComponent(\
		/datum/component/egg_layer,\
		/obj/item/food/egg/penguin_egg,\
		list(/obj/item/food/fishmeat),\
		lay_messages = EGG_LAYING_MESSAGES,\
		eggs_left = 0,\
		eggs_added_from_eating = 1,\
		max_eggs_held = 1,\
		egg_laid_callback = CALLBACK(src, PROC_REF(lay_penguin_egg)),\
	)

/mob/living/basic/pet/penguin/UnarmedAttack(atom/attack_target, proximity_flag, list/modifiers)
	. = ..()
	if(!.)
		return

	if(!proximity_flag)
		return
	if(!istype(attack_target, /obj/item/food/egg/penguin_egg))
		return

	remove_egg() //to check if we already have a egg
	var/obj/item/egg_target = attack_target
	egg_target.forceMove(src)
	carried_egg = attack_target
	add_overlay("penguin_egg_overlay")
	RegisterSignal(egg_target, COMSIG_QDELETING, PROC_REF(on_hatch_egg))

/mob/living/basic/pet/penguin/death(gibbed)
	. = ..()
	remove_egg()

/mob/living/basic/pet/penguin/proc/lay_penguin_egg(obj/item/penguin_egg)
	if(prob(35))
		penguin_egg.AddComponent(\
			/datum/component/fertile_egg,\
			embryo_type = /mob/living/basic/pet/penguin/baby,\
			minimum_growth_rate = 1,\
			maximum_growth_rate = 2,\
			total_growth_required = 400,\
			current_growth = 0,\
			location_allowlist = typecacheof(list(/turf, /mob/living/basic/pet/penguin)),\
		)

/mob/living/basic/pet/penguin/proc/on_hatch_egg()
	SIGNAL_HANDLER
	remove_egg()

/mob/living/basic/pet/penguin/proc/remove_egg()
	if(isnull(carried_egg))
		return
	carried_egg.forceMove(get_turf(src))
	UnregisterSignal(carried_egg, COMSIG_QDELETING)
	carried_egg = null
	cut_overlay("penguin_egg_overlay")

/mob/living/basic/pet/penguin/emperor
	name = "帝企鹅"
	real_name = "企鹅"
	desc = "她目之所及，皆是她的帝国。"
	icon_state = "penguin"
	icon_living = "penguin"
	icon_dead = "penguin_dead"
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/basic/pet/penguin/emperor/neuter
	can_lay_eggs = FALSE

/mob/living/basic/pet/penguin/emperor/shamebrero
	name = "羞帽企鹅"
	icon_state = "penguin_shamebrero"
	icon_living = "penguin_shamebrero"
	gold_core_spawnable = NO_SPAWN
	unique_pet = TRUE

/mob/living/basic/pet/penguin/emperor/shamebrero/neuter
	can_lay_eggs = FALSE

/mob/living/basic/pet/penguin/baby
	name = "企鹅幼崽"
	real_name = "企鹅"
	desc = "不会飞，走路也摇摇晃晃，却是所有幼崽中的王子。"
	icon_state = "penguin_baby"
	icon_living = "penguin_baby"
	icon_dead = "penguin_baby_dead"
	density = FALSE
	pass_flags = PASSMOB
	mob_size = MOB_SIZE_SMALL
	butcher_results = list(/obj/item/organ/ears/penguin = 1, /obj/item/food/meat/slab/penguin = 1)
	ai_controller = /datum/ai_controller/basic_controller/penguin/baby
	can_lay_eggs = FALSE
	///will it grow up?
	var/can_grow_up = TRUE

/mob/living/basic/pet/penguin/baby/Initialize(mapload)
	. = ..()
	if(!can_grow_up)
		return
	var/list/weight_mobtypes = list(
		/mob/living/basic/pet/penguin/emperor = 5,
		/mob/living/basic/pet/penguin/emperor/shamebrero = 1,
	)
	var/grown_type = pick_weight(weight_mobtypes)
	AddComponent(\
		/datum/component/growth_and_differentiation,\
		growth_time = null,\
		growth_path = grown_type,\
		growth_probability = 100,\
		lower_growth_value = 0.5,\
		upper_growth_value = 1,\
		signals_to_kill_on = list(COMSIG_MOB_CLIENT_LOGIN),\
		optional_checks = CALLBACK(src, PROC_REF(ready_to_grow)),\
	)

/mob/living/basic/pet/penguin/baby/proc/ready_to_grow()
	return (!IS_UNCONSCIOUS_OR_CRIT(src))

/mob/living/basic/pet/penguin/baby/permanent
	can_grow_up = FALSE
