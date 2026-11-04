// 合成分类 - 子弹
/datum/crafting_recipe/ammo
	abstract_type = /datum/crafting_recipe/ammo
	category = CAT_GUN_AMMO

	// 收集具体物品实例，供 check_requirements 校验“空壳”
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_COLLECT_REQUIREMENTS

	// 所有合成都需要弹药装配台
	structures = list(
		/obj/structure/ammo_workshop = CRAFTING_STRUCTURE_USE
	)

	time = 5 SECONDS

// 复装类配方：作为材料的弹壳必须是空壳，防止已装填实弹被当材料消耗
/datum/crafting_recipe/ammo/check_requirements(mob/user, list/collected_requirements)
	. = ..()
	if(!.)
		return FALSE

	for(var/req_path in collected_requirements)
		for(var/obj/item/ammo_casing/casing as anything in collected_requirements[req_path])
			if(casing.loaded_projectile) // 带弹头 = 实弹，拒绝
				return FALSE

	return TRUE

// 物品生成器，用于合成配方能产出多个物品
/obj/effect/spawner/gun_workshop
	abstract_type = /obj/effect/spawner/gun_workshop
	var/item = null
	var/amount = 1

// 初始化内覆写物品生成逻辑
/obj/effect/spawner/gun_workshop/Initialize(mapload)
	. = ..()
	var/turf/src_turf = get_turf(src)
	for(var/i in 1 to amount)
		var/obj/item/spawned_item = new item(src_turf)

		if(istype(spawned_item, /obj/item/ammo_casing))
			var/obj/item/ammo_casing/spawned_casing = spawned_item

			// 释放投射物对象的内存并设置引用为空，之后更新贴图
			// 以此达到创建弹壳而非子弹的效果
			QDEL_NULL(spawned_casing.loaded_projectile)
			spawned_casing.update_appearance()

		// 合成产物的位置随机
		spawned_item.pixel_x = rand(-8, 8)
		spawned_item.pixel_y = rand(-8, 8)

/obj/effect/spawner/gun_workshop/c9x19mm_bullet_5
	item = /obj/item/c9x19mm_bullet
	amount = 5

	icon = 'modular_z121/icons/gun_workshop/caliber/c9x19mm/icon.dmi'
	icon_state = "9x19mm-bullet"

/datum/crafting_recipe/ammo/c9x19mm_bullet_fmj_5
	name = "5x 9x19mm FMJ 弹头"
	result = /obj/effect/spawner/gun_workshop/c9x19mm_bullet_5

	reqs = list(
		/obj/item/stack/sheet/bronze = 1,
		/obj/item/stack/sheet/iron = 1
	)

/obj/effect/spawner/gun_workshop/c9x19mm_casing_5
	item = /obj/item/ammo_casing/c9x19mm
	amount = 5

	icon = 'modular_z121/icons/gun_workshop/caliber/c9x19mm/icon.dmi'
	icon_state = "9x19mm"

/datum/crafting_recipe/ammo/c9x19mm_casing_5
	name = "5x 9x19mm 弹壳"
	result = /obj/effect/spawner/gun_workshop/c9x19mm_casing_5

	reqs = list(
		/obj/item/stack/sheet/bronze = 2
	)

/obj/effect/spawner/gun_workshop/pistol_primer_5
	item = /obj/item/primer/pistol
	amount = 5

	icon = 'modular_z121/icons/gun_workshop/primer/icon.dmi'
	icon_state = "pistol"

/datum/crafting_recipe/ammo/pistol_primer
	name = "5x 手枪弹底火"
	result = /obj/effect/spawner/gun_workshop/pistol_primer_5

	reqs = list(
		/obj/item/stack/sheet/bronze = 1,
		/datum/reagent/gunpowder = 3
	)

/datum/crafting_recipe/ammo/c9x19mm_cartridge
	name = "9x19mm 帕拉贝鲁姆手枪弹"
	result = /obj/item/ammo_casing/c9x19mm

	reqs = list(
		/obj/item/c9x19mm_bullet = 1,
		/obj/item/ammo_casing/c9x19mm = 1,
		/obj/item/primer/pistol = 1,
		/datum/reagent/gunpowder = 2,
	)
