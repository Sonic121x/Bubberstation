/mob/living/basic/stickman
	name = "愤怒火柴人"
	desc = "来自只有二维的世界的存在。至少它努力想正面朝向你。"
	icon_state = "stickman"
	icon_living = "stickman"
	icon_dead = "stickman_dead"
	mob_biotypes = MOB_HUMANOID
	gender = MALE
	health = 100
	maxHealth = 100
	speed = 0.5
	attack_verb_continuous = "出拳"
	attack_verb_simple = "出拳"
	melee_damage_lower = 10
	melee_damage_upper = 10
	melee_attack_cooldown = 1.5 SECONDS
	attack_sound = 'sound/items/weapons/punch1.ogg'
	combat_mode = TRUE
	faction = list(FACTION_STICKMAN)
	unsuitable_atmos_damage = 0
	unsuitable_heat_damage = 7.5
	physiology = list(STAMINA = 0)

	ai_controller = /datum/ai_controller/basic_controller/stickman

/mob/living/basic/stickman/lesser
	maxHealth = 25
	health = 25

/mob/living/basic/stickman/Initialize(mapload)
	. = ..()
	new /obj/effect/temp_visual/paper_scatter(get_turf(src))

/datum/ai_controller/basic_controller/stickman
	behavior_tree_json = "code/modules/mob/living/basic/ruin_defender/stickman.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/mob/living/basic/stickman/dog
	name = "愤怒火柴狗"
	desc = "火柴人最好的朋友——前提是他能看见它。"
	icon_state = "stickdog"
	icon_living = "stickdog"
	icon_dead = "stickdog_dead"
	attack_verb_continuous = "咬"
	attack_verb_simple = "咬"
	attack_vis_effect = ATTACK_EFFECT_BITE
	sharpness = SHARP_POINTY
	mob_biotypes = MOB_BEAST
	attack_sound = 'sound/items/weapons/bite.ogg'

/mob/living/basic/stickman/ranged
	name = "愤怒火柴枪手"
	desc = "二维的枪到底是怎么运作的？？"
	icon_state = "stickmanranged"
	icon_living = "stickmanranged"
	attack_verb_continuous = "敲打"
	attack_verb_simple = "敲打"
	melee_damage_lower = 5
	melee_damage_upper = 5
	attack_sound = 'sound/items/weapons/genhit1.ogg'

	ai_controller = /datum/ai_controller/basic_controller/stickman/ranged

/mob/living/basic/stickman/ranged/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/death_drops, /obj/item/gun/ballistic/automatic/pistol/stickman)
	AddComponent(/datum/component/ranged_attacks, casing_type = /obj/item/ammo_casing/c9mm, projectile_sound = 'sound/misc/bang.ogg', cooldown_time = 5 SECONDS)

/datum/ai_controller/basic_controller/stickman/ranged
	behavior_tree_json = "code/modules/mob/living/basic/ruin_defender/stickman_ranged.bt.json"
