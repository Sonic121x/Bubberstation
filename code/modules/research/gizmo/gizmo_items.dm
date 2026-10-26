/// A handheld gizmo, with some different activation modes
/obj/item/gizmo
	name = "小装置"
	desc = "当装置的烤箱热起来时，它会把吉格给弗利格了。"
	icon = 'icons/obj/science/gizmos.dmi'

	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF

	/// Possible icon states
	var/list/icon_states = list("gizmo_item_1")
	/// Reference to the gizmo master controller that handles all the other gizmo stuff
	var/datum/gizmo_controller/controller = /datum/gizmo_controller/item

/obj/item/gizmo/Initialize(mapload)
	. = ..()

	if(icon_states)
		base_icon_state = pick(icon_states)
		icon_state = base_icon_state

	controller = new controller(src)
	controller.generate_interfaces(src)

/obj/item/gizmo/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	add_fingerprint(user)

	if(is_wire_tool(tool))
		attempt_wire_interaction(user)
		return ITEM_INTERACT_SUCCESS
	return NONE

/// Hard-mode code-crack gizmo
/obj/item/gizmo/moo
	controller = /datum/gizmo_controller/moo
