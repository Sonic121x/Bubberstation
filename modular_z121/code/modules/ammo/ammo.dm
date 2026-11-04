/obj/item/ammo_casing/c9mm/makeshift
	name = "9mm简易弹药"
	desc = "一发简易制作的9mm弹药。"
	caliber = CALIBER_9MM
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "pistol-brass"
	base_icon_state = "pistol-brass"
	projectile_type = /obj/projectile/bullet/c9mm/makeshift
//	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/makeshift/c9mm

/obj/item/ammo_box/magazine/ammo_stack/makeshift/c9mm
	name = "9mm简易弹药堆"
	desc = "一堆简易制作的9mm弹药。"
	caliber = CALIBER_9MM
	ammo_type = /obj/item/ammo_casing/c9mm/makeshift
	casing_phrasing = "弹药"
	max_ammo = 10
//	casing_w_spacing = 3
//	casing_z_padding = 4

/obj/projectile/bullet/c9mm/makeshift
	name = "9mm简易子弹"
	icon = 'modular_z121/icons/ammo/projectile.dmi'
	icon_state = "merehandgun_bullet"
	damage = 10
	wound_bonus = -25
	exposed_wound_bonus = 5
	speed = 1
	armour_penetration = 0
	embed_type = null
	sharpness = SHARP_POINTY

/obj/item/ammo_casing/makeshift/c22
	name = ".22简易弹药"
	desc = "一发简易制作的.22弹药。"
	caliber = ".22"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "pistol-brass"
	base_icon_state = "pistol-brass"
	projectile_type = /obj/projectile/bullet/c22
//	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/makeshift/c22

/obj/item/ammo_box/magazine/ammo_stack/makeshift/c22
	name = ".22简易弹药堆"
	desc = "一堆简易制作的.22弹药。"
	caliber = ".22"
	ammo_type = /obj/item/ammo_casing/makeshift/c22
	casing_phrasing = "弹药"
	max_ammo = 15
//	casing_w_spacing = 3
//	casing_z_padding = 4

/obj/projectile/bullet/c22
	name = ".22简易子弹"
	icon = 'modular_z121/icons/ammo/projectile.dmi'
	icon_state = "bb"
	damage = 5
	wound_bonus = 25
	exposed_wound_bonus = 5
	speed = 1
	armour_penetration = 0
	embed_type = null
	sharpness = SHARP_POINTY
	var/bonus_damage = 10

/obj/item/ammo_casing/makeshift/c7758
	name = "7.7x58mm简易弹药"
	desc = "一发简易制作的7.7x58mm弹药。"
	caliber = "7758"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "rifle-brass"
	base_icon_state = "rifle-brass"
	projectile_type = /obj/projectile/bullet/c7758
//	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/makeshift/c7758

/obj/item/ammo_box/magazine/ammo_stack/makeshift/c7758
	name = "7.7x58mm简易弹药堆"
	desc = "一堆简易制作的7.7x58mm弹药。"
	caliber = "7758"
	ammo_type = /obj/item/ammo_casing/makeshift/c7758
	casing_phrasing = "弹药"
	max_ammo = 8
//	casing_w_spacing = 3
//	casing_z_padding = 4

/obj/projectile/bullet/c7758
	name = "7.7x58mm简易子弹"
	icon = 'modular_z121/icons/ammo/projectile.dmi'
	icon_state = "medium_bullet"
	damage = 30
	wound_bonus = 10
	exposed_wound_bonus = 5
	speed = 1
	armour_penetration = 25
	embed_type = null
	sharpness = SHARP_POINTY

/obj/item/ammo_casing/makeshift/c308
	name = ".308简易弹药"
	desc = "一发简易制作的.308弹药。"
	caliber = ".308"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "rifle-brass"
	base_icon_state = "rifle-brass"
	projectile_type = /obj/projectile/bullet/c308
//	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/makeshift/c308

/obj/item/ammo_box/magazine/ammo_stack/makeshift/c308
	name = ".308简易弹药堆"
	desc = "一堆简易制作的.308弹药。"
	caliber = ".308"
	ammo_type = /obj/item/ammo_casing/makeshift/c308
	casing_phrasing = "弹药"
	max_ammo = 8
