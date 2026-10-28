/*
HEY!!! LISTEN!!!
Due to some fuckery with how these templates work; the bottom left turf of your map HAS to touch the rest AND has to be on the same /area/.
*/

/datum/map_template/condo
	/// Offset from the bottom-left turf of your condo. Said turf MUST touch the rest of your condo due to how these templates are loaded; including in /area/.
	var/landing_zone_x_offset
	var/landing_zone_y_offset

/// Keep these alphabetical.

/datum/map_template/condo/alleyway
	name = "公寓 - 小巷"
	mappath = "modular_zubbers/code/modules/condos/_maps/alleyway.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 5

/datum/map_template/condo/apartment
	name = "公寓 - 公寓房"
	mappath = "modular_zubbers/code/modules/condos/_maps/apartment.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/blueshift_dorms_four
	name = "公寓 - “蓝移”风格宿舍"
	mappath = "modular_zubbers/code/modules/condos/_maps/blueshift_dormsfour.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 2

/// Wowee! It's like I'm a real terrorist!
/// This particular one was cooler with wallening window frames and short stairs.. alas. twas not to be
/datum/map_template/condo/dstwo_condo
	name = "公寓 - 正宗 DS-2 主题"
	mappath = "modular_zubbers/code/modules/condos/_maps/dstwo_condo.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 2

/datum/map_template/condo/beach_condo
	name = "公寓 - 海滨"
	mappath = "modular_zubbers/code/modules/condos/_maps/beach_condo.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 2

/datum/map_template/condo/gm_condo
	name = "公寓 - 套房"
	mappath = "modular_zubbers/code/modules/condos/_maps/gm_condo.dmm"
	landing_zone_x_offset = 4
	landing_zone_y_offset = 2

/// This version's actually slightly different to justify itself; being based off the wallening version.
/datum/map_template/condo/hilberts_hotel
	name = "公寓 - 希尔伯特酒店客房"
	mappath = "modular_zubbers/code/modules/condos/_maps/hilbertshotel.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 12

/datum/map_template/condo/lodge_pool
	name = "公寓 - 旅舍泳池"
	mappath = "modular_zubbers/code/modules/condos/_maps/lodge_pool.dmm"
	landing_zone_x_offset = 10
	landing_zone_y_offset = 1

/datum/map_template/condo/manor_hall
	name = "公寓 - 庄园大厅"
	mappath = "modular_zubbers/code/modules/condos/_maps/manor_hall.dmm"
	landing_zone_x_offset = 1
	landing_zone_y_offset = 3

/datum/map_template/condo/medieval_bog
	name = "公寓 - 中世纪沼泽"
	mappath = "modular_zubbers/code/modules/condos/_maps/medieval_bog.dmm"
	landing_zone_x_offset = 1
	landing_zone_y_offset = 3

/datum/map_template/condo/necropolis
	name = "公寓 - 死灵之都"
	mappath = "modular_zubbers/code/modules/condos/_maps/necropolis.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 11

/datum/map_template/condo/ocean_view
	name = "公寓 - 海景"
	mappath = "modular_zubbers/code/modules/condos/_maps/ocean_view.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 1

/datum/map_template/condo/ouroboros_dorms_four
	name = "公寓 - “衔尾蛇”风格宿舍"
	mappath = "modular_zubbers/code/modules/condos/_maps/ouroboros_dormssix.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 4

/// The joke was originally that it was just flatgrass. Now it's a little more.
/datum/map_template/condo/planar_soil
	name = "公寓 - 位面土壤"
	mappath = "modular_zubbers/code/modules/condos/_maps/planar_soil.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 1

/datum/map_template/condo/serenity_cabin_four
	name = "公寓 - “宁静”风格木屋"
	mappath = "modular_zubbers/code/modules/condos/_maps/serenity_cabinfour.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 1

/datum/map_template/condo/snowglobe_dorms_four
	name = "公寓 - “雪花球”风格宿舍"
	mappath = "modular_zubbers/code/modules/condos/_maps/snowglobe_dormsfour.dmm"
	landing_zone_x_offset = 6
	landing_zone_y_offset = 3

/datum/map_template/condo/station_arrivals
	name = "公寓 - 到达站检查点"
	mappath = "modular_zubbers/code/modules/condos/_maps/station_arrivals.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 2

/datum/map_template/condo/xeno_resin
	name = "公寓 - 异形巢穴"
	mappath = "modular_zubbers/code/modules/condos/_maps/xeno_resin.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 1

/datum/map_template/condo/cabin_woods
	name = "公寓 - 林中木屋"
	mappath = "modular_zubbers/code/modules/condos/_maps/cabin_woods.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 1

/datum/map_template/condo/ship_bridge
	name = "公寓 - 飞船舰桥"
	mappath = "modular_zubbers/code/modules/condos/_maps/ship_bridge.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/public_library
	name = "公寓 - 公共图书馆"
	mappath = "modular_zubbers/code/modules/condos/_maps/public_library.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 1

/datum/map_template/condo/mountainside_apartment
	name = "公寓 - 山腰公寓"
	mappath = "modular_zubbers/code/modules/condos/_maps/apartment_mountainside.dmm"
	landing_zone_x_offset = 14
	landing_zone_y_offset = 4

