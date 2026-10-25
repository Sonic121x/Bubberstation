// 10mm

/obj/item/ammo_casing/c10mm
	name = "10mm 子弹壳"
	desc = "一个 10mm 子弹壳。"
	caliber = CALIBER_10MM
	projectile_type = /obj/projectile/bullet/c10mm
	newtonian_force = 0.75

/obj/item/ammo_casing/c10mm/ap
	name = "10mm 穿甲子弹壳"
	desc = "一个 10mm 穿甲子弹壳。"
	projectile_type = /obj/projectile/bullet/c10mm/ap

/obj/item/ammo_casing/c10mm/hp
	name = "10mm 空尖子弹壳"
	desc = "一个 10mm 空尖子弹壳。"
	projectile_type = /obj/projectile/bullet/c10mm/hp

/obj/item/ammo_casing/c10mm/fire
	name = "10mm 燃烧子弹壳"
	desc = "一个 10mm 燃烧子弹壳。"
	projectile_type = /obj/projectile/bullet/incendiary/c10mm

// 9mm (Makarov, Stechkin APS)

/obj/item/ammo_casing/c9mm
	name = "9mm 子弹壳"
	desc = "一个 9mm 子弹壳。"
	caliber = CALIBER_9MM
	projectile_type = /obj/projectile/bullet/c9mm
	newtonian_force = 0.75
//BUBBERSTAION ADDITION
/obj/item/ammo_casing/c9mm/security
	name = "9mm 安保子弹壳"
	desc = "一个 9mm 安保子弹壳。"
	caliber = CALIBER_9MM
	projectile_type = /obj/projectile/bullet/c9mm/security
	newtonian_force = 0.75
// BUBBBER EDIT END
/obj/item/ammo_casing/c9mm/ap
	name = "9mm 穿甲子弹壳"
	desc = "一个 9mm 穿甲子弹壳。"
	projectile_type =/obj/projectile/bullet/c9mm/ap

/obj/item/ammo_casing/c9mm/hp
	name = "9mm 空尖子弹壳"
	desc = "一个 9mm 空尖子弹壳。"
	projectile_type = /obj/projectile/bullet/c9mm/hp

/obj/item/ammo_casing/c9mm/fire
	name = "9mm 燃烧子弹壳"
	desc = "一个 9mm 燃烧子弹壳。"
	projectile_type = /obj/projectile/bullet/incendiary/c9mm

// .50AE (Desert Eagle)

/obj/item/ammo_casing/a50ae
	name = ".50AE 子弹壳"
	desc = "一个 .50AE 子弹壳。"
	caliber = CALIBER_50AE
	projectile_type = /obj/projectile/bullet/a50ae

// .160 Smart (Abielle smartgun)

/obj/item/ammo_casing/c160smart
	name = ".160 智能子弹壳"
	desc = "一颗 .160 智能子弹，底部装有一小份助推发射药。"
	icon_state = "smartgun_casing"
	caliber = CALIBER_160SMART
	projectile_type = /obj/projectile/bullet/c160smart
	/// How many tiles away should we check for smart auto-locking
	var/auto_lock_range = 2

/obj/item/ammo_casing/c160smart/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/item/ammo_casing/c160smart/ready_proj(atom/target, mob/living/user, quiet, zone_override, atom/fired_from)
	. = ..()
	if(!isturf(target))
		loaded_projectile.set_homing_target(target)
		new /obj/effect/temp_visual/smartgun_target(get_turf(target))
	else
		var/atom/aimbot_target = locate(/mob/living) in range(auto_lock_range, target)
		if(aimbot_target)
			loaded_projectile.set_homing_target(aimbot_target)
			new /obj/effect/temp_visual/smartgun_target(get_turf(aimbot_target))

/obj/effect/temp_visual/smartgun_target
	name = "智能枪目标准星"
	desc = "一个全息准星，大概意味着你该赶紧跑了。"
	icon_state = "launchpad_pull"
	duration = 0.25 SECONDS
