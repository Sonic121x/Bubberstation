#define WAND_OPEN "open"
#define WAND_BOLT "bolt"
#define WAND_EMERGENCY "emergency"
#define WAND_SHOCK "shock"
#define WAND_DEPOWER "depower"

/obj/item/door_remote
	icon_state = "remote"
	base_icon_state = "remote"
	worn_icon = null
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	icon = 'icons/obj/devices/remote.dmi'
	name = "控制法杖"
	desc = "用于控制一组气闸的遥控器。"
	w_class = WEIGHT_CLASS_TINY
	drop_sound = 'sound/items/door_remote/door_remote_drop1.ogg'
	pickup_sound = 'sound/items/door_remote/door_remote_pick_up1.ogg'

	var/department = "civilian"
	var/mode = WAND_OPEN
	var/region_access = REGION_GENERAL
	var/list/access_list = list()
	// the trim of the owner of this remote, if applied
	var/datum/id_trim/job/owner_trim = null
	// areas that this remote is the exclusive owner of
	var/list/area/our_domain = null
	// areas specifically considered as restricted from a remote
	// accessing them unless specifically allowed (vault, security, etc)
	var/static/list/area/restricted_areas = list(
		/area/station/command/bridge, 									/*so Captain's remote isn't totally useless*/
		/area/station/security, 										/*so antag RD/HoP/QM/CMO can't easily screw up the brig doors*/
		/area/station/command/vault, 									/*aka Vault since it's QM's special thing*/
		/area/station/ai/satellite/chamber,	// these are areas exclusive to RD
		/area/station/ai/upload,			// but sometimes mappers might misconfig their doors with our several dozen access helpers
	)
	COOLDOWN_DECLARE(shock_cooldown)
	/// sound played when mode is switched
	var/mode_switch_sound = SFX_REMOTE_MODE_SWITCH
	/// sound played when an action is done
	var/action_sound = SFX_REMOTE_ACTION

/obj/item/door_remote/Initialize(mapload)
	. = ..()
	update_icon_state()
	// initialize late to make sure job accesses are fully configured
	return INITIALIZE_HINT_LATELOAD

/obj/item/door_remote/LateInitialize()
	access_list = SSid_access.get_region_access_list(list(region_access))
	if(!isnull(owner_trim))
		var/datum/id_trim/job/trim_singlet = SSid_access.trim_singletons_by_path[owner_trim]
		access_list |= trim_singlet.access

/obj/item/door_remote/proc/is_my_domain(area/restricted_area)
	for(var/area/dominion as anything in our_domain)
		if(istype(restricted_area, dominion))
			return TRUE
	return FALSE

/obj/item/door_remote/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	if(obj_flags & EMAGGED)
		return FALSE
	balloon_alert(user, "受限功能已解锁")
	obj_flags |= EMAGGED
	update_icon_state()
	return TRUE

/obj/item/door_remote/attack_self(mob/user)
	var/static/list/ops = list(WAND_OPEN = "开门", WAND_BOLT = "切换门闩", WAND_EMERGENCY = "切换紧急通行", WAND_SHOCK = "电击门", WAND_DEPOWER = "切断门电源")
	switch(mode)
		if(WAND_OPEN)
			mode = WAND_BOLT
		if(WAND_BOLT)
			mode = WAND_EMERGENCY
		if(WAND_EMERGENCY)
			if(!(obj_flags & EMAGGED))
				mode = WAND_OPEN
			else
				mode = WAND_SHOCK
		if(WAND_SHOCK)
			mode = WAND_DEPOWER
		if(WAND_DEPOWER)
			mode = WAND_OPEN
	update_icon_state()
	balloon_alert(user, "模式：[ops[mode]]")
	if(mode_switch_sound)
		playsound(src, mode_switch_sound, 50, TRUE)

/obj/item/door_remote/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /obj/machinery/door) && !isturf(interacting_with))
		return NONE
	return ranged_interact_with_atom(interacting_with, user, modifiers)

/obj/item/door_remote/omni
	name = "全能门控遥控器"
	desc = "这根控制法杖可以开启空间站上的任何一扇门。"
	department = "omni"
	region_access = REGION_ALL_STATION
	our_domain = list(	/area/station	)

/obj/item/door_remote/captain
	name = "指挥部门控遥控器"
	desc = "用于控制一组气闸的遥控器。尽管其花哨的徽记表明舰长是它的主人，但附带的细则 \
		说明它的权限仅限于舰桥及高安保级别的指挥区域——另有一行小字 \
		明确将安保部排除在高安保区域之外。真是讽刺。"
	department = "command"
	region_access = REGION_COMMAND
	our_domain = list(
		/area/station,	// still restricted by limited accesses in REGION_COMMAND
	)

/obj/item/door_remote/chief_engineer
	name = "工程部门控遥控器"
	desc = "用于控制一组气闸的遥控器。这一个闻起来像烧焦的血肉和臭氧。"
	department = "engi"
	region_access = REGION_ENGINEERING
	owner_trim = /datum/id_trim/job/chief_engineer
	// doesn't need a domain because their specific high-security areas aren't on anyone else's trim but cap

/obj/item/door_remote/research_director
	name = "科研部门控遥控器"
	desc = "用于控制一组气闸的遥控器。这一个略微变形，仿佛被某个力大无穷的人捏过。"
	department = "sci"
	region_access = REGION_RESEARCH
	owner_trim = /datum/id_trim/job/research_director
	our_domain = list(
		/area/station/ai/satellite/chamber,
		/area/station/ai/upload,
	)

