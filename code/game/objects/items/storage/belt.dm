/obj/item/storage/belt
	name = "其实不是工具腰带"
	desc = "可以装下各种东西。这是 /belt 的基础类型，你确定你该拿到这个吗？"
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "utility"
	inhand_icon_state = "utility"
	worn_icon_state = "utility"
	lefthand_file = 'icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/belt_righthand.dmi'
	abstract_type = /obj/item/storage/belt
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("抽打", "鞭打", "惩戒")
	attack_verb_simple = list("抽打", "鞭打", "惩戒")
	max_integrity = 300
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
	w_class = WEIGHT_CLASS_BULKY
	var/content_overlays = FALSE //If this is true, the belt will gain overlays based on what it's holding

/obj/item/storage/belt/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]开始用[src]抽打自己！看起来是想自杀！"))
	return BRUTELOSS

/obj/item/storage/belt/update_overlays()
	. = ..()
	if(!content_overlays)
		return
	for(var/obj/item/I in contents)
		. += I.get_belt_overlay()

/obj/item/storage/belt/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/attack_equip)
	AddElement(/datum/element/strip_accessible_storage)
	update_appearance()

/obj/item/storage/belt/utility
	name = "工具腰带" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "用于装工具。"
	icon_state = "utility"
	inhand_icon_state = "utility"
	worn_icon_state = "utility"
	content_overlays = TRUE
	custom_premium_price = PAYCHECK_CREW * 2
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/utility_belt

/obj/item/storage/belt/utility/chief
	name = "总工程师工具腰带"
	desc = "用于装工具，看起来很时髦。"
	icon_state = "utility_ce"
	inhand_icon_state = "utility_ce"
	worn_icon_state = "utility_ce"

/obj/item/storage/belt/utility/chief/full
	preload = TRUE

/obj/item/storage/belt/utility/chief/full/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver/power, src)
	SSwardrobe.provide_type(/obj/item/crowbar/power, src)
	SSwardrobe.provide_type(/obj/item/weldingtool/experimental, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/stack/cable_coil, src)
	SSwardrobe.provide_type(/obj/item/extinguisher/mini, src)
	SSwardrobe.provide_type(/obj/item/analyzer/ranged, src) //SKYRAT EDIT - Ranged Analyzer for CE - ORIGINAL: SSwardrobe.provide_type(/obj/item/analyzer, src)
	//much roomier now that we've managed to remove two tools

/obj/item/storage/belt/utility/chief/full/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver/power
	to_preload += /obj/item/crowbar/power
	to_preload += /obj/item/weldingtool/experimental
	to_preload += /obj/item/multitool
	to_preload += /obj/item/stack/cable_coil
	to_preload += /obj/item/extinguisher/mini
	to_preload += /obj/item/analyzer/ranged // SKYRAT EDIT - Ranged Analyzer for CE
	return to_preload

/obj/item/storage/belt/utility/full/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver, src)
	SSwardrobe.provide_type(/obj/item/wrench, src)
	SSwardrobe.provide_type(/obj/item/weldingtool, src)
	SSwardrobe.provide_type(/obj/item/crowbar, src)
	SSwardrobe.provide_type(/obj/item/wirecutters, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/stack/cable_coil, src)

/obj/item/storage/belt/utility/full/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver
	to_preload += /obj/item/wrench
	to_preload += /obj/item/weldingtool
	to_preload += /obj/item/crowbar
	to_preload += /obj/item/wirecutters
	to_preload += /obj/item/multitool
	to_preload += /obj/item/stack/cable_coil
	return to_preload

/obj/item/storage/belt/utility/full/powertools
	preload = FALSE

/obj/item/storage/belt/utility/full/powertools/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/electric(src) // SKYRAT EDIT - original: new /obj/item/weldingtool/experimental(src)
	new /obj/item/multitool(src)
	new /obj/item/holosign_creator/atmos(src)
	new /obj/item/extinguisher/mini(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/belt/utility/full/powertools/rcd/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/experimental(src)
	new /obj/item/multitool(src)
	new /obj/item/construction/rcd/loaded/upgraded(src)
	new /obj/item/extinguisher/mini(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/belt/utility/full/engi/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver, src)
	SSwardrobe.provide_type(/obj/item/wrench, src)
	SSwardrobe.provide_type(/obj/item/weldingtool/largetank, src)
	SSwardrobe.provide_type(/obj/item/crowbar, src)
	SSwardrobe.provide_type(/obj/item/wirecutters, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/stack/cable_coil, src)

/obj/item/storage/belt/utility/full/engi/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver
	to_preload += /obj/item/wrench
	to_preload += /obj/item/weldingtool/largetank
	to_preload += /obj/item/crowbar
	to_preload += /obj/item/wirecutters
	to_preload += /obj/item/multitool
	to_preload += /obj/item/stack/cable_coil
	return to_preload

/obj/item/storage/belt/utility/atmostech/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver, src)
	SSwardrobe.provide_type(/obj/item/wrench, src)
	SSwardrobe.provide_type(/obj/item/weldingtool, src)
	SSwardrobe.provide_type(/obj/item/crowbar, src)
	SSwardrobe.provide_type(/obj/item/wirecutters, src)
	SSwardrobe.provide_type(/obj/item/t_scanner, src)
	SSwardrobe.provide_type(/obj/item/extinguisher/mini, src)

