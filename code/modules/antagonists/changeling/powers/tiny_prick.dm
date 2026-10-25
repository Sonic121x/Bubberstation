/datum/action/changeling/sting//parent path, not meant for users afaik
	name = "微刺"
	desc = "戳戳刺刺"
	category = "stings"
	button_icon_state = "sting_null" //This must be equal to the icon state for `/atom/movable/screen/ling/sting`

/datum/action/changeling/sting/Trigger(mob/clicker, trigger_flags)
	SHOULD_CALL_PARENT(FALSE) //We are snowflaked from parent
	var/mob/user = owner
	if(!user || !user.mind)
		return
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	if(!changeling)
		return
	if(!changeling.chosen_sting)
		set_sting(user)
	else
		unset_sting(user)
	return

/datum/action/changeling/sting/proc/set_sting(mob/user)
	to_chat(user, span_notice("我们准备好了毒刺。按住 Alt 点击，或用鼠标中键点击目标即可刺击。"))
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	changeling.chosen_sting = src

	var/atom/movable/screen/ling/sting/sting = user.hud_used?.screen_objects[HUD_CHANGELING_STING]
	if (sting)
		sting.icon_state = button_icon_state
		sting.SetInvisibility(0, id=type)

/datum/action/changeling/sting/proc/unset_sting(mob/user)
	to_chat(user, span_warning("我们收回了毒刺，暂时无法刺击任何人。"))
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	changeling.chosen_sting = null

	var/atom/movable/screen/ling/sting/sting = user.hud_used?.screen_objects[HUD_CHANGELING_STING]
	if (sting)
		sting.icon_state = null
		sting.RemoveInvisibility(type)

/mob/living/carbon/proc/unset_sting()
	if(mind)
		var/datum/antagonist/changeling/changeling = mind.has_antag_datum(/datum/antagonist/changeling)
		if(changeling?.chosen_sting)
			changeling.chosen_sting.unset_sting(src)

/datum/action/changeling/sting/can_sting(mob/user, mob/target)
	if(!..())
		return
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	if(!changeling.chosen_sting)
		to_chat(user, "我们还没有准备好毒刺！")
	if(!iscarbon(target))
		return
	if(!isturf(user.loc))
		return
	var/mob/living/carbon/human/to_check = target // SKYRAT EDIT START - STINGS DO NOT AFFECT ROBOTIC ENTITIES
	if(to_check.mob_biotypes & MOB_ROBOTIC)
		to_chat(user, "<span class='warning'>我们的毒刺对机械体没有效果</span>")
		return // SKYRAT EDIT END
	if(!length(get_path_to(user, target, max_distance = changeling.sting_range, simulated_only = FALSE)))
		return // no path within the sting's range is found. what a weird place to use the pathfinding system
	if(IS_CHANGELING(target))
		sting_feedback(user, target)
		changeling.chem_charges -= chemical_cost
	return 1

/datum/action/changeling/sting/sting_feedback(mob/user, mob/target)
	if(!target)
		return
	to_chat(user, span_notice("我们悄无声息地刺了[target.name]。"))
	if(IS_CHANGELING(target))
		to_chat(target, span_warning("你感到一阵轻微的刺痛。"))
	return 1

/datum/action/changeling/sting/transformation
	name = "变形毒刺"
	desc = "我们无声地刺入一个生物体，注入迫使其变形的逆转录病毒。"
	helptext = "受害者会像变形怪那样变形。\
		对复杂的人形生物而言，变形是暂时的，但在受害者死亡或处于停滞状态时，计时会暂停。\
		对更简单的人形生物，例如猴子，变形是永久的。\
		不会向他人发出警示。基因突变不会被转移。"
	button_icon_state = "transformation_sting"
	chemical_cost = 33 // Low enough that you can sting only two people in quick succession
	dna_cost = 2
	/// A reference to our active profile, which we grab DNA from
	VAR_FINAL/datum/changeling_profile/selected_dna
	/// Duration of the sting
	var/sting_duration = 8 MINUTES
	/// Set this to false via VV to allow golem, plasmaman, or monkey changelings to turn other people into golems, plasmamen, or monkeys
	var/verify_valid_species = TRUE

/datum/action/changeling/sting/transformation/Grant(mob/grant_to)
	. = ..()
	build_all_button_icons(UPDATE_BUTTON_NAME)

/datum/action/changeling/sting/transformation/update_button_name(atom/movable/screen/movable/action_button/button, force)
	. = ..()
	button.desc += " 对人类持续 [DisplayTimeText(sting_duration)]，但死亡或处于停滞状态时计时暂停。"
	button.desc += " 消耗 [chemical_cost] 点化学物质。"

