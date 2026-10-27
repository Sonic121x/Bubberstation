GLOBAL_DATUM(ctf_spawner, /obj/effect/landmark/ctf)

/obj/effect/landmark/ctf
	name = "CTF 地图生成点"
	var/game_id = CTF_GHOST_CTF_GAME_ID
	var/list/map_bounds

/obj/effect/landmark/ctf/Initialize(mapload)
	. = ..()
	if(GLOB.ctf_spawner)
		qdel(GLOB.ctf_spawner)
	GLOB.ctf_spawner = src

/obj/effect/landmark/ctf/Destroy()
	if(map_bounds)
		for(var/turf/ctf_turf in block(
			map_bounds[MAP_MINX], map_bounds[MAP_MINY], map_bounds[MAP_MINZ],
			map_bounds[MAP_MAXX], map_bounds[MAP_MAXY], map_bounds[MAP_MAXZ]
		))
			ctf_turf.empty()
	GLOB.ctf_spawner = null
	return ..()

/obj/effect/landmark/ctf/proc/load_map(user)
	if (map_bounds)
		return

	var/list/map_options = subtypesof(/datum/map_template/ctf)
	var/turf/spawn_area = get_turf(src)
	var/datum/map_template/ctf/current_map
	var/chosen_map

	if(user)
		var/list/map_choices = list()
		for(var/datum/map_template/ctf/map as anything in map_options)
			var/mapname = initial(map.name)
			map_choices[mapname] = map
		chosen_map = tgui_input_list(user, "选择一张地图", "选择 CTF 地图",list("Random")|sort_list(map_choices))
		if (isnull(chosen_map))
			return FALSE;
		else
			current_map = map_choices[chosen_map]

	if(!user || chosen_map == "Random")
		current_map = pick(map_options)

	current_map = new current_map()

	var/datum/ctf_controller/ctf_controller = GLOB.ctf_games[CTF_GHOST_CTF_GAME_ID]
	ctf_controller.setup_rules(current_map.points_to_win)

	if(!spawn_area)
		CRASH("No spawn area detected for CTF!")
	else if(!current_map)
		CRASH("No map prepared")
	map_bounds = current_map.load(spawn_area, TRUE)
	if(!map_bounds)
		CRASH("Loading CTF map failed!")
	return TRUE

/datum/map_template/ctf
	should_place_on_top = FALSE
	var/description = ""
	///Score required to win CTF on this map.
	var/points_to_win = 3

/datum/map_template/ctf/classic
	name = "Classic"
	description = "最初的 CTF 地图。"
	mappath = "_maps/minigame/CTF/classic.dmm"

/datum/map_template/ctf/four_side
	name = "Four Side"
	description = "一张为演示 4 队 CTF 而制作的地图，只有一面位于中央的旗帜，而不是每队各有一面。"
	mappath = "_maps/minigame/CTF/fourSide.dmm"

/datum/map_template/ctf/downtown
	name = "Downtown"
	description = "一张发生在地面城市中的 CTF 地图。"
	mappath = "_maps/minigame/CTF/downtown.dmm"

/datum/map_template/ctf/limbo
	name = "Limbo"
	description = "一张发生在巫师巢穴中的 KOTH 地图，走廊首尾相连"
	mappath = "_maps/minigame/CTF/limbo.dmm"
	points_to_win = 180

/datum/map_template/ctf/cruiser
	name = "Crusier"
	description = "一张横跨多艘宇宙飞船的 CTF 地图，其中一艘载有一台强大的装置，能让获得它的人加速"
	mappath = "_maps/minigame/CTF/cruiser.dmm"

/datum/map_template/ctf/turbine
	name = "Turbine"
	description = "一张发生在熟悉的设施中的 CTF 地图。别想着死守中路——这个版本里没有哨兵。"
	mappath = "_maps/minigame/CTF/turbine.dmm"
