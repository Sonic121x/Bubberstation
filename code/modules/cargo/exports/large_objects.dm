/datum/export/crate
	cost = CARGO_CRATE_VALUE
	k_elasticity = 0
	unit_name = "板条箱"
	export_types = list(/obj/structure/closet/crate)
	exclude_types = list(
		/obj/structure/closet/crate/coffin,
		/obj/structure/closet/crate/large,
		/obj/structure/closet/crate/mail,
		/obj/structure/closet/crate/wooden,
		/obj/structure/closet/crate/cardboard,
		)

/datum/export/crate/total_printout(datum/export_report/ex, notes = TRUE) // That's why a goddamn metal crate costs that much.
	. = ..()
	if(. && notes)
		. += " 感谢您参与纳米传讯板条箱回收计划。"

/datum/export/crate/wooden
	cost = CARGO_CRATE_VALUE / 5
	unit_name = "大型木箱"
	export_types = list(/obj/structure/closet/crate/large)
	exclude_types = list()

/datum/export/crate/wooden/ore
	unit_name = "矿石箱"
	export_types = list(/obj/structure/ore_box)
	exclude_types = list()

/datum/export/crate/wood
	cost = CARGO_CRATE_VALUE * 0.48
	unit_name = "木箱"
	export_types = list(/obj/structure/closet/crate/wooden)
	exclude_types = list()

/datum/export/crate/coffin
	cost = CARGO_CRATE_VALUE/2 //50 wooden crates cost 800 credits, and you can make 10 coffins in seconds with those planks. Each coffin selling for 100 means you can make a net gain of 200 credits for wasting your time making coffins.
	unit_name = "棺材"
	export_types = list(/obj/structure/closet/crate/coffin)
	exclude_types = list()

/datum/export/crate/cardboard
	cost = CARGO_CRATE_VALUE/5
	unit_name = "纸板箱"
	export_types = list(/obj/structure/closet/crate/cardboard, /obj/structure/closet/cardboard)
	exclude_types = list()

/datum/export/reagent_dispenser
	abstract_type = /datum/export/reagent_dispenser
	cost = CARGO_CRATE_VALUE * 0.5 // +0-400 depending on amount of reagents left
	///cost for an full holder of reagents
	var/contents_cost = CARGO_CRATE_VALUE * 0.8

/datum/export/reagent_dispenser/get_base_cost(obj/structure/reagent_dispensers/dispenser)
	return ..() + round(contents_cost * (dispenser.reagents.total_volume / dispenser.reagents.maximum_volume))

/datum/export/reagent_dispenser/water
	unit_name = "水箱"
	export_types = list(/obj/structure/reagent_dispensers/watertank)
	contents_cost = CARGO_CRATE_VALUE * 0.4

/datum/export/reagent_dispenser/fuel
	unit_name = "燃料箱"
	export_types = list(/obj/structure/reagent_dispensers/fueltank)

/datum/export/reagent_dispenser/alcohol_keg
	unit_name = "酒桶"
	contents_cost = CARGO_CRATE_VALUE * 3.5
	export_types = list(/obj/structure/reagent_dispensers/keg/beer, /obj/structure/reagent_dispensers/keg/whiskey, /obj/structure/reagent_dispensers/keg/rum)

/datum/export/reagent_dispenser/gold_keg
	unit_name = "高级酒桶"
	contents_cost = CARGO_CRATE_VALUE * 6.5
	export_types = list(/obj/structure/reagent_dispensers/keg/gold)

/datum/export/pipedispenser
	cost = CARGO_CRATE_VALUE * 2.5
	unit_name = "管道分配器"
	export_types = list(/obj/machinery/pipedispenser)

/datum/export/emitter
	cost = CARGO_CRATE_VALUE * 2.75
	unit_name = "发射器"
	export_types = list(/obj/machinery/power/emitter)

/datum/export/field_generator
	cost = CARGO_CRATE_VALUE * 2.75
	unit_name = "力场发生器"
	export_types = list(/obj/machinery/field/generator)

/datum/export/tesla_coil
	cost = CARGO_CRATE_VALUE * 2.25
	unit_name = "特斯拉线圈"
	export_types = list(/obj/machinery/power/energy_accumulator/tesla_coil)

/datum/export/supermatter
	cost = CARGO_CRATE_VALUE * 16
	unit_name = "超物质碎片"
	export_types = list(/obj/machinery/power/supermatter_crystal/shard)

/datum/export/grounding_rod
	cost = CARGO_CRATE_VALUE * 1.2
	unit_name = "接地棒"
	export_types = list(/obj/machinery/power/energy_accumulator/grounding_rod)

/datum/export/iv
	cost = CARGO_CRATE_VALUE * 0.25
	unit_name = "静脉输液架"
	export_types = list(/obj/machinery/iv_drip)

/datum/export/barrier
	cost = CARGO_CRATE_VALUE * 0.25
	unit_name = "安保路障"
	export_types = list(/obj/item/grenade/barrier, /obj/structure/barricade/security)

///Maximum number of credits you can earn from selling your gas canister cause its theoritically infinite
#define MAX_GAS_CREDITS 15000

/**
 * Maximum pressure a canister can withstand is 9.2e13 kPa at a minimum of 2.7K which would contain a horrifying 4,098,150,709.4 moles.
 * We don't want players making that much credits so we limit the total amount earned to MAX_GAS_CREDITS
*/
/datum/export/gas_canister
	cost = CARGO_CRATE_VALUE * 0.05 //Base cost of canister. You get more for nice gases inside.
	unit_name = "气体罐"
	export_types = list(/obj/machinery/portable_atmospherics/canister)

/datum/export/gas_canister/get_base_cost(obj/machinery/portable_atmospherics/canister/canister)
	var/datum/gas_mixture/canister_mix = canister.return_air()
	if(!canister_mix.total_moles())
		return 0
	var/cached_moles = canister_mix.moles

	var/worth = cost
	for(var/datum/gas/gas as anything in GLOB.meta_gas_info[META_GAS_ID])
		if(!(initial(gas.cargo_flags) & GAS_EXPORTABLE))
			continue
		canister_mix.assert_gas(gas)
		if(cached_moles[gas] > 0)
			worth += get_gas_value(gas, cached_moles[gas])
			if(worth > MAX_GAS_CREDITS)
				worth = MAX_GAS_CREDITS
				break

	return worth

/datum/export/gas_canister/proc/get_gas_value(datum/gas/gasType, moles)
	return ROUND_UP(initial(gasType.base_value) * moles)

#undef MAX_GAS_CREDITS
