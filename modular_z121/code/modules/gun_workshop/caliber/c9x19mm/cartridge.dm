/obj/item/c9x19mm_bullet
	name = "9x19mm FMJ 弹头"
	desc = "全金属被甲弹（Full Metal Jacket）是最基础的弹头类型，由内部的铅锑合金芯和外部的黄铜被甲组成。"

	icon = 'modular_z121/icons/gun_workshop/caliber/c9x19mm/icon.dmi'
	icon_state = "9x19mm-bullet"

/obj/item/ammo_casing/c9x19mm
	name = "9x19mm 手枪弹"
	desc = "9x19mm 帕拉贝鲁姆手枪弹，是当今世界上使用最广泛、最成功的军、警、民用手枪弹种。它在威力、穿透力、后坐力和弹道性能之间取得了出色的平衡，成为了名副其实的世界第一手枪弹。"

	icon = 'modular_z121/icons/gun_workshop/caliber/c9x19mm/icon.dmi'
	icon_state = "9x19mm"
	icon_state_preview = "9x19mm-live"

	caliber = CALIBER_9X19MM
	projectile_type = /obj/projectile/bullet/c9x19mm
//	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c9x19mm

// 如果没有弹头，只是弹壳，那么修改子弹的名称
/obj/item/ammo_casing/c9x19mm/update_name(updates)
	. = ..()
	name = loaded_projectile ? "9x19mm 手枪弹" : "9x19mm 弹壳"


/obj/item/ammo_box/magazine/ammo_stack/c9x19mm
	name = "一把 9x19mm 子弹"
	desc = "一小堆 9x19mm 的子弹。"

	caliber = CALIBER_9X19MM
	ammo_type = /obj/item/ammo_casing/c9x19mm

	max_ammo = 15
