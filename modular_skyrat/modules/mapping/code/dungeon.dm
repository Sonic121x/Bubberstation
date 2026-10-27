/*
*	WALLS
*/

/turf/closed/indestructible/dungeon
	name = "石墙"
	desc = "冰冷的石墙。就像地牢一样。"
	icon = 'modular_skyrat/modules/mapping/icons/unique/dungeon.dmi'
	icon_state = "wall"
	base_icon_state = "wall"
	explosive_resistance = INFINITY

/turf/closed/indestructible/dungeon/corner
	icon_state = "wall-corner"
	base_icon_state = "wall-corner"

/*
*	TURFS
*/

/turf/open/floor/plating/cobblestone
	gender = PLURAL
	name = "鹅卵石路"
	desc = "铺成永久通道的鹅卵石。有点老派。"
	icon = 'modular_skyrat/modules/mapping/icons/unique/dungeon.dmi'
	icon_state = "cobble"
	planetary_atmos = FALSE

/turf/open/floor/plating/cobblestone/planet
	baseturfs = /turf/open/misc/dirt/planet
	planetary_atmos = TRUE

/turf/open/floor/plating/cobblestone/dungeon
	icon_state = "cobble-dungeon"
	baseturfs = /turf/open/floor/plating/cobblestone/dungeon
	planetary_atmos = FALSE

// This one has a rocky texture to it.
/turf/open/floor/plating/cobblestone/sparse
	icon_state = "cobble_sparse"
	baseturfs = /turf/open/floor/plating/cobblestone/sparse

/turf/open/floor/plating/cobblestone/sparse/planet
	icon_state = "cobble_sparse"
	baseturfs = /turf/open/floor/plating/cobblestone/sparse/planet
	planetary_atmos = TRUE

/*
*	FAKE WALLS
*/

/obj/structure/dungeon
	name = "带洞的石墙！"
	desc = "墙上的一个洞！很小。"
	icon = 'modular_skyrat/modules/mapping/icons/unique/dungeon.dmi'
	icon_state = "wall-hole"
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/dungeon/doorway
	name = "门洞"
	desc = "在石墙上开出的门洞。窄得很。"
	icon = 'modular_skyrat/modules/mapping/icons/unique/dungeon.dmi'
	icon_state = "wall-doorway"
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/railing/stone/Initialize(mapload)
	.=..()
	if(dir == 2)
		layer = ABOVE_MOB_LAYER
	else
		return

/obj/structure/railing/stone
	name = "石墙"
	desc = "鹅卵石砌成的石墙。相当结实。"
	icon = 'modular_skyrat/modules/mapping/icons/unique/dungeon.dmi'
	icon_state = "cobble-wall"
	max_integrity = 100
	density = TRUE
	anchored = TRUE
	climbable = TRUE

/obj/structure/railing/stone/attackby(obj/item/wrench, mob/living/user, params)
	to_chat(user, span_notice("你皱起眉头，意识到这堵墙确实是石头做的，光靠一把扳手可没法把它从地里撬起来拖走。"))
	return

/obj/structure/railing/stone/left
	icon_state = "cobble-wall-left"
	density = FALSE
	climbable = FALSE

/obj/structure/railing/stone/right
	icon_state = "cobble-wall-right"
	density = FALSE
	climbable = FALSE

/obj/structure/mineral_door/dungeon
	name = "木门"
	desc = "一扇小木门。它大概还能打开，就是有点小。"
	icon = 'modular_skyrat/modules/mapping/icons/unique/dungeon.dmi'
	icon_state = "wall-door"
	openSound = 'sound/effects/doorcreaky.ogg'
	closeSound = 'sound/effects/doorcreaky.ogg'
	sheetType = /obj/item/stack/sheet/mineral/wood
	max_integrity = 100

/obj/machinery/button/dungeon
	name = "石砖"
	desc = "一块从墙里凸出来的砖。嗯。"
	icon = 'modular_skyrat/modules/mapping/icons/unique/dungeon.dmi'
	base_icon_state = "doorctrl"
	icon_state = "doorctrl"
	power_channel = AREA_USAGE_ENVIRON
	use_power = NO_POWER_USE
	idle_power_usage = 0
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/button/dungeon/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_SCREWDRIVER)
		to_chat(user, span_notice("你沿着砖的边缘戳了戳，试着把螺丝刀硬塞进去。看来这样是弄不出来的。"))
		return
// Let's not open the maintenance panel of a stone brick.
