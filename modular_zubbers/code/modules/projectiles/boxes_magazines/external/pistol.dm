/obj/item/ammo_box/magazine/security
	name = "手枪弹匣（9mm 墨菲）"
	desc = "9mm 手枪弹匣，适用于纳米传讯制式手枪。它配备了比普通弹匣更坚固的弹簧，还额外增加了配重。"
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/magazine.dmi'
	icon_state = "9x19p"
	base_icon_state = "9x19p"
	ammo_type = /obj/item/ammo_casing/security
	caliber = CALIBER_9MM_SEC
	max_ammo = 14
	ammo_band_color = null
	multiple_sprites = AMMO_BOX_PER_BULLET
	multiple_sprite_use_base = TRUE
	var/murphy_eject_sound = 'sound/items/weapons/throwhard.ogg'
	var/was_ejected = 0

/obj/item/ammo_box/magazine/security/rocket
	name = "手枪弹匣（9mm 墨菲 火箭抛壳）"
	desc = parent_type::desc + "内部装有小型装药，抛壳时会迸出火花；这种弹匣装弹量更少，但抛出的弹壳具有致命的速度。"
	ammo_type = /obj/item/ammo_casing/security
	max_ammo = 10
	base_icon_state = "9x19pI"
	murphy_eject_sound = 'sound/items/weapons/gun/general/rocket_launch.ogg'

/obj/item/ammo_box/magazine/security/rocket/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(QDELETED(src))
		return
	if(was_ejected)
		playsound(get_turf(src.loc), 'sound/effects/explosion/explosion1.ogg', 40, 1)
		visible_message(span_warning("[src]在冲击力下碎裂成废铁"))
		if(isliving(hit_atom))
			var/mob/living/hit_mob = hit_atom
			hit_mob.Knockdown(2 SECONDS)
			hit_mob.apply_damage(40, BRUTE, BODY_ZONE_CHEST)
		qdel(src)

/obj/item/ammo_box/magazine/recharge/ntusp
	name = "小型失能能量包"
	desc = "NT22-HCS“执法者”用的小型可充电能量包。最多可合成十二发能让目标疲惫的 .22HL 弹药。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/ammo.dmi'
	base_icon_state = "powerpack_small"
	icon_state = "powerpack_small-12"
	ammo_type = /obj/item/ammo_casing/caseless/c22hl
	max_ammo = 12
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)

/obj/item/ammo_box/magazine/recharge/ntusp/laser
	name = "小型致命能量包"
	desc = "经过改装、供 NT22-HCS“执法者”使用的小型可充电能量包。最多可合成八发激光 .22LS 弹药。"
	ammo_type = /obj/item/ammo_casing/caseless/c22ls
	base_icon_state = "powerpack_small-l"
	icon_state = "powerpack_small-l-8"
	max_ammo = 8

/obj/item/ammo_box/magazine/recharge/ntusp/laser/empty
	start_empty = TRUE // so you cant field convert mags to full laser ones
	custom_materials = null

/obj/item/ammo_box/magazine/recharge/ntusp/empty
	start_empty = TRUE
	custom_materials = null

/obj/item/ammo_box/magazine/recharge/ntusp/emp_act(severity) //shooting physical bullets wont stop you dying to an EMP
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		var/bullet_count = ammo_count()
		var/bullets_to_remove = round(bullet_count / severity)
		for(var/i = 0; i < bullets_to_remove; i++)
			qdel(get_round())
		update_icon()

/obj/item/ammo_box/speedloader/security
	name = "快速装弹器（9mm 墨菲）"
	desc = "用于快速为五发装 9mm 左轮手枪装弹。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/ammo.dmi'
	icon_state = "9mm"
	base_icon_state = "9mm"
	ammo_type = /obj/item/ammo_casing/security
	caliber = CALIBER_9MM_SEC
	max_ammo = 5
	ammo_band_icon = null
	ammo_band_color = null
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/plastic = SHEET_MATERIAL_AMOUNT)

/obj/item/ammo_box/speedloader/security/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-base"

/obj/item/ammo_box/speedloader/security/update_overlays()
	. = ..()
	if(!LAZYLEN(stored_ammo))
		return
	for(var/inserted_ammo in 1 to stored_ammo.len)
		. += "9mm-revolver-[inserted_ammo]"

/obj/item/ammo_box/magazine/r45
	caliber = CALIBER_45
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/telecrystal = SHEET_MATERIAL_AMOUNT,
	)

/obj/item/ammo_box/speedloader/c38/c32
	name = "快速装弹器（.32）"
	desc = "用于快速为六发装 .32 左轮手枪装弹。"
	ammo_type = /obj/item/ammo_casing/c38/c32
	caliber = CALIBER_32
