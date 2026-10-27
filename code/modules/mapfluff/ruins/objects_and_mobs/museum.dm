/obj/machinery/computer/terminal/museum
	name = "展品信息终端"
	desc = "一块技术含量相当低的信息板。不过还没低到一块真正展牌的程度。看起来相当古老。"
	upperinfo = "纳米传讯博物馆展品信息"
	icon_state = MAP_SWITCH("plaque", "/obj/machinery/computer/terminal/museum")
	icon_screen = "plaque_screen"
	icon_keyboard = null

/obj/effect/replica_spawner //description and name are intact, better to make a new fluff object for stuff that is not actually ingame as an object
	name = "复制品生成器"
	desc = "这会生成一个外观与输入目标完全一致的填充物件，但显然只是个复制品。看在上帝的份上，千万别用在那类带有 Initialize 副作用的东西上。"
	icon = 'icons/hud/screen_gen.dmi'
	icon_state = "x2"
	invisibility = INVISIBILITY_ABSTRACT //nope, can't see this
	anchored = TRUE
	density = TRUE
	opacity = FALSE
	var/replica_path = /obj/structure/fluff
	var/target_path
	var/obvious_replica = TRUE

/obj/effect/replica_spawner/Initialize(mapload)
	. = ..()
	if(isnull(target_path))
		return INITIALIZE_HINT_QDEL //no use to make a replica of null
	var/atom/appearance_object = new target_path
	var/atom/new_replica = new replica_path(loc)

	new_replica.icon = appearance_object.icon
	new_replica.icon_state = appearance_object.icon_state
	new_replica.copy_overlays(appearance_object.appearance, cut_old = TRUE)
	new_replica.density = appearance_object.density //for like nondense showers and stuff

	new_replica.name = "[appearance_object.name][obvious_replica ? "（复制品）" : ""]"
	new_replica.desc = "[appearance_object.desc][obvious_replica ? "……只不过这一件是复制品。" : ""]"

	new_replica.pixel_y = pixel_y
	new_replica.pixel_x = pixel_x

	qdel(appearance_object)
	qdel(src)
	return INITIALIZE_HINT_QDEL

/obj/structure/fluff/dnamod
	name = "DNA 改造器"
	desc = "DNA 操纵器的复制品。本质上只是一个装着几盏酷炫灯光的盒子。"
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "dnamod"
	density = TRUE

/obj/structure/fluff/preserved_borer
	name = "皮层钻虫标本展品"
	desc = "一件皮层钻虫标本。它在这儿待的时间大概已经久到，一旦离开展柜就撑不了多久。"
	icon = 'icons/obj/structures.dmi'
	icon_state = "preservedborer"
	density = TRUE

/obj/structure/fluff/balloon_nuke
	name = "核弹气球"
	desc = "你大概不该留下来看看它到底有没有充好气。"
	icon = /obj/machinery/nuclearbomb::icon
	icon_state = /obj/machinery/nuclearbomb::icon_state
	density = TRUE
	max_integrity = 5 //one tap

/obj/structure/fluff/balloon_nuke/atom_destruction()
	playsound(loc, 'sound/effects/cartoon_sfx/cartoon_pop.ogg', 75, vary = TRUE)
	..()

/obj/structure/fluff/fake_camera
	name = /obj/machinery/camera::name
	desc = /obj/machinery/camera::desc
	icon = /obj/machinery/camera::icon
	icon_state = /obj/machinery/camera::icon_state

/obj/structure/fluff/fake_scrubber
	name = /obj/machinery/atmospherics/components/unary/vent_scrubber::name
	desc = /obj/machinery/atmospherics/components/unary/vent_scrubber::desc
	icon = /obj/machinery/atmospherics/components/unary/vent_scrubber::icon
	layer = ABOVE_OPEN_TURF_LAYER
	plane = FLOOR_PLANE
	icon_state = "scrub_on"

/obj/structure/fluff/fake_vent
	name = /obj/machinery/atmospherics/components/unary/vent_pump::name
	desc = /obj/machinery/atmospherics/components/unary/vent_pump::desc
	icon = /obj/machinery/atmospherics/components/unary/vent_pump::icon
	layer = ABOVE_OPEN_TURF_LAYER
	plane = FLOOR_PLANE
	icon_state = "vent_out"

/turf/open/mirage
	icon = 'icons/turf/floors.dmi'
	icon_state = "mirage"
	invisibility = INVISIBILITY_ABSTRACT
	/// target turf x and y are offsets from our location instead of a direct coordinate
	var/offset = TRUE
	/// tile range that we show, 2 means that the target tile and two tiles ahead of it in our direction will show
	var/range
	var/target_turf_x = 0
	var/target_turf_y = 0
	/// if not specified, uses our Z
	var/target_turf_z

