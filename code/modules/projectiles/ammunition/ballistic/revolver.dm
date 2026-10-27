// .357 (Syndie Revolver)

/obj/item/ammo_casing/c357
	name = ".357 子弹壳"
	desc = "一个 .357 子弹壳。"
	caliber = CALIBER_357
	projectile_type = /obj/projectile/bullet/c357
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3)

/obj/item/ammo_casing/c357/spent
	projectile_type = null

/obj/item/ammo_casing/c357/match
	name = ".357 比赛级子弹壳"
	desc = "一种以极高标准的工艺制造的 .357 子弹壳。"
	projectile_type = /obj/projectile/bullet/c357/match

/obj/item/ammo_casing/c357/phasic
	name = ".357 相位子弹壳"
	projectile_type = /obj/projectile/bullet/c357/phasic

/obj/item/ammo_casing/c357/heartseeker
	name = ".357 寻心子弹壳"
	projectile_type = /obj/projectile/bullet/c357/heartseeker

/obj/item/ammo_casing/c357/heartseeker/ready_proj(atom/target, mob/living/user, quiet, zone_override, atom/fired_from)
	. = ..()
	if(!isturf(target))
		loaded_projectile.set_homing_target(target)

// 7.62x38mmR (Nagant Revolver)

/obj/item/ammo_casing/n762
	name = "7.62x38mmR 子弹壳"
	desc = "一个 7.62x38mmR 子弹壳。"
	caliber = CALIBER_N762
	projectile_type = /obj/projectile/bullet/n762

// .38 (Detective's Gun)

/obj/item/ammo_casing/c38
	name = ".38 子弹壳"
	desc = "一个 .38 子弹壳。"
	caliber = CALIBER_38
	projectile_type = /obj/projectile/bullet/c38
	/// Used for icon building for things like speedloaders and the like to determine what kind of sprite this casing uses. Actually accepts any string, just make sure there is a matching positional sprite in _/icons/obj/weapons/guns/ammo.dmi.
	var/lead_or_laser = "lead"

/obj/item/ammo_casing/c38/trac
	name = ".38 TRAC 子弹壳"
	desc = "一个 .38 “TRAC” 子弹壳。"
	projectile_type = /obj/projectile/bullet/c38/trac

/obj/item/ammo_casing/c38/match
	name = ".38 比赛级子弹壳"
	desc = "一种以极高标准的工艺制造的 .38 子弹壳。"
	projectile_type = /obj/projectile/bullet/c38/match

/obj/item/ammo_casing/c38/match/bouncy
	name = ".38 橡胶子弹壳"
	desc = "一种以极其弹跳的标准制造的 .38 橡胶子弹壳。"
	projectile_type = /obj/projectile/bullet/c38/match/bouncy
	harmful = FALSE //SKYRAT EDIT ADDITION

/obj/item/ammo_casing/c38/match/true
	name = ".38 精准打击子弹壳"
	desc = "一个 .38 精准打击子弹壳。"
	projectile_type = /obj/projectile/bullet/c38/match/true

/obj/item/ammo_casing/c38/dumdum
	name = ".38 达姆弹弹壳"
	desc = "一个 .38 达姆弹弹壳。"
	projectile_type = /obj/projectile/bullet/c38/dumdum

/obj/item/ammo_casing/c38/hotshot
	name = ".38 灼热子弹壳"
	desc = "一个 .38 灼热子弹壳。"
	projectile_type = /obj/projectile/bullet/c38/hotshot

/obj/item/ammo_casing/c38/iceblox
	name = ".38 冰封子弹壳"
	desc = "一个 .38 冰封子弹壳。"
	projectile_type = /obj/projectile/bullet/c38/iceblox

/obj/item/ammo_casing/c38/flare
	name = ".38 照明弹壳"
	desc = "一个 .38 照明弹壳。"
	icon_state = "sL-casing"
	projectile_type = /obj/projectile/beam/laser/flare
	lead_or_laser = "laser"

//gatfruit
/obj/item/ammo_casing/pea
	name = "豌豆子弹壳"
	desc = "一颗奇特的豌豆子弹。"
	caliber = CALIBER_PEA
	icon_state = "pea"
	projectile_type = /obj/projectile/bullet/pea
	/// Damage we achieve at 100 potency
	var/max_damage = 15
	/// Damage set by the plant
	var/damage = 15 //max potency, is set

/obj/item/ammo_casing/pea/Initialize(mapload)
	. = ..()
	create_reagents(60, SEALED_CONTAINER)

/obj/item/ammo_casing/pea/ready_proj(atom/target, mob/living/user, quiet, zone_override, atom/fired_from)
	. = ..()
	if(isnull(loaded_projectile))
		return
	loaded_projectile.damage = damage

/obj/item/ammo_casing/pea/attack_self(mob/user)
	. = ..()
	if(isnull(loaded_projectile))
		return
	var/obj/item/food/grown/peas/peas = new(user.drop_location())
	user.put_in_hands(peas)
	to_chat(user, span_notice("你从 [src] 中取出了 [peas]。"))
	loaded_projectile = null
	update_appearance()
