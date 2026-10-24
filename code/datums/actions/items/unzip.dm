/datum/action/item_action/zipper
	name = "拉开行李袋"
	desc = "拉开所装备行李袋的拉链，以便取用里面的物品。"

/datum/action/item_action/zipper/New(Target)
	. = ..()
	RegisterSignal(target, COMSIG_DUFFEL_ZIP_CHANGE, PROC_REF(on_zip_change))
	var/obj/item/storage/backpack/duffelbag/duffle_target = target
	on_zip_change(target, duffle_target.zipped_up)

/datum/action/item_action/zipper/proc/on_zip_change(datum/source, new_zip)
	SIGNAL_HANDLER
	if(new_zip)
		name = "拉开拉链"
		desc = "拉开所装备行李袋的拉链，以便取用里面的物品。"
	else
		name = "拉上拉链"
		desc = "拉上所装备行李袋的拉链，让你移动得更快。"
	build_all_button_icons(UPDATE_BUTTON_NAME)
