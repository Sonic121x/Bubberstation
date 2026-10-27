/*
 * Nitrogen Tanks for Vox
 */

/obj/item/tank/internals/nitrogen
	name = "氮气罐"
	desc = "一小罐氮气，供不呼吸标准空气混合气的船员使用。"
	icon = 'modular_skyrat/master_files/icons/obj/tank.dmi'
	icon_state = "nitrogen"
	tank_holder_icon_state = "holder_nitrogen"
	force = 10
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE
	distribute_pressure = 4 // see vox.dm for their intake values balance changes

/obj/item/tank/internals/nitrogen/populate_gas()
	air_contents.assert_gas(/datum/gas/nitrogen)
	air_contents.moles[/datum/gas/nitrogen] = (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

/obj/item/tank/internals/nitrogen/full/populate_gas()
	air_contents.assert_gas(/datum/gas/nitrogen)
	air_contents.moles[/datum/gas/nitrogen] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

/obj/item/tank/internals/nitrogen/belt
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/belt.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/equipment/tanks_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/equipment/tanks_righthand.dmi'
	icon_state = "nitrogen_emergency_ext"
	inhand_icon_state = "nitrogen"
	tank_holder_icon_state = "holder_nitrogen_emergency_ext"
	slot_flags = ITEM_SLOT_BELT
	force = 5
	volume = 12
	w_class = WEIGHT_CLASS_SMALL

/obj/item/tank/internals/nitrogen/belt/full/populate_gas()
	air_contents.assert_gas(/datum/gas/nitrogen)
	air_contents.moles[/datum/gas/nitrogen] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

/obj/item/tank/internals/nitrogen/belt/emergency
	name = "应急氮气罐"
	desc = "用于紧急情况。里面只有极少量氮气，请尽量节省，留到真正需要时再用。"
	icon_state = "nitrogen_emergency"
	tank_holder_icon_state = "holder_nitrogen_emergency"
	worn_icon_state = "nitrogen_extended"
	volume = 3

/obj/item/tank/internals/nitrogen/belt/emergency/populate_gas()
	air_contents.assert_gas(/datum/gas/nitrogen)
	air_contents.moles[/datum/gas/nitrogen] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)
