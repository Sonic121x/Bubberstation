/obj/item/autosurgeon
	name = "自动手术器"
	desc = "一种能自动将植入物、技能芯片或器官植入使用者体内的装置，免去了大规模手术的麻烦。 \
		它有一个用于插入植入物或器官的插槽，以及一个用于取出误装物品的螺丝刀槽。"
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "autosurgeon"
	inhand_icon_state = "nothing"
	w_class = WEIGHT_CLASS_SMALL

	/// How many times you can use the autosurgeon before it becomes useless
	var/uses = INFINITY
	/// What organ will the autosurgeon sub-type will start with. ie, CMO autosurgeon start with a medi-hud.
	var/starting_organ
	/// The organ currently loaded in the autosurgeon, ready to be implanted.
	var/obj/item/organ/stored_organ
	/// The list of organs and their children we allow into the autosurgeon. An empty list means no whitelist.
	var/list/organ_whitelist = list()
	/// The percentage modifier for how fast you can use the autosurgeon to implant other people.
	var/surgery_speed = 1
	/// The overlay that shows when the autosurgeon has an organ inside of it.
	var/loaded_overlay = "autosurgeon_loaded_overlay"

/obj/item/autosurgeon/attack_self_tk(mob/user)
	return //stops TK fuckery

/obj/item/autosurgeon/Initialize(mapload)
	. = ..()
	if(starting_organ)
		load_organ(new starting_organ(src))

/obj/item/autosurgeon/update_overlays()
	. = ..()
	if(stored_organ)
		. += loaded_overlay
		. += emissive_appearance(icon, loaded_overlay, src)

/obj/item/autosurgeon/proc/load_organ(obj/item/organ/loaded_organ, mob/living/user)
	if(user)
		if(stored_organ)
			to_chat(user, span_alert("[src] 里已经存有一个植入物。"))
			return

		if(uses <= 0)
			to_chat(user, span_alert("[src] 已经用尽，无法再装入更多植入物。"))
			return

		if(organ_whitelist.len)
			var/organ_whitelisted
			for(var/whitelisted_organ in organ_whitelist)
				if(istype(loaded_organ, whitelisted_organ))
					organ_whitelisted = TRUE
					break
			if(!organ_whitelisted)
				to_chat(user, span_alert("[src] 与 [loaded_organ] 不兼容。"))
				return

		if(!user.transferItemToLoc(loaded_organ, src))
			to_chat(user, span_alert("[loaded_organ] 粘在你手上了！"))
			return

	stored_organ = loaded_organ
	loaded_organ.forceMove(src)

	name = "[initial(name)] ([stored_organ.name])" //to tell you the organ type, like "suspicious autosurgeon (Reviver implant)"
	update_appearance()

/obj/item/autosurgeon/proc/use_autosurgeon(mob/living/target, mob/living/user, implant_time)
	if(!stored_organ)
		to_chat(user, span_alert("[src] 目前没有存放植入物。"))
		return

	if(uses <= 0)
		to_chat(user, span_alert("[src] 已经被使用过了。工具已经变钝，无法再次启动。"))
		return

	if(implant_time)
		user.visible_message(
			span_notice("[user] 准备对 [target] 使用 [src]。"),
			span_notice("你准备对 [target] 使用 [src]。"),
		)
		if(!do_after(user, (implant_time * surgery_speed), target))
			return

	if(target != user)
		log_combat(user, target, "用自动手术器将 [stored_organ] 植入了", "[src]", "位于 [AREACOORD(target)]")
		user.visible_message(span_notice("[user] 按下 [src] 上的按钮，让它刺入 [target] 的身体。"), span_notice("你按下 [src] 上的按钮，让它刺入 [target] 的身体。"))
	else
		user.visible_message(
			span_notice("[user] 按下 [src] 上的按钮，让它刺入自己的身体。"),
			span_notice("你按下 [src] 上的按钮，让它刺入你的身体。"),
		)

	if (stored_organ.valid_zones && user.get_held_index_of_item(src))
		var/list/checked_zones = list(user.zone_selected)
		if (IS_RIGHT_INDEX(user.get_held_index_of_item(src)))
			checked_zones += list(BODY_ZONE_R_ARM, BODY_ZONE_R_LEG)
		else
			checked_zones += list(BODY_ZONE_L_ARM, BODY_ZONE_L_LEG)

		for (var/check_zone in checked_zones)
			if (stored_organ.valid_zones[check_zone])
				stored_organ.swap_zone(check_zone)
				break

	if (!stored_organ.Insert(target)) // insert stored organ into the user
		balloon_alert(user, "植入失败！")
		return

	stored_organ = null
	name = initial(name) //get rid of the organ in the name
	playsound(target.loc, 'sound/items/weapons/circsawhit.ogg', 50, vary = TRUE)
	update_appearance()

	uses--
	if(uses <= 0)
		desc = "[initial(desc)] 看起来已经用尽了。"

