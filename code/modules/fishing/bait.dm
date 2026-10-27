/obj/item/bait_can
	name = "鱼饵罐"
	desc = "里面装了很多，不过要把它们取出来还得花点时间。"
	icon = 'icons/obj/fishing.dmi'
	icon_state = "bait_can"
	base_icon_state =  "bait_can"
	w_class = WEIGHT_CLASS_SMALL
	/// Tracking until we can take out another bait item
	COOLDOWN_DECLARE(bait_removal_cooldown)
	/// What bait item it produces
	var/obj/item/bait_type = /obj/item/food/bait
	/// Time between bait retrievals
	var/cooldown_time = 5 SECONDS
	/// How many uses does it have left.
	var/uses_left = 20

/obj/item/bait_can/attack_self(mob/user, modifiers)
	. = ..()
	var/fresh_bait = retrieve_bait(user)
	if(fresh_bait)
		user.put_in_hands(fresh_bait)

/obj/item/bait_can/examine(mob/user)
	. = ..()
	. += span_info("它[uses_left ? "还剩下 [uses_left] 个 [bait_type::name]" : "已经空了"]。")

/obj/item/bait_can/update_icon_state()
	. = ..()
	icon_state = base_icon_state
	if(uses_left <= initial(uses_left))
		if(!uses_left)
			icon_state = "[icon_state]_empty"
		else
			icon_state = "[icon_state]_open"

/obj/item/bait_can/proc/retrieve_bait(mob/user)
	if(!uses_left)
		user.balloon_alert(user, "空了")
		return
	if(!COOLDOWN_FINISHED(src, bait_removal_cooldown))
		user.balloon_alert(user, "稍等一下")
		return
	COOLDOWN_START(src, bait_removal_cooldown, cooldown_time)
	update_appearance()
	uses_left--
	return new bait_type(src)

/obj/item/bait_can/worm
	name = "蚯蚓罐"
	desc = "这罐子里有蚯蚓。"
	bait_type = /obj/item/food/bait/worm

/obj/item/bait_can/worm/premium
	name = "豪华蚯蚓罐"
	desc = "这罐子里有上等蚯蚓。"
	bait_type = /obj/item/food/bait/worm/premium

/obj/item/bait_can/super_baits
	name = "超级鱼饵罐"
	desc = "这罐子里装着神之甘露。"
	bait_type = /obj/item/food/bait/doughball/synthetic/super
	uses_left = 12

/obj/item/fishing_lure
	name = "钓鱼拟饵"
	desc = "就是它，一件塑料钓具，可鱼儿却倾尽全身每一个分子都想咬上一口。"
	icon = 'icons/obj/fishing.dmi'
	icon_state = "minnow"
	w_class = WEIGHT_CLASS_SMALL
	/**
	 * A list with two keys delimiting the spinning interval in which a mouse click has to be pressed while fishing.
	 * This is passed down to the fishing rod, and then to the lure during the minigame.
	 */
	var/spin_frequency = list(2 SECONDS, 3 SECONDS)

/obj/item/fishing_lure/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_FISHING_BAIT, TRAIT_BAIT_ALLOW_FISHING_DUD, TRAIT_OMNI_BAIT, TRAIT_BAIT_UNCONSUMABLE), INNATE_TRAIT)
	RegisterSignal(src, COMSIG_ITEM_FISHING_ROD_SLOTTED, PROC_REF(on_fishing_rod_slotted))
	RegisterSignal(src, COMSIG_ITEM_FISHING_ROD_UNSLOTTED, PROC_REF(on_fishing_rod_unslotted))

/obj/item/fishing_lure/proc/on_fishing_rod_slotted(datum/source, obj/item/fishing_rod/rod, slot)
	SIGNAL_HANDLER
	rod.spin_frequency = spin_frequency

/obj/item/fishing_lure/proc/on_fishing_rod_unslotted(datum/source, obj/item/fishing_rod/rod, slot)
	SIGNAL_HANDLER
	rod.spin_frequency = null

///Called for every fish subtype by the fishing subsystem when initializing, to populate the list of fish that can be catched with this lure.
/obj/item/fishing_lure/proc/is_catchable_fish(obj/item/fish/fish, list/fish_properties)
	return TRUE

