/obj/item/clothing/gloves/kaza_ruk/sec/warden
	name = "典狱长卡扎鲁克手套"
	desc = "这双手套似乎能引导你施展提兹拉武术卡扎鲁克的改良版本，非蜥蜴人也能轻松使用。\
		加固支撑有助于佩戴者在近身搏斗时站稳脚跟。"
	clothing_traits = list(TRAIT_FAST_CUFFING, TRAIT_BRAWLING_KNOCKDOWN_BLOCKED, TRAIT_NO_STAGGER, TRAIT_NO_THROW_HITPUSH)

/obj/item/gun/energy/laser/scatter/shotty/warden
	name = "典狱长失能霰弹枪"
	desc = "一把被拆空并改装了内置失能系统的战斗霰弹枪。供电单元似乎在69年的汉堡站大暴乱中遭受了损坏。"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter/disabler)
	pin = /obj/item/firing_pin
	projectile_damage_multiplier = 0.75

/obj/item/clothing/gloves/kaza_ruk/sec/warden/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/gun/ballistic/shotgun/automatic/combat/compact)

/obj/structure/closet/secure_closet/hos/populate_contents_immediate()
	. = ..()
	var/obj/item/gun/energy/e_gun/hos/original_primary = locate(/obj/item/gun/energy/e_gun/hos) in src
	if(original_primary)
		qdel(original_primary)
	new /obj/item/hos_primary_case(src)

/obj/structure/closet/secure_closet/warden/PopulateContents()
	. = ..()
	new /obj/item/stamp/warden(src)
	if(!locate(/obj/item/clothing/gloves/kaza_ruk/sec/warden) in src)
		new /obj/item/clothing/gloves/kaza_ruk/sec/warden(src)
	if(!locate(/obj/item/gun/energy/laser/scatter/shotty) in src)
		new /obj/item/gun/energy/laser/scatter/shotty/warden(src)

/obj/structure/closet/secure_closet/warden/populate_contents_immediate()
	. = ..()
	for(var/obj/item/gun/ballistic/shotgun/automatic/combat/compact/warden_primary in src)
		if(warden_primary.type == /obj/item/gun/ballistic/shotgun/automatic/combat/compact)
			qdel(warden_primary)

/obj/structure/closet/secure_closet/hop/populate_contents_immediate()
	. = ..()
	new /obj/item/stamp/granted(src)
	new /obj/item/stamp/denied(src)
	new /obj/item/autosurgeon/paperwork(src)

/obj/structure/closet/secure_closet/nanotrasen_consultant/PopulateContents()
	. = ..()
	new /obj/item/autosurgeon/paperwork(src)

/obj/machinery/suit_storage_unit/blueshield
	mask_type = /obj/item/clothing/mask/gas/sechailer
	mod_type = /obj/item/mod/control/pre_equipped/blueshield
