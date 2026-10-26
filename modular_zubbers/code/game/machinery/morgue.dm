#define MORGUE_RADIO_COOLDOWN 1 MINUTES

/obj/structure/bodycontainer/morgue/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/morgue_radio)

/obj/structure/bodycontainer/morgue
	/// reference to internal radio in the morgue trays.
	var/obj/item/radio/headset/headset_med/radio

/datum/component/morgue_radio
	/// Typecasted reference to the current tray.
	var/obj/structure/bodycontainer/morgue/morgue
	/// Tracker for the morgue radio cooldown.
	COOLDOWN_DECLARE(radio_cooldown)

/datum/component/morgue_radio/Initialize(...)
	. = ..()
	morgue = parent
	if(!istype(morgue))
		return COMPONENT_INCOMPATIBLE

/datum/component/morgue_radio/RegisterWithParent()
	// Initialize the radio in the morgue tray.
	// Put it in the connected tray because ironically that makes it not pop out when the morgue is opened.
	morgue.radio = new /obj/item/radio/headset/headset_med(morgue.connected)
	morgue.radio.set_listening(FALSE)
	RegisterSignal(morgue, COMSIG_MORGUE_ALARM, PROC_REF(morgue_revivable))

/datum/component/morgue_radio/UnregisterFromParent()
	QDEL_NULL(morgue.radio)
	UnregisterSignal(morgue, COMSIG_MORGUE_ALARM)

/// Proc that runs code to speak into the morgues internal radio.
/datum/component/morgue_radio/proc/morgue_revivable(cadaver)
	SIGNAL_HANDLER
	if(!morgue?.radio) // Runtime prevention
		return
	if(!COOLDOWN_FINISHED(src, radio_cooldown))
		return
	morgue.radio.talk_into(
		morgue,
		pick(
			"[chinese_area_display(get_area_name(morgue))]的停尸托盘内检测到电活动。请联系技术支持。",
			"装袋区出现了意外的尸体。请先扫描意外的尸体，再将其放入装袋区。",
			"[chinese_area_display(get_area_name(morgue))]检测到异常活动。请检查[chinese_area_display(get_area_name(morgue))]的故障。",
			"错误。[cadaver]检测到脑电波活动。此事件已上报，请咨询医疗事故律师。",
		),
		RADIO_CHANNEL_MEDICAL,
	)

	COOLDOWN_START(src, radio_cooldown, MORGUE_RADIO_COOLDOWN)

#undef MORGUE_RADIO_COOLDOWN
