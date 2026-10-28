/mob/living/basic/blankbody
	name = "空白躯体"
	desc = "它看起来足够像人类，但血肉有着灰烬般的质感，脸上毫无五官，只有一抹诡异的微笑。"
	icon_state = "blank-body"
	icon_living = "blank-body"
	icon_dead = "blank-dead"
	health = 100
	maxHealth = 100
	obj_damage = 50
	melee_damage_lower = 2
	melee_damage_upper = 6
	speed = 1
	attack_verb_continuous = "挥拳打"
	attack_verb_simple = "挥拳打"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	melee_attack_cooldown = 1 SECONDS
	faction = list(FACTION_NETHER)
	speak_emote = list("尖叫")
	death_message = "崩解成细小的尘埃。"
	unsuitable_atmos_damage = 0
	unsuitable_cold_damage = 0
	unsuitable_heat_damage = 0
	// Pink, like their skin
	lighting_cutoff_red = 30
	lighting_cutoff_green = 15
	lighting_cutoff_blue = 40

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile_obstacles
	physiology = list(STAMINA = 0)

/mob/living/basic/blankbody/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_NETHER, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 0)
	AddComponent(/datum/component/health_scaling_effects, min_health_attack_modifier_lower = 8, min_health_attack_modifier_upper = 14)
