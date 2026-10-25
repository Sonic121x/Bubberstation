///The time limit on the keys before the access it's been given clears itself.
#define ACCESS_TIMER_LIMIT (10 MINUTES)

/obj/item/access_key
	name = "通行钥匙环"
	desc = "带蜂鸣器的钥匙环，能让钥匙根据所拥有的权限改变外形。"
	icon_state = "access_key"
	inhand_icon_state = "access_key"
	icon = 'icons/obj/service/janitor.dmi'
	lefthand_file = 'icons/mob/inhands/items/keys_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/keys_righthand.dmi'
	hitsound = 'sound/items/rattling_keys_attack.ogg'
	force = 2
	verb_say = "哔哔作响" //it has a beeper
	verb_ask = "发出疑问的哔声"
	verb_exclaim = "大声哔哔"
	w_class = WEIGHT_CLASS_TINY

	///The departmental access given to the key.
	var/list/department_access

	/// The amount of time it takes to find the necessary key when attempting to open an airlock
	var/key_speed = 3 SECONDS

/obj/item/access_key/Initialize(mapload)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_ON_DEPARTMENT_ACCESS, PROC_REF(department_access_given))
	GLOB.janitor_devices += src

/obj/item/access_key/Destroy()
	GLOB.janitor_devices -= src
	return ..()

/obj/item/access_key/examine(mob/user)
	. = ..()
	if(department_access)
		. += "它目前拥有 [department_access] 区域的通行权限。"

/obj/item/access_key/examine_more(mob/user)
	. = ..()
	. += span_notice("可通过钥匙卡认证装置授予通行权限。")
	. += span_notice("该权限一次只能授予一个部门。")

/**
 * Called when attempting to open an airlock.
 * Checks if the keys have access, returns try_to_activate_door if it does, returns FALSE otherwise.
 * Args:
 * user - The person attempting to open the door
 * airlock - The door we're attempting to open
 */
/obj/item/access_key/proc/attempt_open_door(mob/living/user, obj/machinery/door/airlock)
	if(DOING_INTERACTION_WITH_TARGET(user, airlock))
		return FALSE
	user.balloon_alert_to_viewers("手忙脚乱地翻找钥匙……", "寻找钥匙……")
	user.playsound_local(src, 'sound/items/rattling_keys.ogg', 25, TRUE)
	if(!do_after(user, key_speed, airlock))
		return FALSE
	if(!department_access || !airlock.check_access_list(SSid_access.accesses_by_region[department_access]))
		airlock.balloon_alert(user, "无通行权限！")
		return FALSE
	return airlock.try_to_activate_door(user, access_bypass = TRUE)

/**
 * Called when a keycard authenticator sends region access
 * Stores it on the key to use for access, then sets a timer to clear it.
 * Args:
 * source - the keycard authenticator giving us the access
 * region_access - the list of access we're being sent, we only take the first entry in the list as there should only have one department at a time.
 */
/obj/item/access_key/proc/department_access_given(obj/machinery/keycard_auth/source, list/region_access)
	SIGNAL_HANDLER
	department_access = region_access[1]
	say("已授予 [department_access] 区域的通行权限。")
	playsound(src, 'sound/machines/ding.ogg', 25, TRUE)
	addtimer(CALLBACK(src, PROC_REF(clear_access)), ACCESS_TIMER_LIMIT, TIMER_UNIQUE|TIMER_OVERRIDE)
	log_game("[department_access] 部门的通行权限已授予 [src] [(ismob(loc)) ? "由 [loc] 持有" : "但未被人持有"]")
	investigate_log("[department_access] 部门的通行权限已授予 [src] [(ismob(loc)) ? "由 [loc] 持有" : "但未被人持有"]", INVESTIGATE_ACCESSCHANGES)

/**
 * Called when a keycard authenticator runs out of time
 * Clears the department access and alerts nearby people of such.
 */
/obj/item/access_key/proc/clear_access()
	log_game("[src] 上的 [department_access] 部门通行权限已过期。")
	investigate_log("[src] 上的 [department_access] 部门通行权限已过期。]", INVESTIGATE_ACCESSCHANGES)
	department_access = null
	say("通行权限已撤销，时间到了。")
	playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 25, TRUE)

#undef ACCESS_TIMER_LIMIT
