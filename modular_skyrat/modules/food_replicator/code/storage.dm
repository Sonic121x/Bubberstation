/obj/item/storage/pouch/cin_medipens
	name = "殖民地注射笔小袋"
	desc = "一个可以放进你口袋的（医用）笔小袋。"
	icon = 'modular_skyrat/modules/food_replicator/icons/pouch.dmi'
	icon_state = "medipen_pouch"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/pouch/cin_medipens/update_icon_state()
	icon_state = "[initial(icon_state)]_[contents.len]"
	return ..()

/obj/item/storage/pouch/cin_medipens/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/storage/pouch/cin_medipens/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_TINY
	atom_storage.max_total_storage = WEIGHT_CLASS_TINY*8
	atom_storage.max_slots = 8
	atom_storage.can_hold = typecacheof(list(/obj/item/reagent_containers/hypospray/medipen, /obj/item/pen, /obj/item/flashlight/pen))

/obj/item/storage/pouch/cin_medkit
	name = "殖民地急救包"
	desc = "一个可以放进你口袋的医疗盒。也能收纳与医疗无关的东西，但枪械、弹药和原材料除外。"
	icon = 'modular_skyrat/modules/food_replicator/icons/pouch.dmi'
	icon_state = "cfak"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/pouch/cin_medkit/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = 4
	atom_storage.max_slots = 4
	atom_storage.cant_hold = typecacheof(list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/stack/sheet))

/obj/item/storage/pouch/cin_general
	name = "殖民地通用小袋"
	desc = "一个合成皮革制成的多用途小袋，可以放进你的口袋。"
	icon = 'modular_skyrat/modules/food_replicator/icons/pouch.dmi'
	icon_state = "gen_pouch"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/pouch/cin_general/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = WEIGHT_CLASS_SMALL*3
	atom_storage.max_slots = 3