/obj/item/fishing_lure/examine(mob/user)
	. = ..()
	. += span_info("钓鱼时，需要以 [spin_frequency[1] * 0.1] 至 [spin_frequency[2] * 0.1] 秒的频率旋转收线。")
	if(HAS_MIND_TRAIT(user, TRAIT_EXAMINE_FISHING_SPOT))
		. += span_tinynotice("凭借你的经验，你可以再次检查它以获得可用它钓到的鱼类列表。")

/obj/item/fishing_lure/examine_more(mob/user)
	. = ..()
	if(!HAS_MIND_TRAIT(user, TRAIT_EXAMINE_FISHING_SPOT))
		return

	var/list/known_fishes = list()
	for(var/obj/item/fish/fish_type as anything in SSfishing.lure_catchables[type])
		if(initial(fish_type.fish_flags) & FISH_FLAG_SHOW_IN_CATALOG)
			known_fishes += initial(fish_type.name)

	if(!length(known_fishes))
		return

	. += span_info("用此拟饵可以钓到以下鱼类：[english_list(known_fishes)]。")

///Check if the fish is in the list of catchable fish for this fishing lure. Return value is a multiplier.
/obj/item/fishing_lure/check_bait(obj/item/fish/fish)
	var/multiplier = 0
	var/is_instance = istype(fish)
	var/list/fish_properties = SSfishing.fish_properties[is_instance ? fish.type : fish]
	if(is_type_in_list(/obj/item/fishing_lure, fish_properties[FISH_PROPERTIES_FAV_BAIT]))
		multiplier += 2
	if(is_instance)
		if(is_catchable_fish(fish, fish_properties))
			multiplier += 10
	else if(fish in SSfishing.lure_catchables[type])
		multiplier += 10
	return multiplier

/obj/item/fishing_lure/minnow
	name = "人造米诺鱼拟饵"
	desc = "一种可能吸引小鱼的拟饵。太小、太大或太挑剔的猎物不会对它感兴趣。"
	icon_state = "minnow"

/obj/item/fishing_lure/minnow/is_catchable_fish(obj/item/fish/fish, list/fish_properties)
	var/intermediate_size = FISH_SIZE_SMALL_MAX + (FISH_SIZE_NORMAL_MAX - FISH_SIZE_SMALL_MAX)
	if(!ISINRANGE(fish.size, FISH_SIZE_TINY_MAX * 0.5, intermediate_size))
		return FALSE
	if(length(list(/datum/fish_trait/vegan, /datum/fish_trait/picky_eater, /datum/fish_trait/nocturnal, /datum/fish_trait/heavy) & fish.fish_traits))
		return FALSE
	return TRUE

/obj/item/fishing_lure/plug
	name = "人造塞形拟饵"
	desc = "一种较大的拟饵，可能吸引较大的鱼。微小的或挑剔的猎物仍不会感兴趣。"
	icon_state = "plug"

/obj/item/fishing_lure/plug/is_catchable_fish(obj/item/fish/fish, list/fish_properties)
	if(fish.size <= FISH_SIZE_SMALL_MAX)
		return FALSE
	if(length(list(/datum/fish_trait/vegan, /datum/fish_trait/picky_eater, /datum/fish_trait/nocturnal, /datum/fish_trait/heavy) & fish.fish_traits))
		return FALSE
	return TRUE

/obj/item/fishing_lure/dropping
	name = "塑料垃圾拟饵"
	desc = "一种能钓到各种黏滑、猥琐、恶心和/或热爱垃圾的鱼的拟饵。"
	icon_state = "dropping"
	spin_frequency = list(1.5 SECONDS, 2.8 SECONDS)

/obj/item/fishing_lure/dropping/is_catchable_fish(obj/item/fish/fish, list/fish_properties)
	var/list/sources = list(/datum/fish_source/toilet, /datum/fish_source/moisture_trap)
	for(var/datum/fish_source/source as anything in sources)
		var/datum/fish_source/instance = GLOB.preset_fish_sources[/datum/fish_source/toilet]
		if(fish.type in instance.fish_table)
			return TRUE
	var/list/fav_baits = fish_properties[FISH_PROPERTIES_FAV_BAIT]
	for(var/list/identifier in fav_baits)
		if(identifier[FISH_BAIT_TYPE] == FISH_BAIT_FOODTYPE && (identifier[FISH_BAIT_VALUE] & (JUNKFOOD|GROSS|TOXIC)))
			return TRUE
	if(fish.beauty <= FISH_BEAUTY_DISGUSTING)
		return TRUE
	return FALSE

