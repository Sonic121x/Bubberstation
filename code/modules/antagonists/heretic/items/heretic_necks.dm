/obj/item/clothing/neck/heretic_focus
	name = "琥珀聚焦器"
	desc = "一块琥珀聚焦镜，能建立与彼世的联系。\
		这条项链似乎在抽动，但只在你用眼角余光看它时才会如此。"
	icon_state = "eldritch_necklace"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF
	/// Cooldown between attempts to recharge spells
	var/cooldown_period = 3 MINUTES
	COOLDOWN_DECLARE(spell_recharge_cd)

/obj/item/clothing/neck/heretic_focus/equipped(mob/living/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_NECK) || !IS_HERETIC(user))
		return
	START_PROCESSING(SSobj, src)
	COOLDOWN_START(src, spell_recharge_cd, cooldown_period)

/obj/item/clothing/neck/heretic_focus/dropped(mob/living/user)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/neck/heretic_focus/process(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, spell_recharge_cd))
		return

	var/mob/living/wearer = loc
	if(!istype(wearer) || !IS_HERETIC(wearer))
		return PROCESS_KILL

	var/datum/antagonist/heretic/our_heretic = GET_HERETIC(wearer)
	for(var/datum/heretic_knowledge/spell/spell in our_heretic?.get_researched_knowledge())
		spell.add_charges(ceil(spell.max_charges * spell.focus_recharge_amount))

	COOLDOWN_START(src, spell_recharge_cd, cooldown_period)

/obj/item/clothing/neck/heretic_focus/crimson_medallion
	name = "猩红勋章"
	desc = "一块血红色的聚焦镜，能建立与彼世的联系——以及更糟的东西。\
		它的眼睛不停抽动，向四面八方凝视。它似乎正在无声地尖叫……"
	icon_state = "crimson_medallion"
	cooldown_period = 1 MINUTES
	/// The aura healing component. Used to delete it when taken off.
	var/datum/component/component
	/// If active or not, used to add and remove its cult and heretic buffs.
	var/active = FALSE

/obj/item/clothing/neck/heretic_focus/crimson_medallion/equipped(mob/living/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_NECK))
		return

	var/team_color = COLOR_ADMIN_PINK
	if(IS_CULTIST(user))
		var/datum/action/innate/cult/blood_magic/magic_holder = locate() in user.actions
		team_color = COLOR_CULT_RED
		magic_holder.magic_enhanced = TRUE
	else if(IS_HERETIC_OR_MONSTER(user) && !active)
		for(var/datum/action/cooldown/spell/spell_action in user.actions)
			spell_action.cooldown_time *= 0.5
			active = TRUE
		team_color = COLOR_GREEN
	else
		team_color = pick(COLOR_CULT_RED, COLOR_GREEN)

	user.add_traits(list(TRAIT_MANSUS_TOUCHED, TRAIT_BLOOD_FOUNTAIN), REF(src))
	to_chat(user, span_alert("你的心脏开始以一种奇怪却令人安心的不规则节律跳动，血液也比以前稀薄了许多。你不太确定这是好事。"))
	component = user.AddComponent( \
		/datum/component/aura_healing, \
		range = 3, \
		brute_heal = 1, \
		burn_heal = 1, \
		blood_heal = 2, \
		suffocation_heal = 5, \
		simple_heal = 0.6, \
		requires_visibility = FALSE, \
		limit_to_trait = TRAIT_MANSUS_TOUCHED, \
		healing_color = team_color, \
	)

/obj/item/clothing/neck/heretic_focus/crimson_medallion/dropped(mob/living/user)
	. = ..()

	if(!istype(user))
		return

	if(HAS_TRAIT_FROM(user, TRAIT_MANSUS_TOUCHED, REF(src)))
		to_chat(user, span_notice("你的心脏与血液恢复了平常的节律与流动。"))

	if(IS_HERETIC_OR_MONSTER(user) && active)
		for(var/datum/action/cooldown/spell/spell_action in user.actions)
			spell_action.cooldown_time *= 2
			active = FALSE
	QDEL_NULL(component)
	user.remove_traits(list(TRAIT_MANSUS_TOUCHED, TRAIT_BLOOD_FOUNTAIN), REF(src))

	// If boosted enable is set, to prevent false dropped() calls from repeatedly nuking the max spells.
	var/datum/action/innate/cult/blood_magic/magic_holder = locate() in user.actions
	// Remove the last spell if over new limit, as we will reduce our max spell amount. Done beforehand as it causes a index out of bounds runtime otherwise.
	if(magic_holder?.magic_enhanced)
		QDEL_NULL(magic_holder.spells[ENHANCED_BLOODCHARGE])
	magic_holder?.magic_enhanced = FALSE


