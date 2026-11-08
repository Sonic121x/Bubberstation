/datum/round_event_control/drop_troopers_syndicate_lesser
	name = "空降部队：辛迪加（小规模）"
	description = "辛迪加派出少量空降士兵袭击空间站。"
	typepath = /datum/round_event/droppod_airraid/syndicate/lesser
	weight = 10
	max_occurrences = 1
	min_players = 12
	category = EVENT_CATEGORY_ENTITIES
	track = EVENT_TRACK_MUNDANE
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_NPC_ANTAG)

/datum/round_event/droppod_airraid/syndicate/lesser
	turf_droppods_ratio = 50
	spawn_wave_total_lower = 1
	spawn_wave_total_upper = 3
	droppod_density = 1
	boss_types = list()
	max_boss_pods = 0
	time_to_next_wave_droppod_factor = 50

/datum/round_event/droppod_airraid/syndicate/lesser/announce(fake)
	priority_announce("警报！辛迪加正向[GLOB.station_name]派遣一支袭扰小队。请做好冲击准备。", "敌方侦察部队来袭", sound = 'sound/announcer/notice/notice1.ogg', color_override = "orange")


//////////////////////////////////////
//////////////// BOTS ////////////////
//////////////////////////////////////

/datum/round_event_control/drop_troopers_hivebots
	name = "空降部队：蜂巢机器人"
	description = "一支自主机器人入侵舰队袭击空间站。"
	typepath = /datum/round_event/droppod_airraid/hivebots
	weight = 10
	max_occurrences = 2
	min_players = 20
	admin_setup = list()
	//admin_setup = list(/datum/event_admin_setup/multiple_choice/droppod_troopers)
	category = EVENT_CATEGORY_ENTITIES
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_NPC_ANTAG)

/datum/round_event/droppod_airraid/hivebots
	turf_droppods_ratio = 50
	spawn_wave_total_lower = 3
	spawn_wave_total_upper = 5
	droppod_density = 5
	enemy_types = list(
		/mob/living/basic/hivebot/range, \
		/mob/living/basic/hivebot/rapid, \
		/mob/living/basic/hivebot/strong, \
		/mob/living/basic/hivebot/mechanic, \
	)
	max_boss_pods = 0
	time_to_next_wave_droppod_factor = 50

	droppod_style = /datum/pod_style
	max_droppod_dropdelay = 10
	min_droppod_dropdelay = 30

/datum/round_event/droppod_airraid/hivebots/announce(fake)
	priority_announce("警报！侦测到身份不明的空投舱正飞往[GLOB.station_name]。请做好冲击准备。", "不明空投舱", sound = 'sound/announcer/notice/notice1.ogg', color_override = "orange")

/datum/round_event/droppod_airraid/hivebots/announce_end()
	priority_announce("空投舱舰队对[GLOB.station_name]的撞击已停止。请保持镇定，返回工作岗位。")
