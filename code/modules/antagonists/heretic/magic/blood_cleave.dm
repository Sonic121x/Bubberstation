/datum/action/cooldown/spell/pointed/cleave
	name = "劈裂"
	desc = "使目标及其周围若干目标产生严重出血。"
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "cleave"
	ranged_mousepointer = 'icons/effects/mouse_pointers/throw_target.dmi'

	school = SCHOOL_FORBIDDEN
	cooldown_time = 45 SECONDS

	invocation = "劈'裂！"
	invocation_type = INVOCATION_WHISPER
	spell_requirements = NONE

	cast_range = 4

	/// The radius of the cleave effect
	var/cleave_radius = 1
	/// What type of wound we apply
	var/wound_type = /datum/wound/slash/flesh/critical/cleave

/datum/action/cooldown/spell/pointed/cleave/is_valid_target(atom/cast_on)
	return ..() && ishuman(cast_on)

/datum/action/cooldown/spell/pointed/cleave/cast(mob/living/carbon/human/cast_on)
	. = ..()
	for(var/mob/living/carbon/human/victim in range(cleave_radius, cast_on))
		if(victim == owner || IS_HERETIC_OR_MONSTER(victim))
			continue
		if(victim.can_block_magic(antimagic_flags))
			victim.visible_message(
				span_danger("[victim]身上闪起火红的光芒，但斥退了烈焰！"),
				span_danger("你的身体开始闪起火红的光芒，但你受到了保护！！")
			)
			continue

		if(!CAN_HAVE_BLOOD(victim))
			continue

		victim.visible_message(
			span_danger("随着一股不洁的烈焰从[victim]的血液中迸发，其血管被由内而外撕碎！"),
			span_danger("你的血管由内爆裂，不洁的火焰从你的血液中喷涌而出！")
		)

		var/obj/item/bodypart/bodypart = pick(victim.get_bodyparts())
		var/datum/wound/slash/flesh/crit_wound = new wound_type()
		crit_wound.apply_wound(bodypart)
		victim.apply_damage(20, BURN, wound_bonus = CANT_WOUND)

		new /obj/effect/temp_visual/cleave(get_turf(victim))

	return TRUE

/datum/action/cooldown/spell/pointed/cleave/long
	name = "次级劈裂"
	cooldown_time = 60 SECONDS
	wound_type = /datum/wound/slash/flesh/severe

/obj/effect/temp_visual/cleave
	icon = 'icons/effects/eldritch.dmi'
	icon_state = "cleave"
	duration = 6
