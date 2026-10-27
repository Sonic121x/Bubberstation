/// SKYRAT MODULE SKYRAT_XENO_REDO

/mob/living/carbon/alien/adult/skyrat/warrior
	name = "异形战士"
	desc = "若有异形配得上“行走的坦克”这个称号，它必定算一个，厚重甲壳和强壮双臂就是明证。"
	caste = "warrior"
	maxHealth = 400
	health = 400
	icon_state = "alienwarrior"
	melee_damage_lower = 30
	melee_damage_upper = 35
	default_organ_types_by_slot = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain/alien,
		ORGAN_SLOT_XENO_HIVENODE = /obj/item/organ/alien/hivenode,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/alien,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/alien,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/alien,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/alien,
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel,
	)

/mob/living/carbon/alien/adult/skyrat/warrior/Initialize(mapload)
	. = ..()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/spell/aoe/repulse/xeno/skyrat_tailsweep,
		/datum/action/cooldown/mob_cooldown/charge/basic_charge/defender,
		/datum/action/cooldown/alien/skyrat/warrior_agility,
	)
	grant_actions_by_list(innate_actions)

	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

	add_movespeed_modifier(/datum/movespeed_modifier/alien_big)

/datum/action/cooldown/alien/skyrat/warrior_agility
	name = "敏捷模式"
	desc = "改为四足行进，提高速度，代价是伤害降低且无法使用大多数能力。"
	button_icon_state = "the_speed_is_alot"
	cooldown_time = 1 SECONDS
	can_be_used_always = TRUE
	/// Is the warrior currently running around on all fours?
	var/being_agile = FALSE

/datum/action/cooldown/alien/skyrat/warrior_agility/Activate()
	. = ..()
	if(!being_agile)
		begin_agility()
		return TRUE
	if(being_agile)
		end_agility()
		return TRUE

/// Handles the visual indication and code activation of the warrior agility ability (say that five times fast)
/datum/action/cooldown/alien/skyrat/warrior_agility/proc/begin_agility()
	var/mob/living/carbon/alien/adult/skyrat/agility_target = owner
	agility_target.balloon_alert(agility_target, "敏捷模式已开启")
	to_chat(agility_target, span_danger("我们伏下身体四足行进，速度大幅提高，但无法使用大多数能力。"))
	playsound(agility_target, 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_hiss.ogg', 100, TRUE, 8, 0.9)
	agility_target.icon_state = "alien[agility_target.caste]_mobility"

	being_agile = TRUE
	agility_target.add_movespeed_modifier(/datum/movespeed_modifier/warrior_agility)
	agility_target.unable_to_use_abilities = TRUE

	agility_target.melee_damage_lower = 15
	agility_target.melee_damage_upper = 20

/// Handles the visual indicators and code side of deactivating the agility ability
/datum/action/cooldown/alien/skyrat/warrior_agility/proc/end_agility()
	var/mob/living/carbon/alien/adult/skyrat/agility_target = owner
	agility_target.balloon_alert(agility_target, "敏捷模式已结束")
	playsound(agility_target, 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_roar2.ogg', 100, TRUE, 8, 0.9) //Warrior runs up on all fours, stands upright, screams at you
	agility_target.icon_state = "alien[agility_target.caste]"

	being_agile = FALSE
	agility_target.remove_movespeed_modifier(/datum/movespeed_modifier/warrior_agility)
	agility_target.unable_to_use_abilities = FALSE

	agility_target.melee_damage_lower = initial(agility_target.melee_damage_lower)
	agility_target.melee_damage_upper = initial(agility_target.melee_damage_upper)

/datum/movespeed_modifier/warrior_agility
	multiplicative_slowdown = -2
