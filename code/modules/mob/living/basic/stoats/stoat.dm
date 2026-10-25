/mob/living/basic/stoat
	name = "白鼬"
	desc = "天生的害兽清除者……清洁工最好的朋友。"
	icon_state = "stoat"
	icon_living = "stoat"
	icon_dead = "stoat_dead"
	base_icon_state = "stoat"
	icon = 'icons/mob/simple/pets.dmi'
	butcher_results = list(/obj/item/food/meat/slab = 1)
	mob_biotypes = MOB_ORGANIC
	mob_size = MOB_SIZE_SMALL
	pass_flags = PASSTABLE | PASSMOB
	density = FALSE
	health = 40
	maxHealth = 40
	melee_damage_lower = 6
	melee_damage_upper = 9
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	verb_say = "鸣叫"
	verb_ask = "好奇地鸣叫"
	verb_exclaim = "大声鸣叫"
	verb_yell = "大声鸣叫"
	speed = -0.25
	faction = list(FACTION_NEUTRAL)
	ai_controller = /datum/ai_controller/basic_controller/stoat
	///some commands we obey
	var/static/list/pet_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/move,
		/datum/pet_command/free,
		/datum/pet_command/attack,
		/datum/pet_command/follow,
		/datum/pet_command/fetch,
	)
	//can this mob breed?
	var/can_breed = TRUE

/mob/living/basic/stoat/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	AddElement(/datum/element/tiny_mob_hunter)
	var/static/list/eatable_food = list(
		/obj/item/food/deadmouse,
		/obj/item/food/egg,
	)
	AddComponent(/datum/component/tameable, food_types = eatable_food, tame_chance = 70, bonus_tame_chance = 0)
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, typecacheof(eatable_food))
	AddElement(/datum/element/wears_collar)
	AddElement(/datum/element/can_be_held)
	AddComponent(/datum/component/obeys_commands, pet_commands)
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_STOAT, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
	if(can_breed)
		add_breeding_component()

	var/static/list/display_emote = list(
		BB_EMOTE_SAY = list("啾啾啾！"),
		BB_EMOTE_SEE = list("甩动尾巴！", "四处蹦跳！", "舔舐毛发！"),
		BB_SPEAK_CHANCE = 2,
		BB_EMOTE_SOUND = list('sound/mobs/non-humanoids/stoat/stoat_sounds.ogg'),
	)
	ai_controller.set_blackboard_key(BB_BASIC_MOB_SPEAK_LINES, display_emote)

/mob/living/basic/stoat/proc/add_breeding_component()
	var/static/list/partner_paths = typecacheof(list(/mob/living/basic/stoat))
	var/static/list/baby_paths = list(
		/mob/living/basic/stoat/kit = 100 // Placeholder until we get proper baby stoats
	)
	AddComponent(\
		/datum/component/breed,\
		can_breed_with = typecacheof(list(/mob/living/basic/stoat)),\
		baby_paths = baby_paths,\
	)

/mob/living/basic/stoat/kit
	name = "\improper 白鼬幼崽"
	real_name = "白鼬"
	desc = "顶级掠食者，但长得很友善，而且小小一只……"
	icon_state = "kit_stoat"
	icon_living = "kit_stoat"
	icon_dead = "kit_stoat_dead"
	density = FALSE
	pass_flags = PASSMOB
	ai_controller = /datum/ai_controller/basic_controller/stoat/kit
	mob_size = MOB_SIZE_SMALL
	can_breed = FALSE

/mob/living/basic/stoat/kit/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/growth_and_differentiation,\
		growth_time = 20 MINUTES,\
		growth_path = /mob/living/basic/stoat,\
		growth_probability = 100,\
		lower_growth_value = 0.5,\
		upper_growth_value = 1,\
		signals_to_kill_on = list(COMSIG_MOB_CLIENT_LOGIN),\
	)
