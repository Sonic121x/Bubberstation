/obj/structure/door_assembly/door_assembly_public
	name = "公共气闸组件"
	icon = 'icons/obj/doors/airlocks/public/glass.dmi'
	overlays_file = 'icons/obj/doors/airlocks/public/overlays.dmi'
	glass_type = /obj/machinery/door/airlock/public/glass
	airlock_type = /obj/machinery/door/airlock/public

/obj/structure/door_assembly/door_assembly_com
	name = "指挥气闸组件"
	icon = 'icons/obj/doors/airlocks/station/command.dmi'
	base_name = "指挥气闸"
	glass_type = /obj/machinery/door/airlock/command/glass
	airlock_type = /obj/machinery/door/airlock/command

/obj/structure/door_assembly/door_assembly_sec
	name = "安保气闸组件"
	icon = 'icons/obj/doors/airlocks/station/security.dmi'
	base_name = "安保气闸"
	glass_type = /obj/machinery/door/airlock/security/glass
	airlock_type = /obj/machinery/door/airlock/security

/obj/structure/door_assembly/door_assembly_eng
	name = "工程气闸组件"
	icon = 'icons/obj/doors/airlocks/station/engineering.dmi'
	base_name = "工程气闸"
	glass_type = /obj/machinery/door/airlock/engineering/glass
	airlock_type = /obj/machinery/door/airlock/engineering

/obj/structure/door_assembly/door_assembly_min
	name = "采矿气闸组件"
	icon = 'icons/obj/doors/airlocks/station/mining.dmi'
	base_name = "采矿气闸"
	glass_type = /obj/machinery/door/airlock/mining/glass
	airlock_type = /obj/machinery/door/airlock/mining

/obj/structure/door_assembly/door_assembly_atmo
	name = "大气气闸组件"
	icon = 'icons/obj/doors/airlocks/station/atmos.dmi'
	base_name = "大气气闸"
	glass_type = /obj/machinery/door/airlock/atmos/glass
	airlock_type = /obj/machinery/door/airlock/atmos

/obj/structure/door_assembly/door_assembly_research
	name = "研究气闸组件"
	icon = 'icons/obj/doors/airlocks/station/research.dmi'
	base_name = "研究气闸"
	glass_type = /obj/machinery/door/airlock/research/glass
	airlock_type = /obj/machinery/door/airlock/research

/obj/structure/door_assembly/door_assembly_science
	name = "科研气闸组件"
	icon = 'icons/obj/doors/airlocks/station/science.dmi'
	base_name = "科研气闸"
	glass_type = /obj/machinery/door/airlock/science/glass
	airlock_type = /obj/machinery/door/airlock/science

/obj/structure/door_assembly/door_assembly_med
	name = "医疗气闸组件"
	icon = 'icons/obj/doors/airlocks/station/medical.dmi'
	base_name = "医疗气闸"
	glass_type = /obj/machinery/door/airlock/medical/glass
	airlock_type = /obj/machinery/door/airlock/medical

/obj/structure/door_assembly/door_assembly_hydro
	name = "水培气闸组件"
	icon = 'icons/obj/doors/airlocks/station/hydroponics.dmi'
	base_name = "水培气闸"
	glass_type = /obj/machinery/door/airlock/hydroponics/glass
	airlock_type = /obj/machinery/door/airlock/hydroponics

/obj/structure/door_assembly/door_assembly_mai
	name = "维护气闸组件"
	icon = 'icons/obj/doors/airlocks/station/maintenance.dmi'
	base_name = "维护气闸"
	glass_type = /obj/machinery/door/airlock/maintenance/glass
	airlock_type = /obj/machinery/door/airlock/maintenance

/obj/structure/door_assembly/door_assembly_extmai
	name = "外部维护气闸组件"
	icon = 'icons/obj/doors/airlocks/station/maintenanceexternal.dmi'
	base_name = "外部维护气闸"
	glass_type = /obj/machinery/door/airlock/maintenance/external/glass
	airlock_type = /obj/machinery/door/airlock/maintenance/external

/obj/structure/door_assembly/door_assembly_ext
	name = "外部气闸组件"
	icon = 'icons/obj/doors/airlocks/external/external.dmi'
	base_name = "外部气闸"
	overlays_file = 'icons/obj/doors/airlocks/external/overlays.dmi'
	glass_type = /obj/machinery/door/airlock/external/glass
	airlock_type = /obj/machinery/door/airlock/external

/obj/structure/door_assembly/door_assembly_fre
	name = "冷冻库气闸组件"
	icon = 'icons/obj/doors/airlocks/station/freezer.dmi'
	base_name = "冷冻库气闸"
	airlock_type = /obj/machinery/door/airlock/freezer
	noglass = TRUE

/obj/structure/door_assembly/door_assembly_hatch
	name = "气密舱门组件"
	icon = 'icons/obj/doors/airlocks/hatch/centcom.dmi'
	base_name = "气密舱门"
	overlays_file = 'icons/obj/doors/airlocks/hatch/overlays.dmi'
	airlock_type = /obj/machinery/door/airlock/hatch
	noglass = TRUE

