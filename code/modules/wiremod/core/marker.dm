/obj/item/multitool/circuit
	name = "电路多功能工具"
	desc = "电路多功能工具。用于标记实体，之后可在端口上按下上传按钮，把标记的实体上传到元件中。 \
	其余功能与普通多功能工具相同。手持使用可清除已标记的实体，以便再标记另一个实体。"
	icon_state = "multitool_circuit"
	apc_scanner = FALSE // would conflict with mark clearing
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

	/// The marked atom of this multitool
	var/atom/marked_atom

/obj/item/multitool/circuit/Destroy()
	marked_atom = null
	return ..()

/obj/item/multitool/circuit/examine(mob/user)
	. = ..()
	. += span_notice("它[marked_atom? "已" : "尚未"]登记标记实体。")

/obj/item/multitool/circuit/attack_self(mob/user, modifiers)
	. = ..()
	if(.)
		return
	if(!marked_atom)
		return

	say("已清除标记目标。")
	clear_marked_atom()
	return TRUE

/obj/item/multitool/circuit/melee_attack_chain(mob/user, atom/target, list/modifiers)
	var/is_right_clicking = LAZYACCESS(modifiers, RIGHT_CLICK)

	if(marked_atom || !user.Adjacent(target) || is_right_clicking)
		return ..()

	if(isliving(target))
		INVOKE_ASYNC(src, PROC_REF(mark_mob_or_contents), user, target)
		return TRUE

	mark_target(target)

/obj/item/multitool/circuit/proc/mark_target(atom/target)
	say("已标记 [target]。")
	marked_atom = target
	RegisterSignal(marked_atom, COMSIG_QDELETING, PROC_REF(cleanup_marked_atom))
	update_icon()
	flick("multitool_circuit_flick", src)
	playsound(src.loc, 'sound/machines/compiler/compiler-stage2.ogg', 30, TRUE)
	return TRUE

/// Allow users to mark items equipped by the target that are visible.
/obj/item/multitool/circuit/proc/mark_mob_or_contents(mob/user, mob/living/target)
	var/list/visible_items
	var/mob/living/carbon/carbon_target
	if(iscarbon(target))
		carbon_target = target
		visible_items = carbon_target.get_visible_items()
	else
		visible_items = target.get_equipped_items(INCLUDE_HELD)

	visible_items -= src // the multitool cannot mark itself.

	if(!length(visible_items))
		mark_target(target)
		return

	var/list/selectable_targets = list()
	var/datum/radial_menu_choice/mob_choice = new
	mob_choice.image = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_mob")
	mob_choice.name = target.name
	selectable_targets[REF(target)] = mob_choice
	for(var/obj/item/item as anything in visible_items)
		//no revealing items that are not obscured but meant to be hidden
		if(HAS_TRAIT(item, TRAIT_NO_STRIP) || HAS_TRAIT(item, TRAIT_EXAMINE_SKIP))
			continue

		var/datum/radial_menu_choice/item_choice = new

		var/mutable_appearance/item_appearance = new(item)
		item_appearance.layer = FLOAT_LAYER
		item_appearance.plane = FLOAT_PLANE

		item_choice.name = item.name
		item_choice.image = item_appearance
		selectable_targets[REF(item)] = item_choice

	var/picked_ref = show_radial_menu(user, src, selectable_targets, radius = 38, custom_check = CALLBACK(src, PROC_REF(check_menu), user, target), tooltips = TRUE)
	if(!picked_ref)
		return

	var/atom/movable/chosen = locate(picked_ref)
	if(chosen == target || (chosen in (carbon_target ? carbon_target.get_visible_items() : target.get_equipped_items(INCLUDE_HELD))))
		mark_target(chosen)
	else
		balloon_alert(user, "无法标记该实体")

/obj/item/multitool/circuit/proc/check_menu(mob/user, mob/living/target)
	return !marked_atom && user.is_holding(src) && user.Adjacent(target)

/obj/item/multitool/circuit/update_overlays()
	. = ..()
	cut_overlays()
	if(marked_atom)
		. += "marked_overlay"

/// Clears the current marked atom
/obj/item/multitool/circuit/proc/clear_marked_atom()
	if(!marked_atom)
		return
	UnregisterSignal(marked_atom, COMSIG_QDELETING)
	marked_atom = null
	update_icon()

/obj/item/multitool/circuit/proc/cleanup_marked_atom(datum/source)
	SIGNAL_HANDLER
	if(source == marked_atom)
		clear_marked_atom()
