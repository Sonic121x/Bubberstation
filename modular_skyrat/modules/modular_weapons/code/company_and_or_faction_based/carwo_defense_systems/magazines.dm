// .35 Sol pistol magazines

/obj/item/ammo_box/magazine/c35sol_pistol
	name = "\improper 太阳手枪弹匣"
	desc = "地球政府手枪使用的标准尺寸弹匣，可容纳十二发子弹。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "pistol_35_standard"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/c35sol
	caliber = CALIBER_SOL35SHORT
	max_ammo = 12

/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c35sol_pistol/stendo
	name = "\improper 太阳手枪扩容弹匣"
	desc = "地球政府手枪使用的扩容弹匣，可容纳二十四发子弹。"
	icon_state = "pistol_35_stended"
	max_ammo = 24

/obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty
	start_empty = TRUE

// .40 Sol rifle magazines

/obj/item/ammo_box/magazine/c40sol_rifle
	name = "\improper 太阳步枪短弹匣"
	desc = "地球政府步枪使用的缩短型弹匣，可容纳十五发子弹。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "rifle_short"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/c40sol
	caliber = CALIBER_SOL40LONG
	max_ammo = 15

/obj/item/ammo_box/magazine/c40sol_rifle/starts_empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c40sol_rifle/standard
	name = "\improper 太阳步枪弹匣"
	desc = "地球政府步枪使用的标准尺寸弹匣，可容纳三十发子弹。"
	icon_state = "rifle_standard"
	w_class = WEIGHT_CLASS_NORMAL
	max_ammo = 30

/obj/item/ammo_box/magazine/c40sol_rifle/standard/starts_empty
	start_empty = TRUE


/obj/item/ammo_box/magazine/c40sol_rifle/drum
	name = "\improper 太阳步枪弹鼓"
	desc = "地球政府步枪使用的大型弹鼓，可容纳六十发子弹。"
	icon_state = "rifle_drum"
	w_class = WEIGHT_CLASS_NORMAL
	max_ammo = 60

/obj/item/ammo_box/magazine/c40sol_rifle/drum/starts_empty
	start_empty = TRUE

// .980 grenade magazines

/obj/item/ammo_box/magazine/c980_grenade
	name = "\improper 河马榴弹弹匣"
	desc = "装载.980榴弹的标准尺寸弹匣，可容纳四发榴弹。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "granata_standard"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	w_class = WEIGHT_CLASS_NORMAL
	ammo_type = /obj/item/ammo_casing/c980grenade
	caliber = CALIBER_980TYDHOUER
	max_ammo = 4

/obj/item/ammo_box/magazine/c980_grenade/starts_empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c980_grenade/drum
	name = "\improper 河马榴弹弹鼓"
	desc = "装载.980榴弹的弹鼓，可容纳六发榴弹。"
	icon_state = "granata_drum"
	w_class = WEIGHT_CLASS_NORMAL
	max_ammo = 6

/obj/item/ammo_box/magazine/c980_grenade/drum/starts_empty
	start_empty = TRUE

// .40 Sol Long
// Rifle caliber caseless ammo that kills people good

/obj/item/ammo_casing/c40sol
	name = ".40太阳长型致命弹"
	desc = "一发地球政府制式无壳致命步枪弹。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "40sol"

	caliber = CALIBER_SOL40LONG
	projectile_type = /obj/projectile/bullet/c40sol


/obj/item/ammo_casing/c40sol/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)


/obj/projectile/bullet/c40sol
	name = ".40太阳长型子弹"
	damage = 35

	wound_bonus = -30
	exposed_wound_bonus = -35


/obj/item/ammo_box/c40sol
	name = "弹药盒（.40太阳长型致命弹）"
	desc = "一盒.40太阳长型步枪弹，可容纳三十发。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "40box"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	caliber = CALIBER_SOL40LONG
	ammo_type = /obj/item/ammo_casing/c40sol
	max_ammo = 30


// .40 Sol fragmentation rounds, embeds shrapnel in the target almost every time at close to medium range. Teeeechnically less lethals.

/obj/item/ammo_casing/c40sol/fragmentation
	name = ".40太阳长型破片弹"
	desc = "一发地球政府制式无壳破片步枪弹。撞击时破碎，飞散的锋利破片可能使目标失去行动能力。"

	icon_state = "40sol_disabler"

	projectile_type = /obj/projectile/bullet/c40sol/fragmentation

	advanced_print_req = TRUE

	harmful = FALSE


