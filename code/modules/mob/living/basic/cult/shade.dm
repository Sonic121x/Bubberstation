/mob/living/basic/shade
	name = "幽影"
	real_name = "幽影"
	desc = "一个被束缚的灵魂。"
	gender = PLURAL
	icon = 'icons/mob/nonhuman-player/cult.dmi'
	icon_state = "shade_cult"
	icon_living = "shade_cult"
	mob_biotypes = MOB_SPIRIT | MOB_UNDEAD
	maxHealth = 40
	health = 40
	status_flags = CANPUSH
	speak_emote = list("嘶声说")
	response_help_continuous = "把手穿过"
	response_help_simple = "把手穿过"
	response_disarm_continuous = "胡乱挥手打"
	response_disarm_simple = "胡乱挥手打"
	response_harm_continuous = "拳击"
	response_harm_simple = "拳击"
	melee_damage_lower = 5
	melee_damage_upper = 12
	attack_verb_continuous = "以形而上的力量打击"
	attack_verb_simple = "以形而上的力量打击"
	unsuitable_cold_damage = 0
	unsuitable_heat_damage = 0
	unsuitable_atmos_damage = 0
	speed = -1
	faction = list(FACTION_CULT)
	basic_mob_flags = DEL_ON_DEATH
	initial_language_holder = /datum/language_holder/construct
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, STAMINA = 0, OXY = 1)
	/// Theme controls color. THEME_CULT is red THEME_WIZARD is purple and THEME_HOLY is blue
	var/theme = THEME_CULT
	/// The different flavors of goop shades can drop, depending on theme.
	var/static/list/remains_by_theme = list(
		THEME_CULT = /obj/item/ectoplasm/construct,
		THEME_HOLY = /obj/item/ectoplasm/angelic,
		THEME_WIZARD = /obj/item/ectoplasm/mystic,
		THEME_HERETIC = /obj/item/ectoplasm/construct,
	)

/mob/living/basic/shade/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/simple_flying)
	add_traits(list(TRAIT_HEALS_FROM_CULT_PYLONS, TRAIT_SPACEWALK, TRAIT_VENTCRAWLER_ALWAYS), INNATE_TRAIT)
	if(isnull(theme))
		return
	icon_state = "shade_[theme]"
	var/remains = remains_by_theme[theme]
	if(remains)
		AddElement(/datum/element/death_drops, remains)

/mob/living/basic/shade/update_icon_state()
	. = ..()
	if(!isnull(theme))
		icon_state = "shade_[theme]"
	icon_living = icon_state

/mob/living/basic/shade/death()
	if(IS_CULTIST(src))
		SSblackbox.record_feedback("tally", "cult_shade_killed", 1)
	if(death_message == initial(death_message))
		death_message = "发出一声满足的叹息，形体随之舒展开来。"
	..()

/mob/living/basic/shade/can_suicide()
	if(istype(loc, /obj/item/soulstone)) //do not suicide inside the soulstone
		return FALSE
	return ..()

/mob/living/basic/shade/suicide_log(obj/item/suicide_tool)
	if(IS_CULTIST(src))
		SSblackbox.record_feedback("tally", "cult_shade_suicided", 1)
	..()

/mob/living/basic/shade/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/soulstone))
		return ..()

	var/obj/item/soulstone/stone = tool
	stone.capture_shade(src, user)
	return ITEM_INTERACT_SUCCESS
