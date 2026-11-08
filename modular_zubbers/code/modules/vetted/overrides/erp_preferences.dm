/datum/preference/toggle/master_erp_preferences/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!CONFIG_GET(flag/disable_erp_preferences) && preferences.parent.is_vetted) // 自定义修改：强制屏蔽成人内容并保留普通服饰
		return TRUE
	ASYNC
		SSplayer_ranks.is_vetted(preferences.parent, admin_bypass = FALSE)


/datum/preference/toggle/erp/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!CONFIG_GET(flag/disable_erp_preferences) && preferences.parent.is_vetted) // 自定义修改：强制屏蔽成人内容并保留普通服饰
		return TRUE

	ASYNC
		SSplayer_ranks.is_vetted(preferences.parent, admin_bypass = FALSE)

