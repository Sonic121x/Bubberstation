#define RSD_ATTEMPT_COOLDOWN 2 MINUTES

/obj/item/handheld_soulcatcher
	name = "\improper 唤魂型 RSD"
	desc = "唤魂型共鸣模拟装置是一种被设计为手持使用的“灵魂捕手”仪器。此类 RSD 在设计时便着眼于医疗领域，是一件旨在为暂时离世者提供慰藉的工具，让它们在躯体接受修复、治疗或制造期间得以安身。唤魂器本质上是一台高度专用化的手持式 NIF，其软件与硬件仍然使用相同的纳米机械。这台精密的仪器能够在一段本质上无限长的时间里，以无穷多样的模拟环境，为大量印痕提供一个虚拟空间，甚至能将它们与 NIF 之间相互转移。不过，按照医疗规范，最好还是不要磨磨蹭蹭。"
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "soulcatcher-device"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	obj_flags = UNIQUE_RENAME
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT
		)
	/// What soulcatcher datum is associated with this item?
	var/datum/component/carrier/soulcatcher/linked_soulcatcher
	/// The cooldown for the RSD on scanning a body if the ghost refuses. This is here to prevent spamming.
	COOLDOWN_DECLARE(rsd_scan_cooldown)

/obj/item/handheld_soulcatcher/Initialize(mapload)
	. = ..()
	name += " #[rand(0, 999)]" // If it works for monkeys, it surely works for soulcatchers.
	SSpoints_of_interest.make_point_of_interest(src)

/obj/item/handheld_soulcatcher/attack_self(mob/user, modifiers)
	linked_soulcatcher.ui_interact(user)

/obj/item/handheld_soulcatcher/New(loc, ...)
	. = ..()
	linked_soulcatcher = AddComponent(/datum/component/carrier/soulcatcher)
	linked_soulcatcher.name = name

/obj/item/handheld_soulcatcher/Destroy(force)
	if(linked_soulcatcher)
		qdel(linked_soulcatcher)

	return ..()

/obj/item/handheld_soulcatcher/attack(mob/living/target_mob, mob/living/user, params)
	if(!target_mob)
		return ..()

	if(target_mob.GetComponent(/datum/component/previous_body))
		linked_soulcatcher.scan_body(target_mob, user)
		return TRUE

	if(!target_mob.mind)
		to_chat(user, span_warning("你无法从一具空壳躯体中取出心智。"))
		return FALSE

	if(!COOLDOWN_FINISHED(src, rsd_scan_cooldown))
		var/time_left = round((COOLDOWN_TIMELEFT(src, rsd_scan_cooldown)) / (1 MINUTES), 0.01)
		to_chat(user, span_warning("你目前无法攫取 [target_mob] 的灵魂，请等待 [time_left] 分钟后再试。"))
		return FALSE

	if(target_mob.stat == DEAD) //We can temporarily store souls of dead mobs.
		target_mob.ghostize(TRUE) //Incase they are staying in the body.
		var/mob/dead/observer/target_ghost = target_mob.get_ghost(TRUE, TRUE)
		if(!target_ghost)
			to_chat(user, span_warning("你无法获取 [target_mob] 的灵魂！"))
			return FALSE

		var/datum/carrier_room/soulcatcher/target_room = tgui_input_list(user, "选择要将 [target_mob] 的灵魂送往的房间。", name, linked_soulcatcher.carrier_rooms, timeout = 30 SECONDS)
		if(!target_room)
			return FALSE

		SEND_SOUND(target_ghost, 'sound/announcer/notice/notice2.ogg')
		window_flash(target_ghost.client)

		if(tgui_alert(target_ghost, "[user] 想要将你转移到灵魂捕手中的 [target_room]，你接受吗？", name, list("是", "否"), 30 SECONDS, autofocus = FALSE) != "是")
			to_chat(user, span_warning("[target_mob] 似乎不愿意进入。"))
			COOLDOWN_START(src, rsd_scan_cooldown, RSD_ATTEMPT_COOLDOWN)
			return FALSE

		if(!target_room.add_soul_from_ghost(target_ghost))
			return FALSE

		if(!target_mob.GetComponent(/datum/component/previous_body))
			return FALSE

		var/turf/source_turf = get_turf(user)
		log_admin("[key_name(user)] 使用 [src] 将 [key_name(target_mob)] 的心智放入位于 [AREACOORD(source_turf)] 的灵魂捕手")
		linked_soulcatcher.scan_body(target_mob, user)
		return TRUE

	var/datum/carrier_room/target_room = tgui_input_list(user, "选择要将 [target_mob] 的灵魂送往的房间。", name, linked_soulcatcher.carrier_rooms, timeout = 30 SECONDS)
	if(!target_room)
		return FALSE

	SEND_SOUND(target_mob, 'sound/announcer/notice/notice2.ogg')
	window_flash(target_mob.client)

	if((tgui_alert(target_mob, "你希望进入 [target_room] 吗？在你离开之前，你将脱离自己的躯体。", name, list("是", "否"), 30 SECONDS, FALSE) != "是") || (tgui_alert(target_mob, "你确定吗？", name, list("是", "否"), 30 SECONDS, FALSE) != "是"))
		COOLDOWN_START(src, rsd_scan_cooldown, RSD_ATTEMPT_COOLDOWN)
		to_chat(user, span_warning("[target_mob] 似乎不愿意进入。"))
		return FALSE

	if(!target_mob.mind)
		return FALSE

	target_room.add_soul_from_mind(target_mob.mind, FALSE)
	playsound(src, 'modular_skyrat/modules/modular_implants/sounds/default_good.ogg', 50, FALSE, ignore_walls = FALSE)
	visible_message(span_notice("[src] 发出提示音：[target_mob] 的心智转移已完成。"))

	if(!target_mob.GetComponent(/datum/component/previous_body))
		return FALSE

	linked_soulcatcher.scan_body(target_mob, user)

	var/turf/source_turf = get_turf(user)
	log_admin("[key_name(user)] 使用 [src] 在 [key_name(target_mob)] 仍然存活时将其心智放入位于 [AREACOORD(source_turf)] 的灵魂捕手")

	return TRUE