/obj/item/storage/belt/utility/atmostech/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver
	to_preload += /obj/item/wrench
	to_preload += /obj/item/weldingtool
	to_preload += /obj/item/crowbar
	to_preload += /obj/item/wirecutters
	to_preload += /obj/item/t_scanner
	to_preload += /obj/item/extinguisher/mini
	return to_preload

/obj/item/storage/belt/utility/full/inducer/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver, src)
	SSwardrobe.provide_type(/obj/item/wrench, src)
	SSwardrobe.provide_type(/obj/item/weldingtool, src)
	SSwardrobe.provide_type(/obj/item/crowbar/red, src)
	SSwardrobe.provide_type(/obj/item/wirecutters, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/inducer, src)

/obj/item/storage/belt/utility/full/inducer/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver
	to_preload += /obj/item/wrench
	to_preload += /obj/item/weldingtool
	to_preload += /obj/item/crowbar
	to_preload += /obj/item/wirecutters
	to_preload += /obj/item/multitool
	to_preload += /obj/item/inducer
	return to_preload

/obj/item/storage/belt/utility/syndicate
	preload = FALSE

/obj/item/storage/belt/utility/syndicate/PopulateContents()
	new /obj/item/screwdriver/nuke(src)
	new /obj/item/wrench/combat(src)
	new /obj/item/weldingtool/largetank(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)
	new /obj/item/inducer/syndicate(src)

/obj/item/storage/belt/medical
	name = "医疗腰带"
	desc = "可以装下各种医疗设备。"
	icon_state = "medical"
	inhand_icon_state = "medical"
	worn_icon_state = "medical"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/medical_belt

/obj/item/storage/belt/medical/paramedic
	name = "急救员腰带"
	icon_state = "emt"
	inhand_icon_state = "security"
	worn_icon_state = "emt"
	preload = TRUE

/obj/item/storage/belt/medical/paramedic/PopulateContents()
	SSwardrobe.provide_type(/obj/item/sensor_device, src)
	SSwardrobe.provide_type(/obj/item/stack/medical/wrap/gauze/twelve, src)
	SSwardrobe.provide_type(/obj/item/tourniquet, src)
	SSwardrobe.provide_type(/obj/item/bonesetter, src)
	SSwardrobe.provide_type(/obj/item/reagent_containers/syringe, src)
	SSwardrobe.provide_type(/obj/item/reagent_containers/cup/bottle/ammoniated_mercury, src)
	SSwardrobe.provide_type(/obj/item/reagent_containers/cup/bottle/formaldehyde, src)
	update_appearance()

/obj/item/storage/belt/medical/paramedic/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/sensor_device
	to_preload += /obj/item/stack/medical/wrap/gauze/twelve
	to_preload += /obj/item/tourniquet
	to_preload += /obj/item/bonesetter
	to_preload += /obj/item/reagent_containers/syringe
	to_preload += /obj/item/reagent_containers/cup/bottle/ammoniated_mercury
	to_preload += /obj/item/reagent_containers/cup/bottle/formaldehyde
	return to_preload

/obj/item/storage/belt/medical/ert
	icon_state = "emt"
	inhand_icon_state = "security"
	worn_icon_state = "emt"
	preload = TRUE

/obj/item/storage/belt/medical/ert/PopulateContents()
	SSwardrobe.provide_type(/obj/item/sensor_device, src)
	SSwardrobe.provide_type(/obj/item/pinpointer/crew, src)
	SSwardrobe.provide_type(/obj/item/scalpel/advanced, src)
	SSwardrobe.provide_type(/obj/item/retractor/advanced, src)
	SSwardrobe.provide_type(/obj/item/stack/medical/bone_gel, src)
	SSwardrobe.provide_type(/obj/item/cautery/advanced, src)
	SSwardrobe.provide_type(/obj/item/surgical_drapes, src)
	update_appearance()

/obj/item/storage/belt/medical/ert/get_types_to_preload()
	var/list/to_preload = list()
	to_preload += /obj/item/sensor_device
	to_preload += /obj/item/pinpointer/crew
	to_preload += /obj/item/scalpel/advanced
	to_preload += /obj/item/retractor/advanced
	to_preload += /obj/item/stack/medical/bone_gel
	to_preload += /obj/item/cautery/advanced
	to_preload += /obj/item/surgical_drapes
	return to_preload

/obj/item/storage/belt/security
	name = "安保腰带"
	desc = "可以装下手铐、闪光弹等安保装备。"
	icon_state = "security"
	inhand_icon_state = "security"//Could likely use a better one.
	worn_icon_state = "security"
	content_overlays = TRUE
	storage_type = /datum/storage/security_belt

/obj/item/storage/belt/security/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded(src)
	update_appearance()

/obj/item/storage/belt/security/webbing
	name = "安保胸挂"
	desc = "独特而多用途的胸挂，可以装载安保装备。"
	icon_state = "securitywebbing"
	inhand_icon_state = "securitywebbing"
	worn_icon_state = "securitywebbing"
	content_overlays = FALSE
	custom_premium_price = PAYCHECK_COMMAND * 3
	storage_type = /datum/storage/security_belt/webbing

