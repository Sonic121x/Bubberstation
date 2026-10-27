// Short wooden fences, oh me oh my

/obj/structure/railing/wooden_fencing
	name = "木栅栏"
	desc = "一道简易木栅栏，用来把你这样的人关在里面，或拦在外面。"
	icon = 'modular_skyrat/modules/primitive_structures/icons/wooden_fence.dmi'
	icon_state = "fence"
	layer = BELOW_OBJ_LAYER // I think this is the default but lets be safe?
	resistance_flags = FLAMMABLE
	flags_1 = ON_BORDER_1
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 5)
	/// If we randomize our icon on spawning
	var/random_icons = TRUE

/obj/structure/railing/wooden_fencing/Initialize(mapload)
	. = ..()
	if(!random_icons)
		return
	icon_state = pick(
		"fence",
		"fence_2",
		"fence_3",
	)
	update_appearance()

// previously NO_DECONSTRUCTION
/obj/structure/railing/wooden_fencing/wirecutter_act(mob/living/user, obj/item/I)
	return NONE

// Fence gates for the above mentioned fences

/obj/structure/railing/wooden_fencing/gate
	name = "木栅栏门"
	desc = "一扇简易木门，用来防止你这样的动物逃出去。"
	icon_state = "gate"
	random_icons = FALSE
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 5)
	/// Has the gate been opened or not?
	var/opened = FALSE

/obj/structure/railing/wooden_fencing/gate/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	return open_or_close(user)

/// Proc that checks if the gate is open or not, then closes/opens the gate repsectively
/obj/structure/railing/wooden_fencing/gate/proc/open_or_close(mob/user)
	if(!user.can_interact_with(src))
		balloon_alert(user, "无法操作")
		return
	opened = !opened
	set_density(!opened)
	icon_state = "[opened ? "gate_open" : "gate"]"
	playsound(src, (opened ? 'sound/machines/closet/wooden_closet_open.ogg' : 'sound/machines/closet/wooden_closet_close.ogg'), 100, TRUE)
	update_appearance()

/obj/structure/railing/wooden_fencing/gate/update_icon()
	. = ..()
	if(!opened)
		return

// Large wooden gate, used for big doors or entrances to camps

/obj/structure/mineral_door/wood/large_gate
	name = "大型木门"
	icon = 'modular_skyrat/modules/primitive_structures/icons/wooden_gate.dmi'
	icon_state = "gate"
	openSound = 'sound/machines/closet/wooden_closet_open.ogg'
	closeSound = 'sound/machines/closet/wooden_closet_close.ogg'

/obj/structure/mineral_door/wood/large_gate/Open()
	playsound(src, openSound, 100, TRUE)
	set_opacity(FALSE)
	set_density(FALSE)
	door_opened = TRUE
	layer = OPEN_DOOR_LAYER
	air_update_turf(TRUE, FALSE)
	update_appearance()

/obj/structure/mineral_door/wood/large_gate/Close()
	if(!door_opened)
		return
	for(var/mob/living/blocking_mob in get_turf(src))
		return
	playsound(src, closeSound, 100, TRUE)
	set_density(TRUE)
	set_opacity(TRUE)
	door_opened = FALSE
	layer = initial(layer)
	air_update_turf(TRUE, TRUE)
	update_appearance()

/obj/structure/mineral_door/wood/large_gate/update_icon()
	. = ..()
	if(!door_opened)
		return
	if(dir == EAST)
		layer = ABOVE_MOB_LAYER
	else
		layer = initial(layer)
