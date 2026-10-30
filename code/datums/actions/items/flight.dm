// Action that toggles flight onto the mob.
/datum/action/item_action/toggle_flight
	name = "启动飞行推进器"
	desc = "启动喷气靴的微型火箭推进器，实现持续飞行。"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "jet_boot_toggle"
	/// Managed overlay for the fire produced from flight.
	var/mutable_appearance/jet_fire
	/// Audio loop for when the jet boot flight is active.
	var/datum/looping_sound/burning_jet/burning_audio

/datum/action/item_action/toggle_flight/New(Target)
	. = ..()
	jet_fire = mutable_appearance('icons/effects/effects.dmi', "jetfire")
	jet_fire.pixel_z = -4
	burning_audio = new(target)

/datum/action/item_action/toggle_flight/Destroy()
	. = ..()
	QDEL_NULL(jet_fire)
	QDEL_NULL(burning_audio)

/datum/action/item_action/toggle_flight/Grant(mob/grant_to)
	. = ..()
	grant_to.AddComponent( \
		/datum/component/jetpack, \
		FALSE, \
		2 NEWTONS, \
		COMSIG_JETBOOTS_ACTIVE, \
		COMSIG_JETBOOTS_INACTIVE, \
		null, \
		CALLBACK(src, PROC_REF(can_fly)), \
		CALLBACK(src, PROC_REF(can_fly)), \
		/datum/effect_system/trail_follow/smoke, \
	)

/datum/action/item_action/toggle_flight/Remove(mob/remove_from)
	if(HAS_TRAIT_FROM(remove_from, TRAIT_MOVE_FLOATING, SHOES_TRAIT))
		switch_flight()
	return ..()

/datum/action/item_action/toggle_flight/do_effect(trigger_flags)
	if(!ishuman(owner))
		to_chat(owner, span_warning("很遗憾，这双鞋并不适合你的身体。"))
		return FALSE
	if(!target)
		return FALSE
	switch_flight()
	return TRUE

/// Proc that toggles between flight behavior on the mob being on and off, including the mob's flight, gravity, passtable, and the sounds/visuals.
/datum/action/item_action/toggle_flight/proc/switch_flight()
	var/obj/item/clothing/shoes/bhop/rocket/jet/target_shoes = target
	var/mob/living/carbon/human/human_owner = owner

	if(!HAS_TRAIT_FROM(human_owner, TRAIT_MOVE_FLOATING, SHOES_TRAIT))
		//functional
		MODIFY_PHYSIOLOGY(human_owner, PHYS_COEFF_STUN, 2)
		human_owner.add_traits(list(TRAIT_MOVE_FLOATING, TRAIT_IGNORING_GRAVITY, TRAIT_NOGRAV_ALWAYS_DRIFT), SHOES_TRAIT)
		human_owner.add_movespeed_modifier(/datum/movespeed_modifier/jetpack/shoes)
		human_owner.AddElement(/datum/element/forced_gravity, 0)
		SEND_SIGNAL(human_owner, COMSIG_JETBOOTS_ACTIVE, human_owner)
		ADD_TRAIT(human_owner, TRAIT_PASSTABLE, SHOES_TRAIT)
		to_chat(human_owner, span_notice("你将喷气靴相互一碰，开始缓缓悬浮在地面上方……"))
		human_owner.set_resting(FALSE, TRUE)
		human_owner.refresh_gravity()
		RegisterSignals(human_owner, list(COMSIG_LIVING_STATUS_STUN, COMSIG_LIVING_STATUS_KNOCKDOWN, COMSIG_LIVING_STATUS_PARALYZE), PROC_REF(switch_flight))
		//visuals
		burning_audio.start()
		human_owner.add_overlay(jet_fire)
		target_shoes.flight_active = TRUE
		target_shoes.update_appearance(UPDATE_ICON_STATE)
		human_owner.update_appearance(UPDATE_OVERLAYS)
		return

	//functional
	MODIFY_PHYSIOLOGY(human_owner, PHYS_COEFF_STUN, 0.5)
	human_owner.remove_traits(list(TRAIT_MOVE_FLOATING, TRAIT_IGNORING_GRAVITY, TRAIT_NOGRAV_ALWAYS_DRIFT), SHOES_TRAIT)
	human_owner.remove_movespeed_modifier(/datum/movespeed_modifier/jetpack/shoes)
	human_owner.RemoveElement(/datum/element/forced_gravity, 0)
	SEND_SIGNAL(human_owner, COMSIG_JETBOOTS_INACTIVE, human_owner)
	REMOVE_TRAIT(human_owner, TRAIT_PASSTABLE, SHOES_TRAIT)
	to_chat(human_owner, span_notice("你缓缓落回地面……"))
	human_owner.refresh_gravity()
	UnregisterSignal(human_owner, list(COMSIG_LIVING_STATUS_STUN, COMSIG_LIVING_STATUS_KNOCKDOWN, COMSIG_LIVING_STATUS_PARALYZE))
	//visuals
	burning_audio.stop()
	human_owner.cut_overlay(jet_fire)
	target_shoes.flight_active = FALSE
	target_shoes.update_appearance(UPDATE_ICON_STATE)
	human_owner.update_appearance(UPDATE_OVERLAYS)

/// Largely lifted off of wing's can_fly proc, tailored to the jet boots functionality.
/datum/action/item_action/toggle_flight/proc/can_fly()
	var/mob/living/carbon/human/human = owner
	if(IS_UNCONSCIOUS_OR_CRIT(human) || human.body_position == LYING_DOWN || isnull(human.client))
		return FALSE

	var/turf/location = get_turf(human)
	if(!location)
		return FALSE
	if(human.get_item_by_slot(ITEM_SLOT_LEGCUFFED))
		to_chat(human, span_warning("你的双腿被束缚住了！先挣脱束缚！"))
		return FALSE

	var/datum/gas_mixture/environment = location.return_air()
	if(environment?.return_pressure() < HAZARD_LOW_PRESSURE + 10)
		to_chat(human, span_warning("空气太稀薄，无法飞行！"))
		return FALSE
	return TRUE
