/**
 * # Compact Remote
 *
 * A handheld device with one big button.
 */
/obj/item/compact_remote
	name = "紧凑遥控器"
	icon = 'icons/obj/science/circuits.dmi'
	icon_state = "setup_small_simple"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_on = FALSE
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT)

/obj/item/compact_remote/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/shell, list(
		new /obj/item/circuit_component/compact_remote()
	), SHELL_CAPACITY_SMALL)

/obj/item/circuit_component/compact_remote
	display_name = "紧凑遥控器"
	desc = "用于接收紧凑遥控器外壳传来的输入。手持外壳使用即可触发输出信号。"

	/// Called when attack_self is called on the shell.
	var/datum/port/output/signal
	/// The user who used the bot
	var/datum/port/output/entity

/obj/item/circuit_component/compact_remote/populate_ports()
	entity = add_output_port("User", PORT_TYPE_ATOM)
	signal = add_output_port("Signal", PORT_TYPE_SIGNAL)

/obj/item/circuit_component/compact_remote/register_shell(atom/movable/shell)
	RegisterSignal(shell, COMSIG_ITEM_ATTACK_SELF, PROC_REF(send_trigger))

/obj/item/circuit_component/compact_remote/unregister_shell(atom/movable/shell)
	UnregisterSignal(shell, COMSIG_ITEM_ATTACK_SELF)

/**
 * Called when the shell item is used in hand.
 */
/obj/item/circuit_component/compact_remote/proc/send_trigger(atom/source, mob/user)
	SIGNAL_HANDLER
	source.balloon_alert(user, "按下了主按钮")
	playsound(source, SFX_TERMINAL_TYPE, 25, FALSE)
	entity.set_output(user)
	signal.set_output(COMPONENT_SIGNAL)
