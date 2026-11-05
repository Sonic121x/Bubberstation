/mob/living/basic/mlpony
	name = "小马"
	desc = "?"
	icon = 'modular_z121/icons/mob/pony.dmi'
	icon_state = "pony"
	icon_living = "pony"
	icon_dead = "pony"
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC | MOB_BEAST
	speak_emote = list("嘶鸣", "轻声嘶鸣")
	//emote_hear = list("excitedly says")
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	response_harm_continuous = "踢"
	response_harm_simple = "踢"
	attack_verb_continuous = "蹬踢"
	attack_verb_simple = "蹬踢"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	attack_vis_effect = ATTACK_EFFECT_KICK
	melee_damage_lower = 0
	melee_damage_upper = 0
	health = 50
	maxHealth = 50
	speed = 0
	faction = list("pony")
	see_in_dark = 5
	gold_core_spawnable = NO_SPAWN
	blood_volume = BLOOD_VOLUME_NORMAL
	ai_controller = /datum/ai_controller/basic_controller/pony
	status_flags = CANPUSH
	basic_mob_flags = DEL_ON_DEATH
	var/unique_tamer = FALSE
	var/datum/weakref/my_owner

/mob/living/basic/mlpony/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/pet_bonus, "轻声嘶鸣。")
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/ai_flee_while_injured)
	AddElementTrait(TRAIT_WADDLING, INNATE_TRAIT, /datum/element/waddling)
	var/static/list/food_types = list(
		/obj/item/food/grown/apple,
	)
	AddComponent(/datum/component/tameable, food_types = food_types, tame_chance = 25, bonus_tame_chance = 15, unique = unique_tamer)

/mob/living/basic/mlpony/tamed(mob/living/tamer, atom/food)
	. = ..()
	playsound(src, 'sound/mobs/non-humanoids/pony/snort.ogg', 50)
	AddElement(/datum/element/ridable, /datum/component/riding/creature/pony)
	visible_message(span_notice("[src]开心地打了个响鼻。"))
	new /obj/effect/temp_visual/heart(loc)
	var/static/list/tamed_emotes = list(
		BB_EMOTE_HEAR = list("打了个响鼻。"),
		BB_EMOTE_SEE = list("打了个响鼻。"),
		BB_EMOTE_SOUND = list('sound/mobs/non-humanoids/pony/snort.ogg'),
		BB_SPEAK_CHANCE = 3,
	)
	ai_controller.override_blackboard_key(BB_BASIC_MOB_SPEAK_LINES, tamed_emotes)

	if(unique_tamer)
		my_owner = WEAKREF(tamer)
		RegisterSignal(src, COMSIG_MOVABLE_PREBUCKLE, PROC_REF(on_prebuckle))

/mob/living/basic/mlpony/Destroy()
	UnregisterSignal(src, COMSIG_MOVABLE_PREBUCKLE)
	my_owner = null
	return ..()

/mob/living/basic/mlpony/proc/on_prebuckle(mob/source, mob/living/buckler, force, buckle_mob_flags)
	SIGNAL_HANDLER
	var/mob/living/tamer = my_owner?.resolve()
	if(!unique_tamer || (isnull(tamer) && unique_tamer))
		return
	if(buckler != tamer)
		whinny_angrily()
		return COMPONENT_BLOCK_BUCKLE

/mob/living/basic/mlpony/proc/whinny_angrily()
	manual_emote("愤怒地嘶鸣！")

	playsound(src, pick(list(
		'sound/mobs/non-humanoids/pony/whinny01.ogg',
		'sound/mobs/non-humanoids/pony/whinny02.ogg',
		'sound/mobs/non-humanoids/pony/whinny03.ogg'
	)), 50)

/mob/living/basic/mlpony/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	. = ..()

	if (prob(33))
		whinny_angrily()

/mob/living/basic/mlpony/melee_attack(atom/target, list/modifiers, ignore_cooldown = FALSE)
	. = ..()

	if (!.)
		return

	whinny_angrily()
/*
/datum/ai_controller/basic_controller/pony
	behavior_tree_json = "code/modules/mob/living/basic/farm_animals/pony.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_HEAR = list("whinnies!"),
			BB_EMOTE_SEE = list("horses around."),
			BB_EMOTE_SOUND = list('sound/mobs/non-humanoids/pony/whinny01.ogg', 'sound/mobs/non-humanoids/pony/whinny02.ogg', 'sound/mobs/non-humanoids/pony/whinny03.ogg'),
			BB_SPEAK_CHANCE = 3,
		),
	)

	ai_traits = PASSIVE_AI_FLAGS
	ai_movement = /datum/ai_movement/basic_avoidance
*/
/mob/living/basic/mlpony/twilight
	name = "暮光闪闪"
	real_name = "暮光闪闪"
	icon_state = "twilight"
	icon_living = "twilight"

/mob/living/basic/mlpony/pinkie
	name = "萍琪派"
	real_name = "萍琪派"
	icon_state = "pinkie"
	icon_living = "pinkie"

/mob/living/basic/mlpony/rainbow
	name = "云宝黛西"
	real_name = "云宝黛西"
	icon_state = "rainbow"
	icon_living = "rainbow"

