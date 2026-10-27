///Bounties that require you to perform documentation and inspection of your department to send to centcom.
/datum/bounty/patrol
	name = "巡逻空间站"
	description = "对 %AREA_NAME% 进行例行巡逻。 \
		你必须在区域内至少行进 %AREA_COVERAGE% 米。 \
		你的 ID 卡会在你推进时更新进度。"
	reward = CARGO_CRATE_VALUE * 5
	allow_duplicate = TRUE
	global_exempt = TRUE

	/// Ref to the component applied to the ID card to track movement.
	VAR_PRIVATE/datum/tracker

	/// Typepath of what area we want patrolled.
	VAR_FINAL/area/demanded_area
	/// How much area coverage is needed to complete the patrol.
	VAR_FINAL/needed_coverage = -1
	/// List of turf IDs that have been walked on during the patrol.
	VAR_FINAL/list/walked_turfs
	/// Number 0-5 tracking which progress alerts have been sent.
	VAR_FINAL/alerted = 0

/datum/bounty/patrol/New()
	demanded_area = pick(get_patrol_area_types() & GLOB.areas_by_type)

	var/total_coverage = 0
	for(var/turf/open/floor/walkable in GLOB.areas_by_type[demanded_area].get_turfs_from_all_zlevels())
		total_coverage += 1

	needed_coverage = round(total_coverage * rand(4, 8) * 0.1, 1)

	name += ": [initial(demanded_area.name)]"
	description = replacetext(description, "%AREA_NAME%", initial(demanded_area.name))
	description = replacetext(description, "%AREA_COVERAGE%", needed_coverage)

	// scale the reward based on how big the area is, so you don't feel like you're wasting time
	// central primary hallway can have somewhere in the ballpark of 500 turfs
	// but something like the bar only sits around 100-200
	reward *= (needed_coverage / 100)

/datum/bounty/patrol/can_get()
	// only give out bounties worth completing.
	return needed_coverage >= 20

/datum/bounty/patrol/proc/get_patrol_area_types()
	return typecacheof(list(
		/area/station/commons,
		/area/station/hallway,
		/area/station/maintenance,
		/area/station/security/checkpoint,
		/area/station/security/prison,
		/area/station/service,
	))

/datum/bounty/patrol/proc/get_progress()
	var/progress = 0
	for(var/turf_id, count in walked_turfs)
		progress += count
	return progress

/datum/bounty/patrol/print_required()
	return "[get_progress()]/[needed_coverage] 米"

/datum/bounty/patrol/can_claim()
	return get_progress() >= needed_coverage

/datum/bounty/patrol/on_selected(obj/item/card/id/id_card)
	start_tracking(id_card)

/datum/bounty/patrol/proc/start_tracking(obj/item/card/id/id_card)
	contribution |= id_card.registered_account
	tracker = AddComponent(/datum/component/connect_containers, id_card, list(COMSIG_MOVABLE_MOVED = PROC_REF(on_card_moved)))
	RegisterSignal(id_card, COMSIG_MOVABLE_MOVED, PROC_REF(on_card_moved))

/datum/bounty/patrol/on_reset(obj/item/card/id/id_card)
	stop_tracking(id_card)

/datum/bounty/patrol/proc/stop_tracking(obj/item/card/id/id_card)
	QDEL_NULL(tracker)
	UnregisterSignal(id_card, COMSIG_MOVABLE_MOVED)

