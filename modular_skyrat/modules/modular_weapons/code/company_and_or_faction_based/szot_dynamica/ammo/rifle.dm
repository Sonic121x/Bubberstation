// Various ammo boxes for .310

/obj/item/ammo_box/c310_cargo_box
	name = "弹药盒（.310飞箭致命弹）"
	desc = "一盒.310飞箭致命步枪弹，可容纳十发。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "310_box"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	caliber = CALIBER_STRILKA310
	ammo_type = /obj/item/ammo_casing/strilka310
	max_ammo = 10


// AP

/obj/item/ammo_box/c310_cargo_box/piercing
	name = "弹药盒（.310飞箭穿甲弹）"
	desc = "一盒.310飞箭穿甲步枪弹，可容纳十发。"

	icon_state = "310_box_ap"

	ammo_type = /obj/item/ammo_casing/strilka310/ap

// AMR bullet

/obj/item/ammo_casing/p60strela
	name = ".60利箭无壳弹"
	desc = "一大块等离子紫色推进剂，上端露出一枚同样巨大的弹头。\
		虽然杀人效果不错，但你会发现摧毁物体才是它最擅长的用途。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "amr_bullet"
	caliber = CALIBER_60STRELA
	projectile_type = /obj/projectile/bullet/p60strela

/obj/item/ammo_casing/p60strela/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/projectile/bullet/p60strela // The funny thing is, these are wild but you only get three of them a magazine
	name =".60利箭子弹"
	icon_state = "gaussphase"
	speed = 1.5
	damage = 40
	armour_penetration = 30
	wound_bonus = 10
	demolition_mod = 1.2
