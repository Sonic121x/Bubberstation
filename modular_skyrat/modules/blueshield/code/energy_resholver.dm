//Blueshield Energy Revolver
//Icon and such by @EspeciallyStrange 'Calvin'

/obj/item/gun/energy/e_gun/blueshield
	name = "X-02 能量左轮手枪"
	desc = "一把装有自充电电池的能量武器。拿起来有些沉，被它砸一下肯定很疼。"
	icon = 'modular_skyrat/modules/blueshield/icons/energy.dmi'
	icon_state = "blackgrip"
	lefthand_file = 'modular_skyrat/modules/blueshield/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/blueshield/icons/guns_righthand.dmi'
	charge_delay = 9
	can_charge = FALSE //Doesn't work like that son
	selfcharge = 1
	cell_type = /obj/item/stock_parts/power_store/cell/hos_gun
	w_class = WEIGHT_CLASS_NORMAL //Fits in bag!
	force = 15 //smash sulls in
	throwforce = 15
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hos, /obj/item/ammo_casing/energy/laser/hellfire)
	ammo_x_offset = 1

/obj/item/gun/energy/e_gun/blueshield/specop
	name = "战术能量左轮手枪"
	desc = "能量左轮手枪的进阶型号，保留了全部优点，并配备了强大得多的相位发射器。"
	icon_state = "redgrip"
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/spec, /obj/item/ammo_casing/energy/laser/hellfire)
//Alternative for people who prefers energy carbine, remain inclusive and all.
/obj/item/gun/energy/e_gun/stun/blueshield
	name = "防御者能量卡宾枪"
	desc = "军用制式能量枪，可发射眩晕弹。充能极慢。"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/blueshield, /obj/item/ammo_casing/energy/laser/scatter/disabler, /obj/item/ammo_casing/energy/lasergun/blueshield)
	charge_delay = 14
	can_charge = TRUE //In case you aren't charging fast enough, the recharge is meant to be slow on purpose
	selfcharge = 1

//Blueshield Energy
/obj/item/ammo_casing/energy/electrode/blueshield
	e_cost = LASER_SHOTS(6, STANDARD_CELL_CHARGE)
	projectile_type = /obj/projectile/energy/electrode/blueshield

/obj/item/ammo_casing/energy/lasergun/blueshield
	e_cost = LASER_SHOTS(30, STANDARD_CELL_CHARGE)

/obj/projectile/energy/electrode/blueshield
	stamina = 55 //Still a 3 shot down but much more safe to have

