/obj/effect/decal/cleanable/generic
	name = "杂物"
	desc = "该有人清理一下了。"
	icon = 'icons/obj/debris.dmi'
	icon_state = "shards"
	beauty = -50

/obj/effect/decal/cleanable/ash
	name = "灰烬"
	desc = "尘归尘，土归土，最终归于太空。"
	icon = 'icons/obj/debris.dmi'
	icon_state = "ash"
	plane = GAME_PLANE
	layer = CLEANABLE_OBJECT_LAYER
	mergeable_decal = FALSE
	beauty = -50
	decal_reagent = /datum/reagent/ash
	reagent_amount = 30

/obj/effect/decal/cleanable/ash/Initialize(mapload)
	. = ..()
	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)

/obj/effect/decal/cleanable/ash/NeverShouldHaveComeHere(turf/here_turf)
	return !istype(here_turf, /obj/structure/bodycontainer/crematorium) && ..()

/obj/effect/decal/cleanable/ash/large
	name = "一大堆灰烬"
	icon_state = "big_ash"
	beauty = -100
	decal_reagent = /datum/reagent/ash
	reagent_amount = 60

/obj/effect/decal/cleanable/glass
	name = "细小碎片"
	desc = "重归沙尘。"
	icon = 'icons/obj/debris.dmi'
	icon_state = "tiny"
	beauty = -100

/obj/effect/decal/cleanable/glass/Initialize(mapload)
	. = ..()
	if(. == INITIALIZE_HINT_QDEL)
		return
	setDir(pick(GLOB.cardinals))

/obj/effect/decal/cleanable/glass/ex_act()
	qdel(src)
	return TRUE

/obj/effect/decal/cleanable/glass/plasma
	icon_state = "plasmatiny"

/obj/effect/decal/cleanable/glass/titanium
	icon_state = "titaniumtiny"

/obj/effect/decal/cleanable/glass/plastitanium
	icon_state = "plastitaniumtiny"

//Screws that are dropped on the Z level below when deconstructing a reinforced floor plate.
/obj/effect/decal/cleanable/glass/plastitanium/screws //I don't know how to sprite scattered screws, this can work until a spriter gets their hands on it.
	name = "一堆螺丝"
	desc = "看起来是从天花板上掉下来的。"

/obj/effect/decal/cleanable/dirt
	name = "污垢"
	desc = "该有人清理一下了。"
	icon = 'icons/effects/dirt_misc.dmi'
	icon_state = "dirt-flat-0"
	base_icon_state = "dirt"
	smoothing_flags = NONE
	smoothing_groups = SMOOTH_GROUP_CLEANABLE_DIRT
	canSmoothWith = SMOOTH_GROUP_CLEANABLE_DIRT + SMOOTH_GROUP_WALLS
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	beauty = -75
	/// Set to FALSE if your dirt has no smoothing sprites
	var/is_tileable = TRUE

/obj/effect/decal/cleanable/dirt/Initialize(mapload)
	. = ..()
	if(. == INITIALIZE_HINT_QDEL)
		return
	icon_state = pick("dirt-flat-0","dirt-flat-1","dirt-flat-2","dirt-flat-3")
	var/obj/structure/broken_flooring/broken_flooring = locate(/obj/structure/broken_flooring) in loc
	if(!isnull(broken_flooring))
		return
	var/turf/T = get_turf(src)
	if(T.tiled_turf && is_tileable)
		icon = 'icons/effects/dirt.dmi'
		icon_state = "dirt-0"
		smoothing_flags = SMOOTH_BITMASK
		QUEUE_SMOOTH(src)
	if(smoothing_flags & USES_SMOOTHING)
		QUEUE_SMOOTH_NEIGHBORS(src)

/obj/effect/decal/cleanable/dirt/Destroy()
	if(smoothing_flags & USES_SMOOTHING)
		QUEUE_SMOOTH_NEIGHBORS(src)
	return ..()

