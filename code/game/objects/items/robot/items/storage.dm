/obj/item/borg/apparatus
	name = "未知储存装置"
	desc = "这个装置似乎无法使用。"
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "hugmodule"
	/// The item stored inside of this apparatus
	var/obj/item/stored
	/// Whitelist of types allowed in this apparatus
	var/list/storable = list()

/obj/item/borg/apparatus/Initialize(mapload)
	RegisterSignal(loc.loc, COMSIG_BORG_SAFE_DECONSTRUCT, PROC_REF(safedecon))
	return ..()

/obj/item/borg/apparatus/Destroy()
	QDEL_NULL(stored)
	return ..()

///If we're safely deconstructed, we put the item neatly onto the ground, rather than deleting it.
/obj/item/borg/apparatus/proc/safedecon()
	SIGNAL_HANDLER

	if(stored)
		stored.forceMove(get_turf(src))
		stored = null

/obj/item/borg/apparatus/Exited(atom/movable/gone, direction)
	if(gone == stored) //sanity check
		UnregisterSignal(stored, COMSIG_ATOM_UPDATED_ICON)
		stored = null
	update_appearance()
	return ..()

///A right-click verb, for those not using hotkey mode.
GAME_VERB(/obj/item/borg/apparatus, verb_dropHeld, "放下", null)

	if(usr != loc || !stored)
		return
	stored.forceMove(get_turf(usr))
	return

/obj/item/borg/apparatus/get_proxy_attacker_for(atom/target, mob/user)
	if(stored) // Use the stored item if available
		return stored
	return ..()

/**
* Attack_self will pass for the stored item.
*/
/obj/item/borg/apparatus/attack_self(mob/living/silicon/robot/user)
	if(!stored || !issilicon(user))
		return ..()
	stored.attack_self(user)

//Alt click drops the stored item.
/obj/item/borg/apparatus/click_alt(mob/living/silicon/robot/user)
	if(!stored || !issilicon(user))
		return CLICK_ACTION_BLOCKING
	stored.forceMove(user.drop_location())
	return CLICK_ACTION_SUCCESS

/obj/item/borg/apparatus/pre_attack(atom/atom, mob/living/user, list/modifiers, list/attack_modifiers)
	if(istype(atom.loc, /mob/living/silicon/robot) || istype(atom.loc, /obj/item/robot_model) || HAS_TRAIT(atom, TRAIT_NODROP))
		return ..() // Borgs should not be grabbing their own modules

	var/itemcheck = FALSE
	for(var/storable_type in storable)
		if(istype(atom, storable_type))
			itemcheck = TRUE
			break
	if(itemcheck)
		var/obj/item/item = atom
		item.pixel_x = 0
		item.pixel_y = 0
		item.forceMove(src)
		stored = item
		RegisterSignal(stored, COMSIG_ATOM_UPDATED_ICON, PROC_REF(on_stored_updated_icon))
		update_appearance()
		return TRUE
	return ..()

/**
 * Updates the appearance of the apparatus when the stored object's icon gets updated.
 *
 * Returns NONE as we have not done anything to the stored object itself,
 * which is where this signal that this handler intercepts is sent from.
 */
/obj/item/borg/apparatus/proc/on_stored_updated_icon(datum/source, updates)
	SIGNAL_HANDLER
	update_appearance()
	return NONE

/obj/item/borg/apparatus/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!stored)
		return NONE
	tool.melee_attack_chain(user, stored, modifiers)
	return ITEM_INTERACT_SUCCESS

/obj/item/borg/apparatus/beaker
	name = "烧杯储存装置"
	desc = "一种特殊装置，可携带烧杯、瓶子与试管而不会洒出其中的内容物。"
	icon_state = "borg_beaker_apparatus"
	storable = list(
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
	)

/obj/item/borg/apparatus/beaker/Initialize(mapload)
	add_glass()
	RegisterSignal(stored, COMSIG_ATOM_UPDATED_ICON, PROC_REF(on_stored_updated_icon))
	update_appearance()
	return ..()

/obj/item/borg/apparatus/beaker/proc/add_glass()
	stored = new /obj/item/reagent_containers/cup/beaker/large(src)

/obj/item/borg/apparatus/beaker/Destroy()
	QDEL_NULL(stored)
	return ..()

/obj/item/borg/apparatus/beaker/examine()
	. = ..()
	if(stored)
		var/obj/item/reagent_containers/reagent_container = stored
		. += "装置目前固定着[reagent_container]，其中含有："
		if(length(reagent_container.reagents.reagent_list))
			for(var/datum/reagent/reagent in reagent_container.reagents.reagent_list)
				. += "[reagent.volume] 单位的[reagent.name]"
		else
			. += "无。"

	. += span_notice(" <i>按住 Alt 点击</i>可丢下当前储存的烧杯。 ")

