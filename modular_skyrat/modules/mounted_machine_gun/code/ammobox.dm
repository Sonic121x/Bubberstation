/obj/item/ammo_box/magazine/mmg_box
	name = "\improper .50 BMG弹药箱"
	desc = "一个装满弹链弹药的大箱子。"
	icon = 'modular_skyrat/modules/mounted_machine_gun/icons/turret_objects.dmi'
	icon_state = "ammobox"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	max_ammo = 150
	ammo_type = /obj/item/ammo_casing/b50cal
	caliber = CALIBER_50BMG

/obj/item/ammo_casing/b50cal
	name = ".50 BMG子弹"
	icon_state = ".50"
	caliber = CALIBER_50BMG
	projectile_type = /obj/projectile/bullet/c50cal

/obj/projectile/bullet/c50cal
	name = ".50 BMG子弹"
	damage = 40
	wound_bonus = 60
	armour_penetration = 20
	icon_state = "redtrac"