/datum/map_template/condo/mountainside_fortuneteller
	name = "公寓 - 占卜师公寓"
	mappath = "modular_zubbers/code/modules/condos/_maps/apartment_fortuneteller.dmm"
	landing_zone_x_offset = 5
	landing_zone_y_offset = 8

/datum/map_template/condo/mountainside_skyscraper
	name = "公寓 - 摩天大楼"
	mappath = "modular_zubbers/code/modules/condos/_maps/apartment_skyscraper.dmm"
	landing_zone_x_offset = 17
	landing_zone_y_offset = 3

/datum/map_template/condo/mountainside_dragonlair
	name = "公寓 - 龙巢"
	mappath = "modular_zubbers/code/modules/condos/_maps/apartment_dragonslair.dmm"
	landing_zone_x_offset = 5
	landing_zone_y_offset = 11

/datum/map_template/condo/deepspace_ship
	name = "公寓 - 深空飞船"
	mappath = "modular_zubbers/code/modules/condos/_maps/ship_apartment.dmm"
	landing_zone_x_offset = 9
	landing_zone_y_offset = 2

/datum/map_template/condo/deepspace_pod
	name = "公寓 - 深空舱"
	mappath = "modular_zubbers/code/modules/condos/_maps/deepspace_pod.dmm"
	landing_zone_x_offset = 1
	landing_zone_y_offset = 2

// Bubber Maps start here

/datum/map_template/condo/corpo
	name = "公寓 - 企业办公室（纳米传讯）"
	mappath = "modular_zubbers/code/modules/condos/_maps/corporateoffice.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 9

/datum/map_template/condo/corposyndi
	name = "公寓 - 企业办公室（辛迪加）"
	mappath = "modular_zubbers/code/modules/condos/_maps/syndieoffice.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 9

/datum/map_template/condo/cultcave
	name = "公寓 - 教团洞穴"
	mappath = "modular_zubbers/code/modules/condos/_maps/cultcave.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 13

/datum/map_template/condo/engineering
	name = "公寓 - 工程部"
	mappath = "modular_zubbers/code/modules/condos/_maps/engineering.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 10

/datum/map_template/condo/eva
	name = "公寓 - 太空漫步"
	mappath = "modular_zubbers/code/modules/condos/_maps/eva.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/foxbar
	name = "公寓 - 狐狸盒子"
	mappath = "modular_zubbers/code/modules/condos/_maps/foxbar.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/grotto
	name = "公寓 - 洞窟（白天）"
	mappath = "modular_zubbers/code/modules/condos/_maps/grotto.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/grottoalt
	name = "公寓 - 洞窟（夜晚）"
	mappath = "modular_zubbers/code/modules/condos/_maps/grottoalt.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/nightclub //You gotta come to my cosuin's club, it's called Stepford
	name = "公寓 - 表亲夜店"
	mappath = "modular_zubbers/code/modules/condos/_maps/nightclub.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/oasis
	name = "公寓 - 绿洲（白天）"
	mappath = "modular_zubbers/code/modules/condos/_maps/oasis.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/oasisalt
	name = "公寓 - 绿洲（夜晚）"
	mappath = "modular_zubbers/code/modules/condos/_maps/oasisalt.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/poole
	name = "公寓 - 酒店泳池"
	mappath = "modular_zubbers/code/modules/condos/_maps/pool.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/bubberlibrary
	name = "公寓 - 私人图书馆"
	mappath = "modular_zubbers/code/modules/condos/_maps/library.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/prison
	name = "公寓 - 布里克斯顿监狱"
	mappath = "modular_zubbers/code/modules/condos/_maps/prisoninfdorm.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 2

/datum/map_template/condo/hospital
	name = "公寓 - 医院病房"
	mappath = "modular_zubbers/code/modules/condos/_maps/recovery.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/stationside
	name = "公寓 - 空间站一角"
	mappath = "modular_zubbers/code/modules/condos/_maps/stationside.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 3

/datum/map_template/condo/synopcenter
	name = "公寓 - 辛迪加行动枢纽"
	mappath = "modular_zubbers/code/modules/condos/_maps/synopcenter.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/winterwoods
	name = "公寓 - 雪原荒野"
	mappath = "modular_zubbers/code/modules/condos/_maps/winterwoods.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 6

/datum/map_template/condo/evacstat
	name = "公寓 - 撤离中的空间站"
	mappath = "evacuationstation.dmm"
	landing_zone_x_offset = 15
	landing_zone_y_offset = 8

//PORTED FROM IRIS
/datum/map_template/condo/fast_food
	name = "公寓 - 美式餐馆"
	mappath = "modular_zubbers/code/modules/condos/_maps/fast_food.dmm"
	landing_zone_x_offset = 8
	landing_zone_y_offset = 2

/datum/map_template/condo/kinodertoten
	name = "公寓 - 电影院"
	mappath = "modular_zubbers/code/modules/condos/_maps/cinema.dmm"
	landing_zone_x_offset = 10
	landing_zone_y_offset = 4