/obj/item/handheld_soulcatcher/attack_secondary(mob/living/carbon/human/target_mob, mob/living/user, params)
	if(!istype(target_mob))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	var/obj/item/organ/brain/target_brain = target_mob.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(target_brain))
		to_chat(user, span_warning("[target_mob] 没有大脑！"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(!HAS_TRAIT(target_brain, TRAIT_RSD_COMPATIBLE))
		to_chat(user, span_warning("[target_mob] 的大脑不兼容。"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(target_mob.mind || target_mob.ckey || GetComponent(/datum/component/previous_body))
		to_chat(user, span_warning("[target_mob] 无法接收灵魂。"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	var/list/soul_list = list()
	for(var/datum/carrier_room/room as anything in linked_soulcatcher.carrier_rooms)
		for(var/mob/living/soulcatcher_soul/soul as anything in room.current_mobs)
			if(!istype(soul) || !soul.round_participant || soul.body_scan_needed)
				continue

			soul_list += soul

	if(!length(soul_list))
		to_chat(user, span_warning("没有可以转移到 [target_mob] 的灵魂。"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	var/mob/living/soulcatcher_soul/chosen_soul = tgui_input_list(user, "选择要转移进躯体的灵魂", name, soul_list)
	if(!chosen_soul)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(chosen_soul.previous_body)
		var/mob/living/old_body = chosen_soul.previous_body.resolve()
		if(!old_body)
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

		SEND_SIGNAL(old_body, COMSIG_SOULCATCHER_CHECK_SOUL, FALSE)

	chosen_soul.mind.transfer_to(target_mob, TRUE)
	playsound(src, 'modular_skyrat/modules/modular_implants/sounds/default_good.ogg', 50, FALSE, ignore_walls = FALSE)
	visible_message(span_notice("[src] 发出提示音：躯体转移完成。"))
	log_admin("[src] 被 [user] 用来将 [chosen_soul] 的灵魂捕手灵魂转移到 [target_mob]。")

	qdel(chosen_soul)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

#undef RSD_ATTEMPT_COOLDOWN
