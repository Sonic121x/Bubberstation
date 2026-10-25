/obj/item/food/drug
	name = "通用毒品"
	desc = "我是错误"
	icon = 'icons/obj/medical/drugs.dmi'
	abstract_type = /obj/item/food/drug
	foodtypes = GROSS
	food_flags = FOOD_FINGER_FOOD
	max_volume = 50
	eat_time = 1 SECONDS
	tastes = list("毒品" = 2, "化学品" = 1)
	eatverbs = list("啃咬" = 1)
	bite_consumption = 10
	w_class = WEIGHT_CLASS_TINY
	preserved_food = TRUE

/obj/item/food/drug/saturnx
	name = "土星X凝块"
	desc = "一团凝固的纯土星X。\n这种化合物在隐形技术发展初期被发现，当时被认为是一种很有潜力的候选药剂。研究人员发现其会引发思维障碍、肝毒性等一系列安全问题后，便将其淘汰。\n此后，它作为街头毒品在小范围内流行起来。"
	icon_state = "saturnx_glob" //tell kryson to sprite two more variants in the future.
	food_reagents = list(/datum/reagent/drug/saturnx = 10)

/obj/item/food/drug/saturnx/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/food/drug/moon_rock
	name = "月岩"
	desc = "一小块坚硬的克隆卡因游离碱。\n据说，一个普通克隆卡因瘾君子造成的犯罪破坏，相当于四名飞贼、两名纵火犯和一只发狂的比特犬加在一起。\n\n它会与清除体内药物的药剂产生危险相互作用，因此在医学界臭名昭著！"
	icon_state = "moon_rock1"
	food_reagents = list(/datum/reagent/drug/kronkaine = 10)

/obj/item/food/drug/moon_rock/Initialize(mapload)
	. = ..()
	icon_state = pick("moon_rock1", "moon_rock2", "moon_rock3")
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_MOONICORN, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/reagent_containers/cup/blastoff_ampoule
	name = "升·天安瓿" //stylized name
	desc = "一支小安瓿，里面的液体似乎正在剧烈沸腾。\n你怀疑里面装着升·天，这种毒品被认为是臭名昭著的月神夜总会群体伤亡事件的元凶。"
	icon = 'icons/obj/medical/drugs.dmi'
	icon_state = "blastoff_ampoule"
	base_icon_state = "blastoff_ampoule"
	volume = 20
	initial_reagent_flags = TRANSPARENT
	list_reagents = list(/datum/reagent/drug/blastoff = 10)
	reagent_consumption_method = INHALE
	consumption_sound = 'sound/effects/spray2.ogg'

/obj/item/reagent_containers/cup/blastoff_ampoule/update_icon_state()
	. = ..()
	if(!reagents.total_volume)
		icon_state = "[base_icon_state]_empty"
	else if(is_open_container())
		icon_state = "[base_icon_state]_open"
	else
		icon_state = base_icon_state

/obj/item/reagent_containers/cup/blastoff_ampoule/attack_self(mob/user)
	if(!user.can_perform_action(src, NEED_DEXTERITY) || is_open_container())
		return ..()
	add_container_flags(OPENCONTAINER)
	playsound(src, 'sound/items/ampoule_snap.ogg', 40)
	update_appearance()

/obj/item/reagent_containers/cup/blastoff_ampoule/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum, do_splash = TRUE)
	. = ..()
	if(.)
		return
	if(QDELING(src) || !hit_atom)	//Invalid loc
		return
	var/obj/item/shard/ampoule_shard = new(drop_location())
	playsound(src, SFX_SHATTER, 40, TRUE)
	transfer_fingerprints_to(ampoule_shard)
	splash_reagents(hit_atom, throwingdatum?.get_thrower(), was_thrown = TRUE, allow_closed_splash = FALSE)
	qdel(src)

