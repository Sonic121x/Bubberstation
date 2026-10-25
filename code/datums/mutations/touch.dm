/datum/mutation/shock
	name = "电击之触"
	desc = "受试者能够将环境中的多余电力引导至双手，以基本无害的方式电击他人。"
	quality = POSITIVE
	locked = TRUE
	difficulty = 16
	text_gain_indication = span_notice("你感觉电力流过双手。")
	text_lose_indication = span_notice("你双手中的能量消散了。")
	power_path = /datum/action/cooldown/spell/touch/shock
	instability = POSITIVE_INSTABILITY_MODERATE // bad stun baton
	energy_coeff = 1
	power_coeff = 1

/datum/mutation/shock/setup()
	. = ..()
	var/datum/action/cooldown/spell/touch/shock/to_modify =.

	if(!istype(to_modify)) // null or invalid
		return

	if(GET_MUTATION_POWER(src) <= 1)
		to_modify.stagger = initial(to_modify.stagger)
		return

	to_modify.stagger = TRUE

/datum/action/cooldown/spell/touch/shock
	name = "电击之触"
	desc = "将电流引导至手中来电击别人。基本无害！基本上……"
	button_icon_state = "zap"
	sound = 'sound/items/weapons/zapbang.ogg'
	cooldown_time = 7 SECONDS
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	antimagic_flags = NONE

	///This var decides if the spell should stagger, dictated by presence of power chromosome
	var/stagger = FALSE

	hand_path = /obj/item/melee/touch_attack/shock
	draw_message = span_notice("你将电流引导至手中。")
	drop_message = span_notice("你让手中的电流消散了。")

/datum/action/cooldown/spell/touch/shock/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/caster)
	if(iscarbon(victim))
		var/mob/living/carbon/carbon_victim = victim
		if(carbon_victim.electrocute_act(5, caster, 1, SHOCK_NOGLOVES | SHOCK_NOSTUN))//doesn't stun. never let this stun

			var/obj/item/bodypart/affecting = carbon_victim.get_bodypart(carbon_victim.get_random_valid_zone(caster.zone_selected))
			var/armor_block = carbon_victim.run_armor_check(affecting, ENERGY)
			carbon_victim.apply_damage(20, STAMINA, def_zone = affecting, blocked = armor_block)

			carbon_victim.dropItemToGround(carbon_victim.get_active_held_item())
			carbon_victim.dropItemToGround(carbon_victim.get_inactive_held_item())
			carbon_victim.adjust_confusion(15 SECONDS)
			carbon_victim.visible_message(
				span_danger("[caster]电击了[victim]！"),
				span_userdanger("[caster]电击了你！"),
			)
			if(stagger)
				carbon_victim.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH * 2, 10 SECONDS)
			return TRUE

	else if(isliving(victim))
		var/mob/living/living_victim = victim
		if(living_victim.electrocute_act(15, caster, 1, SHOCK_NOSTUN)) //We do damage here because non-carbon mobs typically ignore stamina damage.
			living_victim.visible_message(
				span_danger("[caster]电击了[victim]！"),
				span_userdanger("[caster]电击了你！"),
			)
			if(stagger)
				living_victim.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH * 2, 10 SECONDS)
			return TRUE

	to_chat(caster, span_warning("电流似乎对[victim]不起作用……"))
	return TRUE

/obj/item/melee/touch_attack/shock
	name = "\improper 电击之触"
	desc = "这有点像在长毛地毯上摩擦双脚后去电朋友，只是危险得多。"
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "zapper"
	inhand_icon_state = "zapper"

/datum/mutation/lay_on_hands
	name = "抚愈之触"
	desc = "受试者能够将手放在他人身上，将对方的少量伤势转移到自身。"
	quality = POSITIVE
	locked = FALSE
	difficulty = 16
	text_gain_indication = span_notice("你的双手仿佛受到了祝福！")
	text_lose_indication = span_notice("你的双手不再有受祝福的感觉了。")
	power_path = /datum/action/cooldown/spell/touch/lay_on_hands
	instability = POSITIVE_INSTABILITY_MAJOR
	energy_coeff = 1
	power_coeff = 1
	synchronizer_coeff = 1

/datum/mutation/lay_on_hands/setup()
	. = ..()
	var/datum/action/cooldown/spell/touch/lay_on_hands/to_modify =.

	if(!istype(to_modify)) // null or invalid
		return

	// Transfers more damage if strengthened. (1.5 with power chromosome)
	to_modify.power_coefficient = GET_MUTATION_POWER(src)
	// Halves transferred damage if synchronized. (0.5 with synchronizer chromosome)
	to_modify.synchronizer_coefficient = GET_MUTATION_SYNCHRONIZER(src)

