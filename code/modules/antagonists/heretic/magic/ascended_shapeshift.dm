// Given to ascended knock heretics, is a form of shapeshift that can turn into all 4 common heretic summons, and is not limited to 1 selection.
/datum/action/cooldown/spell/shapeshift/eldritch/ascension
	name = "飞升变形"
	desc = "一种让你化身为另一种邪异生物并获取其能力的法术。\
		你可以随时更换选择，即使你的化身死亡，你也不会死去。"
	cooldown_time = 20 SECONDS
	convert_damage = FALSE
	die_with_shapeshifted_form = FALSE
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "lock_ascension"
	possible_shapes = list(
		/mob/living/basic/heretic_summon/ash_spirit,
		/mob/living/basic/heretic_summon/raw_prophet/ascended,
		/mob/living/basic/heretic_summon/rust_walker,
		/mob/living/basic/heretic_summon/stalker,
	)

/datum/action/cooldown/spell/shapeshift/eldritch/ascension/do_shapeshift(mob/living/caster)
	. = ..()
	if(!.)
		return
	//buff our forms so this ascension ability isnt shit
	playsound(caster, 'sound/effects/magic/demon_consume.ogg', 50, TRUE)
	var/mob/living/monster = .
	monster.AddComponent(/datum/component/seethrough_mob)
	monster.maxHealth *= 1.5
	monster.health = monster.maxHealth
	monster.melee_damage_lower = max((monster.melee_damage_lower * 2), 40)
	monster.melee_damage_upper = monster.melee_damage_upper / 2
	monster.transform *= 1.5
	monster.AddElement(/datum/element/wall_tearer)

/datum/action/cooldown/spell/shapeshift/eldritch/ascension/do_unshapeshift(mob/living/caster)
	. = ..()
	shapeshift_type = null //pick another loser
