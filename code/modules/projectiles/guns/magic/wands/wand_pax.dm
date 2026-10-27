/**
 * Pax wand is a minor heal which applies temporary pacifism, gives you time to talk it out?
 */
/obj/item/gun/magic/wand/pax
	name = "慈悲之杖"
	desc = "一根以超自然力量将受害者和目标连接起来的魔杖，能让双方都无法战斗，并让他们感觉好受一些。"
	school = SCHOOL_RESTORATION
	ammo_type = /obj/item/ammo_casing/magic/pax
	icon_state = "peacewand"
	base_icon_state = "peacewand"
	fire_sound = 'sound/effects/emotes/kiss.ogg'
	max_charges = 12

/obj/item/gun/magic/wand/pax/fire_gun(atom/target, mob/living/user, flag, params)
	. = ..()
	if (!.)
		return
	user.apply_status_effect(/datum/status_effect/pacify/visible, 30 SECONDS) // Don't miss!
	user.adjust_brute_loss(-30)

/obj/item/gun/magic/wand/pax/zap_self(mob/living/user, suicide = FALSE)
	if (!suicide)
		user.visible_message(span_notice("[user] 温柔地亲吻了自己的魔杖。"))

/obj/item/gun/magic/wand/pax/do_suicide(mob/living/user)
	. = ..()
	user.visible_message(span_suicide("……但 [user] 实在下不去手伤害任何人！"))
	return SHAME

/obj/item/ammo_casing/magic/pax
	projectile_type = /obj/projectile/magic/pax
	harmful = FALSE

/obj/projectile/magic/pax
	name = "慈悲魔弹"
	icon = 'icons/mob/simple/animal.dmi'
	icon_state = "heart"

/obj/projectile/magic/pax/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	var/mob/living/victim = target
	if (!istype(victim))
		return

	victim.apply_status_effect(/datum/status_effect/pacify/visible, 30 SECONDS)
	victim.adjust_brute_loss(-30)

// Default pacify status effect has no screen alert but I think this should have one
/datum/status_effect/pacify/visible
	alert_type = /atom/movable/screen/alert/status_effect/pacified

/datum/status_effect/pacify/visible/on_apply()
	if (!HAS_TRAIT(owner, TRAIT_PACIFISM))
		owner.visible_message(span_notice("[owner] 似乎放松了下来。"), span_notice("你感觉肌肉松弛下来，战斗的意志也随之消融。"))
	return ..()

/datum/status_effect/pacify/visible/on_remove()
	. = ..()
	// Might have it from somewhere else
	if (HAS_TRAIT(owner, TRAIT_PACIFISM))
		return
	owner.visible_message(span_warning("[owner] 突然紧绷了起来。"), span_notice("你忽然想起，暴力也是一种选择。"))

/atom/movable/screen/alert/status_effect/pacified
	name = "被安抚"
	desc = "你暂时无法使用暴力。"
	icon_state = "in_love"
