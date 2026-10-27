/datum/round_event_control/spider_infestation
	name = "蜘蛛侵染"
	typepath = /datum/round_event/spider_infestation
	track = EVENT_TRACK_GHOSTSET
	tags = list(TAG_COMBAT, TAG_DESTRUCTIVE, TAG_CHAOTIC)
	weight = 2
	max_occurrences = 1
	min_players = 30
	category = EVENT_CATEGORY_ENTITIES
	description = "生成随时准备孵化的蜘蛛卵。"
	min_wizard_trigger_potency = 5
	max_wizard_trigger_potency = 7

/datum/round_event/spider_infestation
	announce_when = 400
	var/spawncount = 2

/datum/round_event/spider_infestation/setup()
	announce_when = rand(announce_when, announce_when + 50)

/datum/round_event/spider_infestation/announce(fake)
	priority_announce("检测到不明生命体正在进入[station_name()]。请封锁所有外部通道，包括管道和通风系统。", "生命信号警报", ANNOUNCER_ALIENS)

/datum/round_event/spider_infestation/start()
	create_midwife_eggs(spawncount)

/proc/create_midwife_eggs(amount)
	while(amount > 0)
		var/turf/spawn_loc = find_maintenance_spawn(atmos_sensitive = TRUE, require_darkness = TRUE)
		if(isnull(spawn_loc))
			return //Admins will have already been notified of the spawning failure at this point
		var/obj/effect/mob_spawn/ghost_role/spider/midwife/new_eggs = new (spawn_loc)
		new_eggs.amount_grown = 98
		amount--
	log_game("助产蛛的蜘蛛卵通过事件生成。")
	return TRUE
