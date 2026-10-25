/// Determines what accessories your ghost will look like they have.
/datum/preference/choiced/ghost_accessories
	savefile_key = "ghost_accs"
	savefile_identifier = PREFERENCE_PLAYER
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES

/datum/preference/choiced/ghost_accessories/init_possible_values()
	return list(GHOST_ACCS_NONE, GHOST_ACCS_DIR, GHOST_ACCS_FULL)

/datum/preference/choiced/ghost_accessories/create_default_value()
	return GHOST_ACCS_DEFAULT_OPTION

/datum/preference/choiced/ghost_accessories/apply_to_client(client/client, value)
	var/mob/dead/observer/ghost = client.mob
	if (!istype(ghost))
		return

	ghost.ghost_accs = value
	ghost.update_appearance()

/datum/preference/choiced/ghost_accessories/deserialize(input, datum/preferences/preferences)
	// Old ghost preferences used to be 1/50/100.
	// Whoever did that wasted an entire day of my time trying to get those sent
	// properly, so I'm going to buck them.
	if (isnum(input))
		switch (input)
			if (1)
				input = GHOST_ACCS_NONE
			if (50)
				input = GHOST_ACCS_DIR
			if (100)
				input = GHOST_ACCS_FULL

	return ..(input)

/// Determines the appearance of your ghost to others, when you are a BYOND member
/datum/preference/choiced/ghost_form
	savefile_key = "ghost_form"
	savefile_identifier = PREFERENCE_PLAYER
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	should_generate_icons = TRUE

	var/static/list/ghost_forms = list(
		"catghost" = "猫",
		"ghost" = "默认",
		"ghost_black" = "黑色",
		"ghost_blazeit" = "燃起来",
		"ghost_blue" = "蓝色",
		"ghost_camo" = "迷彩",
		"ghost_cyan" = "青色",
		"ghost_dblue" = "深蓝",
		"ghost_dcyan" = "深青",
		"ghost_dgreen" = "深绿",
		"ghost_dpink" = "深粉",
		"ghost_dred" = "深红",
		"ghost_dyellow" = "深黄",
		"ghost_fire" = "火焰",
		"ghost_funkypurp" = "迷幻紫",
		"ghost_green" = "绿色",
		"ghost_grey" = "灰色",
		"ghost_mellow" = "柔和",
		"ghost_pink" = "粉色",
		"ghost_pinksherbert" = "粉色雪泥",
		"ghost_purpleswirl" = "紫色漩涡",
		"ghost_rainbow" = "彩虹",
		"ghost_red" = "红色",
		"ghost_yellow" = "黄色",
		"ghostian2" = "伊恩",
		"ghostking" = "国王",
		"skeleghost" = "骷髅",
	)

/datum/preference/choiced/ghost_form/init_possible_values()
	return assoc_to_keys(ghost_forms)

/datum/preference/choiced/ghost_form/icon_for(value)
	return uni_icon('icons/mob/simple/mob.dmi', value)

/datum/preference/choiced/ghost_form/create_default_value()
	return "ghost"

/datum/preference/choiced/ghost_form/apply_to_client(client/client, value)
	var/mob/dead/observer/ghost = client.mob
	if (!istype(ghost))
		return

	if (!client.is_content_unlocked())
		return

	ghost.update_icon(ALL, value)

/datum/preference/choiced/ghost_form/compile_constant_data()
	var/list/data = ..()

	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = ghost_forms

	return data

/// Toggles the HUD for ghosts
/datum/preference/toggle/ghost_hud
	savefile_key = "ghost_hud"
	savefile_identifier = PREFERENCE_PLAYER
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES

/datum/preference/toggle/ghost_hud/apply_to_client(client/client, value)
	if (isobserver(client?.mob))
		client?.mob.hud_used?.show_hud()

/// Determines what ghosts orbiting look like to you.
/datum/preference/choiced/ghost_orbit
	savefile_key = "ghost_orbit"
	savefile_identifier = PREFERENCE_PLAYER
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES

/datum/preference/choiced/ghost_orbit/init_possible_values()
	return list(
		GHOST_ORBIT_CIRCLE,
		GHOST_ORBIT_TRIANGLE,
		GHOST_ORBIT_SQUARE,
		GHOST_ORBIT_HEXAGON,
		GHOST_ORBIT_PENTAGON,
	)

/datum/preference/choiced/ghost_orbit/apply_to_client(client/client, value)
	var/mob/dead/observer/ghost = client.mob
	if (!istype(ghost))
		return

	if (!client.is_content_unlocked())
		return

	ghost.ghost_orbit = value

/// Determines how to show other ghosts
/datum/preference/choiced/ghost_others
	savefile_key = "ghost_others"
	savefile_identifier = PREFERENCE_PLAYER
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES

/datum/preference/choiced/ghost_others/init_possible_values()
	return list(
		GHOST_OTHERS_SIMPLE,
		GHOST_OTHERS_DEFAULT_SPRITE,
		GHOST_OTHERS_THEIR_SETTING,
	)

/datum/preference/choiced/ghost_others/create_default_value()
	return GHOST_OTHERS_DEFAULT_OPTION

/datum/preference/choiced/ghost_others/apply_to_client(client/client, value)
	var/mob/dead/observer/ghost = client.mob
	if (!istype(ghost))
		return

	ghost.update_sight()

/datum/preference/choiced/ghost_others/deserialize(input, datum/preferences/preferences)
	// Old ghost preferences used to be 1/50/100.
	// Whoever did that wasted an entire day of my time trying to get those sent
	// properly, so I'm going to buck them.
	if (isnum(input))
		switch (input)
			if (1)
				input = GHOST_OTHERS_SIMPLE
			if (50)
				input = GHOST_OTHERS_DEFAULT_SPRITE
			if (100)
				input = GHOST_OTHERS_THEIR_SETTING

	return ..(input, preferences)

/// Whether or not ghosts can examine things by clicking on them.
/datum/preference/toggle/inquisitive_ghost
	savefile_key = "inquisitive_ghost"
	savefile_identifier = PREFERENCE_PLAYER
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES

/// When enabled, prevents any and all ghost role pop-ups.
/datum/preference/toggle/ghost_roles
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "ghost_roles"
	savefile_identifier = PREFERENCE_PLAYER
