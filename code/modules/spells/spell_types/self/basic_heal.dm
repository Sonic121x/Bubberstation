// This spell exists mainly for debugging purposes, and also to show how casting works
/datum/action/cooldown/spell/basic_heal
	name = "次级治疗"
	desc = "为施法者治疗少量钝伤与烧伤。"

	sound = 'sound/effects/magic/staff_healing.ogg'
	school = SCHOOL_RESTORATION
	cooldown_time = 10 SECONDS
	cooldown_reduction_per_rank = 1.25 SECONDS
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC|SPELL_REQUIRES_HUMAN

	invocation = "Victus sano!"
	invocation_type = INVOCATION_WHISPER

	/// Amount of brute to heal to the spell caster on cast
	var/brute_to_heal = 10
	/// Amount of burn to heal to the spell caster on cast
	var/burn_to_heal = 10

/datum/action/cooldown/spell/basic_heal/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/basic_heal/cast(mob/living/cast_on)
	. = ..()
	cast_on.visible_message(
		span_warning("一圈柔和的光芒掠过 [cast_on]！"),
		span_notice("你用治疗之光把自己环绕起来！"),
	)
	var/need_mob_update = FALSE
	need_mob_update += cast_on.adjust_brute_loss(-brute_to_heal, updating_health = FALSE)
	need_mob_update += cast_on.adjust_fire_loss(-burn_to_heal, updating_health = FALSE)
	if(need_mob_update)
		cast_on.updatehealth()
