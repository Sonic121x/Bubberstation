/datum/techweb_node/syndicate_basic
	id = TECHWEB_NODE_SYNDICATE_BASIC
	display_name = "非法技术"
	description = "用于制造危险物品的危险研究。"
	prereq_ids = list(TECHWEB_NODE_EXP_TOOLS, TECHWEB_NODE_EXOTIC_AMMO)
	design_ids = list(
		"advanced_camera",
		"ai_cam_upgrade",
		"borg_syndicate_module",
		"donksoft_refill",
		"largecrossbow",
		/* BUBBER EDIT REMOVAL BEGIN
		"mag_autorifle",
		"mag_autorifle_ap",
		"mag_autorifle_ic",
		*/// BUBBER EDIT REMOVAL END
		"rapidsyringe",
		"suppressor",
		"super_pointy_tape",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	hidden = TRUE

/datum/techweb_node/syndicate_basic/New() //Crappy way of making syndicate gear decon supported until there's another way.
	. = ..()
	if(!SSearly_assets.initialized)
		RegisterSignal(SSearly_assets, COMSIG_SUBSYSTEM_POST_INITIALIZE, PROC_REF(register_uplink_items))
	else
		register_uplink_items()

/datum/techweb_node/syndicate_basic/proc/register_uplink_items()
	SIGNAL_HANDLER
	UnregisterSignal(SSearly_assets, COMSIG_SUBSYSTEM_POST_INITIALIZE)
	required_items_to_unlock = list()
	for(var/datum/uplink_item/item as anything in SStraitor.uplink_items)
		if(isnull(item.item) || item.item == ABSTRACT_UPLINK_ITEM || !(item.uplink_item_flags & SYNDIE_ILLEGAL_TECH))
			continue
		required_items_to_unlock |= item.item //allows deconning to unlock.

/datum/techweb_node/unregulated_bluespace
	id = TECHWEB_NODE_UNREGULATED_BLUESPACE
	display_name = "未受监管的蓝空间研究"
	description = "使用不稳定或失衡流程的蓝空间技术，容易损伤蓝空间的结构。已被银河公约列为非法。"
	prereq_ids = list(TECHWEB_NODE_PARTS_BLUESPACE, TECHWEB_NODE_SYNDICATE_BASIC)
	design_ids = list(
		"desynchronizer",
		"beamrifle",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
