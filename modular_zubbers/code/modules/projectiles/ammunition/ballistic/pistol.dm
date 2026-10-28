/obj/item/ammo_casing/caseless/c22hl
	caliber = ENERGY
	projectile_type = /obj/projectile/bullet/c22hl

/obj/item/ammo_casing/caseless/c22hl/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/item/ammo_casing/caseless/c22hl/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(isturf(loc))
		qdel(src)

/obj/projectile/bullet/c22hl //.22 HL
	name = "硬光光束"
	icon = 'modular_zubbers/icons/obj/weapons/guns/projectiles.dmi'
	icon_state = "disabler_bullet"
	armor_flag = ENERGY
	damage = 1 //ouch ouch my skin ouchie
	damage_type = BURN
	sharpness = NONE
	embed_type = null
	shrapnel_type = null
	stamina = 20

/obj/item/ammo_casing/caseless/c22ls
	caliber = LASER
	projectile_type = /obj/projectile/bullet/c22ls

/obj/item/ammo_casing/caseless/c22ls/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/item/ammo_casing/caseless/c22ls/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(isturf(loc))
		qdel(src)

/obj/projectile/bullet/c22ls //.22LS
	name = "激光束"
	icon = 'modular_zubbers/icons/obj/weapons/guns/projectiles.dmi'
	icon_state = "disabler_bullet"
	armor_flag = LASER
	damage = 18
	damage_type = BURN
	color = "#ff0000"
	wound_bonus = -15
	exposed_wound_bonus = 5
	embed_type = null
	shrapnel_type = null

/obj/item/ntusp_conversion_kit
	name = "NT22-HCS 改装套件"
	desc = "标准改装套件，用于将 NT22-HCS 弹匣改装为更致命或更不致命的模式。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/usp_modkit.dmi'
	icon_state = "modkit_ntusp"
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/recharge/ntusp/attackby(obj/item/A, mob/user)
	if(istype(A, /obj/item/ntusp_conversion_kit))
		to_chat(user, span_danger("[A]发出嗡鸣声，改装了\the [src]的透镜，使其能够制造更致命的弹药。"))
		new /obj/item/ammo_box/magazine/recharge/ntusp/laser/empty(get_turf(src)) // you thought you were getting free bullets?
		qdel(src)
	else
		return ..()

/obj/item/ammo_box/magazine/recharge/ntusp/laser/attackby(obj/item/A, mob/user)
	if(istype(A, /obj/item/ntusp_conversion_kit))
		to_chat(user, span_notice("[A]发出嗡鸣声，改装了\the [src]的透镜，使其能够制造更不致命的弹药。"))
		new /obj/item/ammo_box/magazine/recharge/ntusp/empty(get_turf(src))
		qdel(src)
	else
		return ..()

/obj/item/gun/ballistic/automatic/pistol/ntusp/update_icon()
	icon_state = initial(icon_state)
	if(istype(magazine, /obj/item/ammo_box/magazine/recharge/ntusp/laser))
		icon_state = "ntusp-l"
	..()

/obj/item/ammo_casing/c38/c32 //They will never know
	name = ".32 子弹壳"
	desc = "一枚 .32 子弹壳。"
	projectile_type = /obj/projectile/bullet/c38/c32
	caliber = CALIBER_32

/obj/item/ammo_casing/c38/c32/spent
	projectile_type = null

/obj/projectile/bullet/c38/c32
	name = ".32 子弹"
