/obj/item/gun/ballistic/automatic/rifle/makeshift
	name = "全自动冲锋枪"
	icon = 'modular_z121/icons/weapons/gunz.dmi'
	lefthand_file = 'modular_z121/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_z121/icons/weapons/righthand.dmi'
	worn_icon = 'modular_z121/icons/weapons/worn.dmi'
	bolt_type = BOLT_TYPE_LOCKING
	force = 10
	burst_size = 1

/obj/item/gun/ballistic/automatic/rifle/makeshift/m16stripped
	name = "改装M16步枪"
	desc = "一把经过了大量改装的M16步枪, 发射5.56mm口径弹药, 可以进行全自动射击."
	icon_state = "m16stripped"
	inhand_icon_state = "m16stripped"
	worn_icon_state = "m16stripped"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	accepted_magazine_type = /obj/item/ammo_box/magazine/makeshift/c556mm10
	rack_sound = 'modular_z121/sound/weapons/gunsounds/service/ar_rack.ogg'
	bolt_drop_sound = 'modular_z121/sound/weapons/gunsounds/service/ar_rack.ogg'
	load_sound = 'modular_z121/sound/weapons/gunsounds/service/ar_load.ogg'
	load_empty_sound = 'modular_z121/sound/weapons/gunsounds/service/ar_load.ogg'
	eject_sound = 'modular_z121/sound/weapons/gunsounds/service/ar_unload.ogg'
	eject_empty_sound = 'modular_z121/sound/weapons/gunsounds/service/ar_unload.ogg'
	fire_sound = 'modular_z121/sound/weapons/gunsounds/service/service_3.ogg'
	recoil = 1
	spread = 25
	fire_delay = 0.2 SECONDS
	projectile_speed_multiplier = 1.2
	projectile_damage_multiplier = 0.55
	spawnwithmagazine = FALSE
	special_mags = TRUE

/obj/item/gun/ballistic/automatic/rifle/makeshift/Initialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/rifle/newtech
	worn_icon = 'modular_z121/icons/weapons/worn.dmi'
	bolt_type = BOLT_TYPE_LOCKING
	lefthand_file = 'modular_z121/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_z121/icons/weapons/righthand.dmi'
	icon = 'modular_z121/icons/weapons/guns.dmi'
//	var/jammed = FALSE
//	var/unjam_chance = 25
//	/// Determines how many shots we can make before the weapon needs to be maintained.
//	var/shots_before_degradation = 5
//	/// The max number of allowed shots this gun can have before degradation.
//	var/max_shots_before_degradation = 5
//	/// Determines the degradation stage. The higher the value, the more poorly the weapon performs.
//	var/degradation_stage = 0
//	/// Maximum degradation stage.
//	var/degradation_stage_max = 5
//	/// The probability of degradation increasing per shot.
//	var/degradation_probability = 25
//	/// The maximum speed malus for projectile flight speed. Projectiles probably shouldn't move too slowly or else they will start to cause problems.
//	var/maximum_speed_malus = 0.7

/obj/item/gun/ballistic/automatic/rifle/newtech/steyr
	name = "ACR原型镖弹突击步枪"
	desc = "一把独特的枪械，枪身几乎由一整块材料制成，枪管贯穿其中。发射钢制SCF镖弹。"
	icon = 'modular_z121/icons/weapons/guns.dmi'
	icon_state = "steyr"
	inhand_icon_state = "steyr"
	worn_icon_state = "steyr"
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	semi_auto = TRUE
	accepted_magazine_type = /obj/item/ammo_box/magazine/makeshift/nikonov
	rack_sound = 'modular_z121/sound/weapons/g3_rack.wav'
	bolt_drop_sound = 'modular_z121/sound/weapons/g3_rack.wav'
	load_sound = 'modular_z121/sound/weapons/g3_magin.wav'
	load_empty_sound = 'modular_z121/sound/weapons/g3_magin.wav'
	eject_sound = 'modular_z121/sound/weapons/g3_magout.wav'
	eject_empty_sound = 'modular_z121/sound/weapons/g3_magout.wav'
	fire_sound = 'modular_z121/sound/weapons/steyr.wav'
	suppressed_sound = 'modular_z121/sound/weapons/steyr_silenced.wav'
	recoil = 0.75
	spread = 5
	bolt_type = BOLT_TYPE_LOCKING
	fire_delay = 0.75 SECONDS
	suppressor_x_offset = 7
	can_suppress = TRUE
	projectile_speed_multiplier = 1.5
	projectile_damage_multiplier = 1
	spawnwithmagazine = FALSE
	burst_size = 3
