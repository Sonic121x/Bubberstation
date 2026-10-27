//Alium nests. Essentially beds with an unbuckle delay that only aliums can buckle mobs to.

/obj/structure/bed/nest
	name = "异形巢穴"
	desc = "一堆厚厚的、黏稠的树脂堆成的巢状物，令人生畏。"
	icon = 'icons/obj/smooth_structures/alien/nest.dmi'
	icon_state = "nest-0"
	base_icon_state = "nest"
	max_integrity = 120
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_ALIEN_NEST
	canSmoothWith = SMOOTH_GROUP_ALIEN_NEST
	build_stack_type = null
	elevation = 0
	can_deconstruct = FALSE
	var/static/mutable_appearance/nest_overlay = mutable_appearance('icons/mob/nonhuman-player/alien.dmi', "nestoverlay", LYING_MOB_LAYER)

/obj/structure/bed/nest/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_DANGEROUS_BUCKLE, INNATE_TRAIT)

/obj/structure/bed/nest/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	if(held_item?.tool_behaviour == TOOL_WRENCH)
		return NONE

	return ..()

/obj/structure/bed/nest/buckle_feedback(mob/living/being_buckled, mob/buckler)
	if(being_buckled == buckler)
		being_buckled.visible_message(
			span_notice("[buckler]在[src]上躺下，用厚厚的黏稠树脂包裹住自己。"),
			span_notice("你在[src]上躺下，用厚厚的黏稠树脂包裹住自己。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
	else
		being_buckled.visible_message(
			span_notice("[buckler]把[being_buckled]放倒在[src]上，用厚厚的黏稠树脂将其包裹。"),
			span_notice("[buckler]把你放倒在[src]上，用厚厚的黏稠树脂将你包裹。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)

/obj/structure/bed/nest/unbuckle_feedback(mob/living/being_unbuckled, mob/unbuckler)
	if(being_unbuckled == unbuckler)
		being_unbuckled.visible_message(
			span_notice("[unbuckler]把自己从黏稠的巢中挣脱出来！"),
			span_notice("你把自己从黏稠的巢中挣脱出来！"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
	else
		being_unbuckled.visible_message(
			span_notice("[unbuckler]把[being_unbuckled]从黏稠的巢中拉了出来！"),
			span_notice("[unbuckler]把你从黏稠的巢中拉了出来！"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)

/obj/structure/bed/nest/user_unbuckle_mob(mob/living/captive, mob/living/hero)
	if(!length(buckled_mobs))
		return

	if(hero.get_organ_by_type(/obj/item/organ/alien/plasmavessel))
		unbuckle_mob(captive)
		add_fingerprint(hero)
		return

	if(captive != hero)
		captive.visible_message(span_notice("[hero.name]把[captive.name]从黏稠的巢中拉了出来！"),
			span_notice("[hero.name]把你从胶质树脂中拉了出来。"),
			span_hear("你听到黏糊糊的挤压声……"))
		unbuckle_mob(captive)
		add_fingerprint(hero)
		return

	captive.visible_message(span_warning("[captive.name]挣扎着想从胶质树脂中脱身！"),
		span_notice("你挣扎着想从胶质树脂中脱身……（保持不动约一分半钟。）"),
		span_hear("你听到黏糊糊的挤压声……"))

	if(!do_after(captive, 100 SECONDS, target = src, cog_icon = null))
		if(captive.buckled)
			to_chat(captive, span_warning("你没能解开束缚！"))
		return

	captive.visible_message(span_warning("[captive.name]从胶质树脂中挣脱了！"),
		span_notice("你从胶质树脂中挣脱了！"),
		span_hear("你听到黏糊糊的挤压声……"))

	unbuckle_mob(captive)
	add_fingerprint(hero)

/obj/structure/bed/nest/user_buckle_mob(mob/living/M, mob/user, check_loc = TRUE)
	if ( !ismob(M) || (get_dist(src, user) > 1) || (M.loc != src.loc) || user.incapacitated || M.buckled )
		return

	if(M.get_organ_by_type(/obj/item/organ/alien/plasmavessel))
		return
	if(!user.get_organ_by_type(/obj/item/organ/alien/plasmavessel))
		return

	if(has_buckled_mobs())
		unbuckle_all_mobs()

	if(buckle_mob(M))
		M.visible_message(span_notice("[user.name]分泌出厚厚的恶臭黏液，把[M.name]牢牢固定在[src]上！"),\
			span_danger("[user.name]用恶臭的树脂把你浸透，把你困在[src]里！"),\
			span_hear("你听到黏糊糊的挤压声……"))

/obj/structure/bed/nest/post_buckle_mob(mob/living/M)
	ADD_TRAIT(M, TRAIT_HANDS_BLOCKED, type)
	M.add_offsets(type, x_add = 2)
	M.layer = BELOW_MOB_LAYER
	add_overlay(nest_overlay)

	if(ishuman(M))
		var/mob/living/carbon/human/victim = M
		if(((victim.wear_mask && istype(victim.wear_mask, /obj/item/clothing/mask/facehugger)) || HAS_TRAIT(victim, TRAIT_XENO_HOST)) && victim.stat != DEAD) //If they're a host or have a facehugger currently infecting them. Must be alive.
			victim.apply_status_effect(/datum/status_effect/nest_sustenance)

/obj/structure/bed/nest/post_unbuckle_mob(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_HANDS_BLOCKED, type)
	M.remove_offsets(type)
	M.layer = initial(M.layer)
	cut_overlay(nest_overlay)
	M.remove_status_effect(/datum/status_effect/nest_sustenance)

/obj/structure/bed/nest/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(loc, 'sound/effects/blob/attackblob.ogg', 100, TRUE)
		if(BURN)
			playsound(loc, 'sound/items/tools/welder.ogg', 100, TRUE)

/obj/structure/bed/nest/attack_alien(mob/living/carbon/alien/user, list/modifiers)
	if(!user.combat_mode)
		return attack_hand(user, modifiers)
	else
		return ..()
