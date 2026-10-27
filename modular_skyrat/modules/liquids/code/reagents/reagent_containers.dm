/obj/item/reagent_containers/Initialize(mapload, vol)
	. = ..()

	AddComponent(/datum/component/liquids_interaction, TYPE_PROC_REF(/obj/item/reagent_containers/cup/beaker, attack_on_liquids_turf))

/**
 * Proc to remove liquids from a turf using a reagent container.
 *
 * Arguments:
 * * tile - On which tile we're trying to absorb liquids
 * * user - Who tries to absorb liquids with this?
 * * liquids - Liquids we're trying to absorb.
 */
/obj/item/reagent_containers/proc/attack_on_liquids_turf(turf/target_turf, mob/living/user, obj/effect/abstract/liquid_turf/liquids)
	if(user.combat_mode)
		return FALSE

	if(!spillable)
		return FALSE

	if(!user.Adjacent(target_turf))
		return FALSE

	if(liquids.fire_state) //Use an extinguisher first
		to_chat(user, span_warning("着着火的时候你没法舀起任何东西！"))
		return TRUE

	if(liquids.height == 1)
		to_chat(user, span_warning("这滩液体太浅了，什么也舀不起来！"))
		return TRUE

	var/free_space = reagents.maximum_volume - reagents.total_volume
	if(free_space <= 0)
		to_chat(user, span_warning("[src] 里已经装不下更多液体了！"))
		return TRUE

	var/desired_transfer = amount_per_transfer_from_this
	if(desired_transfer > free_space)
		desired_transfer = free_space

	var/datum/reagents/tempr = liquids.take_reagents_flat(desired_transfer)
	tempr.trans_to(reagents, tempr.total_volume)
	to_chat(user, span_notice("你用 [src] 舀起了约 [amount_per_transfer_from_this] 单位液体。"))
	qdel(tempr)
	user.changeNext_move(CLICK_CD_MELEE)
	return TRUE