/mob/living/basic/mlpony/fluttershy
	name = "柔柔"
	real_name = "柔柔"
	icon_state = "fluttershy"
	icon_living = "fluttershy"

/mob/living/basic/mlpony/applejack
	name = "苹果嘉儿"
	real_name = "苹果嘉儿"
	icon_state = "applejack"
	icon_living = "applejack"

/mob/living/basic/mlpony/luna
	name = "露娜"
	real_name = "露娜"
	icon_state = "luna"
	icon_living = "luna"

/mob/living/basic/mlpony/clownie
	name = "小丑马"
	real_name = "小丑马"
	icon_state = "clownie"
	icon_living = "clownie"

/mob/living/basic/mlpony/tia
	name = "蒂娅"
	real_name = "蒂娅"
	icon_state = "tia"
	icon_living = "tia"

/mob/living/basic/mlpony/trixie
	name = "特丽克西"
	real_name = "特丽克西"
	icon_state = "trixie_a_full"
	icon_living = "trixing_a_full"

/mob/living/basic/mlpony/lyra
	name = "莱拉"
	real_name = "莱拉"
	icon_state = "lyra"
	icon_living = "lyra"

/mob/living/basic/mlpony/vinyl
	name = "黑胶"
	real_name = "黑胶"
	icon_state = "vinyl"
	icon_living = "vinyl"

/mob/living/basic/mlpony/rarity
	name = "瑞瑞"
	real_name = "瑞瑞"
	icon_state = "rarity"
	icon_living = "rarity"

/mob/living/basic/mlpony/whooves
	name = "胡弗斯"
	real_name = "胡弗斯"
	icon_state = "whooves"
	icon_living = "whooves"
	gender = MALE

/mob/living/basic/mlpony/fleur
	name = "芙蓉"
	real_name = "芙蓉"
	icon_state = "fleur"
	icon_living = "fleur"

/mob/living/basic/mlpony/mac
	name = "麦克"
	real_name = "麦克"
	icon_state = "mac"
	icon_living = "mac"
	gender = MALE

/mob/living/basic/mlpony/wendy
	name = "温蒂"
	real_name = "温蒂"
	icon_state = "wendy"
	icon_living = "wendy"
	desc = "这是服主"
/*
/mob/living/simple_animal/pet/cat/slugcat
	name = "蛞蝓猫"
	desc = "一个奇怪而又可爱的白色生物。它的身体异常灵活。"
	icon = 'modular_z121/icons/mob/pets.dmi'
	icon/held_lh = 'modular_z121/icons/mob/pets_held_lh.dmi'
	icon/held_rh = 'modular_z121/icons/mob/pets_held_rh.dmi'
	icon_state = "catslug"
	icon_living = "catslug"
	icon_dead = "catslug_dead"
	held_state = "slugcat"
	speak_emote = list("purrs", "meows", "blorbles")
	emote_hear = list("meows.", "mews.", "blorbles")
	emote_see = list("shakes its head.", "shivers.", "squishes")
	speak_chance = 1
	turns_per_move = 5
	can_be_held = TRUE
	see_in_dark = 6
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	minbodytemp = 200
	maxbodytemp = 400
	butcher_results = list(/obj/item/food/meat/slab = 2)
	unsuitable_atmos_damage = 0.5
	animal_species = /mob/living/simple_animal/pet/slugcat
	childtype = list(/mob/living/simple_animal/pet/slugcat = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	gold_core_spawnable = FRIENDLY_SPAWN
	//collar_type = "cat"
	attack_verb_continuous = "squishes"
	attack_verb_simple = "squish"
	attack_sound = 'sound/effects/blob/attackblob.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW

	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/pet/cat/slugcat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/pet_bonus, "purrs!")
	add_verb(src, /mob/living/proc/toggle_resting)
	add_cell_sample()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/pet/slugcat/add_cell_sample()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CAT, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
*/

/mob/living/simple_animal/pet/slugcat
	name = "蛞蝓猫"
	desc = "一只是猫又是蛞蝓的生物"
	icon = 'modular_z121/icons/mob/pets.dmi'
	held_lh = 'modular_z121/icons/mob/pets_held_lh.dmi'
	held_rh = 'modular_z121/icons/mob/pets_held_rh.dmi'
	icon_state = "slugcat"
	icon_living = "slugcat"
	icon_dead = "slugcat_dead"
	held_state = "slugcat"
	emote_see = list("盯着天花板。", "发抖。")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	minbodytemp = 200
	maxbodytemp = 400
	butcher_results = list(/obj/item/food/meat/slab = 2)
	unsuitable_atmos_damage = 0.5
	animal_species = /mob/living/simple_animal/pet/slugcat
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	response_harm_continuous = "踢"
	response_harm_simple = "踢"
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	gold_core_spawnable = FRIENDLY_SPAWN
	//collar_type = "cat"
	attack_verb_continuous = "挤压"
	attack_verb_simple = "挤压"
	attack_sound = 'sound/effects/blob/attackblob.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW

	footstep_type = FOOTSTEP_MOB_CLAW
	gold_core_spawnable = FRIENDLY_SPAWN

	attack_vis_effect = ATTACK_EFFECT_SLASH
	obj_damage = 0
	melee_damage_lower = 0
	melee_damage_upper = 0
	var/attacktext = "刺击"
	var/obj/item/spear/weapon