//	shots_before_degradation = 15
//	max_shots_before_degradation = 15
//	degradation_stage = 0
//	degradation_stage_max = 10
//	degradation_probability = 10
//	maximum_speed_malus = 0.7

/obj/item/gun/ballistic/automatic/rifle/newtech/g3
	name = "虚空国际G3型7.62mm突击步枪"
	desc = "一把看起来有些融化、又有些像巧克力的7.62mm突击步枪，仿佛搅拌一下就能浇在吐司或海鲜上。"
	icon = 'modular_z121/icons/weapons/guns.dmi'
	icon_state = "g3"
	inhand_icon_state = "g3"
	worn_icon_state = "g3"
	semi_auto = TRUE
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK
	accepted_magazine_type = /obj/item/ammo_box/magazine/makeshift/g3
	rack_sound = 'modular_z121/sound/weapons/g3_rack.wav'
	bolt_drop_sound = 'modular_z121/sound/weapons/g3_rack.wav'
	load_sound = 'modular_z121/sound/weapons/g3_magin.wav'
	load_empty_sound = 'modular_z121/sound/weapons/g3_magin.wav'
	eject_sound = 'modular_z121/sound/weapons/g3_magout.wav'
	eject_empty_sound = 'modular_z121/sound/weapons/g3_magout.wav'
	fire_sound = 'modular_z121/sound/weapons/g3.wav'
	suppressed_sound = 'modular_z121/sound/weapons/g3_silenced.wav'
	recoil = 2.5
	bolt_type = BOLT_TYPE_LOCKING
	spread = 7.5
	fire_delay = 1.25 SECONDS
	can_suppress = TRUE
	suppressor_x_offset = 10
	projectile_speed_multiplier = 1.2
	projectile_damage_multiplier = 0.8
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/rifle/newtech/g3/Initialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/rifle/newtech/g3/give_manufacturer_examine()
	return
//	shots_before_degradation = 1
//	max_shots_before_degradation = 1
//	degradation_stage = 0
//	degradation_stage_max = 10
//	degradation_probability = 25
//	maximum_speed_malus = 0.7


/obj/item/gun/ballistic/automatic/rifle/newtech/nikonov
	name = "AN-94型5.45x39mm原型突击步枪"
	desc = "一把神秘的布尔什维克步枪，为满足红军精锐对全自动制式步枪的需求而诞生。\
		枪口制退器似乎还兼容消音器！真不错。"
	icon = 'modular_z121/icons/weapons/guns.dmi'
	icon_state = "nikonov"
	inhand_icon_state = "nikonov"
	worn_icon_state = "nikonov"
	semi_auto = TRUE
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	accepted_magazine_type = /obj/item/ammo_box/magazine/makeshift/nikonov
	rack_sound = 'modular_z121/sound/weapons/akrack.wav'
	bolt_drop_sound = 'modular_z121/sound/weapons/akrack.wav'
	load_sound = 'modular_z121/sound/weapons/akmagin.wav'
	load_empty_sound = 'modular_z121/sound/weapons/akmagin.wav'
	eject_sound = 'modular_z121/sound/weapons/akmagout.wav'
	eject_empty_sound = 'modular_z121/sound/weapons/akmagout.wav'
	fire_sound = 'modular_z121/sound/weapons/ak.wav'
	suppressed_sound = 'modular_z121/sound/weapons/ak_silenced.wav'
	recoil = 1
	bolt_type = BOLT_TYPE_LOCKING
	spread = 0
	fire_delay = 0.65 SECONDS
	can_suppress = TRUE
	suppressor_x_offset = 10
	projectile_speed_multiplier = 1.2
	projectile_damage_multiplier = 1
	spawnwithmagazine = FALSE
	burst_size = 2
//	shots_before_degradation = 10
//	max_shots_before_degradation = 10
//	degradation_stage = 0
//	degradation_stage_max = 10
//	degradation_probability = 10
//	maximum_speed_malus = 0.7

/obj/item/gun/ballistic/automatic/rifle/newtech/nikonov/Initialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/rifle/newtech/nikonov/give_manufacturer_examine()
	return
