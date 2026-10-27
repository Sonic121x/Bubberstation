/datum/chemical_reaction/heroin
	results = list(/datum/reagent/drug/opium/heroin = 4)
	required_reagents = list(/datum/reagent/drug/opium = 2, /datum/reagent/acetone = 2)
	reaction_tags = REACTION_TAG_CHEMICAL
	required_temp = 480
	optimal_ph_min = 8
	optimal_ph_max = 12
	H_ion_release = -0.04
	rate_up_lim = 12.5
	purity_min = 0.5

/datum/chemical_reaction/powder_heroin
	is_cold_recipe = TRUE
	required_reagents = list(/datum/reagent/drug/opium/heroin = 8)
	required_temp = 250 //freeze it
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL
	mix_message = "溶液冻结成了粉末！"

/datum/chemical_reaction/powder_heroin/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/reagent_containers/heroin(location)

/obj/item/reagent_containers/heroin
	name = "海洛因"
	desc = "吸上一条，歇一会儿吧，老兄。"
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "heroin"
	volume = 4
	has_variable_transfer_amount = FALSE
	list_reagents = list(/datum/reagent/drug/opium/heroin = 4)

/obj/item/reagent_containers/heroin/proc/snort(mob/living/user)
	if(!iscarbon(user))
		return
	var/covered = ""
	if(user.is_mouth_covered(ITEM_SLOT_HEAD))
		covered = "头部装备"
	else if(user.is_mouth_covered(ITEM_SLOT_MASK))
		covered = "面罩"
	if(covered)
		to_chat(user, span_warning("你必须先摘下[covered]！"))
		return
	user.visible_message(span_notice("[user]开始鼻吸[src]。"))
	if(do_after(user, 30))
		to_chat(user, span_notice("你吸完了[src]。"))
		if(reagents.total_volume)
			reagents.trans_to(user, reagents.total_volume, transferred_by = user, methods = INGEST)
		qdel(src)

/obj/item/reagent_containers/heroin/attack(mob/target, mob/user)
	if(target == user)
		snort(user)

/obj/item/reagent_containers/heroin/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	. = SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(!in_range(user, src) || user.get_active_held_item())
		return

	snort(user)

	return

/obj/item/reagent_containers/heroinbrick
	name = "海洛因砖"
	desc = "一块砖状的海洛因，很适合运输！"
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "heroinbrick"
	volume = 20
	has_variable_transfer_amount = FALSE
	list_reagents = list(/datum/reagent/drug/opium/heroin = 20)


/obj/item/reagent_containers/heroinbrick/attack_self(mob/user)
	user.visible_message(span_notice("[user]开始掰碎[src]。"))
	if(do_after(user,10))
		to_chat(user, span_notice("你掰碎了[src]。"))
		for(var/i = 1 to 5)
			new /obj/item/reagent_containers/heroin(user.loc)
		qdel(src)

/datum/crafting_recipe/heroinbrick
	name = "海洛因砖"
	result = /obj/item/reagent_containers/heroinbrick
	reqs = list(/obj/item/reagent_containers/heroin = 5)
	parts = list(/obj/item/reagent_containers/heroin = 5)
	time = 20
	category = CAT_CHEMISTRY

/atom/movable/screen/fullscreen/color_vision/heroin_color
	color = "#444444"

/datum/reagent/drug/opium
	name = "鸦片"
	description = "罂粟的提取物，能让使用者产生轻微的欣快感。"
	color = "#ffe669"
	overdose_threshold = 30
	ph = 8
	taste_description = "花朵"
	addiction_types = list(/datum/addiction/opioids = 18)

/datum/reagent/drug/opium/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	var/high_message = pick("你感到欣喜陶醉。", "你觉得自己站在了世界之巅。")
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(M, span_notice("[high_message]"))
	M.add_mood_event("smacked out", /datum/mood_event/narcotic_heavy, name)
	M.adjust_brute_loss(-0.1 * REM * seconds_per_tick, 0) //can be used as a (shitty) painkiller
	M.adjust_fire_loss(-0.1 * REM * seconds_per_tick, 0)
	M.overlay_fullscreen("heroin_euphoria", /atom/movable/screen/fullscreen/color_vision/heroin_color)
	return ..()

/datum/reagent/drug/opium/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	M.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.5 * REM * seconds_per_tick)
	M.adjust_tox_loss(1 * REM * seconds_per_tick, 0)
	M.adjust_drowsiness(1 SECONDS * REM * normalise_creation_purity() * seconds_per_tick)
	return TRUE

/datum/reagent/drug/opium/on_mob_metabolize(mob/living/metabolizer)
	. = ..()
	metabolizer.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

/datum/reagent/drug/opium/on_mob_end_metabolize(mob/living/metabolizer)
	. = ..()
	metabolizer.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)
	metabolizer.clear_fullscreen("heroin_euphoria")

/datum/reagent/drug/opium/heroin
	name = "海洛因"
	description = "她对我来说就像海洛因，她对我来说就像海洛因！她绝不会……错过一根静脉！"
	color = "#ffe669"
	overdose_threshold = 20
	ph = 6
	taste_description = "花朵"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	inverse_chem = /datum/reagent/drug/opium/blacktar/liquid

/datum/reagent/drug/opium/heroin/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	var/high_message = pick("你觉得自己无可阻挡。", "你觉得自己如同神明。")
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(M, span_notice("[high_message]"))
	M.adjust_brute_loss(-0.4 * REM * seconds_per_tick, 0) //more powerful as a painkiller, possibly actually useful to medical now
	M.adjust_fire_loss(-0.4 * REM * seconds_per_tick, 0)
	..()

/datum/reagent/drug/opium/blacktar
	name = "黑焦油海洛因"
	description = "一种含杂质的游离碱形态海洛因。服用它大概不是什么好主意……"
	color = "#242423"
	overdose_threshold = 10 //more easy to overdose on
	ph = 8
	taste_description = "花朵"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/opium/blacktar/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	var/high_message = pick("你觉得自己像一团焦油。", "你觉得血管里的血液像糖浆一样黏稠。")
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(M, span_notice("[high_message]"))

	M.set_drugginess(20 SECONDS * REM * seconds_per_tick)
	M.adjust_tox_loss(0.5 * REM * seconds_per_tick, 0) //toxin damage
	return ..()

/datum/reagent/drug/opium/blacktar/liquid //prevents self-duplication by going one step down when mixed
	name = "液态黑焦油海洛因"

/datum/chemical_reaction/blacktar
	required_reagents = list(/datum/reagent/drug/opium/blacktar/liquid = 5)
	required_temp = 480
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/blacktar/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/reagent_containers/blacktar(location)

//Exports
/datum/export/heroin
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "海洛因"
	export_types = list(/obj/item/reagent_containers/heroin)
	include_subtypes = FALSE

/datum/export/heroinbrick
	cost = CARGO_CRATE_VALUE * 2.5
	unit_name = "海洛因砖"
	export_types = list(/obj/item/reagent_containers/heroinbrick)
	include_subtypes = FALSE

/datum/export/blacktar
	cost = CARGO_CRATE_VALUE * 0.4
	unit_name = "黑焦油海洛因"
	export_types = list(/obj/item/reagent_containers/blacktar)
	include_subtypes = FALSE
