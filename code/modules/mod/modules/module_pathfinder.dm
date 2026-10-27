#define PATHFINDER_PRE_ANIMATE_TIME (2 SECONDS)

///Pathfinder - Can fly the suit from a long distance to an implant installed in someone.
/obj/item/mod/module/pathfinder
	name = "MOD 寻路模块"
	desc = "本模块由中村工程公司提供，包含两个部分。\
		第一部分是一组推进器和一套计算机化定位子程序，安装在\
		套装的控制单元之中，使套装能以高速公路般的速度飞行，并利用套装的权限锁\
		在站内导航，同时还能定位系统的第二部分；\
		即植入使用者脊柱底部的寻路植入体，\
		它会将使用者的位置广播给套装，让他们随时把套装召回身边。\
		植入体存放于模块内部，需注入人体才能生效。\
		中村工程公司信誓旦旦地保证确实有减速板。"
	icon_state = "pathfinder"
	complexity = 1
	module_type = MODULE_USABLE
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 10
	incompatible_modules = list(/obj/item/mod/module/pathfinder)
	required_slots = list(ITEM_SLOT_BACK|ITEM_SLOT_BELT)
	allow_flags = list(MODULE_ALLOW_INACTIVE|MODULE_ALLOW_UNWORN)
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT)
	/// The pathfinding implant.
	var/obj/item/implant/mod/implant
	/// Whether the implant has been used or not
	var/implant_inside = TRUE
	/// The jet icon we apply to the MOD.
	var/image/jet_icon
	/// Allow suit activation - Lets this module be recalled from the MOD.
	var/allow_suit_activation = FALSE // I'm not here to argue about balance
	/// Are we currently travelling?
	var/in_transit = FALSE


/obj/item/mod/module/pathfinder/Initialize(mapload)
	. = ..()
	implant = new(src)
	jet_icon = image(icon = 'icons/obj/clothing/modsuit/mod_modules.dmi', icon_state = "mod_jet", layer = LOW_ITEM_LAYER)


/obj/item/mod/module/pathfinder/Destroy()
	QDEL_NULL(implant)
	return ..()

/obj/item/mod/module/pathfinder/Exited(atom/movable/gone, direction)
	if(gone == implant)
		implant_inside = FALSE
		update_icon_state()
	return ..()

/obj/item/mod/module/pathfinder/update_icon_state()
	. = ..()
	icon_state = implant_inside ? "pathfinder" : "pathfinder_empty"

/obj/item/mod/module/pathfinder/examine(mob/user)
	. = ..()
	if(implant_inside)
		. += span_notice("对人类使用以将其植入。")
	else
		. += span_warning("植入体不见了。")

/obj/item/mod/module/pathfinder/attack(mob/living/target, mob/living/user, list/modifiers, list/attack_modifiers)
	if(!ishuman(target) || !implant_inside) // Not human, or no implant in module
		return
	if(!do_after(user, 1.5 SECONDS, target = target))
		balloon_alert(user, "被打断了！")
		return
	if(!implant.implant(target, user)) // If implant fails
		balloon_alert(user, "无法植入！")
		return
	if(target == user)
		to_chat(user, span_notice("你将 [implant] 植入了自己体内。"))
	else
		target.visible_message(span_notice("[user] 将植入体植入了 [target] 体内。"), span_notice("[user] 将 [implant] 植入了你体内。"))
	playsound(src, 'sound/effects/spray.ogg', 30, TRUE, -6)

/obj/item/mod/module/pathfinder/on_use(mob/activator)
	. = ..()
	if(mod.wearer && implant_inside) // implant them
		try_implant(activator)
		return
	if(mod.wearer)
		balloon_alert(activator, "套装已被穿戴！")
	else
		recall(activator)


/// Assuming we have a wearer, attempt to implant them.
/obj/item/mod/module/pathfinder/proc/try_implant(mob/activator)
	if(!ishuman(mod.wearer)) // Wearer isn't human
		return
	if(!implant.implant(mod.wearer, mod.wearer))
		balloon_alert(activator, "无法植入！")
		return
	balloon_alert(activator, "已植入")
	if(!(activator == mod.wearer)) // someone else implanted you
		balloon_alert(mod.wearer, "追踪器已植入！")
	playsound(src, 'sound/effects/spray.ogg', 30, TRUE, -6)

