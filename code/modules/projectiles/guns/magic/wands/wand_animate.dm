
/// Wand of making objects alive
/obj/item/gun/magic/wand/animate
	name = "活化之杖"
	desc = "这根短杖与生命共鸣，会将受影响的物体活化成破坏性的仆从。"
	school = SCHOOL_EVOCATION
	ammo_type = /obj/item/ammo_casing/magic/animate
	icon_state = "animatewand"
	base_icon_state = "animatewand"
	fire_sound = 'sound/effects/magic/staff_animation.ogg'
	max_charges = 10

/obj/item/gun/magic/wand/animate/zap_self(mob/living/user, suicide = FALSE)
	. = ..()
	to_chat(user, span_warning("你把自己的一件随身物品活化了！"))
	charges--
	var/list/possessions = user.get_equipped_items()
	if (!length(possessions))
		to_chat(user, span_notice("……但你身上什么也没有。"))
		return

	var/obj/some_item = pick(possessions)
	user.dropItemToGround(some_item)
	some_item.animate_atom_living(user)

/obj/item/gun/magic/wand/animate/do_suicide(mob/living/user)
	charges--
	if (!iscarbon(user))
		user.visible_message(span_suicide("……但 [user] 本来就活得好好的！"))
		return SHAME
	var/mob/living/carbon/suicider = user
	var/obj/item/animate_part = suicider.get_organ_slot(ORGAN_SLOT_BRAIN) || suicider.get_bodypart(BODY_ZONE_HEAD)
	if (!animate_part)
		return SHAME

	var/turf/destination = user.drop_location()

	if (isorgan(animate_part))
		var/obj/item/organ/brain = animate_part
		brain.Remove(user, special = FALSE)
	else
		var/obj/item/bodypart/head = animate_part
		head.dismember(BRUTE)

	animate_part.forceMove(destination)
	animate_part.animate_atom_living()
	if (user.stat != DEAD)
		return SHAME
	user.set_suicide(TRUE)
	return MANUAL_SUICIDE

/obj/item/gun/magic/wand/animate/animate_atom_living(mob/living/owner)
	var/mob/living/basic/mimic/copy/ranged/living_wand = new(drop_location(), src, owner, FALSE, TRUE) // It's already got eyes
	QDEL_NULL(living_wand.ai_controller)
	living_wand.ai_controller = new /datum/ai_controller/basic_controller/mimic_copy/gun/animator(living_wand)
	return living_wand