/mob/living/simple_animal/pet/slugcat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/pet_bonus, "发出了呼噜声！")
	AddElement(/datum/element/can_be_held)
	add_verb(src, /mob/living/proc/toggle_resting)
	add_cell_sample()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/pet/slugcat/add_cell_sample()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CAT, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/mob/living/simple_animal/pet/slugcat/update_resting()
	. = ..()
	if(stat == DEAD)
		return
	if (resting)
		icon_state = "[icon_living]_rest"
	else
		icon_state = "[icon_living]"

/mob/living/simple_animal/pet/slugcat/UnarmedAttack(atom/A, proximity_flag, list/modifiers)
	. = ..()
	if(!isitem(A))
		return

	if(!weapon && istype(A, /obj/item/spear))
		visible_message(span_notice("[src] 拿起了 [A]."), span_notice("你拿起了 [A]."))
		weapon = A
		weapon.forceMove(src)
		melee_damage_lower = weapon.force + weapon.force_wielded
		melee_damage_upper = weapon.force + weapon.force_wielded
		armour_penetration = weapon.armour_penetration
		melee_damage_type = weapon.damtype
		sharpness = weapon.sharpness
		attack_sound = weapon.hitsound
		update_icons()
	else if(!weapon && !istype(A, /obj/item/spear))
		to_chat(src, span_warning("你不知道该如何使用[A]！"))

/mob/living/simple_animal/pet/slugcat/RangedAttack(atom/A, params)
	. = ..()
	if(!weapon)
		return
	visible_message(span_warning("[src]向[A]扔出了[weapon]！"), span_warning("你向[A]扔出了[weapon]！"))
	melee_damage_lower = initial(melee_damage_lower)
	melee_damage_upper = initial(melee_damage_upper)
	armour_penetration = initial(armour_penetration)
	melee_damage_type = initial(melee_damage_type)
	sharpness = initial(sharpness)
	attack_sound = initial(attack_sound)
	weapon.forceMove(get_turf(src))
	weapon.throw_at(A, weapon.throw_range, weapon.throw_speed, src)
	weapon = null
	update_icons()

/mob/living/simple_animal/pet/slugcat/update_icons()
	. = ..()
	if(stat == DEAD || resting)
		return
	icon_state = weapon ? initial(icon_state) + "_spear" : initial(icon_state)

/mob/living/simple_animal/pet/slugcat/death(gibbed)
	if(weapon)
		weapon.forceMove(get_turf(src))
		weapon = null
	update_icons()
	. = ..()

/mob/living/basic/pet/slugcat
	name = "蛞蝓猫"
	desc = "一只是猫又是蛞蝓的生物"
	icon = 'modular_z121/icons/mob/pets.dmi'
	held_lh = 'modular_z121/icons/mob/pets_held_lh.dmi'
	held_rh = 'modular_z121/icons/mob/pets_held_rh.dmi'
	icon_state = "slugcat"
	icon_living = "slugcat"
	icon_dead = "slugcat_dead"
	held_state = "slugcat"
	see_in_dark = 6
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	hud_type = /datum/hud/guardian
	minimum_survivable_temperature = NPC_DEFAULT_MIN_TEMP
	maximum_survivable_temperature = NPC_DEFAULT_MAX_TEMP
	butcher_results = list(/obj/item/food/meat/slab = 2)
	unsuitable_atmos_damage = 0.5
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	response_harm_continuous = "踢"
	response_harm_simple = "踢"
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	gold_core_spawnable = FRIENDLY_SPAWN
	//collar_type = "cat"
	attack_verb_continuous = "挤压"
	attack_verb_simple = "挤压"
	attack_sound = 'sound/effects/blob/attackblob.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	gold_core_spawnable = FRIENDLY_SPAWN
	attack_vis_effect = ATTACK_EFFECT_SLASH
	obj_damage = 0

/mob/living/basic/pet/slugcat/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_CAN_STRIP, TRAIT_CHUNKYFINGERS), ROUNDSTART_TRAIT)
	AddElement(/datum/element/pet_bonus, "发出了呼噜声！")
	AddElement(/datum/element/dextrous, can_throw = TRUE)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_CLAW)
	AddElement(/datum/element/can_be_held)
	AddComponent(/datum/component/personal_crafting)
	AddComponent(/datum/component/basic_inhands, y_offset = -1)
	add_verb(src, /mob/living/proc/toggle_resting)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/basic/pet/slugcat/can_use_guns(obj/item/gun)
	to_chat(src, span_warning("你无法理解如何使用这东西。"))
	return FALSE

/mob/living/basic/pet/slugcat/update_resting()
	. = ..()
	if(stat == DEAD)
		return
	if (resting)
		icon_state = "[icon_living]_rest"
	else
		icon_state = "[icon_living]"
