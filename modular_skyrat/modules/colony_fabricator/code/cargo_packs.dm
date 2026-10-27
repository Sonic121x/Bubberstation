// Service

/datum/supply_pack/service/hydro_synthesizers
	name = "水培管道合成器套装"
	desc = "给植物浇水和施肥让你疲惫不堪？不必担心，这套工具包含两台水合成器和两台水培肥料合成器。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(
		/obj/machinery/plumbing/synthesizer/water_synth,
		/obj/machinery/plumbing/synthesizer/water_synth,
		/obj/machinery/plumbing/synthesizer/colony_hydroponics,
		/obj/machinery/plumbing/synthesizer/colony_hydroponics,
	)
	crate_name = "水培合成器板条箱"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/service/frontier_kitchen
	name = "边疆厨房设备"
	desc = "一系列经典的边疆电器，无论你身处银河何处，都足够搭起一间能正常运转的厨房。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/machinery/plumbing/synthesizer/water_synth,
		/obj/machinery/chem_dispenser/frontier_appliance,
		/obj/machinery/griddle/frontier_tabletop/unanchored,
		/obj/machinery/microwave/frontier_printed/unanchored,
		/obj/machinery/oven/range_frontier/unanchored,
		/obj/machinery/biogenerator/foodricator,
	)
	crate_name = "边疆厨房板条箱"

// Engineering

/datum/supply_pack/engineering/colony_starter
	name = "殖民启动套装"
	desc = "太阳系标准的边疆殖民最低配置套装，内含在银河系大多数地方建立一座基本可运转殖民地所需的一切。"
	cost = CARGO_CRATE_VALUE * 11 // 6 for the lathe, 3 for the organics printer, 2 for the rest of the stuff
	contains = list(
		/obj/item/flatpacked_machine,
		/obj/item/flatpacked_machine/organics_printer,
		/obj/item/flatpacked_machine/gps_beacon,
		/obj/item/stack/sheet/plastic_wall_panel/fifty,
		/obj/item/stack/rods/twentyfive,
		/obj/item/stack/sheet/iron/twenty,
		/obj/item/flatpacked_machine/airlock_kit_manual,
		/obj/item/flatpacked_machine/airlock_kit_manual,
		/obj/item/wallframe/apc,
		/obj/item/electronics/apc,
		/obj/item/stock_parts/power_store/battery/high,
	)
	crate_name = "殖民套装板条箱"
	order_flags = ORDER_CONTRABAND
