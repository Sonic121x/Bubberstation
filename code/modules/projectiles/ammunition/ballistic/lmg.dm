// 7mm (SAW)
// BUBBER BUFFS modular_zubbers\code\modules\projectiles\projectile\bullets\lmg.dm
/obj/item/ammo_casing/m7mm
	name = "7mm 子弹壳"
	desc = "一个 7mm 子弹壳。"
	icon_state = "762-casing"
	caliber = CALIBER_A7MM
	projectile_type = /obj/projectile/bullet/a7mm

/obj/item/ammo_casing/m7mm/ap
	name = "7mm 穿甲子弹壳"
	desc = "一种尖端装有硬化弹芯、用于击穿装甲目标的 7mm 子弹壳。"
	projectile_type = /obj/projectile/bullet/a7mm/ap

/obj/item/ammo_casing/m7mm/hollow
	name = "7mm 空尖子弹壳"
	desc = "一种旨在对无装甲目标造成更多伤害的 7mm 子弹壳。"
	projectile_type = /obj/projectile/bullet/a7mm/hp

/obj/item/ammo_casing/m7mm/incen
	name = "7mm 燃烧子弹壳"
	desc = "一种尖端装有化学胶囊的 7mm 子弹壳，胶囊破裂后会与大气反应产生火球，将目标吞没在火焰中。"
	projectile_type = /obj/projectile/bullet/incendiary/a7mm

/obj/item/ammo_casing/m7mm/match
	name = "7mm 比赛级子弹壳"
	desc = "一种以无可挑剔的高标准制造的 7mm 子弹壳，你可以用它打出一些很酷的花式射击。"
	projectile_type = /obj/projectile/bullet/a7mm/match

/obj/item/ammo_casing/m7mm/bouncy
	name = "7mm 橡胶子弹壳"
	desc = "一种以无可救药的低标准制造的 7mm 橡胶子弹壳，朝着走廊一顿扫射能惹毛一大群人。"
	projectile_type = /obj/projectile/bullet/a7mm/bouncy