//	casing_w_spacing = 3
//	casing_z_padding = 4

/obj/projectile/bullet/c308
	name = ".308简易子弹"
	icon = 'modular_z121/icons/ammo/projectile.dmi'
	icon_state = "medium_bullet"
	damage = 20
	wound_bonus = 10
	exposed_wound_bonus = 5
	speed = 1
	armour_penetration = 25
	embed_type = null
	sharpness = SHARP_POINTY

/obj/item/ammo_casing/shotgun/birdshot
	name = "12号简易鸟弹"
	desc = "一发简易制作的12号鸟弹，可以用来猎鸟，也可以用来猎人。"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "birdshot"
	base_icon_state = "birdshot"
	caliber = CALIBER_SHOTGUN
	pellets = 6
	variance = 20
	projectile_type = /obj/projectile/bullet/pellet/birdshot
//	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/makeshift/birdshot

/obj/item/ammo_box/magazine/ammo_stack/makeshift/birdshot
	name = "12号简易鸟弹堆"
	desc = "一堆简易制作的12号鸟弹。"
	caliber = CALIBER_SHOTGUN
	ammo_type = /obj/item/ammo_casing/shotgun/birdshot
	casing_phrasing = "霰弹"
	max_ammo = 8
//	casing_w_spacing = 3
//	casing_z_padding = 4

/obj/projectile/bullet/pellet/birdshot
	name = "12号鸟弹弹丸"
	icon = 'modular_z121/icons/ammo/projectile.dmi'
	icon_state = "buckshot"
	damage = 7
	wound_bonus = -25
	exposed_wound_bonus = 25
	speed = 1
	range = 8
	armour_penetration = -50
	sharpness = SHARP_POINTY
	embed_type = null
	ricochets_max = 1
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8

/datum/embedding/bullet/birdshot
	embed_chance = 25
	fall_chance = 2
	jostle_chance = 2
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 3
	jostle_pain_mult = 5
	rip_time = 1 SECONDS

/obj/item/ammo_casing/makeshift/c556mm
	name = "5.56x45mm简易弹药"
	desc = "一发简易制作的5.56x45mm弹药。"
	caliber = "5.56x45"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "rifle-brass"
	base_icon_state = "rifle-brass"
	projectile_type = /obj/projectile/bullet/c556mm
//	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/makeshift/c556mm

/obj/item/ammo_box/magazine/ammo_stack/makeshift/c556mm
	name = "5.56x45mm简易弹药堆"
	desc = "一堆简易制作的5.56x45mm弹药。"
	caliber = "5.56x45"
	ammo_type = /obj/item/ammo_casing/makeshift/c556mm
	casing_phrasing = "弹药"
	max_ammo = 8
//	casing_w_spacing = 3
//	casing_z_padding = 4

/obj/projectile/bullet/c556mm
	name = "5.56x45mm简易子弹"
	icon = 'modular_z121/icons/ammo/projectile.dmi'
	icon_state = "medium_bullet"
	damage = 20
	wound_bonus = -30
	exposed_wound_bonus = 5
	speed = 1
	armour_penetration = 25
	embed_type = null
	sharpness = SHARP_POINTY

/obj/item/ammo_casing/makeshift/c762
	name = "7.62x51mm简易弹药"
	desc = "一发简易制作的7.62x51mm弹药。"
	caliber = "7.62x51"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "rifle-brass"
	base_icon_state = "rifle-brass"
	projectile_type = /obj/projectile/bullet/c762
//	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/makeshift/c762

/obj/item/ammo_box/magazine/ammo_stack/makeshift/c762
	name = "7.62x51mm简易弹药堆"
	desc = "一堆简易制作的7.62x51mm弹药。"
	caliber = "7.62x51"
	ammo_type = /obj/item/ammo_casing/makeshift/c762
	casing_phrasing = "弹药"
	max_ammo = 8
//	casing_w_spacing = 3
//	casing_z_padding = 4