/obj/item/storage/belt/mining
	name = "探险者胸挂"
	desc = "多用途胸挂，深受矿工与猎人喜爱。"
	icon_state = "explorer1"
	inhand_icon_state = "explorer1"
	worn_icon_state = "explorer1"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/mining_belt

/obj/item/storage/belt/mining/vendor/PopulateContents()
	new /obj/item/survivalcapsule(src)

/obj/item/storage/belt/mining/alt
	icon_state = "explorer2"
	inhand_icon_state = "explorer2"
	worn_icon_state = "explorer2"

/obj/item/storage/belt/mining/healing/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/reagent_containers/hypospray/medipen/survival/luxury(src)
	for(var/i in 1 to 2)
		new /obj/item/reagent_containers/hypospray/medipen/survival(src)
	for(var/i in 1 to 2)
		var/obj/item/organ/monster_core/core = new /obj/item/organ/monster_core/regenerative_core/legion(src)
		core.preserve()

/obj/item/storage/belt/mining/primitive
	name = "猎手腰带"
	desc = "多用途腰带，用肌腱编织而成。"
	icon_state = "ebelt"
	inhand_icon_state = "ebelt"
	worn_icon_state = "ebelt"
	storage_type = /datum/storage/mining_belt/primitive

/obj/item/storage/belt/soulstone
	name = "灵魂石腰带"
	desc = "设计上便于在战斗中取用碎片，以免让任何一个敌人灵魂溜走。"
	icon_state = "soulstonebelt"
	inhand_icon_state = "soulstonebelt"
	worn_icon_state = "soulstonebelt"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/soulstone_belt

/obj/item/storage/belt/soulstone/full/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/soulstone/mystic(src)

/obj/item/storage/belt/soulstone/full/chappy/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/soulstone/anybody/chaplain(src)

/obj/item/storage/belt/champion
	name = "冠军腰带"
	desc = "向全世界证明你是最强的！"
	icon_state = "championbelt"
	inhand_icon_state = "championbelt"
	worn_icon_state = "championbelt"
	custom_materials = list(/datum/material/gold=SMALL_MATERIAL_AMOUNT *4)
	storage_type = /datum/storage/champion_belt

/obj/item/storage/belt/champion/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/adjust_fishing_difficulty, -2)

/obj/item/storage/belt/military
	name = "胸挂"
	desc = "一套由辛迪加登舰部队穿着的战术胸挂。"
	icon_state = "militarywebbing"
	inhand_icon_state = "militarywebbing"
	worn_icon_state = "militarywebbing"
	resistance_flags = FIRE_PROOF
	storage_type = /datum/storage/military_belt

/obj/item/storage/belt/military/snack
	name = "战术零食胸挂"
	storage_type = /datum/storage/military_belt/snack

/obj/item/storage/belt/military/snack/Initialize(mapload)
	. = ..()
	var/sponsor = pick("咚克公司", "华夫公司", "罗福公司", "戈尔莱克斯掠夺者", "猛虎合作社")
	desc = "一套由[sponsor]虚拟现实体育分部运动员穿着的零食战术胸挂。"

/obj/item/storage/belt/military/snack/full/Initialize(mapload)
	. = ..()
	var/amount = 5
	var/rig_snacks
	while(contents.len <= amount)
		rig_snacks = pick(list(
			/obj/item/food/candy,
			/obj/item/food/cheesiehonkers,
			/obj/item/food/cheesynachos,
			/obj/item/food/chips,
			/obj/item/food/cubannachos,
			/obj/item/food/donkpocket,
			/obj/item/food/nachos,
			/obj/item/food/nugget,
			/obj/item/food/rofflewaffles,
			/obj/item/food/sosjerky,
			/obj/item/food/spacetwinkie,
			/obj/item/food/spaghetti/pastatomato,
			/obj/item/food/syndicake,
			/obj/item/reagent_containers/cup/glass/drinkingglass/filled/nuka_cola,
			/obj/item/reagent_containers/cup/glass/dry_ramen,
			/obj/item/reagent_containers/cup/soda_cans/cola,
			/obj/item/reagent_containers/cup/soda_cans/dr_gibb,
			/obj/item/reagent_containers/cup/soda_cans/lemon_lime,
			/obj/item/reagent_containers/cup/soda_cans/pwr_game,
			/obj/item/reagent_containers/cup/soda_cans/space_mountain_wind,
			/obj/item/reagent_containers/cup/soda_cans/space_up,
			/obj/item/reagent_containers/cup/soda_cans/starkist,
		))
		new rig_snacks(src)

/obj/item/storage/belt/military/abductor
	name = "特工腰带"
	desc = "绑架者特工使用的腰带。"
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "belt"
	inhand_icon_state = "security"
	worn_icon_state = "security"
	content_overlays = TRUE

