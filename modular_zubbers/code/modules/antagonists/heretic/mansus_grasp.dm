/datum/action/cooldown/spell/touch/mansus_grasp
	desc = "一种接触法术，让你通过握击引导旧神之力。除绘制符文外，任何用途都需要活体心脏。"

/datum/action/cooldown/spell/touch/mansus_grasp/can_hit_with_hand(atom/victim, mob/living/caster)
	. = ..()
	if (!.)
		return FALSE
	if (caster.has_status_effect(/datum/status_effect/void_stealth))
		return FALSE
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(caster)
	if (!isturf(victim))
		if (heretic_datum?.has_living_heart() != HERETIC_HAS_LIVING_HEART)
			caster.balloon_alert(caster, "没有活体心脏，只能绘制符文！")
			return FALSE
		if (heretic_datum.owner?.current && HAS_TRAIT(heretic_datum.owner.current, TRAIT_MANSUS_INHIBITION))
			caster.balloon_alert(caster, "力量受抑制，只能绘制符文！")
			return FALSE
