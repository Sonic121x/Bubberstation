/**
 * Can enter stealth mode to become invisible and deal bonus damage on their next attack, an ambush predator.
 */
/mob/living/basic/guardian/assassin
	guardian_type = GUARDIAN_ASSASSIN
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "挥砍"
	attack_verb_simple = "挥砍"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	sharpness = SHARP_POINTY
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, STAMINA = 0, OXY = 1)
	playstyle_string = span_holoparasite("作为<b>刺客</b>型，你造成中等伤害且没有伤害抗性，但可以进入潜行，大幅提升下一次攻击的伤害并使其无视护甲。攻击或受到伤害时潜行会解除。")
	creator_name = "刺客"
	creator_desc = "造成中等伤害并承受全额伤害，但可以进入潜行，使其下一次攻击造成巨额伤害并无视护甲。不过，从潜行中攻击后，它会短暂无法被召回。"
	creator_icon = "assassin"
	toggle_button_type = /datum/action/cooldown/guardian/toggle_mode/assassin
	/// How long to put stealth on cooldown if we are forced out?
	var/stealth_cooldown_time = 16 SECONDS

/mob/living/basic/guardian/assassin/Initialize(mapload, datum/guardian_fluff/theme)
	. = ..()
	RegisterSignal(src, COMSIG_GUARDIAN_ASSASSIN_REVEALED, PROC_REF(on_forced_unstealth))

// Toggle stealth
/mob/living/basic/guardian/assassin/toggle_modes()
	var/stealthed = has_status_effect(/datum/status_effect/guardian_stealth)
	var/datum/action/cooldown/guardian/toggle_mode/assassin/stealth_ability = locate() in actions
	if (stealthed)
		to_chat(src, span_bolddanger("你退出了潜行。"))
		remove_status_effect(/datum/status_effect/guardian_stealth)
		if(stealth_ability)
			stealth_ability.build_all_button_icons()
		return
	if (!is_deployed())
		to_chat(src, span_bolddanger("你必须先显形才能进入潜行！"))
		return
	apply_status_effect(/datum/status_effect/guardian_stealth)
	if(stealth_ability)
		stealth_ability.build_all_button_icons()

/// Called when we are removed from stealth involuntarily
/mob/living/basic/guardian/assassin/proc/on_forced_unstealth(mob/living/source)
	SIGNAL_HANDLER
	visible_message(span_danger("[src] 突然显现！"))
	COOLDOWN_START(src, manifest_cooldown, 4 SECONDS)
	var/datum/action/cooldown/guardian/toggle_mode/assassin/stealth_ability = locate() in actions
	if(stealth_ability)
		stealth_ability.StartCooldownSelf(stealth_cooldown_time)

/// Status effect which makes us sneakier and do bonus damage
/datum/status_effect/guardian_stealth
	id = "guardian_stealth"
	alert_type = null
	/// Damage added in stealth mode.
	var/damage_bonus = 35
	/// Our wound bonus when in stealth mode. Allows you to actually cause wounds, unlike normal.
	var/stealth_wound_bonus = -20

/datum/status_effect/guardian_stealth/on_apply()
	new /obj/effect/temp_visual/guardian/phase/out(get_turf(owner))
	owner.melee_damage_lower += damage_bonus
	owner.melee_damage_upper += damage_bonus
	if (isbasicmob(owner))
		var/mob/living/basic/basic_owner = owner
		basic_owner.armour_penetration = 100
		basic_owner.wound_bonus = stealth_wound_bonus
		basic_owner.obj_damage = 0
	to_chat(owner, span_bolddanger("你进入潜行，强化了你的下一次攻击。"))
	animate(owner, alpha = 15, time = 0.5 SECONDS)

	RegisterSignals(owner, list(COMSIG_GUARDIAN_RECALLED, COMSIG_HOSTILE_POST_ATTACKINGTARGET), PROC_REF(forced_exit))
	RegisterSignals(owner, COMSIG_LIVING_ADJUST_STANDARD_DAMAGE_TYPES, PROC_REF(on_health_changed))
	return TRUE

/datum/status_effect/guardian_stealth/on_remove()
	owner.melee_damage_lower -= damage_bonus
	owner.melee_damage_upper -= damage_bonus
	if (isbasicmob(owner))
		var/mob/living/basic/basic_owner = owner
		basic_owner.armour_penetration = initial(basic_owner.armour_penetration)
		basic_owner.wound_bonus = initial(basic_owner.wound_bonus)
		basic_owner.obj_damage = initial(basic_owner.obj_damage)
	animate(owner, alpha = initial(owner.alpha), time = 0.5 SECONDS)
	UnregisterSignal(owner, list(COMSIG_GUARDIAN_RECALLED, COMSIG_HOSTILE_POST_ATTACKINGTARGET) + COMSIG_LIVING_ADJUST_STANDARD_DAMAGE_TYPES)

/// If we take damage, exit the status effect
/datum/status_effect/guardian_stealth/proc/on_health_changed(mob/living/our_mob, type, amount, forced)
	SIGNAL_HANDLER
	if (amount <= 0)
		return
	forced_exit()

/// Forcibly exit the status effect
/datum/status_effect/guardian_stealth/proc/forced_exit()
	SIGNAL_HANDLER
	SEND_SIGNAL(owner, COMSIG_GUARDIAN_ASSASSIN_REVEALED)
	qdel(src)
