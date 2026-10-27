/obj/item/gps/computer/beacon
	name = "\improper GPS 信标"
	desc = "一台 GPS 信标，固定在地面上以防丢失或被意外移动。"
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/gps_beacon.dmi'
	icon_state = "gps_beacon"
	pixel_y = 0
	/// What this is undeployed back into
	var/undeploy_type = /obj/item/flatpacked_machine/gps_beacon

/obj/item/gps/computer/beacon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, undeploy_type, 2 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

/obj/item/flatpacked_machine/gps_beacon
	name = "打包的 GPS 信标"
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/gps_beacon.dmi'
	icon_state = "beacon_folded"
	w_class = WEIGHT_CLASS_SMALL
	type_to_deploy = /obj/item/gps/computer/beacon

/obj/item/flatpacked_machine/gps_beacon/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)
