

///Parent component that stores shared info
/datum/component/reagent_imbued/
	///the item that the component is attached to
	var/obj/item/parent_item
	///required type to attach to
	var/obj/item/required_type = /obj/item
	//the imbued reagents
	var/datum/reagents/imbued_reagent = new(10, NO_REACT)
	///the text to show the player what happens
	var/examine_imbued_description = "它目前注入了以下试剂："
	///required parent item integrity% for reagent effects
	var/integrity_required
	///how much reagent to inject per tic/proc
	var/inject_amount = 0
	///what smithing oil does to this (at 100% oil imbuing it has 100% of the listed effects)
	var/list/smithing_oil_effects = list()
	///keeps track of how effective last smithing oil imbue did (% of total imbue capacity)
	var/last_smithing_oil_ratio_applied = 0
	///damage mult on parent item when reagent procs
	var/integrity_loss_per_inject = 1
	///random 0 to X amount of damage inflicted onto parent item when reagent procs
	var/integrity_lost_inject_random = 0

/// * set_slot: Used for clothing only, ignore if this isn't the case.
/// * integrity: what integ % is required to use the reagent imbue?
/datum/component/reagent_imbued/Initialize(list/oil_effects = list(), integrity = 0.85, set_slot = null, reagent_integrity_loss_factor = 1, reagent_integrity_loss_random = 0)
	if(!istype(parent, required_type))
		return COMPONENT_INCOMPATIBLE //they need to be clothing, I already said this
	parent_item = parent
	parent_item.create_reagents(MAX_PRE_IMBUE_STORAGE, INJECTABLE | REFILLABLE)
	integrity_required = integrity
	RegisterSignal(parent_item, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent_item, COMSIG_ATOM_EXAMINE_MORE, PROC_REF(on_examine_more))
	smithing_oil_effects = oil_effects
	integrity_loss_per_inject = reagent_integrity_loss_factor
	integrity_lost_inject_random = reagent_integrity_loss_random

/datum/component/reagent_imbued/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	if(USER_CAN_REAGENT_IMBUE(user))
		examine_list += span_notice("将 [parent_item] 浸入淬火槽等容器，或向其中倒入化学试剂后放入锻炉回火，即可注入试剂！")
	else
		examine_list += span_notice("如果掌握特定的锻造技巧，就能向其中注入特殊化学试剂……")
	if(parent_item.get_integrity_percentage() < integrity_required)
		examine_list += span_notice("必须先修复它，注入的试剂才能发挥效果……")
	if(imbued_reagent.reagent_list.len >= 1 && (USER_CAN_REAGENT_IMBUE(user) || HAS_TRAIT(user, TRAIT_REAGENT_SCANNER)))
		examine_list += span_notice("仔细检查可以了解其中注入了什么，以及锻造油的作用……")


/datum/component/reagent_imbued/proc/on_examine_more(obj/item/source, mob/examiner, list/examine_list)
	if(imbued_reagent.reagent_list.len >= 1 && (HAS_TRAIT(examiner, TRAIT_KNOW_ADVANCED_SMITHING) || HAS_TRAIT(examiner, TRAIT_REAGENT_SCANNER)))
		add_reagent_imbue_description(examine_list)

	add_oil_imbue_effect_description(examine_list)

/datum/component/reagent_imbued/proc/add_reagent_imbue_description(list/examine_list)
	examine_list += span_notice(examine_imbued_description)
	for (var/datum/reagent/reagent in imbued_reagent.reagent_list)
		examine_list += span_notice("[reagent.volume] 单位[reagent.name]")

