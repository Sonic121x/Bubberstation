/obj/item/stack/tile/mineral
	/// Determines what stack is gotten out of us when welded.
	var/mineralType = null

/obj/item/stack/tile/mineral/welder_act(mob/living/user, obj/item/tool)
	if(get_amount() < 4)
		to_chat(user, span_warning("你需要至少四块地板砖才能这样做！"))
		return ITEM_INTERACT_BLOCKING
	if(!mineralType)
		to_chat(user, span_warning("你无法重塑这个！"))
		stack_trace("A mineral tile of type [type] doesn't have its mineralType set.")
		return ITEM_INTERACT_BLOCKING
	if(!tool.use_tool(src, user, 0, volume=40))
		return ITEM_INTERACT_BLOCKING
	var/sheet_type = ispath(mineralType, /obj/item/stack) ? mineralType : text2path("/obj/item/stack/sheet/mineral/[mineralType]")
	var/obj/item/stack/new_item = new sheet_type(user.drop_location())
	user.visible_message(span_notice("[user]用[tool]把[src]塑造成了[new_item]。"), \
						span_notice("你用[tool]把[src]塑造成了[new_item]。"), \
						span_hear("你听到焊接声。"))
	var/holding = user.is_holding(src)
	use(4)
	if(holding && QDELETED(src))
		user.put_in_hands(new_item)
	return ITEM_INTERACT_SUCCESS

/obj/item/stack/tile/mineral/plasma
	name = "等离子地板砖"
	singular_name = "等离子地板砖"
	desc = "由极易燃的等离子体制成的地板砖。这肯定不会出什么好事。"
	icon_state = "tile_plasma"
	inhand_icon_state = "tile-plasma"
	turf_type = /turf/open/floor/mineral/plasma
	mineralType = "plasma"
	mats_per_unit = list(/datum/material/plasma=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/plasma
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/plasma,
		/obj/item/stack/tile/mineral/plasma/tiled,
	)

/obj/item/stack/tile/mineral/plasma/tiled
	icon_state = "tile_plasma_tiled"
	turf_type = /turf/open/floor/mineral/plasma/tiled
	merge_type = /obj/item/stack/tile/mineral/plasma/tiled

/obj/item/stack/tile/mineral/uranium
	name = "铀地板砖"
	singular_name = "铀地板砖"
	desc = "由铀制成的地板砖。你感觉有点头晕。"
	icon_state = "tile_uranium"
	inhand_icon_state = "tile-uranium"
	turf_type = /turf/open/floor/mineral/uranium
	mineralType = "uranium"
	mats_per_unit = list(/datum/material/uranium=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/uranium
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/uranium,
		/obj/item/stack/tile/mineral/uranium/tiled,
	)

/obj/item/stack/tile/mineral/uranium/tiled
	icon_state = "tile_uranium_tiled"
	turf_type = /turf/open/floor/mineral/uranium/tiled
	merge_type = /obj/item/stack/tile/mineral/uranium/tiled

/obj/item/stack/tile/mineral/gold
	name = "金地板砖"
	singular_name = "金地板砖"
	desc = "由黄金制成的地板砖，这里的富贵气息扑面而来。"
	icon_state = "tile_gold"
	inhand_icon_state = "tile-gold"
	turf_type = /turf/open/floor/mineral/gold
	mineralType = "gold"
	mats_per_unit = list(/datum/material/gold=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/gold
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/gold,
		/obj/item/stack/tile/mineral/gold/tiled,
		/obj/item/stack/tile/mineral/gold/sun,
	)

/obj/item/stack/tile/mineral/gold/tiled
	icon_state = "tile_gold_tiled"
	turf_type = /turf/open/floor/mineral/gold/tiled
	merge_type = /obj/item/stack/tile/mineral/gold/tiled

/obj/item/stack/tile/mineral/gold/sun
	icon_state = "tile_gold_sun"
	desc = "一块描绘太阳的黄金地板砖。"
	turf_type = /turf/open/floor/mineral/gold/sun
	merge_type = /obj/item/stack/tile/mineral/gold/sun

/obj/item/stack/tile/mineral/silver
	name = "银地板砖"
	singular_name = "银地板砖"
	desc = "由白银制成的地板砖，它反射的光芒刺得人睁不开眼。"
	icon_state = "tile_silver"
	inhand_icon_state = "tile-silver"
	turf_type = /turf/open/floor/mineral/silver
	mineralType = "silver"
	mats_per_unit = list(/datum/material/silver=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/silver
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/silver,
		/obj/item/stack/tile/mineral/silver/tiled,
		/obj/item/stack/tile/mineral/silver/moon,
	)

