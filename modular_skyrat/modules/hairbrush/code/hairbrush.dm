// Hairbrushes

/obj/item/hairbrush
	name = "发刷"
	desc = "一把小巧的圆形刷子，配有符合人体工学的手柄，便于高效梳理。"
	icon = 'modular_skyrat/modules/hairbrush/icons/hairbrush.dmi'
	icon_state = "brush"
	inhand_icon_state = "inhand"
	lefthand_file = 'modular_skyrat/modules/hairbrush/icons/inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/hairbrush/icons/inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/brush_speed = 3 SECONDS

/obj/item/hairbrush/attack(mob/target, mob/user)
	if(target.stat == DEAD)
		to_chat(usr, span_warning("给无法体会的人梳头没什么意义！"))
		return
	brush(target, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/// Brushes someone, giving them a small mood boost
/obj/item/hairbrush/proc/brush(mob/living/target, mob/user)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/head = human_target.get_bodypart(BODY_ZONE_HEAD)

		// Don't brush if you can't reach their head or cancel the action
		if(!head)
			to_chat(user, span_warning("[human_target] 没有头！"))
			return
		if(human_target.is_mouth_covered(ITEM_SLOT_HEAD))
			to_chat(user, span_warning("你无法在 [human_target] 头部被遮住时为其梳理头发！"))
			return
		if(!do_after(user, brush_speed, human_target))
			return

		// Do 1 brute to their head if they're bald. Should've been more careful.
		if(human_target.hairstyle == "Bald" || human_target.hairstyle == "Skinhead" && is_species(human_target, /datum/species/human)) //It can be assumed most anthros have hair on them!
			human_target.visible_message(span_warning("[usr] 用刷毛在 [human_target] 的头皮上难耐地刮擦。"), span_warning("你用刷毛在 [human_target] 的头皮上难耐地刮擦。"))
			head.receive_damage(1)
			return

		// Brush their hair
		if(human_target == user)
			human_target.visible_message(span_notice("[usr] 梳理了自己的头发！"), span_notice("你梳理了自己的头发。"))
			human_target.add_mood_event("brushed", /datum/mood_event/brushed/self)
		else
			user.visible_message(span_notice("[usr] 为 [human_target] 梳理头发！"), span_notice("你为 [human_target] 梳理头发。"), ignored_mobs=list(human_target))
			human_target.show_message(span_notice("[usr] 为你梳理头发！"), MSG_VISUAL)
			human_target.add_mood_event("brushed", /datum/mood_event/brushed, user)

	else if(istype(target, /mob/living/basic/pet))
		if(!do_after(usr, brush_speed, target))
			return
		to_chat(user, span_notice("你为 [target] 梳理时，它舒服地闭上了眼睛！"))
		var/mob/living/living_user = user
		if(istype(living_user))
			living_user.add_mood_event("brushed", /datum/mood_event/brushed/pet, target)
