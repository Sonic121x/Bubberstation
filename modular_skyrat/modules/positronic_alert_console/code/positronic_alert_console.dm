/obj/machinery/posialert
	name = "自动正电子人格提示终端"
	desc = "当有正电子人格可供下载时，会发出提示音的控制台。"
	icon = 'modular_skyrat/modules/positronic_alert_console/icons/terminals.dmi'
	icon_state = "posialert"
	// to create a cooldown so if roboticists are tired of ghosts
	COOLDOWN_DECLARE(robotics_cooldown)
	/// the reason that the console is muted (player decided)
	var/mute_reason
	// to create a cooldown so ghosts cannot spam it
	COOLDOWN_DECLARE(ghost_cooldown)
	/// The encryption key typepath that will be used by the console.
	var/radio_key = /obj/item/encryptionkey/headset_sci
	/// The radio used to send messages over the science channel.
	var/obj/item/radio/radio

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/posialert, 28)

/obj/machinery/posialert/examine(mob/user)
	. = ..()
	if(!COOLDOWN_FINISHED(src, robotics_cooldown))
		. += span_notice("静音还剩[COOLDOWN_TIMELEFT(src, robotics_cooldown) * 0.1]秒。")
		. += span_notice("静音原因：[mute_reason]")
	. += span_notice("按下屏幕可静音或取消静音。")

/obj/machinery/posialert/Initialize(mapload)
	. = ..()
	radio = new(src)
	radio.keyslot = new radio_key
	radio.set_listening(FALSE)
	radio.recalculateChannels()

/obj/machinery/posialert/Destroy()
	QDEL_NULL(radio)
	. = ..()

/obj/machinery/posialert/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!COOLDOWN_FINISHED(src, robotics_cooldown))
		COOLDOWN_RESET(src, robotics_cooldown)
		to_chat(user, span_notice("你取消了[src]的静音。"))
		return
	mute_reason = null
	mute_reason = stripped_input(user, "为什么要静音？（最多20个字符）", "静音原因", "", 20)
	if(!mute_reason)
		to_chat(user, span_warning("必须提供原因才能将[src]静音！"))
		return
	COOLDOWN_START(src, robotics_cooldown, 5 MINUTES)
	to_chat(user, span_notice("你将[src]静音了五分钟。"))

/obj/machinery/posialert/attack_ghost(mob/user)
	. = ..()
	if(!COOLDOWN_FINISHED(src, robotics_cooldown))
		to_chat(user, span_warning("[src]已静音！还剩[COOLDOWN_TIMELEFT(src, robotics_cooldown) * 0.1]秒。"))
		to_chat(user, span_warning("[src]的静音原因：[mute_reason]"))
		return
	if(!COOLDOWN_FINISHED(src, ghost_cooldown))
		to_chat(user, span_warning("[src]仍在冷却中！还剩[COOLDOWN_TIMELEFT(src, ghost_cooldown) * 0.1]秒。"))
		return
	COOLDOWN_START(src, ghost_cooldown, 30 SECONDS)
	flick("posialertflash",src)
	say("有正电子人格可供下载。")
	radio.talk_into(src, "有正电子人格可供下载。", RADIO_CHANNEL_SCIENCE)
	playsound(loc, 'sound/machines/ping.ogg', 50)
