//Credit to Beestation for the original anesthetic machine code: https://github.com/BeeStation/BeeStation-Hornet/pull/3753

/obj/structure/closet/secure_closet/medical2/Initialize(mapload)
	. = ..()
	new /obj/machinery/breath_machine/anesthetic(loc)
	new /obj/machinery/breath_machine/anesthetic(loc)
	qdel(src)

/obj/machinery/breath_machine
	name = "便携式呼吸机"
	desc = "一个带轮子的支架，配有类似输液架的数字调节器，可同时放置一个气罐和一副防毒面具。<br>人类用 N2、Vox 用 N2O 来着？还是反了？O2 又是什么？反正我又不是医生。"
	icon = 'modular_zubbers/icons/obj/medical/breath_machine.dmi'
	icon_state = "breath_machine"
	anchored = FALSE
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	use_power = NO_POWER_USE
	/// The mask attached to the breath machine
	var/obj/item/clothing/mask/breath/machine/attached_mask
	/// the tank attached to the breath machine, by default it does not come with one.
	var/obj/item/tank/attached_tank = null
	/// Is the attached mask currently out?
	var/mask_out = FALSE

/obj/machinery/breath_machine/anesthetic
	attached_tank = new /obj/item/tank/internals/anesthetic

/obj/machinery/breath_machine/examine(mob/user)
	. = ..()

	. += "若未安装气罐，用扳手<b>右键</b>可拆解这个支架。"
	if(mask_out)
		. += "若面罩已展开，<b>点击</b>支架可将其收回。"
	if(attached_tank)
		. += "<b>Alt + 点击</b>可取下 [attached_tank]。"

/obj/machinery/breath_machine/Initialize(mapload)
	. = ..()
	attached_mask = new /obj/item/clothing/mask/breath/machine(src)
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/breath_machine/wrench_act_secondary(mob/living/user, obj/item/tool)
	if(user.combat_mode)
		return ..()

	if(mask_out)
		to_chat(user, span_warning("目前有人连接在 [src] 上！"))
		return TRUE

	if(attached_tank)
		to_chat(user, span_warning("必须先取下 [src] 上的 [attached_tank]！"))
		return TRUE

	new /obj/item/breath_machine_kit(get_turf(src))
	tool.play_tool_sound(user)
	to_chat(user, span_notice("你拆解了 [src]。"))
	qdel(src)
	return TRUE

/obj/machinery/breath_machine/update_overlays()
	. = ..()
	var/static/generic_overlay
	var/static/anesthetic_overlay
	var/static/oxygen_overlay
	var/static/nitrogen_overlay
	var/static/on_overlay
	var/static/off_overlay
	if(isnull(generic_overlay))
		generic_overlay = iconstate2appearance(icon, "tank_generic")
		anesthetic_overlay = iconstate2appearance(icon, "tank_anesthetic")
		oxygen_overlay = iconstate2appearance(icon, "tank_oxygen")
		nitrogen_overlay = iconstate2appearance(icon, "tank_nitrogen")
		on_overlay = iconstate2appearance(icon, "mask_on")
		off_overlay = iconstate2appearance(icon, "mask_off")

	cut_overlays()

	if(attached_tank)
		if(istype(attached_tank, /obj/item/tank/internals/anesthetic))
			add_overlay(anesthetic_overlay)
		else if(istype(attached_tank, /obj/item/tank/internals/oxygen))
			add_overlay(oxygen_overlay)
		else if(istype(attached_tank, /obj/item/tank/internals/nitrogen))
			add_overlay(nitrogen_overlay)
		else
			add_overlay(generic_overlay)

	if(mask_out)
		add_overlay(off_overlay)
	else
		add_overlay(on_overlay)

/obj/machinery/breath_machine/attack_hand(mob/living/user)
	. = ..()
	if(!retract_mask())
		return FALSE
	visible_message(span_notice("[user] 将 [attached_mask] 收回 [src] 中。"))

/obj/machinery/breath_machine/attackby(obj/item/attacking_item, mob/user, params)
	if(!istype(attacking_item, /obj/item/tank))
		return ..()

	if(attached_tank) // If there is an attached tank, remove it and drop it on the floor
		attached_tank.forceMove(loc)

	attacking_item.forceMove(src) // Put new tank in, set it as attached tank
	visible_message(span_notice("[user] 将 [attacking_item] 放入 [src] 中。"))
	attached_tank = attacking_item
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/breath_machine/click_alt(mob/user)
	if(!attached_tank)
		return CLICK_ACTION_BLOCKING

	attached_tank.forceMove(loc)
	to_chat(user, span_notice("你取下了 [attached_tank]。"))
	attached_tank = null
	update_appearance(UPDATE_OVERLAYS)
	if(mask_out)
		retract_mask()
	return CLICK_ACTION_SUCCESS

