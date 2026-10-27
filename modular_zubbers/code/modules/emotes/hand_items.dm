/obj/item/hand_item/bonkinghand
	name = "敲头手"
	desc = "是时候用搞笑的方式敲别人的头了。"
	inhand_icon_state = "nothing"
	attack_verb_continuous = list("敲打")
	attack_verb_simple = list("敲")
	hitsound = 'sound/effects/snap.ogg'

/obj/item/hand_item/bonkinghand/Initialize(mapload)
	. = ..()

/obj/item/hand_item/bonkinghand/attack(mob/living/bonked, mob/living/carbon/human/user)
	var/bonk_volume = 75
	var/obj/item/bodypart/bonkers_hand = user.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
	var/obj/item/bodypart/head/bonk_victims_head = bonked.get_bodypart(BODY_ZONE_HEAD)
	if(user.zone_selected != BODY_ZONE_HEAD)
		to_chat(user, span_warning("如果你没有瞄准头部，就无法敲到别人的头！"))
		return

	if(issilicon(bonked))
		if(bonkers_hand?.receive_damage( 5, 0 )) // 5 brute damage
			user.update_damage_overlays()
		user.visible_message(
			span_danger("[user]敲了[bonked]的头，手又红又肿！"),
			span_notice("你敲了[bonked]的头，却打在他们头部的金属上，弄伤了手！"),
			span_hear("你听到一声滑稽的金属敲击声。"),
		)
		playsound(bonked, 'sound/items/weapons/smash.ogg', bonk_volume, TRUE, -1)

	else if(bonk_victims_head)
		if(bonk_victims_head.biological_state & BIO_METAL)
			if(bonkers_hand?.receive_damage( 5, 0 )) // 5 brute damage
				user.update_damage_overlays()
			user.visible_message(
				span_danger("[user]敲了[bonked]的头，手又红又肿！"),
				span_notice("你敲了[bonked]的头，却打在他们头部的金属上，弄伤了手！"),
				span_hear("你听到一声滑稽的金属敲击声。"),
			)
			playsound(bonked, 'sound/items/weapons/smash.ogg', bonk_volume, FALSE, -1)

		else
			user.visible_message(
				span_danger("[user]敲了[bonked]的头！"),
				span_notice("你敲了[bonked]的头！"),
				span_hear("你听到一声滑稽的敲头声。"),
			)
			playsound(bonked, 'modular_zubbers/code/modules/emotes/sound/effects/bonk.ogg', bonk_volume, FALSE, -1)
	else
		to_chat(user, span_warning("如果对方没有头，你就无法敲他的头！"))
		return
	qdel(src)
// Successful takes will qdel our hand after
/obj/item/hand_item/bonkinghand/on_offer_taken(mob/living/carbon/offerer, mob/living/carbon/taker)
	. = ..()
	if(!.)
		return

	qdel(src)

