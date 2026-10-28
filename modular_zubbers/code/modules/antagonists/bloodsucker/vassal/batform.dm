/**
 * # BATFORM
 *
 * TG removed this, so we're re-adding it
 */
/datum/action/cooldown/spell/shapeshift/bat
	name = "蝙蝠形态"
	desc = "化身太空蝙蝠。你可以飞行、在黑暗中视物，并通过近战攻击恢复生命。"
	background_icon_state = "tremere_power_off"
	active_background_icon_state = "tremere_power_on"
	base_background_icon_state = "tremere_power_off"
	background_icon = 'modular_zubbers/icons/mob/actions/tremere_bloodsucker.dmi'
	power_explanation = "你可以飞行、在黑暗中视物，并通过近战攻击恢复生命。"
	invocation = "主人，赐予我力量，蝙蝠形态！！"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = NONE
	convert_damage = TRUE
	cooldown_time = 1 MINUTES
	possible_shapes = list(/mob/living/basic/bat/bloodsucker)
	power_explanation = "此能力将你变成一只小蝙蝠，可以飞行并通过造成近战伤害自愈。\n\
		不过你的近战伤害不高，而且略微畏惧火焰伤害。\n\
		施放时还会在周围生成一些普通蝙蝠，扰乱视线。\n\
		请注意，此形态死亡会使本体一同死亡，受到的所有伤害也会转移。"
	var/bats_to_spawn = 3

/datum/action/cooldown/spell/shapeshift/bat/cast(mob/living/cast_on)
	. = ..()
	// spawn bats around
	if(!get_turf(cast_on))
		return
	for(var/i in 1 to bats_to_spawn)
		var/mob/living/basic/bat/bat = new(get_turf(cast_on))
		QDEL_IN(bat, cooldown_time)
		random_step(bat, 2, 50)

/mob/living/basic/bat/bloodsucker
	name ="吸血蝙蝠"
	desc = "一只渴望鲜血的蝙蝠。"
	maxHealth = 100
	health = 100
	speed = 0
	melee_damage_lower = 10
	melee_damage_upper = 15
	wound_bonus = 10
	obj_damage = 10
	lighting_cutoff_red = 25
	lighting_cutoff_green = 8
	lighting_cutoff_blue = 5
	melee_attack_cooldown = CLICK_CD_MELEE
	basic_mob_flags = FLAMMABLE_MOB
	lighting_color_cutoffs = BLOODSUCKER_SIGHT_COLOR_CUTOFF
	physiology = list(BRUTE = 0.9, BURN = 1.25, TOX = 1, STAMINA = 1, OXY = 1)
	attack_verb_simple = "吸血"
	attack_verb_continuous = "吸血"

/mob/living/basic/bat/bloodsucker/Initialize(mapload)
	. = ..()
	// Go as fast as people can run
	AddElement(/datum/element/lifesteal, melee_damage_lower)
	// Too fat to fit through vents
	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
