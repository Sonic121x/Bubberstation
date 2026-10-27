/**
 * # Target Intercept Component
 *
 * When activated intercepts next click and outputs clicked atom.
 * Requires a BCI shell.
 */

/obj/item/circuit_component/target_intercept
	display_name = "脑机接口目标截取器"
	desc = "需要脑机接口外壳。激活后，使用者可以用大脑指定一个物体，元件会输出该物体的引用。"
	category = "脑机接口"

	required_shells = list(/obj/item/organ/cyberimp/bci)

	var/datum/port/output/clicked_atom

	var/obj/item/organ/cyberimp/bci/bci
	var/intercept_cooldown = 1 SECONDS

/obj/item/circuit_component/target_intercept/populate_ports()
	trigger_input = add_input_port("Activate", PORT_TYPE_SIGNAL)
	trigger_output = add_output_port("Triggered", PORT_TYPE_SIGNAL)
	clicked_atom = add_output_port("Targeted Object", PORT_TYPE_ATOM)

/obj/item/circuit_component/target_intercept/register_shell(atom/movable/shell)
	if(istype(shell, /obj/item/organ/cyberimp/bci))
		bci = shell
		RegisterSignal(shell, COMSIG_ORGAN_REMOVED, PROC_REF(on_organ_removed))

/obj/item/circuit_component/target_intercept/unregister_shell(atom/movable/shell)
	bci = null
	UnregisterSignal(shell, COMSIG_ORGAN_REMOVED)

/obj/item/circuit_component/target_intercept/input_received(datum/port/input/port)
	if(!bci)
		return

	if(!parent.shell)
		return

	var/mob/living/owner = bci.owner
	if(!owner || !istype(owner) || !owner.client || IS_UNCONSCIOUS_OR_CRIT(owner))
		return

	if(TIMER_COOLDOWN_RUNNING(parent.shell, COOLDOWN_CIRCUIT_TARGET_INTERCEPT))
		return

	to_chat(owner, "<B>左键点击以触发目标截取器！</B>")
	owner.client.click_intercept = src

/obj/item/circuit_component/target_intercept/proc/on_organ_removed(datum/source, mob/living/carbon/owner)
	SIGNAL_HANDLER

	if(owner.client && owner.client.click_intercept == src)
		owner.client.click_intercept = null

/obj/item/circuit_component/target_intercept/proc/InterceptClickOn(mob/user, params, atom/object)
	user.client.click_intercept = null
	clicked_atom.set_output(object)
	trigger_output.set_output(COMPONENT_SIGNAL)
	if(parent.shell)
		TIMER_COOLDOWN_START(parent.shell, COOLDOWN_CIRCUIT_TARGET_INTERCEPT, intercept_cooldown)

/obj/item/circuit_component/target_intercept/get_ui_notices()
	. = ..()
	. += create_ui_notice("目标截取冷却：[DisplayTimeText(intercept_cooldown)]", "orange", "stopwatch")
