//////lavaland surface papers

/obj/item/paper/fluff/stations/lavaland/surface/henderson_report
	name = "重要通知——亨德森夫人"
	default_raw_text = "无可报告之事。"

//ratvar

/obj/structure/dead_ratvar
	name = "庞大残骸"
	desc = "一台巨大战争机器的残骸。"
	icon = 'icons/obj/mining_zones/dead_ratvar.dmi'
	icon_state = "dead_ratvar"
	flags_1 = ON_BORDER_1
	appearance_flags = LONG_GLIDE
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE
	anchored = TRUE
	density = TRUE
	bound_width = 416
	bound_height = 64
	pixel_y = -10
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/dead_ratvar/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/seethrough, SEE_THROUGH_MAP_RATVAR_WRECK)
