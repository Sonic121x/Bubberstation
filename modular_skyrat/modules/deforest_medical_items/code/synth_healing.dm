// Used to stop synth structural damage
/obj/item/stack/medical/wound_recovery/robofoam
	name = "机械修复喷剂"
	singular_name = "机械修复喷剂"
	desc = "一把针尖式泡沫枪，装有先进的合成泡沫，可迅速 \
		填充并稳定合成体的结构性损伤。在泡沫硬化期间，受损部位会 \
		更容易受到进一步的伤害。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "robofoam"
	inhand_icon_state = "implantcase"
	applicable_wounds = list(
		/datum/wound/blunt/robotic,
	)
	max_amount = 2
	amount = 2
	merge_type = /obj/item/stack/medical/wound_recovery/robofoam
	treatment_sound = 'sound/effects/spray.ogg'
	causes_pain = FALSE

/obj/item/stack/medical/wound_recovery/robofoam/examine(mob/user)
	. = ..()
	. += span_notice("这种<b>更便宜</b>的泡沫只能用于填充合成体身上的<b>结构性</b>创伤。")
	return .

/obj/item/stack/medical/wound_recovery/robofoam/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/nanite_slurry, 5)
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/coagulant/fabricated, 5)

// Used to cure practically any synthetic wound
/obj/item/stack/medical/wound_recovery/robofoam_super
	name = "高级机械修复喷剂"
	singular_name = "高级机械修复喷剂"
	desc = "一把针尖式泡沫枪，装有先进的合成泡沫，可迅速 \
		填充并稳定合成体的结构性损伤。在泡沫硬化期间，受损部位会 \
		更容易受到进一步的伤害。 \
		这种特殊的高级型号还可用于修复几乎任何类型的 \
		合成体损伤。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "robofoam_super"
	inhand_icon_state = "implantcase"
	applicable_wounds = list(
		/datum/wound/blunt/robotic,
		/datum/wound/muscle/robotic,
		/datum/wound/electrical_damage,
		/datum/wound/burn/robotic,
	)
	max_amount = 2
	amount = 2
	merge_type = /obj/item/stack/medical/wound_recovery/robofoam_super
	treatment_sound = 'sound/effects/spray.ogg'
	causes_pain = FALSE

/obj/item/stack/medical/wound_recovery/robofoam_super/examine(mob/user)
	. = ..()
	. += span_notice("这种<b>更昂贵</b>的泡沫可用于填充合成体身上的<b>任何</b>类型创伤。")
	return .

/obj/item/stack/medical/wound_recovery/robofoam_super/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/coagulant/fabricated, 5)
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/nanite_slurry, 5)
	healed_mob.reagents.add_reagent(/datum/reagent/dinitrogen_plasmide, 5)

// Synth repair patch, gives the synth a small amount of healing chems
/obj/item/reagent_containers/applicator/pill/robotic_patch
	name = "机械贴片"
	desc = "一种用于合成体的接触式化学贴片。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "synth_patch"
	inhand_icon_state = null
	possible_transfer_amounts = list()
	volume = 40
	apply_method = "贴上"
	self_delay = 3 SECONDS

/obj/item/reagent_containers/applicator/pill/robotic_patch/attack(mob/living/L, mob/user)
	if(ishuman(L))
		var/obj/item/bodypart/affecting = L.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, span_warning("这条肢体不见了！"))
			return
		if(!IS_ROBOTIC_LIMB(affecting))
			to_chat(user, span_notice("机械贴片对有机肢体没有效果！"))
			return
	return ..()

/obj/item/reagent_containers/applicator/pill/robotic_patch/canconsume(mob/eater, mob/user)
	if(!iscarbon(eater))
		return FALSE
	return TRUE

// The actual patch
/obj/item/reagent_containers/applicator/pill/robotic_patch/synth_repair
	name = "机械修复贴片"
	desc = "一种密封贴片，内含一小群纳米机器以及电学凝血试剂，可修复少量合成体损伤。"
	icon_state = "synth_patch"
	list_reagents = list(
		/datum/reagent/medicine/nanite_slurry = 10,
		/datum/reagent/dinitrogen_plasmide = 5,
		/datum/reagent/medicine/coagulant/fabricated = 10,
	)
