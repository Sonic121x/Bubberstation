/obj/item/organ/heart
	name = "心脏"
	desc = "我真为那个丢掉这颗心脏的无情混蛋感到难过。"
	icon_state = "heart-on"
	base_icon_state = "heart"

	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_HEART
	item_flags = NO_BLOOD_ON_ITEM
	healing_factor = STANDARD_ORGAN_HEALING
	decay_factor = 2.5 * STANDARD_ORGAN_DECAY //designed to fail around 6 minutes after death

	low_threshold_passed = span_info("胸口内泛起一阵刺痛，随后又渐渐消退……")
	high_threshold_passed = span_warning("你胸口里有什么东西在疼，而且疼痛没有减轻。你注意到自己呼吸比之前快得多。")
	now_fixed = span_info("你的心脏又开始跳动了。")
	high_threshold_cleared = span_info("胸口的疼痛已经平息，你的呼吸也变得舒缓了些。")

	attack_verb_continuous = list("拍打", "捶打")
	attack_verb_simple = list("拍", "捶")

	// Love is stored in the heart.
	food_reagents = list(/datum/reagent/consumable/nutriment/organ_tissue = 5, /datum/reagent/love = 2.5)

	cell_line = CELL_LINE_ORGAN_HEART
	cells_minimum = 1
	cells_maximum = 2
	visual = FALSE

	// Heart attack code is in code/modules/mob/living/carbon/human/life.dm

	/// Whether the heart is currently beating.
	/// Do not set this directly. Use Restart() and Stop() instead.
	VAR_PRIVATE/beating = TRUE

	/// is this mob having a heatbeat sound played? if so, which?
	var/beat = BEAT_NONE
	/// whether the heart's been operated on to fix some of its damages
	var/operated = FALSE
	/// The message that is displayed when listening to a heart via a stethoscope
	var/beat_noise = "有节奏的砰砰声"
	/// The rate at which blood is pumped by the heart is multiplied by this (value of 0 disables blood regeneration entirely)
	var/blood_regeneration_multiplier = 1

/obj/item/organ/heart/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[beating ? "on" : "off"]"

/obj/item/organ/heart/Remove(mob/living/carbon/heartless, special, movement_flags)
	. = ..()
	if(!special && !QDELETED(src))
		addtimer(CALLBACK(src, PROC_REF(stop_if_unowned)), 12 SECONDS, TIMER_DELETE_ME)
	beat = BEAT_NONE
	owner?.stop_sound_channel(CHANNEL_HEARTBEAT)

/obj/item/organ/heart/proc/stop_if_unowned()
	if(IS_ROBOTIC_ORGAN(src))
		return
	if(isnull(owner))
		Stop()

/obj/item/organ/heart/attack_self(mob/user)
	. = ..()
	if(.)
		return

	if(!beating)
		user.visible_message(
			span_notice("[user] 挤压 [src]，让它重新跳动起来！"),
			span_notice("你挤压 [src]，让它重新跳动起来！"),
		)
		Restart()
		addtimer(CALLBACK(src, PROC_REF(stop_if_unowned)), 8 SECONDS)
		return TRUE

/obj/item/organ/heart/proc/Stop()
	if(!beating)
		return FALSE

	beating = FALSE
	update_appearance()
	beat = BEAT_NONE
	owner?.stop_sound_channel(CHANNEL_HEARTBEAT)
	return TRUE

/obj/item/organ/heart/proc/Restart()
	if(beating)
		return FALSE

	beating = TRUE
	update_appearance()
	return TRUE

/obj/item/organ/heart/OnEatFrom(eater, feeder)
	. = ..()
	Stop()

/// Returns how effectively this heart regenerates the owner's blood based on organ health
/obj/item/organ/heart/proc/get_blood_regeneration_multiplier()
	if(!is_beating() || (organ_flags & (ORGAN_FAILING|ORGAN_EMP)))
		return 0

	var/health_percent = clamp((maxHealth - damage) / maxHealth, 0, 1)
	return blood_regeneration_multiplier * health_percent