/obj/effect/decal/cleanable/dirt/dust
	name = "灰尘"
	desc = "覆盖地板的薄薄一层灰尘。"
	icon_state = "dust"
	base_icon_state = "dust"
	is_tileable = FALSE

/obj/effect/decal/cleanable/dirt/dust/Initialize(mapload)
	. = ..()
	icon_state = base_icon_state

/obj/effect/decal/cleanable/greenglow
	name = "发光黏液"
	desc = "天啊，希望这不是午饭。"
	icon_state = "greenglow"
	light_power = 3
	light_range = 2
	light_color = LIGHT_COLOR_GREEN
	beauty = -300

/obj/effect/decal/cleanable/greenglow/ex_act()
	return FALSE

/obj/effect/decal/cleanable/greenglow/filled
	decal_reagent = /datum/reagent/uranium
	reagent_amount = 5

/obj/effect/decal/cleanable/greenglow/filled/Initialize(mapload)
	decal_reagent = pick(/datum/reagent/uranium, /datum/reagent/uranium/radium)
	. = ..()

/obj/effect/decal/cleanable/greenglow/ecto
	name = "灵质液滩"
	desc = "你知道该找谁来处理。"
	light_power = 2

/obj/effect/decal/cleanable/greenglow/radioactive
	name = "放射性黏液"
	desc = "见鬼，别盯着看了，赶快离远点！这东西有辐射！"
	light_power = 5
	light_range = 3
	light_color = LIGHT_COLOR_NUCLEAR

/obj/effect/decal/cleanable/greenglow/radioactive/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	if(. == INITIALIZE_HINT_QDEL)
		return
	AddComponent(
		/datum/component/radioactive_emitter, \
		cooldown_time = 5 SECONDS, \
		range = 4, \
		threshold = RAD_MEDIUM_INSULATION, \
	)

/obj/effect/decal/cleanable/cobweb
	name = "蛛网"
	desc = "该有人把它清理掉了。"
	gender = NEUTER
	plane = GAME_PLANE
	layer = WALL_OBJ_LAYER
	icon = 'icons/effects/web.dmi'
	icon_state = "cobweb1"
	resistance_flags = FLAMMABLE
	beauty = -100
	clean_type = CLEAN_TYPE_HARD_DECAL
	is_mopped = FALSE

/obj/effect/decal/cleanable/cobweb/cobweb2
	icon_state = "cobweb2"

/obj/effect/decal/cleanable/molten_object
	name = "灰色黏团"
	desc = "看起来像融化的……什么东西。"
	gender = NEUTER
	icon = 'icons/effects/effects.dmi'
	icon_state = "molten"
	plane = GAME_PLANE
	layer = CLEANABLE_OBJECT_LAYER
	mergeable_decal = FALSE
	beauty = -150
	clean_type = CLEAN_TYPE_HARD_DECAL

/obj/effect/decal/cleanable/molten_object/large
	name = "大团灰色黏团"
	icon_state = "big_molten"
	beauty = -300

//Vomit (sorry)
/obj/effect/decal/cleanable/vomit
	name = "呕吐物"
	desc = "天啊，真恶心。"
	icon = 'icons/effects/blood.dmi'
	icon_state = "vomit_1"
	random_icon_states = list("vomit_1", "vomit_2", "vomit_3", "vomit_4")
	beauty = -150

/obj/effect/decal/cleanable/vomit/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(. || !HAS_TRAIT(user, TRAIT_VOMIT_SLURPER))
		return
	playsound(get_turf(src), 'sound/items/drink.ogg', 50, TRUE) //slurp
	user.visible_message(span_alert("[user]将细小的喙伸进呕吐物中，咕噜咕噜地吸食起来。"))
	lazy_init_reagents()?.trans_to(user, reagents.total_volume, transferred_by = user, methods = INGEST)
	qdel(src)

