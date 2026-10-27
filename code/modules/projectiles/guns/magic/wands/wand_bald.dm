/// Makes you bald, or emphasises your baldness
/obj/item/gun/magic/wand/bald
	name = "剃发杖"
	desc = "巫师学院迎新恶作剧常用的短杖，会让受害者变成光头，或让他们的秃顶格外引人注目。"
	school = SCHOOL_TRANSMUTATION
	ammo_type = /obj/item/ammo_casing/magic/bald
	icon_state = "shavingwand"
	base_icon_state = "shavingwand"
	fire_sound = 'sound/items/tools/welder2.ogg'
	max_charges = 12

/obj/item/gun/magic/wand/bald/zap_self(mob/living/user, suicide)
	. = ..()
	if (!suicide)
		visible_message(span_notice("[user] 迅速给自己剃了个头。"))
	var/obj/projectile/magic/bald/trimmer = new(user.drop_location())
	trimmer.firer = user
	user.projectile_hit(trimmer, BODY_ZONE_HEAD)
	qdel(trimmer)

/obj/item/gun/magic/wand/bald/do_suicide(mob/living/carbon/human/user)
	var/obj/item/bodypart/head/dome = user.get_bodypart(BODY_ZONE_HEAD)
	if (!dome || ((dome.head_flags & HEAD_HAIR) && user.hairstyle != "Bald"))
		. = ..()
		visible_message(span_suicide("[user] 拼命想给自己剃头，像是在呼救。"))
		return SHAME

	charges--
	user.apply_status_effect(/datum/status_effect/bald_flare)
	dome.dismember(wounding_type = WOUND_SLASH, silent = TRUE)
	visible_message(span_suicide("随着光芒消退，可以看清 [user] 把自己整个脑袋都剃掉了。"))

/obj/item/gun/magic/wand/bald/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	zone_override = BODY_ZONE_HEAD // Head only
	return ..()

/obj/item/ammo_casing/magic/bald
	projectile_type = /obj/projectile/magic/bald

/// Embaldens people, or turns their bald spot into a reflective surface
/obj/projectile/magic/bald
	name = "脱发之弹"
	icon = 'icons/obj/cosmetic.dmi'
	icon_state = "razor"
	damage = 5
	damage_type = BRUTE
	accuracy_falloff = 0

// Currently we have no facility for shaving nonhuman mobs
/obj/projectile/magic/bald/on_hit(mob/living/carbon/human/target, blocked, pierce_hit)
	if (!isliving(target))
		return ..()

	var/obj/item/bodypart/head/dome = target.get_bodypart(BODY_ZONE_HEAD)
	if (iscarbon(target) && !dome)
		return BULLET_ACT_FORCE_PIERCE // No head no shave
	. = ..()
	if (. == BULLET_ACT_BLOCK || !istype(target) || blocked >= 100)
		return

	// First look for wigs or hats
	var/obj/item/hat = target.head // Head here means what's on it, not what it is

	if (hat)
		if (!istype(hat, /obj/item/clothing/head/wig)) // If we're not a wig, check if there's a wig on our hat
			var/obj/item/clothing/head/wig/attached_wig = locate() in hat
			hat = attached_wig || hat

		if (istype(hat, /obj/item/clothing/head/wig))
			hat.forceMove(target.drop_location())
			hat.deconstruct(FALSE)
			if (QDELETED(hat)) // IDK maybe it's disagreed
				visible_message(span_warning("[target] 的 [hat] 被 [src] 绞碎了！"))
				log_combat(firer, target, "用魔法摧毁了假发", src)
			return

		if(hat.flags_inv & HIDEHAIR)
			var/obj/item/clothing/clothing_hat = hat // Not all hats are clothing
			if (!istype(clothing_hat) || !(clothing_hat.clothing_flags & SNUG_FIT))
				visible_message(span_warning("[hat] 从 [target] 头上被打掉了！"))
				target.dropItemToGround(hat)
			return

	// Weird mutant hair
	var/obj/item/organ/mutant_hair = target.get_organ_slot(ORGAN_SLOT_EXTERNAL_POD_HAIR)
	if (mutant_hair)
		mutant_hair.Remove(target, special = FALSE)
		qdel(mutant_hair)
		target.Knockdown(1 SECONDS)
		visible_message(span_warning("[target] 的头发被 [src] 瞬间剃光了！"))
		log_combat(firer, target, "用魔法剃成光头", src)
		return

	// Finally normal hair
	if ((dome?.head_flags & HEAD_HAIR) && target.hairstyle != "Bald")
		target.set_hairstyle("Bald")
		target.Knockdown(1 SECONDS)
		visible_message(span_warning("[target] 的头发被 [src] 瞬间剃光了！"))
		log_combat(firer, target, "用魔法剃成光头", src)
		return

	target.apply_status_effect(/datum/status_effect/bald_flare)

#define BALD_RAYS_FILTER "bald_ray"

/// Mostly just handles animation
/datum/status_effect/bald_flare
	id = "bald_flare"
	alert_type = null
	duration = 1.6 SECONDS

/datum/status_effect/bald_flare/on_apply()
	. = ..()
	owner.visible_message(span_warning("[owner] 的光头释放出一道耀眼闪光！"))
	for(var/mob/living/viewers in (viewers(3, owner) - owner))
		viewers.flash_act()

	var/mob/living/carbon/human/human_owner = owner
	var/height = max((human_owner.mob_height || 0) - 2, 0)

	owner.add_filter(name = BALD_RAYS_FILTER, priority = 1, params = list(
		type = "rays",
		y = height,
		size = 10,
		color = COLOR_VERY_SOFT_YELLOW,
		density = 20
	))

	var/ray_filter = owner.get_filter(BALD_RAYS_FILTER)
	animate(ray_filter, size = 30, time = duration * 0.85)
	animate(size = 0, time = duration * 0.15)
	animate(ray_filter, offset = 1.5, time = duration, flags = ANIMATION_PARALLEL)

/datum/status_effect/bald_flare/on_remove()
	owner.remove_filter(BALD_RAYS_FILTER)

#undef BALD_RAYS_FILTER
