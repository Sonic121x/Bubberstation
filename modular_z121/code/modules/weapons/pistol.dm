/obj/item/gun/ballistic/automatic/pistol/makeshift
	name = "简易手枪"
	desc = "如果你看到了这件物品，请报告此问题。"
	icon = 'modular_z121/icons/weapons/gunz.dmi'
	icon_state = "cpistol"
	worn_icon = 'modular_z121/icons/weapons/worn.dmi'
	worn_icon_state = "pistol"
	lefthand_file = 'modular_z121/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_z121/icons/weapons/righthand.dmi'
	can_suppress = FALSE
	tac_reloads = TRUE
	wound_bonus = 0
	force = 10
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT

/obj/item/gun/ballistic/automatic/pistol/makeshift/C96
	name = "简易C96手枪"
	desc = "一把仿制的C96手枪, 发射九毫米口径弹药."
	icon_state = "cpistol"
	inhand_icon_state = "cpistol"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/makeshift/C96
	rack_sound = 'modular_z121/sound/weapons/gunsounds/44/magnumeject.ogg' //placeholder
	bolt_drop_sound = 'modular_z121/sound/weapons/gunsounds/44/magnumeject.ogg' //placeholder
	load_sound = 'modular_z121/sound/weapons/gunsounds/chinese/cpistolload2.ogg'
	load_empty_sound = 'modular_z121/sound/weapons/gunsounds/chinese/cpistolload2.ogg'
	eject_sound = 'modular_z121/sound/weapons/gunsounds/chinese/cpistoleject.ogg' //placeholder - these aren't very good
	eject_empty_sound = 'modular_z121/sound/weapons/gunsounds/chinese/cpistoleject.ogg' //placeholder - these aren't very good
	fire_sound = 'modular_z121/sound/weapons/gunsounds/chinese/chinese1.ogg'
	fire_delay = 0.5 SECONDS
	projectile_speed_multiplier = 1.25
	internal_magazine = TRUE
	recoil = 1

/obj/item/ammo_box/magazine/internal/makeshift/C96
	name = "C96内置弹仓"
	ammo_type = /obj/item/ammo_casing/c9mm/makeshift
	caliber = CALIBER_9MM
	max_ammo = 10
	start_empty = TRUE

/obj/item/ammo_box/speedloader/makeshift
	name = "简易桥夹"
	desc = "用于简易枪械的五发桥夹。"
	icon = 'modular_z121/icons/ammo/ammo.dmi'

/obj/item/ammo_box/speedloader/makeshift/C96
	name = "桥夹（9mm）"
	desc = "用于C96手枪的五发桥夹。"
	icon_state = "cpistol"
	ammo_type = /obj/item/ammo_casing/c9mm/makeshift
	max_ammo = 5
	start_empty = TRUE
	ammo_box_multiload = AMMO_BOX_MULTILOAD_ALL
	caliber = CALIBER_9MM

/datum/crafting_bench_recipe/C96
	recipe_name = "桥夹（9mm）"
	recipe_requirements = list(
		/obj/item/stack/sheet/iron = 2,
	)
	resulting_item = /obj/item/ammo_box/speedloader/makeshift/C96

/obj/item/gun/ballistic/automatic/pistol/makeshift/silent
	name = "简易鲁格.22手枪"
	desc = "一把仿制的鲁格手枪, 发射.22口径弹药."
	icon_state = "22pistol"
	inhand_icon_state = "22pistol"
	spawnwithmagazine = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/makeshift/c22p
	rack_sound = 'modular_z121/sound/weapons/gunsounds/9mm/9mm_rack2.ogg'
	bolt_drop_sound = 'modular_z121/sound/weapons/gunsounds/9mm/9mmrack.ogg'
	load_sound = 'modular_z121/sound/weapons/gunsounds/9mm/9mm_in2.ogg' //placeholder
	load_empty_sound = 'modular_z121/sound/weapons/gunsounds/9mm/9mm_in2.ogg' //placeholder
	eject_sound = 'modular_z121/sound/weapons/gunsounds/9mm/9mm_out2.ogg' //placeholder
	eject_empty_sound = 'modular_z121/sound/weapons/gunsounds/9mm/9mm_out2.ogg' //placeholder
	fire_sound = 'modular_z121/sound/weapons/gunsounds/22/22pistol.ogg'
	fire_delay = 0.4 SECONDS
	projectile_damage_multiplier = 1.5
	projectile_speed_multiplier = 2
	spread = 8
	spawnwithmagazine = FALSE
	recoil = 0.5
	can_unsuppress = FALSE
	can_suppress = TRUE

/obj/item/gun/ballistic/automatic/pistol/makeshift/silent/Initialize(mapload)
	. = ..()
	var/obj/item/suppressor/new_suppressor = new(src)
	install_suppressor(new_suppressor)

/obj/item/gun/ballistic/automatic/pistol/makeshift/give_manufacturer_examine()
	return

/obj/item/gun/ballistic/automatic/pistol/newtech
	name = "简易手枪"
	desc = "如果你看到了这件物品，请报告此问题。"
	icon = 'modular_z121/icons/weapons/gunz.dmi'
	icon_state = "cpistol"
	worn_icon = 'modular_z121/icons/weapons/worn.dmi'
	worn_icon_state = "pistol"
	lefthand_file = 'modular_z121/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_z121/icons/weapons/righthand.dmi'
	can_suppress = FALSE
	tac_reloads = TRUE
	wound_bonus = 0
	force = 10
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT

/obj/item/gun/ballistic/automatic/pistol/newtech/Initialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/pistol/newtech/give_manufacturer_examine()
	return

/obj/item/gun/ballistic/automatic/pistol/newtech/glock
	name = "格洛克18型9mm手枪"
	desc = "真正的经典。"
	icon_state = "glock"
	inhand_icon_state = "9mm"
	spawnwithmagazine = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/makeshift/glock
	rack_sound = 'modular_z121/sound/weapons/pistol_rack.wav'
	bolt_drop_sound = 'modular_z121/sound/weapons/pistol_rack.wav'
	load_sound = 'modular_z121/sound/weapons/pistol_magin.wav' //placeholder
	load_empty_sound = 'modular_z121/sound/weapons/pistol_magin.wav' //placeholder
	eject_sound = 'modular_z121/sound/weapons/pistol_magout.wav' //placeholder
	eject_empty_sound = 'modular_z121/sound/weapons/pistol_magout.wav' //placeholder
	fire_sound = 'modular_z121/sound/weapons/glock1.wav'
	suppressed_sound = 'modular_z121/sound/weapons/glock_suppressed2.wav'
	fire_delay = 0.2 SECONDS
	projectile_damage_multiplier = 0.6
	projectile_speed_multiplier = 1.3
	suppressor_x_offset = 1
	spread = 0
	spawnwithmagazine = FALSE
	recoil = 0.75
	can_unsuppress = TRUE
	can_suppress = TRUE
//	shots_before_degradation = 17
//	max_shots_before_degradation = 17
//	degradation_stage = 0
//	degradation_stage_max = 10
//	degradation_probability = 5
//	maximum_speed_malus = 0.7
