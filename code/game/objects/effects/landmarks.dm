/obj/effect/landmark
	name = "landmark"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x2"
	anchored = TRUE
	layer = OBJ_LAYER
	plane = GAME_PLANE
	invisibility = INVISIBILITY_ABSTRACT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/effect/landmark/singularity_act()
	return

/obj/effect/landmark/singularity_pull(atom/singularity, current_size)
	return

INITIALIZE_IMMEDIATE(/obj/effect/landmark)

/obj/effect/landmark/Initialize(mapload)
	. = ..()
	GLOB.landmarks_list += src

/obj/effect/landmark/Destroy()
	GLOB.landmarks_list -= src
	return ..()

/obj/effect/landmark/start
	name = "start"
	icon = 'icons/mob/landmarks.dmi'
	icon_state = "x"
	anchored = TRUE
	layer = MOB_LAYER
	var/jobspawn_override = FALSE
	var/delete_after_roundstart = TRUE
	var/used = FALSE

/obj/effect/landmark/start/proc/after_round_start()
	// We'd like to keep these around for unit tests, so we can check that they exist.
#if !defined(UNIT_TESTS) && !defined(MAP_TEST)
	if(delete_after_roundstart)
		qdel(src)
#endif

/obj/effect/landmark/start/Initialize(mapload)
	. = ..()
	GLOB.start_landmarks_list += src
	if(jobspawn_override)
		LAZYADDASSOCLIST(GLOB.jobspawn_overrides, name, src)
	if(name != "start")
		tag = "start*[name]"

/obj/effect/landmark/start/Destroy()
	GLOB.start_landmarks_list -= src
	if(jobspawn_override)
		LAZYREMOVEASSOC(GLOB.jobspawn_overrides, name, src)
	return ..()

// START LANDMARKS FOLLOW. Don't change the names unless
// you are refactoring shitty landmark code.
/obj/effect/landmark/start/assistant
	name = JOB_ASSISTANT
	icon_state = JOB_ASSISTANT //icon_state is case sensitive. why are all of these capitalized? because fuck you that's why

/obj/effect/landmark/start/assistant/override
	jobspawn_override = TRUE
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/prisoner
	name = "Prisoner"
	icon_state = "Prisoner"
	//SKYRAT EDIT: Start - Makes latejoin prisoners spawn in the prison instead of on the interlink.
	jobspawn_override = TRUE
	delete_after_roundstart = FALSE
	//SKYRAT EDIT: End - Makes latejoin prisoners spawn in the prison instead of on the interlink.

/obj/effect/landmark/start/prisoner/after_round_start()
	return

/obj/effect/landmark/start/janitor
	name = "Janitor"
	icon_state = "Janitor"

/obj/effect/landmark/start/cargo_technician
	name = "Cargo Technician"
	icon_state = "Cargo Technician"

/obj/effect/landmark/start/bitrunner
	name = "Bitrunner"
	icon_state = "Bitrunner"

/obj/effect/landmark/start/bartender
	name = "Bartender"
	icon_state = "Bartender"

/obj/effect/landmark/start/clown
	name = "Clown"
	icon_state = "Clown"

/obj/effect/landmark/start/mime
	name = "Mime"
	icon_state = "Mime"

/obj/effect/landmark/start/quartermaster
	name = "Quartermaster"
	icon_state = "Quartermaster"

/obj/effect/landmark/start/atmospheric_technician
	name = "Atmospheric Technician"
	icon_state = "Atmospheric Technician"

/obj/effect/landmark/start/cook
	name = "Cook"
	icon_state = "Cook"

/obj/effect/landmark/start/shaft_miner
	name = "Shaft Miner"
	icon_state = "Shaft Miner"

/obj/effect/landmark/start/security_officer
	name = "Security Officer"
	icon_state = "Security Officer"

/obj/effect/landmark/start/botanist
	name = "Botanist"
	icon_state = "Botanist"

/obj/effect/landmark/start/head_of_security
	name = "Head of Security"
	icon_state = "Head of Security"

/obj/effect/landmark/start/captain
	name = "Captain"
	icon_state = "Captain"