/obj/item/clothing/neck/heretic_focus/crimson_medallion/attack_self(mob/living/user, modifiers)
	. = ..()
	to_chat(user, span_danger("你开始紧紧攥住[src]……"))
	if(!do_after(user, 1.25 SECONDS, src))
		return
	to_chat(user, span_danger("[src] 爆裂成一片血肉与鲜血，浸透了你的手臂。你能感觉到血液正渗入皮肤。你立刻感觉好多了，但很快，随着血管开始发痒，这种感觉变得空洞。"))
	new /obj/effect/gibspawner/generic(get_turf(src))
	var/heal_amt = user.adjust_brute_loss(-50)
	user.adjust_fire_loss( -(50 - abs(heal_amt)) ) // no double dipping

	// I want it to poison the user but I also think it'd be neat if they got their juice as well. But that cancels most of the damage out. So I dunno.
	user.reagents?.add_reagent(/datum/reagent/fuel/unholywater, rand(6, 10))
	user.reagents?.add_reagent(/datum/reagent/eldritch, rand(6, 10))
	qdel(src)

/obj/item/clothing/neck/heretic_focus/crimson_medallion/examine(mob/user)
	. = ..()

	var/magic_dude
	if(IS_CULTIST(user))
		. += span_cult_bold("这件聚焦器能让你额外储存一个法术，并使强化所需时间减半，同时提供少量的再生效果。")
		magic_dude = TRUE
	if(IS_HERETIC_OR_MONSTER(user))
		magic_dude = TRUE

	if(magic_dude)
		. += span_red("你也可以攥紧它，快速恢复大量生命值，但需付出代价……")

/obj/item/clothing/neck/eldritch_amulet
	name = "温暖的诡异勋章"
	desc = "一枚奇怪的勋章。透过水晶表面窥视，周围的世界便消融而去。\
		你看见自己跳动的心脏，以及上千颗心脏的脉动。"
	icon = 'icons/obj/antags/eldritch.dmi'
	icon_state = "eye_medalion"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	/// A secondary clothing trait only applied to heretics.
	var/heretic_only_trait = TRAIT_THERMAL_VISION

/obj/item/clothing/neck/eldritch_amulet/equipped(mob/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_NECK))
		return
	if(!ishuman(user) || !IS_HERETIC_OR_MONSTER(user))
		return

	ADD_TRAIT(user, heretic_only_trait, "[CLOTHING_TRAIT]_[REF(src)]")
	user.update_sight()

/obj/item/clothing/neck/eldritch_amulet/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, heretic_only_trait, "[CLOTHING_TRAIT]_[REF(src)]")
	user.update_sight()

/obj/item/clothing/neck/eldritch_amulet/piercing
	name = "穿刺诡异勋章"
	desc = "一枚奇怪的勋章。透过水晶表面窥视，光线折射成令人恐惧的新色谱。你看见自己倒映在层层叠叠的镜中，扭曲成不可能的形状。"
	heretic_only_trait = TRAIT_XRAY_VISION

// Cosmetic-only version
/obj/item/clothing/neck/fake_heretic_amulet
	name = "宗教圣像"
	desc = "一枚奇怪的勋章，能让佩戴者看起来像是某个邪教的成员。"
	icon = 'icons/obj/antags/eldritch.dmi'
	icon_state = "eye_medalion"
	w_class = WEIGHT_CLASS_SMALL

// The amulet conversion tool used by moon heretics
/obj/item/clothing/neck/moon_amulet
	name = "月光护符"
	desc = "心灵、灵魂与月亮的一片碎片。凝视它会让你的头晕眩，听到笑声与喜悦的低语。"
	icon = 'icons/obj/antags/eldritch.dmi'
	icon_state = "moon_amulette"
	w_class = WEIGHT_CLASS_SMALL
	/// How much damage does this item do to the targets sanity?
	var/sanity_damage = 20
	var/list/possible_sounds = list(
		'sound/items/sitcom_laugh/SitcomLaugh1.ogg',
		'sound/items/sitcom_laugh/SitcomLaugh2.ogg',
		'sound/items/sitcom_laugh/SitcomLaugh3.ogg',
	)
	var/valid_weapon_type = /obj/item/melee/sickly_blade
	var/sanity_threshold = SANITY_LEVEL_INSANE