/obj/item/autosurgeon/attack_self(mob/user)//when the object it used...
	use_autosurgeon(user, user)

/obj/item/autosurgeon/attack(mob/living/target, mob/living/user, list/modifiers, list/attack_modifiers)
	add_fingerprint(user)
	use_autosurgeon(target, user, 8 SECONDS)

/obj/item/autosurgeon/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(isorgan(tool))
		load_organ(tool, user)
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/autosurgeon/screwdriver_act(mob/living/user, obj/item/screwtool)
	if(..())
		return TRUE
	if(!stored_organ)
		to_chat(user, span_warning("[src] 里没有可供你取出的植入物！"))
	else
		var/atom/drop_loc = user.drop_location()
		for(var/atom/movable/stored_implant as anything in src)
			stored_implant.forceMove(drop_loc)
			to_chat(user, span_notice("你把 [stored_organ] 从 [src] 中取了出来。"))
			stored_organ = null

		screwtool.play_tool_sound(src)
		uses--
		if(uses <= 0)
			desc = "[initial(desc)] 看起来已经用尽了。"
		update_appearance(UPDATE_ICON)
	return TRUE

/obj/item/autosurgeon/medical_hud
	desc = "一次性自动手术器，内含医疗平视显示器义体。可用螺丝刀将其取出，但无法再装回植入物。"
	uses = 1
	starting_organ = /obj/item/organ/cyberimp/eyes/hud/medical

/obj/item/autosurgeon/syndicate
	name = "可疑的自动手术器"
	icon_state = "autosurgeon_syndicate"
	surgery_speed = 0.75
	loaded_overlay = "autosurgeon_syndicate_loaded_overlay"

/obj/item/autosurgeon/syndicate/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/autosurgeon/syndicate/laser_arm
	desc = "一次性自动手术器，内含战斗用臂装激光义体。可用螺丝刀将其取出，但无法再装回植入物。"
	uses = 1
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/gun/laser

/obj/item/autosurgeon/syndicate/thermal_eyes
	starting_organ = /obj/item/organ/eyes/robotic/thermals

/obj/item/autosurgeon/syndicate/thermal_eyes/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/xray_eyes
	starting_organ = /obj/item/organ/eyes/robotic/xray

/obj/item/autosurgeon/syndicate/xray_eyes/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/anti_stun
	starting_organ = /obj/item/organ/cyberimp/brain/anti_stun

/obj/item/autosurgeon/syndicate/anti_stun/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/reviver
	starting_organ = /obj/item/organ/cyberimp/chest/reviver

/obj/item/autosurgeon/syndicate/reviver/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/commsagent
	desc = "一种能自动——而且很痛地——植入植入物的装置。看来有人特意 \
	改装了这一台，让它只能植入……舌头。真可怕。"
	starting_organ = /obj/item/organ/tongue

/obj/item/autosurgeon/syndicate/commsagent/Initialize(mapload)
	. = ..()
	organ_whitelist += /obj/item/organ/tongue

/obj/item/autosurgeon/syndicate/emaggedsurgerytoolset
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/surgery/emagged

/obj/item/autosurgeon/syndicate/emaggedsurgerytoolset/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/contraband_sechud
	desc = "内含违禁的安保 HUD 植入物，健康扫描仪无法检测到。"
	uses = 1
	starting_organ = /obj/item/organ/cyberimp/eyes/hud/security/syndicate
