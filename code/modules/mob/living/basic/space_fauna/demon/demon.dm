/// Player controlled mobs that rip and tear, typically summoned by wizards.
/mob/living/basic/demon
	name = "小恶魔"
	real_name = "小恶魔"
	unique_name = TRUE
	desc = "一只体型庞大、令人生畏的生物，全身覆盖着如铠甲般的黑色鳞片。"

	speak_emote = list("嘎嘎怪笑","尖啸")
	response_help_continuous = "犹豫着不敢碰"
	response_help_simple = "犹豫着不敢碰"
	response_disarm_continuous = "胡乱拍打"
	response_disarm_simple = "胡乱拍打"
	response_harm_continuous = "挥拳打"
	response_harm_simple = "挥拳打"
	attack_verb_continuous = "疯狂撕咬"
	attack_verb_simple = "疯狂撕咬"

	icon = 'icons/mob/simple/demon.dmi'
	icon_state = "demon"
	icon_living = "demon"

	mob_biotypes = MOB_BEAST|MOB_HUMANOID
	status_flags = CANPUSH

	combat_mode = TRUE
	attack_sound = 'sound/effects/magic/demon_attack1.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	faction = list(FACTION_HELL)

	maxHealth = 200
	health = 200
	obj_damage = 40
	melee_damage_lower = 10
	melee_damage_upper = 15
	melee_attack_cooldown = CLICK_CD_MELEE
	death_message = "痛苦地尖叫着，升华成一缕硫磺烟雾。"
	death_sound = 'sound/effects/magic/demon_dies.ogg'

	habitable_atmos = null
	minimum_survivable_temperature = T0C - 25 //Weak to cold
	maximum_survivable_temperature = INFINITY

	basic_mob_flags = DEL_ON_DEATH

	// You KNOW we're doing a lightly purple red
	lighting_cutoff_red = 30
	lighting_cutoff_green = 10
	lighting_cutoff_blue = 20

	physiology = list(STAMINA = 0)

	/// Typepath of the antag datum to add to the demon when applicable
	var/datum/antagonist/antag_type = null

/mob/living/basic/demon/Initialize(mapload)
	. = ..()
	var/list/grantable_loot = grant_loot()
	if(length(grantable_loot))
		AddElement(/datum/element/death_drops, grantable_loot)

/// Proc that adds the necessary loot for the demon. Return an empty list if you don't want to add anything.
/mob/living/basic/demon/proc/grant_loot()
	return list()

/// Proc that just sets up the demon's antagonism status.
/mob/living/basic/demon/mind_initialize()
	. = ..()
	if(isnull(antag_type) || mind.has_antag_datum(antag_type))
		return // we weren't built for this proc to run

	mind.set_assigned_role(SSjob.get_job_type(/datum/job/slaughter_demon))
	mind.add_antag_datum(antag_type)

	SEND_SOUND(src, 'sound/effects/magic/demon_dies.ogg')
	to_chat(src, span_bold("你目前并不与空间站处于同一存在层面。在一滩血液附近使用你的血中穿行技能，即可显形并大肆破坏。"))