/obj/projectile/bullet/c762
	name = "7.62x51mm简易子弹"
	icon = 'modular_z121/icons/ammo/projectile.dmi'
	icon_state = "medium_bullet"
	damage = 20
	wound_bonus = -30
	exposed_wound_bonus = 5
	speed = 1
	armour_penetration = 45
	embed_type = null
	sharpness = SHARP_POINTY

/obj/item/ammo_casing/makeshift/c57
	name = "5.7x28mm简易弹药"
	desc = "一发简易制作的5.7x28mm弹药。"
	caliber = "5.7x28"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "appistol-brass"
	base_icon_state = "appistol-brass"
	projectile_type = /obj/projectile/bullet/c57
//	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/makeshift/c57

/obj/item/ammo_box/magazine/ammo_stack/makeshift/c57
	name = "5.7x28mm简易弹药堆"
	desc = "一堆简易制作的5.7x28mm弹药。"
	caliber = "5.7x28"
	ammo_type = /obj/item/ammo_casing/makeshift/c57
	casing_phrasing = "弹药"
	max_ammo = 8
//	casing_w_spacing = 3
//	casing_z_padding = 4

/obj/projectile/bullet/c57
	name = "5.7x28mm简易子弹"
	icon = 'modular_z121/icons/ammo/projectile.dmi'
	icon_state = "medium_bullet"
	damage = 12
	wound_bonus = -40
	exposed_wound_bonus = 5
	speed = 1
	armour_penetration = 25
	embed_type = null
	sharpness = SHARP_POINTY

/obj/item/ammo_casing/makeshift/c556flechette
	name = "5.56x45mm环形底火SCF镖弹"
	desc = "一发采用环形底火的5.56x45mm SCF镖弹。"
	caliber = "5.56x45 flechette"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "aprifle-steel"
	base_icon_state = "aprifle-steel"
	projectile_type = /obj/projectile/bullet/c556flechette
//	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/makeshift/c556flechette

/obj/item/ammo_box/magazine/ammo_stack/makeshift/c556flechette
	name = "5.56x45mm环形底火SCF镖弹堆"
	desc = "一堆采用环形底火的5.56x45mm SCF镖弹。"
	caliber = "5.56x45 flechette"
	ammo_type = /obj/item/ammo_casing/makeshift/c556flechette
	casing_phrasing = "弹药"
	max_ammo = 8
//	casing_w_spacing = 3
//	casing_z_padding = 4

/obj/projectile/bullet/c556flechette
	name = "5.56x45mm SCF镖弹弹丸"
	icon = 'modular_z121/icons/ammo/projectile.dmi'
	icon_state = "medium_bullet"
	damage = 15
	wound_bonus = 25
	exposed_wound_bonus = 25
	speed = 1
	armour_penetration = 10
	embed_type = null
	sharpness = SHARP_POINTY

/obj/item/ammo_casing/makeshift/c545
	name = "5.45x39mm弹药"
	desc = "一发5.45x39mm弹药。"
	caliber = "5.45x39"
	icon = 'modular_z121/icons/ammo/ammo.dmi'
	icon_state = "rifle-brass"
	base_icon_state = "rifle-brass"
	projectile_type = /obj/projectile/bullet/c556flechette
//	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/makeshift/c545

/obj/item/ammo_box/magazine/ammo_stack/makeshift/c545
	name = "5.45x39mm弹药堆"
	desc = "一堆5.45x39mm弹药。"
	caliber = "5.56x45 flechette"
	ammo_type = /obj/item/ammo_casing/makeshift/c545
	casing_phrasing = "弹药"
	max_ammo = 8
//	casing_w_spacing = 3
//	casing_z_padding = 4

/obj/projectile/bullet/c545
	name = "5.45x39mm子弹"
	icon = 'modular_z121/icons/ammo/projectile.dmi'
	icon_state = "medium_bullet"
	damage = 15
	wound_bonus = 5
	exposed_wound_bonus = 5
	speed = 1
	armour_penetration = 20
	embed_type = null
	sharpness = SHARP_POINTY
