/*
	Blunt/Bone wounds
*/
// TODO: well, a lot really, but i'd kill to get overlays and a bonebreaking effect like Blitz: The League, similar to electric shock skeletons

/datum/wound_pregen_data/bone
	abstract = TRUE
	required_limb_biostate = BIO_BONE

	required_wounding_type = WOUND_BLUNT

	wound_series = WOUND_SERIES_BONE_BLUNT_BASIC

/datum/wound/blunt/bone
	name = "骨骼钝击伤"
	wound_flags = (ACCEPTS_GAUZE | SPLINT_OVERLAY) // SKYRAT EDIT: MEDICAL -- Makes bone wounds have a splint overlay

	default_scar_file = BONE_SCAR_FILE
	threshold_penalty = 5

	/// Have we been bone gel'd?
	var/gelled = FALSE
	/// Have we been taped?
	var/taped = FALSE
	/// Another method is causing our bones to heal
	var/healing = FALSE
	/// If we did the gel + surgical tape healing method for fractures, how many ticks does it take to heal by default
	var/regen_ticks_needed
	/// Our current counter for gel + surgical tape regeneration
	var/regen_ticks_current
	/// If we suffer severe head booboos, we can get brain traumas tied to them
	var/datum/brain_trauma/active_trauma
	/// What brain trauma group, if any, we can draw from for head wounds
	var/brain_trauma_group
	/// If we deal brain traumas, when is the next one due?
	var/next_trauma_cycle
	/// How long do we wait +/- 20% for the next trauma?
	var/trauma_cycle_cooldown
	/// If this is a chest wound and this is set, we have this chance to cough up blood when hit in the chest
	var/internal_bleeding_chance = 0

/*
	Overwriting of base procs
*/
/datum/wound/blunt/bone/wound_injury(datum/wound/old_wound = null, attack_direction = null)
	// hook into gaining/losing gauze so crit bone wounds can re-enable/disable depending if they're slung or not
	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group)
		processes = TRUE
		active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND)
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

	if(limb.held_index && victim.get_item_for_held_index(limb.held_index) && (disabling || prob(30 * severity)))
		var/obj/item/I = victim.get_item_for_held_index(limb.held_index)
		if(istype(I, /obj/item/offhand))
			I = victim.get_inactive_held_item()

		if(I && victim.dropItemToGround(I))
			victim.visible_message(span_danger("[victim]猛然松手，丢下了[I]！"), span_warning("<b>你的[chinese_body_zone_display(limb.plaintext_zone)]受到冲击，使你丢下了[I]！</b>"), vision_distance=COMBAT_MESSAGE_RANGE)

	update_inefficiencies()
	return ..()

/datum/wound/blunt/bone/set_victim(new_victim)

	if (victim)
		UnregisterSignal(victim, list(COMSIG_LIVING_UNARMED_ATTACK, COMSIG_MOB_FIRED_GUN))
	if (new_victim)
		RegisterSignal(new_victim, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(attack_with_hurt_hand))
		RegisterSignal(new_victim, COMSIG_MOB_FIRED_GUN, PROC_REF(firing_with_messed_up_hand))

	return ..()

/datum/wound/blunt/bone/remove_wound(ignore_limb, replaced, destroying)
	limp_slowdown = 0
	limp_chance = 0
	QDEL_NULL(active_trauma)
	return ..()

/datum/wound/blunt/bone/handle_process(seconds_per_tick)
	. = ..()

	if (!victim || HAS_TRAIT(victim, TRAIT_STASIS))
		return

	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group && world.time > next_trauma_cycle)
		if(active_trauma)
			QDEL_NULL(active_trauma)
		else
			active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND)
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

	var/is_bone_limb = ((limb.biological_state & BIO_BONE) && !(limb.biological_state & (BIO_FLESH|BIO_CHITIN)))
	if(!healing && (!gelled || (!taped && !is_bone_limb)))
		return

	regen_ticks_current++
	if(victim.body_position == LYING_DOWN)
		if(SPT_PROB(30, seconds_per_tick))
			regen_ticks_current += 1
		if(victim.IsSleeping() && SPT_PROB(30, seconds_per_tick))
			regen_ticks_current += 1

	if(!is_bone_limb && SPT_PROB(severity * 1.5, seconds_per_tick))
		victim.take_bodypart_damage(rand(1, severity * 2), wound_bonus=CANT_WOUND)
		victim.adjust_stamina_loss(rand(2, severity * 2.5))
		if(prob(33))
			to_chat(victim, span_danger("骨骼正在重新成形，你感到体内传来一阵剧痛！"))

	if(regen_ticks_current > regen_ticks_needed)
		if(!victim || !limb)
			qdel(src)
			return
		to_chat(victim, span_green("你的[chinese_body_zone_display(limb.plaintext_zone)]已从[undiagnosed_name || name]中恢复！"))
		remove_wound()

