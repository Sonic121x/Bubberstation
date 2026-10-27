/obj/item/gun/energy/e_gun/stun/tacticool
	name = "战术酷炫能量枪"
	desc = "一把旧型号的战术能量枪，显然没有得到很好的保养。它的电击模式似乎给电池带来了极大的负担。"
	icon_state = "energytac"
	icon = 'modular_zubbers/icons/obj/weapons/guns/energy.dmi'
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/sec/tacticool, /obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser)
	w_class = WEIGHT_CLASS_BULKY


/obj/item/ammo_casing/energy/electrode/sec/tacticool
	e_cost = LASER_SHOTS(2, STANDARD_CELL_CHARGE)


/obj/item/gun/energy/tacticool/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 15, \
		overlay_y = 10)

/obj/item/gun/energy/e_gun/stun
	icon_state = "energytac"
	icon = 'modular_zubbers/icons/obj/weapons/guns/energy.dmi'

/obj/item/gun/energy/e_gun/nuclear_smg
	name = "高级能量冲锋枪"
	desc = "一种自充电、双模式的速射能量武器，是激光卡宾枪、失能冲锋枪与高级能量枪三者令人作呕的杂交产物。\
			对微型反应堆的改造使其发电更稳定，但效率更低。配有“失能”与“击杀”两种模式。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/energy.dmi'
	icon_state = "nuclear_smg"
	inhand_icon_state = "nucgun"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/smg, /obj/item/ammo_casing/energy/lasergun/carbine_old)
	spread = 2
	ammo_x_offset = 1
	projectile_damage_multiplier = 1.0
	projectile_speed_multiplier = 1.2
	selfcharge = 1
	charge_delay = 7.5
	self_charge_amount = STANDARD_ENERGY_GUN_SELF_CHARGE_RATE / 2
	can_charge = TRUE
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT
	)

/obj/item/gun/energy/e_gun/nuclear_smg/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.15 SECONDS, allow_akimbo = FALSE)

/obj/item/gun/energy/e_gun/nuclear_smg/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 17, \
		overlay_y = 8)