/obj/item/storage/belt/military/abductor/full/PopulateContents()
	new /obj/item/screwdriver/abductor(src)
	new /obj/item/wrench/abductor(src)
	new /obj/item/weldingtool/abductor(src)
	new /obj/item/crowbar/abductor(src)
	new /obj/item/wirecutters/abductor(src)
	new /obj/item/multitool/abductor(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/belt/military/army
	name = "军用腰带"
	desc = "军队使用的腰带。"
	icon_state = "military"
	inhand_icon_state = "security"
	worn_icon_state = "military"

/obj/item/storage/belt/military/assault
	name = "突击腰带"
	desc = "一条战术突击腰带。"
	icon_state = "assault"
	inhand_icon_state = "security"
	worn_icon_state = "assault"
	storage_type = /datum/storage/military_belt/assault

/obj/item/storage/belt/military/assault/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/wt550m9 = 4,
		/obj/item/ammo_box/magazine/wt550m9/wtap = 2,
	), src)

/obj/item/storage/belt/grenade
	name = "掷弹兵腰带"
	desc = "用于装手榴弹的腰带。"
	icon_state = "grenadebeltnew"
	inhand_icon_state = "security"
	worn_icon_state = "grenadebeltnew"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/grenade_belt

/obj/item/storage/belt/grenade/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/grenade/chem_grenade/incendiary = 2,
		/obj/item/grenade/empgrenade = 2,
		/obj/item/grenade/frag = 10,
		/obj/item/grenade/flashbang = 2,
		/obj/item/grenade/gluon = 4,
		/obj/item/grenade/smokebomb = 4,
		/obj/item/grenade/syndieminibomb = 2,
		/obj/item/multitool = 1,
		/obj/item/screwdriver = 1,
	), src)


/obj/item/storage/belt/wands
	name = "魔杖腰带"
	desc = "设计用于装下各种能量法杖。名副其实的异域魔法腰包。"
	icon_state = "soulstonebelt"
	inhand_icon_state = "soulstonebelt"
	worn_icon_state = "soulstonebelt"
	storage_type = /datum/storage/wands_belt

/// Put some wands in that bad boy
/obj/item/storage/belt/wands/full/proc/create_wands()
	new /obj/item/gun/magic/wand/death(src)
	new /obj/item/gun/magic/wand/resurrection(src)
	new /obj/item/gun/magic/wand/fireball(src) //SKYRAT EDIT - Trades polymorph for second fireball
	new /obj/item/gun/magic/wand/teleport(src)
	new /obj/item/gun/magic/wand/door(src)
	new /obj/item/gun/magic/wand/fireball(src)
	new /obj/item/gun/magic/wand/shrink(src)

/obj/item/storage/belt/wands/full/PopulateContents()
	create_wands()
	for(var/obj/item/gun/magic/wand/W in contents) //All wands in this pack come in the best possible condition
		W.max_charges = initial(W.max_charges)
		W.charges = W.max_charges

/// Filled with budget wands instead of cool ones
/obj/item/storage/belt/wands/full/discount
	/// Which wands can appear?
	var/static/list/possible_options = list(
		/obj/item/gun/magic/wand/animate,
		/obj/item/gun/magic/wand/babel,
		/obj/item/gun/magic/wand/bald,
		/obj/item/gun/magic/wand/door,
		/obj/item/gun/magic/wand/fireball,
		/obj/item/gun/magic/wand/freeze,
		/obj/item/gun/magic/wand/hallucination,
		/obj/item/gun/magic/wand/levitate,
		/obj/item/gun/magic/wand/pax,
		/obj/item/gun/magic/wand/pizza,
		/obj/item/gun/magic/wand/plague,
		/obj/item/gun/magic/wand/prank,
		/obj/item/gun/magic/wand/rebel,
		/obj/item/gun/magic/wand/repulse,
		/obj/item/gun/magic/wand/swap,
		/obj/item/gun/magic/wand/teleport,
		/obj/item/gun/magic/wand/tentacles,
		/obj/item/gun/magic/wand/zap,
	)

/obj/item/storage/belt/wands/full/discount/create_wands()
	var/list/available_options = possible_options.Copy()
	for (var/i in 1 to 6)
		if (!length(available_options))
			break
		var/wand_path = pick_n_take(available_options)
		new wand_path(src)

/// Not a subtype of bandolier because it acts pretty differently
/obj/item/storage/belt/wand_bandolier
	name = "魔杖弹带"
	desc = "用于装下大量魔杖的弹带。佩戴在套装上时，可在行进间将耗尽的魔杖换成新的。"
	icon_state = "bandolier"
	inhand_icon_state = "bandolier"
	worn_icon_state = "bandolier"
	storage_type = /datum/storage/wands_belt
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/belt/wand_bandolier/equipped(mob/user, slot)
	. = ..()
	if (!(slot & ITEM_SLOT_SUITSTORE))
		return
	ADD_CLOTHING_TRAIT(user, TRAIT_GUNFLIP)
	RegisterSignal(user, COMSIG_MOB_FIRED_GUN, PROC_REF(on_gun_fired))

/obj/item/storage/belt/wand_bandolier/dropped(mob/user)
	. = ..()
	REMOVE_CLOTHING_TRAIT(user, TRAIT_GUNFLIP)
	UnregisterSignal(user, COMSIG_MOB_FIRED_GUN)