/datum/component/reagent_imbued/proc/add_oil_imbue_effect_description(list/examine_list)
	if(smithing_oil_effects.len > 0)
		var/list/effects_list = list()
		for(var/i in smithing_oil_effects)
			switch(i)
				if(FORGE_EFFECT_ARMOR)
					effects_list += "更有效地缓冲打击"
				if(FORGE_EFFECT_ARMORPEN)
					effects_list += "更有效地穿透护甲"
				if(FORGE_EFFECT_BLOCKCHANCE)
					effects_list += "更擅长格挡攻击"
				if(FORGE_EFFECT_DURABILITY)
					effects_list += "提高耐用性"
				if(FORGE_EFFECT_FORCE)
					effects_list += "增强破坏力"
				if(FORGE_EFFECT_REAGENT_INJECT)
					effects_list += "施加更多其他内含试剂"
				if(FORGE_EFFECT_TOOLSPEED)
					effects_list += "更高效地发挥原本用途"

		examine_list += span_notice("锻造油将使它[jointext(effects_list, "、")]。")
	else
		examine_list += span_notice("锻造油对 [parent_item] 没有效果，但可能影响用它制作的物品。")

///Replaces the imbued_reagent with the given new_reagents.
/datum/component/reagent_imbued/proc/set_reagent_imbue(datum/reagents/new_reagents, clear_source_reagents = TRUE)
	//copy in the new reagents to replace the old
	imbued_reagent.clear_reagents()
	new_reagents.trans_to(imbued_reagent, amount = new_reagents.total_volume, copy_only = TRUE, no_react = TRUE)

	apply_smithing_oil_bonus()
	set_reagent_colors(new_reagents)
	if(clear_source_reagents)
		new_reagents.clear_reagents()

/datum/component/reagent_imbued/proc/set_reagent_colors(datum/reagents/new_reagents)
	var/datum/reagents/color_reagents_list = new /datum/reagents()
	new_reagents.trans_to(color_reagents_list, amount = new_reagents.total_volume, copy_only = TRUE, no_react = TRUE)
	color_reagents_list.remove_reagent(/datum/reagent/fuel/oil/smithing, color_reagents_list.maximum_volume, FALSE)

	if(length(color_reagents_list.reagent_list) > 0)
		var/new_color = mix_color_from_reagents(color_reagents_list.reagent_list)
		if(length(new_color) > 7) //remove the transparency stuff
			new_color = copytext(new_color, 1, 8) + "FF"
		parent_item.add_atom_colour(new_color, WASHABLE_COLOUR_PRIORITY)


///This function modifies the parent item based on how much smithing oil is in our imbued reagent list. Needs to be defined in child subtypes.
/datum/component/reagent_imbued/proc/apply_smithing_oil_bonus()
	if(length(smithing_oil_effects) > 0)
		var/new_oil_ratio = imbued_reagent.remove_reagent(/datum/reagent/fuel/oil/smithing, imbued_reagent.maximum_volume, include_subtypes = FALSE)
		new_oil_ratio /= imbued_reagent.maximum_volume
		for(var/index in smithing_oil_effects)
			give_added_modifying_effect_to_item(index, last_smithing_oil_ratio_applied, new_oil_ratio, parent_item, smithing_oil_effects[index])
		last_smithing_oil_ratio_applied = new_oil_ratio

/datum/component/reagent_imbued/proc/try_inject(mob/living/target, mob/living/user = null)
	if(isnull(user))
		user = target
	//don't have the weapon or any imbued reagents? don't try
	if(isnull(parent_item) || imbued_reagent?.reagent_list?.len < 1)
		return FALSE
	if(imbued_reagent.total_volume == 0)
		return FALSE
	if(parent_item.get_integrity_percentage() < integrity_required)
		return FALSE

	//lets inject that target
	var/mob/living_target = target
	var/new_amount_to_inject = min(inject_amount, imbued_reagent.total_volume)
	imbued_reagent.trans_to(target = living_target, amount = new_amount_to_inject, transferred_by = user, methods = INJECT, copy_only = TRUE)
	var/random_integ = integrity_lost_inject_random * (rand(100)/100)
	parent_item.take_damage((integrity_loss_per_inject + random_integ) * new_amount_to_inject, sound_effect = FALSE)

	if(parent_item.get_integrity_percentage() < integrity_required)
		user.balloon_alert(user, "[parent_item] 的光泽消退了")
		to_chat(user, span_warning("[parent_item] 失去了注入试剂所带来的光泽。"))
	return TRUE

