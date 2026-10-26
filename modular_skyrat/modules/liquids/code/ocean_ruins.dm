/datum/map_template/ruin/ocean
	prefix = "_maps/RandomRuins/OceanRuins/"

/datum/map_template/ruin/ocean/fissure
	name = "热力裂隙"
	id = "ocean-fissure"
	description = "海洋中的一道裂隙。"
	suffix = "ocean_fissure.dmm"
	cost = 5 //Ditto!

/datum/map_template/ruin/ocean/fissure/diag
	name = "横向热力裂隙"
	id = "ocean-fissure-diag"
	description = "海洋中一道横向的裂隙。"
	suffix = "ocean_fissure_diag.dmm"

/datum/map_template/ruin/ocean/listening_outpost
	name = "海洋监听前哨"
	id = "ocean-listening"
	description = "海洋中的一处监听前哨。"
	suffix = "ocean_listening_outpost.dmm"
	cost = 10 //Ditto
	allow_duplicates = FALSE

/datum/map_template/ruin/ocean/mining_site
	name = "海洋采矿场"
	id = "ocean-miningsite"
	description = "海洋采矿场。"
	suffix = "ocean_mining_above.dmm"
	cost = 10 //Please, for the love of god. Decrease these when we get more real ruins for oceans
	allow_duplicates = FALSE
	always_spawn_with = list(/datum/map_template/ruin/ocean/mining_site_below = PLACE_BELOW)

/datum/map_template/ruin/ocean/mining_site_below
	name = "海洋采矿场地下"
	id = "ocean-miningsite-ug"
	description = "海洋采矿场的地下部分。"
	suffix = "ocean_mining_below.dmm"
	unpickable = TRUE

/datum/map_template/ruin/ocean/saddam_hole
	name = "海洋藏身处"
	id = "ocean-hideout"
	description = "海洋藏身处。"
	suffix = "ocean_hideout_above.dmm"
	cost = 10 //Ditto
	allow_duplicates = FALSE
	always_spawn_with = list(/datum/map_template/ruin/ocean/saddam_hole_below = PLACE_BELOW)

/datum/map_template/ruin/ocean/saddam_hole_below
	name = "海洋藏身处地下"
	id = "ocean-hideout-ug"
	description = "海洋藏身处……在下一层。"
	suffix = "ocean_hideout_below.dmm"
	unpickable = TRUE

//Some copypastas ahead, but it's how our ruins spawning system works
/datum/map_template/ruin/ocean_station
	prefix = "_maps/RandomRuins/OceanRuins/"

/datum/map_template/ruin/ocean_station/fissure
	name = "热力裂隙"
	id = "ocean-fissure"
	description = "海洋中的一道裂隙。"
	suffix = "ocean_fissure.dmm"
	cost = 5

/datum/map_template/ruin/ocean_station/fissure/diag
	name = "横向热力裂隙"
	id = "ocean-fissure-diag"
	description = "海洋中一道横向的裂隙。"
	suffix = "ocean_fissure_diag.dmm"

/datum/map_template/ruin/trench
	prefix = "_maps/RandomRuins/OceanRuins/"

/datum/map_template/ruin/trench/biolab_research
	name = "海洋生物实验室研究站"
	id = "ocean-biolab"
	description = "海洋中的生物实验室。"
	suffix = "ocean_bioweapon_lab.dmm"
	cost = 10
	allow_duplicates = FALSE

/datum/map_template/ruin/trench/fissure
	name = "热力裂隙"
	id = "ocean-fissure"
	description = "海洋中的一道裂隙。"
	suffix = "ocean_fissure.dmm"
	cost = 5

/datum/map_template/ruin/trench/fissure/diag
	name = "横向热力裂隙"
	id = "ocean-fissure-diag"
	description = "海洋中一道横向的裂隙。"
	suffix = "ocean_fissure_diag.dmm"
