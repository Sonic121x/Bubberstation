ADMIN_VERB(toggle_fov, R_ADMIN|R_DEBUG, "启用/禁用视野限制", "全局切换视野。", ADMIN_CATEGORY_DEBUG)
	var/on_off = CONFIG_GET(flag/native_fov)

	message_admins("[key_name_admin(user)] 已[on_off ? "禁用" : "启用"]原生视野配置。")
	log_admin("[key_name(user)] 已[on_off ? "禁用" : "启用"]原生视野配置。")
	CONFIG_SET(flag/native_fov, !on_off)

	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggled Field of View", "[on_off ? "Enabled" : "Disabled"]"))

	for(var/mob/living/mob in GLOB.player_list)
		mob.update_fov()
