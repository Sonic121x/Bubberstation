/datum/component/obeys_commands/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE_MORE, PROC_REF(on_examine_more))

/datum/component/obeys_commands/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_ATOM_EXAMINE_MORE)

/datum/component/obeys_commands/on_examine(mob/living/source, mob/user, list/examine_list)
	. = ..()
	examine_list += span_notice("在相邻时按住 Alt 点击它，即可查看可用指令。")
	examine_list += span_notice("你也可以仔细检查它，查看其伤势。许多伙伴都能用缝线或药膏治愈！")

/datum/component/obeys_commands/proc/on_examine_more(mob/living/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if (source.incapacitated)
		return
	if (!(user in source.ai_controller?.blackboard[BB_FRIENDS_LIST]))
		return

	if (source.health < source.maxHealth*0.2)
		examine_list += span_bolddanger("它看起来伤势严重。")
	else if (source.health < source.maxHealth*0.5)
		examine_list += span_danger("它看起来伤势中等。")
	else if (source.health < source.maxHealth*0.8)
		examine_list += span_warning("它看起来伤势轻微。")
	else
		examine_list += span_notice("它看起来状态良好。")
