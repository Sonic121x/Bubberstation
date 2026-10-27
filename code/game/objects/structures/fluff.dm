/**
 * # Fluff structure
 *
 * Fluff structures serve no purpose and exist only for enriching the environment. By default, they can be deconstructed with a wrench.
 */
/obj/structure/fluff
	name = "装饰结构"
	desc = "比绵羊还蓬松。这东西不应该存在。"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "minibar"
	anchored = TRUE
	density = FALSE
	opacity = FALSE
	///If true, the structure can be deconstructed into a metal sheet with a wrench.
	var/deconstructible = TRUE

/obj/structure/fluff/wrench_act(mob/living/user, obj/item/tool)
	if(!deconstructible)
		return ITEM_INTERACT_SKIP_TO_ATTACK
	user.visible_message(span_notice("[user] 开始拆解[src]……"), \
						span_notice("你开始拆解[src]……"))
	tool.play_tool_sound(src)
	if(!tool.use_tool(src, user, 50))
		return ITEM_INTERACT_BLOCKING
	user.visible_message(span_notice("[user] 拆解了[src]！"), span_notice("你把[src]拆成了废金属。"))
	playsound(user, 'sound/items/deconstruct.ogg', 50, TRUE)
	new/obj/item/stack/sheet/iron(drop_location())
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/**
 * Empty terrariums are created when a preserved terrarium in a lavaland seed vault is activated.
 */
/obj/structure/fluff/empty_terrarium
	name = "空生态箱"
	desc = "一台古老的机器，似乎用于储存植物材料。它的舱盖半开着。"
	icon = 'icons/obj/mining_zones/spawners.dmi'
	icon_state = "terrarium_open"
	density = TRUE

/**
 * Empty sleepers are created by a good few ghost roles in lavaland.
 */
/obj/structure/fluff/empty_sleeper
	name = "空休眠舱"
	desc = "一台敞开的休眠舱。要不是坏了，它看起来还会等待下一位病人。"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper-open"

/obj/structure/fluff/empty_sleeper/nanotrasen
	name = "损坏的超睡眠舱"
	desc = "一台纳米传讯超睡眠舱——这一台似乎是坏的。\
		外露的螺栓让它可以用扳手轻松拆解。"
	icon_state = "sleeper-o"

/obj/structure/fluff/empty_sleeper/syndicate
	icon_state = "sleeper_s-open"

/**
 * Empty cryostasis sleepers are created when a malfunctioning cryostasis sleeper in a lavaland shelter is activated.
 */
/obj/structure/fluff/empty_cryostasis_sleeper
	name = "空低温休眠舱"
	desc = "虽然很舒适，但这台休眠舱以后只能当床用了。"
	icon = 'icons/obj/mining_zones/spawners.dmi'
	icon_state = "cryostasis_sleeper_open"

/**
 * Ash drake status spawn on either side of the necropolis gate in lavaland.
 */
/obj/structure/fluff/drake_statue
	name = "龙雕像"
	desc = "一座高耸的玄武岩雕塑，刻画着一头骄傲威严的龙。它的眼睛是六颗发光的宝石。"
	icon = 'icons/effects/64x64.dmi'
	icon_state = "drake_statue"
	pixel_x = -16
	maptext_height = 64
	maptext_width = 64
	density = TRUE
	deconstructible = FALSE
	layer = EDGED_TURF_LAYER

/**
 * shower drain placed usually under showers just so it looks like something picks the water up.
 */
/obj/structure/fluff/shower_drain
	name = "淋浴排水口"
	desc = "呃，我好像看到一团头发。"
	icon = 'icons/obj/mining_zones/survival_pod.dmi'
	icon_state = "fan_tiny"
	plane = FLOOR_PLANE
	layer = BELOW_CATWALK_LAYER

/**
 * A variety of statue in disrepair; parts are broken off and a gemstone is missing
 */
/obj/structure/fluff/drake_statue/falling
	desc = "一座高耸的玄武岩龙雕像。表面布满裂缝，部分已经脱落。"
	icon_state = "drake_statue_falling"


/obj/structure/fluff/bus
	name = "公交车"
	desc = "去上学。读本书。"
	icon = 'icons/obj/fluff/bus.dmi'
	icon_state = null
	density = TRUE
	anchored = TRUE
	deconstructible = FALSE

/obj/structure/fluff/bus/dense
	name = "公交车"
	icon_state = "backwall"

