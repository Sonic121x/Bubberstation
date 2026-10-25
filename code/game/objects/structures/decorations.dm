/obj/structure/decoration
	name = "塑料装饰品"
	desc = "一件廉价的塑料仿自然装饰。至少它不需要浇水。"
	icon = 'icons/obj/fluff/flora/ausflora.dmi'
	resistance_flags = FLAMMABLE
	max_integrity = 20
	anchored = TRUE
	alpha = 210
	/// No material refund on deconstruction, it's cheap plastic
	custom_materials = null

/obj/structure/decoration/Initialize(mapload)
	. = ..()

/obj/structure/decoration/atom_deconstruct(disassembled = TRUE)
	if(!disassembled)
		new /obj/effect/decal/cleanable/plastic(loc)
	return

/obj/structure/decoration/examine(mob/user)
	. = ..()
	. += span_notice("它由廉价的中空塑料制成。")

/obj/structure/decoration/grass
	name = "塑料草坪"
	desc = "假草。摸起来像钢丝刷。"
	icon = /obj/structure/flora/grass/green::icon
	icon_state = /obj/structure/flora/grass/green::icon_state

/obj/structure/decoration/grass/first
	// inherits from parent

/obj/structure/decoration/grass/second
	icon_state = /obj/structure/flora/grass/green/style_2::icon_state

/obj/structure/decoration/grass/third
	icon_state = /obj/structure/flora/grass/green/style_3::icon_state

/obj/structure/decoration/grass/style_random/Initialize(mapload)
	. = ..()
	icon_state = "snowgrass[rand(1, 3)]gb"
	update_appearance()

/obj/structure/decoration/grass/brown
	icon = /obj/structure/flora/grass/brown::icon
	icon_state = /obj/structure/flora/grass/brown::icon_state

/obj/structure/decoration/grass/brown/first

/obj/structure/decoration/grass/brown/second
	icon_state = /obj/structure/flora/grass/brown/style_2::icon_state

/obj/structure/decoration/grass/brown/third
	icon_state = /obj/structure/flora/grass/brown/style_3::icon_state

/obj/structure/decoration/grass/brown/style_random/Initialize(mapload)
	. = ..()
	icon_state = "snowgrass[rand(1, 3)]bb"
	update_appearance()

/obj/structure/decoration/jungle_grass
	name = "塑料丛林草"
	desc = "塑料做的异星感草丛。有丛林情调，没有丛林虫子。"
	icon = /obj/structure/flora/grass/jungle::icon
	icon_state = /obj/structure/flora/grass/jungle::icon_state

/obj/structure/decoration/jungle_grass/first

/obj/structure/decoration/jungle_grass/second
	icon_state = /obj/structure/flora/grass/jungle/a/style_2::icon_state

/obj/structure/decoration/jungle_grass/third
	icon_state = /obj/structure/flora/grass/jungle/a/style_3::icon_state

/obj/structure/decoration/jungle_grass/fourth
	icon_state = /obj/structure/flora/grass/jungle/a/style_4::icon_state

/obj/structure/decoration/jungle_grass/fifth
	icon_state = /obj/structure/flora/grass/jungle/a/style_5::icon_state

/obj/structure/decoration/jungle_grass/style_random/Initialize(mapload)
	. = ..()
	icon_state = "grassa[rand(1, 5)]"
	update_appearance()

/obj/structure/decoration/jungle_grass/b
	icon = /obj/structure/flora/grass/jungle/b::icon
	icon_state = /obj/structure/flora/grass/jungle/b::icon_state

/obj/structure/decoration/jungle_grass/b/first

/obj/structure/decoration/jungle_grass/b/second
	icon_state = /obj/structure/flora/grass/jungle/b/style_2::icon_state

/obj/structure/decoration/jungle_grass/b/third
	icon_state = /obj/structure/flora/grass/jungle/b/style_3::icon_state

/obj/structure/decoration/jungle_grass/b/fourth
	icon_state = /obj/structure/flora/grass/jungle/b/style_4::icon_state

/obj/structure/decoration/jungle_grass/b/fifth
	icon_state = /obj/structure/flora/grass/jungle/b/style_5::icon_state

/obj/structure/decoration/jungle_grass/b/style_random/Initialize(mapload)
	. = ..()
	icon_state = "grassb[rand(1, 5)]"
	update_appearance()

