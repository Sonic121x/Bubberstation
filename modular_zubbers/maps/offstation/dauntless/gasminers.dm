/obj/item/storage/box/gas_miner_beacons/syndicate
	name = "辛迪加气体采矿机投放信标箱"
	desc = "内含两个用于投放大气气体采矿机的信标。"

/obj/item/storage/box/gas_miner_beacons/syndicate/PopulateContents()
	new /obj/item/summon_beacon/gas_miner/syndicate(src)
	new /obj/item/summon_beacon/gas_miner/syndicate(src)

/obj/item/summon_beacon/gas_miner/syndicate
	name = "辛迪加气体采矿机信标"

	allowed_areas = list(/area/ruin/space/has_grav/bubbers/dauntless/cargo,
						/area/ruin/space/has_grav/bubbers/dauntless/engineering,
						/area/ruin/space/has_grav/bubbers/dauntless/engineering/turbine,
						/area/ruin/space/has_grav/bubbers/persistance/engineering,
						/area/ruin/space/has_grav/bubbers/persistance/engineering/atmospherics,
						/area/ruin/space/has_grav/bubbers/persistance/engineering/mining,
						/area/ruin/space/has_grav/bubbers/persistance/engineering/gas,
						/area/ruin/space/has_grav/bubbers/persistance/engineering/utilities
						)
	area_string = "dauntless"
