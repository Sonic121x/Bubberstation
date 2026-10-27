#define INSTANT_WOUND_HEAL_STAMINA_DAMAGE 80
#define INSTANT_WOUND_HEAL_LIMB_DAMAGE 25

/obj/item/stack/medical/wound_recovery
	name = "皮下夹板贴敷器"
	desc = "一卷柔性材料，一侧密布着数百万个微型注射器。 \
		将其贴敷到骨骼结构受损的身体部位时，储存在这些 \
		注射器中的纳米机器人会包围伤口，形成一个皮下的自愈夹板。虽然这种方式 \
		既便于保持外观又能快速愈合，但纳米机器人往往会让宿主在贴敷后的数分钟内 \
		格外容易受到新的伤害。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "subsplint"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	inhand_icon_state = "sampler"
	gender = PLURAL
	singular_name = "皮下夹板贴敷器"
	self_delay = 10 SECONDS
	other_delay = 5 SECONDS
	novariants = TRUE
	max_amount = 3
	amount = 3
	merge_type = /obj/item/stack/medical/wound_recovery
	custom_price = PAYCHECK_COMMAND * 2.5
	/// If this checks for pain, used for synthetic repair foam
	var/causes_pain = TRUE
	/// The types of wounds that we work on, in list format
	var/list/applicable_wounds = list(
		/datum/wound/blunt/bone,
		/datum/wound/muscle,
	)
	/// The sound we play upon successfully treating the wound
	var/treatment_sound = 'sound/items/duct_tape/duct_tape_rip.ogg'

// Ported from Nova: \/
////// Searches for a wound that this item is capable of treating
/obj/item/stack/medical/wound_recovery/proc/find_suitable_wound(obj/item/bodypart/limb)
	for(var/datum/wound/wound as anything in limb.wounds)
		if((wound.wound_flags & ACCEPTS_GAUZE) && is_type_in_list(wound, applicable_wounds))
			return wound

/obj/item/stack/medical/add_item_context(obj/item/source, list/context, atom/target, mob/living/user)
	if(!iscarbon(target))
		return NONE
	context[SCREENTIP_CONTEXT_LMB] = "治疗"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/stack/medical/wound_recovery/try_heal_checks(mob/living/patient, mob/living/user, healed_zone, silent = FALSE)
	var/obj/item/bodypart/limb = patient.get_bodypart(healed_zone)
	if(isnull(limb))
		if(!silent)
			patient.balloon_alert(user, "这里没有[parse_zone(healed_zone)]！")
		return FALSE
	if(!LAZYLEN(limb.wounds))
		if(!silent)
			patient.balloon_alert(user, "没有伤口！") // good problem to have imo
		return FALSE
	if(patient.has_status_effect(/datum/status_effect/vulnerable_to_damage))
		if(!silent)
			patient.balloon_alert(user, "上次使用后仍在恢复中！")
		return FALSE
	if(!find_suitable_wound(limb))
		if(!silent)
			patient.balloon_alert(user, "治不了这种伤！")
		return FALSE
	return TRUE

// This is only relevant for the types of wounds defined, we can't work if there are none
/obj/item/stack/medical/wound_recovery/try_heal(mob/living/patient, mob/user, silent = FALSE, looping = FALSE, auto_change_zone = TRUE, continuous = FALSE)

	var/treatment_delay = (user == patient ? self_delay : other_delay)

	var/obj/item/bodypart/limb = patient.get_bodypart(check_zone(user.zone_selected))

	var/datum/wound/woundies = find_suitable_wound(limb)
// Ported from Nova: ^

	if(HAS_TRAIT(woundies, TRAIT_WOUND_SCANNED))
		treatment_delay *= 0.5
		if(user == patient)
			to_chat(user, span_notice("你牢记全息影像上关于自身伤势的提示，熟练地开始贴敷 [src]。"))
		else
			user.visible_message(span_warning("[user] 开始熟练地用 [src] 处理 [patient] 的[chinese_body_zone_display(limb.plaintext_zone)]上的伤口……"), span_warning("你牢记全息影像的提示，开始迅速用 [src] 处理 [patient] 的[chinese_body_zone_display(limb.plaintext_zone)]上的伤口……"))
	else
		user.visible_message(span_warning("[user] 开始用 [src] 处理 [patient] 的[chinese_body_zone_display(limb.plaintext_zone)]上的伤口……"), span_warning("你开始用 [src] 处理[chinese_body_zone_display(limb.plaintext_zone)]上的伤口……"))

	if(!do_after(user, treatment_delay, target = patient))
		return

	user.visible_message(span_green("[user] 将 [src] 贴敷到 [patient] 的[chinese_body_zone_display(limb.plaintext_zone)]上。"), span_green("你处理了[chinese_body_zone_display(limb.plaintext_zone)]上的伤口。"))
	playsound(patient, treatment_sound, 50, TRUE)
	woundies.remove_wound()
	if(!HAS_TRAIT(patient, TRAIT_ANALGESIA) || !causes_pain)
		patient.emote("scream")
		to_chat(patient, span_userdanger("你的[chinese_body_zone_display(limb.plaintext_zone)]在伤口迅速愈合时痛得像火烧一样，操！"))
		patient.add_mood_event("severe_surgery", /datum/mood_event/rapid_wound_healing)
	limb.receive_damage(brute = INSTANT_WOUND_HEAL_LIMB_DAMAGE, wound_bonus = CANT_WOUND)
	patient.adjust_stamina_loss(INSTANT_WOUND_HEAL_STAMINA_DAMAGE)
	patient.apply_status_effect(/datum/status_effect/vulnerable_to_damage)
	use(1)