/obj/item/fishing_lure/spoon
	name = "\improper 印地勺形拟饵"
	desc = "一片仿鱼鳞的闪亮金属。它擅长钓取生活在淡水中的中小型鱼类。"
	icon_state = "spoon"
	spin_frequency = list(1.25 SECONDS, 2.25 SECONDS)

/obj/item/fishing_lure/spoon/is_catchable_fish(obj/item/fish/fish, list/fish_properties)
	if(!ISINRANGE(fish.size, FISH_SIZE_TINY_MAX + 1, FISH_SIZE_NORMAL_MAX))
		return FALSE
	if(length(list(/datum/fish_trait/vegan, /datum/fish_trait/picky_eater, /datum/fish_trait/nocturnal, /datum/fish_trait/heavy) & fish.fish_traits))
		return FALSE
	var/fluid_type = fish.required_fluid_type
	if(fluid_type == AQUARIUM_FLUID_FRESHWATER || fluid_type == AQUARIUM_FLUID_ANADROMOUS || fluid_type == AQUARIUM_FLUID_ANY_WATER)
		return TRUE
	if((/datum/fish_trait/amphibious in fish.fish_traits) && fluid_type == AQUARIUM_FLUID_AIR)
		return TRUE
	return FALSE

/obj/item/fishing_lure/artificial_fly
	name = "\improper 丝嗡人造蝇拟饵"
	desc = "一种外形类似大个毛绒苍蝇的拟饵。与大多数其他拟饵不同，它足够精致，能引起挑剔鱼类的兴趣，但也仅限于它们。"
	icon_state = "artificial_fly"
	spin_frequency = list(1.1 SECONDS, 2 SECONDS)

/obj/item/fishing_lure/artificial_fly/is_catchable_fish(obj/item/fish/fish, list/fish_properties)
	if(/datum/fish_trait/picky_eater in fish.fish_traits)
		return TRUE
	return FALSE

/obj/item/fishing_lure/led
	name = "\improper LED 钓鱼拟饵"
	desc = "一根沉重、防水、外形像鱼的 LED 棒，专门用于钓取夜行性鱼类和深水鱼类。"
	icon_state = "led"
	spin_frequency = list(3 SECONDS, 3.8 SECONDS)

/obj/item/fishing_lure/led/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/item/fishing_lure/led/update_overlays()
	. = ..()
	. += emissive_appearance(icon, "led_emissive", src)

/obj/item/fishing_lure/led/on_fishing_rod_slotted(obj/item/fishing_rod/rod, slot)
	. = ..()
	ADD_TRAIT(rod, TRAIT_ROD_IGNORE_ENVIRONMENT, type)

/obj/item/fishing_lure/led/on_fishing_rod_unslotted(obj/item/fishing_rod/rod, slot)
	. = ..()
	REMOVE_TRAIT(rod, TRAIT_ROD_IGNORE_ENVIRONMENT, type)

/obj/item/fishing_lure/led/is_catchable_fish(obj/item/fish/fish, list/fish_properties)
	if(length(list(/datum/fish_trait/nocturnal, /datum/fish_trait/heavy) & fish.fish_traits))
		return TRUE
	return FALSE

/obj/item/fishing_lure/lucky_coin
	name = "\improper 招财币拟饵"
	desc = "一枚仿金拟饵。能吸引那些喜爱闪亮之物的鱼。对其他鱼来说，它看起来一点也不好吃。"
	icon_state = "lucky_coin"
	spin_frequency = list(1.5 SECONDS, 2.7 SECONDS)

/obj/item/fishing_lure/lucky_coin/on_fishing_rod_slotted(obj/item/fishing_rod/rod, slot)
	. = ..()
	ADD_TRAIT(rod, TRAIT_ROD_ATTRACT_SHINY_LOVERS, REF(src))