/datum/action/changeling/sting/transformation/Destroy()
	selected_dna = null
	return ..()

/datum/action/changeling/sting/transformation/set_sting(mob/user)
	selected_dna = null
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	var/datum/changeling_profile/new_selected_dna = changeling.select_dna()
	if(QDELETED(src) || QDELETED(changeling) || QDELETED(user))
		return
	if(!new_selected_dna || changeling.chosen_sting || selected_dna) // selected other sting or other DNA while sleeping
		return
	if(verify_valid_species && (TRAIT_NO_DNA_COPY in new_selected_dna.dna.species.inherent_traits))
		user.balloon_alert(user, "DNA 不兼容！")
		return
	selected_dna = new_selected_dna
	return ..()

/datum/action/changeling/sting/transformation/can_sting(mob/user, mob/living/carbon/target)
	. = ..()
	if(!.)
		return
	// Similar checks here are ran to that of changeling can_absorb_dna -
	// Logic being that if their DNA is incompatible with us, it's also bad for transforming
	if(!iscarbon(target) \
		|| !target.has_dna() \
		|| HAS_TRAIT(target, TRAIT_HUSK) \
		|| HAS_TRAIT(target, TRAIT_BADDNA) \
		|| (HAS_TRAIT(target, TRAIT_NO_DNA_COPY) && !ismonkey(target))) // sure, go ahead, make a monk-clone
		user.balloon_alert(user, "DNA 不兼容！")
		return FALSE
	if(target.has_status_effect(/datum/status_effect/temporary_transformation/trans_sting))
		user.balloon_alert(user, "已经变形过了！")
		return FALSE
	return TRUE

/datum/action/changeling/sting/transformation/sting_action(mob/living/user, mob/living/target)
	var/final_duration = sting_duration
	var/final_message = span_notice("我们将[target]变形为[selected_dna.dna.real_name]。")
	if(ismonkey(target))
		final_duration = INFINITY
		final_message = span_warning("我们的基因在尖叫，我们将[target]的低等形态永久变形为[selected_dna.dna.real_name]！")

	if(target.apply_status_effect(/datum/status_effect/temporary_transformation/trans_sting, final_duration, selected_dna.dna))
		..()
		log_combat(user, target, "刺击了", "变形毒刺", "，新身份为“[selected_dna.dna.real_name]”")
		to_chat(user, final_message)
		return TRUE
	return FALSE

/datum/action/changeling/sting/false_armblade
	name = "假臂刃毒刺"
	desc = "我们无声地刺入一名人类，注入一种逆转录病毒，使其手臂暂时突变为臂刃。消耗 20 点化学物质。"
	helptext = "受害者会像变形怪那样长出一条臂刃，只不过这条臂刃又钝又没用。"
	button_icon_state = "false_armblade_sting"
	chemical_cost = 20
	dna_cost = 1

/obj/item/melee/arm_blade/false
	desc = "一团曾经是你手臂的怪异肉块。虽然乍看很危险，但你能看出它其实又钝又没用。"
	force = 5 //Basically as strong as a punch
	fake = TRUE

/datum/action/changeling/sting/false_armblade/can_sting(mob/user, mob/target)
	if(!..())
		return
	if(isliving(target))
		var/mob/living/L = target
		if((HAS_TRAIT(L, TRAIT_HUSK)) || !L.has_dna())
			user.balloon_alert(user, "DNA 不兼容！")
			return FALSE
	return TRUE

/datum/action/changeling/sting/false_armblade/sting_action(mob/user, mob/target)

	var/obj/item/held = target.get_active_held_item()
	if(held && !target.dropItemToGround(held))
		to_chat(user, span_warning("[held]粘在[target]手上，我们无法在它上面长出假臂刃！"))
		return

	..()
	log_combat(user, target, "刺击了", object = "假臂刃毒刺")
	if(ismonkey(target))
		to_chat(user, span_notice("我们的基因在尖叫，我们刺了[target.name]！"))

	var/obj/item/melee/arm_blade/false/blade = new(target,1)
	target.put_in_hands(blade)
	target.visible_message(span_warning("[target.name]的手臂上长出一把怪异的刀刃！"), span_userdanger("你的手臂扭曲变异，变成了一头可怕的怪物！"), span_hear("你听到有机物被撕裂扯开的声音！"))
	playsound(target, 'sound/effects/blob/blobattack.ogg', 30, TRUE)

	addtimer(CALLBACK(src, PROC_REF(remove_fake), target, blade), 1 MINUTES)
	return TRUE