/// Checks if the heart is beating.
/// Can be overridden to add more conditions for more complex hearts.
/obj/item/organ/heart/proc/is_beating()
	return beating

/obj/item/organ/heart/get_status_text(scanpower, add_tooltips, colored)
	if(owner.has_status_effect(/datum/status_effect/heart_attack))
		return conditional_tooltip("<font color='#cc3333'>Myocardial Infarction</font>", "Apply defibrillation immediately. Similar electric shocks may work in emergencies.", add_tooltips)
	if((!beating && !(organ_flags & ORGAN_FAILING) && owner.needs_heart() && owner.stat != DEAD))
		return conditional_tooltip("<font color='#cc3333'>Cardiac Arrest</font>", "Repair tissue damage and apply defibrillation immediately.", add_tooltips)
	return ..()

/obj/item/organ/heart/show_on_condensed_scans()
	// Always show if the guy needs a heart (so its status can be monitored)
	return ..() || owner.needs_heart()

/obj/item/organ/heart/on_life(seconds_per_tick)
	. = ..()

	// If the owner doesn't need a heart, we don't need to do anything with it.
	if(!owner.needs_heart())
		return

	// Handle "sudden" heart attack
	if(!beating || (organ_flags & ORGAN_FAILING))
		if(owner.can_heartattack() && Stop())
			if(!IS_UNCONSCIOUS_OR_CRIT(owner))
				owner.visible_message(span_danger("[owner] 捂住 [owner.p_their()] 胸口，仿佛 [owner.p_their()] 心脏正在停止跳动！"))
			to_chat(owner, span_userdanger("你感到胸口剧痛，仿佛心脏已经停止了跳动！"))
		return

	// Beyond deals with sound effects, so nothing needs to be done if no client
	if(isnull(owner.client))
		return

	if(owner.stat == SOFT_CRIT)
		if(beat != BEAT_SLOW)
			beat = BEAT_SLOW
			to_chat(owner, span_notice("你感到心跳慢了下来……"))
			SEND_SOUND(owner, sound('sound/effects/health/slowbeat.ogg', repeat = TRUE, channel = CHANNEL_HEARTBEAT, volume = 40))

	else if(owner.stat == HARD_CRIT)
		if(beat != BEAT_FAST && owner.has_status_effect(/datum/status_effect/jitter))
			SEND_SOUND(owner, sound('sound/effects/health/fastbeat.ogg', repeat = TRUE, channel = CHANNEL_HEARTBEAT, volume = 40))
			beat = BEAT_FAST

	else if(beat != BEAT_NONE)
		owner.stop_sound_channel(CHANNEL_HEARTBEAT)
		beat = BEAT_NONE

/obj/item/organ/heart/get_availability(datum/species/owner_species, mob/living/owner_mob)
	return owner_species.mutantheart

/obj/item/organ/heart/feel_for_damage(self_aware)
	if(owner.needs_heart() && (!beating || (organ_flags & ORGAN_FAILING)))
		return span_boldwarning("[self_aware ? "你的心脏没有在跳动！" : "你感觉不到自己的心跳。"]")
	if(damage < low_threshold)
		return ""
	if(damage < high_threshold)
		return span_warning("[self_aware ? "你的心脏在疼。" : "那里在疼，而且心跳好像不规律。"]")
	return span_boldwarning("[self_aware ? "你的心脏疼得非常厉害！" : "那里疼得很厉害，而且心跳乱得毫无章法。"]")

/// by default, returns the hearts beat_noise var as a notice span. May do other things when overridden, such as eldritch insanity or electrocution. Whatever you want, really.
/obj/item/organ/heart/proc/hear_beat_noise(mob/living/hearer)
	return span_notice("[owner.p_Their()]的心脏发出[beat_noise]。")

