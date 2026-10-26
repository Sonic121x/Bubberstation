/datum/action/cooldown/spell/charge
	name = "充能术"
	desc = "这个法术可以为你手中的许多东西充能，\
		从魔法器物到电子元件都行。有创意的巫师还能用它\
		为同行注入魔力。"
	button_icon_state = "charge"

	sound = 'sound/effects/magic/charge.ogg'
	school = SCHOOL_TRANSMUTATION
	cooldown_time = 60 SECONDS
	cooldown_reduction_per_rank = 5 SECONDS

	invocation = "Diri Cel!"
	invocation_type = INVOCATION_WHISPER
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC

/datum/action/cooldown/spell/charge/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/charge/cast(mob/living/cast_on)
	. = ..()

	// Charge people we're pulling first and foremost
	if(isliving(cast_on.pulling))
		var/mob/living/pulled_living = cast_on.pulling
		var/pulled_has_spells = FALSE

		for(var/datum/action/cooldown/spell/spell in pulled_living.actions)
			spell.reset_spell_cooldown()
			pulled_has_spells = TRUE

		if(pulled_has_spells)
			to_chat(pulled_living, span_notice("你感到原始魔力在体内流淌，感觉很棒！"))
			to_chat(cast_on, span_notice("[pulled_living] 突然变得浑身温热！"))
			return

		to_chat(pulled_living, span_notice("你有那么一瞬间感觉非常奇怪，但随后就过去了。"))

	// Then charge their main hand item, then charge their offhand item
	var/obj/item/to_charge = cast_on.get_active_held_item() || cast_on.get_inactive_held_item()
	if(!to_charge)
		to_chat(cast_on, span_notice("你感到魔力在双手间涌动，但那种感觉很快就消退了。"))
		return

	var/charge_return = SEND_SIGNAL(to_charge, COMSIG_ITEM_MAGICALLY_CHARGED, src, cast_on)

	if(QDELETED(to_charge))
		to_chat(cast_on, span_warning("[src] 似乎与 [to_charge] 产生了不良反应！"))
		return

	if(charge_return & COMPONENT_ITEM_BURNT_OUT)
		to_chat(cast_on, span_warning("[to_charge] 似乎对 [src] 起了负面反应，变得烫得让人难受！"))

	else if(charge_return & COMPONENT_ITEM_CHARGED)
		to_chat(cast_on, span_notice("[to_charge] 突然变得浑身温热！"))

	else
		to_chat(cast_on, span_notice("[to_charge] 似乎对 [src] 没有反应。"))
