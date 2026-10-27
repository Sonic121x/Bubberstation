/datum/martial_art/psychotic_brawling
	name = "癫狂斗殴术"
	id = MARTIALART_PSYCHOBRAWL
	pacifist_style = TRUE

/datum/martial_art/psychotic_brawling/disarm_act(mob/living/attacker, mob/living/defender)
	return psycho_attack(attacker, defender)

/datum/martial_art/psychotic_brawling/grab_act(mob/living/attacker, mob/living/defender)
	return psycho_attack(attacker, defender, TRUE)

/datum/martial_art/psychotic_brawling/harm_act(mob/living/attacker, mob/living/defender)
	return psycho_attack(attacker, defender)

/datum/martial_art/psychotic_brawling/proc/psycho_attack(mob/living/attacker, mob/living/defender, grab_attack)
	var/atk_verb
	switch(rand(1,8))
		if(1)
			if(iscarbon(defender) && iscarbon(attacker))
				var/mob/living/carbon/carbon_defender = defender
				carbon_defender.help_shake_act(attacker)
			atk_verb = "帮助了"
		if(2)
			attacker.emote("cry")
			attacker.Stun(2 SECONDS)
			atk_verb = "哭着望向"
		if(3)
			if(defender.check_block(attacker, 0, "[attacker]的抓取", UNARMED_ATTACK))
				return MARTIAL_ATTACK_FAIL
			if(attacker.body_position == LYING_DOWN)
				return MARTIAL_ATTACK_INVALID

			if(attacker.grab_state >= GRAB_AGGRESSIVE)
				defender.grabbedby(attacker, 1)
			else
				attacker.start_pulling(defender, supress_message = TRUE)
				if(attacker.pulling)
					defender.drop_all_held_items()
					defender.stop_pulling()
					if(grab_attack)
						log_combat(attacker, defender, "grabbed", addition="aggressively")
						defender.visible_message(
							span_warning("[attacker]猛地抓住了[defender]！"),
							span_userdanger("[attacker]猛地抓住了你！"),
							span_hear("你听到了粗暴拉扯的声音！"),
							null,
							attacker,
						)
						to_chat(attacker, span_danger("你猛地抓住了[defender]！"))
						attacker.setGrabState(GRAB_AGGRESSIVE) //Instant aggressive grab
					else
						log_combat(attacker, defender, "grabbed", addition="passively")
						attacker.setGrabState(GRAB_PASSIVE)
		if(4)
			atk_verb = "头槌"
			var/defender_damage = rand(5, 10)
			if(defender.check_block(attacker, defender_damage, "[attacker]的[atk_verb]", UNARMED_ATTACK))
				return MARTIAL_ATTACK_FAIL

			attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
			attacker.emote("flip")
			defender.visible_message(
				span_danger("[attacker]用[atk_verb]撞击了[defender]！"),
				span_userdanger("[attacker]用[atk_verb]撞击了你！"),
				span_hear("你听到了令人作呕的肉体撞击声！"),
				null,
				attacker,
			)
			to_chat(attacker, span_danger("你用[atk_verb]撞击了[defender]！"))
			playsound(defender, 'sound/items/weapons/punch1.ogg', 40, TRUE, -1)
			defender.apply_damage(defender_damage, attacker.get_attack_type(), BODY_ZONE_HEAD)
			attacker.apply_damage(rand(5, 10), attacker.get_attack_type(), BODY_ZONE_HEAD)
			if(iscarbon(defender))
				var/mob/living/carbon/carbon_defender = defender
				if(!istype(carbon_defender.get_item_by_slot(ITEM_SLOT_HEAD), /obj/item/clothing/head/helmet) && !istype(carbon_defender.get_item_by_slot(ITEM_SLOT_HEAD), /obj/item/clothing/head/utility/hardhat))
					carbon_defender.adjust_organ_loss(ORGAN_SLOT_BRAIN, 5)
			attacker.Stun(rand(1 SECONDS, 4.5 SECONDS))
			defender.Stun(rand(0.5 SECONDS, 3 SECONDS))
			if(HAS_TRAIT(attacker, TRAIT_PACIFISM))
				attacker.add_mood_event("bypassed_pacifism", /datum/mood_event/pacifism_bypassed)
		if(5,6)
			atk_verb = pick("踢击", "击打", "猛击")
			if(defender.check_block(attacker, 0, "[attacker]的[atk_verb]", UNARMED_ATTACK))
				return MARTIAL_ATTACK_FAIL

			attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
			defender.visible_message(
				span_danger("[attacker]以非人的力量[atk_verb]了[defender]，将其打得向后飞去！"),
				span_userdanger("[attacker]以非人的力量[atk_verb]了你，将你打得向后飞去！"),
				span_hear("你听到了令人作呕的肉体撞击声！"),
				null,
				attacker,
			)
			to_chat(attacker, span_danger("你以非人的力量[atk_verb]了[defender]，将其打得向后飞去！"))
			defender.apply_damage(rand(15, 30), attacker.get_attack_type())
			playsound(defender, 'sound/effects/meteorimpact.ogg', 25, TRUE, -1)
			var/throwtarget = get_edge_target_turf(attacker, get_dir(attacker, get_step_away(defender, attacker)))
			defender.throw_at(throwtarget, 4, 2, attacker)//So stuff gets tossed around at the same time.
			defender.Paralyze(6 SECONDS)
			if(HAS_TRAIT(attacker, TRAIT_PACIFISM))
				attacker.add_mood_event("bypassed_pacifism", /datum/mood_event/pacifism_bypassed)
		if(7,8)
			return MARTIAL_ATTACK_INVALID //Resume default behaviour

	if(atk_verb)
		log_combat(attacker, defender, "[atk_verb] (Psychotic Brawling)")
		return MARTIAL_ATTACK_SUCCESS

	return MARTIAL_ATTACK_FAIL
