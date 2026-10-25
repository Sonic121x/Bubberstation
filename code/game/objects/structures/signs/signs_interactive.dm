/obj/structure/sign/clock
	name = "挂钟"
	desc = "再普通不过的挂钟，同时显示本地纳米传讯标准时间和银河条约协调时间。非常适合盯着发呆而不是干活。"
	icon_state = "clock"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/clock, 32)

/obj/structure/sign/clock/examine(mob/user)
	. = ..()
	. += span_info("当前 NST（本地）时间为：[server_timestamp(ic_time = TRUE, twelve_hour_clock = user.client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))]。")
	if(user.is_literate())
		. += span_info("也就是说，本班次已经过去了[round_timestamp()]。")

/obj/structure/sign/calendar
	name = "挂历"
	desc = "一款老派的挂历。虽然现代科技早就让它过时了，但还是很难想象没有它的办公室。"
	icon_state = "calendar"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/calendar, 32)

/obj/structure/sign/calendar/examine(mob/user)
	. = ..()
	. += span_info("当前日期为：[time2text(world.realtime, "DDD, MMM DD", world.timezone)]，[CURRENT_STATION_YEAR]。")
	if(length(GLOB.holidays))
		. += span_info("节日：")
		for(var/holidayname in GLOB.holidays)
			. += span_info("[holidayname]")
