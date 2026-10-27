/obj/machinery/oven/range_frontier
	name = "边疆一体炉灶"
	desc = "边疆地区常见的烤箱与炉灶一体机。出厂时被紧凑地\
		打包成规整的压缩形态，随后可展开成接近全尺寸的电器。\
		不过，设计者似乎忘了附上把这些东西重新打包的说明书。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/kitchen_stuff/range.dmi'
	icon_state = "range_off"
	base_icon_state = "range"
	pass_flags_self = PASSMACHINE|PASSTABLE|LETPASSTHROW
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 1.2
	circuit = null

/obj/machinery/oven/range_frontier/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	AddComponent(/datum/component/stove, container_x = -3, container_y = 14)

/obj/machinery/oven/range_frontier/examine(mob/user)
	. = ..()
	. += span_notice("它无法重新打包，但可以正常拆解。")

/obj/machinery/oven/range_frontier/unanchored
	anchored = FALSE

// Deployable item for cargo

/obj/item/flatpacked_machine/frontier_range
	name = "边疆一体炉灶零件包"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/kitchen_stuff/range.dmi'
	icon_state = "range_packed"
	w_class = WEIGHT_CLASS_NORMAL
	type_to_deploy = /obj/machinery/oven/range_frontier
	deploy_time = 2 SECONDS
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
