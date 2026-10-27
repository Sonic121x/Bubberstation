// Oil shamblers
#define OIL_SHAMBLER_OVERLAY "oil_shambler_overlay"
#define OIL_SHAMBLER_OVERLAY_LAYER 0

// Centaur
#define CENTAUR_DEATH_SPLASH_RANGE 5
#define CENTAUR_DEATH_SPLAT_VOLUME 50
#define CENTAUR_RAD_PULSE_RANGE 300
#define CENTAUR_RAD_PULSE_THRESHOLD 1
#define CENTAUR_ATTACK_SCREAM_VOLUME 60

/mob/living/basic/mold
	name = "霉菌生物"
	desc = "用于调试霉菌的生物。如果你看到了它，请报告此问题。"
	icon = 'modular_skyrat/modules/mold/icons/blob_mobs.dmi'
	gold_core_spawnable = NO_SPAWN
	faction = list(FACTION_MOLD)
	basic_mob_flags = DEL_ON_DEATH

/**
 * OIL SHAMBLERS
 *
 * The mob for the fire mold - humanoids that are (visually) on fire
 * They're immune to burn damage and have a chance to add fire stacks on melee attack
 */
/mob/living/basic/mold/oil_shambler
	name = "油污蹒跚者"
	desc = "全身覆满油污的人形身影，或许它完全由油组成？它似乎一直在燃烧。"
	icon_state = "oil_shambler"
	icon_living = "oil_shambler"
	icon_dead = "oil_shambler"
	speak_emote = list("噼啪作响")

	maxHealth = 25
	health = 25
	damage_coeff = list(BRUTE = 1, BURN = 0.25, TOX = 1, STAMINA = 0, OXY = 0)
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = INFINITY

	melee_damage_type = BURN
	melee_damage_lower = 5
	melee_damage_upper = 10
	obj_damage = 40
	attack_sound = 'sound/effects/blob/attackblob.ogg'

	basic_mob_flags = DEL_ON_DEATH
	gold_core_spawnable = HOSTILE_SPAWN
	death_message = "蒸发了！"

	light_system = OVERLAY_LIGHT
	light_color = LIGHT_COLOR_FIRE
	light_range = 2
	light_power = 1

	ai_controller = /datum/ai_controller/basic_controller/oil_shambler

	/// The chance to apply fire stacks on melee hit
	var/ignite_chance = 20
	/// How many fire stacks to apply on hit
	var/additional_fire_stacks = 2

/mob/living/basic/mold/oil_shambler/Initialize(mapload)
	. = ..()
	update_overlays(UPDATE_OVERLAYS)

/mob/living/basic/mold/oil_shambler/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	SSvis_overlays.add_vis_overlay(src, icon, OIL_SHAMBLER_OVERLAY, layer, plane, dir, alpha)
	SSvis_overlays.add_vis_overlay(src, icon, OIL_SHAMBLER_OVERLAY, OIL_SHAMBLER_OVERLAY_LAYER, EMISSIVE_PLANE, dir, alpha)

/mob/living/basic/mold/oil_shambler/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if(!isliving(target))
		return

	var/mob/living/ignite_target = target
	if(prob(ignite_chance))
		ignite_target.adjust_fire_stacks(additional_fire_stacks)

	ignite_target.ignite_mob()

/datum/ai_controller/basic_controller/oil_shambler
	behavior_tree_json = "modular_skyrat/modules/mold/code/oil_shambler.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/datum/bt_node/ai_behavior/random_speech/oil_shambler
	speech_chance = 3
	emote_hear = list("咕嘟冒泡。", "噼啪作响。", "呻吟。")
	emote_see = list("冒出气泡。")

/**
 * DISEASE MOLD
 *
 * Giant rats that are created by the disease mold
 * They try to inject their target on melee attacks and, if successful, make them contract a disease
 */
/mob/living/basic/mold/diseased_rat
	name = "染病巨鼠"
	desc = "一只大得惊人、看起来狂暴的老鼠，身上还长着蘑菇。"
	icon_state = "diseased_rat"
	icon_living = "diseased_rat"
	icon_dead = "diseased_rat_dead"
	speak_emote = list("吱吱叫")

	maxHealth = 30
	health = 30

	melee_damage_lower = 7
	melee_damage_upper = 13
	obj_damage = 30
	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_verb_continuous = "啃咬"
	attack_verb_simple = "啃咬"

	pass_flags = PASSTABLE
	basic_mob_flags = DEL_ON_DEATH
	butcher_results = list(/obj/item/food/meat/slab = 1)
	gold_core_spawnable = HOSTILE_SPAWN

	ai_controller = /datum/ai_controller/basic_controller/diseased_rat

	/// The disease given on melee attacks
	var/datum/disease/given_disease = /datum/disease/gastritium

