/obj/item/disk/nifsoft_uploader/scryer
	name = "NIFSoft 探视器上传磁盘"
	loaded_nifsoft = /datum/nifsoft/scryer

/datum/nifsoft/scryer
	name = "NIFLink 全息通话器"
	program_desc = "这款随处可见的 NIFSoft 为用户 NIF 添加了类似 MOD 外骨骼的探视器功能；它通过架设在佩戴者颈部周围的硬光投影仪，借助 AR 全息玻璃屏幕实现实时通讯。"
	active_mode = TRUE
	active_cost = 1
	activation_cost = 20
	purchase_price = 200
	buying_category = NIFSOFT_CATEGORY_UTILITY
	ui_icon = "video"
	/// What is the scryer currently associated with the NIFSoft?
	var/obj/item/clothing/neck/link_scryer/loaded/nifsoft/linked_scryer

/datum/nifsoft/scryer/New()
	. = ..()
	var/obj/item/organ/cyberimp/brain/nif/parent_resolved = parent_nif.resolve()
	if(!istype(parent_resolved))
		stack_trace("[src] ([REF(src)]) tried to create a linked scryer but it had no parent_nif!")
	if(!linked_scryer)
		stack_trace("[src] ([REF(src)]) created with no linked scryer!")
	linked_scryer = new (parent_resolved)
	linked_scryer.parent_nifsoft = WEAKREF(src)

/datum/nifsoft/scryer/Destroy()
	if(!QDELETED(linked_scryer))
		QDEL_NULL(linked_scryer)

	return ..()

/datum/nifsoft/scryer/activate()
	. = ..()
	if(. == FALSE)
		return FALSE

	if(!active)
		if(linked_scryer)
			var/parent_resolved = parent_nif.resolve()
			if(parent_resolved)
				return linked_mob.transferItemToLoc(linked_scryer, parent_resolved, TRUE)
		return FALSE

	if(linked_mob.handcuffed)
		linked_mob.balloon_alert(linked_mob, "被铐住了！")
		activate()
		return FALSE

	if(!linked_mob.equip_to_slot_if_possible(linked_scryer, ITEM_SLOT_NECK)) //This sends out a message to the mob if it can't be put on.
		activate()
		return FALSE

	return TRUE

/obj/item/clothing/neck/link_scryer
	/// Do we have custom controls? This is only affects the text shown when examining
	var/custom_examine_controls = FALSE

/obj/item/clothing/neck/link_scryer/loaded/nifsoft
	name = "\improper NIFLink 全息通话器"
	desc = "一种纳米机械构造体，是 MOD 链路探视器的改装版本，由 NIF 生成；功能相同，但能以更便携的形式进行全息通话。"
	custom_examine_controls = TRUE
	/// A weakref of the parent NIFSoft that the scryer belongs to.
	var/datum/weakref/parent_nifsoft

/obj/item/clothing/neck/link_scryer/loaded/nifsoft/Initialize(mapload)
	. = ..()
	if(cell)
		QDEL_NULL(cell)

	cell = new /obj/item/stock_parts/power_store/cell/infinite/nif_cell(src)

/obj/item/clothing/neck/link_scryer/loaded/nifsoft/Destroy()
	if(parent_nifsoft)
		var/datum/nifsoft/scryer/resolved_nifsoft = parent_nifsoft.resolve()
		if(!QDELETED(resolved_nifsoft))
			resolved_nifsoft.linked_scryer = null

	return ..()

/obj/item/clothing/neck/link_scryer/loaded/nifsoft/examine(mob/user)
	. = ..()
	. += span_notice("MOD 链路 ID 为 [mod_link.id]，频率为 [mod_link.frequency || "未设定"]。<b>右键</b>使用多用工具可复制/刻印频率。")
	. += span_notice("<b>右键</b>空手可更改名称。")

/obj/item/clothing/neck/link_scryer/loaded/nifsoft/equipped(mob/living/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_NECK)
		return TRUE

	var/datum/nifsoft/scryer/scryer_nifsoft = parent_nifsoft.resolve()
	if(!istype(scryer_nifsoft))
		return FALSE

	scryer_nifsoft.activate() //If it's not on the neck, it shouldn't be active.
	return TRUE

/obj/item/clothing/neck/link_scryer/loaded/nifsoft/screwdriver_act(mob/living/user, obj/item/tool)
	balloon_alert(user, "电池不可拆卸！")
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/clothing/neck/link_scryer/loaded/nifsoft/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	var/new_label = reject_bad_text(tgui_input_text(user, "更改显示名称", "设置名称", label, MAX_NAME_LEN))
	if(!new_label)
		balloon_alert(user, "名称无效！")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	label = new_label
	balloon_alert(user, "名称已设置！")
	update_name()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/// This cell is only meant for use in items temporarily created by a NIF. Do not let players extract this from devices.
/obj/item/stock_parts/power_store/cell/infinite/nif_cell
	name = "纳米机器人电池"
	desc = "如果你看到此物品，请在 GitHub 上提交问题反馈。"