/obj/effect/decal/cleanable/vomit/toxic // this has a more toned-down color palette, which may be why it's used as the default in so many spots
	icon_state = "vomittox_1"
	random_icon_states = list("vomittox_1", "vomittox_2", "vomittox_3", "vomittox_4")

/obj/effect/decal/cleanable/vomit/purple // ourple
	icon_state = "vomitpurp_1"
	random_icon_states = list("vomitpurp_1", "vomitpurp_2", "vomitpurp_3", "vomitpurp_4")

/obj/effect/decal/cleanable/vomit/nanites
	name = "纳米机器人滋生的呕吐物"
	desc = "天啊，能看见里面有什么东西在动。"
	icon_state = "vomitnanite_1"
	random_icon_states = list("vomitnanite_1", "vomitnanite_2", "vomitnanite_3", "vomitnanite_4")

/// Tracked for voidwalkers to jump to and from
GLOBAL_LIST_EMPTY(nebula_vomits)

/obj/effect/decal/cleanable/vomit/nebula
	name = "星云呕吐物"
	desc = "天啊，真……漂亮。"
	icon_state = "vomitnebula_1"
	random_icon_states = list("vomitnebula_1", "vomitnebula_2", "vomitnebula_3", "vomitnebula_4")
	beauty = 10

/obj/effect/decal/cleanable/vomit/nebula/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	if(. == INITIALIZE_HINT_QDEL)
		return
	update_appearance(UPDATE_OVERLAYS)
	GLOB.nebula_vomits += src

/obj/effect/decal/cleanable/vomit/nebula/update_overlays()
	. = ..()
	. += emissive_appearance(icon, icon_state, src, alpha = src.alpha)

/obj/effect/decal/cleanable/vomit/nebula/Destroy()
	. = ..()

	GLOB.nebula_vomits -= src

/// Nebula vomit with extra guests
/obj/effect/decal/cleanable/vomit/nebula/worms

/obj/effect/decal/cleanable/vomit/nebula/worms/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	if(. == INITIALIZE_HINT_QDEL)
		return
	for (var/i in 1 to rand(2, 3))
		new /mob/living/basic/hivelord_brood(loc)

/obj/effect/decal/cleanable/vomit/old
	name = "结痂的干呕吐物"
	desc = "你试着不去看那些块状物，却还是忍不住看了。"

/obj/effect/decal/cleanable/vomit/old/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	if(. == INITIALIZE_HINT_QDEL)
		return
	icon_state += "-old"
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_SLUDGE, CELL_VIRUS_TABLE_GENERIC, rand(2,4), 10)

/obj/effect/decal/cleanable/vomit/old/black_bile
	name = "黑胆汁"
	desc = "里面有什么东西在扭动……"
	color = COLOR_DARK

/obj/effect/decal/cleanable/chem_pile
	name = "化学物质堆"
	desc = "一堆化学物质。你不太能辨认出里面是什么。"
	gender = NEUTER
	plane = GAME_PLANE
	layer = CLEANABLE_OBJECT_LAYER
	icon = 'icons/obj/debris.dmi'
	icon_state = "ash"

/obj/effect/decal/cleanable/shreds
	name = "碎布"
	desc = "看起来是衣物被撕碎后的残片。"
	icon_state = "shreds"
	gender = PLURAL
	mergeable_decal = FALSE

/obj/effect/decal/cleanable/shreds/ex_act(severity, target)
	if(severity >= EXPLODE_DEVASTATE) //so shreds created during an explosion aren't deleted by the explosion.
		qdel(src)
		return TRUE

	return FALSE

/obj/effect/decal/cleanable/shreds/Initialize(mapload, oldname)
	pixel_x = rand(-10, 10)
	pixel_y = rand(-10, 10)
	if(!isnull(oldname))
		desc = "[oldname]留下的凄惨残片。"
	. = ..()

