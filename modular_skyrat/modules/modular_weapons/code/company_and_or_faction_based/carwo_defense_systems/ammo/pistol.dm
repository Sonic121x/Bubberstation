// .35 Sol Short
// Pistol caliber caseless round used almost exclusively by TerraGov weapons

/obj/item/ammo_casing/c35sol
	name = ".35太阳短型致命弹"
	desc = "一发地球政府制式无壳致命手枪弹。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "35sol"

	caliber = CALIBER_SOL35SHORT
	projectile_type = /obj/projectile/bullet/c35sol


/obj/item/ammo_casing/c35sol/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)


/obj/projectile/bullet/c35sol
	name = ".35太阳短型子弹"
	damage = 20

	wound_bonus = 5 // Normal bullets are 20
	exposed_wound_bonus = 25


/obj/item/ammo_box/c35sol
	name = "弹药盒（.35太阳短型致命弹）"
	desc = "一盒.35太阳短型手枪弹，可容纳二十四发。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "35box"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	caliber = CALIBER_SOL35SHORT
	ammo_type = /obj/item/ammo_casing/c35sol
	max_ammo = 24


// .35 Sol's equivalent to a rubber bullet

/obj/item/ammo_casing/c35sol/incapacitator
	name = ".35太阳短型失能弹"
	desc = "一发地球政府制式无壳低致命性手枪弹。命中时使目标疲惫，浅角度撞墙时容易弹射。"

	icon_state = "35sol_disabler"

	projectile_type = /obj/projectile/bullet/c35sol/incapacitator
	harmful = FALSE


/obj/projectile/bullet/c35sol/incapacitator
	name = ".35太阳短型失能子弹"
	damage = 8
	stamina = 30

	wound_bonus = -40
	exposed_wound_bonus = -20

	weak_against_armour = TRUE

	// The stats of the ricochet are a nerfed version of detective revolver rubber ammo
	// This is due to the fact that there's a lot more rounds fired quickly from weapons that use this, over a revolver
	ricochet_auto_aim_angle = 30
	ricochet_auto_aim_range = 5
	ricochets_max = 4
	ricochet_incidence_leeway = 50
	ricochet_chance = 130
	ricochet_decay_damage = 0.8

	shrapnel_type = null
	sharpness = NONE
	embed_data = null


/obj/item/ammo_box/c35sol/incapacitator
	name = "弹药盒（.35太阳短型失能弹）"
	desc = "一盒.35太阳短型手枪弹，可容纳二十四发。蓝色条纹表示盒内应为低致命性弹药。"

	icon_state = "35box_disabler"

	ammo_type = /obj/item/ammo_casing/c35sol/incapacitator


// .35 Sol ripper, similar to the detective revolver's dumdum rounds, causes slash wounds and is weak to armor

/obj/item/ammo_casing/c35sol/ripper
	name = ".35太阳短型撕裂弹"
	desc = "一发地球政府制式无壳撕裂手枪弹。会对目标造成割伤，但对护甲效果不佳。"

	icon_state = "35sol_shrapnel"
	projectile_type = /obj/projectile/bullet/c35sol/ripper

	custom_materials = AMMO_MATS_RIPPER
	advanced_print_req = TRUE


/obj/projectile/bullet/c35sol/ripper
	name = ".35太阳撕裂子弹"
	damage = 15

	weak_against_armour = TRUE

	sharpness = SHARP_EDGED

	wound_bonus = 25
	exposed_wound_bonus = 25

	embed_type = /datum/embedding/c35sol_ripper

	embed_falloff_tile = -15

/datum/embedding/c35sol_ripper
	embed_chance = 75
	fall_chance = 3
	jostle_chance = 4
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 5
	jostle_pain_mult = 6
	rip_time = 1 SECONDS

/obj/item/ammo_box/c35sol/ripper
	name = "弹药盒（.35太阳短型撕裂弹）"
	desc = "一盒.35太阳短型手枪弹，可容纳二十四发。紫色条纹表示盒内应为类似空尖弹的弹药。"

	icon_state = "35box_shrapnel"

	ammo_type = /obj/item/ammo_casing/c35sol/ripper
