// BUBBER ADDITION: Preserve action button storage names for localized downstream antagonists.
/proc/chinese_zubbers_heretic_action_storage(value, action_type)
	if(ispath(action_type, /datum/action/cooldown/spell/paranoias_eye) && value == "妄念之眼")
		return "Paranoia's Eye"
	if(ispath(action_type, /datum/action/cooldown/mansus_eye) && value == "窥视之眼")
		return "watching eye"
	if(ispath(action_type, /datum/action/cooldown/spell/pointed/tricksters_cackle) && value == "诡戏者的承诺")
		return "Trickster's Promise"
	if(ispath(action_type, /datum/action/cooldown/spell/caretaker) && value == "看守者的最后庇护")
		return "Caretaker's Last Refuge"
	if(ispath(action_type, /datum/action/cooldown/spell/void_stealth) && value == "暗夜之幕")
		return "Cloak of the dark"
	if(ispath(action_type, /datum/action/innate/ai/ranged/override_directive) && value == "夺取正电子机体")
		return "Subvert Positronic Chassis"
	if(ispath(action_type, /datum/action/innate/ai/law_override) && value == "手动覆盖法则")
		return "Manual Law Override"
	if(ispath(action_type, /datum/action/cooldown/spell/pointed/revenant/bloodwriting) && value == "血书")
		return "Bloodwriting"
	return value