/// If we're a human who's punching something with a broken arm, we might hurt ourselves doing so
/datum/wound/blunt/bone/proc/attack_with_hurt_hand(mob/M, atom/target, proximity)
	SIGNAL_HANDLER

	if(victim.get_active_hand() != limb || !proximity || !victim.combat_mode || !ismob(target) || severity <= WOUND_SEVERITY_MODERATE)
		return NONE

	// With a severe or critical wound, you have a 15% or 30% chance to proc pain on hit
	if(prob((severity - 1) * 15))
		// And you have a 70% or 50% chance to actually land the blow, respectively
		if(HAS_TRAIT(victim, TRAIT_ANALGESIA) || prob(70 - 20 * (severity - 1)))
			if(!HAS_TRAIT(victim, TRAIT_ANALGESIA))
				to_chat(victim, span_danger("你击打[target]时，[chinese_body_zone_display(limb.plaintext_zone)]的骨折处传来剧痛！"))
			victim.apply_damage(rand(1, 5), BRUTE, limb, wound_bonus = CANT_WOUND, wound_clothing = FALSE)
		else
			victim.visible_message(span_danger("[victim]用骨折的[chinese_body_zone_display(limb.plaintext_zone)]无力地击向[target]，却痛得缩了回来！"), \
			span_userdanger("你[chinese_body_zone_display(limb.plaintext_zone)]的骨折处痛得难以忍受，没能击中[target]！"), vision_distance=COMBAT_MESSAGE_RANGE)
			INVOKE_ASYNC(victim, TYPE_PROC_REF(/mob, emote), "scream")
			victim.Stun(0.5 SECONDS)
			victim.apply_damage(rand(3, 7), BRUTE, limb, wound_bonus = CANT_WOUND, wound_clothing = FALSE)
			return COMPONENT_CANCEL_ATTACK_CHAIN

	return NONE

/// If we're a human who's firing a gun with a broken arm, we might hurt ourselves doing so
/datum/wound/blunt/bone/proc/firing_with_messed_up_hand(datum/source, obj/item/gun/gun, atom/firing_at, params, zone, bonus_spread_values)
	SIGNAL_HANDLER

	switch(limb.body_zone)
		if(BODY_ZONE_L_ARM)
			// Heavy guns use both hands so they will always get a penalty
			// (Yes, this means having two broken arms will make heavy weapons SOOO much worse)
			// Otherwise make sure THIS hand is firing THIS gun
			if(gun.weapon_weight <= WEAPON_MEDIUM && !IS_LEFT_INDEX(victim.get_held_index_of_item(gun)))
				return

		if(BODY_ZONE_R_ARM)
			// Ditto but for right arm
			if(gun.weapon_weight <= WEAPON_MEDIUM && !IS_RIGHT_INDEX(victim.get_held_index_of_item(gun)))
				return

		else
			// This is not arm wound, so we don't care
			return

	if(gun.calculate_recoil(victim, gun.recoil) > 1 && severity >= WOUND_SEVERITY_SEVERE && prob(25 * (severity - 1)))
		if(!HAS_TRAIT(victim, TRAIT_ANALGESIA))
			to_chat(victim, span_danger("[gun]的后坐力使你[chinese_body_zone_display(limb.plaintext_zone)]的骨折处爆发出剧痛！"))
		victim.apply_damage(rand(1, 3) * (severity - 1) * gun.weapon_weight, BRUTE, limb, wound_bonus = CANT_WOUND, wound_clothing = FALSE)

	if(!HAS_TRAIT(victim, TRAIT_ANALGESIA))
		bonus_spread_values[MAX_BONUS_SPREAD_INDEX] += (15 * severity * limb.get_splint_factor())

