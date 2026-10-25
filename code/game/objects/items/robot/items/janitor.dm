/obj/item/borg/cleaner_box
	name = "清洁真空套装"
	desc = "一种模块，旨在通过把你的活儿甩给那些更加软乎乎的上司来弥补你缺少双手的缺陷。"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "cleanerbox"
	var/obj/item/vacuum_item/hose
	var/deployed = FALSE
	var/locked = FALSE
	var/datum/weakref/module_list

/obj/item/borg/cleaner_box/Initialize(mapload)
	. = ..()
	var/mob/living/silicon/robot = loc
	if(!istype(robot))
		return INITIALIZE_HINT_QDEL
	var/obj/item/robot_model/janitor/model = locate() in robot.get_contents()
	module_list = WEAKREF(model)
	AddComponent(/datum/component/borg_item_offered_when_pulled, robot)
	ADD_TRAIT(src, TRAIT_BORG_GIVE, TRAIT_BORG_GIVE)
	hose = new(src)
	hose.cleaner_box = WEAKREF(src)
	hose.AddComponent( \
		/datum/component/transforming, \
		force_on = hose.force, \
		hitsound_on = hose.hitsound, \
		w_class_on = hose.w_class, \
		clumsy_check = FALSE, \
		attack_verb_continuous_on = list("冲洗", "拖擦", "刷洗", "敲打", "轻拍", "消毒"), \
		attack_verb_simple_on = list("冲洗", "拖擦", "刷洗", "敲打", "轻拍", "消毒"), \
		)
	hose.RegisterSignal(hose, COMSIG_TRANSFORMING_ON_TRANSFORM, TYPE_PROC_REF(/obj/item/vacuum_item, on_transform))
	update_icon(UPDATE_OVERLAYS)

/obj/item/borg/cleaner_box/Destroy(force)
	if(hose?.borg_hose)
		QDEL_NULL(hose.borg_hose)
	if(deployed)
		hose.retract_hose()
	QDEL_NULL(hose)
	return ..()

/obj/item/borg/cleaner_box/attack_self(mob/user, modifiers)
	. = ..()
	if(deployed)
		hose.retract_hose()
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/item/borg/cleaner_box/click_alt(mob/user)
	if(deployed)
		hose.retract_hose()
	locked = !locked
	update_icon(UPDATE_OVERLAYS)
	return CLICK_ACTION_SUCCESS

/obj/item/borg/cleaner_box/on_offered(mob/living/offerer, mob/living/carbon/offered)
	. = TRUE
	if(SEND_SIGNAL(src, COMSIG_ITEM_OFFERING, offerer) & COMPONENT_OFFER_INTERRUPT)
		return
	if(hose.loc != src && !istype(hose.loc, /mob/living)) // Error handling
		stack_trace("[src] has been offered with [hose] not present inside its contents or inside a mob's loc variable. Location: [isnull(loc) ? "NULLSPACE" : "[hose.loc], X: [hose.x], Y: [hose.y], Z:[hose.z]"]")
		deployed = FALSE
		hose.forceMove(src)
	if(locked || deployed)
		return
	if(!offered)
		offered = locate(/mob/living/carbon) in orange(1, offerer)
	if(offered && istype(offered))
		offerer.visible_message(
			span_notice("[offerer]把清洁套装的把手伸向[offered]。"),
			span_notice("你[src]的把手伸向[offered]的手。"), null, 2)

	offerer.apply_status_effect(/datum/status_effect/offering, src, /atom/movable/screen/alert/give/borg, offered)
	return

/obj/item/borg/cleaner_box/on_offer_taken(mob/living/offerer, mob/living/taker)
	. = ..()
	if(.)
		return TRUE
	hose.bag = istype(loc, /mob/living/silicon) ? pick(loc.get_all_contents_type(/obj/item/storage/bag/trash)) : locate(/obj/item/storage/bag/trash) in module_list.resolve()
	if(!hose.bag)
		stack_trace("[src] failed to connect to a trash bag on [module_list.resolve()].")
		return TRUE
	taker.visible_message(
		span_notice("[taker]从[offerer]手中接过[hose]。"),
		span_notice("你从[offerer]手中接过[hose]。"))
	hose.do_pickup_animation(taker, offerer)
	taker.put_in_hands(hose)
	hose.borg_hose = hose.generate_hose(offerer, taker)
	hose.RegisterSignal(hose, COMSIG_ITEM_DROPPED, TYPE_PROC_REF(/obj/item/vacuum_item, on_drop))
	playsound(hose, 'sound/items/vacuum/vacuum_hose.ogg', 100, TRUE)
	deployed = TRUE
	update_icon(UPDATE_OVERLAYS)
	offerer.remove_status_effect(/datum/status_effect/offering)
	return TRUE

/obj/item/borg/cleaner_box/update_overlays()
	. = ..()
	if(deployed)
		. += "cleanerbox_on"
	else
		. += "cleanerbox_wand"
	if(locked)
		. += "cleanerbox_locked"

/obj/item/borg/cleaner_box/examine(mob/user)
	. = ..()
	. += span_notice("<b>Alt 点击</b>以<b>[locked ? "解锁" : "锁定"]</b>[src]。")

