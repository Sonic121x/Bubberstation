/obj/item/sensor_device
	name = "手持船员监控仪" //Thanks to Gun Hog for the name!
	desc = "追踪全站制服传感器的微型设备。"
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "crew_monitor"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	custom_price = PAYCHECK_CREW * 5
	custom_premium_price = PAYCHECK_CREW * 6
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP

/obj/item/sensor_device/attack_self(mob/user)
	GLOB.crewmonitor.show(user,src) //Proc already exists, just had to call it

/obj/item/sensor_device/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/drag_to_activate)