/datum/bounty/patrol/proc/on_card_moved(atom/movable/moving, atom/old_loc, ...)
	SIGNAL_HANDLER

	var/turf/new_turf = get_turf(moving)
	if(!isfloorturf(new_turf) || new_turf == get_turf(old_loc) || new_turf.loc.type != demanded_area)
		return

	var/turf_id = "[new_turf.x],[new_turf.y],[new_turf.z]"
	// you can retread the same tiles, but only up to three times.
	// prevents cheese (walking between the same two tiles over and over),
	// but still allows smaller rooms to be completable without being frustrating.
	if(LAZYACCESS(walked_turfs, turf_id) >= 3)
		return

	var/obj/item/card/id/id_card
	if(isliving(moving))
		var/mob/living/living_mover = moving
		id_card = living_mover.get_idcard()
	else if(isidcard(moving))
		id_card = moving
	if(isnull(id_card))
		id_card = locate() in moving.get_all_contents()

	if(id_card?.registered_account?.civilian_bounty != src)
		return

	LAZYADDASSOC(walked_turfs, turf_id, 1)
	var/progress = get_progress()
	if(alerted == 0)
		alerted = 1
		id_card.registered_account.bank_card_talk("巡逻开始。 \
			在该区域内行进 [needed_coverage] 米以完成巡逻。", force = TRUE)
		return

	var/progress_percent = progress / needed_coverage
	if(progress_percent >= 0.25 && alerted < 2)
		alerted = 2
		id_card.registered_account.bank_card_talk("巡逻已完成 25%。", force = TRUE)
		return

	if(progress_percent >= 0.5 && alerted < 3)
		alerted = 3
		id_card.registered_account.bank_card_talk("巡逻已完成 50%。", force = TRUE)
		return

	if(progress_percent >= 0.75 && alerted < 4)
		alerted = 4
		id_card.registered_account.bank_card_talk("巡逻已完成 75%。", force = TRUE)
		return

	if(progress >= needed_coverage && alerted < 5)
		alerted = 5
		id_card.registered_account.bank_card_talk("巡逻完成。 \
			返回赏金终端领取你的奖励。", force = TRUE)
		stop_tracking(id_card) // don't need this anymore
		return

/datum/bounty/patrol/supply
	name = "巡逻货运"
	allow_duplicate = FALSE

/datum/bounty/patrol/supply/get_patrol_area_types()
	return typecacheof(list(
		/area/station/cargo/breakroom,
		/area/station/cargo/lobby,
		/area/station/cargo/lower,
		/area/station/cargo/mining_breakroom,
		/area/station/cargo/miningdock,
		/area/station/cargo/miningfoundry,
		/area/station/cargo/miningoffice,
		/area/station/cargo/office,
		/area/station/cargo/sorting,
		/area/station/cargo/storage,
		/area/station/cargo/warehouse,
		/area/station/maintenance/department/cargo,
	)) + list(
		/area/station/cargo, // base cargo type as well
		/area/mine/lounge, // and public mining on lavaland
	)

/datum/bounty/patrol/medical
	name = "巡逻医疗"
	allow_duplicate = FALSE

/datum/bounty/patrol/medical/get_patrol_area_types()
	return typecacheof(list(
		/area/station/maintenance/department/medical,
		/area/station/medical/abandoned,
		/area/station/medical/break_room,
		/area/station/medical/cryo,
		/area/station/medical/exam_room,
		/area/station/medical/lower,
		/area/station/medical/medbay,
		/area/station/medical/morgue,
		/area/station/medical/office,
		/area/station/medical/storage,
		/area/station/medical/surgery,
		/area/station/medical/treatment_center,
	)) + list(
		/area/station/medical, // base medical type as well
	)

/datum/bounty/patrol/science
	name = "巡逻科研"
	allow_duplicate = FALSE

/datum/bounty/patrol/science/get_patrol_area_types()
	return typecacheof(list(
		/area/station/science/auxlab,
		/area/station/science/breakroom,
		/area/station/science/explab,
		/area/station/science/lab,
		/area/station/science/lobby,
		/area/station/science/lower,
		/area/station/science/research,
		/area/station/science/research/abandoned,
	)) + list(
		/area/station/science, // base science type as well
		/area/station/maintenance/department/science, // and only base sci maint - not xenobio maint
	)

/datum/bounty/patrol/engineering
	name = "巡逻工程"
	allow_duplicate = FALSE

/datum/bounty/patrol/engineering/get_patrol_area_types()
	return typecacheof(list(
		/area/station/engineering/break_room,
		/area/station/engineering/lobby,
		/area/station/engineering/main,
		/area/station/engineering/storage,
		/area/station/engineering/storage_shared,
		/area/station/maintenance/department/engine,
		/area/station/maintenance/department/electrical,
	)) + list(
		/area/station/engineering, // plus base engineering
		/area/station/engineering/atmos, // and base atmospherics
	)

/datum/bounty/item/contraband
	name = "没收的违禁品"
	description = "辛迪加一直在设法策反纳米传讯旗下空间站的船员。请把你最新查获的一批违禁品运送给我们。"
	reward = CARGO_CRATE_VALUE * 4
	required_count = 5
	wanted_types = list(/obj/item = TRUE)

/datum/bounty/item/contraband/applies_to(obj/O)
	return HAS_TRAIT(O, TRAIT_CONTRABAND)