/obj/item/vacuum_item
	name = "清洁地板清洁器"
	desc = "这是某台工业清洁器的工作端——有人不幸赋予了它智慧。"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "vacuum-wand"
	inhand_icon_state = "vacuum-wand"
	righthand_file = 'icons/mob/inhands/items/vacuum_wand_righthand.dmi'
	lefthand_file = 'icons/mob/inhands/items/vacuum_wand_lefthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	obj_flags = INDESTRUCTIBLE // To prevent fuckery and a broken borg module.
	attack_verb_continuous = list("吸吮", "吸尘", "拍打", "强行除尘", "击打")
	attack_verb_simple = list("吸吮", "吸尘", "拍打", "除尘", "击打")
	force = 12

	var/datum/beam/held/vacuum/borg_hose
	var/datum/weakref/cleaner_box
	var/obj/item/storage/bag/trash/bag
	var/cleaning = FALSE

/obj/item/vacuum_item/Destroy(force)
	bag = null
	return ..()

/obj/item/vacuum_item/interact_with_atom(obj/item/thing, mob/living/user, list/modifiers)
	. = ..()
	if(!istype(thing))
		return NONE
	if(!bag && cleaning)
		return NONE
	if(thing.anchored || thing.w_class >= WEIGHT_CLASS_BULKY)
		return NONE
	playsound(bag, 'sound/items/vacuum/vacuum_use.ogg', 20, TRUE)
	for(var/obj/item/I in get_turf(thing))
		if(!istype(I, thing.type))
			continue
		if(!do_after(user, 0.1 SECONDS, user, show_progress = FALSE))
			break
		if(bag.atom_storage.attempt_insert(I, user, FALSE))
			continue
		break

/obj/item/vacuum_item/proc/on_transform(obj/item/source, mob/living/user, active)
	SIGNAL_HANDLER

	cleaning = !cleaning
	if(!user)
		return COMPONENT_NO_DEFAULT_MESSAGE
	playsound(src, 'sound/items/vacuum/vacuum_clack.ogg', 30, TRUE)
	if(cleaning) //CLEAN_SCRUB because if you get a borg to help you clean up a crime, you deserve to win.
		balloon_alert(user, "清洁中")
		AddComponent( \
			/datum/component/cleaner, \
			base_cleaning_duration = 1 SECONDS, \
			pre_clean_callback = CALLBACK(src, PROC_REF(clean_sound)), \
			)
	else
		balloon_alert(user, "吸尘中")
		qdel(GetComponent(/datum/component/cleaner))
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/vacuum_item/proc/clean_sound()
	playsound(src, 'sound/items/vacuum/vacuum_steam.ogg', 10, TRUE)
	return CLEAN_ALLOWED

/obj/item/vacuum_item/proc/retract_hose()
	var/obj/item/borg/cleaner_box/cleaner_resolved = cleaner_box?.resolve()
	if(!cleaner_resolved)
		CRASH("Somehow [src] doesn't have a source to return to!")
	if(loc == cleaner_resolved)
		return
	do_pickup_animation(cleaner_resolved, get_turf(src))
	forceMove(cleaner_resolved)
	playsound(cleaner_resolved, 'sound/items/vacuum/vacuum_ploop.ogg', 100)
	if(!isnull(borg_hose) && !QDELING(borg_hose))
		balloon_alert_to_hearers("snap")
		QDEL_NULL(borg_hose)
	bag = null
	cleaner_resolved.deployed = FALSE
	UnregisterSignal(src, COMSIG_ITEM_DROPPED)
	cleaner_resolved.update_icon(UPDATE_OVERLAYS)

/obj/item/vacuum_item/proc/generate_hose(mob/living/offerer, mob/living/taker)
	var/datum/beam/held/vacuum/generated_borg_hose = new(taker, offerer, icon_state = "hosebeam", max_distance = 7, emissive = FALSE, beam_layer = BELOW_MOB_LAYER)
	var/index = taker.get_held_index_of_item(src)
	generated_borg_hose.lefthand = IS_LEFT_INDEX(index)
	INVOKE_ASYNC(generated_borg_hose, TYPE_PROC_REF(/datum/beam, Start))
	RegisterSignal(generated_borg_hose, COMSIG_QDELETING, PROC_REF(retract_hose))
	RegisterSignal(generated_borg_hose, COMSIG_BEAM_BEFORE_DRAW, PROC_REF(on_update))
	return generated_borg_hose

/obj/item/vacuum_item/examine(mob/user)
	. = ..()
	. += span_notice("<b>交互</b>以切换到[cleaning ? "<b>吸尘</b>" : "<b>清洁</b>"]模式。")
/obj/item/vacuum_item/proc/on_update()
	SIGNAL_HANDLER
	var/mob/living/mob = borg_hose.origin
	if(istype(mob))
		var/index = mob.is_holding(src)
		borg_hose.lefthand = IS_LEFT_INDEX(index)
	if(prob(10))
		playsound(src, 'sound/items/vacuum/vacuum_hose.ogg', 50, TRUE)

/obj/item/vacuum_item/proc/on_drop(obj/item/vacuum, mob/living/user)
	SIGNAL_HANDLER
	if(user == loc)
		return
	retract_hose()

/datum/beam/held/vacuum
	righthand_s_px = -7
	righthand_s_py = -3

	righthand_e_px = 0
	righthand_e_py = -6

	righthand_w_px = -3
	righthand_w_py = -6

	righthand_n_px = 8
	righthand_n_py = -6

	lefthand_s_px = 7
	lefthand_s_py = -3

	lefthand_e_px = 3
	lefthand_e_py = -6

	lefthand_w_px = 0
	lefthand_w_py = -6

	lefthand_n_px = -8
	lefthand_n_py = -6



