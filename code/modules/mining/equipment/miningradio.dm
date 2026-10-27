/// Portable mining radio purchasable by miners
/obj/item/radio/weather_monitor
	icon = 'icons/obj/devices/miningradio.dmi'
	name = "采矿气象电台"
	icon_state = "miningradio"
	desc = "专为恶劣环境设计的气象电台。风暴逼近时会发出可听见的警报。可接入货运频道。"
	freqlock = RADIO_FREQENCY_LOCKED
	light_power = 1
	light_range = 1.6

/obj/item/radio/weather_monitor/update_overlays()
	. = ..()
	. += emissive_appearance(icon, "small_emissive", src, alpha = src.alpha)

/obj/item/radio/weather_monitor/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/weather_announcer, \
		state_normal = "weatherwarning", \
		state_warning = "urgentwarning", \
		state_danger = "direwarning", \
		radar_z_trait = ZTRAIT_MINING, \
	)
	set_frequency(FREQ_SUPPLY)