/obj/structure/decoration/bush
	name = "塑料灌木"
	desc = "一丛塑料矮树。摸起来刺手，颜色也略微不对。"
	icon = /obj/structure/flora/bush::icon
	icon_state = /obj/structure/flora/bush::icon_state

/obj/structure/decoration/bush/first

/obj/structure/decoration/bush/second
	icon_state = /obj/structure/flora/bush/style_2::icon_state

/obj/structure/decoration/bush/third
	icon_state = /obj/structure/flora/bush/style_3::icon_state

/obj/structure/decoration/bush/fourth
	icon_state = /obj/structure/flora/bush/style_4::icon_state

/obj/structure/decoration/bush/style_random/Initialize(mapload)
	. = ..()
	icon_state = "firstbush_[rand(1, 4)]"
	update_appearance()

/obj/structure/decoration/bush/reed
	name = "塑料芦苇"
	icon = /obj/structure/flora/bush/reed::icon
	icon_state = /obj/structure/flora/bush/reed::icon_state

/obj/structure/decoration/bush/reed/first

/obj/structure/decoration/bush/reed/second
	icon_state = /obj/structure/flora/bush/reed/style_2::icon_state

/obj/structure/decoration/bush/reed/third
	icon_state = /obj/structure/flora/bush/reed/style_3::icon_state

/obj/structure/decoration/bush/reed/fourth
	icon_state = /obj/structure/flora/bush/reed/style_4::icon_state

/obj/structure/decoration/bush/reed/style_random/Initialize(mapload)
	. = ..()
	icon_state = "reedbush_[rand(1, 4)]"
	update_appearance()

/obj/structure/decoration/bush/leafy
	name = "塑料阔叶灌木"
	icon = /obj/structure/flora/bush/leafy::icon
	icon_state = /obj/structure/flora/bush/leafy::icon_state

/obj/structure/decoration/bush/leafy/first

/obj/structure/decoration/bush/leafy/second
	icon_state = /obj/structure/flora/bush/leavy/style_2::icon_state

/obj/structure/decoration/bush/leafy/third
	icon_state = /obj/structure/flora/bush/leavy/style_3::icon_state

/obj/structure/decoration/bush/leafy/style_random/Initialize(mapload)
	. = ..()
	icon_state = "leafybush_[rand(1, 3)]"
	update_appearance()

/obj/structure/decoration/bush/pale
	name = "塑料灰白灌木"
	icon = /obj/structure/flora/bush/pale::icon
	icon_state = /obj/structure/flora/bush/pale::icon_state

/obj/structure/decoration/bush/pale/first

/obj/structure/decoration/bush/pale/second
	icon_state = /obj/structure/flora/bush/pale/style_2::icon_state

/obj/structure/decoration/bush/pale/third
	icon_state = /obj/structure/flora/bush/pale/style_3::icon_state

/obj/structure/decoration/bush/pale/fourth
	icon_state = /obj/structure/flora/bush/pale/style_4::icon_state

/obj/structure/decoration/bush/pale/style_random/Initialize(mapload)
	. = ..()
	icon_state = "palebush_[rand(1, 4)]"
	update_appearance()

/obj/structure/decoration/bush/stalky
	name = "塑料茎秆灌木"
	icon = /obj/structure/flora/bush/stalky::icon
	icon_state = /obj/structure/flora/bush/stalky::icon_state

/obj/structure/decoration/bush/stalky/first

/obj/structure/decoration/bush/stalky/second
	icon_state = /obj/structure/flora/bush/stalky/style_2::icon_state

/obj/structure/decoration/bush/stalky/third
	icon_state = /obj/structure/flora/bush/stalky/style_3::icon_state

/obj/structure/decoration/bush/stalky/style_random/Initialize(mapload)
	. = ..()
	icon_state = "stalkybush_[rand(1, 3)]"
	update_appearance()

/obj/structure/decoration/bush/grassy
	name = "塑料草丛灌木"
	icon = /obj/structure/flora/bush/grassy::icon
	icon_state = /obj/structure/flora/bush/grassy::icon_state

/obj/structure/decoration/bush/grassy/first

/obj/structure/decoration/bush/grassy/second
	icon_state = /obj/structure/flora/bush/grassy/style_2::icon_state

/obj/structure/decoration/bush/grassy/third
	icon_state = /obj/structure/flora/bush/grassy/style_3::icon_state

/obj/structure/decoration/bush/grassy/fourth
	icon_state = /obj/structure/flora/bush/grassy/style_4::icon_state

