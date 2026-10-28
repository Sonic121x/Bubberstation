/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/icemoon/bubberstation
	prefix = "_maps/RandomRuins/IceRuins/bubberstation/"
/*------*/

/datum/map_template/ruin/icemoon/bubberstation/syndicate_base
	name = "辛迪加冰原基地"
	id = "ice-base"
	description = "一处研究非法生物武器的秘密基地，由一支辛迪加特工精英小队严密守卫。"
	suffix = "icemoon_interdyne.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/lavaland/bubberstation/dauntless)
	always_place = FALSE
	unpickable = TRUE
	ruin_type = ZTRAIT_ICE_RUINS_UNDERGROUND