///Retracts the attached_mask back into the machine
/obj/machinery/breath_machine/proc/retract_mask()
	if(!mask_out)
		return FALSE

	if(iscarbon(attached_mask.loc)) // If mask is on a mob
		var/mob/living/carbon/attached_mob = attached_mask.loc
		// Close external air tank
		if (attached_mob.external)
			attached_mob.close_externals()
		attached_mob.transferItemToLoc(attached_mask, src, TRUE)
	else
		attached_mask.forceMove(src)

	mask_out = FALSE
	update_appearance(UPDATE_OVERLAYS)
	return TRUE

/obj/machinery/breath_machine/mouse_drop_dragged(mob/living/carbon/target, mob/user, src_location, over_location, params)
	. = ..()
	if(!istype(target))
		return

	if((!Adjacent(target)) || !(user.Adjacent(target)))
		return FALSE

	if(!attached_tank || mask_out)
		to_chat(user, span_warning("[mask_out ? "机器正在使用中！" : "机器没有连接气罐！"]"))
		return FALSE

	// if we somehow lost the mask, let's just make a brand new one. the wonders of technology!
	if(QDELETED(attached_mask))
		attached_mask = new /obj/item/clothing/mask/breath/machine(src)
		update_appearance(UPDATE_OVERLAYS)

	user.visible_message(span_warning("[user] 试图将 [attached_mask] 戴到 [target] 上。"), span_notice("你试图将 [attached_mask] 戴到 [target] 上"))
	if(!do_after(user, 5 SECONDS, target))
		return
	if(!target.equip_to_appropriate_slot(attached_mask))
		to_chat(user, span_warning("你无法将 [attached_mask] 戴到 [target] 上！"))
		return

	user.visible_message(span_warning("[user] 将 [attached_mask] 戴到了 [target] 上。"), span_notice("你将 [attached_mask] 戴到了 [target] 上"))

	// Open the tank externally
	target.open_internals(attached_tank, is_external = TRUE)
	mask_out = TRUE
	START_PROCESSING(SSmachines, src)
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/breath_machine/process()
	if(!mask_out) // If not on someone, stop processing
		return PROCESS_KILL

	var/mob/living/carbon/carbon_target = attached_mask.loc
	if(get_dist(src, get_turf(attached_mask)) > 1) // If too far away, detach
		to_chat(carbon_target, span_warning("[attached_mask] 从你脸上被扯了下来！"))
		retract_mask()
		return PROCESS_KILL

	// Attempt to restart airflow if it was temporarily interrupted after mask adjustment.
	if(attached_tank && istype(carbon_target) && !carbon_target.external && !attached_mask.up)
		carbon_target.open_internals(attached_tank, is_external = TRUE)

/obj/machinery/breath_machine/Destroy()
	if(mask_out)
		retract_mask()

	if(attached_tank)
		attached_tank.forceMove(loc)
		attached_tank = null

	QDEL_NULL(attached_mask)
	return ..()

/// This a special version of the breath mask used for the breath machine.
/obj/item/clothing/mask/breath/machine
	/// What machine is the mask currently attached to?
	var/datum/weakref/attached_machine

/obj/item/clothing/mask/breath/machine/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

	// Make sure we are not spawning outside of a machine
	if(istype(loc, /obj/machinery/breath_machine))
		attached_machine = WEAKREF(loc)

	var/obj/machinery/breath_machine/our_machine
	if(attached_machine)
		our_machine = attached_machine.resolve()

	if(!our_machine)
		attached_machine = null
		if(mapload)
			stack_trace("Abstract, undroppable item [name] spawned at ([loc]) at [AREACOORD(src)] in \the [get_area(src)]. \
				Please remove it. This item should only ever be created by the breath machine.")
		return INITIALIZE_HINT_QDEL

/obj/item/clothing/mask/breath/machine/Destroy()
	attached_machine = null
	return ..()

/obj/item/clothing/mask/breath/machine/dropped(mob/user)
	. = ..()

	if(isnull(attached_machine))
		return

	var/obj/machinery/breath_machine/our_machine = attached_machine.resolve()
	// no machine, then delete it
	if(!our_machine)
		attached_machine = null
		qdel(src)
		return

	if(loc != our_machine) //If it isn't in the machine, then it retracts when dropped
		to_chat(user, span_notice("[src] 缩回了 [our_machine] 中。"))
		our_machine.retract_mask()

/obj/item/clothing/mask/breath/machine/adjust_visor(mob/living/carbon/user)
	. = ..()
	// Air only goes through the mask, so temporarily pause airflow if mask is getting adjusted.
	// Since the mask is NODROP, the only possible user is the wearer
	var/mob/living/carbon/carbon_target = loc
	if(up && carbon_target.external)
		carbon_target.close_externals()

/// A boxed version of the breath Machine. This is what is printed from the medical prolathe.
/obj/item/breath_machine_kit
	name = "呼吸支架零件套装"
	desc = "包含组装便携式呼吸支架所需的全部零件。拿在手中使用即可组装。"
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/obj/storage/box.dmi'
	icon_state = "plasticbox"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)

/obj/item/breath_machine_kit/attack_self(mob/user)
	new /obj/machinery/breath_machine(user.loc)

	playsound(get_turf(user), 'sound/items/weapons/circsawhit.ogg', 50, TRUE)
	qdel(src)
