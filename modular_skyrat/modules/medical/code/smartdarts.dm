//The SmartDarts themselves
/obj/item/reagent_containers/syringe/smartdart
	name = "智能飞镖"
	desc = "允许使用者在安全距离外注射化学物质，而不会伤害患者。"
	volume = 10
	icon = 'modular_skyrat/modules/medical/icons/obj/smartdarts.dmi'
	icon_state = "dart_0"
	possible_transfer_amounts = list(1, 2, 5, 10)
	base_icon_state = "dart"
	embed_type = /datum/embedding/syringe/smartdart
	/// List containing chemicals that Smartdarts can inject.
	var/list/allowed_medicine = list(
		/datum/reagent/medicine,
		/datum/reagent/vaccine,
	)
	/// Blacklist that contains medicines that SmartDarts are unable to inject.
	var/list/disallowed_medicine = list(
		/datum/reagent/inverse,
		/datum/reagent/medicine/morphine,
	)

/obj/item/reagent_containers/syringe/smartdart/proc/get_allergies(mob/living/carbon/injectee)
	var/list/allergy_list = list()
	for(var/datum/quirk/quirky as anything in injectee.quirks)
		if(!istype(quirky, /datum/quirk/item_quirk/allergic))
			continue
		var/datum/quirk/item_quirk/allergic/allergies_quirk = quirky
		allergy_list = allergies_quirk.allergies
	return allergy_list

/obj/item/reagent_containers/syringe/smartdart/proc/get_safe_inject_amount(datum/reagent/meds, mob/living/carbon/injectee, requested_amount)
	if(!meds)
		return 0
	if(!is_type_in_list(meds, allowed_medicine))
		return 0
	if(is_type_in_list(meds, disallowed_medicine))
		return 0

	var/inject_amount = min(meds.volume, requested_amount)
	if(meds.overdose_threshold <= 0)
		return inject_amount

	var/overdose_amount = meds.overdose_threshold
	var/safe_overdose_amount = overdose_amount - 2 // This buffer keeps SmartDarts from pushing someone directly to overdose.

	for(var/datum/reagent/injectee_chemical as anything in injectee.reagents.reagent_list)
		if(injectee_chemical.type == meds.type)
			safe_overdose_amount -= injectee_chemical.volume

	return max(0, min(inject_amount, safe_overdose_amount))

/obj/item/reagent_containers/syringe/smartdart/proc/transfer_smartdart_reagent(mob/living/carbon/injectee, datum/reagent/meds, amount, show_message = TRUE)
	var/list/reagent_added = list()
	var/transferred = injectee.reagents.add_reagent(
		meds.type,
		amount,
		reagents.copy_data(meds),
		reagents.chem_temp,
		meds.purity,
		meds.ph,
		no_react = TRUE,
		reagent_added = reagent_added,
	)
	if(!transferred)
		return 0

	reagents.remove_reagent(meds.type, transferred)
	injectee.reagents.expose(injectee, INJECT, 1, show_message, reagent_added)
	injectee.reagents.handle_reactions()
	return transferred

/obj/item/reagent_containers/syringe/smartdart/proc/transfer_smartdart_reagents(mob/living/carbon/injectee, amount, show_message = TRUE)
	if(!injectee.reagents || !reagents.total_volume)
		return FALSE

	var/list/allergy_list = get_allergies(injectee)
	var/remaining_amount = amount
	var/prevention_used = FALSE
	for(var/datum/reagent/meds as anything in reagents.reagent_list.Copy())
		if(remaining_amount <= 0)
			break
		if(is_type_in_list(meds, allergy_list))
			prevention_used = TRUE
			continue

		var/inject_amount = get_safe_inject_amount(meds, injectee, remaining_amount)
		if(inject_amount <= 0)
			continue

		var/transferred = transfer_smartdart_reagent(injectee, meds, inject_amount, show_message)
		remaining_amount -= transferred

	return prevention_used

/datum/embedding/syringe/smartdart
	fall_chance = 2
	jostle_chance = 0
	pain_stam_pct = 1
	pain_mult = 0
	jostle_pain_mult = 0
	impact_pain_mult = 0
	remove_pain_mult = 0
	transfer_per_second = 1.5
	var/prevention_announced = FALSE