/turf/open/mirage/Initialize(mapload)
	. = ..()
	if(isnull(range))
		range = (maxviewdist() - 1) / 2
	var/used_z = target_turf_z || z //if target z is not defined, use ours
	var/turf/target = locate(offset ? target_turf_x + x : target_turf_x, offset ? target_turf_y + y : target_turf_y, used_z)
	AddElement(/datum/element/mirage_border, target, dir, range)

/obj/effect/mapping_helpers/ztrait_injector/museum
	traits_to_add = list(ZTRAIT_NOPARALLAX = TRUE, ZTRAIT_NOXRAY = TRUE, ZTRAIT_NOPHASE = TRUE, ZTRAIT_BASETURF = /turf/open/indestructible/plating, ZTRAIT_SECRET = TRUE)

/obj/effect/smooths_with_walls
	name = "与墙壁平滑过渡的效果"
	desc = "用于补充 /turf/open/mirage。"
	icon = 'icons/hud/screen_gen.dmi'
	icon_state = "x2"
	invisibility = INVISIBILITY_ABSTRACT
	anchored = TRUE
	density = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS

/obj/item/paper/fluff/museum/noend
	name = "涂乱的便条"
	default_raw_text = {"这地方，
	<br>天啊，到底是谁出的主意，要在虚空之中、天知道什么地方的正中央建一座博物馆，我们根本没有理由干这种事
	<br>还有那些人偶，它们为什么老是盯着人回看，你们他妈从哪儿弄来的这些玩意儿
	<br>我们甚至要怎么让游客找到这儿来
	<br>有时候我能抓到它们在动
	<br>
	<br>我们当初就不该来这儿"}

/obj/item/paper/fluff/museum/chefs_ultimatum
	name = "旧便条"
	default_raw_text = {"我把它搞砸了，砸得一塌糊涂。
	<br>我把按钮弄坏了，现在我被困住了。
	<br>总之，钥匙不在我身上。我把它冲进马桶了。
	<br>鬼知道它现在在哪儿，这地方的东西好像全都连在一起。"}

/obj/item/paper/fluff/museum/numbers_on_walls
	name = "斥责便条"
	default_raw_text = "请不要再把密码写到到处都是。我知道你的记性跟金鱼差不多，但是，呃，写在纸上不就行了吗？"

/obj/effect/mob_spawn/corpse/human/skeleton/museum_chef
	name = "博物馆食堂死亡厨师"
	mob_name = "无名厨师"
	outfit = /datum/outfit/museum_chef

/datum/outfit/museum_chef
	name = "Dead Museum Cafeteria Chef"
	uniform = /obj/item/clothing/under/color/green
	suit = /obj/item/clothing/suit/toggle/chef
	head = /obj/item/clothing/head/utility/chefhat
	shoes = /obj/item/clothing/shoes/laceup
	mask = /obj/item/clothing/mask/fakemoustache/italian

/obj/machinery/vending/hotdog/museum
	all_products_free = TRUE

/obj/machinery/vending/hotdog/museum/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/tool_blocker, TOOL_SCREWDRIVER, TOOL_ACT_PRIMARY)
	AddElement(/datum/element/tool_blocker, TOOL_CROWBAR, TOOL_ACT_PRIMARY)

#define CAFE_KEYCARD_TOILETS "museum_cafe_key_toilets"

///Do not place these beyond the cafeteria shutters, or you might lock people out of reaching it.
/obj/structure/toilet/museum

/obj/structure/toilet/museum/Initialize(mapload)
	. = ..()
	if(mapload)
		SSqueuelinks.add_to_queue(src, CAFE_KEYCARD_TOILETS)

/obj/item/keycard/cafeteria
	name = "博物馆食堂钥匙卡"
	color = COLOR_OLIVE
	puzzle_id = "museum_cafeteria"
	desc = "顾名思义，就是食堂的钥匙。"

/obj/item/keycard/cafeteria/Initialize(mapload)
	. = ..()
	if(mapload)
		SSqueuelinks.add_to_queue(src, CAFE_KEYCARD_TOILETS)
		return INITIALIZE_HINT_LATELOAD

/obj/item/keycard/cafeteria/LateInitialize()
	if(SSqueuelinks.queues[CAFE_KEYCARD_TOILETS])
		SSqueuelinks.pop_link(CAFE_KEYCARD_TOILETS)

/obj/item/keycard/cafeteria/MatchedLinks(id, partners)
	if(id != CAFE_KEYCARD_TOILETS)
		return ..()
	var/obj/structure/toilet/destination = pick(partners)
	forceMove(destination)
	destination.w_items += w_class
	LAZYADD(destination.cistern_items, src)

#undef CAFE_KEYCARD_TOILETS