/obj/item/organ/heart/cursed
	name = "受诅咒的心脏"
	desc = "一颗在植入后会迫使你手动为它泵血的心脏。"
	icon_state = "cursedheart-off"
	base_icon_state = "cursedheart"
	decay_factor = 0
	beat_noise = "每一次跳动都发出痛苦的尖啸。<b>它似乎完全没有任何节律</b>"
	var/pump_delay = 3 SECONDS
	var/blood_loss = BLOOD_VOLUME_NORMAL * 0.2
	var/heal_brute = 0
	var/heal_burn = 0
	var/heal_oxy = 0

/obj/item/organ/heart/cursed/attack(mob/living/carbon/human/accursed, mob/living/carbon/human/user, obj/target)
	if(accursed == user && istype(accursed))
		playsound(user,'sound/effects/singlebeat.ogg',40,TRUE)
		user.temporarilyRemoveItemFromInventory(src, TRUE)
		Insert(user)
	else
		return ..()

/obj/item/organ/heart/cursed/on_mob_insert(mob/living/carbon/accursed)
	. = ..()

	accursed.AddComponent(/datum/component/manual_heart, pump_delay = pump_delay, blood_loss = blood_loss, heal_brute = heal_brute, heal_burn = heal_burn, heal_oxy = heal_oxy)

/obj/item/organ/heart/cursed/on_mob_remove(mob/living/carbon/accursed, special = FALSE, movement_flags)
	. = ..()

	qdel(accursed.GetComponent(/datum/component/manual_heart))

/obj/item/organ/heart/cursed/hear_beat_noise(mob/living/hearer)
	return span_danger(beat_noise)

/obj/item/organ/heart/cybernetic
	name = "基础义体心脏"
	desc = "一种基础电子装置，用于模拟有机人类心脏的功能。"
	icon_state = "heart-c-on"
	base_icon_state = "heart-c"
	organ_flags = ORGAN_ROBOTIC
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.75 //This also hits defib timer, so a bit higher than its less important counterparts
	failing_desc = "似乎已经损坏。"
	beat_noise = "稳定而持续不断的液压嘶嘶声"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	/// Whether or not we have a stabilization available. This prevents our owner from entering softcrit for an amount of time.
	var/stabilization_available = FALSE
	/// How long our stabilization lasts for.
	var/stabilization_duration = 10 SECONDS
	/// Whether our heart suppresses bleeders and restores blood automatically.
	var/bleed_prevention = FALSE
	/// The probability that our blood replication causes toxin damage.
	var/toxification_probability = 20
	/// Chance of permanent effects if emp-ed.
	var/emp_vulnerability = 80

