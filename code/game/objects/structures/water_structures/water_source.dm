//Water source, use the type water_source for unlimited water sources like classic sinks.
/obj/structure/water_source
	name = "水源"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "sink"
	desc = "用来洗手和洗脸的水池。这个似乎是无限的！"
	anchored = TRUE
	///Boolean on whether something is currently being washed, preventing multiple people from cleaning at once.
	var/busy = FALSE
	///The reagent that is dispensed from this source, by default it's water.
	var/datum/reagent/dispensedreagent = /datum/reagent/water

/obj/structure/water_source/Initialize(mapload)
	. = ..()
	create_reagents(INFINITY, NO_REACT)
	reagents.add_reagent(dispensedreagent, INFINITY)

/obj/structure/water_source/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!iscarbon(user))
		return
	if(!Adjacent(user))
		return

	if(busy)
		to_chat(user, span_warning("已经有人在这里清洗了！"))
		return
	var/selected_area = user.parse_zone_with_bodypart(user.zone_selected)
	var/washing_face = FALSE
	if(selected_area in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES))
		washing_face = TRUE
	user.visible_message(
		span_notice("[user]开始清洗自己的[washing_face ? "脸" : "手"]……"),
		span_notice("你开始清洗你的[washing_face ? "脸" : "手"]……"))
	busy = TRUE

	if(!do_after(user, 4 SECONDS, target = src))
		busy = FALSE
		return

	busy = FALSE

	if(washing_face)
		SEND_SIGNAL(user, COMSIG_COMPONENT_CLEAN_FACE_ACT, CLEAN_WASH)
	else if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(!human_user.wash_hands(CLEAN_WASH))
			to_chat(user, span_warning("你的手被什么东西盖住了！"))
			return
	else
		user.wash(CLEAN_WASH)

	user.visible_message(
		span_notice("[user]用[src]清洗了自己的[washing_face ? "脸" : "手"]。"),
		span_notice("你用[src]清洗了你的[washing_face ? "脸" : "手"]。"),
	)

/obj/structure/water_source/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(busy)
		to_chat(user, span_warning("已经有人在这里清洗了！"))
		return ITEM_INTERACT_BLOCKING

	if(tool.item_flags & ABSTRACT) //Abstract items like grabs won't wash. No-drop items will though because it's still technically an item in your hand.
		return ITEM_INTERACT_BLOCKING

	if(is_reagent_container(tool))
		var/obj/item/reagent_containers/container = tool
		if(container.is_refillable()) // no early return, we want items that cannot perform their unique interactions to wash
			if(container.reagents.holder_full())
				to_chat(user, span_notice("[container]是满的。"))
				return ITEM_INTERACT_BLOCKING

			container.reagents.add_reagent(dispensedreagent, min(container.volume - container.reagents.total_volume, container.amount_per_transfer_from_this))
			to_chat(user, span_notice("你从[src]装满了[container]。"))
			return ITEM_INTERACT_SUCCESS


	if(istype(tool, /obj/item/melee/baton/security))
		var/obj/item/melee/baton/security/baton = tool
		if(baton.cell?.charge && baton.active)
			flick("baton_active", src)
			user.Paralyze(baton.knockdown_time)
			user.set_stutter(baton.knockdown_time)
			baton.cell.use(baton.cell_hit_cost)
			user.visible_message(
				span_warning("[user]在试图清洗已开启的[baton.name]时电到了自己！"),
				span_userdanger("你在[baton]还开着的时候不明智地试图清洗它。"))
			playsound(src, baton.on_stun_sound, 50, TRUE)
			return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/mop))
		tool.reagents.add_reagent(dispensedreagent, 5)
		to_chat(user, span_notice("你在[src]里浸湿了[tool]。"))
		playsound(loc, 'sound/effects/slosh.ogg', 25, TRUE)
		return ITEM_INTERACT_SUCCESS

	if(!user.combat_mode || (tool.item_flags & NOBLUDGEON))
		to_chat(user, span_notice("你开始清洗[tool]……"))
		busy = TRUE
		if(!do_after(user, 4 SECONDS, target = src))
			busy = FALSE
			return ITEM_INTERACT_BLOCKING
		busy = FALSE
		tool.wash(CLEAN_WASH)
		reagents.expose(tool, TOUCH, 5 / max(reagents.total_volume, 5))
		user.visible_message(
			span_notice("[user]用[src]清洗了[tool]。"),
			span_notice("你用[src]清洗了[tool]。"))
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/structure/water_source/puddle //splishy splashy ^_^
	name = "水洼"
	desc = "用于洗手和洗脸的水洼。"
	icon_state = "puddle"
	base_icon_state = "puddle"
	resistance_flags = UNACIDABLE

/obj/structure/water_source/puddle/Initialize(mapload)
	. = ..()
	register_context()

/obj/structure/water_source/puddle/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_RMB] = "捞蝌蚪"

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/structure/water_source/puddle/attack_hand(mob/user, list/modifiers)
	icon_state = "[base_icon_state]-splash"
	. = ..()
	icon_state = base_icon_state

/obj/structure/water_source/puddle/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	icon_state = "[base_icon_state]-splash"
	. = ..()
	icon_state = base_icon_state

/obj/structure/water_source/puddle/attack_hand_secondary(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(DOING_INTERACTION_WITH_TARGET(user, src))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	icon_state = "[base_icon_state]-splash"
	balloon_alert(user, "正在捞蝌蚪……")
	if(do_after(user, 5 SECONDS, src))
		playsound(loc, 'sound/effects/slosh.ogg', 15, TRUE)
		balloon_alert(user, "捞到一只蝌蚪")
		var/obj/item/fish/tadpole/tadpole = new(loc)
		tadpole.randomize_size_and_weight()
		user.put_in_hands(tadpole)
	icon_state = base_icon_state
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