/datum/action/cooldown/spell/touch/lay_on_hands
	name = "抚愈之触"
	desc = "将手放在他人身上，把对方的少量身体伤势转移到自己身上。\
		不知为何，这种力量对亡灵或道德观念古怪的人不太友好。"
	button_icon = 'icons/mob/actions/actions_genetic.dmi'
	button_icon_state = "mending_touch"
	sound = 'sound/effects/magic/staff_healing.ogg'
	cooldown_time = 12 SECONDS
	school = SCHOOL_RESTORATION
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	antimagic_flags = NONE

	hand_path = /obj/item/melee/touch_attack/lay_on_hands
	draw_message = span_notice("你抬起手，准备将伤势转移到自己身上。")
	drop_message = span_notice("你放下了手。")
	/// Multiplies the amount healed (or damage dealt, in the case of a smite).
	var/heal_multiplier = 1
	/// Multiplies the incoming pain from healing. (Halved with synchronizer chromosome)
	var/pain_multiplier = 1
	/// Icon used for beaming effect
	var/beam_icon = "blood"
	/// The mutation's power coefficient.
	var/power_coefficient = 1
	/// The mutation's synchronizer coefficient.
	var/synchronizer_coefficient = 1

/datum/action/cooldown/spell/touch/lay_on_hands/create_hand(mob/living/carbon/cast_on)
	. = ..()
	if(!.)
		return .
	var/obj/item/bodypart/transfer_limb = cast_on.get_active_hand()
	if(!IS_ORGANIC_LIMB(transfer_limb))
		to_chat(cast_on, span_notice("你无法通过无机质的手引导治愈之力。"))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/touch/lay_on_hands/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/mendicant)

	var/mob/living/hurtguy = victim

	heal_multiplier = initial(heal_multiplier) * power_coefficient
	pain_multiplier = initial(pain_multiplier) * synchronizer_coefficient

	// Message to show on a successful heal if the healer has a special pacifism interaction with the mutation.
	var/peaceful_message = null

	var/success

	var/hurt_this_guy = determine_if_this_hurts_instead(mendicant, hurtguy)

	if (hurt_this_guy && (HAS_TRAIT(mendicant, TRAIT_PACIFISM) || !mendicant.combat_mode)) //Returns if we're a pacifist and we'd hurt them, or we're not in combat mode and we'll hurt them
		mendicant.balloon_alert(mendicant, "这会伤害[hurtguy]！")
		return FALSE

	if(hurt_this_guy)
		return by_gods_light_i_smite_you(mendicant, hurtguy, heal_multiplier)

	// Heal more, hurt a bit more.
	// If you crunch the numbers it sounds crazy good,
	// but I think that's a fair reward for combining the efforts of Genetics, Medbay, and Mining to reach a hidden mechanic.
	if(HAS_TRAIT_FROM(mendicant, TRAIT_HIPPOCRATIC_OATH, HIPPOCRATIC_OATH_TRAIT))
		heal_multiplier *= 2
		pain_multiplier *= 0.5
		peaceful_message = span_boldnotice("你能感到阿斯克勒庇俄斯之杖的魔力正在帮助你！")
		beam_icon = "sendbeam"
		var/obj/item/rod_of_asclepius/rod = locate() in mendicant.contents
		if(rod)
			rod.add_filter("cool_glow", 2, list("type" = "outline", "color" = COLOR_VERY_PALE_LIME_GREEN, "size" = 1.25))
			addtimer(CALLBACK(rod, TYPE_PROC_REF(/datum, remove_filter), "cool_glow"), 6 SECONDS)

	// If a normal pacifist, transfer more.
	else if(HAS_TRAIT(mendicant, TRAIT_PACIFISM))
		heal_multiplier *= 1.75
		peaceful_message = span_boldnotice("你爱好和平的天性帮助你将所有痛苦引向自己。")

	if(iscarbon(hurtguy))
		success = do_complicated_heal(mendicant, hurtguy, heal_multiplier, pain_multiplier)
	else
		success = do_simple_heal(mendicant, hurtguy, heal_multiplier, pain_multiplier)

	// No healies in the end, cancel
	if(!success)
		return FALSE

	if(peaceful_message)
		to_chat(mendicant, peaceful_message)

	// Both types can be ignited (technically at least), so we can just do this here.
	if(hurtguy.fire_stacks > 0)
		mendicant.set_fire_stacks(hurtguy.fire_stacks * pain_multiplier, remove_wet_stacks = TRUE)
		if(hurtguy.on_fire)
			mendicant.ignite_mob()
			hurtguy.extinguish_mob()

	mendicant.Beam(hurtguy, icon_state = beam_icon, time = 0.5 SECONDS)
	beam_icon = initial(beam_icon)

	hurtguy.update_damage_overlays()
	mendicant.update_damage_overlays()

	hurtguy.visible_message(span_notice("[mendicant]将双手放在[hurtguy]身上！"))
	to_chat(hurtguy, span_boldnotice("[mendicant]将双手放在你身上，为你治疗！"))
	new /obj/effect/temp_visual/heal(get_turf(hurtguy), COLOR_VERY_PALE_LIME_GREEN)
	return success