/obj/item/borg/apparatus/beaker/update_overlays()
	. = ..()
	var/mutable_appearance/arm = mutable_appearance(icon = icon, icon_state = "borg_beaker_apparatus_arm")
	if(stored)
		stored.pixel_w = 0
		stored.pixel_z = 0
		var/mutable_appearance/stored_copy = new /mutable_appearance(stored)
		if(istype(stored, /obj/item/reagent_containers/cup/beaker))
			arm.pixel_z -= 3
		stored_copy.layer = FLOAT_LAYER
		stored_copy.plane = FLOAT_PLANE
		. += stored_copy
	else
		arm.pixel_z -= 5
	. += arm

/obj/item/borg/apparatus/beaker/extra
	name = "次级烧杯储存装置"
	desc = "一种辅助用的烧杯储存装置。"

/obj/item/borg/apparatus/beaker/service
	name = "饮料储存装置"
	desc = "一种特殊装置，可携带饮品与调料包而不会洒出其中的内容物。你从杯子里倒出的任何饮品（或其他营养液体）都会被重新合成！"
	icon_state = "borg_beaker_apparatus"
	storable = list(
		/obj/item/reagent_containers/cup/glass,
		/obj/item/reagent_containers/condiment,
		/obj/item/reagent_containers/cup/coffeepot,
		/obj/item/reagent_containers/cup/bottle/syrup_bottle,
	)

/obj/item/borg/apparatus/beaker/service/add_glass()
	stored = new /obj/item/reagent_containers/cup/glass/drinkingglass(src)
	handle_reflling(stored, loc.loc, force = TRUE)

/obj/item/borg/apparatus/beaker/service/proc/handle_reflling(obj/item/reagent_containers/cup/glass, mob/living/silicon/robot/bro, force = FALSE)
	if (isnull(bro))
		bro = loc
	if (!iscyborg(bro))
		return

	if (!stored || force)
		glass.AddComponent(/datum/component/reagent_refiller, power_draw_callback = CALLBACK(bro, TYPE_PROC_REF(/mob/living/silicon/robot, draw_power)))

/obj/item/borg/apparatus/beaker/service/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if (!istype(arrived, /obj/item/reagent_containers/cup/glass))
		return
	handle_reflling(arrived)
	return ..()

///Used by the service borg drink apparatus upgrade, holds drink-related items
/obj/item/borg/apparatus/beaker/drink
	name = "次级饮料储存装置"
	desc = "一种特殊装置，可携带饮品与调料包而不会洒出其中的内容物。与你的标准装置不同，它不会重新合成饮品。"
	icon_state = "borg_beaker_apparatus"
	storable = list(
		/obj/item/reagent_containers/cup/glass,
		/obj/item/reagent_containers/condiment,
		/obj/item/reagent_containers/cup/coffeepot,
		/obj/item/reagent_containers/cup/bottle/syrup_bottle,
		/obj/item/reagent_containers/cup/beaker,
	)

/obj/item/borg/apparatus/beaker/service2/add_glass()
	stored = new /obj/item/reagent_containers/cup/glass/drinkingglass(src)

/// allows medical cyborgs to manipulate organs without hands
/obj/item/borg/apparatus/organ_storage
	name = "器官储存袋"
	desc = "用于存放身体部位的容器。"
	icon = 'icons/obj/storage/storage.dmi'
	icon_state = "evidenceobj"
	item_flags = SURGICAL_TOOL
	storable = list(/obj/item/organ,
					/obj/item/bodypart)
	/// Underlay of whatever we have stored
	var/image/stored_underlay

/obj/item/borg/apparatus/organ_storage/update_overlays()
	. = ..()
	if(stored_underlay)
		underlays -= stored_underlay
	if(!stored)
		return
	stored_underlay = image(stored)
	stored_underlay.layer = FLOAT_LAYER
	stored_underlay.plane = FLOAT_PLANE
	stored_underlay.pixel_w = 0
	stored_underlay.pixel_x = 0
	stored_underlay.pixel_y = 0
	stored_underlay.pixel_z = 0
	underlays += stored_underlay

/obj/item/borg/apparatus/organ_storage/examine()
	. = ..()
	. += "器官袋目前装有："
	if(stored)
		var/obj/item/organ = stored
		. += organ.name
	else
		. += "无。"
	. += span_notice(" <i>按住 Alt 点击</i>可丢下当前储存的器官。 ")

/obj/item/borg/apparatus/organ_storage/click_alt(mob/living/silicon/robot/user)
	if(!stored)
		to_chat(user, span_notice("[src]是空的。"))
		return CLICK_ACTION_BLOCKING

	var/obj/item/organ = stored
	user.visible_message(span_notice("[user]把[organ]从[src]里倒了出来。"), span_notice("你把[organ]从[src]里倒了出来。"))
	organ.forceMove(drop_location())
	return CLICK_ACTION_SUCCESS

///Apparatus to allow Engineering/Sabo borgs to manipulate any material sheets.
/obj/item/borg/apparatus/sheet_manipulator
	name = "材料操作装置"
	desc = "用于携带、铺设和操作材料板的装置。该设备还能携带定制地砖和各种杆件。"
	icon_state = "borg_stack_apparatus"
	storable = list(/obj/item/stack/sheet,
					/obj/item/stack/tile,
					/obj/item/stack/rods,
					/obj/item/stack/conveyor)

/obj/item/borg/apparatus/sheet_manipulator/Initialize(mapload)
	update_appearance()
	return ..()