/datum/wound/blunt/bone/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(!victim || wounding_dmg < WOUND_MINIMUM_DAMAGE || !victim.can_bleed())
		return

	if(limb.body_zone == BODY_ZONE_CHEST && victim.get_blood_volume() && prob(internal_bleeding_chance + wounding_dmg))
		var/blood_bled = rand(1, wounding_dmg * (severity == WOUND_SEVERITY_CRITICAL ? 2 : 1.5)) // 12 brute toolbox can cause up to 18/24 bleeding with a severe/critical chest wound
		switch(blood_bled)
			if(1 to 6)
				victim.bleed(blood_bled, TRUE)
			if(7 to 13)
				victim.visible_message(
					span_smalldanger("胸口受到打击后，一缕鲜血从[victim]嘴角流下。"),
					span_danger("胸口的打击使你咳出了一点血。"),
					vision_distance = COMBAT_MESSAGE_RANGE,
				)
				victim.bleed(blood_bled, TRUE)
			if(14 to 19)
				victim.visible_message(
					span_smalldanger("胸口受到打击后，鲜血从[victim]口中涌出！"),
					span_danger("胸口的打击使你吐出了一口血！"),
					vision_distance = COMBAT_MESSAGE_RANGE,
				)
				victim.create_splatter(victim.dir)
				victim.bleed(blood_bled)
			if(20 to INFINITY)
				victim.visible_message(
					span_danger("胸口受到打击后，鲜血从[victim]口中喷出！"),
					span_bolddanger("胸口的打击使你呛咳着喷出一片血雾！"),
					vision_distance = COMBAT_MESSAGE_RANGE,
				)
				victim.bleed(blood_bled)
				victim.create_splatter(victim.dir)
				victim.add_splatter_floor(get_step(victim.loc, victim.dir))

/datum/wound/blunt/bone/modify_desc_before_span(desc)
	. = ..()

	var/obj/item/stack/medical/wrap/current_gauze = LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE)
	if (!current_gauze)
		if(taped)
			. += "，[span_notice("似乎正在外科胶带下重新成形！")]"
		else if(gelled)
			. += "，[span_notice("骨头上冒着气泡的蓝色骨胶正四处飞溅！")]"

/datum/wound/blunt/get_limb_examine_description()
	return span_warning("这条肢体中的骨头似乎已严重断裂。")

/*
	New common procs for /datum/wound/blunt/bone/
*/

/datum/wound/blunt/bone/get_scar_file(obj/item/bodypart/scarred_limb, add_to_scars)
	if (scarred_limb.biological_state & BIO_BONE && (!(scarred_limb.biological_state & BIO_FLESH))) // only bone
		return BONE_SCAR_FILE
	else if (scarred_limb.biological_state & BIO_FLESH && (!(scarred_limb.biological_state & BIO_BONE)))
		return FLESH_SCAR_FILE

	return ..()

/// Joint Dislocation (Moderate Blunt)
/datum/wound/blunt/bone/moderate
	name = "关节脱位"
	undiagnosed_name = "脱臼"
	a_or_from = "a"
	desc = "患者的肢体脱离关节窝，造成疼痛和运动功能下降。"
	treat_text = "对患肢使用正骨器。\
		也可通过强力抓取患者，再以帮助意图紧抱患肢来手动复位。"
	treat_text_short = "使用正骨器，或手动将肢体复位。"
	examine_desc = "以别扭的姿态错位了"
	occur_text = "猛烈扭曲，发生了脱位"
	severity = WOUND_SEVERITY_MODERATE
	interaction_efficiency_penalty = 1.3
	limp_slowdown = 3
	limp_chance = 50
	series_threshold_penalty = 15
	treatable_tools = list(TOOL_BONESET)
	status_effect_type = /datum/status_effect/wound/blunt/bone/moderate
	scar_keyword = "dislocate"

	simple_desc = "患者的骨骼脱位，造成跛行或灵活度下降。"
	simple_treat_text = "在使用正骨器治疗前，<b>包扎</b>伤处可减轻影响。最常见的治疗方法是强力抓取患者，再以帮助意图将肢体扳回原位，不过这一过程也可能被用于伤害患者。"
	homemade_treat_text = "除包扎和手动复位外，还可用车床制造<b>正骨器</b>，忍受剧痛为自己治疗。万不得已时，用<b>防火门挤压</b>患者，有时也能使脱臼的肢体复位。"

