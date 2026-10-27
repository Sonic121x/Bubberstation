/// Base pouch type. Fits in pockets, as its main gimmick.
/obj/item/storage/pouch
	name = "收纳袋"
	desc = "一个用深色布料制成的普通小袋，带有一个夹子，可以别在口袋里。"
	icon = 'modular_skyrat/modules/modular_items/icons/storage.dmi'
	icon_state = "survival"
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_POCKETS

/obj/item/storage/pouch/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_slots = 5

/obj/item/storage/pouch/ammo
	name = "弹药袋"
	desc = "用来装弹药的小袋，可以放进你的口袋。"
	icon = 'modular_skyrat/modules/modular_items/icons/storage.dmi'
	icon_state = "ammopouch"
	custom_price = PAYCHECK_CREW * 4

/obj/item/storage/pouch/ammo/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 12
	atom_storage.max_slots = 3
	atom_storage.numerical_stacking = FALSE
	atom_storage.can_hold = typecacheof(list(/obj/item/ammo_box/magazine, /obj/item/ammo_casing))
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/ammo_pouch)
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))

/datum/atom_skin/ammo_pouch
	abstract_type = /datum/atom_skin/ammo_pouch

/datum/atom_skin/ammo_pouch/ammo
	preview_name = "弹药袋"
	new_icon_state = "ammopouch"

/datum/atom_skin/ammo_pouch/casing
	preview_name = "弹壳袋"
	new_icon_state = "casingpouch"

/obj/item/storage/pouch/ammo/proc/on_reskin()
	SIGNAL_HANDLER
	if(icon_state == "casingpouch")
		name = "弹壳袋"
		desc = "用来装弹药的小袋，可以放进你的口袋；内部经过仔细分隔，只适合装弹壳。"
		atom_storage.can_hold = typecacheof(list(/obj/item/ammo_casing))
		atom_storage.max_specific_storage = WEIGHT_CLASS_TINY
		atom_storage.numerical_stacking = TRUE
		atom_storage.max_slots = 14
		atom_storage.max_total_storage = WEIGHT_CLASS_TINY * 10

/obj/item/storage/pouch/material
	name = "材料袋"
	desc = "用来装板材和 RCD 弹药的小袋，恰好能挂在平时放口袋物品的位置。"
	icon = 'modular_skyrat/modules/modular_items/icons/storage.dmi'
	icon_state = "materialpouch"
	custom_price = PAYCHECK_CREW * 4

/obj/item/storage/pouch/material/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = INFINITY
	atom_storage.max_slots = 2
	atom_storage.numerical_stacking = TRUE
	atom_storage.can_hold = typecacheof(list(/obj/item/rcd_ammo, /obj/item/stack/sheet))

/// It's a pocket medkit. Use sparingly?
/obj/item/storage/pouch/medical
	name = "医疗袋"
	desc = "标准医疗袋，内部分隔便于战地医疗护理。附有一组口袋夹。"
	resistance_flags = FIRE_PROOF
	icon_state = "medkit"
	/// The list of things that medical pouches can hold. Stolen from what medkits can hold, but modified for things you would probably want at pocket-access.
	var/static/list/med_pouch_holdables = list(
		/obj/item/healthanalyzer,
		/obj/item/hypospray/mkii,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/cup/vial,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/medigel,
		/obj/item/reagent_containers/spray,
		/obj/item/reagent_containers/hypospray,
		/obj/item/storage/pill_bottle,
		/obj/item/storage/box/bandages,
		/obj/item/stack/cable_coil,
		/obj/item/stack/medical,
		/obj/item/flashlight/pen,
		/obj/item/bonesetter,
		/obj/item/cautery,
		/obj/item/hemostat,
		/obj/item/reagent_containers/blood,
		/obj/item/stack/medical/wrap/sticky_tape,
	)

/obj/item/storage/pouch/medical/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_slots = 7
	atom_storage.max_total_storage = 14
	atom_storage.set_holdable(med_pouch_holdables)

/obj/item/storage/pouch/medical/loaded/Initialize(mapload)
	. = ..()
	var/static/items_inside = list(
		/obj/item/stack/medical/wrap/gauze/twelve = 1,
		/obj/item/stack/medical/suture = 2,
		/obj/item/stack/medical/mesh = 2,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/healthanalyzer/simple = 1,
	)
	generate_items_inside(items_inside, src)
	desc += " 重新包装，内含空间站标准的医疗用品。"

/// It's... not as egregious as a full pocket medkit.
/obj/item/storage/pouch/medical/firstaid
	name = "急救袋"
	desc = "标准普通急救袋，内部分隔仅容纳战地医疗护理的最基本用品。附有一个口袋夹。"
	icon_state = "firstaid"

/obj/item/storage/pouch/medical/firstaid/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	/*
	hi. you might think this is egregious. five slots? that's a lot!
	here's a thought: the pocket first aid kit from the colonial replicator [modular_skyrat\modules\food_replicator\code\storage.dm] has
	mostly unrestricted storage, limited by having 4 max total storage, so at best you're only fitting 4 tiny items. but that's 4 of *any* tiny item.
	or 2 small items (that aren't guns/mags). so it's basically just turning 1 pocket slot into 2, if you think about it hard enough.
	this is a thing you have to buy from cargo's goodies tab. not even an import. and it only fits medical supplies.
	i think it can have a lil extra storage as a treat.
	*/
	atom_storage.max_slots = 5
	atom_storage.max_total_storage = 10

/obj/item/storage/pouch/medical/firstaid/loaded/Initialize(mapload)
	. = ..()
	desc += " 重新包装，内含空间站标准的医疗用品。"
	var/static/items_inside = list(
		/obj/item/stack/medical/suture = 1,
		/obj/item/stack/medical/mesh = 1,
		/obj/item/storage/box/bandages = 1,
		/obj/item/stack/medical/wrap/gauze/twelve = 1,
		/obj/item/reagent_containers/hypospray/medipen/ekit = 1,
	)
	generate_items_inside(items_inside, src)

/obj/item/storage/pouch/medical/firstaid/stabilizer/Initialize(mapload)
	. = ..()
	desc += " 重新包装，内含以伤口稳定为重点的配置。"
	var/static/items_inside = list(
		/obj/item/cautery = 1,
		/obj/item/bonesetter = 1,
		/obj/item/stack/medical/wrap/gauze/twelve = 1,
		/obj/item/reagent_containers/hypospray/medipen/ekit = 2,
	)
	generate_items_inside(items_inside, src)