/obj/effect/landmark/start/detective
	name = "Detective"
	icon_state = "Detective"

/obj/effect/landmark/start/warden
	name = "Warden"
	icon_state = "Warden"

/obj/effect/landmark/start/chief_engineer
	name = "Chief Engineer"
	icon_state = "Chief Engineer"

/obj/effect/landmark/start/head_of_personnel
	name = "Head of Personnel"
	icon_state = "Head of Personnel"

/obj/effect/landmark/start/librarian
	name = "Curator"
	icon_state = "Curator"

/obj/effect/landmark/start/lawyer
	name = "Lawyer"
	icon_state = "Lawyer"

/obj/effect/landmark/start/station_engineer
	name = "Station Engineer"
	icon_state = "Station Engineer"

/obj/effect/landmark/start/medical_doctor
	name = "Medical Doctor"
	icon_state = "Medical Doctor"

/obj/effect/landmark/start/coroner
	name = "Coroner"
	icon_state = "Coroner"

/obj/effect/landmark/start/paramedic
	name = "Paramedic"
	icon_state = "Paramedic"

/obj/effect/landmark/start/scientist
	name = "Scientist"
	icon_state = "Scientist"

/obj/effect/landmark/start/chemist
	name = "Chemist"
	icon_state = "Chemist"

/obj/effect/landmark/start/roboticist
	name = "Roboticist"
	icon_state = "Roboticist"

/obj/effect/landmark/start/research_director
	name = JOB_RESEARCH_DIRECTOR
	icon_state = JOB_RESEARCH_DIRECTOR

/obj/effect/landmark/start/geneticist
	name = "Geneticist"
	icon_state = "Geneticist"

/obj/effect/landmark/start/chief_medical_officer
	name = "Chief Medical Officer"
	icon_state = "Chief Medical Officer"


/obj/effect/landmark/start/psychologist
	name = "Psychologist"
	icon_state = "Psychologist"

/obj/effect/landmark/start/chaplain
	name = "Chaplain"
	icon_state = "Chaplain"

/obj/effect/landmark/start/cyborg
	name = "Cyborg"
	icon_state = "Cyborg"
	//SKYRAT EDIT: Start - Makes latejoin cyborgs spawn in the station instead of on the interlink.
	jobspawn_override = TRUE
	delete_after_roundstart = FALSE
	//SKYRAT EDIT: End - Makes latejoin cyborgs spawn in the station instead of on the interlink.

/obj/effect/landmark/start/ai
	name = "AI"
	icon_state = "AI"
	delete_after_roundstart = FALSE
	var/primary_ai = TRUE
	var/latejoin_active = TRUE

/obj/effect/landmark/start/ai/after_round_start()
	if(latejoin_active && !used)
		new /obj/structure/ai_core/latejoin_inactive(loc)
	return ..()

/obj/effect/landmark/start/ai/secondary
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "ai_spawn"
	primary_ai = FALSE
	latejoin_active = FALSE

//Department Security spawns

/obj/effect/landmark/start/depsec
	name = "department_sec"
	icon_state = "Security Officer"
	/// What department this spawner is for
	var/department

/obj/effect/landmark/start/depsec/Initialize(mapload)
	. = ..()
	LAZYADDASSOCLIST(GLOB.department_security_spawns, department, src)

/obj/effect/landmark/start/depsec/Destroy()
	LAZYREMOVEASSOC(GLOB.department_security_spawns, department, src)
	return ..()

/obj/effect/landmark/start/depsec/supply
	name = "supply_sec"
	department = SEC_DEPT_SUPPLY

/obj/effect/landmark/start/depsec/medical
	name = "medical_sec"
	department = SEC_DEPT_MEDICAL

/obj/effect/landmark/start/depsec/engineering
	name = "engineering_sec"
	department = SEC_DEPT_ENGINEERING

/obj/effect/landmark/start/depsec/science
	name = "science_sec"
	department = SEC_DEPT_SCIENCE

//Antagonist spawns

/obj/effect/landmark/start/wizard
	name = "wizard"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "wiznerd_spawn"

