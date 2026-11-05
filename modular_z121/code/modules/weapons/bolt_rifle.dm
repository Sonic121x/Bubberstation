/obj/item/gun/ballistic/rifle/boltaction/makeshift
	name = "简易栓动步枪"
	desc = "一把手动栓动步枪。"
	icon = 'modular_z121/icons/weapons/gunz.dmi'
	lefthand_file = 'modular_z121/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_z121/icons/weapons/righthand.dmi'
	worn_icon = 'modular_z121/icons/weapons/worn.dmi'
	fire_sound = 'modular_z121/sound/weapons/hunting_rifle.ogg'
	rack_sound = 'modular_z121/sound/weapons/gunsounds/rifle/rifleback2.ogg'
	lock_back_sound = 'modular_z121/sound/weapons/gunsounds/rifle/rifleback2.ogg'
	bolt_drop_sound = 'modular_z121/sound/weapons/gunsounds/rifle/rifledrop2.ogg'
	load_sound = 'modular_z121/sound/weapons/gunsounds/rifle/riflemag_load.ogg'
	load_empty_sound = 'modular_z121/sound/weapons/gunsounds/rifle/riflemag_load.ogg'
	can_be_sawn_off = FALSE
	recoil = 1.5
	rack_delay = 2.5 SECONDS
	spread = 0.2
	force = 10
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	can_jam = TRUE
	jamming_chance = 10
	unjam_chance = 75

/obj/item/gun/ballistic/rifle/boltaction/makeshift/arisaka
	name = "简易有坂九九式步枪"
	desc = "一把仿制的有坂九九式步枪, 发射7.7×58mm无突缘弹弹药."
	icon = 'modular_z121/icons/weapons/gunz.dmi'
	icon_state = "arisaka"
	base_icon_state = "arisaka"
	lefthand_file = 'modular_z121/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_z121/icons/weapons/righthand.dmi'
	inhand_icon_state = "arisaka"
	worn_icon = 'modular_z121/icons/weapons/worn.dmi'
	worn_icon_state = "arisaka"
	fire_sound = 'modular_z121/sound/weapons/hunting_rifle.ogg'
	rack_sound = 'modular_z121/sound/weapons/gunsounds/rifle/rifleback2.ogg'
	lock_back_sound = 'modular_z121/sound/weapons/gunsounds/rifle/rifleback2.ogg'
	bolt_drop_sound = 'modular_z121/sound/weapons/gunsounds/rifle/rifledrop2.ogg'
	load_sound = 'modular_z121/sound/weapons/gunsounds/rifle/riflemag_load.ogg'
	load_empty_sound = 'modular_z121/sound/weapons/gunsounds/rifle/riflemag_load.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/arisaka
	internal_magazine = TRUE
	recoil = 1.5
	spread = 0.2
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	projectile_damage_multiplier = 1
	projectile_speed_multiplier = 1.5
	jamming_chance = 10
	unjam_chance = 75

/datum/component/bayonet_attachable/arisaka/Initialize(
	obj/item/starting_bayonet,
	offset_x = 0,
	offset_y = 0,
	removable = TRUE,
	bayonet_icon_state = null,
	bayonet_overlay = "bayonet_thin",
	bayonet_overlay_icon = 'modular_z121/icons/weapons/gunz.dmi',
	allow_sawnoff = FALSE
)

	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	src.removable = removable
	src.bayonet_icon_state = bayonet_icon_state
	src.bayonet_overlay = bayonet_overlay
	src.bayonet_overlay_icon = bayonet_overlay_icon
	src.offset_x = offset_x
	src.offset_y = offset_y
	src.allow_sawnoff = allow_sawnoff

	if (istype(starting_bayonet))
		add_bayonet(starting_bayonet)

/obj/item/gun/ballistic/rifle/boltaction/makeshift/arisaka/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable/arisaka, offset_x = 8, offset_y = 0)

/obj/item/ammo_box/magazine/internal/arisaka
	name = "有坂步枪内置弹仓"
	ammo_type = /obj/item/ammo_casing/makeshift/c7758
	caliber = "7758"
	max_ammo = 5
	start_empty = TRUE

/obj/item/ammo_box/speedloader/makeshift/arisaka
	name = "桥夹（7.7×58mm）"
	desc = "用于有坂九九式步枪的五发桥夹。"
	icon_state = "clip"
	ammo_type = /obj/item/ammo_casing/makeshift/c7758
	max_ammo = 5
	start_empty = TRUE
	ammo_box_multiload = AMMO_BOX_MULTILOAD_ALL
	caliber = "7758"

/datum/crafting_bench_recipe/arisaka
	recipe_name = "桥夹（7.7×58mm）"
	recipe_requirements = list(
		/obj/item/stack/sheet/iron = 5,
	)
	resulting_item = /obj/item/ammo_box/speedloader/makeshift/arisaka

/obj/item/gun/ballistic/rifle/boltaction/makeshift/give_manufacturer_examine()
	return

/obj/item/gun/ballistic/rifle/boltaction/makeshift/varmint
	name = "猎鼠步枪"
	desc = "一把自制的小型猎枪, 发射5.56口径弹药, 带有瞄准镜和一体式消音."
	icon_state = "ratslayer"
	inhand_icon_state = "ratslayer"
	worn_icon_state = "ratslayer"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	rack_sound = 'modular_z121/sound/weapons/gunsounds/rifle/rifleback.ogg'
	lock_back_sound = 'modular_z121/sound/weapons/gunsounds/rifle/rifleback.ogg'
	bolt_drop_sound = 'modular_z121/sound/weapons/gunsounds/rifle/rifledrop.ogg'
	load_sound = 'modular_z121/sound/weapons/gunsounds/rifle/riflemag_load.ogg'
	load_empty_sound = 'modular_z121/sound/weapons/gunsounds/rifle/riflemag_load.ogg'
	eject_sound = 'modular_z121/sound/weapons/gunsounds/rifle/riflemag_unload.ogg'
	eject_empty_sound = 'modular_z121/sound/weapons/gunsounds/rifle/riflemag_unload.ogg'
	fire_sound = 'sound/items/weapons/gun/smg/shot_suppressed.ogg'
	fire_delay = 0.6 SECONDS
	rack_delay = 0.6 SECONDS
	projectile_damage_multiplier = 1
	projectile_speed_multiplier = 1.5
	spawnwithmagazine = FALSE
	internal_magazine = FALSE
	spread = 2
	recoil = 0.75
	slowdown = 0.75
	suppressor_x_offset = 0
	suppressor_y_offset = 0
	accepted_magazine_type = /obj/item/ammo_box/magazine/makeshift/c556mm10
	can_unsuppress = FALSE
	can_suppress = TRUE

/obj/item/gun/ballistic/rifle/boltaction/makeshift/varmint/Initialize(mapload)
	. = ..()
	var/obj/item/suppressor/new_suppressor = new(src)
	install_suppressor(new_suppressor)

/obj/item/gun/ballistic/rifle/boltaction/makeshift/varmint/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 2)
