/obj/item/gun/energy/shrink_ray/one_shot
	name = "缩小射线爆破枪"
	desc = "这是一件骇人的外星科技，能在局部空间增强原子的磁引力，使物体暂时缩小。 \
		也可能只是太空魔法。不管怎样，它能把东西缩小，这一把被临时改装成可使用非外星电池。不过它仍然能充能。"
	ammo_type = list(/obj/item/ammo_casing/energy/shrink/worse)

/obj/item/ammo_casing/energy/shrink/worse
	projectile_type = /obj/projectile/magic/shrink/alien
	select_name = "缩小射线"
	e_cost = LASER_SHOTS(1, STANDARD_CELL_CHARGE)

/obj/item/gun/ballistic/automatic/napad
	name = "\improper “纳帕德”冲锋枪"
	desc = "一把配备大容量弹匣的 9 毫米冲锋枪，其上没有任何其他标记，为什么它这么大？"
	icon = 'icons/obj/weapons/guns/ninemmsmg/napad_item.dmi'
	icon_state = "napad"
	worn_icon = 'icons/obj/weapons/guns/ninemmsmg/napad_worn.dmi'
	worn_icon_state = "napad"
	lefthand_file = 'icons/obj/weapons/guns/ninemmsmg/napad_lefthand.dmi'
	righthand_file = 'icons/obj/weapons/guns/ninemmsmg/napad_righthand.dmi'
	inhand_icon_state = "napad"
	special_mags = FALSE
	bolt_type = BOLT_TYPE_LOCKING
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK
	accepted_magazine_type = /obj/item/ammo_box/magazine/napad
	fire_sound = 'sound/items/weapons/gun/rifle/smg_heavy.ogg'
	fire_sound_volume = 80
	can_suppress = FALSE
	burst_size = 1
	fire_delay = 0.55 SECONDS
	actions_types = list()
	projectile_wound_bonus = -10
	projectile_damage_multiplier = 0.65

/obj/item/gun/ballistic/automatic/napad/no_mag
	spawnwithmagazine = FALSE

/obj/item/ammo_box/magazine/napad
	name = "\improper 纳帕德冲锋枪弹匣"
	desc = "冲锋枪用的弹匣，可装填二十五发 9 毫米弹药。"
	icon = 'icons/obj/weapons/guns/ammo.dmi'
	icon_state = "napad_mag"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 25

/obj/item/ammo_box/magazine/napad/spawns_empty
	start_empty = TRUE
