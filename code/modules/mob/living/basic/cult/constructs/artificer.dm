/mob/living/basic/construct/artificer
	name = "工匠"
	real_name = "工匠"
	desc = "一个球状的构装体，专职建造并维护纳尔西教团的军队。"
	icon_state = "artificer"
	icon_living = "artificer"
	maxHealth = 50
	health = 50
	response_harm_continuous = "凶狠地痛打"
	response_harm_simple = "凶狠地痛打"
	obj_damage = 60
	melee_damage_lower = 5
	melee_damage_upper = 5
	attack_verb_continuous = "猛撞"
	attack_verb_simple = "猛撞"
	attack_sound = 'sound/items/weapons/punch2.ogg'
	construct_spells = list(
		/datum/action/cooldown/spell/aoe/magic_missile/lesser,
		/datum/action/cooldown/spell/conjure/construct/lesser,
		/datum/action/cooldown/spell/conjure/cult_floor,
		/datum/action/cooldown/spell/conjure/cult_wall,
		/datum/action/cooldown/spell/conjure/soulstone,
		/datum/action/innate/cult/create_rune/revive,
	)
	playstyle_string = "<b>你是一名工匠。你极其虚弱脆弱，\
		但你能建造防御工事、施放魔法飞弹，还能修理友方构装体、怨灵，\
		以及你自己（点击它们即可）。另外，<i>最重要的是，</i>你还能制造灵魂石来捕获灵魂，\
		并制造外壳，把灵魂石放进去，从而创造新的构装体。</b>"

	can_repair = TRUE
	can_repair_self = TRUE
	smashes_walls = TRUE

/mob/living/basic/construct/artificer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	ADD_TRAIT(src, TRAIT_MEDICAL_HUD, INNATE_TRAIT)

/// Hostile NPC version. Heals nearby constructs and cult structures, avoids targets that aren't extremely hurt.
/mob/living/basic/construct/artificer/hostile
	ai_controller = /datum/ai_controller/basic_controller/artificer
	smashes_walls = FALSE
	melee_attack_cooldown = 2 SECONDS

// Alternate artificer themes
/mob/living/basic/construct/artificer/angelic
	desc = "一个球状的构装体，专职建造并维护神圣军队。"
	faction = list(FACTION_HOLY)
	theme = THEME_HOLY
	construct_spells = list(
		/datum/action/cooldown/spell/conjure/soulstone/purified,
		/datum/action/cooldown/spell/conjure/construct/lesser,
		/datum/action/cooldown/spell/aoe/magic_missile/lesser,
		/datum/action/innate/cult/create_rune/revive,
	)

/mob/living/basic/construct/artificer/angelic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_ANGELIC, INNATE_TRAIT)

/mob/living/basic/construct/artificer/mystic
	faction = list(ROLE_WIZARD)
	theme = THEME_WIZARD
	construct_spells = list(
		/datum/action/cooldown/spell/conjure/cult_floor,
		/datum/action/cooldown/spell/conjure/cult_wall,
		/datum/action/cooldown/spell/conjure/soulstone/mystic,
		/datum/action/cooldown/spell/conjure/construct/lesser,
		/datum/action/cooldown/spell/aoe/magic_missile/lesser,
		/datum/action/innate/cult/create_rune/revive,
	)

/mob/living/basic/construct/artificer/noncult
	construct_spells = list(
		/datum/action/cooldown/spell/conjure/cult_floor,
		/datum/action/cooldown/spell/conjure/cult_wall,
		/datum/action/cooldown/spell/conjure/soulstone/noncult,
		/datum/action/cooldown/spell/conjure/construct/lesser,
		/datum/action/cooldown/spell/aoe/magic_missile/lesser,
		/datum/action/innate/cult/create_rune/revive,
	)
