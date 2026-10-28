/obj/item/disk/design_disk
	name = "组件设计磁盘"
	desc = "一张用于存储设备设计数据、以便在车床上建造的磁盘。"
	icon_state = "datadisk1"
	custom_materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass =SMALL_MATERIAL_AMOUNT)

	/// A List of all design typepaths that are stored on this disk
	var/list/blueprints = list()

/obj/item/disk/design_disk/Initialize(mapload)
	. = ..()
	if(mapload)
		pixel_x = base_pixel_x + rand(-5, 5)
		pixel_y = base_pixel_y + rand(-5, 5)

/obj/item/disk/design_disk/Destroy()
	blueprints = null
	return ..()

/**
 * Used for special interactions with a techweb when uploading the designs.
 * Args:
 * - stored_research - The techweb that's storing us.
 */
/obj/item/disk/design_disk/proc/on_upload(datum/techweb/stored_research, atom/research_source)
	return

/obj/item/disk/design_disk/bepis
	name = "旧实验技术磁盘"
	desc = "一张存有某个久远时代遗落技术的磁盘。你希望它历经这么多年仍然可用。将磁盘上传至研发控制台即可解锁该技术。"
	icon_state = "rndmajordisk"
	blueprints = null

	/// The typepath of the bepis node we store
	var/bepis_node

/obj/item/disk/design_disk/bepis/Initialize(mapload)
	. = ..()
	bepis_node = pick(SSresearch.techweb_nodes_experimental)

	var/datum/techweb_node/actual_node = SSresearch.techweb_nodes[bepis_node]
	blueprints = assoc_to_keys(actual_node.unlocked_designs)

///Unhide and research our node so we show up in the R&D console.
/obj/item/disk/design_disk/bepis/on_upload(datum/techweb/stored_research, atom/research_source)
	stored_research.hidden_nodes -= bepis_node
	stored_research.research_node(bepis_node, force = TRUE, auto_adjust_cost = FALSE, research_source = research_source)

/**
 * Subtype of Bepis tech disk
 * Removes the tech disk that's held on it from the experimental node list, making them not show up in future disks.
 */
/obj/item/disk/design_disk/bepis/remove_tech
	name = "重新格式化的技术磁盘"
	desc = "一张存有 B.E.P.I.S. 某项全新完整技术的磁盘。将磁盘上传至研发控制台即可解锁该技术。"

/obj/item/disk/design_disk/bepis/remove_tech/Initialize(mapload)
	. = ..()
	SSresearch.techweb_nodes_experimental -= bepis_node
	var/datum/techweb_node/actual_node = SSresearch.techweb_nodes[bepis_node]
	log_research("[actual_node.display_name] 已通过 BEPIS 科技网的“移除技术”功能从实验节点中移除。")
