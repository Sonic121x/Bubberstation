// Empath quirk component, it's a component because it can be applied in ways that don't give you the quirk. (For health analyzer purposes)

/datum/component/empathy

	dupe_mode = COMPONENT_DUPE_SOURCES

	// Whether or not we should get scared the next time we see an evil person.
	var/seen_it = FALSE

	// What sort of information we can glean from examining someone
	var/visible_info = ALL

	// Whether or not we can use empathy on ourselves
	var/self_empath = FALSE

	// Whether or not empathy works on humans playing dead
	var/sense_dead = FALSE

	// Whether or not we can tell if people whisper under their mask from far away (We can't hear what they said, we just know they said something)
	var/sense_whisper = TRUE

	// Whether or not we can be smited by someoneone with the evil trait using the mending touch mutation
	var/smite_target = TRUE

/datum/component/empathy/Initialize(seen_it = FALSE, visible_info = ALL, self_empath = FALSE, sense_dead = FALSE, sense_whisper = TRUE, smite_target = TRUE)
	if (!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	src.seen_it = seen_it
	src.visible_info = visible_info
	src.self_empath = self_empath
	src.sense_dead = sense_dead
	src.sense_whisper = sense_whisper
	src.smite_target = smite_target
	if(sense_whisper)
		ADD_TRAIT(parent, TRAIT_SEE_MASK_WHISPER, REF(src))

/datum/component/empathy/RegisterWithParent()
	RegisterSignal(parent, COMSIG_CARBON_MID_EXAMINE, PROC_REF(get_empath_info))
	RegisterSignal(parent, COMSIG_ON_LAY_ON_HANDS, PROC_REF(on_hands_laid))

/datum/component/empathy/proc/get_empath_info(datum/source, mob/living/target, list/examine_list)
	SIGNAL_HANDLER
	if(target.stat == DEAD)
		return
	if(HAS_TRAIT(target, TRAIT_FAKEDEATH))
		if(sense_dead)
			examine_list += "这具尸体似乎有哪里不太对劲……"
		else
			return
	var/mob/living/living_parent = parent
	if(target == living_parent && !self_empath)
		return
	var/t_They = "[target]"
	var/t_their = "其"
	var/t_Their = "其"
	var/t_are = "正在"
	if((visible_info & EMPATH_SEE_COMBAT) && target.combat_mode)
		examine_list += "[t_They]似乎正保持警惕。"
	if((visible_info & EMPATH_SEE_OXY) && target.get_oxy_loss() >= 10)
		examine_list += "[t_They]似乎气喘吁吁。"
	if((visible_info & EMPATH_SEE_TOX) && target.get_tox_loss() >= 10)
		examine_list += "[t_They]似乎有些病态。"
	if((visible_info & EMPATH_SEE_SANITY) && target.mob_mood.sanity <= SANITY_DISTURBED)
		examine_list += "[t_They]似乎十分苦恼。"
	if((visible_info & EMPATH_SEE_BLIND) && target.is_blind())
		examine_list += "[t_They]似乎正望着虚空发呆。"
	if((visible_info & EMPATH_SEE_DEAF) && HAS_TRAIT(target, TRAIT_DEAF))
		examine_list += "[t_They]似乎对声音毫无反应。"
	if((visible_info & EMPATH_SEE_HOT) && target.bodytemperature > target.get_body_temp_heat_damage_limit())
		examine_list += "[t_They]面色潮红，[t_are]喘息。"
	if((visible_info & EMPATH_SEE_COLD) && target.bodytemperature < target.get_body_temp_cold_damage_limit())
		examine_list += "[t_They][t_are]发抖。"
	if((visible_info & EMPATH_SEE_EVIL) && HAS_TRAIT(target, TRAIT_EVIL))
		examine_list += "[t_Their]眼神中透着无情而冰冷的疏离。[t_their]灵魂中只有黑暗。"
		if(living_parent.mind?.holy_role >= HOLY_ROLE_PRIEST)
			examine_list += span_warning("正该施以神罚！！")
		else if(!seen_it)
			seen_it = TRUE
			living_parent.add_mood_event("encountered_evil", /datum/mood_event/encountered_evil)
			living_parent.set_jitter_if_lower(15 SECONDS)
	// BUBBER EDIT ADDITION BEGIN - Empaths detect arousal
	if(ishuman(target) && living_parent.client.prefs.read_preference(/datum/preference/toggle/erp))
		examine_list += astype(target, /mob/living/carbon/human).get_arousal_info()
	// BUBBER EDIT ADDITION END - Empaths detect arousal

/datum/component/empathy/proc/on_hands_laid(datum/source, mob/living/carbon/smiter)
	SIGNAL_HANDLER
	if(iscarbon(parent))
		var/mob/living/carbon/carbon_parent = parent
		if(carbon_parent.mob_biotypes & MOB_UNDEAD)
			return FALSE
	if(smite_target && HAS_TRAIT(smiter, TRAIT_EVIL))
		return TRUE
	return FALSE

/datum/component/empathy/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_CARBON_MID_EXAMINE)

/datum/component/empathy/Destroy(force = FALSE)
	REMOVE_TRAIT(parent, TRAIT_SEE_MASK_WHISPER, REF(src))
	return ..()
