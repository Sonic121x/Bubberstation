/// How many life ticks are required for the nightmare's heart to revive the nightmare.
#define HEART_RESPAWN_THRESHHOLD (80 SECONDS)
/// A special flag value used to make a nightmare heart not grant a light eater. Appears to be unused.
#define HEART_SPECIAL_SHADOWIFY 2

/obj/item/organ/brain/shadow/nightmare
	name = "肿瘤状团块"
	desc = "一块从梦魇头骨中挖出的肉质增生。"
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "brain-x-d"
	shade_color = "不知为何是黑色的"
	variant_traits_added = list(TRAIT_NIGHTMARISH)

	///Our associated shadow jaunt spell, for all nightmares
	var/datum/action/cooldown/spell/jaunt/shadow_walk/our_jaunt
	///Our associated terrorize spell, for antagonist nightmares
	var/datum/action/cooldown/spell/pointed/terrorize/terrorize_spell

/obj/item/organ/brain/shadow/nightmare/on_mob_insert(mob/living/carbon/brain_owner)
	. = ..()

	if(brain_owner.dna.species.id != SPECIES_NIGHTMARE)
		brain_owner.set_species(/datum/species/shadow/nightmare, replace_missing = FALSE)
		visible_message(span_warning("[brain_owner]剧烈挣扎，[src]正在其体内扎根！"))

	our_jaunt = new(brain_owner)
	our_jaunt.Grant(brain_owner)

	if(brain_owner.mind?.has_antag_datum(/datum/antagonist/nightmare)) //Only a TRUE NIGHTMARE is worthy of using this ability
		terrorize_spell = new(src)
		terrorize_spell.Grant(brain_owner)

/obj/item/organ/brain/shadow/nightmare/on_mob_remove(mob/living/carbon/brain_owner)
	. = ..()
	QDEL_NULL(our_jaunt)
	QDEL_NULL(terrorize_spell)

/obj/item/organ/brain/shadow/nightmare/on_life(seconds_per_tick)
	. = ..()

	var/turf/owner_turf = owner.loc
	if(!isturf(owner_turf))
		return
	if (owner_turf.check_lumcount_below(SHADOW_SPECIES_LIGHT_THRESHOLD)) //dodge in the dark
		owner.apply_status_effect(/datum/status_effect/shadow/nightmare)

/datum/status_effect/shadow/nightmare
	id = "nightmare"
	alert_type = /atom/movable/screen/alert/status_effect/shadow_regeneration/nightmare

/datum/status_effect/shadow/nightmare/on_apply()
	. = ..()
	if (!.)
		return FALSE
	RegisterSignal(owner, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(dodge_bullets))
	return TRUE

/datum/status_effect/shadow/nightmare/on_remove()
	UnregisterSignal(owner, COMSIG_ATOM_PRE_BULLET_ACT)
	return ..()

/datum/status_effect/shadow/nightmare/proc/dodge_bullets(mob/living/carbon/human/source, obj/projectile/hitting_projectile, def_zone)
	SIGNAL_HANDLER
	source.visible_message(
		span_danger("[source]在暗影中起舞，躲开了[hitting_projectile]！"),
		span_danger("你借助黑暗的掩护躲开了[hitting_projectile]！"),
	)
	playsound(source, SFX_BULLET_MISS, 75, TRUE)
	return COMPONENT_BULLET_PIERCED

/atom/movable/screen/alert/status_effect/shadow_regeneration/nightmare
	name = "无光领域"
	desc = "沐浴在抚慰的黑暗中，你会缓慢再生，甚至能跨越死亡的界限。\
		敏锐的反射神经让你能够闪避投射物武器。"

/obj/item/organ/heart/nightmare
	name = "黑暗之心"
	desc = "一个暴露在光线下就会扭曲挣扎的异种器官。"
	visual = TRUE
	icon = 'icons/obj/medical/organs/shadow_organs.dmi'
	icon_state = "dark_heart-on"
	base_icon_state = "dark_heart"

	beat_noise = "具形恐惧那扭动的搏动" // evil schmeevil
	decay_factor = 0
	// No love is to be found in a heart so twisted.
	food_reagents = list(/datum/reagent/consumable/nutriment/organ_tissue = 5)
	// In case you want to drink light as well as eat it
	organ_traits = list(TRAIT_LIGHT_DRINKER)
	/// How many life ticks in the dark the owner has been dead for. Used for nightmare respawns.
	var/respawn_progress = 0
	/// The armblade granted to the host of this heart.
	var/obj/item/light_eater/blade

