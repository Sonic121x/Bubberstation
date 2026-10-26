/obj/item/mod/module/baton_holster
	name = "MOD 警棍枪套模块"
	desc = "一种安装在 MOD 外骨骼胸部的模块，可让你 \
		随时从外骨骼中取出插入的警棍。在模块从外骨骼上拆下时， \
		用警棍敲击模块即可插入警棍。"
	icon_state = "holster"
	icon = 'modular_skyrat/modules/contractor/icons/modsuit_modules.dmi'
	module_type = MODULE_ACTIVE
	complexity = 3
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	device = /obj/item/melee/baton/telescopic/contractor_baton
	incompatible_modules = list(/obj/item/mod/module/baton_holster)
	cooldown_time = 0.5 SECONDS
	allow_flags = MODULE_ALLOW_INACTIVE
	required_slots = list(ITEM_SLOT_GLOVES)
	/// Have they sacrificed a baton to actually be able to use this?
	var/eaten_baton = FALSE

/obj/item/mod/module/baton_holster/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(!istype(attacking_item, /obj/item/melee/baton/telescopic/contractor_baton) || eaten_baton)
		return
	balloon_alert(user, "[attacking_item] 已插入")
	eaten_baton = TRUE
	for(var/obj/item/melee/baton/telescopic/contractor_baton/device_baton as anything in src)
		for(var/obj/item/baton_upgrade/original_upgrade in attacking_item)
			var/obj/item/baton_upgrade/new_upgrade = new original_upgrade.type(device_baton)
			device_baton.add_upgrade(new_upgrade)
		for(var/obj/item/restraints/handcuffs/cable/baton_cuffs in attacking_item)
			baton_cuffs.forceMove(device_baton)
	qdel(attacking_item)

/obj/item/mod/module/baton_holster/on_activation()
	if(!eaten_baton)
		balloon_alert(mod.wearer, "未插入警棍")
		return
	return ..()

/obj/item/mod/module/baton_holster/preloaded
	eaten_baton = TRUE
	device = /obj/item/melee/baton/telescopic/contractor_baton

/obj/item/mod/module/baton_holster/preloaded/upgraded
	device = /obj/item/melee/baton/telescopic/contractor_baton/upgraded

/obj/item/mod/module/chameleon/contractor // zero complexity module to match pre-TGification
	complexity = 0

/obj/item/mod/module/springlock/contractor
	name = "MOD 磁力展开模块"
	desc = "一种远比弹簧锁系统现代的版本。 \
	这是一个利用磁铁加快 MOD 外骨骼展开与收起速度的模块。"
	icon_state = "magnet"
	icon = 'modular_skyrat/modules/contractor/icons/modsuit_modules.dmi'

/obj/item/mod/module/springlock/contractor/on_part_activation() // This module is actually *not* a death trap
	return

/obj/item/mod/module/springlock/contractor/on_part_deactivation(deleting = FALSE)
	return

/// This exists for the adminbus contractor modsuit. Do not use otherwise
/obj/item/mod/module/springlock/contractor/no_complexity
	complexity = 0

/obj/item/mod/module/scorpion_hook
	name = "MOD SCORPION 抓钩模块"
	desc = "一种安装在 MOD 外骨骼腕部的模块，这个高度 \
			非法的模块使用硬光抓钩强行将 \
			目标高速拉向你，将其击倒并 \
			使其部分体力耗尽。"
	icon_state = "hook"
	icon = 'modular_skyrat/modules/contractor/icons/modsuit_modules.dmi'
	incompatible_modules = list(/obj/item/mod/module/scorpion_hook)
	module_type = MODULE_ACTIVE
	complexity = 3
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	device = /obj/item/gun/magic/hook/contractor
	cooldown_time = 0.5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)
