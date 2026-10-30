/obj/item/stack/tile/iron
	name = "地板砖"
	singular_name = "地板砖"
	desc = "你脚下踩着的地面。"
	icon_state = "tile"
	inhand_icon_state = "tile"
	force = 6
	mats_per_unit = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*0.25)
	throwforce = 10
	obj_flags = CONDUCTS_ELECTRICITY
	turf_type = /turf/open/floor/iron
	armor_type = /datum/armor/tile_iron
	resistance_flags = FIRE_PROOF
	matter_amount = 1
	cost = HALF_SHEET_MATERIAL_AMOUNT * 0.5
	source = /datum/robot_energy_storage/material/iron
	merge_type = /obj/item/stack/tile/iron
	tile_reskin_types = list(
		/obj/item/stack/tile/iron/base,
		/obj/item/stack/tile/iron/edge,
		/obj/item/stack/tile/iron/half,
		/obj/item/stack/tile/iron/corner,
		/obj/item/stack/tile/iron/large,
		/obj/item/stack/tile/iron/small,
		// BUBBER ADDITION BEGIN
		/obj/item/stack/tile/iron/small_checker,
		/obj/item/stack/tile/iron/small_corner,
		/obj/item/stack/tile/iron/small_edge,
		// BUBBER ADDITION END
		/obj/item/stack/tile/iron/diagonal,
		/obj/item/stack/tile/iron/herringbone,
		/obj/item/stack/tile/iron/textured,
		/obj/item/stack/tile/iron/textured_edge,
		/obj/item/stack/tile/iron/textured_half,
		/obj/item/stack/tile/iron/textured_corner,
		/obj/item/stack/tile/iron/textured_large,
		/obj/item/stack/tile/iron/dark,
		/obj/item/stack/tile/iron/dark/smooth_edge,
		/obj/item/stack/tile/iron/dark/smooth_half,
		/obj/item/stack/tile/iron/dark/smooth_corner,
		/obj/item/stack/tile/iron/dark/smooth_large,
		/obj/item/stack/tile/iron/dark/small,
		// BUBBER ADDITION BEGIN
		/obj/item/stack/tile/iron/dark/small_checker,
		/obj/item/stack/tile/iron/dark/small_corner,
		/obj/item/stack/tile/iron/dark/small_edge,
		// BUBBER ADDITION END
		/obj/item/stack/tile/iron/dark/diagonal,
		/obj/item/stack/tile/iron/dark/herringbone,
		/obj/item/stack/tile/iron/dark_side,
		/obj/item/stack/tile/iron/dark_corner,
		/obj/item/stack/tile/iron/checker,
		/obj/item/stack/tile/iron/dark/textured,
		/obj/item/stack/tile/iron/dark/textured_edge,
		/obj/item/stack/tile/iron/dark/textured_half,
		/obj/item/stack/tile/iron/dark/textured_corner,
		/obj/item/stack/tile/iron/dark/textured_large,
		/obj/item/stack/tile/iron/white,
		/obj/item/stack/tile/iron/white/smooth_edge,
		/obj/item/stack/tile/iron/white/smooth_half,
		/obj/item/stack/tile/iron/white/smooth_corner,
		/obj/item/stack/tile/iron/white/smooth_large,
		/obj/item/stack/tile/iron/white/small,
		// BUBBER ADDITION BEGIN
		/obj/item/stack/tile/iron/white/small_checker,
		/obj/item/stack/tile/iron/white/small_corner,
		/obj/item/stack/tile/iron/white/small_edge,
		// BUBBER ADDITION END
		/obj/item/stack/tile/iron/white/diagonal,
		/obj/item/stack/tile/iron/white/herringbone,
		/obj/item/stack/tile/iron/white_side,
		/obj/item/stack/tile/iron/white_corner,
		/obj/item/stack/tile/iron/cafeteria,
		/obj/item/stack/tile/iron/white/textured,
		/obj/item/stack/tile/iron/white/textured_edge,
		/obj/item/stack/tile/iron/white/textured_half,
		/obj/item/stack/tile/iron/white/textured_corner,
		/obj/item/stack/tile/iron/white/textured_large,
		/obj/item/stack/tile/iron/recharge_floor,
		/obj/item/stack/tile/iron/recharge_floor/white,
		/obj/item/stack/tile/iron/recharge_floor/dark,
		/obj/item/stack/tile/iron/recharge_floor/smooth,
		/obj/item/stack/tile/iron/smooth,
		/obj/item/stack/tile/iron/smooth_edge,
		/obj/item/stack/tile/iron/smooth_half,
		/obj/item/stack/tile/iron/smooth_corner,
		/obj/item/stack/tile/iron/smooth_large,
		/obj/item/stack/tile/iron/terracotta,
		/obj/item/stack/tile/iron/terracotta/small,
		/obj/item/stack/tile/iron/terracotta/diagonal,
		/obj/item/stack/tile/iron/terracotta/herringbone,
		/obj/item/stack/tile/iron/kitchen,
		/obj/item/stack/tile/iron/kitchen/small,
		/obj/item/stack/tile/iron/kitchen/diagonal,
		/obj/item/stack/tile/iron/kitchen/herringbone,
		/obj/item/stack/tile/iron/chapel,
		/obj/item/stack/tile/iron/showroomfloor,
		/obj/item/stack/tile/iron/solarpanel,
		/obj/item/stack/tile/iron/freezer,
		/obj/item/stack/tile/iron/freezer/edge,
		/obj/item/stack/tile/iron/freezer/half,
		/obj/item/stack/tile/iron/freezer/corner,
		/obj/item/stack/tile/iron/freezer/large,
		/obj/item/stack/tile/iron/grimy,
		/obj/item/stack/tile/iron/sepia,
	)

