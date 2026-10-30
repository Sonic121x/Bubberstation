/// Whether the alert shows a running count of how many people have signed up so far.
/datum/candidate_poll/var/show_candidate_amount = TRUE

/// Closes the alert. Opting out for the round is Alt-click or the chat link.
/atom/movable/screen/alert/poll_alert/proc/dismiss_poll()
	if(isnull(poll))
		return
	owner.clear_alert("[poll.poll_key]_poll_alert")

/atom/movable/screen/alert/poll_alert/proc/confirm_never_round()
	if(isnull(poll))
		return
	if(poll.ignoring_category != ANTAG_PROMPT_IGNORE_CATEGORY || (owner.ckey in GLOB.poll_ignore[poll.ignoring_category]))
		set_never_round()
		return

	var/mob/asked = owner
	var/choice = tgui_alert(
		asked,
		"这会在本回合剩余时间内隐藏所有反派招募提示，而不只是这一条。你可以使用 OOC 标签页中的“清除招募屏蔽”命令重新启用。",
		"禁用反派招募提示？",
		list("Yes", "No"),
	)
	if(choice != "Yes" || isnull(poll) || owner != asked)
		return
	set_never_round()
