/datum/action/cooldown/spell/cosmic_rune/before_cast(atom/cast_on)
	. = ..()

	owner.balloon_alert_to_viewers("正在激活符文……")
	if (!do_after(owner, 5 SECONDS, owner, IGNORE_HELD_ITEM))
		return SPELL_CANCEL_CAST
