/* Types of tanks!
 * Contains:
 * Oxygen
 * Anesthetic
 * Air
 * Plasma
 * Emergency Oxygen
 * Generic
 */
/obj/item/tank/internals
	interaction_flags_click = FORBID_TELEKINESIS_REACH|NEED_HANDS|ALLOW_RESTING


/// Allows carbon to toggle internals via AltClick of the equipped tank.
/obj/item/tank/internals/click_alt(mob/user)
	toggle_internals(user)
	return CLICK_ACTION_SUCCESS

/obj/item/tank/internals/examine(mob/user)
	. = ..()
	. += span_notice("Alt 点击气罐可切换阀门。")

/*
 * Oxygen
 */
/obj/item/tank/internals/oxygen
	name = "氧气罐"
	desc = "一罐氧气，这罐是蓝色的。"
	icon_state = "oxygen"
	inhand_icon_state = "oxygen_tank"
	tank_holder_icon_state = "holder_oxygen"
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE
	force = 10
	dog_fashion = /datum/dog_fashion/back


/obj/item/tank/internals/oxygen/populate_gas()
	air_contents.set_gas(/datum/gas/oxygen, (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))


/obj/item/tank/internals/oxygen/yellow
	desc = "一罐氧气，这罐是黄色的。"
	icon_state = "oxygen_f"
	inhand_icon_state = "oxygen_f_tank"
	tank_holder_icon_state = "holder_oxygen_f"
	dog_fashion = null

/obj/item/tank/internals/oxygen/red
	desc = "一罐氧气，这罐是红色的。"
	icon_state = "oxygen_fr"
	inhand_icon_state = "oxygen_fr_tank"
	tank_holder_icon_state = "holder_oxygen_fr"
	dog_fashion = null

/obj/item/tank/internals/oxygen/empty/populate_gas()
	return

/*
 * Anesthetic
 */
/obj/item/tank/internals/anesthetic
	name = "麻醉气体罐"
	desc = "一罐 N2O/O2 混合气体。"
	icon_state = "anesthetic"
	inhand_icon_state = "an_tank"
	tank_holder_icon_state = "holder_anesthetic"
	force = 10

