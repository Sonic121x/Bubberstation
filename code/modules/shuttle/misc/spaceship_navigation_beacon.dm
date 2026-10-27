/obj/machinery/spaceship_navigation_beacon
	name = "无线电导航巨型信标"
	desc = "一种持续在多个常用海事导航频率上广播自身位置的装置。用于在未探索或未开发区域建立穿梭机导航航点。"
	icon = 'icons/obj/machines/navigation_beacon.dmi'
	icon_state = "beacon_active"
	base_icon_state = "beacon"
	density = TRUE

	/// Locked beacons cannot be jumped to by ships.
	var/locked = FALSE
	/// Time between automated messages.
	var/automatic_message_cooldown = 5 MINUTES
	/// Next world tick to send an automatic message.
	var/next_automatic_message_time
	/// Our internal radio.
	var/obj/item/radio/radio

/obj/machinery/spaceship_navigation_beacon/Initialize(mapload)
	. = ..()
	SSshuttle.beacon_list |= src

	name = "[initial(src.name)] [z]-[rand(0, 999)]"

	var/static/list/multitool_tips = list(
		TOOL_MULTITOOL = list(
			SCREENTIP_CONTEXT_LMB = "编辑信标名称",
			SCREENTIP_CONTEXT_RMB = "锁定/解锁信标",
		)
	)
	AddElement(/datum/element/contextual_screentip_tools, multitool_tips)

	radio = new(src)
	radio.set_listening(FALSE)
	radio.set_frequency(FREQ_RADIO_NAV_BEACON)
	radio.freqlock = RADIO_FREQENCY_LOCKED
	radio.recalculateChannels()

	START_PROCESSING(SSmachines, src)
	COOLDOWN_START(src, next_automatic_message_time, automatic_message_cooldown)

/obj/machinery/spaceship_navigation_beacon/emp_act(severity)
	. = ..()
	locked = TRUE
	update_appearance(UPDATE_ICON_STATE)

/obj/machinery/spaceship_navigation_beacon/Destroy()
	SSshuttle.beacon_list -= src
	return ..()

/obj/machinery/spaceship_navigation_beacon/update_icon_state()
	icon_state = "[base_icon_state][locked ? "_locked" : "_active"]"
	return ..()

/obj/machinery/spaceship_navigation_beacon/multitool_act(mob/living/user, obj/item/tool)
	..()

	var/chosen_tag = tgui_input_text(user, "输入此信标的自定义名称", "信标重新分类", max_length = MAX_NAME_LEN)
	if(!chosen_tag)
		return

	var/new_name = "[initial(src.name)] [chosen_tag]"
	if(new_name && Adjacent(user))
		name = new_name
		balloon_alert_to_viewers("信标已重命名")

	return TRUE

/obj/machinery/spaceship_navigation_beacon/multitool_act_secondary(mob/living/user, obj/item/tool)
	..()

	locked = !locked

	balloon_alert_to_viewers("[!locked ? "已解锁" : "已锁定"]")
	update_icon_state()

	return TRUE

/obj/machinery/spaceship_navigation_beacon/examine()
	.=..()
	. += span_notice("侧面印着“[FREQ_RADIO_NAV_BEACON / 10] kHz”。")
	if(locked)
		. += span_warning("正面闪烁的红灯表明此信标已锁定。")
	else
		. += span_notice("正面闪烁的绿灯表明此信标运行正常。")

/obj/machinery/spaceship_navigation_beacon/process(seconds_per_tick)
	if(COOLDOWN_FINISHED(src, next_automatic_message_time) && radio)
		var/automatic_nav_message = "[src]，第 [z] 星区，[locked ? "信标已锁定" : "信标运行中"]，网格坐标，[x] 东，[y] 北。"

		radio.talk_into(src, "[automatic_nav_message]")

		COOLDOWN_START(src, next_automatic_message_time, automatic_message_cooldown)

// Item used to actually make nav beacons

/obj/item/folded_navigation_gigabeacon
	name = "紧凑型无线电导航巨型信标"
	desc = "一种紧凑型无线电导航巨型信标，用于在未探索区域提供穿梭机导航航点。使用前必须部署。"
	icon = 'icons/obj/machines/navigation_beacon.dmi'
	icon_state = "beacon_folded"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/folded_navigation_gigabeacon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/deployable, 3 SECONDS, /obj/machinery/spaceship_navigation_beacon)

/obj/item/folded_navigation_gigabeacon/examine()
	.=..()
	. += span_notice("背面用多种银河语言写有说明，详细介绍如何无需任何特殊工具<b>在手中</b>部署它。")
	. += span_notice("侧面印着“[FREQ_RADIO_NAV_BEACON / 10] kHz”。")
