/obj/item/ammo_box/magazine/wt550m9
	name = "\improper WT-550 弹匣"

/obj/item/ammo_box/magazine/wt550m9/wtap
	name = "WT-550 穿甲弹匣"

/obj/item/ammo_box/magazine/wt550m9/wtic
	name = "WT-550 燃烧弹匣"

/obj/item/ammo_box/magazine/wt550m9/compressed //20% higher damage potential than the standard bullets, but DPS is lower
	name = "压缩 WT-550 弹匣"
	ammo_type = /obj/item/ammo_casing/c46x30mm/compressed
	ammo_band_color = "#00618E"
	max_ammo = 40
	caliber = null
	multitype = FALSE //we don't want people loading these with normal or ap bullets do we

/obj/item/ammo_box/magazine/wt550m9/compressed/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count()/2, 4)]"

/obj/item/ammo_box/magazine/wt550m9/compressed/super
	name = "超压缩 WT-550 弹匣"
	ammo_band_color = "#072E40"
	max_ammo = 60
/obj/item/ammo_box/magazine/wt550m9/compressed/super/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count()/3, 4)]"


/obj/item/ammo_box/magazine/recharge/ntmp5
	name = "大型失能能量包"
	desc = "NT22-HCS-MP“枪骑兵”用可充电能量包。最多可合成二十发能让目标疲惫的 .22HL 弹药。"
	parent_type = /obj/item/ammo_box/magazine/recharge/ntusp
	ammo_type = /obj/item/ammo_casing/caseless/c22hl/ntmp5
	base_icon_state = "powerpack"
	icon_state = "powerpack"
	max_ammo = 20
	custom_materials = null

/obj/item/ammo_box/magazine/recharge/ntmp5/proc/get_charge_overlay_state()
	var/current_ammo = ammo_count()
	if(current_ammo <= 0 || max_ammo <= 0)
		return null
	var/ammo_percent = current_ammo / max_ammo
	var/list/overlay_candidates
	if(ammo_percent < 0.5)
		overlay_candidates = list("powerpack_half", "powerpack-half", "powerpack_half-l", "powerpack-half-l")
	else
		overlay_candidates = list("powerpack-full", "powerpack_full", "powerpack-full-l", "powerpack_full-l")

	for(var/overlay_state in overlay_candidates)
		if(icon_exists(icon, overlay_state))
			return overlay_state

	return null

/obj/item/ammo_box/magazine/recharge/ntmp5/update_icon_state()
	. = ..()
	icon_state = initial(base_icon_state)

/obj/item/ammo_box/magazine/recharge/ntmp5/update_overlays()
	. = ..()
	var/charge_overlay_state = get_charge_overlay_state()
	if(charge_overlay_state)
		. += charge_overlay_state

/obj/item/ammo_box/magazine/recharge/ntmp5/laser
	name = "大型致命能量包"
	desc = "经过改装、供 NT22-HCS-MP“枪骑兵”使用的可充电能量包。最多可合成十六发激光 .22LS 弹药。"
	ammo_type = /obj/item/ammo_casing/caseless/c22ls/ntmp5
	base_icon_state = "powerpack-l"
	icon_state = "powerpack-l"
	max_ammo = 16

/obj/item/ammo_box/magazine/recharge/ntmp5/laser/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/recharge/ntmp5/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/recharge/ntmp5/attackby(obj/item/A, mob/user)
	if(istype(A, /obj/item/ntusp_conversion_kit))
		to_chat(user, span_danger("[A]发出嗡鸣声，改装了\the [src]的透镜，使其能够制造更致命的弹药。"))
		new /obj/item/ammo_box/magazine/recharge/ntmp5/laser/empty(get_turf(src))
		qdel(src)
	else
		return ..()

/obj/item/ammo_box/magazine/recharge/ntmp5/laser/attackby(obj/item/A, mob/user)
	if(istype(A, /obj/item/ntusp_conversion_kit))
		to_chat(user, span_notice("[A]发出嗡鸣声，改装了\the [src]的透镜，使其能够制造更不致命的弹药。"))
		new /obj/item/ammo_box/magazine/recharge/ntmp5/empty(get_turf(src))
		qdel(src)
	else
		return ..()