/obj/effect/landmark/start/wizard/Initialize(mapload)
	..()
	GLOB.wizardstart += loc
	return INITIALIZE_HINT_QDEL

/// Places to put midround nukeops (normal)
GLOBAL_LIST_EMPTY(nukeop_base_start)
/// Places to put midround nukeops (leader)
GLOBAL_LIST_EMPTY(nukeop_base_leader_start)
/// Places to put nukeops overwatch agents
GLOBAL_LIST_EMPTY(nukeop_base_overwatch_start)
/// Places to spawn nukeops on roundstart
GLOBAL_LIST_EMPTY(nukeop_elevator_start)

/obj/effect/landmark/start/nukeop_base
	name = "nukeop"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "snukeop_spawn"

/obj/effect/landmark/start/nukeop_base/Initialize(mapload)
	..()
	var/list/add_to = get_global_list()
	add_to += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/start/nukeop_base/proc/get_global_list()
	return GLOB.nukeop_base_start

/obj/effect/landmark/start/nukeop_base/leader
	name = "nukeop leader"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "snukeop_leader_spawn"

/obj/effect/landmark/start/nukeop_base/leader/get_global_list()
	return GLOB.nukeop_base_leader_start

/obj/effect/landmark/start/nukeop_base/overwatch
	name = "nukeop overwatch"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "snukeop_leader_spawn"

/obj/effect/landmark/start/nukeop_base/overwatch/get_global_list()
	return GLOB.nukeop_base_overwatch_start

/obj/effect/landmark/start/nukeop_elevator
	name = "nukeop (elevator)"
	icon = /obj/effect/landmark/start/nukeop_base::icon
	icon_state = /obj/effect/landmark/start/nukeop_base::icon_state

/obj/effect/landmark/start/nukeop_elevator/Initialize(mapload)
	. = ..()
	GLOB.nukeop_elevator_start += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/nukeop_elevator
	icon_state = "x"

/obj/effect/landmark/nukeop_elevator/interior
	name = "nukeop elevator interior top right corner"

/obj/effect/landmark/nukeop_elevator/exterior
	name = "nukeop elevator exterior top right corner"

// Must be immediate because players will
// join before SSatom initializes everything.
INITIALIZE_IMMEDIATE(/obj/effect/landmark/start/new_player)

/obj/effect/landmark/start/new_player
	name = "New Player"

/obj/effect/landmark/start/new_player/Initialize(mapload)
	..()
	GLOB.newplayer_start += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/start/pun_pun
	name = JOB_PUN_PUN
	icon = 'icons/mob/human/human.dmi'
	icon_state = "monkey"

/obj/effect/landmark/latejoin
	name = "JoinLate"

/obj/effect/landmark/latejoin/Initialize(mapload)
	..()
	SSjob.latejoin_trackers += loc
	return INITIALIZE_HINT_QDEL

//space carps, magicarps, lone ops, slaughter demons, possibly revenants spawn here
/obj/effect/landmark/carpspawn
	name = "carpspawn"
	icon_state = "carp_spawn"

//observer start
/obj/effect/landmark/observer_start
	name = "Observer-Start"
	icon_state = "observer_start"

//generic maintenance locations
/obj/effect/landmark/generic_maintenance_landmark
	name = "generic_maintenance_spawn"
	icon_state = "xeno_spawn"

/obj/effect/landmark/generic_maintenance_landmark/Initialize(mapload)
	..()
	GLOB.generic_maintenance_landmarks += loc
	return INITIALIZE_HINT_QDEL

//objects with the stationloving component (nuke disk) respawn here.
//also blobs that have their spawn forcemoved (running out of time when picking their spawn spot) and santa
/obj/effect/landmark/blobstart
	name = "blobstart"
	icon_state = "blob_start"

/obj/effect/landmark/blobstart/Initialize(mapload)
	..()
	GLOB.blobstart += loc
	return INITIALIZE_HINT_QDEL

//spawns sec equipment lockers depending on the number of sec officers
/obj/effect/landmark/secequipment
	name = "secequipment"
	icon_state = "secequipment"

