/proc/chinese_skyrat_items_more_action_storage(value, action_type)
	if(ispath(action_type, /datum/action/cooldown/spell/teshari_hearing) && value == "切换敏锐听觉")
		return "Toggle Sensitive Hearing"
	if(ispath(action_type, /datum/action/item_action/take_dildo) && value == "握住双头假阳具的另一端")
		return "Take the other side of the double dildo in hand"
	if(ispath(action_type, /datum/action/item_action/toggle_personality) && value == "切换武器人格")
		return "Toggle Weapon Personality"
	if(ispath(action_type, /datum/action/item_action/activate_plasma_overclock) && value == "超频等离子充能器")
		return "Overclock Plasma Charger"
	if(ispath(action_type, /datum/action/cooldown/spell/stimpack) && value == "魔法兴奋剂")
		return "Magic Stimpack"
	if(ispath(action_type, /datum/action/item_action/hev_toggle/nri) && value == "切换旭日装甲")
		return "Toggle VOSKHOD Suit"
	if(ispath(action_type, /datum/action/item_action/hev_toggle_notifs/nri) && value == "切换旭日装甲通知")
		return "Toggle VOSKHOD Suit Notifications"
	return value
