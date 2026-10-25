
// Makarov (9mm) //

/obj/item/ammo_box/magazine/m9mm
	name = "手枪弹匣（9mm）"
	icon_state = "9x19p"
	base_icon_state = "9x19p"
	desc = "一个 9mm 手枪弹匣，适用于马卡洛夫手枪。"
	ammo_band_icon = "+9x19ab"
	ammo_band_color = null
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 12
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/m9mm/security
	name = "手枪弹匣（9mm 安保型）"
	desc = "一个 9mm 手枪弹匣，适用于勤务手枪。"
	ammo_type = /obj/item/ammo_casing/c9mm/security
	max_ammo = 10

/obj/item/ammo_box/magazine/m9mm/security/rocket
	name = "手枪弹匣（9mm 安保型）"
	desc = "一个 9mm 手枪弹匣，适用于勤务手枪。"
	ammo_type = /obj/item/ammo_casing/c9mm/security
	max_ammo = 8

/obj/item/ammo_box/magazine/m9mm/security/rocket/throw_impact(mob/living/hit_mob, datum/thrownthing/throwingdatum)
	. = ..()
	if(!QDELETED(hit_mob))
		hit_mob.Knockdown(2 SECONDS)
		hit_mob.adjust_brute_loss(40)
	qdel()

/obj/item/ammo_box/magazine/m9mm/fire
	name = "手枪弹匣（9mm 燃烧弹）"
	MAGAZINE_TYPE_INCENDIARY
	ammo_type = /obj/item/ammo_casing/c9mm/fire

/obj/item/ammo_box/magazine/m9mm/hp
	name = "手枪弹匣（9mm 空尖弹）"
	MAGAZINE_TYPE_HOLLOWPOINT
	ammo_type = /obj/item/ammo_casing/c9mm/hp

/obj/item/ammo_box/magazine/m9mm/ap
	name = "手枪弹匣（9mm 穿甲弹）"
	MAGAZINE_TYPE_ARMORPIERCE
	ammo_type = /obj/item/ammo_casing/c9mm/ap

// Stechkin APS (9mm) //

/obj/item/ammo_box/magazine/m9mm_aps
	name = "斯捷奇金手枪弹匣（9mm）"
	desc = "一个 9mm 手枪弹匣，适用于斯捷奇金 APS 全自动手枪。"
	icon_state = "9mmaps-15"
	base_icon_state = "9mmaps"
	ammo_band_icon = "+9mmapsab"
	ammo_band_color = null
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 15

/obj/item/ammo_box/magazine/m9mm_aps/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 5)]"

/obj/item/ammo_box/magazine/m9mm_aps/fire
	name = "斯捷奇金手枪弹匣（9mm 燃烧弹）"
	MAGAZINE_TYPE_INCENDIARY
	ammo_type = /obj/item/ammo_casing/c9mm/fire

/obj/item/ammo_box/magazine/m9mm_aps/hp
	name = "斯捷奇金手枪弹匣（9mm 空尖弹）"
	MAGAZINE_TYPE_HOLLOWPOINT
	ammo_type = /obj/item/ammo_casing/c9mm/hp

/obj/item/ammo_box/magazine/m9mm_aps/ap
	name = "斯捷奇金手枪弹匣（9mm 穿甲弹）"
	MAGAZINE_TYPE_ARMORPIERCE
	ammo_type = /obj/item/ammo_casing/c9mm/ap

// Ansem (10mm) //

/obj/item/ammo_box/magazine/m10mm
	name = "手枪弹匣（10mm）"
	desc = "一个 10mm 手枪弹匣，适用于安瑟姆手枪。"
	icon_state = "9x19p"
	base_icon_state = "9x19p"
	ammo_band_icon = "+9x19ab"
	ammo_band_color = null

	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/m10mm/fire
	name = "手枪弹匣（10mm 燃烧弹）"
	MAGAZINE_TYPE_INCENDIARY
	ammo_type = /obj/item/ammo_casing/c10mm/fire

/obj/item/ammo_box/magazine/m10mm/hp
	name = "手枪弹匣（10mm 空尖弹）"
	MAGAZINE_TYPE_HOLLOWPOINT
	ammo_type = /obj/item/ammo_casing/c10mm/hp

/obj/item/ammo_box/magazine/m10mm/ap
	name = "手枪弹匣（10mm 穿甲弹）"
	MAGAZINE_TYPE_ARMORPIERCE
	ammo_type = /obj/item/ammo_casing/c10mm/ap

// M1911 (.45) //

/obj/item/ammo_box/magazine/m45
	name = "手枪弹匣（.45）"
	desc = "一个 .45 手枪弹匣，适用于 M1911。"
	icon_state = "45-8"
	base_icon_state = "45"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = CALIBER_45
	max_ammo = 8
	multiple_sprites = AMMO_BOX_PER_BULLET
	multiple_sprite_use_base = TRUE

// Desert Eagle (.50 AE) //

/obj/item/ammo_box/magazine/m50
	name = "手枪弹匣（.50 AE）"
	desc = "一个 .50 AE 手枪弹匣，适用于沙漠之鹰。"
	icon_state = "50ae"
	ammo_type = /obj/item/ammo_casing/a50ae
	caliber = CALIBER_50AE
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET

// Regal Condor (.45) //

/obj/item/ammo_box/magazine/r45
	name = "皇家秃鹫弹匣（.45 收割者）"
	desc = "一个极其昂贵的 .45 手枪弹匣，适用于皇家秃鹫。装填有“收割者”弹，对任何目标都危险地有效。"
	icon_state = "r45-8"
	base_icon_state = "r45"
	ammo_type = /obj/item/ammo_casing/c45/reaper
	caliber = CALIBER_45
	max_ammo = 8
	multiple_sprites = AMMO_BOX_PER_BULLET
	multiple_sprite_use_base = TRUE
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 10,
	)
