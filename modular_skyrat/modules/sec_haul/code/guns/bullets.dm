/*
*	9x25mm Mk.12
*/

/obj/item/ammo_casing/c9mm
	name = "9×25毫米Mk.12弹药"
	desc = "一发现代9×25毫米Mk.12弹药。"

/obj/item/ammo_casing/c9mm/ap
	name = "9×25毫米Mk.12穿甲弹"
	desc = "一发装有穿甲弹头的现代9×25毫米Mk.12弹药。"
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c9mm/hp
	name = "9×25毫米Mk.12空尖弹"
	desc = "一发装有空尖弹头的现代9×25毫米Mk.12弹药，对无护甲目标极具杀伤力。"
	advanced_print_req = TRUE

/obj/item/ammo_casing/c9mm/fire
	name = "9×25毫米Mk.12燃烧弹"
	desc = "一发现代9×25毫米Mk.12弹药。这发燃烧弹会留下火焰轨迹，并点燃目标。"
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

/obj/item/ammo_casing/security
	name = "9×19毫米安保弹药"
	desc = "安保制式弹药，经过优化以避免造成长期损伤，确保罪犯在接受医疗救治后仍可被关押（并收取费用）。"
	caliber = CALIBER_9MM_SEC
	projectile_type = /obj/projectile/bullet/security

/obj/projectile/bullet/security
	name = "9×19毫米墨菲弹"
	damage = 20
	wound_bonus = -20
	armour_penetration = 10

/obj/projectile/bullet/c9mm
	damage = 25

/obj/projectile/bullet/c9mm
	damage = 25

/obj/projectile/bullet/c38
	name = ".38子弹"
	damage = 30

// premium .38 ammo from cargo, weak against armor, lower base damage, but excellent at embedding and causing slice wounds at close range
/obj/projectile/bullet/c38/dumdum
	name = ".38达姆弹"
	damage = 20
	weak_against_armour = TRUE
	ricochets_max = 0
	sharpness = SHARP_EDGED
	wound_bonus = 35
	exposed_wound_bonus = 30
	embed_type = /datum/embedding/dumdum
	wound_falloff_tile = -8
	embed_falloff_tile = -20

/datum/embedding/dumdum
	embed_chance = 90
	fall_chance = 3
	jostle_chance = 4
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 5
	jostle_pain_mult = 6
	rip_time = 1 SECONDS
