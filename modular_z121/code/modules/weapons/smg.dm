/obj/item/gun/ballistic/automatic/smg/makeshift
	name = "全自动冲锋枪"
	icon = 'modular_z121/icons/weapons/gunz.dmi'
	lefthand_file = 'modular_z121/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_z121/icons/weapons/righthand.dmi'
	worn_icon = 'modular_z121/icons/weapons/worn.dmi'
	bolt_type = BOLT_TYPE_LOCKING
	force = 10
	burst_size = 1

/obj/item/gun/ballistic/automatic/smg/makeshift/american180
	name = ".22冲锋枪"
	desc = "一把消音.22冲锋枪，由枪身顶部的大型弹盘供弹。有趣的武器，适合有趣的人。"
	icon_state = "smg22"
	inhand_icon_state = "smg22"
	worn_icon_state = "smg22"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	accepted_magazine_type = /obj/item/ammo_box/magazine/makeshift/c22smg
	rack_sound = 'modular_z121/sound/weapons/gunsounds/22/22smg_rack.ogg'
	bolt_drop_sound = 'modular_z121/sound/weapons/gunsounds/22/22smg_rack.ogg'
	load_sound = 'modular_z121/sound/weapons/gunsounds/22/22smg_load.ogg'
	load_empty_sound = 'modular_z121/sound/weapons/gunsounds/22/22smg_load.ogg'
	eject_sound = 'modular_z121/sound/weapons/gunsounds/22/22smg_unload.ogg'
	eject_empty_sound = 'modular_z121/sound/weapons/gunsounds/22/22smg_unload.ogg'
	fire_sound = 'modular_z121/sound/weapons/gunsounds/22/22smg.ogg'
	fire_delay = 0.15 SECONDS
	projectile_speed_multiplier = 1.5
	projectile_damage_multiplier = 1
	spawnwithmagazine = FALSE
	spread = 5
	recoil = 0.2
	can_unsuppress = FALSE
	can_suppress = TRUE

/obj/item/gun/ballistic/automatic/smg/makeshift/american180/Initialize(mapload)
	. = ..()
	var/obj/item/suppressor/new_suppressor = new(src)
	install_suppressor(new_suppressor)

/obj/item/gun/ballistic/automatic/smg/makeshift/Initialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/smg/makeshift/give_manufacturer_examine()
	return

/obj/item/gun/ballistic/automatic/smg/makeshift/m3
	name = "M3冲锋枪"
	desc = "一把射速很快的老式9mm冲锋枪。单发威力不大，但如此迅猛的火力足以弥补。"
	icon_state = "smg9mm"
	inhand_icon_state = "smg9mm"
	worn_icon_state = "smg9mm"
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	accepted_magazine_type = /obj/item/ammo_box/magazine/makeshift/m3
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	rack_sound = 'modular_z121/sound/weapons/gunsounds/10mmsmg/smgrack.ogg'
	bolt_drop_sound = 'modular_z121/sound/weapons/gunsounds/10mmsmg/smgrack.ogg'
	load_sound = 'modular_z121/sound/weapons/gunsounds/10mmsmg/smgload.ogg'
	load_empty_sound = 'modular_z121/sound/weapons/gunsounds/10mmsmg/smgload.ogg'
	eject_sound = 'modular_z121/sound/weapons/gunsounds/10mmsmg/smgunload.ogg'
	eject_empty_sound = 'modular_z121/sound/weapons/gunsounds/10mmsmg/smgunload.ogg'
	fire_sound = 'modular_z121/sound/weapons/greasegun.ogg'
	fire_delay = 0.2 SECONDS
	projectile_speed_multiplier = 1.5
	projectile_damage_multiplier = 0.8
	spawnwithmagazine = FALSE
	spread = 15
	recoil = 0.45
	force = 10

/obj/item/gun/ballistic/automatic/smg/newtech
	name = "全自动冲锋枪"
	icon = 'modular_z121/icons/weapons/gunz.dmi'
	lefthand_file = 'modular_z121/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_z121/icons/weapons/righthand.dmi'
	worn_icon = 'modular_z121/icons/weapons/worn.dmi'
	bolt_type = BOLT_TYPE_LOCKING
	force = 10
	burst_size = 1
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

/obj/item/gun/ballistic/automatic/smg/newtech/Initialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/smg/newtech/give_manufacturer_examine()
	return


/obj/item/gun/ballistic/automatic/smg/newtech/hksmg
	name = "新锐AP-5冲锋枪"
	desc = "一把可靠的大容量冲锋枪。其主要特点是子弹初速高，能够穿透军用防弹装备。"
	icon = 'modular_z121/icons/weapons/guns.dmi'
	icon_state = "hksmg"
	inhand_icon_state = "hksmg"
	worn_icon_state = "hksmgs"
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	accepted_magazine_type = /obj/item/ammo_box/magazine/makeshift/hksmg
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	rack_sound = 'modular_z121/sound/weapons/hksmg_rack.wav'
	bolt_drop_sound = 'modular_z121/sound/weapons/hksmg_rack.wav'
	load_sound = 'modular_z121/sound/weapons/hksmg_magin.wav'
	load_empty_sound = 'modular_z121/sound/weapons/hksmg_magin.wav'
	eject_sound = 'modular_z121/sound/weapons/hksmg_magout.wav'
	eject_empty_sound = 'modular_z121/sound/weapons/hksmg_magout.wav'
	fire_sound = 'modular_z121/sound/weapons/hksmg.wav'
	suppressed_sound = 'modular_z121/sound/weapons/hksmg_silenced.ogg'
	fire_delay = 0.2 SECONDS
	projectile_speed_multiplier = 1.7
	projectile_damage_multiplier = 0.75
	spawnwithmagazine = FALSE
	spread = 7
	recoil = 0.5
	force = 10
//	shots_before_degradation = 20
//	max_shots_before_degradation = 20
//	degradation_stage = 0
//	degradation_stage_max = 10
//	degradation_probability = 25
//	maximum_speed_malus = 0.7