/datum/mood_event/rapid_wound_healing
	description = "伤口是没了，可那疼痛实在无法忍受！\n"
	mood_change = -3
	timeout = 5 MINUTES

// Helps recover bleeding
/obj/item/stack/medical/wound_recovery/rapid_coagulant
	name = "快速凝血剂涂抹器"
	singular_name = "快速凝血剂涂抹器"
	desc = "一个小装置，里面装着某种速效凝血剂。 \
		用于出血部位时，几乎能瞬间止住所有出血。 \
		这种快速凝血作用可能会使人在涂抹后暂时 \
		更容易受到进一步的伤害。"
	icon_state = "clotter"
	inhand_icon_state = "implantcase"
	applicable_wounds = list(
		/datum/wound/slash/flesh,
		/datum/wound/pierce/bleed,
	)
	merge_type = /obj/item/stack/medical/wound_recovery/rapid_coagulant

/obj/item/stack/medical/wound_recovery/rapid_coagulant/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/coagulant/fabricated, 5)

// Helps recover burn wounds much faster, while not healing much damage directly
/obj/item/stack/medical/ointment/red_sun
	name = "红日药膏"
	singular_name = "红日药膏"
	desc = "一款广受欢迎的药膏品牌，用来应付红日之下的一切——而那通常意味着严重的烧伤。 \
		它指的究竟是哪一个红日？连药膏的生产者自己都不清楚。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "balm"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	inhand_icon_state = "bandage"
	gender = PLURAL
	novariants = TRUE
	amount = 12
	max_amount = 12
	self_delay = 4 SECONDS
	other_delay = 2 SECONDS
	heal_burn = 5
	heal_brute = 5
	flesh_regeneration = 5
	sanitization = 3
	merge_type = /obj/item/stack/medical/ointment/red_sun
	custom_price = PAYCHECK_LOWER * 1.5

/obj/item/stack/medical/ointment/red_sun/grind_results()
	return list(/datum/reagent/medicine/oxandrolone = 3)

/obj/item/stack/medical/ointment/red_sun/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/lidocaine, 2)

// Gauze that are especially good at treating burns, but are terrible splints
/obj/item/stack/medical/wrap/gauze/sterilized
	name = "密封无菌纱布"
	singular_name = "密封无菌纱布"
	desc = "一小卷经过特殊处理而完全无菌的弹性材料，为保险起见还密封在塑料中。 \
		它们在处理烧伤方面效果极佳，但受限于小巧的体积，作为 \
		骨折包扎则相当一般。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "burndaid"
	inhand_icon_state = null
	novariants = TRUE
	max_amount = 6
	amount = 6
	splint_factor = 1.2
	burn_cleanliness_bonus = 0.1
	merge_type = /obj/item/stack/medical/wrap/gauze/sterilized
	custom_price = PAYCHECK_LOWER * 1.5

/obj/item/stack/medical/wrap/gauze/sterilized/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/space_cleaner/sterilizine, 5)
	healed_mob.reagents.expose(healed_mob, TOUCH, 1)

// Works great at sealing bleed wounds, but does little to actually heal them
/obj/item/stack/medical/suture/coagulant
	name = "凝血剂-F 药包"
	singular_name = "凝血剂-F 药包"
	desc = "一小包用于止血的人造凝血剂。它的效果不如某些 \
		其他的伤口凝血方法，但比普通缝合更有效。 \
		缺点呢？它能修复的实际损伤更少。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "clotter_slow"
	inhand_icon_state = null
	novariants = TRUE
	amount = 12
	max_amount = 12
	repeating = FALSE
	heal_brute = 0
	stop_bleeding = 2
	merge_type = /obj/item/stack/medical/suture/coagulant
	custom_price = PAYCHECK_LOWER * 1.5

#undef INSTANT_WOUND_HEAL_STAMINA_DAMAGE
#undef INSTANT_WOUND_HEAL_LIMB_DAMAGE