/obj/item/stack/tile/iron/two
	amount = 2

/obj/item/stack/tile/iron/four
	amount = 4

/datum/armor/tile_iron
	fire = 100
	acid = 70

/obj/item/stack/tile/iron/Initialize(mapload)
	. = ..()
	var/static/list/tool_behaviors = list(
		TOOL_WELDER = list(
			SCREENTIP_CONTEXT_LMB = "制作铁板",
			SCREENTIP_CONTEXT_RMB = "制作铁杆",
		),
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)

/obj/item/stack/tile/iron/welder_act(mob/living/user, obj/item/tool)
	if(get_amount() < 4)
		balloon_alert(user, "地板砖不够！")
		return
	if(tool.use_tool(src, user, delay = 0, volume = 40))
		var/obj/item/stack/sheet/iron/new_item = new(user.loc)
		user.visible_message(
			span_notice("[user.name]用[tool]把[src]压成了铁板。"),
			blind_message = span_hear("你听到了焊接声。"),
			vision_distance = COMBAT_MESSAGE_RANGE,
			ignored_mobs = user
		)
		use(4)
		user.put_in_inactive_hand(new_item)
		return ITEM_INTERACT_SUCCESS

/obj/item/stack/tile/iron/welder_act_secondary(mob/living/user, obj/item/tool)
	if(get_amount() < 2)
		balloon_alert(user, "地板砖不够！")
		return
	if(tool.use_tool(src, user, delay = 0, volume = 40))
		var/obj/item/stack/rods/new_item = new(user.loc)
		user.visible_message(
			span_notice("[user.name]用[tool]把[src]压成了铁杆。"),
			blind_message = span_hear("你听到了焊接声。"),
			vision_distance = COMBAT_MESSAGE_RANGE,
			ignored_mobs = user
		)
		use(2)
		user.put_in_inactive_hand(new_item)
		return ITEM_INTERACT_SUCCESS

/obj/item/stack/tile/iron/base //this subtype should be used for most stuff
	merge_type = /obj/item/stack/tile/iron/base

/obj/item/stack/tile/iron/base/cyborg //cant reskin these, fucks with borg code
	tile_reskin_types = null

