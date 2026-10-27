// .27-54 Cesarzowa
// Small caliber pistol round meant to be fired out of something that shoots real quick like

/obj/item/ammo_casing/c27_54cesarzowa
	name = ".27-54女皇穿甲弹"
	desc = "一发紫色弹体的无壳弹药，内部装着一枚尖头小弹丸。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "27-54cesarzowa"

	caliber = CALIBER_CESARZOWA
	projectile_type = /obj/projectile/bullet/c27_54cesarzowa

/obj/item/ammo_casing/c27_54cesarzowa/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)

/obj/projectile/bullet/c27_54cesarzowa
	name = ".27-54女皇穿甲子弹"
	damage = 15
	armour_penetration = 30
	wound_bonus = -30
	exposed_wound_bonus = -10

/obj/item/ammo_box/c27_54cesarzowa
	name = "弹药盒（.27-54女皇穿甲弹）"
	desc = "一盒.27-54女皇穿甲手枪弹，可容纳十八发。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "27-54cesarzowa_box"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	caliber = CALIBER_CESARZOWA
	ammo_type = /obj/item/ammo_casing/c27_54cesarzowa
	max_ammo = 18