/datum/action/cooldown/spell/touch/lay_on_hands/proc/do_simple_heal(mob/living/carbon/mendicant, mob/living/hurtguy, heal_multiplier, pain_multiplier)
	// Did the transfer work?
	. = FALSE

	// Damage to heal
	var/brute_to_heal = min(hurtguy.get_brute_loss(), 35 * heal_multiplier)
	// no double dipping
	var/burn_to_heal = min(hurtguy.get_fire_loss(), (35 - brute_to_heal) * heal_multiplier)

	// Get at least organic limb to transfer the damage to
	var/list/mendicant_organic_limbs = list()
	for(var/obj/item/bodypart/possible_limb in mendicant.get_bodyparts())
		if(IS_ORGANIC_LIMB(possible_limb))
			mendicant_organic_limbs += possible_limb
	// None? Gtfo
	if(!length(mendicant_organic_limbs))
		mendicant.balloon_alert(mendicant, "没有有机肢体！")
		return .

	// Try to use our active hand, otherwise pick at random
	var/obj/item/bodypart/mendicant_transfer_limb = mendicant.get_active_hand()
	if(!(mendicant_transfer_limb in mendicant_organic_limbs))
		mendicant_transfer_limb = pick(mendicant_organic_limbs)
		mendicant_transfer_limb.receive_damage(brute_to_heal * pain_multiplier, burn_to_heal * pain_multiplier, forced = TRUE, wound_bonus = CANT_WOUND)

	if(brute_to_heal)
		hurtguy.adjust_brute_loss(-brute_to_heal)
		. = TRUE

	if(burn_to_heal)
		hurtguy.adjust_fire_loss(-burn_to_heal)
		. = TRUE

	if(!.)
		hurtguy.balloon_alert(mendicant, "没有受伤！")