/obj/structure/decoration/bush/grassy/style_random/Initialize(mapload)
	. = ..()
	icon_state = "grassybush_[rand(1, 4)]"
	update_appearance()

/obj/structure/decoration/bush/sparsegrass
	name = "塑料稀疏草"
	icon = /obj/structure/flora/bush/sparsegrass::icon
	icon_state = /obj/structure/flora/bush/sparsegrass::icon_state

/obj/structure/decoration/bush/sparsegrass/first

/obj/structure/decoration/bush/sparsegrass/second
	icon_state = /obj/structure/flora/bush/sparsegrass/style_2::icon_state

/obj/structure/decoration/bush/sparsegrass/third
	icon_state = /obj/structure/flora/bush/sparsegrass/style_3::icon_state

/obj/structure/decoration/bush/sparsegrass/style_random/Initialize(mapload)
	. = ..()
	icon_state = "sparsegrass_[rand(1, 3)]"
	update_appearance()

/obj/structure/decoration/bush/fullgrass
	name = "塑料茂密草"
	icon = /obj/structure/flora/bush/fullgrass::icon
	icon_state = /obj/structure/flora/bush/fullgrass::icon_state

/obj/structure/decoration/bush/fullgrass/first

/obj/structure/decoration/bush/fullgrass/second
	icon_state = /obj/structure/flora/bush/fullgrass/style_2::icon_state

/obj/structure/decoration/bush/fullgrass/third
	icon_state = /obj/structure/flora/bush/fullgrass/style_3::icon_state

/obj/structure/decoration/bush/fullgrass/style_random/Initialize(mapload)
	. = ..()
	icon_state = "fullgrass_[rand(1, 3)]"
	update_appearance()

/obj/structure/decoration/bush/ferny
	name = "塑料蕨类灌木"
	icon = /obj/structure/flora/bush/ferny::icon
	icon_state = /obj/structure/flora/bush/ferny::icon_state

/obj/structure/decoration/bush/ferny/first

/obj/structure/decoration/bush/ferny/second
	icon_state = /obj/structure/flora/bush/ferny/style_2::icon_state

/obj/structure/decoration/bush/ferny/third
	icon_state = /obj/structure/flora/bush/ferny/style_3::icon_state

/obj/structure/decoration/bush/ferny/style_random/Initialize(mapload)
	. = ..()
	icon_state = "fernybush_[rand(1, 3)]"
	update_appearance()

/obj/structure/decoration/bush/sunny
	name = "塑料向阳灌木"
	icon = /obj/structure/flora/bush/sunny::icon
	icon_state = /obj/structure/flora/bush/sunny::icon_state

/obj/structure/decoration/bush/sunny/first

/obj/structure/decoration/bush/sunny/second
	icon_state = /obj/structure/flora/bush/sunny/style_2::icon_state

/obj/structure/decoration/bush/sunny/third
	icon_state = /obj/structure/flora/bush/sunny/style_3::icon_state

/obj/structure/decoration/bush/sunny/style_random/Initialize(mapload)
	. = ..()
	icon_state = "sunnybush_[rand(1, 3)]"
	update_appearance()

/obj/structure/decoration/bush/generic
	name = "塑料普通灌木"
	icon = /obj/structure/flora/bush/generic::icon
	icon_state = /obj/structure/flora/bush/generic::icon_state

/obj/structure/decoration/bush/generic/first

/obj/structure/decoration/bush/generic/second
	icon_state = /obj/structure/flora/bush/generic/style_2::icon_state

/obj/structure/decoration/bush/generic/third
	icon_state = /obj/structure/flora/bush/generic/style_3::icon_state

/obj/structure/decoration/bush/generic/fourth
	icon_state = /obj/structure/flora/bush/generic/style_4::icon_state

/obj/structure/decoration/bush/generic/style_random/Initialize(mapload)
	. = ..()
	icon_state = "genericbush_[rand(1, 4)]"
	update_appearance()

/obj/structure/decoration/bush/pointy
	name = "塑料尖叶灌木"
	icon = /obj/structure/flora/bush/pointy::icon
	icon_state = /obj/structure/flora/bush/pointy::icon_state

/obj/structure/decoration/bush/pointy/first

/obj/structure/decoration/bush/pointy/second
	icon_state = /obj/structure/flora/bush/pointy/style_2::icon_state

/obj/structure/decoration/bush/pointy/third
	icon_state = /obj/structure/flora/bush/pointy/style_3::icon_state

