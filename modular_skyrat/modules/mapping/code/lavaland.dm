/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/lavaland/skyrat
	prefix = "_maps/RandomRuins/LavaRuins/skyrat/"
/*------*/

/datum/map_template/ruin/lavaland/skyrat/syndicate_base
	name = "Lava-Ruin Syndicate Lava Base"
	id = "lava-base"
	description = "一座研究非法生物武器的秘密基地，由一队辛迪加特工精锐严密看守。"
	suffix = "lavaland_surface_syndicate_base1_skyrat.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/icemoon/underground/skyrat/syndicate_base)
	always_place = FALSE
	unpickable = TRUE
