/datum/mutation/uwu
	name = "卖萌化"
	desc = "一种让受影响者说话过分可爱的突变。"
	locked = TRUE
	instability = NEGATIVE_STABILITY_MINI
	quality = MINOR_NEGATIVE
	text_gain_indication = span_notice("你想喵一声……")
	text_lose_indication = span_notice("想喵叫的冲动消失了。")
	var/static/list/language_mutilation = list(
		"r" = "w",
		"l" = "w",
		"na" = "nya",
		"ne" = "nye",
		"ni" = "nyi",
		"no" = "nyo",
		"nu" = "nyu"
	)

/datum/mutation/uwu/New(datum/mutation/copymut)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = language_mutilation)