/obj/item/stack/tile/iron/edge
	name = "边缘地板砖"
	singular_name = "边缘地板砖"
	icon_state = "tile_edge"
	turf_type = /turf/open/floor/iron/edge
	merge_type = /obj/item/stack/tile/iron/edge
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/half
	name = "半块地板砖"
	singular_name = "半块地板砖"
	icon_state = "tile_half"
	turf_type = /turf/open/floor/iron/half
	merge_type = /obj/item/stack/tile/iron/half
	tile_rotate_dirs = list(SOUTH, NORTH)

/obj/item/stack/tile/iron/corner
	name = "转角地板砖"
	singular_name = "转角地板砖"
	icon_state = "tile_corner"
	turf_type = /turf/open/floor/iron/corner
	merge_type = /obj/item/stack/tile/iron/corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/large
	name = "大号地板砖"
	singular_name = "大号地板砖"
	icon_state = "tile_large"
	turf_type = /turf/open/floor/iron/large
	merge_type = /obj/item/stack/tile/iron/large

/obj/item/stack/tile/iron/textured
	name = "纹理地板砖"
	singular_name = "纹理地板砖"
	icon_state = "tile_textured"
	turf_type = /turf/open/floor/iron/textured
	merge_type = /obj/item/stack/tile/iron/textured

/obj/item/stack/tile/iron/textured_edge
	name = "纹理边缘地板砖"
	singular_name = "带边纹理地板砖"
	icon_state = "tile_textured_edge"
	turf_type = /turf/open/floor/iron/textured_edge
	merge_type = /obj/item/stack/tile/iron/textured_edge
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/textured_half
	name = "纹理半块地板砖"
	singular_name = "半块纹理地板砖"
	icon_state = "tile_textured_half"
	turf_type = /turf/open/floor/iron/textured_half
	merge_type = /obj/item/stack/tile/iron/textured_half
	tile_rotate_dirs = list(SOUTH, NORTH)

/obj/item/stack/tile/iron/textured_corner
	name = "纹理转角地板砖"
	singular_name = "转角纹理地板砖"
	icon_state = "tile_textured_corner"
	turf_type = /turf/open/floor/iron/textured_corner
	merge_type = /obj/item/stack/tile/iron/textured_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/textured_large
	name = "大号纹理地板砖"
	singular_name = "大号纹理地板砖"
	icon_state = "tile_textured_large"
	turf_type = /turf/open/floor/iron/textured_large
	merge_type = /obj/item/stack/tile/iron/textured_large

/obj/item/stack/tile/iron/small
	name = "小号地板砖"
	singular_name = "小号地板砖"
	icon_state = "tile_small"
	turf_type = /turf/open/floor/iron/small
	merge_type = /obj/item/stack/tile/iron/small

/obj/item/stack/tile/iron/diagonal
	name = "斜纹地板砖"
	singular_name = "斜纹地板砖"
	icon_state = "tile_diagonal"
	turf_type = /turf/open/floor/iron/diagonal
	merge_type = /obj/item/stack/tile/iron/diagonal

/obj/item/stack/tile/iron/herringbone
	name = "人字纹地板砖"
	singular_name = "人字纹地板砖"
	icon_state = "tile_herringbone"
	turf_type = /turf/open/floor/iron/herringbone
	merge_type = /obj/item/stack/tile/iron/herringbone

/obj/item/stack/tile/iron/dark
	name = "深色地板砖"
	singular_name = "深色地板砖"
	icon_state = "tile_dark"
	turf_type = /turf/open/floor/iron/dark
	merge_type = /obj/item/stack/tile/iron/dark