/// After we fire a gun, check if it's a wand. If it is and it's empty, do a swap
/obj/item/storage/belt/wand_bandolier/proc/on_gun_fired(mob/living/wizard, obj/item/gun/magic/wand/old_wand)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(equip_new_wand), wizard, old_wand)

/obj/item/storage/belt/wand_bandolier/proc/equip_new_wand(mob/living/wizard, obj/item/gun/magic/wand/old_wand)
	if (!istype(old_wand))
		return
	if (!atom_storage.real_location.contents.len) // no other wands
		return
	if (old_wand.charges > 1) // It hasn't subtracted yet
		return

	var/obj/item/fresh_wand
	for (var/obj/item/gun/magic/wand/checked in atom_storage.real_location.contents)
		if (checked.charges)
			fresh_wand = checked
			break
	if (!fresh_wand || fresh_wand.on_found())
		return // Nothing to swap with

	wizard.temporarilyRemoveItemFromInventory(old_wand)
	if (!wizard.put_in_hands(fresh_wand))
		return
	to_chat(wizard, span_notice("你迅速抽出[fresh_wand]。"))
	if (atom_storage.attempt_insert(old_wand, wizard))
		return
	old_wand.forceMove(wizard.drop_location())
	to_chat(wizard, span_warning("……并把[old_wand]掉在地上。"))

/obj/item/storage/belt/janitor
	name = "清洁腰带"
	desc = "用于装下大多数清洁用品的腰带。"
	icon_state = "janibelt"
	inhand_icon_state = "janibelt"
	worn_icon_state = "janibelt"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/janitor_belt

/obj/item/storage/belt/janitor/full/PopulateContents()
	new /obj/item/lightreplacer(src)
	new /obj/item/reagent_containers/spray/cleaner(src)
	new /obj/item/soap/nanotrasen(src)
	new /obj/item/holosign_creator(src)
	new /obj/item/melee/flyswatter(src)

/obj/item/storage/belt/bandolier
	name = "弹带"
	desc = "用于装填步枪、霰弹枪以及更大口径左轮弹药的弹带。"
	icon_state = "bandolier"
	inhand_icon_state = "bandolier"
	worn_icon_state = "bandolier"
	storage_type = /datum/storage/bandolier_belt

/obj/item/storage/belt/bandolier/china_lake_extra/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_casing/a40mm = 12,
	), src)

/obj/item/storage/belt/fannypack
	name = "腰包"
	desc = "一个呆头呆脑的小腰包，用来装小物件。它足够隐蔽——或者足够难看让人别开眼——别人不容易看清你放进或取出了什么。"
	icon_state = "fannypack_leather"
	inhand_icon_state = null
	worn_icon_state = "fannypack_leather"
	dying_key = DYE_REGISTRY_FANNYPACK
	custom_price = PAYCHECK_CREW * 2
	storage_type = /datum/storage/fanny_pack

/obj/item/storage/belt/fannypack/black
	name = "黑色腰包"
	icon_state = "fannypack_black"
	worn_icon_state = "fannypack_black"

/obj/item/storage/belt/fannypack/red
	name = "红色腰包"
	icon_state = "fannypack_red"
	worn_icon_state = "fannypack_red"

/obj/item/storage/belt/fannypack/purple
	name = "紫色腰包"
	icon_state = "fannypack_purple"
	worn_icon_state = "fannypack_purple"

/obj/item/storage/belt/fannypack/blue
	name = "蓝色腰包"
	icon_state = "fannypack_blue"
	worn_icon_state = "fannypack_blue"

/obj/item/storage/belt/fannypack/orange
	name = "橙色腰包"
	icon_state = "fannypack_orange"
	worn_icon_state = "fannypack_orange"

/obj/item/storage/belt/fannypack/white
	name = "白色腰包"
	icon_state = "fannypack_white"
	worn_icon_state = "fannypack_white"

/obj/item/storage/belt/fannypack/green
	name = "绿色腰包"
	icon_state = "fannypack_green"
	worn_icon_state = "fannypack_green"

/obj/item/storage/belt/fannypack/pink
	name = "粉色腰包"
	icon_state = "fannypack_pink"
	worn_icon_state = "fannypack_pink"

/obj/item/storage/belt/fannypack/cyan
	name = "青色腰包"
	icon_state = "fannypack_cyan"
	worn_icon_state = "fannypack_cyan"

/obj/item/storage/belt/fannypack/yellow
	name = "黄色腰包"
	icon_state = "fannypack_yellow"
	worn_icon_state = "fannypack_yellow"

/obj/item/storage/belt/fannypack/cummerbund
	name = "腰封"
	desc = "一条打褶的腰封，与西装外套搭配相宜。"
	icon_state = "cummerbund"
	inhand_icon_state = null
	worn_icon_state = "cummerbund"

/obj/item/storage/belt/fannypack/yellow/bee_terrorist/PopulateContents()
	new /obj/item/grenade/c4 (src)
	new /obj/item/reagent_containers/applicator/pill/cyanide(src)
	new /obj/item/grenade/chem_grenade/facid(src)

/obj/item/storage/belt/fannypack/black/rogue
	name = "终极绝望腰包"