/mob/living/basic/mold/diseased_rat/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()

	if(!isliving(target))
		return

	var/mob/living/carbon/disease_target = target
	if(can_inject(disease_target))
		to_chat(disease_target, span_danger("[src]的牙齿咬穿了你的衣服！"))
		disease_target.ForceContractDisease(new given_disease(), FALSE, TRUE)

/datum/ai_controller/basic_controller/diseased_rat
	behavior_tree_json = "modular_skyrat/modules/mold/code/diseased_rat.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/datum/bt_node/ai_behavior/random_speech/diseased_rat
	speech_chance = 3
	emote_hear = list("吱吱叫。", "磨牙。", "嘶嘶叫。")
	emote_see = list("流着口水。")

/**
 * ELECTRIC MOLD
 *
 * Giant mosquitos spawned by the electric mold
 * They inject their target with teslium on melee attacks
 */
/mob/living/basic/mold/electric_mosquito
	name = "电蚊"
	desc = "一只体型过大的蚊子，体内似乎流动着电流。"
	icon_state = "electric_mosquito"
	icon_living = "electric_mosquito"
	icon_dead = "electric_mosquito_dead"
	speak_emote = list("嗡嗡叫")

	maxHealth = 20
	health = 20

	melee_damage_lower = 5
	melee_damage_upper = 8
	obj_damage = 20
	attack_verb_continuous = "叮刺"
	attack_verb_simple = "叮刺"
	attack_sound = 'sound/effects/blob/attackblob.ogg'
	basic_mob_flags = DEL_ON_DEATH

	ai_controller = /datum/ai_controller/basic_controller/electric_mosquito

	pass_flags = PASSTABLE

	/// What the mob injects per bite
	var/inject_reagent = /datum/reagent/teslium
	/// How many units to inject per bite
	var/inject_amount = 0

/mob/living/basic/mold/electric_mosquito/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/venomous, inject_reagent, inject_amount)

/datum/ai_controller/basic_controller/electric_mosquito
	behavior_tree_json = "modular_skyrat/modules/mold/code/electric_mosquito.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/datum/bt_node/ai_behavior/random_speech/electric_mosquito
	speech_chance = 3
	emote_hear = list("滋滋放电。", "嗡嗡叫。", "噼啪作响。")
	emote_see = list("迸出电弧。")

/**
 * RADIATION MOLD
 *
 * Weird centipede things that spawn with a rad mold
 * They have a chance to irradiate their target on hit
 */
/mob/living/basic/mold/centaur
	name = "半人马怪"
	desc = "骨骼与血肉恐怖地结合在一起，长着多组腿脚。"
	icon_state = "centaur"
	icon_living = "centaur"
	icon_dead = "centaur_dead"
	speak_emote = list("呻吟")

	maxHealth = 60
	health = 60
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = INFINITY

	speed = 0.5

	melee_damage_lower = 6
	melee_damage_upper = 12
	basic_mob_flags = DEL_ON_DEATH
	wound_bonus = 5
	obj_damage = 40
	attack_sound = 'sound/effects/wounds/crackandbleed.ogg'

	light_system = OVERLAY_LIGHT
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_GREEN

	ai_controller = /datum/ai_controller/basic_controller/centaur

	/// The chance to irradiate on hit
	var/irradiate_chance = 20

/mob/living/basic/mold/centaur/Initialize(mapload)
	. = ..()
	update_overlays(UPDATE_OVERLAYS)

/mob/living/basic/mold/centaur/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()

	if(!isliving(target))
		return

	var/mob/living/radiation_target = target
	if(prob(irradiate_chance))
		radiation_pulse(radiation_target, CENTAUR_RAD_PULSE_RANGE, CENTAUR_RAD_PULSE_THRESHOLD, FALSE, TRUE)
		playsound(src, 'modular_skyrat/modules/horrorform/sound/horror_scream.ogg', CENTAUR_ATTACK_SCREAM_VOLUME, TRUE)

/datum/ai_controller/basic_controller/centaur
	behavior_tree_json = "modular_skyrat/modules/mold/code/centaur.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/datum/bt_node/ai_behavior/random_speech/centaur
	speech_chance = 3
	emote_hear = list("吱吱叫。", "呻吟。", "哀嚎。")
	emote_see = list("扭动着身体。")


#undef OIL_SHAMBLER_OVERLAY
#undef OIL_SHAMBLER_OVERLAY_LAYER
#undef CENTAUR_DEATH_SPLASH_RANGE
#undef CENTAUR_DEATH_SPLAT_VOLUME
#undef CENTAUR_RAD_PULSE_RANGE
#undef CENTAUR_RAD_PULSE_THRESHOLD
#undef CENTAUR_ATTACK_SCREAM_VOLUME