/obj/structure/door_assembly/door_assembly_mhatch
	name = "维护舱门组件"
	icon = 'icons/obj/doors/airlocks/hatch/maintenance.dmi'
	base_name = "维护舱门"
	overlays_file = 'icons/obj/doors/airlocks/hatch/overlays.dmi'
	airlock_type = /obj/machinery/door/airlock/maintenance_hatch
	noglass = TRUE

/obj/structure/door_assembly/door_assembly_highsecurity
	name = "高安保气闸组件"
	icon = 'icons/obj/doors/airlocks/highsec/highsec.dmi'
	base_name = "高安保气闸"
	overlays_file = 'icons/obj/doors/airlocks/highsec/overlays.dmi'
	airlock_type = /obj/machinery/door/airlock/highsecurity
	noglass = TRUE
	material_type = /obj/item/stack/sheet/plasteel
	material_amt = 4
	custom_materials = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 4)

/obj/structure/door_assembly/door_assembly_vault
	name = "金库门组件"
	icon = 'icons/obj/doors/airlocks/vault/vault.dmi'
	base_name = "金库门"
	overlays_file = 'icons/obj/doors/airlocks/vault/overlays.dmi'
	airlock_type = /obj/machinery/door/airlock/vault
	noglass = TRUE
	material_type = /obj/item/stack/sheet/plasteel
	material_amt = 6
	custom_materials = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 6)

/obj/structure/door_assembly/door_assembly_shuttle
	name = "穿梭机气闸组件"
	icon = 'icons/obj/doors/airlocks/shuttle/shuttle.dmi'
	base_name = "穿梭机气闸"
	overlays_file = 'icons/obj/doors/airlocks/shuttle/overlays.dmi'
	airlock_type = /obj/machinery/door/airlock/shuttle
	glass_type = /obj/machinery/door/airlock/shuttle/glass

/obj/structure/door_assembly/door_assembly_cult
	name = "邪教气闸组件"
	icon = 'icons/obj/doors/airlocks/cult/runed/cult.dmi'
	base_name = "邪教气闸"
	overlays_file = 'icons/obj/doors/airlocks/cult/runed/overlays.dmi'
	airlock_type = /obj/machinery/door/airlock/cult
	glass_type = /obj/machinery/door/airlock/cult/glass

/obj/structure/door_assembly/door_assembly_cult/unruned
	icon = 'icons/obj/doors/airlocks/cult/unruned/cult.dmi'
	overlays_file = 'icons/obj/doors/airlocks/cult/unruned/overlays.dmi'
	airlock_type = /obj/machinery/door/airlock/cult/unruned
	glass_type = /obj/machinery/door/airlock/cult/unruned/glass

/obj/structure/door_assembly/door_assembly_viro
	name = "病毒学气闸组件"
	icon = 'icons/obj/doors/airlocks/station/virology.dmi'
	base_name = "病毒学气闸"
	glass_type = /obj/machinery/door/airlock/virology/glass
	airlock_type = /obj/machinery/door/airlock/virology

/obj/structure/door_assembly/door_assembly_centcom
	icon = 'icons/obj/doors/airlocks/centcom/centcom.dmi'
	overlays_file = 'icons/obj/doors/airlocks/centcom/overlays.dmi'
	airlock_type = /obj/machinery/door/airlock/centcom
	noglass = TRUE

/obj/structure/door_assembly/door_assembly_grunge
	icon = 'icons/obj/doors/airlocks/centcom/centcom.dmi'
	overlays_file = 'icons/obj/doors/airlocks/centcom/overlays.dmi'
	airlock_type = /obj/machinery/door/airlock/grunge
	noglass = TRUE

/obj/structure/door_assembly/door_assembly_gold
	name = "黄金气闸组件"
	icon = 'icons/obj/doors/airlocks/station/gold.dmi'
	base_name = "黄金气闸"
	airlock_type = /obj/machinery/door/airlock/gold
	mineral = "gold"
	glass_type = /obj/machinery/door/airlock/gold/glass

/obj/structure/door_assembly/door_assembly_silver
	name = "白银气闸组件"
	icon = 'icons/obj/doors/airlocks/station/silver.dmi'
	base_name = "白银气闸"
	airlock_type = /obj/machinery/door/airlock/silver
	mineral = "silver"
	glass_type = /obj/machinery/door/airlock/silver/glass

/obj/structure/door_assembly/door_assembly_diamond
	name = "钻石气闸组件"
	icon = 'icons/obj/doors/airlocks/station/diamond.dmi'
	base_name = "钻石气闸"
	airlock_type = /obj/machinery/door/airlock/diamond
	mineral = "diamond"
	glass_type = /obj/machinery/door/airlock/diamond/glass

