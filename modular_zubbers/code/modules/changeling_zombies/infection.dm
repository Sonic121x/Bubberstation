GLOBAL_VAR_INIT(changeling_zombies_detected,FALSE)

/proc/can_become_changeling_zombie(datum/parent)

	if(!ishuman(parent) || HAS_TRAIT(parent,TRAIT_NEVER_CONSIDERED_ALIVE) || HAS_TRAIT(parent,TRAIT_GENELESS))
		return FALSE

	var/mob/living/carbon/human/host = parent

	if(IS_CHANGELING(host))
		return FALSE

	if(!host.dna)
		return FALSE

	if(HAS_TRAIT(host, TRAIT_DNR))
		return FALSE

	var/datum/species/host_species = host.dna.species

	if(host_species.no_equip_flags & ITEM_SLOT_OCLOTHING)
		return FALSE

	return TRUE

/datum/component/changeling_zombie_infection

	var/zombified = FALSE
	var/can_cure = FALSE
	var/was_changeling_husked = FALSE

	var/list/obj/item/melee/arm_blade/changeling_zombie/arm_blades = list()
	var/obj/item/clothing/suit/armor/changeling/prototype/armor

	var/list/bodypart_zones_to_regenerate = list()
	COOLDOWN_DECLARE(limb_regen_cooldown)

	var/datum/objective/changeling_zombie_infect/infect_objective

	var/static/list/random_mumblings = list(
		"我们的一员",
		"成为我们的一员",
		"融为一体",
		"我们是一体",
		"被吞噬吧"
	)

	COOLDOWN_DECLARE(transformation_grace_period)

	var/infection_timestamp = 0

	var/spaceacillin_resistance = 0

/datum/component/changeling_zombie_infection/Initialize()

	. = ..()

	if(!can_become_changeling_zombie(parent))
		return COMPONENT_INCOMPATIBLE

	infection_timestamp = world.time

	START_PROCESSING(SSobj, src)

	if(HAS_TRAIT_FROM(parent,TRAIT_HUSK, CHANGELING_DRAIN))
		COOLDOWN_START(src, transformation_grace_period, 30 SECONDS)
		was_changeling_husked = TRUE

	RegisterSignal(parent, SIGNAL_ADDTRAIT(TRAIT_HUSK), PROC_REF(on_husk))
	RegisterSignal(parent, SIGNAL_REMOVETRAIT(TRAIT_HUSK), PROC_REF(on_unhusk))

/datum/component/changeling_zombie_infection/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_LIVING_DEATH)
	UnregisterSignal(parent, COMSIG_CARBON_REMOVE_LIMB)
	UnregisterSignal(parent, COMSIG_CARBON_ATTACH_LIMB)
	UnregisterSignal(parent, COMSIG_MOB_SAY)
	UnregisterSignal(parent, SIGNAL_ADDTRAIT(TRAIT_HUSK))
	UnregisterSignal(parent, SIGNAL_REMOVETRAIT(TRAIT_HUSK))

/datum/component/changeling_zombie_infection/Destroy(force, silent)

	QDEL_LIST(arm_blades)
	QDEL_NULL(armor)

	STOP_PROCESSING(SSobj, src)

	if(parent)
		var/mob/living/carbon/human/host = parent
		if(zombified)
			playsound(parent, 'sound/effects/magic/demon_consume.ogg', 50, TRUE)
		REMOVE_TRAITS_IN(host,TRAIT_CHANGELING_ZOMBIE)
		host.mind?.remove_antag_datum(/datum/antagonist/changeling_zombie)

	zombified = FALSE

	. = ..()