/obj/effect/landmark/secequipment/Initialize(mapload)
	..()
	GLOB.secequipment += loc
	return INITIALIZE_HINT_QDEL

//players that get put in admin jail show up here
/obj/effect/landmark/prisonwarp
	name = "prisonwarp"
	icon_state = "prisonwarp"

/obj/effect/landmark/prisonwarp/Initialize(mapload)
	..()
	GLOB.prisonwarp += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/ert_spawn
	name = "Emergencyresponseteam"
	icon_state = "ert_spawn"

/obj/effect/landmark/ert_spawn/Initialize(mapload)
	..()
	GLOB.emergencyresponseteamspawn += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/ert_shuttle_spawn
	name = "ertshuttlespawn"
	icon_state = "ert_spawn"

/obj/effect/landmark/ert_shuttle_brief_spawn
	name = "ertshuttlebriefspawn"
	icon_state = "ert_brief_spawn"

//ninja energy nets teleport victims here
/obj/effect/landmark/holding_facility
	name = "Holding Facility"
	icon_state = "holding_facility"

/obj/effect/landmark/holding_facility/Initialize(mapload)
	..()
	GLOB.holdingfacility += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/thunderdome/observe
	name = "tdomeobserve"
	icon_state = "tdome_observer"

/obj/effect/landmark/thunderdome/observe/Initialize(mapload)
	..()
	GLOB.tdomeobserve += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/thunderdome/one
	name = "tdome1"
	icon_state = "tdome_t1"

/obj/effect/landmark/thunderdome/one/Initialize(mapload)
	..()
	GLOB.tdome1 += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/thunderdome/two
	name = "tdome2"
	icon_state = "tdome_t2"

/obj/effect/landmark/thunderdome/two/Initialize(mapload)
	..()
	GLOB.tdome2 += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/thunderdome/admin
	name = "tdomeadmin"
	icon_state = "tdome_admin"

/obj/effect/landmark/thunderdome/admin/Initialize(mapload)
	..()
	GLOB.tdomeadmin += loc
	return INITIALIZE_HINT_QDEL

/**
 * Generic event spawn points
 *
 * These are placed in locales where there are likely to be players, and places which are identifiable at a glance -
 * Such as public hallways, department rooms, head of staff offices, and non-generic maintenance locations
 *
 * Used in events to cause effects in locations where it is likely to effect players
 */
/obj/effect/landmark/event_spawn
	name = "generic event spawn"
	icon_state = "generic_event"

/obj/effect/landmark/event_spawn/Initialize(mapload)
	. = ..()
	GLOB.generic_event_spawns += src

/obj/effect/landmark/event_spawn/Destroy()
	GLOB.generic_event_spawns -= src
	return ..()

/obj/effect/landmark/ruin
	var/datum/map_template/ruin/ruin_template

/obj/effect/landmark/ruin/Initialize(mapload, my_ruin_template)
	. = ..()
	name = "ruin_[GLOB.ruin_landmarks.len + 1]"
	ruin_template = my_ruin_template
	GLOB.ruin_landmarks |= src

/obj/effect/landmark/ruin/Destroy()
	GLOB.ruin_landmarks -= src
	ruin_template = null
	. = ..()

// handled in portals.dm, id connected to one-way portal
/obj/effect/landmark/portal_exit
	name = "portal exit"
	icon_state = "portal_exit"
	var/id

/// Marks the bottom left of the testing zone.
/// In landmarks.dm and not unit_test.dm so it is always active in the mapping tools.
/obj/effect/landmark/unit_test_bottom_left
	name = "unit test zone bottom left"

/// Marks the top right of the testing zone.
/// In landmarks.dm and not unit_test.dm so it is always active in the mapping tools.
/obj/effect/landmark/unit_test_top_right
	name = "unit test zone top right"

/obj/effect/landmark/start/hangover
	name = "hangover spawn"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "hangover_spawn"

	/// A list of everything this hangover spawn created as part of the hangover station trait
	var/list/hangover_debris = list()

	/// A list of everything this hangover spawn created as part of the birthday station trait
	var/list/party_debris = list()

