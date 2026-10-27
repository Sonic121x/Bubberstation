/obj/item/gun/ballistic/toy/foamforce_implant
	name = "\improper 弹出式咚克软玩具枪"
	desc = "一把弹簧上膛的咚克软玩具枪，会从你手臂上的面板里弹出来。你不禁琢磨，在手臂里装一根高张力弹簧究竟算不算个好主意。"
	icon = 'modular_zubbers/icons/obj/guns/popupdart_toy.dmi' //modified Derringer sprite by the wonderful Niim. Further modified by myself/MrGloopy.
	icon_state = "popupdart_toy"
	force = 0
	throwforce = 0
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/foamforce_implant
	item_flags = NONE

//JAM CODE
	var/jammed = FALSE
	var/can_jam = TRUE
	var/jamming_chance = 10
	var/unjam_chance = 50
	var/draw_time = 1.3 SECONDS

/obj/item/gun/ballistic/toy/foamforce_implant/attack_self(mob/user)
	if(jammed)
		if(prob(unjam_chance))
			jammed = FALSE
			unjam_chance = initial(unjam_chance)
		else
			balloon_alert(user, "卡壳了！")
			playsound(user,'sound/items/weapons/jammed.ogg', 75, TRUE)
			return FALSE
	return ..()

/obj/item/gun/ballistic/toy/foamforce_implant/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(can_jam)
		if(chambered.loaded_projectile)
			if(prob(jamming_chance))
				jammed = TRUE
			jamming_chance = clamp (jamming_chance, 0, 100)
	return ..()
//JAM CODE END

//RACKING CODE
/obj/item/gun/ballistic/toy/foamforce_implant/rack(mob/user = null)
	if (bolt_locked)
		drop_bolt(user)
		return
	balloon_alert(user, "推杆已释放")
	playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
	handle_chamber(empty_chamber =  FALSE, from_firing = FALSE, chamber_next_round = FALSE)
	bolt_locked = TRUE
	update_appearance()

/obj/item/gun/ballistic/toy/foamforce_implant/drop_bolt(mob/user = null)
	if(!do_after(user, draw_time, target = src))
		return
	playsound(src, bolt_drop_sound, bolt_drop_sound_volume, FALSE)
	balloon_alert(user, "推杆已拉动")
	chamber_round()
	bolt_locked = FALSE
	update_appearance()

/obj/item/gun/ballistic/toy/foamforce_implant/shoot_live_shot(mob/living/user)
	..()
	rack()

/obj/item/gun/ballistic/toy/foamforce_implant/can_shoot()
	if (bolt_locked)
		return FALSE
	return ..()

/obj/item/gun/ballistic/toy/foamforce_implant/shoot_with_empty_chamber(mob/living/user)
	if(chambered || !magazine || !length(magazine.contents))
		return ..()
	drop_bolt(user)

/obj/item/gun/ballistic/toy/foamforce_implant/examine(mob/user)
	. = ..()
	. += "发射器[bolt_locked ? "尚未准备好" : "已准备好"]开火。"

/obj/item/gun/ballistic/toy/foamforce_implant/update_overlays()
	. = ..()
	if(!bolt_locked)
		. += "[initial(icon_state)]" + "_bolt_locked"
//RACKING CODE END

//AUDIO
	fire_sound = 'sound/items/syringeproj.ogg'
	load_sound = 'sound/items/weapons/gun/general/mag_bullet_insert.ogg'
	load_sound_vary = TRUE
	rack_sound_volume = 50
	rack_sound = 'sound/items/weapons/gun/sniper/rack.ogg'
	bolt_drop_sound = 'sound/items/weapons/gun/rifle/bolt_in.ogg'
	fire_delay = 7
	sound_vary = TRUE
	rack_sound_vary = TRUE
	click_on_low_ammo = FALSE
	internal_magazine = TRUE
	casing_ejector = FALSE
//HANDLING
	clumsy_check = FALSE
	casing_ejector = FALSE
	can_suppress = FALSE
	weapon_weight = WEAPON_LIGHT
	pb_knockback = 0
	cartridge_wording = "飞镖"
	pinless = TRUE
	gun_flags = NOT_A_REAL_GUN
	can_muzzle_flash = FALSE
	bolt_type = BOLT_TYPE_OPEN
	semi_auto = FALSE
	can_be_sawn_off = FALSE
	tac_reloads = FALSE
	bolt_wording = "推杆"
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	mag_display = FALSE
