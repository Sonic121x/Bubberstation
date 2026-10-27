/obj/item/gun/ballistic/automatic/pistol/pepperball
	name = "\improper 博尔特AHG胡椒球枪"
	desc = "一件极为平庸的“枪械”，用于发射柔软的胡椒球，以轻松制服目标。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/pepperball/pepperball.dmi'
	icon_state = "peppergun"
	w_class = WEIGHT_CLASS_SMALL
	accepted_magazine_type = /obj/item/ammo_box/magazine/pepperball
	can_suppress = FALSE
	fire_sound = 'sound/effects/pop_expl.ogg'
	rack_sound = 'sound/items/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/items/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/items/weapons/gun/pistol/slide_drop.ogg'
	fire_sound_volume = 50
	fire_delay = 8

/obj/item/gun/ballistic/automatic/pistol/pepperball/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_BOLT)

/obj/item/gun/ballistic/automatic/pistol/pepperball/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', light_overlay = "flight")

/obj/item/ammo_box/magazine/pepperball
	name = "手枪弹匣（胡椒球）"
	desc = "装满球状弹药的枪械弹匣。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/pepperball/pepperball.dmi'
	icon_state = "pepperball"
	ammo_type = /obj/item/ammo_casing/pepperball
	caliber = CALIBER_PEPPERBALL
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_casing/pepperball
	name = "胡椒球"
	desc = "一发胡椒球弹药。"
	caliber = CALIBER_PEPPERBALL
	projectile_type = /obj/projectile/bullet/pepperball
	harmful = FALSE

/obj/projectile/bullet/pepperball
	name = "胡椒球弹丸"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/pepperball/projectiles.dmi'
	icon_state = "pepperball"
	damage = 0
	stamina = 5
	shrapnel_type = null
	sharpness = NONE
	embed_data = null
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	var/contained_reagent = /datum/reagent/consumable/condensedcapsaicin
	var/reagent_volume = 5

/obj/projectile/bullet/pepperball/on_hit(atom/target, blocked = 0, pierce_hit)
	if(isliving(target))
		var/mob/living/M = target
		if(M.can_inject())
			var/datum/reagent/R = new contained_reagent
			R.expose_mob(M, VAPOR, reagent_volume)
	. = ..()

/obj/item/ammo_box/advanced/pepperballs
	name = "胡椒球弹药盒"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/pepperball/ammoboxes.dmi'
	icon_state = "box10x24"
	ammo_type = /obj/item/ammo_casing/pepperball
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
	)
	max_ammo = 15

// Gunset for the pepperball pistol

/obj/item/storage/toolbox/guncase/skyrat/pistol/pepperball
	name = "AHG胡椒球枪械套装"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/pepperball
	extra_to_spawn = /obj/item/ammo_box/magazine/pepperball
