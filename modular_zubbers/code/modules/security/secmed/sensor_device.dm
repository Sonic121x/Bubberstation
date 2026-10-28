/obj/item/sensor_device/secmed
	name = "安保医疗兵便携监测仪"
	desc = "一款独特的便携式船员监测仪型号，看上去是为安保医疗兵专门定制的。"
	icon = 'modular_zubbers/icons/obj/scanner.dmi'
	icon_state = "secmed_crewmonitor"

/obj/item/sensor_device/secmed/attack_self(mob/user)
	GLOB.secmed_crewmonitor.show(user,src)
