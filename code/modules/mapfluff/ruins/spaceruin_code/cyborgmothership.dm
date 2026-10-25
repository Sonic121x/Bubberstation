/obj/docking_port/stationary/cyborg_mothership
	name = "半机械人母舰"
	shuttle_id = "cyborg_mothership"
	roundstart_template = /datum/map_template/shuttle/ruin/cyborg_mothership
	dir = SOUTH
	width = 23
	height = 30
	dwidth = 11

/obj/docking_port/mobile/cyborg_mothership
	name = "半机械人母舰"
	shuttle_id = "cyborg_mothership"
	dir = SOUTH
	dwidth = 11
	width = 23
	height = 23
	launch_status = 0
	callTime = 25 SECONDS
	movement_force = list("KNOCKDOWN" = 0,"THROW" = 0)

/obj/item/circuitboard/computer/cyborg_mothership
	name = "#101011"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/cyborg_mothership

/obj/item/circuitboard/computer/cyborg_mothership/bridge
	name = "#101011 舰桥"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/cyborg_mothership/bridge

/obj/machinery/computer/shuttle/cyborg_mothership
	name = "#101011 控制台"
	desc = "用于控制半机械人母舰。"
	circuit = /obj/item/circuitboard/computer/cyborg_mothership
	shuttleId = "cyborg_mothership"
	possible_destinations = "whiteship_away;whiteship_home;whiteship_z4;whiteship_lavaland;cyborg_mothership"

/// Console used on the cyborg_mothership bridge. Comes with GPS pre-baked.
/obj/machinery/computer/shuttle/cyborg_mothership/bridge
	name = "#101011 舰桥控制台"
	desc = "用于控制半机械人母舰。会发出微弱的 GPS 信号。"
	circuit = /obj/item/circuitboard/computer/cyborg_mothership/bridge

/obj/machinery/computer/shuttle/cyborg_mothership/bridge/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	AddComponent(/datum/component/gps, SPACE_SIGNAL_GPSTAG)

/obj/machinery/computer/camera_advanced/shuttle_docker/cyborg_mothership
	name = "#101011 导航计算机"
	desc = "用于为半机械人母舰指定精确的跃迁位置。"
	shuttleId = "cyborg_mothership"
	lock_override = NONE
	shuttlePortId = "cyborg_mothership"
	jump_to_ports = list("whiteship_away" = 1, "whiteship_home" = 1, "whiteship_z4" = 1, "cyborg_mothership" = 1)
	view_range = 10
	designate_time = 100
	y_offset = -11

/obj/machinery/computer/camera_advanced/shuttle_docker/cyborg_mothership/Initialize(mapload)
	. = ..()
	GLOB.jam_on_wardec += src

/obj/machinery/computer/camera_advanced/shuttle_docker/cyborg_mothership/Destroy()
	GLOB.jam_on_wardec -= src
	return ..()

/obj/item/disk/holodisk/ruin/cyborg_mothership
	name = "黑匣子打印件 #101011"
	desc = "一张生锈的全息磁盘，记录着 #101011 的最后时刻。"
	preset_image_type = /datum/preset_holoimage/ai
	preset_record_text = {"
		NAME 母舰
		SAY 警告——检测到太空藤蔓
		DELAY 30
		NAME 577 号单元
		PRESET /datum/preset_holoimage/robot
		SAY 正在运行诊断……藤蔓生物量似乎正在覆盖飞船的太阳能板。
		DELAY 50
		NAME 母舰
		PRESET /datum/preset_holoimage/ai
		SAY 577 号单元，请启动净化程序。能量正以指数级下降。
		DELAY 50
		NAME 577 号单元
		PRESET /datum/preset_holoimage/robot
		SAY 收到。目的地设为太阳能板。植物生物量将被清除——
		DELAY 50
		NAME 蜂巢机器人
		PRESET /datum/preset_holoimage/hivebot
		SAY 消灭，歼灭，摧毁！
		DELAY 30
		NAME 577 号单元
		PRESET /datum/preset_holoimage/robot
		SAY 未知机械生命体，表明身份！
		DELAY 30
		NAME 蜂巢机器人
		PRESET /datum/preset_holoimage/hivebot
		SAY 消灭！
		DELAY 10
		SOUND ricochet
		DELAY 10
		SOUND "sparks"
		DELAY 20
		SOUND ricochet
		DELAY 10
		SOUND swing_hit
		DELAY 20
		NAME 577 号单元
		PRESET /datum/preset_holoimage/robot
		SAY *静电噪声* 模块离线！*静电噪声* 损@伤 已&存在
		DELAY 50
		SOUND explosion_creaking
		DELAY 20
		NAME 母舰
		PRESET /datum/preset_holoimage/ai
		SAY 检测到敌对机械生命体。空间站能量已耗尽。正在关闭电源……
		DELAY 50
		NAME 蜂巢机器人
		PRESET /datum/preset_holoimage/hivebot
		SAY 搜索！定位！消灭！
		DELAY 30
		PRESET /datum/preset_holoimage/corgi
		NAME 黑匣子自动消息
		SAY 连接中断。正在将音频日志转存至磁盘。
		DELAY 50
	"}
