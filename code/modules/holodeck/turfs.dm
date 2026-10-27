/turf/open/floor/holofloor
	icon_state = "floor"
	holodeck_compatible = TRUE
	thermal_conductivity = 0
	flags_1 = NONE
	var/direction = SOUTH

/turf/open/floor/holofloor/attackby(obj/item/I, mob/living/user)
	return // HOLOFLOOR DOES NOT GIVE A FUCK

/turf/open/floor/holofloor/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	return ITEM_INTERACT_BLOCKING // Fuck you

/turf/open/floor/holofloor/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/tool_blocker, TOOL_CROWBAR, TOOL_ACT_PRIMARY)

/turf/open/floor/holofloor/burn_tile()
	return //you can't burn a hologram!

/turf/open/floor/holofloor/break_tile()
	return //you can't break a hologram!

/turf/open/floor/holofloor/plating
	name = "全息甲板投影地板"
	icon_state = "engine"

/turf/open/floor/holofloor/chapel
	name = "礼拜堂地板"
	icon_state = "chapel"

/turf/open/floor/holofloor/chapel/bottom_left
	direction = WEST

/turf/open/floor/holofloor/chapel/top_right
	direction = EAST

/turf/open/floor/holofloor/chapel/bottom_right

/turf/open/floor/holofloor/chapel/top_left
	direction = NORTH

/turf/open/floor/holofloor/chapel/Initialize(mapload)
	. = ..()
	if (direction != SOUTH)
		setDir(direction)

/turf/open/floor/holofloor/white
	name = "白色地板"
	icon_state = "white"

/turf/open/floor/holofloor/pure_white
	name = "白色地板"
	desc = "嘿，瞧，这就是灰色浪潮成员的内心！"
	icon_state = "pure_white"

/turf/open/floor/holofloor/plating/burnmix
	name = "燃烧混合气地板"
	initial_gas_mix = BURNMIX_ATMOS

/turf/open/floor/holofloor/grass
	gender = PLURAL
	name = "茂密草地"
	desc = "望着这片茂盛的草场，你忽然感到一阵思乡。"
	icon_state = "grass0"
	bullet_bounce_sound = null
	tiled_turf = FALSE

/turf/open/floor/holofloor/grass/Initialize(mapload)
	. = ..()
	icon_state = "grass[rand(0,3)]"

/turf/open/floor/holofloor/beach
	gender = PLURAL
	name = "沙子"
	desc = "这比度假还舒服，毕竟你照样拿工资。"
	icon = 'icons/turf/sand.dmi'
	icon_state = "sand"
	bullet_bounce_sound = null
	tiled_turf = FALSE

/turf/open/floor/holofloor/beach/coast
	gender = NEUTER
	name = "海岸线"
	icon = 'icons/turf/beach.dmi'
	icon_state = "beach"

/turf/open/floor/holofloor/beach/coast/corner
	icon_state = "beach-corner"

/turf/open/floor/holofloor/beach/water
	name = "水"
	desc = "给人一种能在水上行走的感觉。牧师们很喜欢。"
	icon = 'icons/turf/beach.dmi'
	icon_state = "water"
	bullet_sizzle = TRUE

/turf/open/floor/holofloor/beach/water/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/fishing_spot, /datum/fish_source/holographic)

/turf/open/floor/holofloor/asteroid
	gender = PLURAL
	name = "小行星沙地"
	desc = "沙子在脚下嘎吱作响，摸起来却很柔软。"
	icon_state = "asteroid"
	tiled_turf = FALSE

/turf/open/floor/holofloor/asteroid/Initialize(mapload)
	icon_state = "asteroid[rand(0, 12)]"
	. = ..()

/turf/open/floor/holofloor/basalt
	gender = PLURAL
	name = "玄武岩"
	desc = "尽管全息甲板的墙壁很凉爽，你依然觉得炎热。"
	icon_state = "basalt0"
	tiled_turf = FALSE

/turf/open/floor/holofloor/basalt/Initialize(mapload)
	. = ..()
	if(prob(15))
		icon_state = "basalt[rand(0, 12)]"
		switch(icon_state)
			if("basalt1", "basalt2", "basalt3")
				set_light(BASALT_LIGHT_RANGE_BRIGHT, BASALT_LIGHT_POWER, LIGHT_COLOR_LAVA)
			if("basalt5", "basalt9")
				set_light(BASALT_LIGHT_RANGE_DIM, BASALT_LIGHT_POWER, LIGHT_COLOR_LAVA)

/turf/open/floor/holofloor/space
	name = "\proper 太空"
	desc = "看起来像太空的地板。好在太空的致命之处并没有在这里被模拟出来。"
	icon = 'icons/turf/space.dmi'
	icon_state = "space"
	layer = SPACE_LAYER
	plane = PLANE_SPACE

/turf/open/floor/holofloor/hyperspace
	name = "\proper 超空间"
	desc = "给人一种正在以超高速移动的感觉，实际上却原地不动。可能引起晕动病。"
	icon = 'icons/turf/space.dmi'
	icon_state = "speedspace_ns_1"
	bullet_bounce_sound = null
	tiled_turf = FALSE

/turf/open/floor/holofloor/hyperspace/Initialize(mapload)
	icon_state = "speedspace_ns_[(x + 5*y + (y%2+1)*7)%15+1]"
	. = ..()

/turf/open/floor/holofloor/hyperspace/ns/Initialize(mapload)
	. = ..()
	icon_state = "speedspace_ns_[(x + 5*y + (y%2+1)*7)%15+1]"

/turf/open/floor/holofloor/carpet
	name = "地毯"
	desc = "带着电气的热情。"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "carpet-255"
	base_icon_state = "carpet"
	floor_tile = /obj/item/stack/tile/carpet
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SMOOTH_GROUP_CARPET
	canSmoothWith = SMOOTH_GROUP_CARPET
	bullet_bounce_sound = null
	tiled_turf = FALSE

/turf/open/floor/holofloor/carpet/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/, update_appearance)), 0.1 SECONDS)

/turf/open/floor/holofloor/carpet/update_icon(updates=ALL)
	. = ..()
	if((updates & UPDATE_SMOOTHING) && overfloor_placed && smoothing_flags & USES_SMOOTHING)
		QUEUE_SMOOTH(src)

/turf/open/floor/holofloor/wood
	icon_state = "wood"
	desc = "让你感到宾至如归。"
	tiled_turf = FALSE

/turf/open/floor/holofloor/snow
	gender = PLURAL
	name = "雪"
	desc = "蓬松的雪堆积成看起来结实的地板，但踩上去却会下陷。"
	icon = 'icons/turf/snow.dmi'
	icon_state = "snow"
	slowdown = 2
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	tiled_turf = FALSE

/turf/open/floor/holofloor/dark
	icon_state = "darkfull"
	desc = "周围环境漆黑一片，你几乎连自己都看不见。"

/turf/open/floor/holofloor/stairs
	name = "楼梯"
	icon_state = "stairs"
	tiled_turf = FALSE

/turf/open/floor/holofloor/stairs/left
	icon_state = "stairs-l"

/turf/open/floor/holofloor/stairs/medium
	icon_state = "stairs-m"

/turf/open/floor/holofloor/stairs/right
	icon_state = "stairs-r"

/turf/open/floor/holofloor/chess_white
	icon_state = "white_large"
	color = "#eeeed2"

/turf/open/floor/holofloor/chess_black
	icon_state = "white_large"
	color = "#93b570"
