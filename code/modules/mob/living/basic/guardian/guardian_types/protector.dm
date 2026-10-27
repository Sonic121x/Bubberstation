/// Very durable, and reverses the usual leash dynamic. Can slow down to become extremely durable.
/mob/living/basic/guardian/protector
	guardian_type = GUARDIAN_PROTECTOR
	melee_damage_lower = 15
	melee_damage_upper = 15
	range = 5 // You want this to be low so you can drag them around
	damage_coeff = list(BRUTE = 0.4, BURN = 0.4, TOX = 0.4, STAMINA = 0, OXY = 0.4)
	playstyle_string = span_holoparasite("作为<b>保护者</b>型，你使召唤者牵引到你身边，而不是你牵引到他们身边，并拥有两种模式：战斗模式，你造成并承受中等伤害；保护模式，你造成并承受的伤害几乎为零，但移动稍慢。")
	creator_name = "保护者"
	creator_desc = "与其他寄生体不同，当使用者超出范围时，会使其传送至你身边。拥有两种模式：战斗模式，造成并承受中等伤害；保护模式，造成并承受的伤害几乎为零，但移动稍慢。"
	creator_icon = "protector"
	toggle_button_type = /datum/action/cooldown/guardian/toggle_mode
	/// Action which toggles our shield
	var/datum/action/cooldown/mob_cooldown/protector_shield/shield

/mob/living/basic/guardian/protector/Initialize(mapload, datum/guardian_fluff/theme)
	. = ..()
	shield = new(src)
	shield.Grant(src)

/mob/living/basic/guardian/protector/Destroy()
	QDEL_NULL(shield)
	return ..()

// Invert the order
/mob/living/basic/guardian/protector/leash_to(atom/movable/leashed, atom/movable/leashed_to)
	return ..(leashed_to, leashed)

/mob/living/basic/guardian/protector/unleash()
	qdel(summoner?.GetComponent(/datum/component/leash))

/mob/living/basic/guardian/protector/toggle_modes()
	shield.Trigger()

/mob/living/basic/guardian/protector/ex_act(severity)
	if(severity >= EXPLODE_DEVASTATE)
		adjust_brute_loss(400) //if in protector mode, will do 20 damage and not actually necessarily kill the summoner
		return TRUE
	return ..()

/// Toggle a status effect which makes you slow but defensive
/datum/action/cooldown/mob_cooldown/protector_shield
	name = "保护模式"
	desc = "进入防御姿态，移动变慢、伤害降低，但几乎无敌。"
	button_icon = 'icons/effects/effects.dmi'
	button_icon_state = "shield-old"
	background_icon = 'icons/hud/guardian.dmi'
	background_icon_state = "base"
	cooldown_time = 1 SECONDS
	click_to_activate = FALSE
	owner_has_control = FALSE // Hide it from the user, it's integrated with guardian UI

/datum/action/cooldown/mob_cooldown/protector_shield/Activate(mob/living/target)
	if (!isliving(target))
		return FALSE
	if (target.has_status_effect(/datum/status_effect/protector_shield))
		target.remove_status_effect(/datum/status_effect/protector_shield)
		return
	target.apply_status_effect(/datum/status_effect/protector_shield)
	StartCooldown()
	return TRUE

/// Makes the guardian even more durable, but slower
/datum/status_effect/protector_shield
	id = "guardian_shield"
	alert_type = null
	/// Damage removed in protecting mode.
	var/damage_penalty = 13
	/// Colour for our various overlays.
	var/overlay_colour = COLOR_TEAL
	/// Overlay for our protection shield.
	var/mutable_appearance/shield_overlay
	/// Damage coefficients when shielded
	var/static/list/shielded_damage = list(BRUTE = 0.05, BURN = 0.05, TOX = 0.05, STAMINA = 0, OXY = 0.05)
	// What the damage coefficients were previously
	var/list/original_damage_coeff

/datum/status_effect/protector_shield/on_apply()
	if (isguardian(owner))
		var/mob/living/basic/guardian/guardian_owner = owner
		overlay_colour = guardian_owner.guardian_colour
	shield_overlay = mutable_appearance('icons/effects/effects.dmi', "shield-grey")
	shield_overlay.color = overlay_colour

	owner.melee_damage_lower -= damage_penalty
	owner.melee_damage_upper -= damage_penalty
	owner.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/guardian_shield)

	if (isbasicmob(owner)) // Better hope you are or this status is doing basically nothing useful for you
		var/mob/living/basic/basic_owner = owner
		original_damage_coeff = basic_owner.damage_coeff
		basic_owner.damage_coeff = shielded_damage

	to_chat(owner, span_bolddanger("你进入了保护模式。"))
	RegisterSignal(owner, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_update_overlays))
	RegisterSignals(owner, COMSIG_LIVING_ADJUST_STANDARD_DAMAGE_TYPES, PROC_REF(on_health_changed))
	owner.update_appearance(UPDATE_ICON)
	return TRUE

/datum/status_effect/protector_shield/on_remove()
	owner.melee_damage_lower += damage_penalty
	owner.melee_damage_upper += damage_penalty
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/status_effect/guardian_shield)

	if (isbasicmob(owner))
		var/mob/living/basic/basic_owner = owner
		basic_owner.damage_coeff = original_damage_coeff

	to_chat(owner, span_bolddanger("你恢复了正常模式。"))
	UnregisterSignal(owner, list(COMSIG_ATOM_UPDATE_OVERLAYS) + COMSIG_LIVING_ADJUST_STANDARD_DAMAGE_TYPES)
	owner.update_appearance(UPDATE_ICON)

/// Show an extra overlay when we're in shield mode
/datum/status_effect/protector_shield/proc/on_update_overlays(atom/source, list/overlays)
	SIGNAL_HANDLER
	overlays += shield_overlay

/// Flash an animation when someone tries to hurt us
/datum/status_effect/protector_shield/proc/on_health_changed(mob/living/our_mob, type, amount, forced)
	SIGNAL_HANDLER
	if (amount <= 0 && !QDELETED(our_mob))
		return
	var/image/flash_overlay = new('icons/effects/effects.dmi', owner, "shield-flash", dir = pick(GLOB.cardinals))
	flash_overlay.color = overlay_colour
	owner.flick_overlay_view(flash_overlay, 0.5 SECONDS)