/obj/structure/fluff/bus/passable
	name = "公交车"
	icon_state = "frontwalltop"
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER //except for the stairs tile, which should be set to OBJ_LAYER aka 3.
	plane = ABOVE_GAME_PLANE


/obj/structure/fluff/bus/passable/seat
	name = "座位"
	desc = "系好安全带！……你说什么，没有安全带？！"
	icon_state = "backseat"
	pixel_y = 17
	layer = OBJ_LAYER
	plane = GAME_PLANE


/obj/structure/fluff/bus/passable/seat/driver
	name = "驾驶座"
	desc = "太空耶稣是我的副驾驶。"
	icon_state = "driverseat"

/obj/structure/fluff/bus/passable/seat/driver/attack_hand(mob/user, list/modifiers)
	playsound(src, 'sound/items/carhorn.ogg', 50, TRUE)
	. = ..()

/obj/structure/fluff/paper
	name = "密集的纸张内衬"
	desc = "铺在墙底的一片纸张。"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "paper"
	deconstructible = FALSE

/obj/structure/fluff/paper/corner
	icon_state = "papercorner"

/obj/structure/fluff/paper/stack
	name = "厚厚一叠纸"
	desc = "一叠各式各样的纸张，每一页都布满幼稚的涂鸦。"
	icon_state = "paperstack"


/obj/structure/fluff/divine
	name = "神迹"
	icon = 'icons/obj/service/hand_of_god_structures.dmi'
	icon_state = "error"
	anchored = TRUE
	density = TRUE

/obj/structure/fluff/divine/nexus
	name = "枢纽"
	desc = "它将一位神明锚定在此世。它散发着奇异的光环，看起来能很好地抵御爆炸冲击。"
	icon_state = "nexus"

/obj/structure/fluff/divine/conduit
	name = "导管"
	desc = "它让神明得以延伸其影响范围。在导管附近，神明的力量与在枢纽附近一样强大。"
	icon_state = "conduit"

/obj/structure/fluff/divine/convertaltar
	name = "皈依祭坛"
	desc = "一座献给神明的祭坛。"
	icon_state = "convertaltar"
	density = FALSE
	can_buckle = 1

/obj/structure/fluff/divine/powerpylon
	name = "能量塔"
	desc = "一座能提高神明影响世界速率的塔。"
	icon_state = "powerpylon"
	can_buckle = 1

/obj/structure/fluff/divine/defensepylon
	name = "防御塔"
	desc = "一座受祝福的塔，能承受许多打击，并向不信者发射强力光束。神明可以开关它。"
	icon_state = "defensepylon"

/obj/structure/fluff/divine/shrine
	name = "神龛"
	desc = "一座献给神明的神龛。"
	icon_state = "shrine"

/obj/structure/fluff/fokoff_sign
	name = "粗糙的标牌"
	desc = "一块制作粗糙的标牌，上面用某种红色颜料歪歪扭扭地写着“滚蛋”。"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "fokof"

/obj/structure/fluff/big_chain
	name = "巨型锁链"
	desc = "一段高耸的锁链，一直延伸至天花板。"
	icon = 'icons/effects/32x96.dmi'
	icon_state = "chain"
	anchored = TRUE
	density = TRUE
	deconstructible = FALSE
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE

/obj/structure/fluff/beach_towel
	name = "沙滩巾"
	desc = "一条印有各种沙滩主题图案的毛巾。"
	icon = 'icons/obj/railings.dmi'
	icon_state = "railing"
	density = FALSE
	anchored = TRUE
	deconstructible = FALSE

/obj/structure/fluff/beach_umbrella
	name = "沙滩伞"
	desc = "一把精致的遮阳伞，为沙滩游客挡住阳光。"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "brella"
	density = FALSE
	anchored = TRUE
	deconstructible = FALSE

/obj/structure/fluff/beach_umbrella/security
	icon_state = "hos_brella"

/obj/structure/fluff/beach_umbrella/science
	icon_state = "rd_brella"

/obj/structure/fluff/beach_umbrella/engine
	icon_state = "ce_brella"

/obj/structure/fluff/beach_umbrella/cap
	icon_state = "cap_brella"

/obj/structure/fluff/beach_umbrella/syndi
	icon_state = "syndi_brella"

/obj/structure/fluff/clockwork
	name = "发条装饰"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "error"
	deconstructible = FALSE

/obj/structure/fluff/clockwork/alloy_shards
	name = "复制合金碎片"
	desc = "某种异常可塑金属的碎裂碎片。它们偶尔会移动，并似乎在发光。"
	icon_state = "alloy_shards"

