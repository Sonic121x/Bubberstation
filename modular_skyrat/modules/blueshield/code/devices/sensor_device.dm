/obj/item/sensor_device/blueshield
	name = "蓝盾手持监控仪"
	desc = "一款独特的手持船员监控仪，似乎为行政保护用途做过专门改装。"
	icon = 'modular_skyrat/modules/blueshield/icons/device.dmi'
	icon_state = "blueshield_scanner"

/obj/item/sensor_device/blueshield/attack_self(mob/user)
	GLOB.blueshield_crewmonitor.show(user,src)
