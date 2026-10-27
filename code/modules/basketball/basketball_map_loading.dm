/obj/effect/landmark/basketball
	name = "篮球地图生成点"

/obj/effect/landmark/basketball/team_spawn
	name = "篮球队生成点"
	var/game_id = "basketball"

// locations where players for the home team will spawn
/obj/effect/landmark/basketball/team_spawn/home
	name = "主队生成点"

/obj/effect/landmark/basketball/team_spawn/home_hoop
	name = "篮球主队篮筐生成点"

// locations where players for the away team will spawn
/obj/effect/landmark/basketball/team_spawn/away
	name = "客队生成点"

/obj/effect/landmark/basketball/team_spawn/away_hoop
	name = "篮球客队篮筐生成点"

/obj/effect/landmark/basketball/team_spawn/referee
	name = "裁判生成点"

/area/centcom/basketball
	name = "篮球小游戏"
	icon_state = "b_ball"
	requires_power = FALSE
	static_lighting = FALSE
	base_lighting_alpha = 255
	default_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = NOTELEPORT | NO_DEATH_MESSAGE | BLOCK_SUICIDE

/datum/lazy_template/basketball
	map_dir = "_maps/minigame/basketball"
	place_on_top = TRUE
	turf_reservation_type = /datum/turf_reservation/turf_not_baseturf
	/// Map UI Name
	var/name
	/// Map Description
	var/description = ""
	/// The name of the basketball team
	var/team_name
	/// The basketball teams home stadium uniform
	var/home_team_uniform

/datum/lazy_template/basketball/stadium
	name = "体育馆"
	description = "纳米传讯篮球部的主场。"
	map_name = "stadium"
	key = "stadium"
	team_name = "纳米传讯篮球"
	home_team_uniform = /datum/outfit/basketball/nanotrasen

/datum/lazy_template/basketball/lusty_xenomorphs
	name = "饥渴异形队体育馆"
	description = "饥渴异形队的主场。"
	map_name = "lusty_xenomorphs"
	key = "lusty_xenomorphs"
	team_name = "饥渴异形"
	home_team_uniform = /datum/outfit/basketball/lusty_xenomorphs

/datum/lazy_template/basketball/space_surfers
	name = "太空冲浪者队体育馆"
	description = "太空冲浪者队的主场。"
	map_name = "space_surfers"
	key = "space_surfers"
	team_name = "太空冲浪者"
	home_team_uniform = /datum/outfit/basketball/space_surfers

/datum/lazy_template/basketball/greytide_worldwide
	name = "灰潮全球队体育馆"
	description = "灰潮全球队的主场。"
	map_name = "greytide_worldwide"
	key = "greytide_worldwide"
	team_name = "灰潮全球"
	home_team_uniform = /datum/outfit/basketball/greytide_worldwide

/datum/lazy_template/basketball/ass_blast_usa
	name = "美国屁爆队体育馆"
	description = "美国屁爆队的主场。"
	map_name = "ass_blast_usa"
	key = "ass_blast_usa"
	team_name = "美国屁爆"
	home_team_uniform = /datum/outfit/basketball/ass_blast_usa

/datum/lazy_template/basketball/soviet_bears
	name = "苏联熊队体育馆"
	description = "苏联熊队的主场。"
	map_name = "soviet_bear"
	key = "soviet_bear"
	team_name = "苏联熊"
	home_team_uniform = /datum/outfit/basketball/soviet_bears

/datum/lazy_template/basketball/ash_gladiators
	name = "灰烬角斗士队体育馆"
	description = "灰烬角斗士队的主场。"
	map_name = "ash_gladiators"
	key = "ash_gladiators"
	team_name = "灰烬角斗士"
	home_team_uniform = /datum/outfit/basketball/ash_gladiators

/datum/lazy_template/basketball/beach_bums
	name = "沙滩流浪汉队体育馆"
	description = "沙滩流浪汉队的主场。"
	map_name = "beach_bums"
	key = "beach_bums"
	team_name = "沙滩流浪汉"
	home_team_uniform = /datum/outfit/basketball/beach_bums