/obj/item/mod/module/pathfinder/proc/attach(mob/living/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	if(human_user.get_item_by_slot(mod.slot_flags) && !human_user.dropItemToGround(human_user.get_item_by_slot(mod.slot_flags)))
		return
	if(!human_user.equip_to_slot_if_possible(mod, mod.slot_flags, qdel_on_fail = FALSE, disable_warning = TRUE))
		return
	mod.quick_deploy(user)
	human_user.update_action_buttons(TRUE)
	playsound(mod, 'sound/machines/ping.ogg', 50, TRUE)
	drain_power(use_energy_cost)

/obj/item/mod/module/pathfinder/proc/recall(mob/recaller)
	if(!implant)
		balloon_alert(recaller, "没有植入体！")
		return FALSE
	if(recaller != implant.imp_in && !allow_suit_activation) // No pAI recalling
		balloon_alert(recaller, "用户无效！")
		return FALSE
	if(mod.open)
		balloon_alert(recaller, "舱盖开启！")
		return FALSE
	if(in_transit)
		balloon_alert(recaller, "套装正在传输！")
		return FALSE
	var/atom_on_turf = get_atom_on_turf(mod)
	if(ismob(atom_on_turf))
		if(atom_on_turf == recaller)
			balloon_alert(recaller, "已经穿在身上了！")
		else
			recaller.balloon_alert(recaller, "套装正被其他人穿着！")
		return FALSE

	in_transit = TRUE
	animate(mod, 0.5 SECONDS, pixel_x = base_pixel_y, pixel_y = base_pixel_y)
	mod.Shake(pixelshiftx = 1, pixelshifty = 1, duration = PATHFINDER_PRE_ANIMATE_TIME)
	addtimer(CALLBACK(src, PROC_REF(do_recall), recaller), PATHFINDER_PRE_ANIMATE_TIME, TIMER_DELETE_ME)

	balloon_alert(recaller, "套装已召回")
	if(!(recaller == mod.wearer))
		balloon_alert(mod.wearer, "套装已召回")
	return TRUE

/// Pod-transport the suit to its owner
/obj/item/mod/module/pathfinder/proc/do_recall(mob/recaller)
	var/container = get_atom_on_turf(mod)
	if(ismob(container))
		balloon_alert(recaller, "发射被打断！")
		in_transit = FALSE
		return

	if(iscloset(container))
		var/obj/structure/closet/closet = container
		if (!closet.opened)
			if (!closet.open())
				playsound(closet, 'sound/effects/bang.ogg', vol = 50, vary = TRUE)
				closet.bust_open()


	mod.add_overlay(jet_icon)
	playsound(mod, 'sound/vehicles/rocketlaunch.ogg', vol = 80, vary = FALSE)
	var/turf/land_target = get_turf(implant.imp_in)
	var/obj/structure/closet/supplypod/pod = podspawn(list(
		"target" = get_turf(mod),
		"path" = /obj/structure/closet/supplypod/transport/module_pathfinder,
		"reverse_dropoff_coords" = list(land_target.x, land_target.y, land_target.z),
	))

	pod.insert(mod, pod)
	RegisterSignal(pod, COMSIG_SUPPLYPOD_RETURNING, PROC_REF(pod_takeoff))

	if (istype(container, /obj/machinery/suit_storage_unit))
		var/obj/machinery/suit_storage_unit/storage = container
		storage.locked = FALSE
		storage.open_machine()

/// Track when pod has taken off so we don't falsely report the initial landing
/obj/item/mod/module/pathfinder/proc/pod_takeoff(datum/pod)
	SIGNAL_HANDLER
	RegisterSignal(pod, COMSIG_SUPPLYPOD_LANDED, PROC_REF(pod_landed))

/// When the pod landed, we can recall again
/obj/item/mod/module/pathfinder/proc/pod_landed()
	SIGNAL_HANDLER
	in_transit = FALSE
	mod.cut_overlay(jet_icon)
	playsound(mod, 'sound/items/handling/toolbox/toolbox_drop.ogg', vol = 80, vary = FALSE)
	if (implant?.imp_in?.Adjacent(src))
		INVOKE_ASYNC(src, PROC_REF(attach), implant.imp_in)

// ###########
// THE INPLANT
// ###########


/obj/item/implant/mod
	name = "MOD 寻路植入体"
	desc = "让你可以随时召回 MOD 模块化外骨骼。"
	actions_types = list(/datum/action/item_action/mod_recall)
	allow_multiple = TRUE // Surgrey is annoying if you loose your MOD
	custom_materials = null
	/// The pathfinder module we are linked to.
	var/obj/item/mod/module/pathfinder/module
	implant_info = "手动激活。植入体所有者可随时召回模块化外骨骼。"
	implant_lore = "MOD 寻路植入体由中村工业公司设计，是 MOD 寻路模块的接收端，\
		被设计为与其配套主机模块一同制造。它应被植入脊柱底部附近：\
		植入到其他任何位置都可能导致配套套装部署错误，或无法启用减速板，\
		而中村工业公司承诺减速板确实存在。"

/obj/item/implant/mod/Initialize(mapload)
	. = ..()
	if(!istype(loc, /obj/item/mod/module/pathfinder))
		return INITIALIZE_HINT_QDEL
	module = loc

/obj/item/implant/mod/Destroy()
	module = null
	return ..()

/datum/action/item_action/mod_recall
	name = "召回 MOD"
	desc = "随时随地召回 MOD 模块化外骨骼。"
	check_flags = AB_CHECK_CONSCIOUS
	background_icon_state = "bg_mod"
	overlay_icon_state = "bg_mod_border"
	button_icon = 'icons/mob/actions/actions_mod.dmi'
	button_icon_state = "recall"
	/// The cooldown for the recall.
	COOLDOWN_DECLARE(recall_cooldown)

/datum/action/item_action/mod_recall/New(Target)
	. = ..()
	if(!istype(Target, /obj/item/implant/mod))
		qdel(src)
		return

/datum/action/item_action/mod_recall/do_effect(trigger_flags)
	var/obj/item/implant/mod/implant = target
	if(!COOLDOWN_FINISHED(src, recall_cooldown))
		implant.balloon_alert(owner, "冷却中！")
		return
	if(implant.module.recall(owner))
		implant.balloon_alert(owner, "套装正在飞来……")
		COOLDOWN_START(src, recall_cooldown, 5 SECONDS)

/// Special pod subtype we use just to make insertion check easy
/obj/structure/closet/supplypod/transport/module_pathfinder

/obj/structure/closet/supplypod/transport/module_pathfinder/insertion_allowed(atom/to_insert)
	return istype(to_insert, /obj/item/mod/control)

#undef PATHFINDER_PRE_ANIMATE_TIME
