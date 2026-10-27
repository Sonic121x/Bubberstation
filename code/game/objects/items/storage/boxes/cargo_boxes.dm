// This file contains all boxes used by the Cargo department and its purpose on the station.

/obj/item/storage/box/shipping
	name = "货运用品箱"
	desc = "内含数个用于货运的扫描仪和贴标器。不含包装纸。"
	illustration = "shipping"

/obj/item/storage/box/shipping/PopulateContents()
	var/list/items_inside = list(
		/obj/item/dest_tagger = 1,
		/obj/item/universal_scanner = 1,
		/obj/item/stack/package_wrap/small = 2,
		/obj/item/stack/wrapping_paper/small = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/shipping/debug
	name = "更大的货运用品箱"
	desc = "建立你自己的货运部所需的一切。"

/obj/item/storage/box/shipping/debug/PopulateContents()
	var/list/items_inside = list(
		/obj/item/universal_scanner = 1,
		/obj/item/stack/package_wrap/small = 2,
		/obj/item/stack/wrapping_paper/small = 2,
		/obj/item/boulder_beacon = 1,
		/obj/item/stack/conveyor/thirty = 1,
		/obj/item/conveyor_switch_construct = 1,
		/obj/item/construction/plumbing = 1,
	)
	generate_items_inside(items_inside,src)
