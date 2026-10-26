// A collection of pre-set uplinks, for admin spawns.

// Radio-like uplink; not an actual radio because this uplink is most commonly
// used for nuke ops, for whom opening the radio GUI and the uplink GUI
// simultaneously is an annoying distraction.
/obj/item/uplink
	name = "空间站中继无线电"
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "radio"
	inhand_icon_state = "radio"
	worn_icon_state = "radio"
	desc = "通过本地通讯网络通话的基础手持无线电。"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	dog_fashion = /datum/dog_fashion/back

	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	throw_speed = 3
	throw_range = 7
	w_class = WEIGHT_CLASS_SMALL

	/// The uplink flag for this type.
	/// See [`code/__DEFINES/uplink.dm`]
	var/uplink_flag = UPLINK_TRAITORS
	/// If the uplink is lockable, which defaults to false which most subtypes of this item are for debug reasons
	var/lockable_uplink = FALSE

/obj/item/uplink/Initialize(mapload, owner, tc_amount = 20, datum/uplink_handler/uplink_handler_override = null)
	. = ..()
	AddComponent(\
		/datum/component/uplink, \
		owner = owner, \
		lockable = lockable_uplink, \
		enabled = TRUE, \
		uplink_flag = uplink_flag, \
		starting_tc = tc_amount, \
		uplink_handler_override = uplink_handler_override, \
	)

/obj/item/uplink/debug
	name = "调试上行链路"

/obj/item/uplink/debug/Initialize(mapload, owner, tc_amount = 9000, datum/uplink_handler/uplink_handler_override = null)
	. = ..()
	var/datum/component/uplink/hidden_uplink = GetComponent(/datum/component/uplink)
	hidden_uplink.name = "调试上行链路"
	hidden_uplink.uplink_handler.debug_mode = TRUE

/obj/item/uplink/nuclear
	uplink_flag = UPLINK_NUKE_OPS

/obj/item/uplink/nuclear/debug
	name = "调试核爆上行链路"
	uplink_flag = UPLINK_ALL_SYNDIE_OPS

/obj/item/uplink/nuclear/debug/Initialize(mapload, owner, tc_amount = 9000, datum/uplink_handler/uplink_handler_override = null)
	. = ..()
	var/datum/component/uplink/hidden_uplink = GetComponent(/datum/component/uplink)
	hidden_uplink.name = "调试核爆上行链路"
	hidden_uplink.uplink_handler.debug_mode = TRUE

/obj/item/uplink/nuclear_restricted
	uplink_flag = UPLINK_NUKE_OPS

/obj/item/uplink/nuclear_restricted/Initialize(mapload)
	. = ..()
	var/datum/component/uplink/hidden_uplink = GetComponent(/datum/component/uplink)
	hidden_uplink.allow_restricted = FALSE

///A subtype used for lone ops, with some of the stuff they shouldn't/can't access removed from purchase.
/obj/item/uplink/loneop
	uplink_flag = UPLINK_LONE_OP

/obj/item/uplink/clownop
	uplink_flag = UPLINK_CLOWN_OPS

/obj/item/uplink/old
	name = "积灰的无线电"
	desc = "一台落满灰尘的无线电。"

/obj/item/uplink/old/Initialize(mapload, owner, tc_amount = 10, datum/uplink_handler/uplink_handler_override = null)
	. = ..()
	var/datum/component/uplink/hidden_uplink = GetComponent(/datum/component/uplink)
	hidden_uplink.name = "积灰的无线电"

// Multitool uplink
////obj/item/multitool/uplink/Initialize(mapload, owner, tc_amount = 20, datum/uplink_handler/uplink_handler_override = null) //ORIGINAL
/obj/item/multitool/uplink/Initialize(mapload, owner, tc_amount = 35, datum/uplink_handler/uplink_handler_override = null) //SKYRAT EDIT CHANGE. Original tc_amount = 20
	. = ..()
	AddComponent(/datum/component/uplink, owner, FALSE, TRUE, UPLINK_TRAITORS, tc_amount)

// Pen uplink
///obj/item/pen/uplink/Initialize(mapload, owner, tc_amount = 20, datum/uplink_handler/uplink_handler_override = null) //ORIGINAL
/obj/item/pen/uplink/Initialize(mapload, owner, tc_amount = 35, datum/uplink_handler/uplink_handler_override = null) //SKYRAT EDIT CHANGE. Original tc_amount = 20
	. = ..()
	AddComponent(/datum/component/uplink, owner, TRUE, FALSE, UPLINK_TRAITORS, tc_amount)
