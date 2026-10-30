/atom/movable/screen/alert/status_effect/vulnerable_to_damage
	name = "易受伤害"
	desc = "在身体从自我修复中恢复的期间，你会受到比平常更多的伤害！"
	icon_state = "terrified"

/datum/status_effect/vulnerable_to_damage
	id = "vulnerable_to_damage"
	duration = 5 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/vulnerable_to_damage
	remove_on_fullheal = TRUE
	/// The percentage damage modifier we give the mob we're applied to
	var/damage_resistance_subtraction = 50
	/// How much extra bleeding the mob is given
	var/bleed_modifier_multiplier = 2

/datum/status_effect/vulnerable_to_damage/surgery
	duration = 15 MINUTES

/datum/status_effect/vulnerable_to_damage/on_apply()
	to_chat(owner, span_userdanger("你的身体突然变得虚弱而脆弱！"))
	var/mob/living/carbon/human/carbon_owner = owner
	carbon_owner.damage_resistance -= damage_resistance_subtraction
	MODIFY_PHYSIOLOGY(carbon_owner, PHYS_COEFF_BLEED, bleed_modifier_multiplier)
	return ..()

/datum/status_effect/vulnerable_to_damage/on_remove()
	to_chat(owner, span_notice("你似乎已经从那种非自然的脆弱中恢复过来了！"))
	var/mob/living/carbon/human/carbon_owner = owner
	carbon_owner.damage_resistance += damage_resistance_subtraction
	MODIFY_PHYSIOLOGY(carbon_owner, PHYS_COEFF_BLEED, 1/bleed_modifier_multiplier)
	return ..()