/datum/embedding/syringe/smartdart/process_effect(seconds_per_tick)
	var/obj/item/reagent_containers/syringe/smartdart/smartdart = parent
	if(!istype(smartdart))
		return
	if(!IS_ORGANIC_LIMB(owner_limb))
		return

	var/prevention_used = smartdart.transfer_smartdart_reagents(owner, transfer_per_second * seconds_per_tick, show_message = SPT_PROB(15, seconds_per_tick))
	if(prevention_used && !prevention_announced)
		prevention_announced = TRUE
		owner.visible_message(span_notice("[smartdart] 发出了一声短促的哔声。"), span_notice("你听到 [smartdart] 发出一声短促的哔声。"))
		playsound(smartdart, 'sound/machines/ping.ogg', 50, TRUE, -1)

//Code that handles the base interactions involving smartdarts
/obj/item/reagent_containers/syringe/smartdart/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(target.reagents)
		to_chat(user, span_warning("[src] 无法手动注射化学物质。"))
	return NONE
//A majority of this code is from the original syringes.dm file.
/obj/item/reagent_containers/syringe/smartdart/interact_with_atom_secondary(atom/target, mob/living/user, list/modifiers)
	if(!try_syringe(target, user))
		return ITEM_INTERACT_BLOCKING

	if(reagents.total_volume >= reagents.maximum_volume)
		to_chat(user, span_notice("[src] 已满。"))
		return ITEM_INTERACT_BLOCKING

	if(isliving(target))
		to_chat(user, span_warning("[src] 无法采血。"))
		return ITEM_INTERACT_BLOCKING

	if(!target.reagents.total_volume)
		to_chat(user, span_warning("[target] 是空的！"))
		return ITEM_INTERACT_BLOCKING

	if(!target.is_drawable(user))
		to_chat(user, span_warning("你不能直接从 [target] 中抽取试剂！"))
		return ITEM_INTERACT_BLOCKING

	var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transferred_by = user) // transfer from, transfer to - who cares?
	to_chat(user, span_notice("你向 [src] 中注入了 [trans] 单位溶液。现在它含有 [reagents.total_volume] 单位。"))

	return ITEM_INTERACT_SUCCESS

//The base smartdartgun
/obj/item/gun/syringe/smartdart
	name = "医疗智能飞镖枪"
	desc = "医疗注射枪的改装版，只允许装填智能飞镖。"
	w_class = WEIGHT_CLASS_NORMAL //I might need to look into changing this later depending on feedback
	icon = 'modular_skyrat/modules/medical/icons/obj/dartguns.dmi'
	icon_state = "smartdartgun"
	worn_icon_state = "medicalsyringegun"
	item_flags = null
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5.3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)

/obj/item/gun/syringe/smartdart/Initialize(mapload)
	. = ..()
	chambered = new /obj/item/ammo_casing/syringegun/dart(src)

/obj/item/gun/syringe/smartdart/give_gun_safeties()
	return

/obj/item/gun/syringe/smartdart/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/reagent_containers/syringe/smartdart))
		return ..()
	to_chat(user, span_notice("[tool] 装不进 [src]！请改用<b>智能飞镖</b>。"))
	return ITEM_INTERACT_BLOCKING

/obj/item/gun/syringe/smartdart/examine(mob/user)
	. = ..()

	for(var/obj/item/reagent_containers/syringe/dart as anything in syringes)
		. += "已装填 [dart]。"

//Smartdart projectiles
/obj/item/ammo_casing/syringegun/dart
	harmful = FALSE
	projectile_type = /obj/projectile/bullet/dart/syringe/dart

//Handles loading smartdarts into regular syringeguns
/obj/item/ammo_casing/syringegun/newshot(alternative_ammo)
	if(!loaded_projectile)
		if(!isnull(alternative_ammo))
			loaded_projectile = new alternative_ammo(src, src)
			harmful = FALSE
		else
			loaded_projectile = new projectile_type(src, src)
			harmful = TRUE

/obj/projectile/bullet/dart/syringe/dart
	name = "智能飞镖"
	damage = 0