/obj/item/stack/tile/mineral/silver/tiled
	icon_state = "tile_silver_tiled"
	turf_type = /turf/open/floor/mineral/silver/tiled
	merge_type = /obj/item/stack/tile/mineral/silver/tiled

/obj/item/stack/tile/mineral/silver/moon
	icon_state = "tile_silver_moon"
	desc = "一块描绘月亮的白银地板砖。"
	turf_type = /turf/open/floor/mineral/silver/moon
	merge_type = /obj/item/stack/tile/mineral/silver/moon
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/mineral/diamond
	name = "钻石地板砖"
	singular_name = "钻石地板砖"
	desc = "由钻石制成的地板砖。哇，只能说，哇。"
	icon_state = "tile_diamond"
	inhand_icon_state = "tile-diamond"
	turf_type = /turf/open/floor/mineral/diamond
	mineralType = "diamond"
	mats_per_unit = list(/datum/material/diamond=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/diamond
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/diamond,
		/obj/item/stack/tile/mineral/diamond/tiled,
	)

/obj/item/stack/tile/mineral/diamond/tiled
	icon_state = "tile_diamond_tiled"
	turf_type = /turf/open/floor/mineral/diamond/tiled
	merge_type = /obj/item/stack/tile/mineral/diamond/tiled

/obj/item/stack/tile/mineral/bananium
	name = "香蕉矿地板砖"
	singular_name = "香蕉矿地板砖"
	desc = "一块由香蕉矿制成的防滑地板砖，HOOOOOOOOONK！"
	icon_state = "tile_bananium"
	inhand_icon_state = "tile-bananium"
	turf_type = /turf/open/floor/mineral/bananium
	mineralType = "bananium"
	mats_per_unit = list(/datum/material/bananium=SHEET_MATERIAL_AMOUNT*0.25)
	material_flags = NONE //The slippery comp makes it unpractical for good clown decor. The material tiles should still slip.
	merge_type = /obj/item/stack/tile/mineral/bananium
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/bananium,
		/obj/item/stack/tile/mineral/bananium/tiled,
	)

/obj/item/stack/tile/mineral/bananium/tiled
	icon_state = "tile_bananium_tiled"
	turf_type = /turf/open/floor/mineral/bananium/tiled
	merge_type = /obj/item/stack/tile/mineral/bananium/tiled

/obj/item/stack/tile/mineral/bluespace
	name = "蓝空间地板砖"
	singular_name = "蓝空间地板砖"
	desc = "由蓝空间水晶制成的地板砖。随机传送领域的最新创新。"
	icon_state = "tile_bluespacecrystal"
	inhand_icon_state = "tile-bluespacecrystal"
	turf_type = /turf/open/floor/mineral/bluespace
	mineralType = /obj/item/stack/sheet/bluespace_crystal
	mats_per_unit = list(/datum/material/bluespace=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/bluespace
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/bluespace,
		/obj/item/stack/tile/mineral/bluespace/tiled,
	)

/obj/item/stack/tile/mineral/bluespace/tiled
	icon_state = "tile_bluespacecrystal_tiled"
	turf_type = /turf/open/floor/mineral/bluespace/tiled
	merge_type = /obj/item/stack/tile/mineral/bluespace/tiled

/obj/item/stack/tile/mineral/telecrystal
	name = "传送水晶地板砖"
	singular_name = "传送水晶地板砖"
	desc = "由传送水晶制成的地板砖。几乎可以肯定这东西是违法的。"
	icon_state = "tile_telecrystal"
	inhand_icon_state = "tile-telecrystal"
	turf_type = /turf/open/floor/mineral/telecrystal
	mineralType = /obj/item/stack/telecrystal
	mats_per_unit = list(/datum/material/telecrystal=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/telecrystal
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/telecrystal,
		/obj/item/stack/tile/mineral/telecrystal/tiled,
	)

/obj/item/stack/tile/mineral/telecrystal/tiled
	icon_state = "tile_telecrystal_tiled"
	turf_type = /turf/open/floor/mineral/telecrystal/tiled
	merge_type = /obj/item/stack/tile/mineral/telecrystal/tiled

/obj/item/stack/tile/mineral/adamantine
	name = "精金地板砖"
	singular_name = "精金地板砖"
	desc = "由精金制成的地板砖。工业风格，魔像的最爱。"
	icon_state = "tile_adamantine"
	inhand_icon_state = "tile-adamantine"
	turf_type = /turf/open/floor/mineral/adamantine
	mineralType = "adamantine"
	mats_per_unit = list(/datum/material/adamantine=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/adamantine
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/adamantine,
		/obj/item/stack/tile/mineral/adamantine/tiled,
	)

