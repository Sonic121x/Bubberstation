/*
* Ghost Cafe
*/

/area/centcom/holding
	name = "拘留设施"
	mood_bonus = 25
	area_flags = parent_type::area_flags | UNLIMITED_FISHING
	mood_message = "我该好好休息一下了！"

/area/centcom/holding/cafe
	name = "幽灵咖啡厅"

/area/centcom/holding/cafe/vox
	name = "咖啡厅沃克斯包厢"

/area/centcom/holding/cafe/dorms
	name = "幽灵咖啡厅宿舍"

/area/centcom/holding/cafe/park
	name = "幽灵咖啡厅户外区"

/area/centcom/holding/cafe/station
	icon_state = "graveyard"
	icon = 'icons/area/areas_station.dmi'

/area/centcom/holding/cafe/station/service
	name = "\improper 幽灵咖啡厅服务区"
	icon_state = "kitchen"
	airlock_wires = /datum/wires/airlock/service

/area/centcom/holding/cafe/station/service/kitchen
	name = "\improper 幽灵咖啡厅厨房"
	icon_state = "kitchen"

/area/centcom/holding/cafe/station/commons/toilet/shower
	name = "\improper 幽灵咖啡厅淋浴室"
	icon_state = "shower"

/area/centcom/holding/cafe/station/commons/toilet //skibidi
	name = "\improper 幽灵咖啡厅厕所"
	icon_state = "toilet"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/centcom/holding/cafe/station/service/kitchen/coldroom
	name = "\improper 幽灵咖啡厅厨房冷库"
	icon_state = "kitchen_cold"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED
	ambience_index = AMBIENCE_SPOOKY

/area/centcom/holding/cafe/station/commons/lounge
	name = "\improper 幽灵咖啡厅酒吧休息区"
	icon_state = "lounge"
	mood_bonus = 5
	mood_message = "我喜欢待在酒吧里！"
	mood_trait = TRAIT_EXTROVERT
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/centcom/holding/cafe/station/service/hydroponics
	name = "幽灵咖啡厅水培区"
	icon_state = "hydro"
	airlock_wires = /datum/wires/airlock/service
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/centcom/holding/cafe/station/commons/fitness
	name = "\improper 幽灵咖啡厅皮革俱乐部"
	icon_state = "fitness"

/area/centcom/holding/cafe/station/commons/fitness/locker_room
	name = "\improper 幽灵咖啡厅共用更衣室"
	icon_state = "locker"

/area/centcom/holding/cafe/station/commons/fitness/recreation/sauna
	name = "\improper 幽灵咖啡厅桑拿房"
	icon_state = "sauna"

/area/centcom/holding/cafe/station/service/janitor
	name = "幽灵咖啡厅清洁间"
	icon_state = "janitor"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/centcom/holding/cafe/station/service/lawoffice
	name = "\improper 幽灵咖啡厅律师办公室"
	icon_state = "law"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/centcom/holding/cafe/station/service/barber
	name = "\improper 幽灵咖啡厅理发店"
	icon_state = "barber"

/area/centcom/holding/cafe/station/commons/kiosk
	name = "幽灵咖啡厅小卖部"
	icon_state = "commons"

/area/centcom/holding/cafe/station/medical
	name = "幽灵咖啡厅医疗部"
	icon_state = "medbay"
	ambience_index = AMBIENCE_MEDICAL
	airlock_wires = /datum/wires/airlock/medbay
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/centcom/holding/cafe/station/medical/psychology
	name = "\improper 幽灵咖啡厅心理咨询室"
	icon_state = "psychology"
	mood_bonus = 3
	mood_message = "我在这里感到安心。"
	ambientsounds = list(
		'sound/ambience/aurora_caelus/aurora_caelus_short.ogg',
		)

/area/centcom/holding/cafe/station/medical/cryo
	name = "低温治疗室"
	icon_state = "cryo"

/area/centcom/holding/cafe/station/science/robotics/augments
	name = "\improper 幽灵咖啡厅机器人学区"
	icon_state = "robotics"
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED

/area/centcom/holding/cafe/station/command
	name = "幽灵咖啡厅指挥部"
	icon_state = "command"
	ambientsounds = list(
		'sound/ambience/misc/signal.ogg',
		)
	airlock_wires = /datum/wires/airlock/command
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/centcom/holding/cafe/station/command/meeting_room
	name = "\improper 幽灵咖啡厅部门主管会议室"
	icon_state = "meeting"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

/area/centcom/holding/cafe/station/command/cap
	name = "幽灵咖啡厅舰长办公室"
	icon_state = "captain"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/centcom/holding/cafe/station/command/cap/private
	name = "幽灵咖啡厅舰长寝室"
	icon_state = "captain_private"

/area/centcom/holding/cafe/station/command/teleporter
	name = "\improper 幽灵咖啡厅传送室"
	icon_state = "teleporter"
	ambience_index = AMBIENCE_ENGI

/area/centcom/holding/cafe/station/maint
	name = "幽灵咖啡厅维护区"
	icon_state = "maint_electrical"
	ambience_index = AMBIENCE_MAINT
	airlock_wires = /datum/wires/airlock/maint
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED
	forced_ambience = TRUE
	ambient_buzz = 'sound/ambience/maintenance/source_corridor2.ogg'
	ambient_buzz_vol = 20

/area/centcom/holding/cafe/station/security
	name = "幽灵咖啡厅安保部"
	icon_state = "security"
	ambience_index = AMBIENCE_DANGER
	airlock_wires = /datum/wires/airlock/security
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/centcom/holding/cafe/station/service/library
	name = "\improper 幽灵咖啡厅图书馆"
	icon_state = "library"
	mood_bonus = 5
	mood_message = "我喜欢待在图书馆里！"
	mood_trait = TRAIT_INTROVERT
	sound_environment = SOUND_AREA_LARGE_SOFTFLOOR

/area/centcom/holding/cafe/station/engineering
	name = "幽灵咖啡厅工程部"
	icon_state = "engie"
	ambience_index = AMBIENCE_ENGI
	airlock_wires = /datum/wires/airlock/engineering
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/centcom/holding/cafe/ruin
	icon = 'icons/area/areas_ruins.dmi'

/area/centcom/holding/cafe/ruin/caves
	name = "幽灵咖啡厅洞穴"
	icon_state = "os_beta_mining"
	ambience_index = AMBIENCE_SPOOKY
	sound_environment = SOUND_ENVIRONMENT_CAVE

/area/centcom/holding/cafe/ruin/ash_walkers
	name = "幽灵咖啡厅灰行者巢穴"
	icon_state = "os_beta_mining"
	ambience_index = AMBIENCE_MINING
	sound_environment = SOUND_AREA_LAVALAND
	ambient_buzz = 'sound/ambience/lavaland/magma.ogg'

/area/centcom/holding/cafe/ruin/icemoon
	name = "幽灵咖啡厅雪原"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "mining"
	ambience_index = AMBIENCE_ICEMOON
	sound_environment = SOUND_AREA_ICEMOON
	ambient_buzz = 'sound/ambience/lavaland/magma.ogg'

/area/centcom/holding/cafe/ruin/xenonest
	name = "幽灵咖啡厅异形巢穴"
	icon_state = "os_delta_hall"
	ambience_index = AMBIENCE_SPOOKY

/area/centcom/holding/cafe/beach
	name = "幽灵咖啡厅海滩"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away"
	ambientsounds = list('sound/ambience/beach/shore.ogg', 'sound/ambience/beach/seag1.ogg','sound/ambience/beach/seag2.ogg','sound/ambience/beach/seag3.ogg','sound/ambience/misc/ambiodd.ogg','sound/ambience/medical/ambinice.ogg')

//Interlink

/area/centcom/interlink
	name = "中转站"

/area/centcom/interlink/dorm_rooms
	name = "中转站宿舍"
	mood_bonus = /area/centcom/holding::mood_bonus
	mood_message = /area/centcom/holding::mood_message