/obj/structure/fluff/clockwork/alloy_shards/small
	icon_state = "shard_small1"

/obj/structure/fluff/clockwork/alloy_shards/medium
	icon_state = "shard_medium1"

/obj/structure/fluff/clockwork/alloy_shards/medium_gearbit
	icon_state = "gear_bit1"

/obj/structure/fluff/clockwork/alloy_shards/large
	icon_state = "shard_large1"

/obj/structure/fluff/clockwork/blind_eye
	name = "盲眼"
	desc = "一只沉重的黄铜眼睛，其红色虹膜已经黯淡。"
	icon_state = "blind_eye"

/obj/structure/fluff/clockwork/fallen_armor
	name = "坠落的装甲"
	desc = "毫无生气的装甲残块。它们的设计方式很奇怪，你穿不上。"
	icon_state = "fallen_armor"

/obj/structure/fluff/clockwork/clockgolem_remains
	name = "发条魔像废料"
	desc = "一堆废金属。看起来已经损坏得无法修复了。"
	icon_state = "clockgolem_dead"

/obj/structure/fluff/tram_rail
	name = "电车轨道"
	desc = "对电车来说很棒，对滑行来说就不太妙了。"
	icon = 'icons/obj/tram/tram_rails.dmi'
	icon_state = "rail"
	layer = TRAM_RAIL_LAYER
	plane = FLOOR_PLANE
	resistance_flags =  INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	deconstructible = FALSE
	can_buckle = TRUE
	buckle_requires_restraints = TRUE
	buckle_lying = 90

/obj/structure/fluff/tram_rail/post_buckle_mob(mob/living/target)
	. = ..()
	target.pixel_y += dir == SOUTH ? -3 : 14
	RegisterSignal(target, COMSIG_LIVING_HIT_BY_TRAM, PROC_REF(on_buckled_tram_smashed))

/obj/structure/fluff/tram_rail/post_unbuckle_mob(mob/living/target)
	. = ..()
	target.pixel_y -= dir == SOUTH ? -3 : 14
	UnregisterSignal(target, COMSIG_LIVING_HIT_BY_TRAM)

/// If someone gets hit by the tram while buckled to us (mission accomplished) unbuckle them so that they can fly away
/// Also we rip one of their arms off to "uncuff" them
/obj/structure/fluff/tram_rail/proc/on_buckled_tram_smashed(mob/living/smashed)
	SIGNAL_HANDLER
	unbuckle_mob(smashed, force = TRUE, can_fall = FALSE) // Make sure they don't fall down a z-level until they've been thrown

/obj/structure/fluff/tram_rail/floor
	name = "电车轨道防护罩"
	icon_state = "rail_floor"

/obj/structure/fluff/tram_rail/end
	icon_state = "railend"

/obj/structure/fluff/tram_rail/anchor
	name = "电车轨道锚"
	icon_state = "anchor"

/obj/structure/fluff/tram_rail/electric
	desc = "对电车来说很棒，对滑行来说就不太妙了。这一根是供电轨。"
	/// What power channel from the APC do we check for power?
	var/power_channel = AREA_USAGE_ENVIRON

/obj/structure/fluff/tram_rail/electric/anchor
	name = "电车轨道锚"
	icon_state = "anchor"

/obj/structure/fluff/tram_rail/electric/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/electrified_buckle,\
		input_requirements = SHOCK_REQUIREMENT_AREA_POWER,\
		shock_immediately = TRUE,\
		print_message = FALSE,\
		damage_on_shock = 5,\
		loop_length = 8 SECONDS,\
		area_power_channel = power_channel,\
		shock_flags = SHOCK_NOSTUN\
	)

/obj/structure/fluff/tram_rail/electric/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	var/area/our_area = get_area(src)
	if(our_area?.powered(power_channel) && user.electrocute_act(75, src))
		do_sparks(5, TRUE, src)

/obj/structure/fluff/broken_canister_frame
	name = "破损的储气罐框架"
	desc = "一个被拆开的储气罐。看起来可以用扳手回收一些金属。"
	icon_state = "broken_canister"
	anchored = FALSE
	density = TRUE
	deconstructible = TRUE

/obj/structure/fluff/wallsign
	name = "方向指示牌"
	desc = "那么，该往哪走呢？"
	density = FALSE
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "wallsign"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/wallsign, 32)