/datum/wound_pregen_data/bone/dislocate
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/bone/moderate

	required_limb_biostate = BIO_JOINTED

	threshold_minimum = 35

/datum/wound/blunt/bone/moderate/Destroy()
	if(victim)
		UnregisterSignal(victim, COMSIG_LIVING_DOORCRUSHED)
	return ..()

/datum/wound/blunt/bone/moderate/set_victim(new_victim)

	if (victim)
		UnregisterSignal(victim, COMSIG_LIVING_DOORCRUSHED)
	if (new_victim)
		RegisterSignal(new_victim, COMSIG_LIVING_DOORCRUSHED, PROC_REF(door_crush))

	return ..()

/datum/wound/blunt/bone/moderate/get_self_check_description(self_aware)
	return span_warning("感觉脱臼了！")

/// Getting smushed in an airlock/firelock is a last-ditch attempt to try relocating your limb
/datum/wound/blunt/bone/moderate/proc/door_crush()
	SIGNAL_HANDLER
	if(prob(40))
		victim.visible_message(span_danger("[victim]脱臼的[chinese_body_zone_display(limb.plaintext_zone)]咔嗒一声回到了原位！"), span_userdanger("你脱臼的[chinese_body_zone_display(limb.plaintext_zone)]咔嗒一声回到了原位！好痛！"))
		remove_wound()
		return DOORCRUSH_NO_WOUND
	return NONE

