GAME_VERB_DESC(/client, open_character_preferences, "打开角色偏好设置", "打开角色偏好设置", "OOC")

	if(!prefs)
		return
	prefs.current_window = PREFERENCE_TAB_CHARACTER_PREFERENCES
	prefs.update_static_data(usr)
	prefs.ui_interact(usr)

GAME_VERB_DESC(/client, open_game_preferences, "打开游戏偏好设置", "打开游戏偏好设置", "OOC")

	if(!prefs)
		return
	prefs.current_window = PREFERENCE_TAB_GAME_PREFERENCES
	prefs.update_static_data(usr)
	prefs.ui_interact(usr)