/obj/projectile/bullet/c40sol/fragmentation
	name = ".40太阳长型破片子弹"
	damage = 15
	stamina = 30

	weak_against_armour = TRUE

	sharpness = SHARP_EDGED
	wound_bonus = 0
	exposed_wound_bonus = 20

	shrapnel_type = /obj/item/shrapnel/stingball
	embed_type = /datum/embedding/c40sol_fragmentation

	embed_falloff_tile = -5

/datum/embedding/c40sol_fragmentation
	embed_chance = 50
	fall_chance = 5
	jostle_chance = 5
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 2
	jostle_pain_mult = 3
	rip_time = 0.5 SECONDS

/obj/item/ammo_box/c40sol/fragmentation
	name = "弹药盒（.40太阳长型破片弹）"
	desc = "一盒.40太阳长型步枪弹，可容纳三十发。蓝色条纹表示盒内应为低致命性弹药。"

	icon_state = "40box_disabler"

	ammo_type = /obj/item/ammo_casing/c40sol/fragmentation


// .40 Sol match grade, bounces a lot, and if there's less than 20 bullet armor on wherever these hit, it'll go completely through the target and out the other side

/obj/item/ammo_casing/c40sol/pierce
	name = ".40太阳长型竞赛弹"
	desc = "一发地球政府制式无壳竞赛级步枪弹。采用更高膛压，因此弹丸飞行速度略快。\
		传闻这种子弹能打出酷炫的墙面跳弹，不过官方建议直接射击目标，\
		别打目标旁边的墙。"

	icon_state = "40sol_pierce"

	projectile_type = /obj/projectile/bullet/c40sol/pierce

	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE


/obj/projectile/bullet/c40sol/pierce
	name = ".40太阳竞赛子弹"

	icon_state = "gaussphase"

	speed = 2

	damage = 25
	armour_penetration = 20

	wound_bonus = -30
	exposed_wound_bonus = -10

	ricochets_max = 2
	ricochet_chance = 80
	ricochet_auto_aim_range = 4
	ricochet_incidence_leeway = 65

	projectile_piercing = PASSMOB


/obj/projectile/bullet/c40sol/pierce/on_hit(atom/target, blocked = 0, pierce_hit)
	if(isliving(target))
		var/mob/living/poor_sap = target

		// If the target mob has enough armor to stop the bullet, or the bullet has already gone through two people, stop it on this hit
		if((poor_sap.run_armor_check(def_zone, BULLET, "", "", silent = TRUE) > 20) || (pierces > 2))
			projectile_piercing = NONE

			if(damage > 10) // Lets just be safe with this one
				damage -= 5
			armour_penetration -= 10

	return ..()


/obj/item/ammo_box/c40sol/pierce
	name = "弹药盒（.40太阳长型竞赛弹）"
	desc = "一盒.40太阳长型步枪弹，可容纳三十发。黄色条纹表示盒内应为高性能弹药。"

	icon_state = "40box_pierce"

	ammo_type = /obj/item/ammo_casing/c40sol/pierce


// .40 Sol incendiary

/obj/item/ammo_casing/c40sol/incendiary
	name = ".40太阳长型燃烧弹"
	desc = "一发地球政府制式无壳燃烧步枪弹。不留火焰轨迹，只在命中时点燃目标。"

	icon_state = "40sol_flame"

	projectile_type = /obj/projectile/bullet/c40sol/incendiary

	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE


/obj/projectile/bullet/c40sol/incendiary
	name = ".40太阳长型燃烧子弹"
	icon_state = "redtrac"

	damage = 25

	/// How many firestacks the bullet should impart upon a target when impacting
	var/firestacks_to_give = 1


/obj/projectile/bullet/c40sol/incendiary/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()

	if(iscarbon(target))
		var/mob/living/carbon/gaslighter = target
		gaslighter.adjust_fire_stacks(firestacks_to_give)
		gaslighter.ignite_mob()


/obj/item/ammo_box/c40sol/incendiary
	name = "弹药盒（.40太阳长型燃烧弹）"
	desc = "一盒.40太阳长型步枪弹，可容纳三十发。橙色条纹表示盒内应为燃烧弹药。"

	icon_state = "40box_flame"

	ammo_type = /obj/item/ammo_casing/c40sol/incendiary
