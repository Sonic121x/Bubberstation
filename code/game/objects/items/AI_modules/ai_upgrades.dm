///AI Upgrades

/// AI module which gives some specific malf ai ability when installed in a law rack
/obj/item/ai_module/upgrade
	name = "AI 升级模块"
	desc = "用于为 AI 安装升级的模块。"
	icon_state = "mcontroller"

	///The upgrade that will be applied to the AI when installed
	var/upgrade_type = /datum/ai_module
	/// Actual upgrade datum that will be applied to the AI when installed
	VAR_PRIVATE/datum/ai_module/gift

/obj/item/ai_module/upgrade/Initialize(mapload)
	. = ..()
	gift = new upgrade_type()

/obj/item/ai_module/upgrade/Destroy()
	QDEL_NULL(gift)
	return ..()

/obj/item/ai_module/upgrade/examine(mob/user)
	. = ..()
	. += span_info("必须插入模块架才能工作。")

/obj/item/ai_module/upgrade/silicon_linked_to_installed(mob/living/silicon/lawed)
	if(!isAI(lawed))
		return

	if(gift.unlock_text)
		to_chat(lawed, gift.unlock_text)
	if(gift.unlock_sound)
		lawed.playsound_local(lawed, gift.unlock_sound, 50, 0)

	if(gift.upgrade)
		gift.upgrade(lawed)
	else if(!(locate(gift.power_type) in lawed.actions))
		var/datum/action/gifted_action = new gift.power_type()
		gifted_action.Grant(lawed)

/obj/item/ai_module/upgrade/silicon_unlinked_from_installed(mob/living/silicon/lawed)
	if(!isAI(lawed))
		return
	if(gift.upgrade)
		// Can't un-upgrade (yet), so just return
		return
	if(IS_MALF_AI(lawed))
		// To prevent accidentally deleting a hard earned malf ability
		return

	var/datum/action/innate/ai/existing_action = locate(gift.power_type) in lawed.actions
	qdel(existing_action)

/// AI module which gives some ALL malf ai abilities when installed in a law rack
/obj/item/ai_module/combat
	name = "战斗软件模块"
	desc = "用于人工智能的高度非法且极其危险的升级，赋予它们多种能力，以及入侵区域电力控制器的能力。"
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "secmodschematic"

/obj/item/ai_module/combat/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/ai_module/combat/examine(mob/user)
	. = ..()
	. += span_warning("必须插入模块架才能工作。")

/obj/item/ai_module/combat/log_install(mob/living/user, obj/machinery/ai_law_rack/rack)
	. = ..()
	message_admins("[ADMIN_LOOKUPFLW(user)]将[src]安装进了[ADMIN_VERBOSEJMP(rack)]（[rack.log_status()]）。")

/obj/item/ai_module/combat/log_uninstall(mob/living/user, obj/machinery/ai_law_rack/rack)
	. = ..()
	message_admins("[ADMIN_LOOKUPFLW(user)]从[ADMIN_VERBOSEJMP(rack)]移除了[src]（[rack.log_status()]）。")

/obj/item/ai_module/combat/silicon_linked_to_installed(mob/living/silicon/lawed)
	if(!isAI(lawed))
		return
	var/mob/living/silicon/ai/combatai = lawed
	if(combatai.malf_picker)
		return
	to_chat(combatai, span_userdanger("你的模块架已升级战斗软件！"))
	to_chat(combatai, span_danger("你的现有法则和目标保持不变。")) //this unlocks malf powers, but does not give the license to plasma flood
	combatai.add_malf_picker()
	combatai.hack_software = TRUE

/obj/item/ai_module/combat/silicon_unlinked_from_installed(mob/living/silicon/lawed)
	if(!isAI(lawed))
		return
	var/mob/living/silicon/ai/combatai = lawed
	// Don't delete a malf ai's malf picker please
	if(!combatai.malf_picker || IS_MALF_AI(combatai))
		return
	// Does not revert upgrades, no clean way of doing that (yet)
	// Though it makes sense that they'd stick around, so I'm fine with it (for now)
	QDEL_NULL(combatai.malf_picker)
	QDEL_NULL(combatai.modules_action)
	for(var/datum/action/innate/ai/leftover_action in combatai.actions)
		qdel(leftover_action)
	combatai.hack_software = FALSE

//Lipreading
/obj/item/ai_module/upgrade/surveillance
	name = "监控软件升级"
	desc = "非法软件包，允许人工智能通过读唇和隐藏麦克风，从摄像头中“听到”声音。"
	upgrade_type = /datum/ai_module/malf/upgrade/eavesdrop
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5
	)

/obj/item/ai_module/upgrade/surveillance/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/ai_module/upgrade/power_transfer
	name = "电力传输升级"
	desc = "合法升级，允许人工智能从远处直接为区域电力控制器供电。"
	upgrade_type = /datum/ai_module/power_apc
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
	)