/obj/effect/landmark/start/hangover/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/landmark/start/hangover/Destroy()
	hangover_debris = null
	party_debris = null
	return ..()

/obj/effect/landmark/start/hangover/LateInitialize()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_BIRTHDAY))
		party_debris += new /obj/effect/decal/cleanable/confetti(get_turf(src)) //a birthday celebration can also be a hangover
		var/list/bonus_confetti = GLOB.alldirs
		for(var/confettis in bonus_confetti)
			var/party_turf_to_spawn_on = get_step(src, confettis)
			if(!isopenturf(party_turf_to_spawn_on))
				continue
			var/dense_object = FALSE
			for(var/atom/content in party_turf_to_spawn_on)
				if(content.density)
					dense_object = TRUE
					break
			if(dense_object)
				continue
			if(prob(50))
				party_debris += new /obj/effect/decal/cleanable/confetti(party_turf_to_spawn_on)
			if(prob(10))
				party_debris += new /obj/item/toy/balloon(party_turf_to_spawn_on)
	if(!HAS_TRAIT(SSstation, STATION_TRAIT_HANGOVER))
		return
	if(prob(60))
		hangover_debris += new /obj/effect/decal/cleanable/vomit(get_turf(src))
	if(prob(70))
		var/bottle_count = rand(1, 3)
		for(var/index in 1 to bottle_count)
			var/turf/turf_to_spawn_on = get_step(src, pick(GLOB.alldirs))
			if(!isopenturf(turf_to_spawn_on))
				continue
			var/dense_object = FALSE
			for(var/atom/content in turf_to_spawn_on.contents)
				if(content.density)
					dense_object = TRUE
					break
			if(dense_object)
				continue
			hangover_debris += new /obj/item/reagent_containers/cup/glass/bottle/beer/almost_empty(turf_to_spawn_on)

///Spawns the mob with some drugginess/drunkenness, and some disgust.
/obj/effect/landmark/start/hangover/proc/make_hungover(mob/hangover_mob)
	if(!iscarbon(hangover_mob))
		return

	var/mob/living/carbon/spawned_carbon = hangover_mob
	if(HAS_PERSONALITY(spawned_carbon, /datum/personality/teetotal))
		spawned_carbon.add_mood_event("hungover", /datum/mood_event/teetotal_hangover)
		spawned_carbon.adjust_disgust(30)
		return

	spawned_carbon.set_resting(TRUE, silent = TRUE)
	if(HAS_PERSONALITY(spawned_carbon, /datum/personality/bibulous))
		spawned_carbon.add_mood_event("hungover", /datum/mood_event/bibulous_hangover)
		spawned_carbon.adjust_drunk_effect(rand(30, 60))
		spawned_carbon.adjust_drugginess(rand(10 SECONDS, 20 SECONDS))
		spawned_carbon.adjust_disgust(rand(30, 70))
		return

	spawned_carbon.add_mood_event("hungover", /datum/mood_event/normal_hangover)
	spawned_carbon.adjust_disgust(rand(10, 50)) //How hungover are you?
	if(prob(50))
		spawned_carbon.adjust_drunk_effect(rand(15, 25))
	else
		spawned_carbon.adjust_drugginess(rand(30 SECONDS, 40 SECONDS))

/obj/effect/landmark/start/hangover/JoinPlayerHere(mob/joining_mob, buckle)
	var/mob/created_joining_mob = ..()
	make_hungover(created_joining_mob)
	for(var/obj/structure/closet/closet in get_turf(src))
		if(closet.opened)
			continue
		created_joining_mob.forceMove(closet)
		return created_joining_mob
	return created_joining_mob

/obj/effect/landmark/flaps_install
	name = "plastic flaps install point"
	icon_state = "flap-install"

/obj/effect/landmark/flaps_install/Initialize(mapload)
	. = ..()
	GLOB.cargo_shuttle_flaps_landmarks += src

/obj/effect/landmark/flaps_install/Destroy()
	GLOB.cargo_shuttle_flaps_landmarks -= src
	return ..()

//Landmark that creates destinations for the navigate verb to path to
/obj/effect/landmark/navigate_destination
	name = "navigate verb destination"
	icon_state = "navigate"
	var/location

