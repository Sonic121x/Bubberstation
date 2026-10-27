/mob/living/basic/construct/juggernaut
	name = "主宰"
	real_name = "主宰"
	desc = "一个巨大、重装的构装体，专为领头发动攻击并承受敌方火力而造。"
	icon_state = "juggernaut"
	icon_living = "juggernaut"
	maxHealth = 150
	health = 150
	response_harm_continuous = "徒劳地拳击"
	response_harm_simple = "徒劳地拳击"
	obj_damage = 90
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "以重装护手猛砸"
	attack_verb_simple = "以重装护手猛砸"
	speed = 2.5
	attack_sound = 'sound/items/weapons/punch3.ogg'
	status_flags = NONE
	mob_size = MOB_SIZE_LARGE
	construct_spells = list(
		/datum/action/cooldown/spell/basic_projectile/juggernaut,
		/datum/action/cooldown/spell/forcewall/cult,
		/datum/action/innate/cult/create_rune/wall,
	)
	playstyle_string = span_bold("你是一名主宰。虽然行动迟缓，但你的外壳能承受沉重打击、制造盾墙、把敌人和墙壁一并撕碎，甚至能弹开能量武器。")

	smashes_walls = TRUE

/mob/living/basic/construct/juggernaut/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/damage_threshold, 10)

/// Hostile NPC version. Pretty dumb, just attacks whoever is near.
/mob/living/basic/construct/juggernaut/hostile
	ai_controller = /datum/ai_controller/basic_controller/juggernaut
	smashes_walls = FALSE
	melee_attack_cooldown = 2 SECONDS

/mob/living/basic/construct/juggernaut/projectile_hit(obj/projectile/hitting_projectile, def_zone, piercing_hit, blocked)
	if(!istype(hitting_projectile, /obj/projectile/energy) && !istype(hitting_projectile, /obj/projectile/beam))
		return ..()
	if(!prob(40 - round(hitting_projectile.damage / 3))) // reflect chance
		return ..()

	apply_damage(hitting_projectile.damage * 0.5, hitting_projectile.damage_type)
	visible_message(
		span_danger("\The [hitting_projectile] 被 [src] 的重装外壳弹开了！"),
		span_userdanger("\The [hitting_projectile] 被你的重装外壳弹开了！"),
	)

	hitting_projectile.reflect(src)
	return BULLET_ACT_FORCE_PIERCE // complete projectile permutation

// Alternate juggernaut themes
/mob/living/basic/construct/juggernaut/angelic
	faction = list(FACTION_HOLY)
	theme = THEME_HOLY

/mob/living/basic/construct/juggernaut/angelic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_ANGELIC, INNATE_TRAIT)

/mob/living/basic/construct/juggernaut/mystic
	faction = list(ROLE_WIZARD)
	theme = THEME_WIZARD