/obj/item/stack/tile/mineral/adamantine/tiled
	icon_state = "tile_adamantine_tiled"
	turf_type = /turf/open/floor/mineral/adamantine/tiled
	merge_type = /obj/item/stack/tile/mineral/adamantine/tiled

/obj/item/stack/tile/mineral/metal_hydrogen
	name = "金属氢地板砖"
	singular_name = "金属氢地板砖"
	desc = "由金属氢制成的地板砖。踩上去就像漫步云端！"
	icon_state = "tile_metal_hydrogen"
	inhand_icon_state = "tile-metalhydrogen"
	turf_type = /turf/open/floor/mineral/metal_hydrogen
	mineralType = "metal_hydrogen"
	mats_per_unit = list(/datum/material/metalhydrogen=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/metal_hydrogen
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/metal_hydrogen,
		/obj/item/stack/tile/mineral/metal_hydrogen/tiled,
	)

/obj/item/stack/tile/mineral/metal_hydrogen/tiled
	icon_state = "tile_metal_hydrogen_tiled"
	turf_type = /turf/open/floor/mineral/metal_hydrogen/tiled
	merge_type = /obj/item/stack/tile/mineral/metal_hydrogen/tiled

/obj/item/stack/tile/mineral/runite
	name = "符文矿地板砖"
	singular_name = "符文矿地板砖"
	desc = "由符文矿制成、颇具魔力的地板砖。你感觉它的极性由魔法之风的方向决定。"
	icon_state = "tile_runite"
	inhand_icon_state = "tile-runite"
	turf_type = /turf/open/floor/mineral/runite
	mineralType = "runite"
	mats_per_unit = list(/datum/material/runite=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/runite
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/mineral/runite/tiled
	icon_state = "tile_runite_tiled"
	turf_type = /turf/open/floor/mineral/runite/tiled
	merge_type = /obj/item/stack/tile/mineral/runite/tiled

/obj/item/stack/tile/mineral/mythril
	name = "秘银地板砖"
	singular_name = "秘银地板砖"
	desc = "如此传奇而深不可测的材料，当然最适合拿来铺地。"
	icon_state = "tile_mythril"
	inhand_icon_state = "tile-mythril"
	turf_type = /turf/open/floor/mineral/mythril
	mineralType = "mythril"
	mats_per_unit = list(/datum/material/mythril=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/mythril

/obj/item/stack/tile/mineral/mythril/tiled
	icon_state = "tile_mythril_tiled"
	turf_type = /turf/open/floor/mineral/mythril/tiled
	merge_type = /obj/item/stack/tile/mineral/mythril/tiled

/obj/item/stack/tile/mineral/sandstone
	name = "砂岩砖地板"
	desc = "由砂岩制成的地板砖。"
	icon_state = "sandstone_floor"
	inhand_icon_state = "tile-sandstone"
	mineralType = "sandstone"
	mats_per_unit = list(/datum/material/sandstone = HALF_SHEET_MATERIAL_AMOUNT / 2)
	turf_type = /turf/open/floor/sandstone
	merge_type = /obj/item/stack/tile/mineral/sandstone

/obj/item/stack/tile/mineral/stone
	name = "石砖地板"
	desc = "由石头制成的地板砖。"
	icon_state = "stone_floor"
	inhand_icon_state = "tile-stone"
	mineralType = null
	mats_per_unit = list(/datum/material/rock = HALF_SHEET_MATERIAL_AMOUNT / 2)
	turf_type = /turf/open/floor/stone
	merge_type = /obj/item/stack/tile/mineral/stone

/obj/item/stack/tile/mineral/abductor
	name = "异形合金地板砖"
	singular_name = "异形合金地板砖"
	desc = "由异形合金制成的地板砖。"
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "tile_abductor"
	inhand_icon_state = "tile-abductor"
	mats_per_unit = list(/datum/material/alloy/alien=SHEET_MATERIAL_AMOUNT*0.25)
	turf_type = /turf/open/floor/mineral/abductor
	mineralType = "abductor"
	merge_type = /obj/item/stack/tile/mineral/abductor

/obj/item/stack/tile/mineral/titanium
	name = "钛地板砖"
	singular_name = "钛地板砖"
	desc = "光滑的钛地板砖，用于穿梭机。"
	icon_state = "tile_titanium"
	inhand_icon_state = "tile-shuttle"
	turf_type = /turf/open/floor/mineral/titanium
	mineralType = "titanium"
	mats_per_unit = list(/datum/material/titanium=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/titanium
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/titanium,
		/obj/item/stack/tile/mineral/titanium/yellow,
		/obj/item/stack/tile/mineral/titanium/blue,
		/obj/item/stack/tile/mineral/titanium/white,
		/obj/item/stack/tile/mineral/titanium/purple,
		/obj/item/stack/tile/mineral/titanium/tiled,
		/obj/item/stack/tile/mineral/titanium/tiled/yellow,
		/obj/item/stack/tile/mineral/titanium/tiled/blue,
		/obj/item/stack/tile/mineral/titanium/tiled/white,
		/obj/item/stack/tile/mineral/titanium/tiled/purple,
		)

/obj/item/stack/tile/mineral/titanium/yellow
	name = "黄色钛地板砖"
	singular_name = "黄色钛地板砖"
	desc = "光滑的黄色钛地板砖，用于穿梭机。"
	turf_type = /turf/open/floor/mineral/titanium/yellow
	icon_state = "tile_titanium_yellow"
	merge_type = /obj/item/stack/tile/mineral/titanium/yellow

/obj/item/stack/tile/mineral/titanium/blue
	name = "蓝色钛地板砖"
	singular_name = "蓝色钛地板砖"
	desc = "光滑的蓝色钛地板砖，用于穿梭机。"
	turf_type = /turf/open/floor/mineral/titanium/blue
	icon_state = "tile_titanium_blue"
	merge_type = /obj/item/stack/tile/mineral/titanium/blue

/obj/item/stack/tile/mineral/titanium/white
	name = "白色钛地板砖"
	singular_name = "白色钛地板砖"
	desc = "光滑的白色钛地板砖，用于穿梭机。"
	turf_type = /turf/open/floor/mineral/titanium/white
	icon_state = "tile_titanium_white"
	merge_type = /obj/item/stack/tile/mineral/titanium/white

/obj/item/stack/tile/mineral/titanium/purple
	name = "紫色钛地板砖"
	singular_name = "紫色钛地板砖"
	desc = "光滑的紫色钛地板砖，用于穿梭机。"
	turf_type = /turf/open/floor/mineral/titanium/purple
	icon_state = "tile_titanium_purple"
	merge_type = /obj/item/stack/tile/mineral/titanium/purple

/obj/item/stack/tile/mineral/titanium/tiled
	name = "纹格钛地板砖"
	singular_name = "纹格钛地板砖"
	desc = "钛地板砖，用于穿梭机。"
	turf_type = /turf/open/floor/mineral/titanium/tiled
	icon_state = "tile_titanium_tiled"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled

/obj/item/stack/tile/mineral/titanium/tiled/yellow
	name = "黄色纹格钛地板砖"
	singular_name = "黄色纹格钛地板砖"
	desc = "黄色纹格钛地板砖，用于穿梭机。"
	turf_type = /turf/open/floor/mineral/titanium/tiled/yellow
	icon_state = "tile_titanium_tiled_yellow"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/yellow

/obj/item/stack/tile/mineral/titanium/tiled/blue
	name = "蓝色纹格钛地板砖"
	singular_name = "蓝色纹格钛地板砖"
	desc = "蓝色纹格钛地板砖，用于穿梭机。"
	turf_type = /turf/open/floor/mineral/titanium/tiled/blue
	icon_state = "tile_titanium_tiled_blue"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/blue

/obj/item/stack/tile/mineral/titanium/tiled/white
	name = "白色纹格钛地板砖"
	singular_name = "白色纹格钛地板砖"
	desc = "白色纹格钛地板砖，用于穿梭机。"
	turf_type = /turf/open/floor/mineral/titanium/tiled/white
	icon_state = "tile_titanium_tiled_white"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/white

/obj/item/stack/tile/mineral/titanium/tiled/purple
	name = "紫色纹格钛地板砖"
	singular_name = "紫色纹格钛地板砖"
	desc = "紫色纹格钛地板砖，用于穿梭机。"
	turf_type = /turf/open/floor/mineral/titanium/tiled/purple
	icon_state = "tile_titanium_tiled_purple"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/purple

/obj/item/stack/tile/mineral/plastitanium
	name = "塑钛地板砖"
	singular_name = "塑钛地板砖"
	desc = "由塑钛制成的地板砖，用于非常邪恶的穿梭机。"
	icon_state = "tile_plastitanium"
	inhand_icon_state = "tile-darkshuttle"
	turf_type = /turf/open/floor/mineral/plastitanium
	mineralType = "plastitanium"
	mats_per_unit = list(/datum/material/alloy/plastitanium=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/plastitanium
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/plastitanium,
		/obj/item/stack/tile/mineral/plastitanium/red,
		/obj/item/stack/tile/mineral/plastitanium/pod,
		/obj/item/stack/tile/mineral/plastitanium/pod/light,
		/obj/item/stack/tile/mineral/plastitanium/pod/dark,
		/obj/item/stack/tile/mineral/plastitanium/pod/red,
		/obj/item/stack/tile/mineral/plastitanium/pod/redlight,
		//BUBBER EDIT ADDITION BEGIN
		/obj/item/stack/tile/mineral/plastitanium/pod/light/edge,
		/obj/item/stack/tile/mineral/plastitanium/pod/light/half,
		/obj/item/stack/tile/mineral/plastitanium/pod/light/corner,
		/obj/item/stack/tile/mineral/plastitanium/pod/light/large,
		/obj/item/stack/tile/mineral/plastitanium/pod/dark/edge,
		/obj/item/stack/tile/mineral/plastitanium/pod/dark/half,
		/obj/item/stack/tile/mineral/plastitanium/pod/dark/corner,
		/obj/item/stack/tile/mineral/plastitanium/pod/dark/large,
		/obj/item/stack/tile/mineral/plastitanium/pod/red/edge,
		/obj/item/stack/tile/mineral/plastitanium/pod/red/half,
		/obj/item/stack/tile/mineral/plastitanium/pod/red/corner,
		/obj/item/stack/tile/mineral/plastitanium/pod/red/large,
		/obj/item/stack/tile/mineral/plastitanium/pod/redlight/edge,
		/obj/item/stack/tile/mineral/plastitanium/pod/redlight/half,
		/obj/item/stack/tile/mineral/plastitanium/pod/redlight/corner,
		/obj/item/stack/tile/mineral/plastitanium/pod/redlight/large,
		)

/obj/item/stack/tile/mineral/plastitanium/red
	name = "红色塑钛地板砖"
	singular_name = "红色塑钛地板砖"
	desc = "由塑钛制成的地板砖，用于非常红色的穿梭机。"
	turf_type = /turf/open/floor/mineral/plastitanium/red
	icon_state = "tile_plastitanium_red"
	merge_type = /obj/item/stack/tile/mineral/plastitanium/red

/obj/item/stack/tile/mineral/plastitanium/pod
	name = "舱体地板砖"
	singular_name = "舱体地板砖"
	desc = "一块带凹槽的地板砖。"
	icon_state = "tile_pod"
	inhand_icon_state = "tile-pod"
	turf_type = /turf/open/floor/mineral/plastitanium/pod
	merge_type = /obj/item/stack/tile/mineral/plastitanium/pod

/obj/item/stack/tile/mineral/plastitanium/pod/light
	name = "浅色舱体地板砖"
	singular_name = "浅色舱体地板砖"
	desc = "一块浅色的带凹槽地板砖。"
	icon_state = "tile_podlight"
	turf_type = /turf/open/floor/mineral/plastitanium/pod/light
	merge_type = /obj/item/stack/tile/mineral/plastitanium/pod/light

/obj/item/stack/tile/mineral/plastitanium/pod/dark
	name = "深色舱体地板砖"
	singular_name = "深色舱体地板砖"
	desc = "一块深色的带凹槽地板砖。"
	icon_state = "tile_poddark"
	turf_type = /turf/open/floor/mineral/plastitanium/pod/dark
	merge_type = /obj/item/stack/tile/mineral/plastitanium/pod/dark

/obj/item/stack/tile/mineral/plastitanium/pod/red
	name = "红色舱体地板砖"
	singular_name = "深色舱体地板砖"
	desc = "一块红色的带凹槽地板砖。"
	icon_state = "tile_pod_red"
	turf_type = /turf/open/floor/mineral/plastitanium/pod/red
	merge_type = /obj/item/stack/tile/mineral/plastitanium/pod/red

/obj/item/stack/tile/mineral/plastitanium/pod/redlight
	name = "浅红色舱体地板砖"
	singular_name = "浅红色舱体地板砖"
	desc = "一块浅红色的带凹槽地板砖。"
	icon_state = "tile_podlight_red"
	turf_type = /turf/open/floor/mineral/plastitanium/pod/redlight
	merge_type = /obj/item/stack/tile/mineral/plastitanium/pod/redlight

/obj/item/stack/tile/mineral/snow
	name = "雪地板砖"
	singular_name = "雪地板砖"
	desc = "一层雪。"
	icon_state = "tile_snow"
	inhand_icon_state = "tile-silver"
	turf_type = /turf/open/floor/fake_snow
	mineralType = "snow"
	merge_type = /obj/item/stack/tile/mineral/snow
	mats_per_unit = list(/datum/material/snow = HALF_SHEET_MATERIAL_AMOUNT / 2)
