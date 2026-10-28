/mob/living
	/// Normalized is a check for instances where more than one accessory of jewelry is worn. For all intensive purposes, only the first worn accessory stores the user's size.
	var/normalized = FALSE
	///Effect from hold up
	var/obj/effect/overlay/gunpoint_effect/lock_on_effect

/// Toggle admin frozen
/mob/living/proc/toggle_admin_freeze(client/admin)
	admin_frozen = !admin_frozen

	if(admin_frozen)
		SetStun(INFINITY, ignore_canstun = TRUE)
	else
		SetStun(0, ignore_canstun = TRUE)

	if(client && admin)
		to_chat(src, span_userdanger("管理员已[!admin_frozen ? "解冻" : "冻结"]了你。"))
		log_admin("[key_name(admin)] 对 [key_name(src)] 的管理员冻结状态进行了切换。")
		message_admins("[key_name_admin(admin)] 对 [key_name_admin(src)] 的管理员冻结状态进行了切换。")

/// Toggle admin sleeping
/mob/living/proc/toggle_admin_sleep(client/admin)
	admin_sleeping = !admin_sleeping

	if(admin_sleeping)
		SetSleeping(INFINITY)
	else
		SetSleeping(0)

	if(client && admin)
		to_chat(src, span_userdanger("管理员已使你[!admin_sleeping ? "醒来" : "入睡"]。"))
		log_admin("[key_name(admin)] 对 [key_name(src)] 的管理员催眠状态进行了切换。")
		message_admins("[key_name_admin(admin)] 对 [key_name_admin(src)] 的管理员催眠状态进行了切换。")