/obj/item/storage/belt/fannypack/black/rogue/PopulateContents()
	new /obj/item/food/drug/saturnx(src)
	new /obj/item/reagent_containers/cup/blastoff_ampoule(src)
	new /obj/item/reagent_containers/hypospray/medipen/methamphetamine(src)

/obj/item/storage/belt/sheath
	desc = "用来装……刀之类的东西。你不该看到这个。"
	w_class = WEIGHT_CLASS_BULKY
	interaction_flags_click = parent_type::interaction_flags_click | NEED_DEXTERITY | NEED_HANDS
	var/stored_blade
	actions_types = list(/datum/action/innate/blade_counter)
	action_slots = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	COOLDOWN_DECLARE(resheath_cooldown)
	COOLDOWN_DECLARE(full_ability_cooldown)

/obj/item/storage/belt/sheath/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob, action_slots)
	RegisterSignal(src, COMSIG_ATOM_STORED_ITEM, PROC_REF(post_resheath))

/obj/item/storage/belt/sheath/Destroy(force)
	. = ..()
	UnregisterSignal(src, COMSIG_ATOM_STORED_ITEM)

/obj/item/storage/belt/sheath/examine(mob/user)
	. = ..()
	if(length(contents))
		. += span_notice("按住 Alt 点击可快速抽出刀刃。")

/obj/item/storage/belt/sheath/click_alt(mob/user)
	if(!length(contents))
		balloon_alert(user, "是空的！")
		return CLICK_ACTION_BLOCKING
	var/obj/item/stored_item = contents[1]
	user.visible_message(span_notice("[user]从[src]中取出[stored_item]。"), span_notice("你从[src]中取出[stored_item]。"))
	user.put_in_hands(stored_item)
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/storage/belt/sheath/update_icon_state()
	icon_state = initial(icon_state)
	inhand_icon_state = initial(inhand_icon_state)
	worn_icon_state = initial(worn_icon_state)
	if(contents.len)
		icon_state += "-full"
		inhand_icon_state += "-full"
		worn_icon_state += "-full"
	return ..()

/obj/item/storage/belt/sheath/PopulateContents()
	if(stored_blade)
		new stored_blade(src)
		update_appearance()

/obj/item/storage/belt/sheath/proc/post_resheath()
	SIGNAL_HANDLER
	COOLDOWN_START(src, resheath_cooldown, 10 SECONDS)

/datum/action/innate/blade_counter
	name = "反击"
	desc = "预判敌人的攻击，用鞘中的刀刃反击。"
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "declaration"
	ranged_mousepointer = 'icons/effects/mouse_pointers/honorbound.dmi'

	enable_text = "你准备反击目标……"
	disable_text = "你放松了架势。"

	click_action = TRUE

	var/datum/weakref/eyed_fool

/datum/action/innate/blade_counter/IsAvailable(feedback = TRUE)
	if(!isliving(owner))
		return FALSE
	var/obj/item/storage/belt/sheath/owners_sheath = target
	if(!COOLDOWN_FINISHED(owners_sheath, full_ability_cooldown))
		if(feedback)
			to_chat(owner, span_warning("你刚刚才反击失败过，还没恢复！"))
		return FALSE
	if(!length(owners_sheath.contents))
		if(feedback)
			to_chat(owner, span_warning("你的刀鞘是空的！"))
		return FALSE
	if(!COOLDOWN_FINISHED(owners_sheath, resheath_cooldown))
		if(feedback)
			to_chat(owner, span_warning("你才刚刚把刀收回鞘！"))
		return FALSE
	return TRUE

/datum/action/innate/blade_counter/proc/final_checks(atom/cast_on)
	if(!isliving(cast_on))
		return FALSE
	if(owner == cast_on)
		to_chat(owner, span_warning("你不能反击自己！"))
		return FALSE
	var/mob/living/target = cast_on
	if(!target.mind)
		to_chat(owner, span_warning("他们太难以捉摸，无法反击！"))
		return FALSE
	var/obj/item/storage/belt/sheath/oursheath = target
	if(!length(oursheath.contents))
		return FALSE
	return TRUE

/datum/action/innate/blade_counter/do_ability(mob/living/swordsman, mob/living/cast_on)
	if(!final_checks(cast_on))
		return TRUE
	var/obj/item/storage/belt/sheath/used_sheath = target
	RegisterSignal(swordsman, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(counter_attack))
	swordsman.Immobilize(1 SECONDS)
	eyed_fool = WEAKREF(cast_on)
	swordsman.visible_message(span_danger("[swordsman]拉开架势，手悬在[used_sheath]上方！"), span_notice("你准备反击[cast_on]！"))
	addtimer(CALLBACK(src, PROC_REF(relax), swordsman, used_sheath), 1 SECONDS)
	COOLDOWN_START(used_sheath, full_ability_cooldown, 60 SECONDS)
	unset_ranged_ability(swordsman)
	return TRUE

#define COUNTERMULTIPLIER 3