/obj/item/clothing/neck/moon_amulet/examine(mob/user)
	. = ..()
	if(IS_HERETIC(user))
		. += span_notice("佩戴此护符会使你的治疗速度提高 50%。")

/obj/item/clothing/neck/moon_amulet/equipped(mob/living/user, slot)
	. = ..()
	if(!IS_HERETIC(user) && (slot_flags & slot))
		channel_amulet(user)
		return // Equipping the amulet as a non-heretic will give you a fat mood debuff and nothing else
	if(!(slot_flags & slot))
		on_amulet_deactivate(user)
		return
	on_amulet_activate(user)

/// Modifies any blades you hold/pickup/drop when the amulet is enabled
/obj/item/clothing/neck/moon_amulet/proc/on_amulet_activate(mob/living/user)
	RegisterSignal(user, COMSIG_HERETIC_BLADE_ATTACK, PROC_REF(blade_channel))
	RegisterSignal(user, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_equip_item))
	RegisterSignal(user, COMSIG_MOB_DROPPED_ITEM, PROC_REF(on_dropped_item))
	// Just make sure we pacify blades potentially in our hands when we put on the amulet
	on_equip_item(user, user.get_active_held_item(), ITEM_SLOT_HANDS)
	on_equip_item(user, user.get_inactive_held_item(), ITEM_SLOT_HANDS)
	ADD_TRAIT(user, TRAIT_THERMAL_VISION, REF(src))
	// If the equipper is a moon heretic, we buff their passive
	var/datum/status_effect/heretic_passive/moon/moon_passive = user.has_status_effect(/datum/status_effect/heretic_passive/moon)
	moon_passive?.amulet_equipped = TRUE

/// Modifies any blades you hold/pickup/drop when the amulet is disabled
/obj/item/clothing/neck/moon_amulet/proc/on_amulet_deactivate(mob/living/user)
	// Make sure to restore the values of any blades we might be holding when our amulet is deactivated
	on_dropped_item(user, user.get_active_held_item())
	on_dropped_item(user, user.get_inactive_held_item())
	UnregisterSignal(user, list(COMSIG_HERETIC_BLADE_ATTACK, COMSIG_MOB_EQUIPPED_ITEM, COMSIG_MOB_DROPPED_ITEM))
	REMOVE_TRAIT(user, TRAIT_THERMAL_VISION, REF(src))
	var/datum/status_effect/heretic_passive/moon/moon_passive = user.has_status_effect(/datum/status_effect/heretic_passive/moon)
	moon_passive?.amulet_equipped = FALSE

/obj/item/clothing/neck/moon_amulet/dropped(mob/living/user)
	on_amulet_deactivate(user)
	return ..()

/obj/item/clothing/neck/moon_amulet/attack(mob/living/target, mob/living/user, list/modifiers, list/attack_modifiers)
	if(channel_amulet(user, target))
		return
	return ..()

/obj/item/clothing/neck/moon_amulet/proc/blade_channel(mob/living/attacker, mob/living/victim)
	SIGNAL_HANDLER
	channel_amulet(attacker, victim)