/obj/item/borg/apparatus/sheet_manipulator/update_overlays()
	. = ..()
	var/mutable_appearance/arm = mutable_appearance(icon, "borg_stack_apparatus_arm1")
	if(stored)
		stored.pixel_w = 0
		stored.pixel_z = 0
		arm.icon_state = "borg_stack_apparatus_arm2"
		var/mutable_appearance/stored_copy = new /mutable_appearance(stored)
		var/underscore = findtext(stored_copy.icon_state, "_")
		if(underscore)
			stored_copy.icon_state = initial(stored.icon_state) //how we use the icon_state of single sheets, even with full stacks
		stored_copy.layer = FLOAT_LAYER
		stored_copy.plane = FLOAT_PLANE
		. += stored_copy
	. += arm

/obj/item/borg/apparatus/sheet_manipulator/examine()
	. = ..()
	if(stored)
		. += "装置目前固定着[stored]。"
	. += span_notice(" <i>按住 Alt 点击</i>可丢下当前储存的材料板。 ")

///Apparatus allowing Engineer/Sabo borgs to manipulate circuit boards and more
/obj/item/borg/apparatus/engineering
	name = "工程装置"
	desc = "一种特殊装置，可携带和操作电路板、灯具与电池。"
	icon_state = "borg_hardware_apparatus"
	storable = list(
		/obj/item/circuitboard,
		/obj/item/electronics,
		/obj/item/stock_parts/power_store,
		/obj/item/light,
		/obj/item/conveyor_switch_construct,
	)

/obj/item/borg/apparatus/engineering/Initialize(mapload)
	update_appearance()
	return ..()

/obj/item/borg/apparatus/engineering/update_overlays()
	. = ..()
	var/mutable_appearance/arm = mutable_appearance(icon, "borg_hardware_apparatus_arm1")
	if(stored)
		stored.pixel_w = -3
		stored.pixel_z = 0
		if(!istype(stored, /obj/item/circuitboard))
			arm.icon_state = "borg_hardware_apparatus_arm2"
		else if(istype(stored, /obj/item/circuitboard || /obj/item/stock_parts/power_store))
			stored.pixel_w = -5
			stored.pixel_z = 2
			arm.icon_state = "borg_hardware_apparatus_arm1"
		var/mutable_appearance/stored_copy = new /mutable_appearance(stored)
		stored_copy.layer = FLOAT_LAYER
		stored_copy.plane = FLOAT_PLANE
		. += stored_copy
	. += arm

/obj/item/borg/apparatus/engineering/examine()
	. = ..()
	if(stored)
		. += "装置目前固定着[stored]。"
	. += span_notice(" <i>按住 Alt 点击</i>可丢下当前储存的物品。 ")

/obj/item/borg/apparatus/engineering/pre_attack(atom/atom, mob/living/user, list/modifiers, list/attack_modifiers)
	if(istype(atom, /obj/item/ai_module/law) && !stored) //If an admin wants a borg to upload laws, who am I to stop them? Otherwise, we can hint that it fails
		to_chat(user, span_warning("这块电路板似乎没有标准机器人装置所需的针孔。你无法把它拿起来。"))
		return TRUE
	return ..()

// stops them from cell interactions with other borgos
/obj/item/borg/apparatus/engineering/interact_with_atom(atom/movable/interacting_with, mob/living/user, list/modifiers)
	if(iscyborg(user) && iscyborg(interacting_with))
		balloon_alert(user, "你的机械臂不够灵活，无法正确地操作这个。")
		return ITEM_INTERACT_FAILURE

/obj/item/borg/apparatus/service
	name = "服务装置"
	desc = "一种特殊装置，可携带食物、种子、嫁接枝条、碗、盘子、烤箱托盘、汤锅和纸张。"
	icon_state = "borg_service_apparatus"
	storable = list(
		/obj/item/food,
		/obj/item/paper,
		/obj/item/plate,
		/obj/item/plate/oven_tray,
		/obj/item/reagent_containers/cup/bowl,
		/obj/item/reagent_containers/cup/soup_pot,
		/obj/item/seeds,
		/obj/item/graft,
	)

/obj/item/borg/apparatus/service/Initialize(mapload)
	update_appearance()
	return ..()

/obj/item/borg/apparatus/service/update_overlays()
	. = ..()
	var/mutable_appearance/arm = mutable_appearance(icon, "borg_hardware_apparatus_arm1")
	if(stored)
		stored.pixel_w = -3
		stored.pixel_z = 0
		if((!istype(stored, /obj/item/plate/oven_tray)) || (!istype(stored, /obj/item/food)))
			arm.icon_state = "borg_hardware_apparatus_arm2"
		var/mutable_appearance/stored_copy = new /mutable_appearance(stored)
		stored_copy.layer = FLOAT_LAYER
		stored_copy.plane = FLOAT_PLANE
		. += stored_copy
	. += arm

/obj/item/borg/apparatus/service/examine()
	. = ..()
	if(stored)
		. += "装置目前固定着[stored]。"
	. += span_notice("<i>按住 Alt 点击</i>可丢下当前固定的物品。")