/datum/component/changeling_zombie_infection/process(seconds_per_tick)

	var/mob/living/carbon/human/host = parent

	if(SPT_PROB(4, seconds_per_tick) && istype(host.loc,/obj/machinery/cryo_cell))
		var/obj/machinery/cryo_cell/gay_baby_jail = host.loc
		if(gay_baby_jail.on)
			gay_baby_jail.visible_message(
				span_danger("有什么东西在 [gay_baby_jail] 里翻腾挣扎！")
			)
			gay_baby_jail.Shake()
			gay_baby_jail.take_damage(gay_baby_jail.max_integrity*0.2,armour_penetration=100)

	if(zombified)
		var/list/healing_options = list()
		if(host.get_brute_loss() > 0)
			healing_options += BRUTE
		if(host.get_fire_loss() > 0)
			healing_options += BURN
		if(host.get_tox_loss() > 0)
			healing_options += TOX
		if(length(healing_options))
			host.heal_damage_type(CHANGELING_ZOMBIE_PASSIVE_HEALING,pick(healing_options))

		if(host.blood_volume <= BLOOD_VOLUME_NORMAL)
			host.blood_volume += 5

		if(length(bodypart_zones_to_regenerate) && COOLDOWN_FINISHED(src,limb_regen_cooldown))
			var/selected_zone = pick_n_take(bodypart_zones_to_regenerate)
			if(host.regenerate_limb(selected_zone))
				var/obj/item/bodypart/regenerated_bodypart = host.get_bodypart(selected_zone)
				host.visible_message(
					span_danger("[host] 重塑并再生了自己的 [regenerated_bodypart]！"),
					span_userdanger("你重塑并再生了自己的 [regenerated_bodypart]！"),
					span_hear("你听到血肉生长的声音！"),
					COMBAT_MESSAGE_RANGE
				)
				playsound(host, 'sound/effects/splat.ogg', 50)

	else if(spaceacillin_resistance < 100 && host.reagents?.has_reagent(/datum/reagent/medicine/spaceacillin))
		var/current_toxin_damage = host.get_tox_loss()
		if(can_cure || current_toxin_damage > CHANGELING_ZOMBIE_TOXINS_THRESHOLD_TO_CURE*0.5 + spaceacillin_resistance)
			qdel(src)
			return
		spaceacillin_resistance += seconds_per_tick
	else
		var/current_toxin_damage = host.get_tox_loss()
		if(can_cure && current_toxin_damage <= 5) //Not exactly 0 just in case there are race conditions with healing.
			qdel(src) //Cured!
			return
		else if(COOLDOWN_FINISHED(src,transformation_grace_period))
			if(current_toxin_damage >= CHANGELING_ZOMBIE_TOXINS_THRESHOLD_TO_TRANSFORM && host.stat == DEAD)
				make_zombie()
				can_cure = FALSE
			else
				var/damage_multiplier = max(1, (world.time - infection_timestamp) / (1 MINUTES) )
				if(can_cure)
					damage_multiplier = min(2,damage_multiplier) //Caps it to double.
				if(host.stat && host.stat == DEAD)
					host.adjust_tox_loss(round(CHANGELING_ZOMBIE_TOXINS_PER_SECOND_DEAD * seconds_per_tick * damage_multiplier,0.1))
				else
					if(!can_cure && current_toxin_damage >= CHANGELING_ZOMBIE_TOXINS_THRESHOLD_TO_CURE) //50 toxins to cure
						can_cure = TRUE
						host.visible_message(
							span_danger("[host] 的血肉硬化并开始变形；现在正是治好他的好时机！"),
							span_userdanger("你的血肉在扭动、冒泡……这可不是什么好兆头。"),
							span_hear("你听到血肉生长的声音！"),
							COMBAT_MESSAGE_RANGE
						)
					host.adjust_tox_loss(round(CHANGELING_ZOMBIE_TOXINS_PER_SECOND_LIVING * seconds_per_tick * damage_multiplier,0.1))
				if(SPT_PROB(4, seconds_per_tick))
					if(current_toxin_damage > CHANGELING_ZOMBIE_TOXINS_THRESHOLD_TO_CURE)
						var/obj/item/bodypart/wound_area = host.get_bodypart(pick(BODY_ZONE_L_ARM,BODY_ZONE_R_ARM))
						if(wound_area)
							var/datum/wound/slash/flesh/moderate/flesh_wound = new
							flesh_wound.apply_wound(wound_area)
							host.visible_message(
								span_danger("[host] 的 [wound_area] 猛烈扭曲变形，仿佛有什么东西正要挣脱出来！"),
								span_userdanger("你的 [wound_area] 猛烈扭曲变形！到底怎么回事？！"),
								span_hear("你听到血肉撕裂的声音！"),
								COMBAT_MESSAGE_RANGE
							)
							host.emote("scream")
						else
							host.emote("groan")
					else if(current_toxin_damage > CHANGELING_ZOMBIE_TOXINS_THRESHOLD_TO_CURE*0.5)
						host.visible_message(
							span_warning("[host] 看起来不太好……"),
							span_warning("你感觉不太舒服……")
						)
						host.emote("cough")