/obj/item/stack/tile/iron/dark/smooth_edge
	name = "深色边缘地板砖"
	singular_name = "带边深色地板砖"
	icon_state = "tile_dark_edge"
	turf_type = /turf/open/floor/iron/dark/smooth_edge
	merge_type = /obj/item/stack/tile/iron/dark/smooth_edge
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/dark/smooth_half
	name = "深色半块地板砖"
	singular_name = "半块深色地板砖"
	icon_state = "tile_dark_half"
	turf_type = /turf/open/floor/iron/dark/smooth_half
	merge_type = /obj/item/stack/tile/iron/dark/smooth_half
	tile_rotate_dirs = list(SOUTH, NORTH)

/obj/item/stack/tile/iron/dark/smooth_corner
	name = "深色转角地板砖"
	singular_name = "转角深色地板砖"
	icon_state = "tile_dark_corner"
	turf_type = /turf/open/floor/iron/dark/smooth_corner
	merge_type = /obj/item/stack/tile/iron/dark/smooth_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/dark/smooth_large
	name = "大号深色地板砖"
	singular_name = "大号深色地板砖"
	icon_state = "tile_dark_large"
	turf_type = /turf/open/floor/iron/dark/smooth_large
	merge_type = /obj/item/stack/tile/iron/dark/smooth_large

/obj/item/stack/tile/iron/dark_side
	name = "深色半边砖"
	singular_name = "深色半边地板砖"
	icon_state = "tile_darkside"
	turf_type = /turf/open/floor/iron/dark/side
	merge_type = /obj/item/stack/tile/iron/dark_side
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST, SOUTHEAST, SOUTHWEST, NORTHEAST, NORTHWEST)

/obj/item/stack/tile/iron/dark_corner
	name = "深色四分之一砖"
	singular_name = "深色四分之一地板砖"
	icon_state = "tile_darkcorner"
	turf_type = /turf/open/floor/iron/dark/corner
	merge_type = /obj/item/stack/tile/iron/dark_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/checker
	name = "棋盘格地板砖"
	singular_name = "棋盘格地板砖"
	icon_state = "tile_checker"
	turf_type = /turf/open/floor/iron/checker
	merge_type = /obj/item/stack/tile/iron/checker
	tile_rotate_dirs = list(SOUTH, NORTH)

/obj/item/stack/tile/iron/dark/textured
	name = "深色纹理地板砖"
	singular_name = "深色纹理地板砖"
	icon_state = "tile_textured_dark"
	turf_type = /turf/open/floor/iron/dark/textured
	merge_type = /obj/item/stack/tile/iron/dark/textured

/obj/item/stack/tile/iron/dark/textured_edge
	name = "深色纹理边缘地板砖"
	singular_name = "带边深色纹理地板砖"
	icon_state = "tile_textured_dark_edge"
	turf_type = /turf/open/floor/iron/dark/textured_edge
	merge_type = /obj/item/stack/tile/iron/dark/textured_edge
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/dark/textured_half
	name = "深色纹理半块地板砖"
	singular_name = "半块深色纹理地板砖"
	icon_state = "tile_textured_dark_half"
	turf_type = /turf/open/floor/iron/dark/textured_half
	merge_type = /obj/item/stack/tile/iron/dark/textured_half
	tile_rotate_dirs = list(SOUTH, NORTH)

/obj/item/stack/tile/iron/dark/textured_corner
	name = "深色纹理转角地板砖"
	singular_name = "转角深色纹理地板砖"
	icon_state = "tile_textured_dark_corner"
	turf_type = /turf/open/floor/iron/dark/textured_corner
	merge_type = /obj/item/stack/tile/iron/dark/textured_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/dark/textured_large
	name = "大号深色纹理地板砖"
	singular_name = "大号深色纹理地板砖"
	icon_state = "tile_textured_dark_large"
	turf_type = /turf/open/floor/iron/dark/textured_large
	merge_type = /obj/item/stack/tile/iron/dark/textured_large

/obj/item/stack/tile/iron/dark/small
	name = "小号深色地板砖"
	singular_name = "小号深色地板砖"
	icon_state = "tile_dark_small"
	turf_type = /turf/open/floor/iron/dark/small
	merge_type = /obj/item/stack/tile/iron/dark/small

/obj/item/stack/tile/iron/dark/diagonal
	name = "深色斜纹地板砖"
	singular_name = "深色斜纹地板砖"
	icon_state = "tile_dark_diagonal"
	turf_type = /turf/open/floor/iron/dark/diagonal
	merge_type = /obj/item/stack/tile/iron/dark/diagonal

/obj/item/stack/tile/iron/dark/herringbone
	name = "深色人字纹地板砖"
	singular_name = "深色人字纹地板砖"
	icon_state = "tile_dark_herringbone"
	turf_type = /turf/open/floor/iron/dark/herringbone
	merge_type = /obj/item/stack/tile/iron/dark/herringbone

/obj/item/stack/tile/iron/white
	name = "白色地板砖"
	singular_name = "白色地板砖"
	icon_state = "tile_white"
	turf_type = /turf/open/floor/iron/white
	merge_type = /obj/item/stack/tile/iron/white

/obj/item/stack/tile/iron/white/smooth_edge
	name = "白色边缘地板砖"
	singular_name = "带边白色地板砖"
	icon_state = "tile_white_edge"
	turf_type = /turf/open/floor/iron/white/smooth_edge
	merge_type = /obj/item/stack/tile/iron/white/smooth_edge
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/white/smooth_half
	name = "白色半块地板砖"
	singular_name = "半块白色地板砖"
	icon_state = "tile_white_half"
	turf_type = /turf/open/floor/iron/white/smooth_half
	merge_type = /obj/item/stack/tile/iron/white/smooth_half
	tile_rotate_dirs = list(SOUTH, NORTH)

/obj/item/stack/tile/iron/white/smooth_corner
	name = "白色转角地板砖"
	singular_name = "转角白色地板砖"
	icon_state = "tile_white_corner"
	turf_type = /turf/open/floor/iron/white/smooth_corner
	merge_type = /obj/item/stack/tile/iron/white/smooth_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/white/smooth_large
	name = "大号白色地板砖"
	singular_name = "大号白色地板砖"
	icon_state = "tile_white_large"
	turf_type = /turf/open/floor/iron/white/smooth_large
	merge_type = /obj/item/stack/tile/iron/white/smooth_large

/obj/item/stack/tile/iron/white_side
	name = "白色半边砖"
	singular_name = "白色半边地板砖"
	icon_state = "tile_whiteside"
	turf_type = /turf/open/floor/iron/white/side
	merge_type = /obj/item/stack/tile/iron/white_side
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST, SOUTHEAST, SOUTHWEST, NORTHEAST, NORTHWEST)

/obj/item/stack/tile/iron/white_corner
	name = "白色四分之一砖"
	singular_name = "白色四分之一地板砖"
	icon_state = "tile_whitecorner"
	turf_type = /turf/open/floor/iron/white/corner
	merge_type = /obj/item/stack/tile/iron/white_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/cafeteria
	name = "餐厅地板砖"
	singular_name = "餐厅地板砖"
	icon_state = "tile_cafeteria"
	turf_type = /turf/open/floor/iron/cafeteria
	merge_type = /obj/item/stack/tile/iron/cafeteria
	tile_rotate_dirs = list(SOUTH, NORTH)

/obj/item/stack/tile/iron/white/textured
	name = "白色纹理地板砖"
	singular_name = "白色纹理地板砖"
	icon_state = "tile_textured_white"
	turf_type = /turf/open/floor/iron/white/textured
	merge_type = /obj/item/stack/tile/iron/white/textured

/obj/item/stack/tile/iron/white/textured_edge
	name = "白色纹理边缘地板砖"
	singular_name = "带边白色纹理地板砖"
	icon_state = "tile_textured_white_edge"
	turf_type = /turf/open/floor/iron/white/textured_edge
	merge_type = /obj/item/stack/tile/iron/white/textured_edge
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/white/textured_half
	name = "白色纹理半块地板砖"
	singular_name = "半块白色纹理地板砖"
	icon_state = "tile_textured_white_half"
	turf_type = /turf/open/floor/iron/white/textured_half
	merge_type = /obj/item/stack/tile/iron/white/textured_half
	tile_rotate_dirs = list(SOUTH, NORTH)

/obj/item/stack/tile/iron/white/textured_corner
	name = "白色纹理转角地板砖"
	singular_name = "转角白色纹理地板砖"
	icon_state = "tile_textured_white_corner"
	turf_type = /turf/open/floor/iron/white/textured_corner
	merge_type = /obj/item/stack/tile/iron/white/textured_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/white/textured_large
	name = "大号白色纹理地板砖"
	singular_name = "大号白色纹理地板砖"
	icon_state = "tile_textured_white_large"
	turf_type = /turf/open/floor/iron/white/textured_large
	merge_type = /obj/item/stack/tile/iron/white/textured_large

/obj/item/stack/tile/iron/white/small
	name = "小号白色地板砖"
	singular_name = "小号白色地板砖"
	icon_state = "tile_white_small"
	turf_type = /turf/open/floor/iron/white/small
	merge_type = /obj/item/stack/tile/iron/white/small

/obj/item/stack/tile/iron/white/diagonal
	name = "白色斜纹地板砖"
	singular_name = "白色斜纹地板砖"
	icon_state = "tile_white_diagonal"
	turf_type = /turf/open/floor/iron/white/diagonal
	merge_type = /obj/item/stack/tile/iron/white/diagonal

/obj/item/stack/tile/iron/white/herringbone
	name = "白色人字纹地板砖"
	singular_name = "白色人字纹地板砖"
	icon_state = "tile_white_herringbone"
	turf_type = /turf/open/floor/iron/white/herringbone
	merge_type = /obj/item/stack/tile/iron/white/herringbone

/obj/item/stack/tile/iron/recharge_floor
	name = "充能地板砖"
	singular_name = "充能地板砖"
	icon_state = "tile_recharge"
	turf_type = /turf/open/floor/iron/recharge_floor
	merge_type = /obj/item/stack/tile/iron/recharge_floor

/obj/item/stack/tile/iron/recharge_floor/dark
	name = "深色充电地板砖"
	singular_name = "深色充电地板砖"
	icon_state = "tile_dark_recharge"
	turf_type = /turf/open/floor/iron/recharge_floor/dark
	merge_type = /obj/item/stack/tile/iron/recharge_floor/dark

/obj/item/stack/tile/iron/recharge_floor/white
	name = "白色充电地板砖"
	singular_name = "白色充电地板砖"
	icon_state = "tile_white_recharge"
	turf_type = /turf/open/floor/iron/recharge_floor/white
	merge_type = /obj/item/stack/tile/iron/recharge_floor/white

/obj/item/stack/tile/iron/recharge_floor/smooth
	name = "光滑充电地板砖"
	singular_name = "光滑充电地板砖"
	icon_state = "tile_smooth_recharge"
	turf_type = /turf/open/floor/iron/recharge_floor/smooth
	merge_type = /obj/item/stack/tile/iron/recharge_floor/smooth

/obj/item/stack/tile/iron/smooth
	name = "光滑地板砖"
	singular_name = "光滑地板砖"
	icon_state = "tile_smooth"
	turf_type = /turf/open/floor/iron/smooth
	merge_type = /obj/item/stack/tile/iron/smooth

/obj/item/stack/tile/iron/smooth_edge
	name = "光滑边缘地板砖"
	singular_name = "带边光滑地板砖"
	icon_state = "tile_smooth_edge"
	turf_type = /turf/open/floor/iron/smooth_edge
	merge_type = /obj/item/stack/tile/iron/smooth_edge
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/smooth_half
	name = "光滑半块地板砖"
	singular_name = "半块光滑地板砖"
	icon_state = "tile_smooth_half"
	turf_type = /turf/open/floor/iron/smooth_half
	merge_type = /obj/item/stack/tile/iron/smooth_half
	tile_rotate_dirs = list(SOUTH, NORTH)

