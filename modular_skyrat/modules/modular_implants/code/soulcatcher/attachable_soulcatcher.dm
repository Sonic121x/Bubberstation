/datum/component/carrier/soulcatcher/small_device
	max_mobs = 1

/datum/component/carrier/soulcatcher/attachable
	max_mobs = 1
	communicate_as_parent = TRUE
	removable = TRUE

/datum/component/carrier/soulcatcher/attachable/New()
	. = ..()
	var/obj/item/parent_item = parent
	if(!istype(parent_item))
		return COMPONENT_INCOMPATIBLE

	name = parent_item.name
	var/datum/carrier_room/first_room = carrier_rooms[1]
	first_room.name = parent_item.name
	first_room.room_description = parent_item.desc

	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT, PROC_REF(bring_up_ui))
	RegisterSignal(parent, COMSIG_PREQDELETED, PROC_REF(remove_self))

/// Adds text to the examine text of the parent item, explaining that the item can be used to enable the use of NIFSoft HUDs
/datum/component/carrier/soulcatcher/attachable/proc/on_examine(datum/source, mob/user, list/examine_text)
	SIGNAL_HANDLER
	examine_text += span_cyan("[source] 上附着一个灵魂捕手，<b>Ctrl+Shift+点击</b>即可使用。")

/datum/component/carrier/soulcatcher/attachable/proc/bring_up_ui(datum/source, mob/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(ui_interact), user)

/datum/component/carrier/soulcatcher/attachable/Destroy(force)
	UnregisterSignal(parent, COMSIG_ATOM_EXAMINE)
	UnregisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT)
	UnregisterSignal(parent, COMSIG_PREQDELETED)
	return ..()

/datum/component/carrier/soulcatcher/attachable/remove_self()
	var/obj/item/parent_item = parent
	var/turf/drop_turf = get_turf(parent_item)
	var/obj/item/attachable_soulcatcher/dropped_item = new (drop_turf)

	var/datum/component/carrier/dropped_soulcatcher = dropped_item.GetComponent(/datum/component/carrier)
	var/datum/carrier_room/target_room = dropped_soulcatcher.carrier_rooms[1]
	var/list/current_mobs = get_current_mobs()

	if(current_mobs) // If we have souls inside of here, they should be transferred to the new object
		for(var/mob/living/soul as anything in current_mobs)
			transfer_mob(soul, target_room)

	return ..()

/obj/item/attachable_soulcatcher
	name = "骚灵型 RSD"
	desc = "这台装置是一张可变形纳米机器网，能包裹大多数尺寸的物体，使其成为承载共鸣的容器。容器中的灵魂会像身处躯体或普通灵魂捕手中那样被灌注，能够感知世界，甚至通过新的形态开口说话。装置的纳米机器网让意识可以一定程度上操纵其容器，但任何大幅度的移动都是不可能的。"
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "attachable-soulcatcher"
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT
		)
	/// Do we want to destory the item once it is attached to an item?
	var/destroy_on_use = TRUE
	/// What items do we want to prevent the viewer from attaching this to?
	var/list/blacklisted_items = list(
		/obj/item/organ,
		/obj/item/brain_processor,
		/obj/item/pai_card,
		/obj/item/aicard,
		/obj/item/card,
		/obj/item/radio,
		/obj/item/disk/nuclear, // Woah there
	)
	/// What soulcathcer component is currnetly linked to this object?
	var/datum/component/carrier/soulcatcher/small_device/linked_soulcatcher

/obj/item/attachable_soulcatcher/Initialize(mapload)
	. = ..()
	linked_soulcatcher = AddComponent(/datum/component/carrier/soulcatcher/small_device)
	linked_soulcatcher.name = name

/obj/item/attachable_soulcatcher/attack_self(mob/user, modifiers)
	linked_soulcatcher.ui_interact(user)

/obj/item/attachable_soulcatcher/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isitem(interacting_with) || is_type_in_list(interacting_with, blacklisted_items))
		balloon_alert(user, "不兼容！")
		return NONE

	if(interacting_with.GetComponent(/datum/component/carrier/soulcatcher))
		balloon_alert(user, "已经附着过了！")
		return ITEM_INTERACT_BLOCKING

	var/datum/component/carrier/soulcatcher/new_soulcatcher = interacting_with.AddComponent(/datum/component/carrier/soulcatcher/attachable)
	playsound(interacting_with.loc, 'sound/items/weapons/circsawhit.ogg', 50, vary = TRUE)

	var/datum/carrier_room/target_room = new_soulcatcher.carrier_rooms[1]
	var/list/current_mobs = linked_soulcatcher.get_current_mobs()
	if(current_mobs)
		for(var/mob/living/soul as anything in current_mobs)
			linked_soulcatcher.transfer_mob(soul, target_room)

	if(destroy_on_use)
		qdel(src)
