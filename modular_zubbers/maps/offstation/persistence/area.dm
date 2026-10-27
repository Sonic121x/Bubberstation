// Persistance Areas - Lavaland

/area/ruin/space/has_grav/bubbers/persistance
	name = "SSV 恒久号"
	icon = 'icons/area/areas_centcom.dmi'
	icon_state = "syndie-ship"
	outdoors = FALSE
	ignore_weather_sfx = TRUE
	flags_1 = parent_type::flags_1 & ~(CAN_BE_DIRTY_1) // Stops SSDecay from affecting the Persistance

// Cargo

/area/ruin/space/has_grav/bubbers/persistance/cargo
	name = "恒久号机库"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/cargo/dispoals
	name = "恒久号垃圾处理系统"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/cargo/drone
	name = "恒久号远程监控与无人机部署区"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/cargo/mining
	name = "恒久号采矿设备室"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

// Engineering

/area/ruin/space/has_grav/bubbers/persistance/engineering
	name = "恒久号工程舱"

/area/ruin/space/has_grav/bubbers/persistance/engineering/atmospherics
	name = "恒久号大气室"

/area/ruin/space/has_grav/bubbers/persistance/engineering/mining
	name = "恒久号蓝空间采矿区"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/engineering/gas
	name = "恒久号气体采集与储存区"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/engineering/utilities
	name = "恒久号公用设施系统"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

// Service - Recreation

/area/ruin/space/has_grav/bubbers/persistance/service
	name = "主厅"

/area/ruin/space/has_grav/bubbers/persistance/evac
	name = "恒久号撤离舱停泊区"

/area/ruin/space/has_grav/bubbers/persistance/service/diner
	name = "恒久号餐厅"
	mood_bonus = 3
	mood_message = "我喜欢待在餐厅里！"

/area/ruin/space/has_grav/bubbers/persistance/service/kitchen
	name = "恒久号厨房"

/area/ruin/space/has_grav/bubbers/persistance/service/freezer
	name = "恒久号厨房冷库"

/area/ruin/space/has_grav/bubbers/persistance/service/hydro
	name = "恒久号水培区"

/area/ruin/space/has_grav/bubbers/persistance/service/shower
	name = "恒久号船员淋浴室"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/service/lockers
	name = "恒久号更衣室"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/service/gym
	name = "恒久号健身房"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/ruin/space/has_grav/bubbers/persistance/service/lounge
	name = "恒久号休息室"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED
	mood_bonus = 5
	mood_message = "我在这里感到安心。"

/area/ruin/space/has_grav/bubbers/persistance/service/janitorial
	name = "恒久号清洁工具储藏室"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/ruin/space/has_grav/bubbers/persistance/service/salon
	name = "恒久号沙龙"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/ruin/space/has_grav/bubbers/persistance/service/sauna
	name = "恒久号桑拿房"
	mood_bonus = 5
	mood_message = "这地方挺让人放松的。"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

//dorms
/area/ruin/space/has_grav/bubbers/persistance/service/dorms
	name = "恒久号宿舍区"
	mood_bonus = 5
	mood_message = "我在这里感到安心。"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/engineering
	name = "恒久号工程部寝室"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/science
	name = "恒久号研究员寝室"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/chef
	name = "恒久号调酒师寝室"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/janitor
	name = "恒久号清洁技术员寝室"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/cargo
	name = "恒久号货运主管寝室"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/liason
	name = "恒久号企业联络官寝室"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/assistant
	name = "恒久号助理寝室"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/morale
	name = "恒久号士气官寝室"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/maa
	name = "恒久号纠察长寝室"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/brig
	name = "恒久号拘留区长官寝室"

/area/ruin/space/has_grav/bubbers/persistance/service/dorms/medical
	name = "恒久号医疗官寝室"

// Science

/area/ruin/space/has_grav/bubbers/persistance/sci
	name = "恒久号科研部"

/area/ruin/space/has_grav/bubbers/persistance/sci/rnd
	name = "恒久号实验室"

/area/ruin/space/has_grav/bubbers/persistance/sci/robotics
	name = "恒久号机器人实验室"

/area/ruin/space/has_grav/bubbers/persistance/sci/ordnance
	name = "恒久号军械实验室"

/area/ruin/space/has_grav/bubbers/persistance/sci/xenobio
	name = "恒久号异种生物实验室"

/area/ruin/space/has_grav/bubbers/persistance/sci/xenoarchology
	name = "恒久号考古实验室"

// Medical

/area/ruin/space/has_grav/bubbers/persistance/med
	name = "恒久号医疗部"

/area/ruin/space/has_grav/bubbers/persistance/med/treatment
	name = "恒久号治疗舱"

/area/ruin/space/has_grav/bubbers/persistance/med/storage
	name = "恒久号医疗储藏室"

/area/ruin/space/has_grav/bubbers/persistance/med/chem
	name = "恒久号化学实验室"

/area/ruin/space/has_grav/bubbers/persistance/med/viro
	name = "恒久号病毒研究实验室"

/area/ruin/space/has_grav/bubbers/persistance/command
	name = "恒久号指挥部"

/area/ruin/space/has_grav/bubbers/persistance/command/bridge
	name = "恒久号舰桥"

/area/ruin/space/has_grav/bubbers/persistance/command/admiral
	name = "恒久号办公室"

/area/ruin/space/has_grav/bubbers/persistance/command/liason
	name = "企业联络官办公室"

/area/ruin/space/has_grav/bubbers/persistance/command/vault
	name = "高安保金库"

/area/ruin/space/has_grav/bubbers/persistance/command/maa
	name = "纠察长办公室"

//Security - Prison

/area/ruin/space/has_grav/bubbers/persistance/sec
	name = "恒久号安保部"

/area/ruin/space/has_grav/bubbers/persistance/sec/brigentrance
	name = "恒久号拘留区值班台与牢房"

/area/ruin/space/has_grav/bubbers/persistance/sec/holding
	name = "拘留牢房"

/area/ruin/space/has_grav/bubbers/persistance/sec/armory
	name = "恒久号军械库"

/area/ruin/space/has_grav/bubbers/persistance/sec/interrogation
	name = "审讯与处理室"

/area/ruin/space/has_grav/bubbers/persistance/sec/prison // Prison
	name = "恒久号公共监区"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/ruin/space/has_grav/bubbers/persistance/sec/prison/holding
	name = "隔离牢房"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/bubbers/persistance/sec/prison/rec
	name = "囚犯活动室"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/ruin/space/has_grav/bubbers/persistance/sec/prison/shower
	name = "监狱淋浴室"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/datum/weather/rad_storm/New()
	. = ..()
	protected_areas += /area/ruin/space/has_grav/bubbers/persistance

//roof areas
/area/ruin/space/has_grav/bubbers/persistance/roof
	name= "恒久号屋顶"
	outdoors = TRUE
	sound_environment = SOUND_AREA_ICEMOON
	ignore_weather_sfx = FALSE

/area/ruin/space/has_grav/bubbers/persistance/shieldgen
	name= "恒久号护盾发生器"
	outdoors = TRUE
	sound_environment = SOUND_AREA_ICEMOON
	ignore_weather_sfx = FALSE

/area/ruin/space/has_grav/bubbers/persistance/controltower
	name= "恒久号穿梭机控制室"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED
