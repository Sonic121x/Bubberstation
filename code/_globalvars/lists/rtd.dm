///all designs supported by the RTD
GLOBAL_LIST_INIT(floor_designs, list(
	//what players will use most of the time
	"Conventional" = list(
		//The most common types
		"Standard" = list(
			list("name" = "基础", "type" = /obj/item/stack/tile/iron, "tile_cost" = 4),
			list("name" = "小型", "type" = /obj/item/stack/tile/iron/small, "tile_cost" = 3),
			list("name" = "大型", "type" = /obj/item/stack/tile/iron/large, "tile_cost" = 7),
			list("name" = "斜向", "type" = /obj/item/stack/tile/iron/diagonal, "tile_cost" = 5),
			list("name" = "边缘", "type" = /obj/item/stack/tile/iron/edge, "tile_cost" = 5),
			list("name" = "半块", "type" = /obj/item/stack/tile/iron/half, "tile_cost" = 5),
			list("name" = "角落", "type" = /obj/item/stack/tile/iron/corner, "tile_cost" = 5),
			list("name" = "纹理", "type" = /obj/item/stack/tile/iron/textured, "tile_cost" = 5),
			list("name" = "纹理边缘", "type" = /obj/item/stack/tile/iron/textured_edge, "tile_cost" = 6),
			list("name" = "纹理半块", "type" = /obj/item/stack/tile/iron/textured_half, "tile_cost" = 6),
			list("name" = "纹理角落", "type" = /obj/item/stack/tile/iron/textured_corner, "tile_cost" = 6),
			list("name" = "大型纹理", "type" = /obj/item/stack/tile/iron/textured_large, "tile_cost" = 6),
		),
		//Looks slightly transparent or faded
		"Translucent" = list(
			list("name" = "光滑", "type" = /obj/item/stack/tile/iron/smooth, "tile_cost" = 4),
			list("name" = "光滑边缘", "type" = /obj/item/stack/tile/iron/smooth_edge, "tile_cost" = 4),
			list("name" = "光滑半块", "type" = /obj/item/stack/tile/iron/smooth_half, "tile_cost" = 4),
			list("name" = "光滑角落", "type" = /obj/item/stack/tile/iron/smooth_corner, "tile_cost" = 4),
			list("name" = "大型光滑", "type" = /obj/item/stack/tile/iron/smooth_large, "tile_cost" = 7),
			list("name" = "冷冻室", "type" = /obj/item/stack/tile/iron/freezer, "tile_cost" = 5),
			list("name" = "展厅", "type" = /obj/item/stack/tile/iron/showroomfloor, "tile_cost" = 5),
			list("name" = "玻璃", "type" = /obj/item/stack/tile/glass, "tile_cost" = 5),
			list("name" = "强化玻璃", "type" = /obj/item/stack/tile/rglass, "tile_cost" = 10)
		),
		//Uses eletricity or atleast thats i think these do
		"Circuit" = list(
			list("name" = "充电", "type" = /obj/item/stack/tile/iron/recharge_floor, "tile_cost" = 5),
			list("name" = "太阳能板", "type" = /obj/item/stack/tile/iron/solarpanel, "tile_cost" = 5),
			list("name" = "蓝色电路", "type" = /obj/item/stack/tile/circuit, "tile_cost" = 5),
			list("name" = "绿色电路", "type" = /obj/item/stack/tile/circuit/green, "tile_cost" = 5),
			list("name" = "动态绿色电路", "type" = /obj/item/stack/tile/circuit/green/anim, "tile_cost" = 5),
			list("name" = "红色电路", "type" = /obj/item/stack/tile/circuit/red, "tile_cost" = 5),
			list("name" = "动态红色电路", "type" = /obj/item/stack/tile/circuit/red/anim, "tile_cost" = 5),
		)
	),

	//Floors which are decorated
	"Decorated" = list(
		//Dark Colored tiles
		"Dark Colored" = list(
			list("name" = "基础", "type" = /obj/item/stack/tile/iron/dark, "tile_cost" = 4),
			list("name" = "光滑边缘", "type" = /obj/item/stack/tile/iron/dark/smooth_edge, "tile_cost" = 4),
			list("name" = "光滑半块", "type" = /obj/item/stack/tile/iron/dark/smooth_half, "tile_cost" = 4),
			list("name" = "光滑角落" ,"type" = /obj/item/stack/tile/iron/dark/smooth_corner, "tile_cost" = 4),
			list("name" = "大型光滑", "type" = /obj/item/stack/tile/iron/dark/smooth_large, "tile_cost" = 7),
			list("name" = "小型", "type" = /obj/item/stack/tile/iron/dark/small, "tile_cost" = 4),
			list("name" = "斜向", "type" = /obj/item/stack/tile/iron/dark/diagonal, "tile_cost" = 4),
			list("name" = "人字纹", "type" = /obj/item/stack/tile/iron/dark/herringbone, "tile_cost" = 4),
			list("name" = "半块深色", "type" = /obj/item/stack/tile/iron/dark_side, "tile_cost" = 4),
			list("name" = "深色角落" ,"type" = /obj/item/stack/tile/iron/dark_corner, "tile_cost" = 4),
		),

		//White Colored tiles
		"White Colored" = list(
			list("name" = "基础", "type" = /obj/item/stack/tile/iron/white, "tile_cost" = 5),
			list("name" = "光滑边缘", "type" = /obj/item/stack/tile/iron/white/smooth_edge, "tile_cost" = 5),
			list("name" = "光滑半块", "type" = /obj/item/stack/tile/iron/white/smooth_half, "tile_cost" = 5),
			list("name" = "光滑角落", "type" = /obj/item/stack/tile/iron/white/smooth_corner, "tile_cost" = 5),
			list("name" = "大型光滑", "type" = /obj/item/stack/tile/iron/white/smooth_large, "tile_cost" = 7),
			list("name" = "小型", "type" = /obj/item/stack/tile/iron/white/small, "tile_cost" = 5),
			list("name" = "斜向", "type" = /obj/item/stack/tile/iron/white/diagonal, "tile_cost" = 5),
			list("name" = "人字纹", "type" = /obj/item/stack/tile/iron/white/herringbone, "tile_cost" = 5),
			list("name" = "半块白色", "type" = /obj/item/stack/tile/iron/white_side, "tile_cost" = 5),
			list("name" = "白色角落", "type" = /obj/item/stack/tile/iron/white_corner, "tile_cost" = 5),
		),

		//Textured tiles
		"Textured" = list(
			list("name" = "白色纹理", "type" = /obj/item/stack/tile/iron/white/textured, "tile_cost" = 5),
			list("name" = "白色纹理边缘", "type" = /obj/item/stack/tile/iron/white/textured_edge, "tile_cost" = 5),
			list("name" = "白色纹理半块", "type" = /obj/item/stack/tile/iron/white/textured_half, "tile_cost" = 5),
			list("name" = "白色纹理角落", "type" = /obj/item/stack/tile/iron/white/textured_corner, "tile_cost" = 5),
			list("name" = "大型白色纹理", "type" = /obj/item/stack/tile/iron/white/textured_large, "tile_cost" = 7),
			list("name" = "深色纹理", "type" = /obj/item/stack/tile/iron/dark/textured, "tile_cost" = 5),
			list("name" = "深色纹理边缘", "type" = /obj/item/stack/tile/iron/dark/textured_edge, "tile_cost" = 5),
			list("name" = "深色纹理半块", "type" = /obj/item/stack/tile/iron/dark/textured_half, "tile_cost" = 5),
			list("name" = "深色纹理角落", "type" = /obj/item/stack/tile/iron/dark/textured_corner, "tile_cost" = 5),
			list("name" = "大型深色纹理", "type" = /obj/item/stack/tile/iron/dark/textured_large, "tile_cost" = 7),
		)
	),

	//Tiles which you decorate your home with
	"Interior" = list(
		//Common room tiles
		"Room" = list(
			list("name" = "厨房", "type" = /obj/item/stack/tile/iron/kitchen, "tile_cost" = 4),
			list("name" = "小型厨房", "type" = /obj/item/stack/tile/iron/kitchen/small, "tile_cost" = 4),
			list("name" = "斜向厨房", "type" = /obj/item/stack/tile/iron/kitchen/diagonal, "tile_cost" = 4),
			list("name" = "教堂", "type" = /obj/item/stack/tile/iron/chapel, "tile_cost" = 4),
			list("name" = "餐厅", "type" = /obj/item/stack/tile/iron/cafeteria, "tile_cost" = 4),
			list("name" = "污垢", "type" = /obj/item/stack/tile/iron/grimy, "tile_cost" = 5),
			list("name" = "棕褐色", "type" = /obj/item/stack/tile/iron/sepia, "tile_cost" = 5),
			list("name" = "人字纹", "type" = /obj/item/stack/tile/iron/kitchen/herringbone, "tile_cost" = 5),
		),

		//Culd have called it miscellaneous but nah too long
		"Pattern" = list(
			list("name" = "陶土", "type" = /obj/item/stack/tile/iron/terracotta, "tile_cost" = 5),
			list("name" = "小型", "type" = /obj/item/stack/tile/iron/terracotta/small, "tile_cost" = 5),
			list("name" = "斜向", "type" = /obj/item/stack/tile/iron/terracotta/diagonal, "tile_cost" = 5),
			list("name" = "人字纹", "type" = /obj/item/stack/tile/iron/terracotta/herringbone, "tile_cost" = 5),
			list("name" = "棋盘格", "type" = /obj/item/stack/tile/iron/checker, "tile_cost" = 5),
			list("name" = "人字纹", "type" = /obj/item/stack/tile/iron/herringbone, "tile_cost" = 5),
		)
	)
))

/// Lazy-initialize the datum field on all the designs
/proc/populate_rtd_datums()
	for(var/main_root in GLOB.floor_designs)
		for(var/sub_category in GLOB.floor_designs[main_root])
			for(var/list/design in GLOB.floor_designs[main_root][sub_category])
				var/datum/tile_info/tile_data = new /datum/tile_info(design)
				design["datum"] = tile_data