//the component that is attached to clothes that allows them to be imbued
//ONLY USE THIS FOR CLOTHING
/datum/component/reagent_imbued/clothing
	///the slot that the item will check
	var/checking_slot
	///the human that is wearing the parent_item
	var/mob/living/carbon/human/cloth_wearer
	imbued_reagent = new(maximum = REAGENT_CLOTHING_INJECT_AMOUNT, new_flags = NO_REACT)
	examine_imbued_description = "它会向佩戴者缓慢输送以下试剂："
	inject_amount = REAGENT_CLOTHING_INJECT_AMOUNT
	//the cooldown between each imbue
	COOLDOWN_DECLARE(imbue_cooldown)

/datum/component/reagent_imbued/clothing/Initialize(list/oil_effects = list(), integrity = 0.85, set_slot = null, reagent_integrity_loss_factor = 1, reagent_integrity_loss_random = 0)
	. = ..()
	if(. != COMPONENT_INCOMPATIBLE)
		if(set_slot)
			checking_slot = set_slot
		RegisterSignal(parent_item, COMSIG_ITEM_EQUIPPED, PROC_REF(set_wearer))
		RegisterSignal(parent_item, COMSIG_ITEM_PRE_UNEQUIP, PROC_REF(remove_wearer))
		START_PROCESSING(SSdcs, src)

/datum/component/reagent_imbued/clothing/Destroy(force, silent)
	parent_item = null
	cloth_wearer = null
	STOP_PROCESSING(SSdcs, src)
	return ..()


/datum/component/reagent_imbued/clothing/proc/set_wearer()
	SIGNAL_HANDLER

	if(!ishuman(parent_item.loc))
		return
	cloth_wearer = parent_item.loc

/datum/component/reagent_imbued/clothing/proc/remove_wearer()
	SIGNAL_HANDLER
	cloth_wearer = null

/datum/component/reagent_imbued/clothing/process(seconds_per_tick)
	if(!cloth_wearer)
		return

	if(parent_item != cloth_wearer.get_item_by_slot(checking_slot))
		return

	if(!COOLDOWN_FINISHED(src, imbue_cooldown))
		return

	if(try_inject(cloth_wearer))
		COOLDOWN_START(src, imbue_cooldown, 3 SECONDS)

//the component that is attached to weapons that allows them to be imbued
//ONLY USE THIS FOR WEAPONS
/datum/component/reagent_imbued/weapon
	imbued_reagent = new(REAGENT_WEAPON_INJECT_AMOUNT, NO_REACT)
	examine_imbued_description = "命中时，它会向受害者注入以下试剂："
	var/extra_force_oil_bonus = 0
	inject_amount = REAGENT_WEAPON_INJECT_AMOUNT

/datum/component/reagent_imbued/weapon/Initialize(list/oil_effects = list(), integrity = 0.85, set_slot = null)
	. = ..()
	if(. != COMPONENT_INCOMPATIBLE)
		RegisterSignal(parent_item, COMSIG_ITEM_ATTACK, PROC_REF(inject_attacked))

/datum/component/reagent_imbued/weapon/Destroy(force, silent)
	parent_item = null
	return ..()

/datum/component/reagent_imbued/weapon/proc/inject_attacked(datum/source, mob/living/target, mob/living/user, list/modifiers)
	SIGNAL_HANDLER
	try_inject(target)
#undef MAX_PRE_IMBUE_STORAGE
#undef REAGENT_CLOTHING_INJECT_AMOUNT
#undef REAGENT_WEAPON_INJECT_AMOUNT
#undef REAGENT_STAFF_INJECT_AMOUNT
