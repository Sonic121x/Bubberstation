/// The loot from killing a slaughter demon - can be consumed to allow the user to blood crawl
/obj/item/organ/heart/demon
	name = "恶魔心脏"
	desc = "它仍在狂暴地跳动，散发着纯粹的憎恨气息。"
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "demon_heart-on"
	decay_factor = 0

/obj/item/organ/heart/demon/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

/obj/item/organ/heart/demon/attack(mob/target_mob, mob/living/carbon/user, obj/target)
	if(target_mob != user)
		return ..()

	user.visible_message(
		span_warning("[user] 把 [src] 举到嘴边，用牙撕咬起来！"),
		span_danger("一种不自然的饥饿感吞噬了你。你把 [src] 举到嘴边，将它吞了下去！"),
	)
	playsound(user, 'sound/effects/magic/demon_consume.ogg', 50, TRUE)

	if(locate(/datum/action/cooldown/spell/jaunt/bloodcrawl) in user.actions)
		to_chat(user, span_warning("……而你感觉自己并没有什么不同。"))
		qdel(src)
		return

	user.visible_message(
		span_warning("[user] 的双眼燃起深红的火光！"),
		span_userdanger("你感到一股奇异的力量渗入体内……你已吸收了恶魔的血中穿行之力！"),
	)

	user.temporarilyRemoveItemFromInventory(src, TRUE)
	src.Insert(user) //Consuming the heart literally replaces your heart with a demon heart. H A R D C O R E

/obj/item/organ/heart/demon/on_mob_insert(mob/living/carbon/heart_owner)
	. = ..()
	// Gives a non-eat-people crawl to the new owner
	var/datum/action/cooldown/spell/jaunt/bloodcrawl/crawl = new(heart_owner)
	crawl.Grant(heart_owner)

/obj/item/organ/heart/demon/on_mob_remove(mob/living/carbon/heart_owner, special = FALSE, movement_flags)
	. = ..()
	var/datum/action/cooldown/spell/jaunt/bloodcrawl/crawl = locate() in heart_owner.actions
	qdel(crawl)

/obj/item/organ/heart/demon/Stop()
	return FALSE // Always beating.

/obj/effect/decal/cleanable/blood/innards
	name = "一堆内脏"
	desc = "一堆令人作呕的内脏与血肉。"
	gender = NEUTER
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "innards"
	random_icon_states = null
