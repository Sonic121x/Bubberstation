/datum/element/hand_organ_insertion
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2

	var/insertion_time = 0 SECONDS

/datum/element/hand_organ_insertion/Attach(datum/target, insertion_time = 5 SECONDS)
	. = ..()
	if (!iscarbon(target))
		return ELEMENT_INCOMPATIBLE

	src.insertion_time = insertion_time

	RegisterSignal(target, COMSIG_USER_ITEM_INTERACTION_SECONDARY, PROC_REF(on_item_interaction_secondary))

/datum/element/hand_organ_insertion/Detach(datum/source, ...)
	. = ..()

	UnregisterSignal(source, COMSIG_USER_ITEM_INTERACTION_SECONDARY)

/datum/element/hand_organ_insertion/proc/on_item_interaction_secondary(mob/living/carbon/parent, atom/target, obj/item/tool, list/modifiers)
	SIGNAL_HANDLER
	if (target != parent)
		return FALSE
	if (!isorgan(tool))
		return FALSE

	INVOKE_ASYNC(src, PROC_REF(attempt_to_insert_organ), parent, tool)
	return TRUE

/datum/element/hand_organ_insertion/proc/attempt_to_insert_organ(mob/living/carbon/user, obj/item/organ/organ)
	if (!can_insert_organ(user, organ, feedback = TRUE))
		return

	var/zone_name = user.parse_zone_with_bodypart(organ.zone)

	user.visible_message(
		message = span_danger("[user]开始将[organ]塞进自己的[zone_name]！"),
		self_message = span_danger("你开始将[organ]塞进自己的[zone_name]！"),
		blind_message = span_hear("你听见湿黏的挤压声！")
	)

	user.balloon_alert(user, "正在插入……")

	playsound(user, 'sound/items/handling/surgery/organ2.ogg', vol = 80, vary = TRUE, ignore_walls = FALSE)

	if (!do_after(user, insertion_time, extra_checks = CALLBACK(src, PROC_REF(can_insert_organ), user, organ)))
		user.balloon_alert(user, "被打断了！")
		return

	zone_name = user.parse_zone_with_bodypart(organ.zone)

	user.visible_message(
		message = span_danger("[user]将[organ]塞进了自己的[zone_name]！"),
		self_message = span_danger("你将[organ]塞进了自己的[zone_name]！"),
		blind_message = span_hear("你听见最后一声响亮而湿黏的挤压声！")
	)

	user.balloon_alert(user, "已插入！")

	playsound(user, 'sound/items/handling/surgery/organ1.ogg', vol = 80, vary = TRUE, ignore_walls = FALSE)
	user.temporarilyRemoveItemFromInventory(organ, force = TRUE)
	organ.pre_surgical_insertion(user, user, organ.zone)
	organ.Insert(user)
	organ.on_surgical_insertion(user, user.get_bodypart(deprecise_zone(organ.zone)))

/datum/element/hand_organ_insertion/proc/can_insert_organ(mob/living/carbon/user, obj/item/organ/organ, feedback = FALSE)
	if (!user.get_bodypart(deprecise_zone(organ.zone)))
		user.balloon_alert(user, "你没有[chinese_body_zone_display(parse_zone(organ.zone))]！")
		return FALSE

	var/obj/item/organ/existing_organ = user.get_organ_slot(organ.slot)
	if (existing_organ)
		user.balloon_alert(user, "你的[existing_organ]挡住了位置！")
		return FALSE

	if (!organ.useable)
		user.balloon_alert(user, "无法使用！")
		return FALSE
	return TRUE
