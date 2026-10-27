GLOBAL_DATUM(cargo_sloth, /mob/living/basic/sloth)

/mob/living/basic/sloth
	name = "树懒"
	desc = "一只可爱又嗜睡的生物。"
	icon = 'icons/mob/simple/pets.dmi'
	icon_state = "sloth"
	icon_living = "sloth"
	icon_dead = "sloth_dead"

	speak_emote = list("打了个哈欠")

	held_state = "sloth"

	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	response_harm_continuous = "踢"
	response_harm_simple = "踢"

	attack_verb_continuous = "咬"
	attack_verb_simple = "咬"
	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE

	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN

	melee_damage_lower = 18
	melee_damage_upper = 18
	health = 50
	maxHealth = 50
	speed = 10 // speed is fucking weird man. they aren't fast though don't worry
	butcher_results = list(/obj/item/food/meat/slab = 3)

	ai_controller = /datum/ai_controller/basic_controller/sloth

/datum/emote/sloth
	abstract_type = /datum/emote/sloth
	mob_type_allowed_typecache = /mob/living/basic/sloth
	mob_type_blacklist_typecache = list()

/datum/emote/sloth/smile_slow
	key = "ssmile"
	key_third_person = "slowlysmiles"
	message = "缓缓露出微笑！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/mob/living/basic/sloth/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/pet_bonus, "ssmile")
	AddElement(/datum/element/footstep, footstep_type = FOOTSTEP_MOB_CLAW)
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/can_be_held)
	AddComponent(/datum/component/tree_climber)

	if(!mapload || !isnull(GLOB.cargo_sloth) || !is_station_level(z))
		return

	// If someone adds non-cargo sloths to maps we'll have a problem but we're fine for now
	GLOB.cargo_sloth = src
	GLOB.gorilla_start += get_turf(src)

/mob/living/basic/sloth/Destroy()
	if(GLOB.cargo_sloth == src)
		GLOB.cargo_sloth = null

	return ..()

/mob/living/basic/sloth/paperwork
	name = "文书"
	desc = "货运部的宠物树懒。和其余技术员一样没什么用。"
	gender = MALE
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/sloth/citrus
	name = "柑橘"
	desc = "货运部的宠物树懒。她穿着一件难看得要命的毛衣。"
	icon_state = "cool_sloth"
	icon_living = "cool_sloth"
	icon_dead = "cool_sloth_dead"
	gender = FEMALE
	butcher_results = list(/obj/item/toy/spinningtoy = 1)
	gold_core_spawnable = NO_SPAWN

/// They're really passive in game, so they just wanna get away if you start smacking them. No trees in space from them to use for clawing your eyes out, but they will try if desperate.
/datum/ai_controller/basic_controller/sloth
	behavior_tree_json = "code/modules/mob/living/basic/pets/sloth.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_FLEE_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_HEAR = list("打着呼噜。", "打了个哈欠。"),
			BB_EMOTE_SEE = list("打起了瞌睡。", "睡眼惺忪地四处张望。"),
			BB_SPEAK_CHANCE = 1,
		),
	)

	ai_traits = PASSIVE_AI_FLAGS
	ai_movement = /datum/ai_movement/basic_avoidance