/datum/action/innate/blade_counter/proc/counter_attack(mob/living/forward_thinker, atom/attackingthing, damage, attack_text, attack_type)
	SIGNAL_HANDLER
	var/obj/item/storage/belt/sheath/used_sheath = target
	if(!used_sheath || !length(used_sheath.contents) || (attack_type != MELEE_ATTACK && attack_type != UNARMED_ATTACK))
		return FAILED_BLOCK

	var/obj/item/justicetool = used_sheath.contents[1]
	var/mob/living/fool = isliving(attackingthing) ? attackingthing : attackingthing.loc
	if(used_sheath.loc != forward_thinker || fool != eyed_fool.resolve() || !forward_thinker.put_in_active_hand(justicetool))
		return FAILED_BLOCK
	do_strike(fool, forward_thinker, justicetool)
	playsound(forward_thinker, 'sound/items/unsheath.ogg', 50, TRUE)
	COOLDOWN_RESET(used_sheath, full_ability_cooldown)
	return SUCCESSFUL_BLOCK

/datum/action/innate/blade_counter/proc/do_strike(mob/living/fool, mob/living/forward_thinker, obj/item/justicetool)
	var/obj/item/bodypart/offending_hand = fool.get_active_hand()
	forward_thinker.visible_message(span_danger("[forward_thinker]在[fool]攻击之际迅速抽出[justicetool]并击中[fool]！"), span_notice("你在[fool]攻击之际迅速抽出[justicetool]并反击[fool]！"))
	fool.apply_damage(
		damage = justicetool.force * COUNTERMULTIPLIER,
		damagetype = justicetool.damtype,
		def_zone = offending_hand,
		blocked = fool.run_armor_check(offending_hand, MELEE, armour_penetration = justicetool.armour_penetration, silent = TRUE),
		wound_bonus = justicetool.wound_bonus * COUNTERMULTIPLIER,
		exposed_wound_bonus = justicetool.exposed_wound_bonus * COUNTERMULTIPLIER,
		sharpness = justicetool.sharpness,
		attack_direction = get_dir(forward_thinker, fool),
		attacking_item = justicetool,
	)


/datum/action/innate/blade_counter/proc/relax(mob/living/holder, obj/item/storage/belt/sheath/active_sheath)
	UnregisterSignal(holder, COMSIG_LIVING_CHECK_BLOCK)

/datum/action/innate/blade_counter/gunpowered
	name = "动力反击"
	desc = "预判敌人的攻击并尝试反击，但自身风险极大。由于击发角度限制，必须将其挂在腰间。"

	/// Whether the currently relevant counterattack succeeded.
	var/succeeded_attempt = FALSE

/datum/action/innate/blade_counter/gunpowered/do_ability(mob/living/swordsman, mob/living/cast_on)
	. = ..()
	succeeded_attempt = FALSE


/datum/action/innate/blade_counter/gunpowered/do_strike(mob/living/fool, mob/living/forward_thinker, obj/item/justicetool)
	if(forward_thinker.get_slot_by_item(target) == ITEM_SLOT_SUITSTORE)
		return ..()
	succeeded_attempt = TRUE
	var/obj/item/bodypart/offending_hand = fool.get_active_hand()
	var/obj/item/bodypart/risked_hand = forward_thinker.get_active_hand()
	if(iscarbon(fool) && offending_hand.dismember(BRUTE, FALSE, WOUND_SLASH))
		forward_thinker.visible_message(span_danger("[forward_thinker]在[fool]攻击之际迅速抽出[justicetool]并击中[fool]，把对方的手臂砍飞！"),
										span_notice("你在[fool]攻击之际迅速抽出[justicetool]，砍下了[fool]的手臂！"))
	else
		fool.apply_damage(
			damage = justicetool.force * COUNTERMULTIPLIER,
			damagetype = justicetool.damtype,
			def_zone = offending_hand,
			blocked = fool.run_armor_check(offending_hand, MELEE, armour_penetration = justicetool.armour_penetration, silent = TRUE),
			wound_bonus = justicetool.wound_bonus * COUNTERMULTIPLIER,
			exposed_wound_bonus = justicetool.exposed_wound_bonus * COUNTERMULTIPLIER,
			sharpness = justicetool.sharpness,
			attack_direction = get_dir(forward_thinker, fool),
			attacking_item = justicetool,
		)
		forward_thinker.visible_message(span_danger("[forward_thinker]在[fool]攻击之际迅速抽出[justicetool]并击中[fool]！"),
										span_notice("你迅速抽出[justicetool]，在对方攻击途中命中了他！"))
	if(!IS_ROBOTIC_LIMB(risked_hand))
		forward_thinker.visible_message(span_danger("[forward_thinker]的手臂无法承受这一击的力量！"),
										span_danger("你感到一阵剧痛，手臂被这一击的力量撕裂！"))
		forward_thinker.apply_damage(
		damage = 50,
		damagetype = BRUTE,
		def_zone = risked_hand,
		wound_bonus = 50,
		wound_clothing = FALSE,
	)