/obj/item/reagent_containers/cup/blastoff_ampoule/Initialize(mapload, vol)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/food/drug/meth_crystal
	name = "冰毒结晶"
	desc = "一种透明、寒酸、看起来像假货的结晶物质。"
	icon_state = "meth_crystal1"
	tastes = list("恶心", "灼烧")
	force = 3
	throwforce = 4
	embed_type = /datum/embedding/meth

/datum/embedding/meth // lmao
	embed_chance = 9
	rip_time = 2 SECONDS
	COOLDOWN_DECLARE(reagent_message_cd)
	ignore_throwspeed_threshold = TRUE
	var/transfer_per_second = 0.5

/datum/embedding/meth/process_effect(seconds_per_tick)
	var/obj/item/rock = parent
	if(!istype(rock, /obj/item/food/drug/meth_crystal))
		return

	if(!IS_ORGANIC_LIMB(owner_limb))
		return

	if(!owner?.reagents || !rock.reagents?.total_volume)
		return

	rock.reagents.trans_to(
		owner,
		transfer_per_second * seconds_per_tick,
		methods = INJECT,
		show_message = SPT_PROB(15, seconds_per_tick)
	)

/obj/item/food/drug/meth_crystal/Initialize(mapload)
	. = ..()
	icon_state = pick("meth_crystal1", "meth_crystal2", "meth_crystal3", "meth_crystal4", "meth_crystal5")
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)
	reagents.add_reagent(/datum/reagent/drug/methamphetamine, 10)

/obj/item/food/drug/opium
	name = "鸦片"
	desc = "服用少许，仅如一粒野豌豆，便可止痛、助眠、促消化……\
	但若服用过量，则有害处，使太空人昏沉嗜睡，甚至致死。"
	icon_state = "opium1"
	tastes = list("琥珀", "苦香草")
	food_reagents = list(
		/datum/reagent/medicine/morphine = 10,
		/datum/reagent/consumable/sugar = 1
	)

/obj/item/food/drug/opium/examine()
	. = ..()
	if(reagents.get_reagent_amount(/datum/reagent/medicine/morphine) >= 10)
		. += span_notice("这块鸦片体积大、香气浓郁，无需继续提炼。")
	else
		. += span_notice("这块鸦片还很小，可以与更多鸦片压合，提高效力和浓度。")

/obj/item/food/drug/opium/Initialize(mapload) // For narcotics and black market purchases, pure and proper.
	. = ..()
	icon_state = pick("opium1", "opium2", "opium3", "opium4", "opium5")
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/food/drug/opium/raw/Initialize(mapload, potency) // Randomizes amount depending upon potency.
	. = ..()
	reagents.clear_reagents()
	var/mult = max(potency / 20, 1) // 20 = base, 100 = 5x, 200 = 10x
	reagents.add_reagent(/datum/reagent/medicine/morphine, (rand(4, 25) / 10) * mult)
	reagents.add_reagent(/datum/reagent/consumable/sugar, rand(1, 7) / 10)

/obj/item/food/drug/opium/raw/interact_with_atom(obj/item/I, mob/user) // allows for combining opium up to 10u, refining it until rich and fragrant.
	if(istype(I, /obj/item/food/drug/opium/raw))
		var/obj/item/food/drug/opium/raw/other = I

		var/current = reagents.get_reagent_amount(/datum/reagent/medicine/morphine)
		if(current >= 10)
			to_chat(user, span_notice("这块已经无法再容纳更多了。"))
			return TRUE

		var/capacity_left = 10 - current
		var/transferred = other.reagents.trans_to(src, capacity_left)

		if(transferred > 0)
			var/overflow = reagents.get_reagent_amount(/datum/reagent/medicine/morphine) - 10
			if(overflow > 0)
				reagents.trans_to(other, overflow)

			to_chat(user, span_notice("你将几块鸦片压合在一起，使其更加浓缩。"))
			if(!other.reagents.total_volume)
				qdel(other)
		else
			to_chat(user, span_notice("这些鸦片无法进一步压合。"))

		return TRUE

	return ..()
