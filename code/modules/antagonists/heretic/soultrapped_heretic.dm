///a heretic that got soultrapped by cultists. does nothing, other than signify they suck
/datum/antagonist/soultrapped_heretic
	name = "\improper 被囚魂的异教徒"
	roundend_category = "Heretics"
	antagpanel_category = "Heretic"
	pref_flag = ROLE_HERETIC
	antag_moodlet = /datum/mood_event/soultrapped_heretic
	antag_hud_name = "heretic"

// Will never show up because they're shades inside a sword
/datum/mood_event/soultrapped_heretic
	description = "他们把我困住了！我逃不掉！"
	mood_change = -20

// always failure obj
/datum/objective/heretic_trapped
	name = "囚魂的失败"
	explanation_text = "帮助教团。杀死教团。帮助船员。杀死船员。帮助你的持剑者。杀死你的持剑者。杀死所有人。摇响你的锁链。挣脱你的束缚。"

/datum/antagonist/soultrapped_heretic/on_gain()
	..()
	var/policy = get_policy(ROLE_SOULTRAPPED_HERETIC)
	if(policy)
		to_chat(owner, policy)
	else
		to_chat(owner, span_ghostalert("你是曾经的异教徒被囚禁的灵魂。你可以尝试说服持剑者解除你的束缚，从而获得一定程度的自由，并让他们得以使用你的部分力量。\
		你曾被教团奴役，但并非其成员，仍保有残余的自由意志。除此之外，除了评点几句，你几乎无事可做。尽量不要被困在储物柜里。"))
	owner.current.log_message("作为异教徒被献祭给纳尔西，并被封入一把长剑之中。", LOG_GAME)
	var/datum/objective/epic_fail = new /datum/objective/heretic_trapped()
	epic_fail.completed = FALSE
	objectives += epic_fail