/obj/effect/decal/cleanable/glitter
	name = "普通闪粉堆"
	desc = "手工艺界挥之不去的疱疹。"
	icon = 'icons/effects/glitter.dmi'
	icon_state = "glitter"
	gender = NEUTER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/decal/cleanable/glitter/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	if(. == INITIALIZE_HINT_QDEL)
		return
	add_overlay(mutable_appearance('icons/effects/glitter.dmi', "glitter_sparkle[rand(1,9)]", appearance_flags = EMISSIVE_APPEARANCE_FLAGS))

/obj/effect/decal/cleanable/plasma
	name = "稳定等离子体"
	desc = "一滩稳定等离子体。"
	icon_state = "flour"
	icon = 'icons/effects/tomatodecal.dmi'
	color = "#2D2D2D"

/obj/effect/decal/cleanable/insectguts
	name = "昆虫内脏"
	desc = "踩死一只虫子，还会有四只顶上来。"
	icon = 'icons/effects/blood.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7")
	color = BLOOD_COLOR_XENO

/obj/effect/decal/cleanable/confetti
	name = "彩纸屑"
	desc = "四处撒落的小彩纸，给清洁工找点乐子！"
	icon = 'icons/effects/confetti_and_decor.dmi'
	icon_state = "confetti"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT //the confetti itself might be annoying enough

/obj/effect/decal/cleanable/plastic
	name = "塑料碎片"
	desc = "撕裂、破碎、一文不值的塑料碎片。"
	icon = 'icons/obj/debris.dmi'
	icon_state = "shards"
	color = "#c6f4ff"

/obj/effect/decal/cleanable/wrapping
	name = "包装碎片"
	desc = "拆开包裹后留下的纸板和纸张碎片。"
	icon = 'icons/obj/debris.dmi'
	icon_state = "paper_shreds"
	plane = GAME_PLANE
	layer = CLEANABLE_OBJECT_LAYER

/obj/effect/decal/cleanable/wrapping/pinata
	name = "皮纳塔碎片"
	desc = "皮纳塔留下的纸糊碎片。"
	icon_state = "pinata_shreds"

/obj/effect/decal/cleanable/wrapping/pinata/syndie
	icon_state = "syndie_pinata_shreds"

/obj/effect/decal/cleanable/wrapping/pinata/donk
	icon_state = "donk_pinata_shreds"

/obj/effect/decal/cleanable/garbage
	name = "腐烂垃圾"
	desc = "一个破开的垃圾袋，臭烘烘的垃圾似乎已经部分液化了。呕！"
	icon = 'icons/obj/debris.dmi'
	icon_state = "garbage"
	plane = GAME_PLANE
	layer = CLEANABLE_OBJECT_LAYER
	beauty = -150
	clean_type = CLEAN_TYPE_HARD_DECAL

/obj/effect/decal/cleanable/garbage/Initialize(mapload)
	. = ..()
	if(. == INITIALIZE_HINT_QDEL)
		return
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_SLUDGE, CELL_VIRUS_TABLE_GENERIC, rand(2,4), 15)

/obj/effect/decal/cleanable/rubble
	name = "碎石"
	desc = "一堆碎石。"
	icon = 'icons/obj/debris.dmi'
	icon_state = "rubble"
	mergeable_decal = FALSE
	beauty = -10
	plane = GAME_PLANE
	layer = GIB_LAYER
	clean_type = CLEAN_TYPE_HARD_DECAL
	is_mopped = FALSE

/obj/effect/decal/cleanable/rubble/Initialize(mapload)
	. = ..()
	if(. == INITIALIZE_HINT_QDEL)
		return
	flick("rubble_bounce", src)
	icon_state = "rubble"
	update_appearance(UPDATE_ICON_STATE)

/obj/effect/decal/cleanable/can_bits
	name = "破碎罐头"
	desc = "这下彻底兜不住了。"

/obj/effect/decal/cleanable/concrete_dust
	name = "混凝土粉尘"
	desc = "破坏混凝土结构时产生的细粉末。"
	icon = 'icons/obj/debris.dmi'
	icon_state = "concrete_dust"
	beauty = -20
