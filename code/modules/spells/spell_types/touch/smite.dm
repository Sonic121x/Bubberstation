/datum/action/cooldown/spell/touch/smite
	name = "天罚"
	desc = "此法术以不洁能量充盈你的手掌，\
		能令被触碰的受害者猛烈爆裂。"
	button_icon_state = "gib"
	sound = 'sound/effects/magic/disintegrate.ogg'

	school = SCHOOL_EVOCATION
	cooldown_time = 1 MINUTES
	cooldown_reduction_per_rank = 10 SECONDS

	invocation = "EI NATH!!"
	sparks_amt = 4

	hand_path = /obj/item/melee/touch_attack/smite

/// Smite is pretty extravagant, so whenever we get casted, we blind everyone nearby.
/datum/action/cooldown/spell/touch/smite/proc/blind_everyone_nearby(mob/living/victim, atom/center)
	do_sparks(sparks_amt, FALSE, get_turf(victim))
	for(var/mob/living/nearby_spectator in view(center, 7))
		if(nearby_spectator == center)
			continue
		nearby_spectator.flash_act(affect_silicon = FALSE)

/datum/action/cooldown/spell/touch/smite/on_antimagic_triggered(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	// Off goes the arm we were casting with!
	var/obj/item/bodypart/to_dismember = caster.get_holding_bodypart_of_item(hand)
	var/did_dismember = to_dismember?.dismember()
	caster.visible_message(
		span_warning(did_dismember ? "反噬的冲击炸飞了 [caster] 的手臂！" : "反噬释放出一道耀眼的闪光！"),
		span_userdanger("法术从 [victim] 的皮肤反弹回你的手臂！"),
	)
	// And do the blind (us included)
	caster.flash_act()
	blind_everyone_nearby(caster, caster)

/datum/action/cooldown/spell/touch/smite/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	blind_everyone_nearby(victim, caster)

	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		var/obj/item/clothing/suit/worn_suit = human_victim.wear_suit
		if(istype(worn_suit, /obj/item/clothing/suit/hooded/bloated_human))
			human_victim.visible_message(span_danger("[victim] 身上的 [worn_suit] 炸裂开来，四散成一滩血肉！"))
			human_victim.dropItemToGround(worn_suit)
			qdel(worn_suit)
			new /obj/effect/gibspawner(get_turf(victim))
			return TRUE

	victim.investigate_log("被天罚法术炸成了碎肉。", INVESTIGATE_DEATHS)
	victim.gib(DROP_ALL_REMAINS)
	return TRUE

/obj/item/melee/touch_attack/smite
	name = "\improper 天罚之触"
	desc = "我这只手正闪耀着惊人的力量！"
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "disintegrate"
	inhand_icon_state = "disintegrate"

/obj/item/melee/touch_attack/smite/suicide_act(mob/living/user)

	user.visible_message(span_suicide("[user] 张开双臂，闪电在两手之间跃动！看来 [user.p_theyre()] 要轰轰烈烈地收场了！"))
	user.say("SHIA KAZING!!", forced = "smite suicide")
	do_sparks(4, FALSE, get_turf(user))
	explosion(user, heavy_impact_range = 2, explosion_cause = src) //Cheap explosion imitation because putting detonate() here causes runtimes
	user.gib(DROP_ALL_REMAINS)
	qdel(src)
	return MANUAL_SUICIDE