/// Makes whoever the target is a bit more insane. If they are insane enough, they will be zombified into a moon zombie
/obj/item/clothing/neck/moon_amulet/proc/channel_amulet(mob/user, atom/target)

	if(!isliving(user))
		return FALSE
	var/mob/living/living_user = user
	if(!IS_HERETIC_OR_MONSTER(living_user))
		living_user.balloon_alert(living_user, "你感觉到有某种存在正在注视你")
		living_user.add_mood_event("Moon Amulet Insanity", /datum/mood_event/amulet_insanity)
		living_user.mob_mood.adjust_sanity(-50)
		return FALSE
	if(!isliving(target))
		return FALSE
	var/mob/living/living_target = target

	if(!ishuman(target))
		living_target.adjust_fire_loss(30)
		return TRUE
	var/mob/living/carbon/human/human_target = target
	if(IS_HERETIC_OR_MONSTER(human_target))
		living_user.balloon_alert(living_user, "抵抗了效果！")
		return FALSE
	if(human_target.has_status_effect(/datum/status_effect/moon_slept) || human_target.has_status_effect(/datum/status_effect/moon_converted))
		//human_target.balloon_alert(living_user, "causing damage!") // BUBBER EDIT REMOVAL
		//human_target.adjust_organ_loss(ORGAN_SLOT_BRAIN, 25) // BUBBER EDIT REMOVAL
		return FALSE
	if(human_target.can_block_magic(MAGIC_RESISTANCE_MOON))
		return FALSE
	if(!human_target.mob_mood)
		return FALSE
	if(human_target.mob_mood.sanity_level < sanity_threshold)
		human_target.balloon_alert(living_user, "其心智过于坚韧！")
		human_target.add_mood_event("Moon Amulet Insanity", /datum/mood_event/amulet_insanity)
		human_target.mob_mood.adjust_sanity(-sanity_damage)
	else
		if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
			human_target.balloon_alert(living_user, "其心智几乎屈服，但有某种东西在保护它！")
			human_target.apply_status_effect(/datum/status_effect/moon_slept)
			return TRUE
		SEND_SIGNAL(user, COMSIG_MOB_APPLIED_MOONLIGHT_AMULET, target)
		human_target.balloon_alert(living_user, "其心智屈服，看见了真相！")
		human_target.apply_status_effect(/datum/status_effect/moon_converted)
		living_user.log_message("使 [human_target] 陷入疯狂。", LOG_GAME)
		human_target.log_message("被 [living_user] 逼疯", LOG_GAME)
	return TRUE

/// Modifies any blades that we equip while wearing the amulet
/obj/item/clothing/neck/moon_amulet/proc/on_equip_item(mob/user, obj/item/blade, slot)
	SIGNAL_HANDLER
	if(!istype(blade, valid_weapon_type))
		return // We only care about modifying blades
	if(slot & ITEM_SLOT_HANDS)
		blade.force = 0
		blade.wound_bonus = 0
		blade.exposed_wound_bonus = 0
		blade.armour_penetration = 200
		RegisterSignal(blade, COMSIG_SEND_ITEM_ATTACK_MESSAGE_OBJECT, PROC_REF(modify_attack_message))
		return
	blade.force = initial(blade.force)
	blade.wound_bonus = initial(blade.wound_bonus)
	blade.exposed_wound_bonus = initial(blade.exposed_wound_bonus)
	blade.armour_penetration = initial(blade.armour_penetration)
	UnregisterSignal(blade, COMSIG_SEND_ITEM_ATTACK_MESSAGE_OBJECT)

/obj/item/clothing/neck/moon_amulet/proc/modify_attack_message(obj/item/weapon, mob/living/victim, mob/living/attacker)
	SIGNAL_HANDLER

	var/list/attack_list = list(
		"你挥动[weapon]扫向[victim]，将其身影一分为二。",
		"你用[weapon]击打[victim]，从其体内溅出一片飞瀑。完美无瑕。",
		"当[weapon]深深咬入时，它为[victim]卸下了多余的思想。",
	)
	to_chat(attacker, span_danger(pick(attack_list)))

	var/list/victim_list = list(
		"你被[attacker]击中，但[weapon]撕去的不仅仅是身体的一部分。",
		"你看见一道光弧，[attacker]的[weapon]朝你扭转而来，世界短暂地呈现出四色。",
		"当[attacker]用[weapon]剖开你时，你失去了内心深处的某样东西。这痛苦比任何伤口都更难忍。",
	)
	to_chat(victim, span_userdanger(pick(victim_list)))
	playsound(attacker, pick(possible_sounds), 40, TRUE)
	return SIGNAL_MESSAGE_MODIFIED

/// Modifies any blades that we drop while wearing the amulet
/obj/item/clothing/neck/moon_amulet/proc/on_dropped_item(mob/user, obj/item/dropped_item)
	SIGNAL_HANDLER
	if(!istype(dropped_item, valid_weapon_type))
		return // We only care about modifying blades
	dropped_item.force = initial(dropped_item.force)
	dropped_item.wound_bonus = initial(dropped_item.wound_bonus)
	dropped_item.exposed_wound_bonus = initial(dropped_item.exposed_wound_bonus)
	dropped_item.armour_penetration = initial(dropped_item.armour_penetration)
	UnregisterSignal(dropped_item, COMSIG_SEND_ITEM_ATTACK_MESSAGE_OBJECT)