/datum/action/innate/blade_counter/gunpowered/relax(mob/living/holder, obj/item/storage/belt/sheath/active_sheath)
	..()
	if(succeeded_attempt || holder.get_slot_by_item(target) == ITEM_SLOT_SUITSTORE)
		return

	if(length(active_sheath.contents))
		var/obj/item/denied_weapon = active_sheath.contents[1]
		denied_weapon.forceMove(get_turf(holder))
		denied_weapon.throw_at(pick(RANGE_TURFS(3, denied_weapon)), 3, 3)

	// We can assume that the holder is a carbon, and thus has an actual arm, because they have a belt slot.
	var/obj/item/bodypart/worthless_hand = holder.get_active_hand()
	if(!worthless_hand)
		worthless_hand = holder.get_inactive_hand()
		if(!worthless_hand)
			holder.visible_message(span_danger("[holder]的刀鞘误触，刀刃飞了出去！"),
									span_danger("你的刀鞘误触，刀刃飞了出去！"))
			return

	if(IS_ROBOTIC_LIMB(worthless_hand) || !worthless_hand.dismember(BRUTE, FALSE, WOUND_BLUNT))
		holder.visible_message(span_danger("[holder]误触鞘中刀刃，手臂被撕裂！"),
								span_danger("你未能安全击发刀刃，手臂被撕裂！"))
		holder.apply_damage(
			damage = 50,
			damagetype = BRUTE,
			def_zone = worthless_hand,
			wound_bonus = 50,
			wound_clothing = FALSE,
		)
		return

	holder.visible_message(span_danger("[holder]误触鞘中刀刃，手臂被猛烈扯断！"),
							span_danger("你未能安全击发刀刃，手臂被扯断！"))

#undef COUNTERMULTIPLIER

/obj/item/storage/belt/sheath/sabre
	name = "军刀鞘"
	desc = "一只华丽的刀鞘，用于收纳军官的佩剑。"
	icon_state = "sheath"
	inhand_icon_state = "sheath"
	worn_icon_state = "sheath"
	storage_type = /datum/storage/sabre_belt
	stored_blade = /obj/item/melee/sabre

/obj/item/storage/belt/sheath/grass_sabre
	name = "军刀鞘"
	desc = "一只简朴的草编刀鞘，用来装某种……军刀。不过真正的金属刀可能太锋利了……"
	icon_state = "grass_sheath"
	inhand_icon_state = "grass_sheath"
	worn_icon_state = "grass_sheath"
	storage_type = /datum/storage/green_sabre_belt

/obj/item/storage/belt/sheath/gladius
	name = "短剑鞘"
	desc = "为迷你尺寸的剑准备的迷你刀鞘。"
	icon_state = "gladius_sheath"
	inhand_icon_state = "gladius_sheath"
	worn_icon_state = "gladius_sheath"
	storage_type = /datum/storage/gladius_belt
	stored_blade = /obj/item/claymore/gladius

/obj/item/storage/belt/sheath/katana
	name = "武士刀鞘"
	desc = "用于收纳轻巧武士刀的刀鞘。"
	icon_state = "katana_sheath"
	inhand_icon_state = "katana_sheath"
	worn_icon_state = "katana_sheath"
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	storage_type = /datum/storage/katana_sheath
	stored_blade = /obj/item/katana

/obj/item/storage/belt/sheath/katana/empty
	stored_blade = NONE

/obj/item/storage/belt/sheath/katana/toy
	action_slots = NONE
	storage_type = /datum/storage/toy_sheath
	stored_blade = /obj/item/toy/katana

/obj/item/storage/belt/sheath/katana/toy/empty
	stored_blade = NONE

/obj/item/storage/belt/sheath/ninja
	name = "能量武士刀鞘"
	desc = "高科技武士刀鞘，可实现快速的拔刀动作。"
	icon_state = "ninja_sheath"
	inhand_icon_state = "ninja_sheath"
	worn_icon_state = "ninja_sheath"
	storage_type = /datum/storage/ninja_sheath
	stored_blade = /obj/item/energy_katana

/obj/item/storage/belt/sheath/hanzo_katana
	name = "半藏武士刀鞘"
	desc = "普通的黑色刀鞘，用于收纳传说中的半藏钢刀。"
	icon_state = "hanzo_sheath"
	inhand_icon_state = "hanzo_sheath"
	worn_icon_state = "hanzo_sheath"
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	storage_type = /datum/storage/hanzo_sheath
	stored_blade = /obj/item/nullrod/claymore/katana

/obj/item/storage/belt/sheath/hanzo_katana/empty
	stored_blade = NONE

/obj/item/storage/belt/plant
	name = "植物学腰带"
	desc = "结实的皮质腰带，用于装下大多数水培用品。"
	icon_state = "plantbelt"
	inhand_icon_state = "utility"
	worn_icon_state = "plantbelt"
	content_overlays = TRUE
	storage_type = /datum/storage/plant_belt

/obj/item/storage/belt/sheath/sabre/gunpowered
	name = "改装军刀鞘"
	desc = "仿制自臭名昭著的“冷空之风”的设计。带有扳机机构，可更有力地拔刀。"
	icon_state = "gunsheath"
	actions_types = list(/datum/action/innate/blade_counter/gunpowered)
	stored_blade = null

/obj/item/storage/belt/sheath/grass_sabre/gunpowered
	name = "改装军刀鞘"
	desc = "仿制自臭名昭著的“提兹拉等离子火”培育的设计。带有扳机机构，可更有力地拔刀。"
	icon_state = "grass_gunsheath"
	actions_types = list(/datum/action/innate/blade_counter/gunpowered)
