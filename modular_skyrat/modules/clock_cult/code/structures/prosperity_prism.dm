#define POWER_PER_USE 50

/obj/structure/destructible/clockwork/gear_base/powered/prosperity_prism
	name = "繁荣棱镜"
	desc = "一座棱镜，似乎不知怎地总把目光锁在你身上。"
	clockwork_desc = "一座棱镜，能治愈附近仆从受到的各种伤害，并清除毒素。"
	icon_state = "prolonging_prism"
	base_icon_state = "prolonging_prism"
	anchored = TRUE
	break_message = span_warning("棱镜崩解开来，烟雾逸散到空气中。")
	max_integrity = 150
	minimum_power = POWER_PER_USE
	passive_consumption = POWER_PER_USE / 2


/obj/structure/destructible/clockwork/gear_base/powered/prosperity_prism/process(seconds_per_tick)
	. = ..()
	if(!.)
		return

	for(var/mob/living/possible_cultist in range(3, src)) // Kyler said this is faster than spatial grid
		if(!IS_CLOCK(possible_cultist))
			continue

		if(possible_cultist.health >= possible_cultist.maxHealth)
			continue

		if(use_power(POWER_PER_USE))
			possible_cultist.adjust_tox_loss(-2.5 * seconds_per_tick, forced = TRUE)
			possible_cultist.adjust_stamina_loss(-7.5 * seconds_per_tick)
			possible_cultist.adjust_brute_loss(-2.5 * seconds_per_tick)
			possible_cultist.adjust_fire_loss(-2.5 * seconds_per_tick)
			possible_cultist.adjust_oxy_loss(-2.5 * seconds_per_tick)

			new /obj/effect/temp_visual/heal(get_turf(possible_cultist), "#45dd8a")

			for(var/datum/reagent/toxin/toxin_chem in possible_cultist.reagents.reagent_list)
				possible_cultist.reagents.remove_reagent(toxin_chem.type, 2.5 * seconds_per_tick)

#undef POWER_PER_USE
