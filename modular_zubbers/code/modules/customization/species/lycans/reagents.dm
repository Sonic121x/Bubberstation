#define BASE_BURN_PER_SECOND 0.5

/datum/reagent/silver/on_mob_metabolize(mob/living/affected_mob)
	. = ..()

	if (get_lycanthropy_intensity(affected_mob) == 0)
		return

	to_chat(affected_mob, span_userdanger("月神的银钢已深入你的血脉！你的血肉在燃烧沸腾！"))
	affected_mob.emote("scream")

/datum/reagent/silver/on_mob_end_metabolize(mob/living/affected_mob, metabolization_ratio)
	. = ..()

	if (get_lycanthropy_intensity(affected_mob) == 0)
		return

	to_chat(affected_mob, span_bolddanger("当最后一点受祝福的月神之银从你的血液中被滤净，舒适感重新回到你身上。"))

/datum/reagent/silver/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()

	var/intensity = get_lycanthropy_intensity(affected_mob)
	if (intensity == 0)
		return

	// we are a lycan and we have silver in our blood ohhhh noooo broooooooo

	var/damage_amt = BASE_BURN_PER_SECOND * intensity * seconds_per_tick
	affected_mob.apply_damage(
		damage_amt,
		BURN,
		wound_bonus = CANT_WOUND // TODO - maybe have a small chance to cause a burn wound?
	)

	if (SPT_PROB(5, seconds_per_tick))
		to_chat(affected_mob, span_warning("你血管中的银正在灼烧你的狼人之躯……！"))
		affected_mob.emote("scream")

/datum/reagent/silver/proc/get_lycanthropy_intensity(mob/living/carbon/affected_mob)
	if (!ishuman(affected_mob))
		return 0

	if (islycan(affected_mob))
		return 3
	else if (iscursekin(affected_mob))
		return 1

	return 0

#undef BASE_BURN_PER_SECOND