/obj/item/fishing_lure/lucky_coin/on_fishing_rod_unslotted(obj/item/fishing_rod/rod, slot)
	. = ..()
	REMOVE_TRAIT(rod, TRAIT_ROD_ATTRACT_SHINY_LOVERS, REF(src))

/obj/item/fishing_lure/lucky_coin/is_catchable_fish(obj/item/fish/fish, list/fish_properties)
	if(/datum/fish_trait/shiny_lover in fish.fish_traits)
		return TRUE
	return FALSE

/obj/item/fishing_lure/algae
	name = "塑料藻类拟饵"
	desc = "一团柔软的假水藻。食草动物爱它，别的都不爱，连杂食动物也不爱。"
	icon_state = "algae"
	spin_frequency = list(3 SECONDS, 5 SECONDS)

/obj/item/fishing_lure/algae/is_catchable_fish(obj/item/fish/fish, list/fish_properties)
	if(/datum/fish_trait/vegan in fish.fish_traits)
		return TRUE
	return FALSE

/obj/item/fishing_lure/grub
	name = "\improper 扭扭虫拟饵"
	desc = "一种柔软的塑料拟饵，有着蛴螬的身体和扭动的尾巴。专用于钓取小鱼，只要它们不是食草动物、不挑剔，也不是挑剔的食草动物。"
	icon_state = "grub"
	spin_frequency = list(1 SECONDS, 2.7 SECONDS)

/obj/item/fishing_lure/grub/is_catchable_fish(obj/item/fish/fish, list/fish_properties)
	if(fish.size >= FISH_SIZE_SMALL_MAX)
		return FALSE
	if(length(list(/datum/fish_trait/vegan, /datum/fish_trait/picky_eater) & fish.fish_traits))
		return FALSE
	return TRUE

/obj/item/fishing_lure/buzzbait
	name = "\improper 电嗡拟饵"
	desc = "一个固定在几根线缆上的金属彩色咔哒块，不知为何能吸引值得一电的鱼。"
	icon_state = "buzzbait"
	spin_frequency = list(0.8 SECONDS, 1.7 SECONDS)

/obj/item/fishing_lure/buzzbait/is_catchable_fish(obj/item/fish/fish, list/fish_properties)
	if(HAS_TRAIT(fish, TRAIT_FISH_ELECTROGENESIS))
		return TRUE
	return FALSE

/obj/item/fishing_lure/spinnerbait
	name = "旋转亮片拟饵"
	desc = "一种会旋转、易受损的拟饵，非常适合吸引淡水掠食者，不过杂食动物不会对它感兴趣。"
	icon_state = "spinnerbait"
	spin_frequency = list(2 SECONDS, 4 SECONDS)

/obj/item/fishing_lure/spinnerbait/is_catchable_fish(obj/item/fish/fish, list/fish_properties)
	if(!(/datum/fish_trait/predator in fish.fish_traits))
		return FALSE
	var/init_fluid_type = fish.required_fluid_type
	if(init_fluid_type == AQUARIUM_FLUID_FRESHWATER || init_fluid_type == AQUARIUM_FLUID_ANADROMOUS || init_fluid_type == AQUARIUM_FLUID_ANY_WATER)
		return TRUE
	if((/datum/fish_trait/amphibious in fish.fish_traits) && init_fluid_type == AQUARIUM_FLUID_AIR) //fluid type is changed to freshwater on init
		return TRUE
	return FALSE

/obj/item/fishing_lure/daisy_chain
	name = "雏菊链拟饵"
	desc = "一种外形类似小鱼群的拟饵。咸水掠食者爱它，但别的鱼大多不感兴趣。"
	icon_state = "daisy_chain"
	spin_frequency = list(2 SECONDS, 4 SECONDS)

/obj/item/fishing_lure/daisy_chain/is_catchable_fish(obj/item/fish/fish, list/fish_properties)
	if(!(/datum/fish_trait/predator in fish.fish_traits))
		return FALSE
	var/init_fluid_type = fish.required_fluid_type
	if(init_fluid_type == AQUARIUM_FLUID_SALTWATER || init_fluid_type == AQUARIUM_FLUID_ANADROMOUS || init_fluid_type == AQUARIUM_FLUID_ANY_WATER)
		return TRUE
	return FALSE