/obj/item/tank/internals/anesthetic/populate_gas()
	air_contents.set_gas(/datum/gas/oxygen, (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD)
	air_contents.set_gas(/datum/gas/nitrous_oxide, (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD)


/obj/item/tank/internals/anesthetic/examine(mob/user)
	. = ..()
	. += span_notice("[src]上刻着一行警告……")
	. += span_warning("人体没有任何过程会消耗 N2O，所以患者会把 N2O 呼出来……让你也暴露其中。务必在通风良好的地方操作，以免发生犯困的意外。")

/obj/item/tank/internals/anesthetic/pure
	desc = "一罐纯 N2O。罐身上草草地贴了一张警告贴纸。"
	icon_state = "anesthetic_warning"

/obj/item/tank/internals/anesthetic/pure/populate_gas()
	air_contents.adjust_gas(/datum/gas/nitrous_oxide, (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/*
 * Plasma
 */
/obj/item/tank/internals/plasma
	name = "等离子气罐"
	desc = "内装危险的等离子体。请勿吸入。警告：极易燃。"
	icon_state = "plasma"
	inhand_icon_state = "plasma_tank"
	worn_icon_state = "plasmatank"
	tank_holder_icon_state = null
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = null //they have no straps!
	force = 8


/obj/item/tank/internals/plasma/populate_gas()
	air_contents.set_gas(/datum/gas/plasma, (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/tank/internals/plasma/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/flamethrower))
		return ..()
	var/obj/item/flamethrower/spewer = tool
	if (spewer.status || spewer.ptank)
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(src, spewer))
		return ITEM_INTERACT_BLOCKING
	master = spewer // does master even do anything anymore?
	spewer.ptank = src
	spewer.update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/tank/internals/plasma/full/populate_gas()
	air_contents.set_gas(/datum/gas/plasma, (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/tank/internals/plasma/empty/populate_gas()
	return

/*
 * Plasmaman Plasma Tank
 */

/obj/item/tank/internals/plasmaman
	name = "等离子供气罐"
	desc = "一罐专为内部供气设计的等离子气体，尤其适合以等离子为生的生命体。如果你不是等离子人，大概不该用它。"
	icon_state = "plasmaman_tank"
	inhand_icon_state = "plasmaman_tank"
	tank_holder_icon_state = null
	force = 10
	distribute_pressure = TANK_PLASMAMAN_RELEASE_PRESSURE

/obj/item/tank/internals/plasmaman/populate_gas()
	air_contents.set_gas(/datum/gas/plasma, (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/tank/internals/plasmaman/full/populate_gas()
	air_contents.set_gas(/datum/gas/plasma, (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))


/obj/item/tank/internals/plasmaman/belt
	icon_state = "plasmaman_tank_belt"
	inhand_icon_state = "plasmaman_tank_belt"
	worn_icon_state = "plasmaman_tank_belt"
	tank_holder_icon_state = null
	worn_icon = null
	slot_flags = ITEM_SLOT_BELT
	force = 5
	volume = 6 //same size as the engineering ones but plasmamen have special lungs that consume less plasma per breath
	w_class = WEIGHT_CLASS_SMALL //thanks i forgot this
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.8)

/obj/item/tank/internals/plasmaman/belt/full/populate_gas()
	air_contents.set_gas(/datum/gas/plasma, (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/tank/internals/plasmaman/belt/empty/populate_gas()
	return



/*
 * Emergency Oxygen
 */
/obj/item/tank/internals/emergency_oxygen
	name = "应急氧气罐"
	desc = "用于紧急情况。含氧量非常少，所以尽量省着用，留到真正需要的时候。"
	icon_state = "emergency"
	inhand_icon_state = "emergency_tank"
	worn_icon_state = "emergency"
	tank_holder_icon_state = "holder_emergency"
	worn_icon = null
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	force = 4
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE
	volume = 3 //Tiny. Real life equivalents only have 21 breaths of oxygen in them. They're EMERGENCY tanks anyway -errorage (dangercon 2011)
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/tank/internals/emergency_oxygen/populate_gas()
	air_contents.set_gas(/datum/gas/oxygen, (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))


/obj/item/tank/internals/emergency_oxygen/empty/populate_gas()
	return

/obj/item/tank/internals/emergency_oxygen/engi
	name = "扩容应急氧气罐"
	icon_state = "emergency_engi"
	inhand_icon_state = "emergency_engi_tank"
	worn_icon_state = "emergency_engi"
	tank_holder_icon_state = "holder_emergency_engi"
	worn_icon = null
	volume = 6 // should last 24 minutes if full
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.75)

/obj/item/tank/internals/emergency_oxygen/engi/empty/populate_gas()
	return

/obj/item/tank/internals/emergency_oxygen/double
	name = "双联应急氧气罐"
	icon_state = "emergency_double"
	worn_icon_state = "emergency_engi"
	tank_holder_icon_state = "holder_emergency_engi"
	volume = 12 //If it's double of the above, shouldn't it be double the volume??
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)

/obj/item/tank/internals/emergency_oxygen/double/empty/populate_gas()
	return

// *
// * GENERIC
// *

/obj/item/tank/internals/generic
	name = "气罐"
	desc = "用于储存和运输气体的通用气罐。可作内部供气使用。"
	icon_state = "generic"
	inhand_icon_state = "generic_tank"
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE
	force = 10
	dog_fashion = /datum/dog_fashion/back
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/tank/internals/generic/populate_gas()
	return

/*
 * Funny internals
 */
/obj/item/tank/internals/emergency_oxygen/engi/clown
	name = "搞怪应急氧气罐"
	desc = "用于紧急情况。含氧量非常少，还额外掺了一种搞怪气体，所以尽量省着用，留到真正需要的时候。"
	icon_state = "emergency_clown"
	inhand_icon_state = "emergency_clown"
	worn_icon_state = "emergency_clown"
	tank_holder_icon_state = "holder_emergency_clown"
	distribute_pressure = TANK_CLOWN_RELEASE_PRESSURE

/obj/item/tank/internals/emergency_oxygen/engi/clown/n2o

/obj/item/tank/internals/emergency_oxygen/engi/clown/n2o/populate_gas()
	air_contents.set_gas(/datum/gas/oxygen, (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.95)
	air_contents.set_gas(/datum/gas/nitrous_oxide, (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.05)

/obj/item/tank/internals/emergency_oxygen/engi/clown/bz

/obj/item/tank/internals/emergency_oxygen/engi/clown/bz/populate_gas()
	air_contents.set_gas(/datum/gas/oxygen,(10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.9)
	air_contents.set_gas(/datum/gas/bz,(10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.1)

/obj/item/tank/internals/emergency_oxygen/engi/clown/helium
	distribute_pressure = TANK_CLOWN_RELEASE_PRESSURE + 2

/obj/item/tank/internals/emergency_oxygen/engi/clown/helium/populate_gas()
	air_contents.set_gas(/datum/gas/oxygen, (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.75)
	air_contents.set_gas(/datum/gas/helium, (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.25)
