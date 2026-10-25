//Fish sources that're usually found in ruins or on mining z-levels should go here

/datum/fish_source/cursed_spring
	catalog_description = null //it's a secret (sorta, I know you're reading this)
	radial_state = "cursed"
	fish_table = list(
		FISHING_DUD = 2,
		/obj/item/fish/soul = 3,
		/obj/item/fish/skin_crab = 3,
		/obj/item/fishing_rod/telescopic/master = 1,
	)
	fish_counts = list(
		/obj/item/fishing_rod/telescopic/master = 1,
	)
	fishing_difficulty = FISHING_DEFAULT_DIFFICULTY + 35
	fish_source_flags = FISH_SOURCE_FLAG_EXPLOSIVE_MALUS
	associated_safe_turfs = list(/turf/open/water/hot_spring)

/datum/fish_source/chasm
	catalog_description = "裂隙深处"
	background = "background_chasm"
	radial_state = "ground_hole"
	overlay_state = "portal_chasm"
	fish_table = list(
		FISHING_DUD = 5,
		/obj/item/fish/chasm_crab = 15,
		/datum/chasm_detritus = 30,
	)
	fishing_difficulty = FISHING_DEFAULT_DIFFICULTY + 15
	fish_source_flags = FISH_SOURCE_FLAG_EXPLOSIVE_NONE

/datum/fish_source/chasm/on_start_fishing(obj/item/fishing_rod/rod, mob/fisherman, atom/parent)
	. = ..()
	if(istype(rod.hook, /obj/item/fishing_hook/rescue))
		to_chat(fisherman, span_notice("救援钩笔直地落入裂隙深处！但愿它能钩到一具尸体。"))
		return
	to_chat(fisherman, span_danger("你的鱼钩发出一声轻柔的“咚”，卡在了裂隙的岩壁上。看起来它钓不到什么像样的东西，也许只能钓上些碎屑。"))

/datum/fish_source/chasm/roll_reward(obj/item/fishing_rod/rod, mob/fisherman)
	var/rolled_reward = ..()

	if(!rod.hook || !ispath(rolled_reward, /datum/chasm_detritus))
		return rolled_reward

	return rod.hook.chasm_detritus_type

/datum/fish_source/lavaland
	catalog_description = "熔岩喷口"
	background = "background_lavaland"
	radial_state = "lava"
	overlay_state = "portal_lava"
	fish_table = list(
		FISHING_DUD = 5,
		/obj/item/stack/ore/slag = 15,
		/obj/item/fish/lavaloop = 15,
		/obj/item/stack/sheet/animalhide/goliath_hide = 15,
		/obj/item/stack/sheet/bone = 15,
		/obj/item/stack/sheet/sinew = 15,
		/obj/structure/closet/crate/necropolis/tendril = 1,
		/obj/item/skeleton_key = 1,
		/obj/item/stack/sheet/mineral/runite = 1,
		/obj/effect/mob_spawn/corpse/human/charredskeleton = 1,
		/mob/living/basic/mining/legion= 1,
		/mob/living/basic/mining/brimdemon= 1,

	)
	fish_counts = list(
		/obj/structure/closet/crate/necropolis/tendril = 1,
		/obj/item/skeleton_key = 1,
		/obj/item/stack/sheet/mineral/runite = 2,
	)
	fish_count_regen = list(
		/obj/structure/closet/crate/necropolis/tendril = 27 MINUTES,
		/obj/item/skeleton_key = 13 MINUTES,
		/obj/item/stack/sheet/mineral/runite = 15 MINUTES,
	)
	fishing_difficulty = FISHING_DEFAULT_DIFFICULTY + 20
	fish_source_flags = FISH_SOURCE_FLAG_EXPLOSIVE_MALUS
	associated_safe_turfs = list(/turf/open/lava)
	safe_turfs_blacklist = list(/turf/open/lava/plasma)

/datum/fish_source/lavaland/reason_we_cant_fish(obj/item/fishing_rod/rod, mob/fisherman, atom/parent)
	. = ..()
	if(!HAS_TRAIT(rod, TRAIT_ROD_LAVA_USABLE))
		return "在那里钓鱼需要强化鱼线。"

/datum/fish_source/lavaland/icemoon
	background = "background_plasma"
	catalog_description = "液态等离子体喷口"
	radial_state = "plasma"
	fish_table = list(
		FISHING_DUD = 5,
		/obj/item/fish/chasm_crab/ice = 30,
		/obj/item/fish/lavaloop/plasma_river = 30,
		/obj/item/coin/plasma = 6,
		/obj/item/stack/ore/plasma = 6,
		/obj/effect/decal/remains/plasma = 2,
		/obj/item/stack/sheet/mineral/runite = 2,
		/obj/item/stack/sheet/mineral/adamantine = 2,
		/obj/item/skeleton_key = 1,
		/obj/structure/closet/crate/necropolis/tendril = 1,
		/mob/living/basic/mining/lobstrosity = 1,
		/mob/living/basic/mining/lobstrosity/juvenile = 1,
	)
	fish_counts = list(
		/obj/item/stack/sheet/mineral/adamantine = 3,
		/obj/item/stack/sheet/mineral/runite = 2,
		/obj/item/skeleton_key = 1,
		/obj/structure/closet/crate/necropolis/tendril = 1,
	)
	fish_count_regen = list(
		/obj/item/stack/sheet/mineral/adamantine = 8 MINUTES,
		/obj/item/stack/sheet/mineral/runite = 10 MINUTES,
		/obj/item/skeleton_key = 15 MINUTES,
		/obj/structure/closet/crate/necropolis/tendril = 30 MINUTES,
	)
	overlay_state = "portal_plasma"
	associated_safe_turfs = list(/turf/open/lava/plasma)

/datum/fish_source/oil_well
	background = "background_oil_well"
	catalog_description = "油井"
	radial_state = "oil"
	overlay_state = "portal_chasm" //close enough to pitch black
	fish_table = list(
		FISHING_DUD = 5,
		/obj/item/fish/boned = 10,
		/obj/item/stack/sheet/bone = 2,
		/obj/item/clothing/gloves/bracer = 2,
		/obj/effect/decal/remains/human = 2,
		/obj/item/fish/mastodon = 1,
		/obj/item/fishing_rod/telescopic/master = 1,
	)
	fish_counts = list(
		/obj/item/clothing/gloves/bracer = 1,
		/obj/effect/decal/remains/human = 1,
		/obj/item/fish/mastodon = 1,
		/obj/item/fishing_rod/telescopic/master = 1,
	)
	fish_count_regen = list(
		/obj/item/fish/mastodon = 8 MINUTES,
	)
	fishing_difficulty = FISHING_DEFAULT_DIFFICULTY + 25