/obj/structure/door_assembly/door_assembly_uranium
	name = "铀气闸组件"
	icon = 'icons/obj/doors/airlocks/station/uranium.dmi'
	base_name = "铀气闸"
	airlock_type = /obj/machinery/door/airlock/uranium
	mineral = "uranium"
	glass_type = /obj/machinery/door/airlock/uranium/glass

/obj/structure/door_assembly/door_assembly_plasma
	name = "等离子气闸组件"
	icon = 'icons/obj/doors/airlocks/station/plasma.dmi'
	base_name = "等离子气闸"
	airlock_type = /obj/machinery/door/airlock/plasma
	mineral = "plasma"
	glass_type = /obj/machinery/door/airlock/plasma/glass

/obj/structure/door_assembly/door_assembly_bananium
	name = "香蕉矿气闸组件"
	desc = "Honk."
	icon = 'icons/obj/doors/airlocks/station/bananium.dmi'
	base_name = "香蕉矿气闸"
	airlock_type = /obj/machinery/door/airlock/bananium
	mineral = "bananium"
	glass_type = /obj/machinery/door/airlock/bananium/glass

/obj/structure/door_assembly/door_assembly_sandstone
	name = "砂岩气闸组件"
	icon = 'icons/obj/doors/airlocks/station/sandstone.dmi'
	base_name = "砂岩气闸"
	airlock_type = /obj/machinery/door/airlock/sandstone
	mineral = "sandstone"
	glass_type = /obj/machinery/door/airlock/sandstone/glass

/obj/structure/door_assembly/door_assembly_titanium
	name = "钛气闸组件"
	icon = 'icons/obj/doors/airlocks/shuttle/shuttle.dmi'
	base_name = "穿梭机气闸"
	overlays_file = 'icons/obj/doors/airlocks/shuttle/overlays.dmi'
	glass_type = /obj/machinery/door/airlock/titanium/glass
	airlock_type = /obj/machinery/door/airlock/titanium
	mineral = "titanium"

/obj/structure/door_assembly/door_assembly_wood
	name = "木质气闸组件"
	icon = 'icons/obj/doors/airlocks/station/wood.dmi'
	base_name = "木质气闸"
	airlock_type = /obj/machinery/door/airlock/wood
	mineral = "wood"
	glass_type = /obj/machinery/door/airlock/wood/glass

/obj/structure/door_assembly/door_assembly_bronze
	name = "青铜气闸组件"
	icon = 'icons/obj/doors/airlocks/clockwork/pinion_airlock.dmi'
	base_name = "青铜气闸"
	airlock_type = /obj/machinery/door/airlock/bronze
	noglass = TRUE
	material_type = /obj/item/stack/sheet/bronze
	custom_materials = list(/datum/material/bronze = SHEET_MATERIAL_AMOUNT * 4)

/obj/structure/door_assembly/door_assembly_bronze/seethru
	airlock_type = /obj/machinery/door/airlock/bronze/seethru

/obj/structure/door_assembly/door_assembly_material
	name = "气闸组件"
	airlock_type = /obj/machinery/door/airlock/material
	glass_type = /obj/machinery/door/airlock/material/glass
	greyscale_config = /datum/greyscale_config/material_airlock
	nomineral = TRUE
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_AFFECT_STATISTICS

/obj/structure/door_assembly/multi_tile/door_assembly_public
	name = "大型公共气闸组件"
	base_name = "大型公共气闸"

/obj/structure/door_assembly/multi_tile/door_assembly_tram
	name = "电车门组件"
	icon = 'icons/obj/doors/airlocks/tram/tram.dmi'
	base_name = "电车门"
	overlays_file = 'icons/obj/doors/airlocks/tram/tram-overlays.dmi'
	glass_type = /obj/machinery/door/airlock/tram
	airlock_type = /obj/machinery/door/airlock/tram
	glass = FALSE
	noglass = TRUE
	mineral = "titanium"
	material_type = /obj/item/stack/sheet/mineral/titanium
	custom_materials = list(/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 8)

/obj/structure/door_assembly/door_assembly_material/atom_deconstruct(disassembled = TRUE)
	var/turf/target_turf = get_turf(src)
	for(var/datum/material/material_datum as anything in custom_materials)
		var/material_count = FLOOR(custom_materials[material_datum] / SHEET_MATERIAL_AMOUNT, 1)
		if(!disassembled)
			material_count = rand(FLOOR(material_count/2, 1), material_count)
		new material_datum.sheet_type(target_turf, material_count)
	if(glass)
		if(disassembled)
			if(heat_proof_finished)
				new /obj/item/stack/sheet/rglass(target_turf)
			else
				new /obj/item/stack/sheet/glass(target_turf)
		else
			new /obj/item/shard(target_turf)

/obj/structure/door_assembly/door_assembly_material/finish_door()
	var/obj/machinery/door/airlock/door = ..()
	door.set_custom_materials(custom_materials)
	door.update_appearance()
	return door