/datum/action/cooldown/spell/touch/lay_on_hands/proc/do_complicated_heal(mob/living/carbon/mendicant, mob/living/carbon/hurtguy, heal_multiplier, pain_multiplier)

	// Did the transfer work?
	. = FALSE

	// Counter to make sure we don't take too much from separate limbs
	var/healing_budget = 35 * heal_multiplier
	// Transfer damage from each limb to the mendicant's counterpart.
	for(var/obj/item/bodypart/affected_limb as anything in hurtguy.get_bodyparts())
		if(!(affected_limb.bodytype & BODYTYPE_ORGANIC))
			continue
		var/obj/item/bodypart/mendicant_transfer_limb = mendicant.get_bodypart(affected_limb.body_zone)
		var/list/mendicant_organic_limbs = list()
		for(var/obj/item/bodypart/possible_limb in mendicant.get_bodyparts(include_stumps = TRUE)) // Keeping this here in case stumps can store damage in the future
			if(IS_ORGANIC_LIMB(possible_limb) && !IS_STUMP(possible_limb)) // No stumps are currently organic, this is futureproofing.
				mendicant_organic_limbs += possible_limb
		// Spread the healing between brute and burn
		var/affected_limb_damage = affected_limb.brute_dam + affected_limb.burn_dam
		var/brute_damage = 0
		var/burn_damage = 0
		if(healing_budget >= affected_limb_damage)
			healing_budget -= affected_limb_damage
			brute_damage = affected_limb.brute_dam
			burn_damage = affected_limb.burn_dam
		else
			if(affected_limb.brute_dam > affected_limb.burn_dam)
				burn_damage = min(affected_limb.burn_dam, healing_budget/2)
				brute_damage = healing_budget - burn_damage
			else
				brute_damage = min(affected_limb.burn_dam, healing_budget/2)
				burn_damage = healing_budget - brute_damage
			healing_budget = 0
		if((brute_damage || burn_damage))
			. = TRUE
			var/brute_taken = brute_damage * pain_multiplier
			var/burn_taken = burn_damage * pain_multiplier
			// Heal!
			affected_limb.heal_damage(brute_damage, burn_damage, required_bodytype = BODYTYPE_ORGANIC)
			// Hurt!
			if((mendicant_transfer_limb in mendicant_organic_limbs))
				mendicant_transfer_limb.receive_damage(brute_taken, burn_taken, forced = TRUE, wound_bonus = CANT_WOUND)
			else // spread damage if we're trying to heal a bodypart we have no organic parallel of
				mendicant.take_overall_damage(brute_damage, burn_damage, required_bodytype = BODYTYPE_ORGANIC)

		// Force light wounds onto you.
		for(var/datum/wound/iter_wound as anything in affected_limb.wounds)
			switch(iter_wound.severity)
				if(WOUND_SEVERITY_SEVERE) // half and half
					if(prob(50 * heal_multiplier))
						continue
				if(WOUND_SEVERITY_CRITICAL)
					if(heal_multiplier < 1.5 && prob(30 * heal_multiplier)) // need buffs to transfer crit wounds
						continue
			. = TRUE
			iter_wound.remove_wound()
			iter_wound.apply_wound(mendicant_transfer_limb)

		if(!healing_budget)
			break

	if(!CAN_HAVE_BLOOD(mendicant) || !CAN_HAVE_BLOOD(hurtguy))
		return .

	// 10% base
	var/max_blood_transfer = (BLOOD_VOLUME_NORMAL * 0.10) * heal_multiplier
	var/hurtguy_blood = hurtguy.get_blood_volume()
	// Too little blood
	if(hurtguy_blood < BLOOD_VOLUME_NORMAL)
		var/amount_to_transfer = min(max_blood_transfer, BLOOD_VOLUME_NORMAL - hurtguy_blood)
		// We ignore incompatibility here.
		var/blood_transferred = mendicant.transfer_blood_to(hurtguy, amount_to_transfer, ignore_low_blood = TRUE, ignore_incompatibility = TRUE)

		if(!blood_transferred)
			return

		to_chat(mendicant, span_notice("你的血管（还有脑袋）感觉轻了些。"))
		. = TRUE
		// Because we do our own spin on it!
		if(hurtguy.get_blood_compatibility(mendicant) == FALSE)
			hurtguy.adjust_tox_loss((blood_transferred * 0.1) * pain_multiplier) // 1 dmg per 10 blood
			to_chat(hurtguy, span_notice("你的血管充盈起来，但有点发痒。"))
		else
			to_chat(hurtguy, span_notice("你的血管充盈起来！"))
		return

	if(hurtguy_blood < BLOOD_VOLUME_MAXIMUM)
		return

	var/amount_to_receive = min(max_blood_transfer, hurtguy_blood - BLOOD_VOLUME_MAXIMUM)
	// We ignore incompatibility here.
	var/blood_received = hurtguy.transfer_blood_to(mendicant, amount_to_receive, ignore_incompatibility = TRUE)

	if(!blood_received)
		return

	to_chat(hurtguy, span_notice("你的血管不再那么胀了。"))
	. = TRUE
	// Because we do our own spin on it!
	if(mendicant.get_blood_compatibility(hurtguy) == FALSE)
		mendicant.adjust_tox_loss((blood_received * 0.1) * pain_multiplier) // 1 dmg per 10 blood
		to_chat(mendicant, span_notice("你的血管又胀又痒！"))
	else
		to_chat(mendicant, span_notice("你的血管胀了起来！"))
	if(!.)
		mendicant.balloon_alert(hurtguy, "没有受损的有机肢体！")