/obj/item/door_remote/head_of_security
	name = "安保部门控遥控器"
	desc = "用于控制一组气闸的遥控器。这一个闻起来有汗水、血、怨恨和咖啡的味道。\
		似乎有人篡改过它的标识。"
	department = "security"
	region_access = REGION_SECURITY
	owner_trim = /datum/id_trim/job/head_of_security
	our_domain = list(	/area/station/security	)

/obj/item/door_remote/quartermaster
	name = "货运部门控遥控器"
	desc = "远程控制气闸。这台遥控器额外拥有金库权限。尽管如此，拿着它总会让你莫名感到不安。"
	department = "cargo"
	region_access = REGION_SUPPLY
	owner_trim = /datum/id_trim/job/quartermaster
	our_domain = list( /area/station/command/vault )

/obj/item/door_remote/chief_medical_officer
	name = "医疗部门控遥控器"
	desc = "用于控制一组气闸的遥控器。它散发着浓烈刺鼻的血腥味，而且尽管带有医疗徽记，\
		却完全没有一丝消毒剂的气味。"
	department = "med"
	region_access = REGION_MEDBAY
	owner_trim = /datum/id_trim/job/chief_medical_officer

/obj/item/door_remote/head_of_personnel
	name = "服务部门控遥控器"
	desc = "用于控制一组气闸的遥控器。这一个闻起来像打印机墨水，还会让持有者产生\
		神秘消失的冲动。"
	department = "civilian"
	region_access = REGION_GENERAL
	owner_trim = /datum/id_trim/job/head_of_personnel

/obj/item/door_remote/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/machinery/door/door
	if(action_sound)
		playsound(src, action_sound, 50, TRUE)

	if (istype(interacting_with, /obj/machinery/door))
		door = interacting_with
		if (!door.opens_with_door_remote)
			return ITEM_INTERACT_BLOCKING

	else
		for (var/obj/machinery/door/door_on_turf in get_turf(interacting_with))
			if (door_on_turf.opens_with_door_remote)
				door = door_on_turf
				break

		if (isnull(door))
			return ITEM_INTERACT_BLOCKING

	if (!door.check_access_list(access_list) || !door.requiresID())
		interacting_with.balloon_alert(user, "无法通行！")
		return ITEM_INTERACT_BLOCKING

	var/area/door_area = get_area(door)
	if(is_type_in_list(door_area, restricted_areas) && !is_my_domain(get_area(door)))
		interacting_with.balloon_alert(user, "无法通行！")
		return ITEM_INTERACT_BLOCKING

	var/obj/machinery/door/airlock/airlock = door

	if (!door.hasPower() || (istype(airlock) && !airlock.canAIControl()))
		interacting_with.balloon_alert(user, mode == WAND_OPEN ? "它纹丝不动！" : "什么也没发生！")
		return ITEM_INTERACT_BLOCKING

	switch (mode)
		if (WAND_OPEN)
			if (door.density)
				door.open()
			else
				door.close()

		if (WAND_BOLT)
			if (!istype(airlock))
				interacting_with.balloon_alert(user, "只能用于气闸！")
				return ITEM_INTERACT_BLOCKING

			if (airlock.locked)
				airlock.unbolt()
				log_combat(user, airlock, "解开门闩", src)
			else
				airlock.bolt()
				log_combat(user, airlock, "锁上门闩", src)

		if (WAND_EMERGENCY)
			if (!istype(airlock))
				interacting_with.balloon_alert(user, "只能用于气闸！")
				return ITEM_INTERACT_BLOCKING

			airlock.emergency = !airlock.emergency
			airlock.update_appearance(UPDATE_ICON)

		if (WAND_SHOCK)
			if (!istype(airlock))
				interacting_with.balloon_alert(user, "只能用于气闸！")
				return ITEM_INTERACT_BLOCKING
			if (!COOLDOWN_FINISHED(src, shock_cooldown))
				interacting_with.balloon_alert(user, "电击脉冲正在重置！")
				return ITEM_INTERACT_BLOCKING
			if (airlock.isElectrified())
				interacting_with.balloon_alert(user, "已经带电了！")
			else
				airlock.set_electrified(MACHINE_DEFAULT_ELECTRIFY_TIME, user)
				COOLDOWN_START(src, shock_cooldown, 10 SECONDS)

		if (WAND_DEPOWER)
			if (!istype(airlock))
				interacting_with.balloon_alert(user, "只能用于气闸！")
				return ITEM_INTERACT_BLOCKING
			// First hit disrupts main power, backup comes back in ten seconds, if you stick around you can hit backup for 60 more seconds of downtime.
			if (!airlock.main_power_timer)
				airlock.loseMainPower()
			else if (!airlock.backup_power_time)
				airlock.loseBackupPower()

	return ITEM_INTERACT_SUCCESS

/obj/item/door_remote/update_icon_state()
	var/icon_state_mode
	if(!(obj_flags & EMAGGED))
		switch(mode)
			if(WAND_OPEN)
				icon_state_mode = "open"
			if(WAND_BOLT)
				icon_state_mode = "bolt"
			if(WAND_EMERGENCY)
				icon_state_mode = "emergency"
	else
		icon_state_mode = "emergency"

	icon_state = "[base_icon_state]_[department]_[icon_state_mode]"
	return ..()

#undef WAND_OPEN
#undef WAND_BOLT
#undef WAND_EMERGENCY
#undef WAND_SHOCK
#undef WAND_DEPOWER