/obj/item/organ/heart/nightmare/Destroy()
	QDEL_NULL(blade)
	return ..()

/obj/item/organ/heart/nightmare/attack(mob/M, mob/living/carbon/user, obj/target)
	if(M != user)
		return ..()
	user.visible_message(
		span_warning("[user]把[src]举到自己嘴边，用牙齿撕咬起来！"),
		span_danger("[src]在你手中冰冷得不合常理。你把它举到嘴边，吞了下去！")
	)
	playsound(user, 'sound/effects/magic/demon_consume.ogg', 50, TRUE)

	user.visible_message(
		span_warning("鲜血从[user]的手臂喷涌而出，手臂随即重塑为一件武器！"),
		span_userdanger("冰冷的血液在血管中奔涌，你的手臂正在重塑！")
	)
	user.temporarilyRemoveItemFromInventory(src, TRUE)
	Insert(user)

/obj/item/organ/heart/nightmare/on_mob_insert(mob/living/carbon/heart_owner, special, movement_flags)
	. = ..()
	if(special == HEART_SPECIAL_SHADOWIFY)
		return
	blade = new /obj/item/light_eater
	heart_owner.put_in_hands(blade)
	RegisterSignal(blade, COMSIG_QDELETING, PROC_REF(on_blade_deleted))

/obj/item/organ/heart/nightmare/on_mob_remove(mob/living/carbon/heart_owner, special, movement_flags)
	. = ..()
	respawn_progress = 0
	if(blade && special != HEART_SPECIAL_SHADOWIFY)
		heart_owner.visible_message(span_warning("[blade]崩解消散了！"))
		QDEL_NULL(blade)

/obj/item/organ/heart/nightmare/Stop()
	return FALSE

// Happens if the blade was deleted before we were during mob destruction
/obj/item/organ/heart/nightmare/proc/on_blade_deleted(datum/source)
	SIGNAL_HANDLER
	blade = null

/obj/item/organ/heart/nightmare/on_death(seconds_per_tick)
	if(!owner)
		return

	var/turf/owner_turf = get_turf(owner)
	if(istype(owner_turf))
		if(owner_turf.check_lumcount_below(SHADOW_SPECIES_LIGHT_THRESHOLD))
			respawn_progress += seconds_per_tick SECONDS
			playsound(owner, 'sound/effects/singlebeat.ogg', 40, TRUE)

	if(respawn_progress < HEART_RESPAWN_THRESHHOLD)
		return

	owner.revive(HEAL_ALL & ~HEAL_REFRESH_ORGANS)
	if(!(owner.dna.species.id == SPECIES_SHADOW || owner.dna.species.id == SPECIES_NIGHTMARE))
		var/mob/living/carbon/old_owner = owner
		Remove(owner, HEART_SPECIAL_SHADOWIFY)
		old_owner.set_species(/datum/species/shadow)
		Insert(old_owner, HEART_SPECIAL_SHADOWIFY)
		to_chat(owner, span_userdanger("你感到暗影侵入你的皮肤，跃入胸腔正中！你活过来了！"))
		SEND_SOUND(owner, sound('sound/effects/ghost.ogg'))
	owner.visible_message(span_warning("[owner]踉跄着站了起来！"))
	playsound(owner, 'sound/effects/hallucinations/far_noise.ogg', 50, TRUE)
	respawn_progress = 0

/obj/item/organ/heart/nightmare/get_availability(datum/species/owner_species, mob/living/owner_mob)
	if(HAS_TRAIT(owner_mob, TRAIT_NIGHTMARISH))
		return TRUE
	return ..()

#undef HEART_SPECIAL_SHADOWIFY
#undef HEART_RESPAWN_THRESHHOLD