/obj/structure/decoration/bush/pointy/fourth
	icon_state = /obj/structure/flora/bush/pointy/style_4::icon_state

/obj/structure/decoration/bush/pointy/style_random/Initialize(mapload)
	. = ..()
	icon_state = "pointybush_[rand(1, 4)]"
	update_appearance()

/obj/structure/decoration/bush/lavendergrass
	name = "塑料薰衣草"
	icon = /obj/structure/flora/bush/lavendergrass::icon
	icon_state = /obj/structure/flora/bush/lavendergrass::icon_state

/obj/structure/decoration/bush/lavendergrass/first

/obj/structure/decoration/bush/lavendergrass/second
	icon_state = /obj/structure/flora/bush/lavendergrass/style_2::icon_state

/obj/structure/decoration/bush/lavendergrass/third
	icon_state = /obj/structure/flora/bush/lavendergrass/style_3::icon_state

/obj/structure/decoration/bush/lavendergrass/fourth
	icon_state = /obj/structure/flora/bush/lavendergrass/style_4::icon_state

/obj/structure/decoration/bush/lavendergrass/style_random/Initialize(mapload)
	. = ..()
	icon_state = "lavendergrass_[rand(1, 4)]"
	update_appearance()

/obj/structure/decoration/bush/flowers_yw
	name = "塑料黄白花"
	icon = /obj/structure/flora/bush/flowers_yw::icon
	icon_state = /obj/structure/flora/bush/flowers_yw::icon_state

/obj/structure/decoration/bush/flowers_yw/first

/obj/structure/decoration/bush/flowers_yw/second
	icon_state = /obj/structure/flora/bush/flowers_yw/style_2::icon_state

/obj/structure/decoration/bush/flowers_yw/third
	icon_state = /obj/structure/flora/bush/flowers_yw/style_3::icon_state

/obj/structure/decoration/bush/flowers_yw/style_random/Initialize(mapload)
	. = ..()
	icon_state = "ywflowers_[rand(1, 3)]"
	update_appearance()

/obj/structure/decoration/bush/flowers_br
	name = "塑料蓝红花"
	icon = /obj/structure/flora/bush/flowers_br::icon
	icon_state = /obj/structure/flora/bush/flowers_br::icon_state

/obj/structure/decoration/bush/flowers_br/first

/obj/structure/decoration/bush/flowers_br/second
	icon_state = /obj/structure/flora/bush/flowers_br/style_2::icon_state

/obj/structure/decoration/bush/flowers_br/third
	icon_state = /obj/structure/flora/bush/flowers_br/style_3::icon_state

/obj/structure/decoration/bush/flowers_br/style_random/Initialize(mapload)
	. = ..()
	icon_state = "brflowers_[rand(1, 3)]"
	update_appearance()

/obj/structure/decoration/bush/flowers_pp
	name = "塑料紫花"
	icon = /obj/structure/flora/bush/flowers_pp::icon
	icon_state = /obj/structure/flora/bush/flowers_pp::icon_state

/obj/structure/decoration/bush/flowers_pp/first

/obj/structure/decoration/bush/flowers_pp/second
	icon_state = /obj/structure/flora/bush/flowers_pp/style_2::icon_state

/obj/structure/decoration/bush/flowers_pp/third
	icon_state = /obj/structure/flora/bush/flowers_pp/style_3::icon_state

/obj/structure/decoration/bush/flowers_pp/style_random/Initialize(mapload)
	. = ..()
	icon_state = "ppflowers_[rand(1, 3)]"
	update_appearance()

/obj/structure/decoration/bush/snow
	name = "塑料雪景灌木"
	desc = "覆着假雪的塑料灌木。全年都是冬日气氛。"
	icon = /obj/structure/flora/bush/snow::icon
	icon_state = /obj/structure/flora/bush/snow::icon_state

/obj/structure/decoration/bush/snow/first

/obj/structure/decoration/bush/snow/second
	icon_state = /obj/structure/flora/bush/snow/style_2::icon_state

/obj/structure/decoration/bush/snow/third
	icon_state = /obj/structure/flora/bush/snow/style_3::icon_state

/obj/structure/decoration/bush/snow/fourth
	icon_state = /obj/structure/flora/bush/snow/style_4::icon_state

/obj/structure/decoration/bush/snow/fifth
	icon_state = /obj/structure/flora/bush/snow/style_5::icon_state