/obj/item/organ/heart/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	// Some effects are byassed if our owner (should it exist) doesn't need a heart
	var/owner_needs_us = owner?.needs_heart()

	if(owner_needs_us && !COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		owner.set_dizzy_if_lower(15 SECONDS / severity)
		owner.losebreath += 10
		COOLDOWN_START(src, severe_cooldown, 15 SECONDS)

	if(prob(emp_vulnerability/severity)) //Chance of permanent effects
		organ_flags |= ORGAN_EMP //Starts organ faliure - gonna need replacing soon.
		Stop()
		addtimer(CALLBACK(src, PROC_REF(Restart)), 10 SECONDS / severity)
		if(owner_needs_us)
			owner.visible_message(
				span_danger("[owner] 捂住 [owner.p_their()] 胸口，仿佛 [owner.p_their()] 心脏正在停止跳动！"),
				span_userdanger("你感到胸口剧痛，仿佛心脏已经停止了跳动！"),
			)

/obj/item/organ/heart/cybernetic/on_life(seconds_per_tick)
	. = ..()

	if(organ_flags & ORGAN_EMP)
		return

	if(stabilization_available && owner.health <= owner.crit_threshold)
		stabilize_heart()

	// Wound healing is intentionally tied to blood volume.
	if(bleed_prevention && ishuman(owner) && owner.get_blood_volume() < BLOOD_VOLUME_NORMAL)
		var/mob/living/carbon/human/wounded_owner = owner

		if(toxification_probability && prob(toxification_probability))
			wounded_owner.adjust_tox_loss(1 * seconds_per_tick, updating_health = FALSE)

		wounded_owner.coagulant_effect(1 * seconds_per_tick)

/obj/item/organ/heart/cybernetic/proc/stabilize_heart()
	ADD_TRAIT(owner, TRAIT_NOSOFTCRIT, ORGAN_TRAIT)
	stabilization_available = FALSE

	addtimer(TRAIT_CALLBACK_REMOVE(owner, TRAIT_NOSOFTCRIT, ORGAN_TRAIT), stabilization_duration)

	addtimer(VARSET_CALLBACK(src, stabilization_available, TRUE), 5 MINUTES, TIMER_DELETE_ME)

// Largely a sanity check
/obj/item/organ/heart/cybernetic/on_mob_remove(mob/living/carbon/heart_owner, special = FALSE, movement_flags)
	. = ..()
	if(HAS_TRAIT_FROM(heart_owner, TRAIT_NOSOFTCRIT, ORGAN_TRAIT))
		REMOVE_TRAIT(heart_owner, TRAIT_NOSOFTCRIT, ORGAN_TRAIT)

/obj/item/organ/heart/cybernetic/tier2
	name = "义体心脏"
	desc = "一种电子装置，用于模拟有机人类心脏的功能。当出现撕裂伤或大出血时，心脏会迅速开始自我复制\
		人造血液。不过，由于复制过程并不完美，这可能使毒素在血液中积累。"
	icon_state = "heart-c-u-on"
	base_icon_state = "heart-c-u"
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	bleed_prevention = TRUE
	emp_vulnerability = 40
	blood_regeneration_multiplier = 9 // regenerates 2.25u of blood per tick (default is 0.25u)

/obj/item/organ/heart/cybernetic/tier3
	name = "升级版义体心脏"
	desc = "一种电子装置，用于模拟有机人类心脏的功能。当遭受物理创伤时，心脏的临时保险机制能在短时间内维持患者的稳定\
		与行动能力。此外，这颗心脏还能安全地自我复制血液，不会带来毒素积累的风险。"
	icon_state = "heart-c-u2-on"
	base_icon_state = "heart-c-u2"
	maxHealth = 2 * STANDARD_ORGAN_THRESHOLD
	stabilization_available = TRUE
	toxification_probability = 0
	bleed_prevention = TRUE
	emp_vulnerability = 20
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/organ/heart/cybernetic/surplus
	name = "廉价义体心脏"
	desc = "一个脆弱的人类心脏仿制品，看起来更像水泵而不是真正的心脏。\
		完全没有任何电磁脉冲防护能力。"
	icon_state = "heart-c-s-on"
	base_icon_state = "heart-c-s"
	maxHealth = STANDARD_ORGAN_THRESHOLD*0.5
	beat_noise = "令人担忧的不规则液压嗡鸣。它在运转时你<b>不该碰它</b>"
	emp_vulnerability = 100

//surplus organs are so awful that they explode when removed, unless failing
/obj/item/organ/heart/cybernetic/surplus/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dangerous_organ_removal, /*surgical = */ TRUE)

/obj/item/organ/heart/cybernetic/surplus/hear_beat_noise(mob/living/hearer)
	return span_danger("[owner.p_Their()]的心脏发出[beat_noise]。")

/obj/item/organ/heart/freedom
	name = "自由之心"
	desc = "这颗心脏泵动着热情，要给予……某样东西自由。"
	organ_flags = ORGAN_ROBOTIC  //the power of freedom prevents heart attacks
	beat_noise = "<b>自由之声</b>"
	/// The cooldown until the next time this heart can give the host an adrenaline boost.
	COOLDOWN_DECLARE(adrenaline_cooldown)