/datum/component/changeling_zombie_infection/proc/make_zombie()

	if(zombified)
		return FALSE

	var/mob/living/carbon/human/host = parent

	host.grab_ghost()

	zombified = TRUE

	host.cure_husk(CHANGELING_DRAIN) //If we don't actually cure the husk, weird shit happens.

	to_chat(host, span_notice("你感到里里外外都在发痒，仿佛组织正在不断编织、重组。"))

	host.add_traits(
		list(
			TRAIT_ILLITERATE,
			TRAIT_CHUNKYFINGERS,
			TRAIT_DISCOORDINATED_TOOL_USER,
			TRAIT_AIRLOCK_SHOCKIMMUNE,
			TRAIT_RESISTCOLD,
			TRAIT_RESISTLOWPRESSURE,
			TRAIT_NOHUNGER,
			TRAIT_NOBREATH,
			TRAIT_NEVER_CONSIDERED_ALIVE,
			TRAIT_THERMAL_VISION,
			TRAIT_NEARSIGHTED_CORRECTED,
			TRAIT_TUMOR_SUPPRESSED,
			TRAIT_RDS_SUPPRESSED,
			TRAIT_EASYDISMEMBER,
			TRAIT_HARD_SOLES,
			TRAIT_FAKEDEATH,
		),
		TRAIT_CHANGELING_ZOMBIE
	)

	host.cure_all_traumas(TRAUMA_RESILIENCE_MAGIC)
	host.revive(ADMIN_HEAL_ALL)

	host.do_jitter_animation(10 SECONDS)
	playsound(host, 'sound/effects/hallucinations/far_noise.ogg', 50, TRUE)

	host.drop_all_held_items()

	//Give armblades.
	for(var/hand_index=1,hand_index<=length(host.held_items),hand_index++)
		generate_armblade(host,hand_index)

	//Give suit.
	if(host.wear_suit)
		host.temporarilyRemoveItemFromInventory(host.wear_suit,TRUE)
	armor = new(host.loc)
	ADD_TRAIT(armor, TRAIT_NODROP, TRAIT_CHANGELING_ZOMBIE)
	host.equip_to_slot_if_possible(armor,ITEM_SLOT_OCLOTHING,TRUE,TRUE,TRUE)

	//Extra boost
	host.SetKnockdown(0)
	host.set_stamina_loss(0)
	host.set_resting(FALSE)
	host.reagents.add_reagent(/datum/reagent/medicine/changelingadrenaline, 4)
	host.reagents.add_reagent(/datum/reagent/medicine/changelinghaste, 3)

	RegisterSignal(host, COMSIG_LIVING_DEATH, PROC_REF(on_owner_died))
	RegisterSignal(host, COMSIG_CARBON_REMOVE_LIMB, PROC_REF(on_remove_limb))
	RegisterSignal(host, COMSIG_CARBON_POST_ATTACH_LIMB, PROC_REF(on_gain_limb))
	RegisterSignal(host, COMSIG_MOB_SAY, PROC_REF(handle_speech))

	if(host.mind)
		host.mind.add_antag_datum(/datum/antagonist/changeling_zombie)

	if(!was_changeling_husked && !GLOB.changeling_zombies_detected) //Only announce if it's from a non-changeling spawn.
		var/turf/T = get_turf(host)
		if(is_station_level(T.z)) //Prevents the announcements if admins are fucking around on centcom.
			var/list/turf/found_turfs = get_area_turfs(/area/station/medical,subtypes=TRUE)
			if(length(found_turfs))
				var/turf/chosen_turf = pick(found_turfs)
				if(chosen_turf)
					GLOB.changeling_zombies_detected = TRUE
					priority_announce(
						"通知：一种被盗的巫师联邦病毒据说能“让死者动画化”（原文如此），它可能——也可能没有——经由补给舱被误送到了本站。请将上述补给舱内的物品交还给最近的纳米传讯代表。若发生意外感染，请使用已送至 [chosen_turf.loc] 的解药及随附说明书。",
						"复活病毒警报",
						ANNOUNCER_ANIMES
					)
					podspawn(list(
						"target" = chosen_turf,
						"path" = /obj/structure/closet/supplypod/centcompod,
						"style" = /datum/pod_style/centcom,
						"spawn" = /obj/structure/closet/crate/medical/changeling_zombie_cure,
						"damage" = 50,
						"explosionSize" = list(0, 1, 2, 3),
						"effectStun" = TRUE
				))

	return TRUE