/obj/item/stack/tile/iron/smooth_corner
	name = "光滑转角地板砖"
	singular_name = "转角光滑地板砖"
	icon_state = "tile_smooth_corner"
	turf_type = /turf/open/floor/iron/smooth_corner
	merge_type = /obj/item/stack/tile/iron/smooth_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/smooth_large
	name = "大号光滑地板砖"
	singular_name = "大号光滑地板砖"
	icon_state = "tile_smooth_large"
	turf_type = /turf/open/floor/iron/smooth_large
	merge_type = /obj/item/stack/tile/iron/smooth_large

/obj/item/stack/tile/iron/terracotta
	name = "陶土地板砖"
	singular_name = "陶土地板砖"
	icon_state = "tile_terracotta"
	turf_type = /turf/open/floor/iron/terracotta
	merge_type = /obj/item/stack/tile/iron/terracotta

/obj/item/stack/tile/iron/terracotta/small
	name = "小号陶土地板砖"
	singular_name = "小号陶土地板砖"
	icon_state = "tile_terracotta_small"
	turf_type = /turf/open/floor/iron/terracotta/small
	merge_type = /obj/item/stack/tile/iron/terracotta/small

/obj/item/stack/tile/iron/terracotta/diagonal
	name = "陶土斜纹地板砖"
	singular_name = "陶土斜纹地板砖"
	icon_state = "tile_terracotta_diagonal"
	turf_type = /turf/open/floor/iron/terracotta/diagonal
	merge_type = /obj/item/stack/tile/iron/terracotta/diagonal

/obj/item/stack/tile/iron/terracotta/herringbone
	name = "陶土人字纹地板砖"
	singular_name = "陶土人字纹地板砖"
	icon_state = "tile_terracotta_herringbone"
	turf_type = /turf/open/floor/iron/terracotta/herringbone
	merge_type = /obj/item/stack/tile/iron/terracotta/herringbone

/obj/item/stack/tile/iron/kitchen
	name = "厨房地板砖"
	singular_name = "厨房地板砖"
	icon_state = "tile_kitchen"
	turf_type = /turf/open/floor/iron/kitchen
	merge_type = /obj/item/stack/tile/iron/kitchen

/obj/item/stack/tile/iron/kitchen/small
	name = "小号厨房地板砖"
	singular_name = "小号厨房地板砖"
	icon_state = "tile_kitchen_small"
	turf_type = /turf/open/floor/iron/kitchen/small
	merge_type = /obj/item/stack/tile/iron/kitchen/small

/obj/item/stack/tile/iron/kitchen/diagonal
	name = "斜纹厨房地板砖"
	singular_name = "斜纹厨房地板砖"
	icon_state = "tile_kitchen_diagonal"
	turf_type = /turf/open/floor/iron/kitchen/diagonal
	merge_type = /obj/item/stack/tile/iron/kitchen/diagonal

/obj/item/stack/tile/iron/kitchen/herringbone
	name = "人字纹厨房地板砖"
	singular_name = "人字纹厨房地板砖"
	icon_state = "tile_kitchen_herringbone"
	turf_type = /turf/open/floor/iron/kitchen/herringbone
	merge_type = /obj/item/stack/tile/iron/kitchen/herringbone

/obj/item/stack/tile/iron/chapel
	name = "礼拜堂地板砖"
	singular_name = "礼拜堂地板砖"
	icon_state = "tile_chapel"
	turf_type = /turf/open/floor/iron/chapel
	merge_type = /obj/item/stack/tile/iron/chapel
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST, SOUTHEAST, SOUTHWEST, NORTHEAST, NORTHWEST)

/obj/item/stack/tile/iron/showroomfloor
	name = "展厅地板砖"
	singular_name = "展厅地板砖"
	icon_state = "tile_showroom"
	turf_type = /turf/open/floor/iron/showroomfloor
	merge_type = /obj/item/stack/tile/iron/showroomfloor

