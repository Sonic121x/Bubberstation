/datum/heretic_knowledge/spell/space_phase
	desc = "赋予你太空相位，让你能在太空中自由移动。\
		只有在太空或特殊地格上才能进入或退出相位。激活前需要短暂蓄力。"

/datum/action/cooldown/spell/jaunt/space_crawl/before_cast(atom/cast_on)
	. = ..()

	if (!is_jaunting(owner))
		owner.balloon_alert_to_viewers("正在移出相位……")
		if (!do_after(owner, 2 SECONDS, owner, IGNORE_HELD_ITEM|IGNORE_SLOWDOWNS|IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE))
			return SPELL_CANCEL_CAST
