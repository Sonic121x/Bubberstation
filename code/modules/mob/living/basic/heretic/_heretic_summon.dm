/mob/living/basic/heretic_summon
	name = "邪异恶魔"
	real_name = "邪异恶魔"
	desc = "来自此界之外的恐怖之物，由糟糕的代码召唤而来。"
	icon = 'icons/mob/nonhuman-player/eldritch_mobs.dmi'
	faction = list(FACTION_HERETIC)
	basic_mob_flags = DEL_ON_DEATH
	gender = NEUTER
	mob_biotypes = NONE

	habitable_atmos = null
	status_flags = CANPUSH
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 0, STAMINA = 0, OXY = 0)
	speed = 0
	melee_attack_cooldown = CLICK_CD_MELEE

	attack_sound = 'sound/items/weapons/punch1.ogg'
	response_help_continuous = "想了想还是没敢碰"
	response_help_simple = "想了想还是没敢碰"
	response_disarm_continuous = "胡乱挥手打"
	response_disarm_simple = "胡乱挥手打"
	response_harm_continuous = "撕扯"
	response_harm_simple = "撕扯"
	death_message = "向内坍缩成了一团。"

	unsuitable_atmos_damage = 0
	unsuitable_cold_damage = 0
	unsuitable_heat_damage = 0

	combat_mode = TRUE
	ai_controller = null
	speak_emote = list("尖叫道")
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/heretic_summon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/death_drops, /obj/effect/gibspawner/generic)
	ADD_TRAIT(src, TRAIT_HERETIC_SUMMON, INNATE_TRAIT)