/obj/item/stack/tile/iron/solarpanel
	name = "太阳能板地板砖"
	singular_name = "太阳能板地板砖"
	icon_state = "tile_solarpanel"
	turf_type = /turf/open/floor/iron/solarpanel
	merge_type = /obj/item/stack/tile/iron/solarpanel

/obj/item/stack/tile/iron/freezer
	name = "冷库地板砖"
	singular_name = "冷库地板砖"
	icon_state = "tile_freezer"
	turf_type = /turf/open/floor/iron/freezer
	merge_type = /obj/item/stack/tile/iron/freezer

/obj/item/stack/tile/iron/freezer/edge
	name = "冷库边缘地板砖"
	singular_name = "带边冷库地板砖"
	icon_state = "tile_freezer_edge"
	turf_type = /turf/open/floor/iron/freezer/edge
	merge_type = /obj/item/stack/tile/iron/freezer/edge
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/freezer/half
	name = "冷库半块地板砖"
	singular_name = "半块冷库地板砖"
	icon_state = "tile_freezer_half"
	turf_type = /turf/open/floor/iron/freezer/half
	merge_type = /obj/item/stack/tile/iron/freezer/half
	tile_rotate_dirs = list(SOUTH, NORTH)

/obj/item/stack/tile/iron/freezer/corner
	name = "冷库转角地板砖"
	singular_name = "转角冷库地板砖"
	icon_state = "tile_freezer_corner"
	turf_type = /turf/open/floor/iron/freezer/corner
	merge_type = /obj/item/stack/tile/iron/freezer/corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/iron/freezer/large
	name = "大号冷库地板砖"
	singular_name = "大号冷库地板砖"
	icon_state = "tile_freezer_large"
	turf_type = /turf/open/floor/iron/freezer/large
	merge_type = /obj/item/stack/tile/iron/freezer/large

/obj/item/stack/tile/iron/grimy
	name = "污垢地板砖"
	singular_name = "污垢地板砖"
	icon_state = "tile_grimy"
	turf_type = /turf/open/floor/iron/grimy
	merge_type = /obj/item/stack/tile/iron/grimy

/obj/item/stack/tile/iron/sepia
	name = "棕褐地板砖"
	singular_name = "棕褐地板砖"
	desc = "嗯，这些地砖上的时间流动是正常的，真奇怪。"
	icon_state = "tile_sepia"
	turf_type = /turf/open/floor/iron/sepia
	merge_type = /obj/item/stack/tile/iron/sepia

//Tiles below can't be gotten through tile reskinning

/obj/item/stack/tile/iron/bluespace
	name = "蓝空间地板砖"
	singular_name = "蓝空间地板砖"
	desc = "可惜的是，这些地砖似乎并不能让你跑得更快……"
	icon_state = "tile_bluespace"
	turf_type = /turf/open/floor/iron/bluespace
	merge_type = /obj/item/stack/tile/iron/bluespace
	tile_reskin_types = null

/obj/item/stack/tile/iron/goonplaque
	name = "铭牌地板砖"
	singular_name = "铭牌地板砖"
	desc = "“这块铭牌献给 G4407 空间站上的同志们。希望 TG4407 型号能配得上你们的声名与财富。”下面潦草地刻着一幅粗糙的图画：一颗流星和一个太空人。太空人在大笑，流星正在爆炸。"
	icon_state = "tile_plaque"
	turf_type = /turf/open/floor/iron/goonplaque
	merge_type = /obj/item/stack/tile/iron/goonplaque
	tile_reskin_types = null

/obj/item/stack/tile/iron/vaporwave
	name = "蒸汽波地板砖"
	singular_name = "蒸汽波地板砖"
	icon_state = "tile_vaporwave"
	turf_type = /turf/open/floor/iron/vaporwave
	merge_type = /obj/item/stack/tile/iron/vaporwave
	tile_reskin_types = null