/obj/structure/decoration/bush/snow/sixth
	icon_state = /obj/structure/flora/bush/snow/style_6::icon_state

/obj/structure/decoration/bush/snow/style_random/Initialize(mapload)
	. = ..()
	icon_state = "snowbush[rand(1, 6)]"
	update_appearance()

/obj/structure/decoration/bush/jungle
	name = "塑料丛林灌木"
	desc = "塑料丛林植物。外观全都有，过敏原一个没有。"
	icon = /obj/structure/flora/bush/jungle::icon
	icon_state = /obj/structure/flora/bush/jungle::icon_state

/obj/structure/decoration/bush/jungle/first

/obj/structure/decoration/bush/jungle/second
	icon_state = /obj/structure/flora/bush/jungle/a/style_2::icon_state

/obj/structure/decoration/bush/jungle/third
	icon_state = /obj/structure/flora/bush/jungle/a/style_3::icon_state

/obj/structure/decoration/bush/jungle/style_random/Initialize(mapload)
	. = ..()
	icon_state = "busha[rand(1, 3)]"
	update_appearance()

/obj/structure/decoration/bush/jungle/b
	icon = /obj/structure/flora/bush/jungle/b::icon
	icon_state = /obj/structure/flora/bush/jungle/b::icon_state

/obj/structure/decoration/bush/jungle/b/first

/obj/structure/decoration/bush/jungle/b/second
	icon_state = /obj/structure/flora/bush/jungle/b/style_2::icon_state

/obj/structure/decoration/bush/jungle/b/third
	icon_state = /obj/structure/flora/bush/jungle/b/style_3::icon_state

/obj/structure/decoration/bush/jungle/b/style_random/Initialize(mapload)
	. = ..()
	icon_state = "bushb[rand(1, 3)]"
	update_appearance()

/obj/structure/decoration/bush/jungle/c
	icon = /obj/structure/flora/bush/jungle/c::icon
	icon_state = /obj/structure/flora/bush/jungle/c::icon_state

/obj/structure/decoration/bush/jungle/c/first

/obj/structure/decoration/bush/jungle/c/second
	icon_state = /obj/structure/flora/bush/jungle/c/style_2::icon_state

/obj/structure/decoration/bush/jungle/c/third
	icon_state = /obj/structure/flora/bush/jungle/c/style_3::icon_state

/obj/structure/decoration/bush/jungle/c/style_random/Initialize(mapload)
	. = ..()
	icon_state = "bushc[rand(1, 3)]"
	update_appearance()

/obj/structure/decoration/bush/large
	name = "大型塑料灌木"
	desc = "一丛大型塑料灌木。以它那空洞的存在感占据整个房间。"
	icon = /obj/structure/flora/bush/large::icon
	icon_state = /obj/structure/flora/bush/large::icon_state
	pixel_x = /obj/structure/flora/bush/large::pixel_x
	pixel_y = /obj/structure/flora/bush/large::pixel_y
	layer = /obj/structure/flora/bush/large::layer
	plane = /obj/structure/flora/bush/large::plane
	density = /obj/structure/flora/bush/large::density

/obj/structure/decoration/bush/large/first

/obj/structure/decoration/bush/large/second
	icon_state = /obj/structure/flora/bush/large/style_2::icon_state

/obj/structure/decoration/bush/large/third
	icon_state = /obj/structure/flora/bush/large/style_3::icon_state

/obj/structure/decoration/bush/large/style_random/Initialize(mapload)
	. = ..()
	icon_state = "bush[rand(1, 3)]"
	update_appearance()

/obj/structure/decoration/rock
	name = "塑料岩石"
	desc = "一块中空塑料巨石。远看意外地像真的。"
	icon = /obj/structure/flora/rock::icon
	icon_state = /obj/structure/flora/rock::icon_state

/obj/structure/decoration/rock/first

/obj/structure/decoration/rock/second
	icon_state = /obj/structure/flora/rock/style_2::icon_state

/obj/structure/decoration/rock/third
	icon_state = /obj/structure/flora/rock/style_3::icon_state

/obj/structure/decoration/rock/fourth
	icon_state = /obj/structure/flora/rock/style_4::icon_state

/obj/structure/decoration/rock/style_random/Initialize(mapload)
	. = ..()
	icon_state = "basalt[rand(1, 4)]"
	update_appearance()

