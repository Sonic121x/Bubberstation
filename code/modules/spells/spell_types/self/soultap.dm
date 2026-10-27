
/**
 * SOUL TAP!
 *
 * Trades 20 max health for a refresh on all of your spells.
 * I was considering making it depend on the cooldowns of your spells, but I want to support "Big spell wizard" with this loadout.
 * The two spells that sound most problematic with this is mindswap and lichdom,
 * but soul tap requires clothes for mindswap and lichdom takes your soul.
 */
/datum/action/cooldown/spell/tap
	name = "汲魂"
	desc = "用你自己的灵魂为法术提供燃料！"
	button_icon_state = "soultap"

	// I could see why this wouldn't be necromancy, but messing with souls or whatever. Ectomancy?
	school = SCHOOL_NECROMANCY
	cooldown_time = 1 SECONDS
	invocation = "不惜一切代价！"
	invocation_type = INVOCATION_SHOUT
	spell_max_level = 1

	/// The amount of health we take on tap
	var/tap_health_taken = 20

/datum/action/cooldown/spell/tap/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE

	// We call this here so we can get feedback if they try to cast it when they shouldn't.
	if(!is_valid_target(owner))
		if(feedback)
			to_chat(owner, span_warning("你没有可以汲取的灵魂！"))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/tap/is_valid_target(atom/cast_on)
	return isliving(cast_on) && !HAS_TRAIT(cast_on, TRAIT_NO_SOUL)

/datum/action/cooldown/spell/tap/cast(mob/living/cast_on)
	. = ..()
	cast_on.maxHealth -= tap_health_taken
	cast_on.health = min(cast_on.health, cast_on.maxHealth)

	for(var/datum/action/cooldown/spell/spell in cast_on.actions)
		spell.reset_spell_cooldown()

	// If the tap took all of our life, we die and lose our soul!
	if(cast_on.maxHealth <= 0)
		to_chat(cast_on, span_userdanger("你虚弱的灵魂被这次汲取彻底吞噬了！"))
		ADD_TRAIT(cast_on, TRAIT_NO_SOUL, MAGIC_TRAIT)

		cast_on.visible_message(span_danger("[cast_on] 突然死去了！"), ignored_mobs = cast_on)
		cast_on.investigate_log("被汲魂杀死了。", INVESTIGATE_DEATHS)
		cast_on.death()

	// If the next tap will kill us, give us a heads-up
	else if(cast_on.maxHealth - tap_health_taken <= 0)
		to_chat(cast_on, span_bolddanger("你的身体异常虚脱，胸口的灼烧感让人难以忽视！"))

	// Otherwise just give them some feedback
	else
		to_chat(cast_on, span_danger("你感到身体虚脱，胸口传来灼烧般的疼痛。"))