/obj/item/organ/heart/freedom/on_life(seconds_per_tick)
	. = ..()
	if(owner.health < 5 && COOLDOWN_FINISHED(src, adrenaline_cooldown))
		COOLDOWN_START(src, adrenaline_cooldown, rand(25 SECONDS, 1 MINUTES))
		to_chat(owner, span_userdanger("你感到自己正在死去，但你拒绝放弃！"))
		owner.heal_overall_damage(brute = 15, burn = 15, required_bodytype = BODYTYPE_ORGANIC)
		if(owner.reagents.get_reagent_amount(/datum/reagent/medicine/ephedrine) < 20)
			owner.reagents.add_reagent(/datum/reagent/medicine/ephedrine, 10)

/obj/item/organ/heart/pod
	name = "豆荚线粒体"
	desc = "这个类似植物的器官是豆荚人的能量工厂。" // deliberate wording here
	beat_noise = "豆荚人的力量" // makes sense
	foodtype_flags = PODPERSON_ORGAN_FOODTYPES
	color = COLOR_LIME

/// An improved version of the organic heart, with more health and more "keeping you alive" potential
/obj/item/organ/heart/evolved
	name = "进化心脏"
	desc = "它的跳动始终强劲。"
	icon_state = "heart-evolved-on"
	base_icon_state = "heart-evolved"
	maxHealth = STANDARD_ORGAN_THRESHOLD * 1.2
	/// Chance to heal per on_life
	var/healing_probability = 10
	/// Base healing we receive per tick at 0 damage and for standard versions
	var/base_healing = 1

/obj/item/organ/heart/evolved/on_life(seconds_per_tick)
	. = ..()

	if(prob(healing_probability * seconds_per_tick))
		var/damage_to_heal = base_healing * ((maxHealth - damage) / initial(maxHealth)) * seconds_per_tick
		owner.heal_overall_damage(damage_to_heal, damage_to_heal, required_bodytype = BODYTYPE_ORGANIC)

		if(owner.stat == HARD_CRIT && !owner.has_reagent(/datum/reagent/medicine/atropine, 5))
			owner.reagents.add_reagent(/datum/reagent/medicine/atropine, 1 * seconds_per_tick)

/// A weaker evolved heart, but can block magic in exchange for our organs health!
/obj/item/organ/heart/evolved/sacred
	name = "神圣心脏"
	desc = "你那些邪恶的魔法在爱的力量面前毫无胜算！！！"

	icon_state = "heart-sacred-on"
	base_icon_state = "heart-sacred"

	healing_probability = 5
	base_healing = 0.5
	// How much damage each magic block deals to us
	var/damage_per_block = 50

/obj/item/organ/heart/evolved/sacred/on_life(seconds_per_tick)
	. = ..()

	if(IS_CULTIST(owner))
		owner.reagents.add_reagent(/datum/reagent/water/holywater, 5 * seconds_per_tick)

/obj/item/organ/heart/evolved/sacred/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()

	receiver.AddComponent(/datum/component/anti_magic, block_magic = CALLBACK(src, PROC_REF(on_blocked)), check_blocking = CALLBACK(src, PROC_REF(check_block)))

/obj/item/organ/heart/evolved/sacred/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()

	qdel(organ_owner.GetComponent(/datum/component/anti_magic))

/// When we blocked damage, do PAIN on us
/obj/item/organ/heart/evolved/sacred/proc/on_blocked()
	apply_organ_damage(damage_per_block)
	owner.vomit(VOMIT_CATEGORY_BLOOD)
	playsound(owner, 'sound/effects/health/slowbeat.ogg', 80)

/// We don't block magic if it would kill our heart
/obj/item/organ/heart/evolved/sacred/proc/check_block()
	if(maxHealth - damage <= damage_per_block)
		return FALSE
	return TRUE