/datum/wound/blunt/bone/moderate/try_handling(mob/living/user)
	if(user.usable_hands <= 0 || user.pulling != victim)
		return FALSE
	if(!isnull(user.hud_used?.screen_objects[HUD_MOB_ZONE_SELECTOR]) && user.zone_selected != limb.body_zone)
		return FALSE

	if(user.grab_state == GRAB_PASSIVE)
		to_chat(user, span_warning("必须先强力抓住[victim]，才能处理其[undiagnosed_name || name]！"))
		return TRUE

	if(user.grab_state >= GRAB_AGGRESSIVE)
		user.visible_message(span_danger("[user]开始用力扭动[victim]脱臼的[chinese_body_zone_display(limb.plaintext_zone)]！"), span_notice("你开始用力扭动[victim]脱臼的[chinese_body_zone_display(limb.plaintext_zone)]……"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user]开始用力扭动你脱臼的[chinese_body_zone_display(limb.plaintext_zone)]！"))
		if(!user.combat_mode)
			chiropractice(user)
		else
			malpractice(user)
		return TRUE

/// If someone is snapping our dislocated joint back into place by hand with an aggro grab and help intent
/datum/wound/blunt/bone/moderate/proc/chiropractice(mob/living/carbon/human/user)
	var/time = base_treat_time

	if(!do_after(user, time, target=victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	if(prob(65))
		user.visible_message(span_danger("[user]将[victim]脱臼的[chinese_body_zone_display(limb.plaintext_zone)]猛地扳回了原位！"), span_notice("你将[victim]脱臼的[chinese_body_zone_display(limb.plaintext_zone)]猛地扳回了原位！"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user]将你脱臼的[chinese_body_zone_display(limb.plaintext_zone)]猛地扳回了原位！"))
		victim.emote("scream")
		victim.apply_damage(20, BRUTE, limb, wound_bonus = CANT_WOUND)
		qdel(src)
	else
		user.visible_message(span_danger("[user]用力扭动[victim]脱臼的[chinese_body_zone_display(limb.plaintext_zone)]，使其痛苦不堪！"), span_danger("你用力扭动[victim]脱臼的[chinese_body_zone_display(limb.plaintext_zone)]，使其痛苦不堪！"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user]用力扭动你脱臼的[chinese_body_zone_display(limb.plaintext_zone)]，痛得你难以忍受！"))
		victim.apply_damage(10, BRUTE, limb, wound_bonus = CANT_WOUND)
		chiropractice(user)

/// If someone is snapping our dislocated joint into a fracture by hand with an aggro grab and harm or disarm intent
/datum/wound/blunt/bone/moderate/proc/malpractice(mob/living/carbon/human/user)
	var/time = base_treat_time

	if(!do_after(user, time, target=victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	if(prob(65))
		user.visible_message(span_danger("[user]折断了[victim]脱臼的[chinese_body_zone_display(limb.plaintext_zone)]，发出令人作呕的断裂声！"), span_danger("你折断了[victim]脱臼的[chinese_body_zone_display(limb.plaintext_zone)]，发出令人作呕的断裂声！"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user]折断了你脱臼的[chinese_body_zone_display(limb.plaintext_zone)]，发出令人作呕的断裂声！"))
		victim.emote("scream")
		victim.apply_damage(25, BRUTE, limb, wound_bonus = 30)
	else
		user.visible_message(span_danger("[user]用力扭动着[victim]脱臼的[chinese_body_zone_display(limb.plaintext_zone)]，使其痛苦不堪！"), span_danger("你用力扭动[victim]脱臼的[chinese_body_zone_display(limb.plaintext_zone)]，使其痛苦不堪！"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user]用力扭动你脱臼的[chinese_body_zone_display(limb.plaintext_zone)]，痛得你难以忍受！"))
		victim.apply_damage(10, BRUTE, limb, wound_bonus = CANT_WOUND)
		malpractice(user)

/datum/wound/blunt/bone/moderate/treat(obj/item/tool, mob/user)
	var/scanned = HAS_TRAIT(src, TRAIT_WOUND_SCANNED)
	var/self_penalty_mult = user == victim ? 1.5 : 1
	var/scanned_mult = scanned ? 0.5 : 1
	var/treatment_delay = base_treat_time * self_penalty_mult * scanned_mult

	if(victim == user)
		victim.visible_message(span_danger("[user]开始用[tool][scanned ? "熟练地" : ""]将自己的[chinese_body_zone_display(limb.plaintext_zone)]复位。"), span_warning("你开始[scanned ? "按照全息影像的指引，" : ""]用[tool]将自己的[chinese_body_zone_display(limb.plaintext_zone)]复位……"))
	else
		user.visible_message(span_danger("[user]开始用[tool][scanned ? "熟练地" : ""]将[victim]的[chinese_body_zone_display(limb.plaintext_zone)]复位。"), span_notice("你开始[scanned ? "按照全息影像的指引，" : ""]用[tool]将[victim]的[chinese_body_zone_display(limb.plaintext_zone)]复位……"))

	if(!do_after(user, treatment_delay, target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return

	if(victim == user)
		victim.apply_damage(15, BRUTE, limb, wound_bonus = CANT_WOUND)
		victim.visible_message(span_danger("[user]将自己的[chinese_body_zone_display(limb.plaintext_zone)]复位了！"), span_userdanger("你将自己的[chinese_body_zone_display(limb.plaintext_zone)]复位了！"))
	else
		victim.apply_damage(10, BRUTE, limb, wound_bonus = CANT_WOUND)
		user.visible_message(span_danger("[user]将[victim]的[chinese_body_zone_display(limb.plaintext_zone)]复位了！"), span_nicegreen("你将[victim]的[chinese_body_zone_display(limb.plaintext_zone)]复位了！"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user]将你的[chinese_body_zone_display(limb.plaintext_zone)]复位了！"))

	victim.emote("scream")
	qdel(src)

/*
	Severe (Hairline Fracture)
*/

/datum/wound/blunt/bone/severe
	name = "骨裂"
	desc = "患者的骨骼出现裂纹，造成严重疼痛和肢体功能下降。"
	treat_text = "进行手术修复。紧急情况下可在患处涂抹骨胶，使其逐渐恢复。\
		也可使用夹板或医用纱布吊带，防止骨折恶化。"
	treat_text_short = "手术修复，或涂抹骨胶。也可使用夹板或纱布吊带。"
	examine_desc = "肿胀得骇人，参差的凸起暗示着骨骼碎裂"
	occur_text = "飞溅出骨屑，并出现了骇人的淤伤"

	severity = WOUND_SEVERITY_SEVERE
	interaction_efficiency_penalty = 2
	limp_slowdown = 6
	limp_chance = 60
	series_threshold_penalty = 30
	treatable_by = list(/obj/item/stack/medical/wrap/sticky_tape/surgical, /obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/blunt/bone/severe
	scar_keyword = "bluntsevere"
	brain_trauma_group = BRAIN_TRAUMA_MILD
	trauma_cycle_cooldown = 1.5 MINUTES
	internal_bleeding_chance = 40
	wound_flags = (ACCEPTS_GAUZE | MANGLES_INTERIOR | SPLINT_OVERLAY) // SKYRAT EDIT - MEDICAL (SPLINT_OVERLAY)
	regen_ticks_needed = 120 // ticks every 2 seconds, 240 seconds, so roughly 4 minutes default

	simple_desc = "患者的骨骼中部出现裂纹，肢体功能严重下降。"
	simple_treat_text = "在使用骨胶和外科胶带进行<b>手术治疗</b>前，<b>包扎</b>伤处可减轻影响。"
	homemade_treat_text = "可直接对伤处使用<b>骨胶和外科胶带</b>，但大多数人很难自行完成，除非先使用一种或多种<b>止痛药</b>（吗啡和矿工药膏已知有效）。"


/datum/wound_pregen_data/bone/hairline
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/bone/severe

	threshold_minimum = 60

/// Compound Fracture (Critical Blunt)
/datum/wound/blunt/bone/critical
	name = "开放性骨折"
	undiagnosed_name = null // you can tell it's a compound fracture at a glance because of a skin breakage
	a_or_from = "a"
	desc = "患者的骨骼多处断裂，\
		伴有皮肤破裂，造成剧烈疼痛，肢体几乎无法使用。"
	treat_text = "立即用纱布或夹板固定患肢，并进行手术修复。\
		紧急情况下可对患处使用骨胶和外科胶带，使其经过较长时间后恢复。"
	treat_text_short = "手术修复，或使用骨胶和外科胶带。还应使用夹板或纱布吊带。"
	examine_desc = "血肉模糊、支离破碎，碎骨暴露在空气中"
	occur_text = "裂开了，断骨暴露在空气中"

	severity = WOUND_SEVERITY_CRITICAL
	interaction_efficiency_penalty = 2.5
	limp_slowdown = 7
	limp_chance = 70
	sound_effect = 'sound/effects/wounds/crack2.ogg'
	threshold_penalty = 15
	disabling = TRUE
	treatable_by = list(/obj/item/stack/medical/wrap/sticky_tape/surgical, /obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/blunt/bone/critical
	scar_keyword = "bluntcritical"
	brain_trauma_group = BRAIN_TRAUMA_SEVERE
	trauma_cycle_cooldown = 2.5 MINUTES
	internal_bleeding_chance = 60
	wound_flags = (ACCEPTS_GAUZE | MANGLES_INTERIOR | SPLINT_OVERLAY) // SKYRAT EDIT - MEDICAL (SPLINT_OVERLAY)
	regen_ticks_needed = 240 // ticks every 2 seconds, 480 seconds, so roughly 8 minutes default
	surgery_states = SURGERY_SKIN_CUT | SURGERY_BONE_SAWED // Bad enough to count as a busted skull/ribcage

	simple_desc = "患者的骨骼几乎完全粉碎，肢体彻底无法活动。"
	simple_treat_text = "在使用骨胶和外科胶带进行<b>手术治疗</b>前，<b>包扎</b>伤处可略微减轻影响。"
	homemade_treat_text = "虽然极其困难且见效缓慢，仍可直接对伤处使用<b>骨胶和外科胶带</b>。大多数人几乎无法自行完成，除非先使用一种或多种<b>止痛药</b>（吗啡和矿工药膏已知有效）。"

	/// Tracks if a surgeon has reset the bone (part one of the surgical treatment process)
	VAR_FINAL/reset = FALSE

/datum/wound_pregen_data/bone/compound
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/bone/critical

	threshold_minimum = 115

// doesn't make much sense for "a" bone to stick out of your head
/datum/wound/blunt/bone/critical/apply_wound(obj/item/bodypart/L, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, attack_direction = null, wound_source = "Unknown", replacing = FALSE)
	if(L.body_zone == BODY_ZONE_HEAD)
		occur_text = "裂开了，血肉间露出破裂的颅骨"
		examine_desc = "有一处骇人的凹陷，颅骨碎片从中刺出"
	. = ..()

/// if someone is using bone gel on our wound
/datum/wound/blunt/bone/proc/gel(obj/item/stack/medical/bone_gel/I, mob/user)
	// skellies get treated nicer with bone gel since their "reattach dismembered limbs by hand" ability sucks when it's still critically wounded
	if((limb.biological_state & BIO_BONE) && !(limb.biological_state & (BIO_FLESH|BIO_CHITIN)))
		return skelly_gel(I, user)

	if(gelled)
		to_chat(user, span_warning("[user == victim ? "你" : "[victim]"]的[chinese_body_zone_display(limb.plaintext_zone)]已经涂过骨胶了！"))
		return TRUE

	user.visible_message(span_danger("[user]开始匆忙将[I]涂在[victim]的[chinese_body_zone_display(limb.plaintext_zone)]上……"), span_warning("你无视警告标签，开始匆忙将[I]涂在[user == victim ? "自己" : "[victim]"]的[chinese_body_zone_display(limb.plaintext_zone)]上……"))

	if(!do_after(user, base_treat_time * 1.5 * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	I.use(1)
	victim.emote("scream")
	if(user != victim)
		user.visible_message(span_notice("[user]将[I]涂在[victim]的[chinese_body_zone_display(limb.plaintext_zone)]上，发出嘶嘶的气泡声！"), span_notice("你将[I]涂在了[victim]的[chinese_body_zone_display(limb.plaintext_zone)]上！"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user]将[I]涂在了你的[chinese_body_zone_display(limb.plaintext_zone)]上。骨骼开始溶解、重新成形，剧痛随之爆发！"))
	else
		if(!HAS_TRAIT(victim, TRAIT_ANALGESIA))
			if(prob(25 + (20 * (severity - 2)) - min(victim.get_drunk_amount(), 10))) // 25%/45% chance to fail self-applying with severe and critical wounds, modded by drunkenness
				victim.visible_message(span_danger("[victim]还没将[I]涂完在自己的[chinese_body_zone_display(limb.plaintext_zone)]上，就痛得昏了过去！"), span_notice("你还没将[I]涂完在自己的[chinese_body_zone_display(limb.plaintext_zone)]上，就痛得昏了过去！"))
				victim.AdjustUnconscious(5 SECONDS)
				return TRUE
		victim.visible_message(span_notice("[victim]将[I]涂在自己的[chinese_body_zone_display(limb.plaintext_zone)]上，痛得龇牙咧嘴！"), span_notice("你将[I]涂在了自己的[chinese_body_zone_display(limb.plaintext_zone)]上，骨骼顿时剧痛无比！"))

	victim.apply_damage(25, BRUTE, limb, wound_bonus = CANT_WOUND)
	victim.apply_damage(100, STAMINA)
	gelled = TRUE
	return TRUE

/// skellies are less averse to bone gel, since they're literally all bone
/datum/wound/blunt/bone/proc/skelly_gel(obj/item/stack/medical/bone_gel/I, mob/user)
	if(gelled)
		to_chat(user, span_warning("[user == victim ? "你" : "[victim]"]的[chinese_body_zone_display(limb.plaintext_zone)]已经涂过骨胶了！"))
		return

	user.visible_message(span_danger("[user]开始将[I]涂在[victim]的[chinese_body_zone_display(limb.plaintext_zone)]上……"), span_warning("你开始将[I]涂在[user == victim ? "自己" : "[victim]"]的[chinese_body_zone_display(limb.plaintext_zone)]上……"))

	if(!do_after(user, base_treat_time * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return

	I.use(1)
	if(user != victim)
		user.visible_message(span_notice("[user]将[I]涂在[victim]的[chinese_body_zone_display(limb.plaintext_zone)]上，发出嘶嘶的气泡声！"), span_notice("你将[I]涂在了[victim]的[chinese_body_zone_display(limb.plaintext_zone)]上！"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user]将[I]涂在了你的[chinese_body_zone_display(limb.plaintext_zone)]上。骨骼开始重新成形，你感到一种奇怪的、冒泡似的痒感！"))
	else
		victim.visible_message(span_notice("[victim]将[I]涂在自己的[chinese_body_zone_display(limb.plaintext_zone)]上，发出奇怪的气泡声！"), span_notice("你将[I]涂在了自己的[chinese_body_zone_display(limb.plaintext_zone)]上。骨骼开始重新成形，你感到一种奇怪的、冒泡似的痒感！"))

	gelled = TRUE
	processes = TRUE
	return TRUE

/// if someone is using surgical tape on our wound
/datum/wound/blunt/bone/proc/tape(obj/item/stack/medical/wrap/sticky_tape/surgical/I, mob/user)
	if(!gelled)
		to_chat(user, span_warning("必须先在[user == victim ? "你" : "[victim]"]的[chinese_body_zone_display(limb.plaintext_zone)]上涂抹骨胶，才能进行这项紧急操作！"))
		return TRUE
	if(taped)
		to_chat(user, span_warning("[user == victim ? "你" : "[victim]"]的[chinese_body_zone_display(limb.plaintext_zone)]已经缠好[I.name]，正在重新成形！"))
		return TRUE

	user.visible_message(span_danger("[user]开始将[I]缠在[victim]的[chinese_body_zone_display(limb.plaintext_zone)]上……"), span_warning("你开始将[I]缠在[user == victim ? "自己" : "[victim]"]的[chinese_body_zone_display(limb.plaintext_zone)]上……"))

	if(!do_after(user, base_treat_time * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	if(victim == user)
		regen_ticks_needed *= 1.5

	I.use(1)
	if(user != victim)
		user.visible_message(span_notice("[user]将[I]缠在[victim]的[chinese_body_zone_display(limb.plaintext_zone)]上，发出嘶嘶的气泡声！"), span_notice("你将[I]缠在了[victim]的[chinese_body_zone_display(limb.plaintext_zone)]上！"), ignored_mobs=victim)
		to_chat(victim, span_green("[user]将[I]缠在了你的[chinese_body_zone_display(limb.plaintext_zone)]上，你立刻感到骨骼开始重新成形！"))
	else
		victim.visible_message(span_notice("[victim]将[I]缠在了自己的[chinese_body_zone_display(limb.plaintext_zone)]上！"), span_green("你将[I]缠在了自己的[chinese_body_zone_display(limb.plaintext_zone)]上，立刻感到骨骼开始重新成形！"))

	taped = TRUE
	processes = TRUE
	return TRUE

/datum/wound/blunt/bone/item_can_treat(obj/item/potential_treater, mob/user)
	// assume that - if working on a ready-to-operate limb - the surgery wants to do the real surgery instead of bone regeneration
	return ..() && !HAS_TRAIT(limb, TRAIT_READY_TO_OPERATE)

/datum/wound/blunt/bone/treat(obj/item/tool, mob/user)
	if(istype(tool, /obj/item/stack/medical/bone_gel))
		gel(tool, user)
	if(istype(tool, /obj/item/stack/medical/wrap/sticky_tape/surgical))
		tape(tool, user)

/datum/wound/blunt/bone/get_scanner_description(mob/user)
	. = ..()

	. += "<div class='ml-3'>"

	if(severity > WOUND_SEVERITY_MODERATE)
		if((limb.biological_state & BIO_BONE) && !(limb.biological_state & (BIO_FLESH|BIO_CHITIN)))
			if(!gelled)
				. += "建议治疗：直接对患肢涂抹骨胶。纯骨骼生物对骨胶的耐受性似乎远高于血肉生物，也不需要外科胶带。\n"
			else
				. += "[span_notice("注意：骨骼正在再生，已恢复[round(regen_ticks_current*100/regen_ticks_needed)]%。")]\n"
		else
			if(!gelled)
				. += "替代治疗：直接在患肢上涂抹骨胶，再缠上外科胶带以开始骨骼再生。此法既痛苦又缓慢，仅建议在危急情况下采用。\n"
			else if(!taped)
				. += "[span_notice("继续替代治疗：直接在患肢上缠上外科胶带，开始骨骼再生。注意，此法既痛苦又缓慢，但睡眠或躺下可加快恢复。")]\n"
			else
				. += "[span_notice("注意：骨骼正在再生，已恢复[round(regen_ticks_current*100/regen_ticks_needed)]%。")]\n"

	if(limb.body_zone == BODY_ZONE_HEAD)
		. += "检测到颅骨创伤：骨骼修复前，患者会随机发作[severity == WOUND_SEVERITY_SEVERE ? "轻度" : "重度"]脑创伤。"
	else if(limb.body_zone == BODY_ZONE_CHEST && CAN_HAVE_BLOOD(victim))
		. += "检测到胸廓创伤：骨骼修复前，胸部再次受伤很可能加重内出血。"
	. += "</div>"