/datum/action/cooldown/spell/touch/lay_on_hands/proc/determine_if_this_hurts_instead(mob/living/carbon/mendicant, mob/living/hurtguy)

	var/hurtguy_smiteable = SEND_SIGNAL(hurtguy, COMSIG_ON_LAY_ON_HANDS, mendicant)

	if(hurtguy.mob_biotypes & MOB_UNDEAD && mendicant.mob_biotypes & MOB_UNDEAD)
		return FALSE //always return false if we're both undead //undead solidarity

	if(hurtguy.mob_biotypes & MOB_UNDEAD && !HAS_TRAIT(mendicant, TRAIT_EVIL)) //Is the mob undead and we're not evil? If so, hurt.
		return TRUE

	if(HAS_TRAIT(hurtguy, TRAIT_EVIL) && !HAS_TRAIT(mendicant, TRAIT_EVIL)) //Is the guy evil and we're not evil? If so, hurt.
		return TRUE

	if(hurtguy_smiteable) //Is some other property of the target (like the empath component) causing them to be smited? If so, hurt.
		return TRUE
	return (FALSE)

///If our target was undead or evil, we blast them with a firey beam rather than healing them. For, you know, 'holy' reasons. When did genes become so morally uptight?

/datum/action/cooldown/spell/touch/lay_on_hands/proc/by_gods_light_i_smite_you(mob/living/carbon/smiter, mob/living/motherfucker_to_hurt, smite_multiplier)
	var/our_smite_multiplier = smite_multiplier
	var/evil_smite = HAS_TRAIT(smiter, TRAIT_EVIL) ? TRUE : FALSE
	var/divine_champion = smiter.mind?.holy_role >= HOLY_ROLE_PRIEST ? TRUE : FALSE
	var/smite_text_to_target = "将双手放在你身上"

	if(divine_champion || HAS_TRAIT(smiter, TRAIT_SPIRITUAL))

		// Defaults for possible deity. You know, just in case.
		var/possible_deity = evil_smite ? "撒旦" : "上帝"

		var/mob/living/carbon/human/human_smiter = smiter

		// If we have a client, check their deity pref and use that instead of our chaps god if our smiter is a spiritualist
		var/client/smiter_client = smiter.client

		if(smiter_client && HAS_TRAIT(smiter, TRAIT_SPIRITUAL))
			possible_deity = smiter_client.prefs?.read_preference(/datum/preference/name/deity)
		else if (GLOB.deity)
			possible_deity = GLOB.deity

		if(ishuman(human_smiter))
			human_smiter.force_say()
			if(evil_smite)
				human_smiter.say("以[possible_deity]的黑暗之名，我命你灭亡！！！", forced = "compelled by the power of their deity")
			else
				human_smiter.say("以[possible_deity]之威，我降罚于你！！！", forced = "compelled by the power of their deity")
		our_smite_multiplier *= divine_champion ? 5 : 1 //good luck surviving this if they're a chap

	if(evil_smite)
		motherfucker_to_hurt.visible_message(span_warning("[smiter]在[motherfucker_to_hurt]面前打了个响指，一股无形的力量使[motherfucker_to_hurt]的身体猛烈扭曲！"))
		motherfucker_to_hurt.apply_damage(10 * our_smite_multiplier, BRUTE, spread_damage = TRUE, wound_bonus = 5 * our_smite_multiplier)
		motherfucker_to_hurt.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH * our_smite_multiplier, 25 SECONDS)
		smiter.emote("snap")
		smite_text_to_target = "打了个响指，用精神力量碾压你"
	else
		motherfucker_to_hurt.visible_message(span_warning("[smiter]将双手放在[motherfucker_to_hurt]身上，却释放出耀眼的能量灼伤了对方！"))
		motherfucker_to_hurt.apply_damage(10 * our_smite_multiplier, BURN, spread_damage = TRUE, wound_bonus = 5 * our_smite_multiplier)
		motherfucker_to_hurt.adjust_fire_stacks(3 * our_smite_multiplier)
		motherfucker_to_hurt.ignite_mob()

	motherfucker_to_hurt.update_damage_overlays()

	to_chat(motherfucker_to_hurt, span_bolddanger("[smiter][smite_text_to_target]，使你受到了伤害！"))
	motherfucker_to_hurt.emote("scream")
	new /obj/effect/temp_visual/explosion(get_turf(motherfucker_to_hurt), evil_smite ? LIGHT_COLOR_BLOOD_MAGIC : LIGHT_COLOR_HOLY_MAGIC)
	. = TRUE

/obj/item/melee/touch_attack/lay_on_hands
	name = "抚愈之触"
	desc = "遗憾的是，这和你最喜欢的桌游不同，不能对自己施放，所以也不能拿自己当替罪羊。" // mayus is reference. if you get it you're cool
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "greyscale"
	color = COLOR_VERY_PALE_LIME_GREEN
	inhand_icon_state = "greyscale"
	item_flags = parent_type::item_flags & ~NEEDS_PERMIT