/obj/effect/landmark/navigate_destination/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/landmark/navigate_destination/LateInitialize()
	if(!location)
		var/obj/machinery/door/airlock/A = locate(/obj/machinery/door/airlock) in loc
		location = A ? format_text(A.name) : get_area_name(src, format_text = TRUE)

	GLOB.navigate_destinations[loc] = location

	qdel(src)

//Command
/obj/effect/landmark/navigate_destination/bridge
	location = "舰桥"

/obj/effect/landmark/navigate_destination/hop
	location = "人事主管办公室"

/obj/effect/landmark/navigate_destination/vault
	location = "金库"

/obj/effect/landmark/navigate_destination/teleporter
	location = "传送机"

/obj/effect/landmark/navigate_destination/gateway
	location = "星门"

/obj/effect/landmark/navigate_destination/eva
	location = "舱外活动装备库"

/obj/effect/landmark/navigate_destination/aiupload
	location = "AI 上传室"

/obj/effect/landmark/navigate_destination/minisat_access_ai
	location = "AI 卫星通道"

/obj/effect/landmark/navigate_destination/minisat_access_tcomms
	location = "电信卫星通道"

/obj/effect/landmark/navigate_destination/minisat_access_tcomms_ai
	location = "AI 与电信卫星通道"

/obj/effect/landmark/navigate_destination/tcomms
	location = "电信室"

//Departments
/obj/effect/landmark/navigate_destination/sec
	location = "安保部"

/obj/effect/landmark/navigate_destination/det
	location = "侦探办公室"

/obj/effect/landmark/navigate_destination/research
	location = "科研部"

/obj/effect/landmark/navigate_destination/engineering
	location = "工程部"

/obj/effect/landmark/navigate_destination/techstorage
	location = "技术储藏室"

/obj/effect/landmark/navigate_destination/atmos
	location = "大气部"

/obj/effect/landmark/navigate_destination/med
	location = "医疗部"

/obj/effect/landmark/navigate_destination/chemfactory
	location = "化学工厂"

/obj/effect/landmark/navigate_destination/cargo
	location = "货运部"

//Common areas
/obj/effect/landmark/navigate_destination/bar
	location = "酒吧"

/obj/effect/landmark/navigate_destination/dorms
	location = "宿舍"

/obj/effect/landmark/navigate_destination/court
	location = "法庭"

/obj/effect/landmark/navigate_destination/tools
	location = "工具储藏室"

/obj/effect/landmark/navigate_destination/library
	location = "图书馆"

/obj/effect/landmark/navigate_destination/chapel
	location = "教堂"

/obj/effect/landmark/navigate_destination/minisat_access_chapel_library
	location = "教堂与图书馆卫星通道"

//Service
/obj/effect/landmark/navigate_destination/kitchen
	location = "厨房"

/obj/effect/landmark/navigate_destination/hydro
	location = "水培室"

/obj/effect/landmark/navigate_destination/janitor
	location = "清洁工储藏室"

/obj/effect/landmark/navigate_destination/lawyer
	location = "律师办公室"

//Shuttle docks
/obj/effect/landmark/navigate_destination/dockarrival
	location = "入站穿梭机停靠区"

/obj/effect/landmark/navigate_destination/dockesc
	location = "逃生穿梭机停靠区"

/obj/effect/landmark/navigate_destination/dockescpod
	location = "逃生舱停靠区"

/obj/effect/landmark/navigate_destination/dockescpod1
	location = "1 号逃生舱停靠区"

/obj/effect/landmark/navigate_destination/dockescpod2
	location = "2 号逃生舱停靠区"

/obj/effect/landmark/navigate_destination/dockescpod3
	location = "3 号逃生舱停靠区"

/obj/effect/landmark/navigate_destination/dockescpod4
	location = "4 号逃生舱停靠区"

/obj/effect/landmark/navigate_destination/dockaux
	location = "辅助停靠区"

//Maint
/obj/effect/landmark/navigate_destination/incinerator
	location = "焚化炉"

/obj/effect/landmark/navigate_destination/disposals
	location = "废物处理区"