/obj/structure/decoration/rock/pile
	name = "塑料岩堆"
	desc = "一堆中空塑料岩石。轻得能一脚踢倒。"
	icon = /obj/structure/flora/rock/pile::icon
	icon_state = /obj/structure/flora/rock/pile::icon_state

/obj/structure/decoration/rock/pile/first

/obj/structure/decoration/rock/pile/second
	icon_state = /obj/structure/flora/rock/pile/style_2::icon_state

/obj/structure/decoration/rock/pile/third
	icon_state = /obj/structure/flora/rock/pile/style_3::icon_state

/obj/structure/decoration/rock/pile/style_random/Initialize(mapload)
	. = ..()
	icon_state = "lavarocks[pick(3;1,3;2,1;3)]"
	update_appearance()

/obj/structure/decoration/rock/pile/jungle
	name = "塑料丛林岩石"
	desc = "丛林主题的假岩石。没有任何真实地质历史。"
	icon = /obj/structure/flora/rock/pile/jungle::icon
	icon_state = /obj/structure/flora/rock/pile/jungle::icon_state

/obj/structure/decoration/rock/pile/jungle/first

/obj/structure/decoration/rock/pile/jungle/second
	icon_state = /obj/structure/flora/rock/pile/jungle/style_2::icon_state

/obj/structure/decoration/rock/pile/jungle/third
	icon_state = /obj/structure/flora/rock/pile/jungle/style_3::icon_state

/obj/structure/decoration/rock/pile/jungle/fourth
	icon_state = /obj/structure/flora/rock/pile/jungle/style_4::icon_state

/obj/structure/decoration/rock/pile/jungle/fifth
	icon_state = /obj/structure/flora/rock/pile/jungle/style_5::icon_state

/obj/structure/decoration/rock/pile/jungle/style_random/Initialize(mapload)
	. = ..()
	icon_state = "rock[rand(1, 5)]"
	update_appearance()

/obj/structure/decoration/rock/pile/jungle/large
	name = "塑料大块岩石"
	desc = "一堆巨大的假丛林岩石。意外地轻。"
	icon = /obj/structure/flora/rock/pile/jungle/large::icon
	icon_state = /obj/structure/flora/rock/pile/jungle/large::icon_state
	pixel_x = /obj/structure/flora/rock/pile/jungle/large::pixel_x
	pixel_y = /obj/structure/flora/rock/pile/jungle/large::pixel_y

/obj/structure/decoration/rock/pile/jungle/large/first

/obj/structure/decoration/rock/pile/jungle/large/second
	icon_state = /obj/structure/flora/rock/pile/jungle/large/style_2::icon_state

/obj/structure/decoration/rock/pile/jungle/large/third
	icon_state = /obj/structure/flora/rock/pile/jungle/large/style_3::icon_state

/obj/structure/decoration/rock/pile/jungle/large/style_random/Initialize(mapload)
	. = ..()
	icon_state = "rocks[rand(1, 3)]"
	update_appearance()

/obj/structure/decoration/rock/volcano
	name = "塑料火山口"
	desc = "一座精心上色的微型塑料火山。"
	icon = /obj/structure/flora/rock/volcano::icon
	icon_state = /obj/structure/flora/rock/volcano::icon_state

/obj/structure/decoration/rock/volcano/first

/obj/structure/decoration/rock/volcano/second
	icon_state = "volcano_2"

/obj/structure/decoration/rock/volcano/third
	icon_state = "volcano_3"

/obj/structure/decoration/rock/volcano/fourth
	icon_state = "volcano_4"

/obj/structure/decoration/rock/volcano/fifth
	icon_state = "volcano_5"

/obj/structure/decoration/rock/volcano/style_random/Initialize(mapload)
	. = ..()
	icon_state = "volcano_[rand(1, 5)]"
	update_appearance()

/obj/structure/decoration/misc/glowgrowth
	name = "塑料荧光菌群"
	desc = "大型塑料仿生物发光真菌群。不太会发光。"
	icon = /obj/structure/flora/ash/glowgrowth::icon
	icon_state = /obj/structure/flora/ash/glowgrowth::icon_state

/obj/structure/decoration/misc/glowgrowth/first

/obj/structure/decoration/misc/glowgrowth/second
	icon_state = "glowgrowth2"

/obj/structure/decoration/misc/glowgrowth/third
	icon_state = "glowgrowth3"

/obj/structure/decoration/misc/glowgrowth/style_random/Initialize(mapload)
	. = ..()
	icon_state = "glowgrowth[rand(1, 3)]"
	update_appearance()
