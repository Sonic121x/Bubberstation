/// A nasty little robotic bug that dusts people on attack. Jeepers. This should be a very, very, very rare spawn.
/mob/living/basic/supermatter_spider
	name = "超物质蜘蛛"
	desc= "一片超物质碎晶，安放在经过机械强化的底座上。"

	icon = 'icons/mob/simple/smspider.dmi'
	icon_state = "smspider"
	icon_living = "smspider"
	icon_dead = "smspider_dead"

	gender = NEUTER
	status_flags = CANPUSH
	mob_biotypes = MOB_BUG|MOB_ROBOTIC|MOB_MINERAL
	speak_emote = list("震动")


	attack_verb_continuous = "切割"
	attack_verb_simple = "切割"
	attack_sound = 'sound/effects/supermatter.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW

	maxHealth = 10
	health = 10
	minimum_survivable_temperature = TCMB
	maximum_survivable_temperature = T0C + 1250
	habitable_atmos = null
	death_message = "跌落在地，它的晶片黯淡成了可悲的灰色！"
	physiology = list(STAMINA = 0)

	faction = list(FACTION_HOSTILE)

	// Gold, supermatter tinted
	lighting_cutoff_red = 30
	lighting_cutoff_green = 30
	lighting_cutoff_blue = 10

	ai_controller = /datum/ai_controller/basic_controller/supermatter_spider

	/// If we successfully dust something, should we die?
	var/single_use = TRUE

/mob/living/basic/supermatter_spider/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_WEB_SURFER, INNATE_TRAIT)
	AddComponent(/datum/component/swarming)

	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_CLAW)

/// Proc that we call on attacking something to dust 'em.
/mob/living/basic/supermatter_spider/early_melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if(.)
		return

	if(isliving(target))
		var/mob/living/victim = target
		victim.investigate_log("被 [src] 化为灰烬。", INVESTIGATE_DEATHS)
		dust_feedback(target)
		victim.dust()
		if(single_use)
			death()
		return BASIC_MOB_END_ATTACK_CHAIN_COOLDOWN

	if(!isturf(target))
		dust_feedback(target)
		qdel(target)
		if(single_use)
			death()
		return BASIC_MOB_END_ATTACK_CHAIN_COOLDOWN

/// Simple proc that plays the supermatter dusting sound and sends a visible message.
/mob/living/basic/supermatter_spider/proc/dust_feedback(atom/target)
	playsound(get_turf(src), 'sound/effects/supermatter.ogg', 10, TRUE)
	visible_message(span_danger("[src] 撞上了 [target]，在一道耀眼的光芒中将其化为尘埃！"))

/mob/living/basic/supermatter_spider/overcharged
	name = "超载超物质蜘蛛"
	desc = "一片超载的超物质碎晶，安放在经过机械强化的底座上。这一只看起来格外危险。"
	icon_state = "smspideroc"
	icon_living = "smspideroc"
	maxHealth = 25
	health = 25
	single_use = FALSE

/datum/ai_controller/basic_controller/supermatter_spider
	behavior_tree_json = "code/modules/mob/living/basic/space_fauna/supermatter_spider.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_HEAR = list("叮当作响。", "哐当作响。"),
			BB_EMOTE_SEE = list("嗡嗡震动。"),
			BB_SPEAK_CHANCE = 7,
		),
	)

	ai_movement = /datum/ai_movement/basic_avoidance