/datum/component/changeling_zombie_infection/proc/generate_armblade(mob/living/carbon/human/host,hand_index)
	var/obj/item/melee/arm_blade/changeling_zombie/arm_blade = new(host.loc)
	arm_blade.blood_chance = was_changeling_husked ? CHANGELING_ZOMBIE_INFECT_CHANCE_LESSER : CHANGELING_ZOMBIE_INFECT_CHANCE //Less chance to infect if you were made a zombie by a changeling.
	ADD_TRAIT(arm_blade, TRAIT_NODROP, TRAIT_CHANGELING_ZOMBIE)
	RegisterSignal(arm_blade, COMSIG_QDELETING, PROC_REF(on_armblade_delete))
	host.put_in_hand(arm_blade,hand_index,forced=TRUE)
	arm_blades += arm_blade
	return arm_blade

/datum/component/changeling_zombie_infection/proc/on_husk()

	SIGNAL_HANDLER

	if(HAS_TRAIT_FROM(parent,TRAIT_HUSK, CHANGELING_DRAIN))
		COOLDOWN_START(src, transformation_grace_period, CHANGELING_ZOMBIE_MINIMUM_TRANSFORM_DELAY)
		was_changeling_husked = TRUE //If you were somehow changeling husked after you became a zombie.

/datum/component/changeling_zombie_infection/proc/on_unhusk()

	SIGNAL_HANDLER

	if(was_changeling_husked && !zombified) //Unhusking someone who was ling husked will remove the changeling zombie infection, as long as they aren't a zombie.
		qdel(src)

/datum/component/changeling_zombie_infection/proc/on_owner_died()

	SIGNAL_HANDLER

	//Death is a valid cure, only if you're already transformed.
	if(zombified)
		qdel(src)

/datum/component/changeling_zombie_infection/proc/on_remove_limb(datum/source, obj/item/bodypart/removed_limb, special, dismembered)

	SIGNAL_HANDLER

	if(removed_limb.body_zone == BODY_ZONE_HEAD || removed_limb.body_zone == BODY_ZONE_CHEST)
		return

	bodypart_zones_to_regenerate += removed_limb.body_zone
	COOLDOWN_START(src,limb_regen_cooldown,CHANGELING_ZOMBIE_LIMB_REGEN_TIME)


/datum/component/changeling_zombie_infection/proc/on_armblade_delete(datum/source)

	SIGNAL_HANDLER

	src.arm_blades -= source

/datum/component/changeling_zombie_infection/proc/on_gain_limb(datum/source, obj/item/bodypart/gained, special)

	SIGNAL_HANDLER

	if(!gained.held_index)
		return

	var/mob/living/carbon/human/host = parent

	generate_armblade(host,gained.held_index)

	COOLDOWN_START(src,limb_regen_cooldown,CHANGELING_ZOMBIE_LIMB_REGEN_TIME)

/datum/component/changeling_zombie_infection/proc/handle_speech(datum/source, list/speech_args)

	SIGNAL_HANDLER

	speech_args[SPEECH_SPANS] |= SPAN_ITALICS

	var/message = "[speech_args[SPEECH_MESSAGE]] "

	if(message[1] != "*")
		var/list/exploded_words = splittext(message," ")
		for(var/word in exploded_words)
			if(prob(25))
				word = uppertext(word)
			if(!prob(80))
				message = "[message][word] "
				continue
			message = "[message][word]... "
			if(prob(10))
				message = "[message][prob(1) ? "被吞噬吧（不过不是那种意义上的） " : pick(random_mumblings)]! "

		speech_args[SPEECH_MESSAGE] = trim(message)
