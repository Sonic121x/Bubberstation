/datum/element/clockwork_structure_info
	element_flags = ELEMENT_DETACH_ON_HOST_DESTROY


/datum/element/clockwork_structure_info/Attach(datum/target, list/slots_to_count)
	. = ..()

	if(!istype(target, /obj/structure/destructible/clockwork/gear_base))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(print_info))
	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))


/datum/element/clockwork_structure_info/Detach(datum/target)
	. = ..()
	UnregisterSignal(target, COMSIG_ATOM_ITEM_INTERACTION)
	UnregisterSignal(target, COMSIG_ATOM_EXAMINE)

/**
 *
 * This proc is called when the user hits the target with an item, which checks for it being a clockwork slab.
 *
 * Arguments:
 * 	* source - The structure that was attacked
 *  * weapon - The item that attacked the structure
 * 	* user - The one who attacked the structure
 */
/datum/element/clockwork_structure_info/proc/print_info(obj/structure/destructible/clockwork/gear_base/source, mob/user, obj/item/weapon)
	SIGNAL_HANDLER

	if(!IS_CLOCK(user) || !istype(weapon, /obj/item/clockwork/clockwork_slab))
		return

	var/assembled_string = ""

	assembled_string += "<b>[source]</b><br>"
	assembled_string += "该结构当前<b>[source.anchored ? "已固定" : "未固定"]</b>。<br>"

	if(istype(source, /obj/structure/destructible/clockwork/gear_base/powered))
		var/obj/structure/destructible/clockwork/gear_base/powered/powered_source = source
		assembled_string += "该结构当前处于<b>[powered_source.enabled ? "开启" : "关闭"]</b>状态，并<b>[powered_source.processing ? "正在运行" : "未在运行"]</b>。<br>"
		assembled_string += "该结构在启用时每 2 秒消耗 <b>[powered_source.passive_consumption]</b> W。<br>"
		assembled_string += "该结构连接着 <b>[LAZYLEN(powered_source.transmission_sigils)]</b> 个传输印记。"

	to_chat(user, span_brass(assembled_string))
	return ITEM_INTERACT_BLOCKING

/**
 *
 * This proc is called when a mob examines the structure
 *
 * Arguments:
 * 	* source - The structure that was examined
 * 	* user - The one who attacked the structure
 *  * examine_text - The list of text to send the examiner
 */
/datum/element/clockwork_structure_info/proc/on_examine(obj/structure/destructible/clockwork/gear_base/source, mob/examiner, list/examine_text)
	SIGNAL_HANDLER

	if(!IS_CLOCK(examiner))
		return

	examine_text += span_brass("使用<b>发条石板</b>可以获取更多信息。")
