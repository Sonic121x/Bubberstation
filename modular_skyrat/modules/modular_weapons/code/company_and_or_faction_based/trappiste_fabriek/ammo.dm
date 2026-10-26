// .585 Trappiste
// High caliber round used in large pistols and revolvers

/obj/item/ammo_casing/c585trappiste
	name = ".585特拉比斯特致命弹"
	desc = "一种使用白色聚合物弹壳的大口径弹药，常用于手枪。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/ammo.dmi'
	icon_state = "585trappiste"

	caliber = CALIBER_585TRAPPISTE
	projectile_type = /obj/projectile/bullet/c585trappiste

/obj/projectile/bullet/c585trappiste
	name = ".585特拉比斯特子弹"
	damage = 45
	wound_bonus = 0 // Normal bullets are 20

/obj/item/ammo_box/c585trappiste
	name = "弹药盒（.585特拉比斯特致命弹）"
	desc = "一盒.585特拉比斯特手枪弹，可容纳十二发。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/ammo.dmi'
	icon_state = "585box"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	caliber = CALIBER_585TRAPPISTE
	ammo_type = /obj/item/ammo_casing/c585trappiste
	max_ammo = 12

// .585 Trappiste equivalent to a rubber bullet

/obj/item/ammo_casing/c585trappiste/incapacitator
	name = ".585特拉比斯特平头弹"
	desc = "一种使用白色聚合物弹壳的大口径弹药，弹头较软且平坦。命中目标时会变形压扁，通常不会穿透。"

	icon_state = "585trappiste_disabler"

	projectile_type = /obj/projectile/bullet/c585trappiste/incapacitator
	harmful = FALSE

/obj/projectile/bullet/c585trappiste/incapacitator
	name = ".585特拉比斯特平头子弹"
	damage = 20
	stamina = 40
	wound_bonus = 10

	weak_against_armour = TRUE

	shrapnel_type = null
	sharpness = NONE
	embed_data = null

/obj/item/ammo_box/c585trappiste/incapacitator
	name = "弹药盒（.585特拉比斯特平头弹）"
	desc = "一盒.585特拉比斯特手枪弹，可容纳十二发。蓝色条纹表示盒内应为低致命性弹药。"

	icon_state = "585box_disabler"

	ammo_type = /obj/item/ammo_casing/c585trappiste/incapacitator

// .585 hollowpoint, made to cause nasty wounds

/obj/item/ammo_casing/c585trappiste/hollowpoint
	name = ".585特拉比斯特空尖弹"
	desc = "一种使用白色聚合物弹壳的大口径弹药，弹尖中空。设计目的是命中血肉目标时造成尽可能严重的伤害。"

	icon_state = "585trappiste_shrapnel"
	projectile_type = /obj/projectile/bullet/c585trappiste/hollowpoint

	advanced_print_req = TRUE

/obj/projectile/bullet/c585trappiste/hollowpoint
	name = ".585特拉比斯特空尖子弹"
	damage = 35

	weak_against_armour = TRUE

	wound_bonus = 30
	exposed_wound_bonus = 40

/obj/item/ammo_box/c585trappiste/hollowpoint
	name = "弹药盒（.585特拉比斯特空尖弹）"
	desc = "一盒.585特拉比斯特手枪弹，可容纳十二发。紫色条纹表示盒内应为类似空尖弹的弹药。"

	icon_state = "585box_shrapnel"

	ammo_type = /obj/item/ammo_casing/c585trappiste/hollowpoint