/datum/action/changeling/sting/false_armblade/proc/remove_fake(mob/target, obj/item/melee/arm_blade/false/blade)
	playsound(target, 'sound/effects/blob/blobattack.ogg', 30, TRUE)
	target.visible_message(span_warning("伴随着令人作呕的咔嚓声，[target]把自己的[blade.name]变回了手臂！"),
	span_warning("[blade]变回了原样。"), span_italics("你听到有机物被撕裂扯开的声音！"))

	qdel(blade)
	target.update_held_items()

/datum/action/changeling/sting/extract_dna
	name = "提取 DNA 毒刺"
	desc = "我们悄无声息地刺击目标并提取其 DNA。消耗 25 点化学物质。"
	helptext = "可获得目标的 DNA，使我们能变形为其样貌。这会导致我们之后无法完整吸收其身体。"
	button_icon_state = "extract_dna_sting"
	chemical_cost = 25
	dna_cost = 0

/datum/action/changeling/sting/extract_dna/can_sting(mob/user, mob/target)
	if(..())
		var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
		return changeling.can_absorb_dna(target)

/datum/action/changeling/sting/extract_dna/sting_action(mob/user, mob/living/carbon/human/target)
	..()
	log_combat(user, target, "刺击了", "提取毒刺")
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	if(!changeling.has_profile_with_dna(target.dna))
		changeling.add_new_profile(target)
	return TRUE

/datum/action/changeling/sting/mute
	name = "沉默毒刺"
	desc = "我们无声地刺入一名人类，使其短时间内完全失声。消耗 20 点化学物质。"
	helptext = "不会向受害者提示其已被刺击，直到其想说话却发不出声。"
	button_icon_state = "mute_sting"
	chemical_cost = 20
	dna_cost = 2

/datum/action/changeling/sting/mute/sting_action(mob/user, mob/living/carbon/target)
	..()
	log_combat(user, target, "刺击了", "沉默毒刺")
	target.adjust_silence(1 MINUTES)
	return TRUE

/datum/action/changeling/sting/blind
	name = "致盲毒刺"
	desc = "我们使受害者暂时失明。消耗 25 点化学物质。"
	helptext = "这种毒刺会让目标短时间内完全失明，并在很长时间内视力模糊。若目标拥有机械眼或没有眼睛则无效。"
	button_icon_state = "blind_sting"
	chemical_cost = 25
	dna_cost = 1

/datum/action/changeling/sting/blind/sting_action(mob/user, mob/living/carbon/target)
	var/obj/item/organ/eyes/eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	if(!eyes)
		user.balloon_alert(user, "没有眼睛！")
		return FALSE

	if(IS_ROBOTIC_ORGAN(eyes))
		user.balloon_alert(user, "机械眼！")
		return FALSE

	..()
	log_combat(user, target, "刺击了", "致盲毒刺")
	to_chat(target, span_danger("你的眼睛剧烈灼痛！"))
	eyes.apply_organ_damage(eyes.maxHealth * 0.8)
	target.adjust_temp_blindness(40 SECONDS)
	target.set_eye_blur_if_lower(80 SECONDS)
	return TRUE

/datum/action/changeling/sting/lsd
	name = "致幻毒刺"
	desc = "我们让受害者陷入极度恐惧。消耗 10 点化学物质。"
	helptext = "我们进化出用强效致幻化学物质刺击目标的能力。\
			目标不会察觉自己被刺，效果将在 30 至 60 秒后发作。"
	button_icon_state = "hallucination_sting"
	chemical_cost = 10
	dna_cost = 1

/datum/action/changeling/sting/lsd/sting_action(mob/user, mob/living/carbon/target)
	..()
	log_combat(user, target, "刺击了", "致幻毒刺")
	addtimer(CALLBACK(src, PROC_REF(hallucination_time), target), rand(30 SECONDS, 60 SECONDS))
	return TRUE

/datum/action/changeling/sting/lsd/proc/hallucination_time(mob/living/carbon/target)
	if(QDELETED(src) || QDELETED(target))
		return
	target.adjust_hallucinations(180 SECONDS)

/datum/action/changeling/sting/cryo
	name = "低温毒刺"
	desc = "我们无声地刺入受害者，注入一种能将其从内部冻结的混合化学物质。消耗 15 点化学物质。"
	helptext = "不会向受害者发出警示，不过他们大概会意识到自己突然开始结冰。"
	button_icon_state = "cryogenic_sting"
	chemical_cost = 15
	dna_cost = 2

/datum/action/changeling/sting/cryo/sting_action(mob/user, mob/target)
	..()
	log_combat(user, target, "刺击了", "低温毒刺")
	if(target.reagents)
		target.reagents.add_reagent(/datum/reagent/consumable/frostoil, 30)
	return TRUE
