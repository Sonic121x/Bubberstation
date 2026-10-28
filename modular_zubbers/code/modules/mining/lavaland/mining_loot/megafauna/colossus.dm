/obj/item/organ/vocal_cords/colossus/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/mob/living/silicon/robot/robot = interacting_with
	if(!istype(robot))
		return NONE
	if(!robot.opened)
		to_chat(user, span_warning("[robot]必须先打开才能放入此物品。"))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("你把[src]插入了[robot]。"))
	var/datum/action/cooldown/spell/voice_of_god/voice = new
	voice.Grant(robot)
	if(!user.dropItemToGround(src, TRUE, TRUE))
		to_chat(user, span_notice("你无法丢下[src]。"))
		return ITEM_INTERACT_BLOCKING
	forceMove(robot)
	RegisterSignal(robot, COMSIG_BORG_SAFE_DECONSTRUCT, PROC_REF(on_silicon_decon))
	return ITEM_INTERACT_SUCCESS

/obj/item/organ/vocal_cords/colossus/proc/on_silicon_decon()
	forceMove(get_turf(loc))
