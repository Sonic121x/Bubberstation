/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/lavaland/bubberstation
	prefix = "_maps/RandomRuins/LavaRuins/bubberstation/"

/datum/map_template/ruin/space/bubberstation
	prefix = "_maps/RandomRuins/SpaceRuins/bubberstation/"
/*------*/

/datum/map_template/ruin/lavaland/bubberstation/dauntless
	name = "SSV 无畏号"
	id = "lava-ship"
	description = "一艘极度隐秘的辛迪加间谍船，藏身于滚滚灰烬风暴之后。DS-2 被摧毁后，它被派来监视纳米传讯的活动。"
	suffix = "lavaland_dauntless.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/icemoon/bubberstation/syndicate_base)
	always_place = FALSE
	unpickable = TRUE

/datum/map_template/ruin/space/bubberstation/dauntless
	name = "SSV 无畏号（太空）"
	id = "space-ship"
	description = "一艘极度隐秘的辛迪加间谍船，藏身于深空星区之中。DS-2 被摧毁后，它被派来监视纳米传讯的活动。"
	suffix = "space_dauntless.dmm"
	allow_duplicates = FALSE
	always_place = FALSE
	unpickable = TRUE

/datum/map_template/ruin/space/skyrat/interdynefob
	unpickable = TRUE
