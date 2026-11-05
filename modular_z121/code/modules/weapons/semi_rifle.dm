/obj/item/gun/ballistic/rifle/makeshift
	name = "步枪"
	icon = 'modular_z121/icons/weapons/gunz.dmi'
	worn_icon = 'modular_z121/icons/weapons/worn.dmi'
	lefthand_file = 'modular_z121/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_z121/icons/weapons/righthand.dmi'
	internal_magazine = FALSE
	tac_reloads = FALSE
	slot_flags = ITEM_SLOT_SUITSTORE
	force = 15
	wound_bonus = 0

/obj/item/gun/ballistic/rifle/makeshift/battlerifle
	name = "简易加兰德步枪"
	desc = "一把仿制的加兰德步枪, 发射.308口径弹药."
	icon_state = "battlerifle"
	inhand_icon_state = "battlerifle"
	worn_icon_state = "battler"
	bolt_type = BOLT_TYPE_STANDARD
	semi_auto = TRUE
	internal_magazine = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/makeshift/c308
	fire_sound = 'modular_z121/sound/weapons/battlerifle.ogg'
	eject_empty_sound = 'modular_z121/sound/weapons/battlerifleunload.ogg'
	eject_sound = 'modular_z121/sound/weapons/battlerifleunload.ogg'
	rack_sound = 'modular_z121/sound/weapons/gunsounds/battle_rifle/battle_rack.ogg'
	bolt_drop_sound = 'modular_z121/sound/weapons/gunsounds/battle_rifle/battle_rack.ogg'
	recoil = 1.75
	spread = 5
	fire_delay = 8
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	spawnwithmagazine = FALSE
	projectile_speed_multiplier = 1.5
	projectile_damage_multiplier = 1

/obj/item/gun/ballistic/rifle/makeshift/give_manufacturer_examine()
	return

/obj/item/gun/ballistic/rifle/makeshift/service
	name = "简易AR-15步枪"
	desc = "一把仿制的AR-15步枪, 发射5.56mm口径弹药."
	icon_state = "service"
	inhand_icon_state = "service"
	worn_icon_state = "service"
	bolt_type = BOLT_TYPE_LOCKING
	semi_auto = TRUE
	internal_magazine = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/makeshift/c556mm10
	rack_sound = 'modular_z121/sound/weapons/gunsounds/service/ar_rack.ogg'
	bolt_drop_sound = 'modular_z121/sound/weapons/gunsounds/service/ar_rack.ogg'
	load_sound = 'modular_z121/sound/weapons/gunsounds/service/ar_load.ogg'
	load_empty_sound = 'modular_z121/sound/weapons/gunsounds/service/ar_load.ogg'
	eject_sound = 'modular_z121/sound/weapons/gunsounds/service/ar_unload.ogg'
	eject_empty_sound = 'modular_z121/sound/weapons/gunsounds/service/ar_unload.ogg'
	fire_sound = 'modular_z121/sound/weapons/gunsounds/service/service_3.ogg'
	recoil = 0.75
	spread = 5
	fire_delay = 0.45 SECONDS
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	spawnwithmagazine = FALSE
	special_mags = TRUE
	projectile_speed_multiplier = 1.5
	projectile_damage_multiplier = 0.6

/obj/item/gun/ballistic/rifle/makeshift/service/prototype
	name = "简易M16步枪"
	desc = "一把仿制的M16步枪, 发射5.56mm口径弹药, 可以进行全自动改装."
	icon_state = "protoservice"
	inhand_icon_state = "protoservice"
	worn_icon_state = "protoservice"
	fire_sound = 'modular_z121/sound/weapons/gunsounds/service/service_2.ogg'
	spread = 10
	fire_delay = 1 SECONDS
	burst_size = 3
	recoil = 1.5

/obj/item/gun/ballistic/rifle/makeshift/sniper
	name = "简易狙击步枪"
	desc = "一把独特的狙击步枪, 发射.308口径弹药."
	icon_state = "sniper"
	inhand_icon_state = "sniper"
	worn_icon_state = "sniper"
	bolt_type = BOLT_TYPE_LOCKING
	semi_auto = TRUE
	internal_magazine = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/makeshift/c30810
	rack_sound = 'modular_z121/sound/weapons/gunsounds/sniper/sniperrack.ogg'
	bolt_drop_sound = 'modular_z121/sound/weapons/gunsounds/sniper/sniperrack.ogg'
	load_sound = 'modular_z121/sound/weapons/gunsounds/battle_rifle/battle_load.ogg' //placeholder
	load_empty_sound = 'modular_z121/sound/weapons/gunsounds/battle_rifle/battle_load.ogg' //placeholder
	eject_sound = 'modular_z121/sound/weapons/gunsounds/battle_rifle/battle_unload.ogg' //placeholder
	eject_empty_sound = 'modular_z121/sound/weapons/gunsounds/battle_rifle/battle_unload.ogg' //placeholder
	fire_sound = 'modular_z121/sound/weapons/gunsounds/sniper/sniper2.ogg'
	recoil = 2
	spread = 5
	fire_delay = 2 SECONDS
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	spawnwithmagazine = FALSE
	projectile_speed_multiplier = 1.5
	projectile_damage_multiplier = 1

/obj/item/gun/ballistic/rifle/makeshift/sniper/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 4)

/obj/item/gun/ballistic/rifle/makeshift/sniper/silencer
	name = "简易消音步枪"
	desc = "一把经过了改装的狙击步枪, 发射.308口径弹药."
	icon_state = "silentsniper"
	inhand_icon_state = "silentsniper"
	fire_delay = 1.75 SECONDS
	recoil = 1.5
	projectile_speed_multiplier = 1
	projectile_damage_multiplier = 1
	fire_sound = 'sound/items/weapons/gun/smg/shot_suppressed.ogg'

/obj/item/gun/ballistic/rifle/makeshift/sniper/silencer/Initialize(mapload)
	. = ..()
	var/obj/item/suppressor/new_suppressor = new(src)
	install_suppressor(new_suppressor)
