/obj/item/mecha_ammo
	name = "通用弹药箱"
	desc = "一箱供未知武器使用的弹药。"
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/obj/weapons/guns/mecha_ammo.dmi'
	icon_state = "empty"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	var/rounds = 0
	var/direct_load //For weapons where we re-load the weapon itself rather than adding to the ammo storage.
	var/load_audio = 'sound/items/weapons/gun/general/mag_bullet_insert.ogg'
	var/ammo_type
	/// whether to qdel this mecha_ammo when it becomes empty
	var/qdel_on_empty = FALSE

/obj/item/mecha_ammo/update_name()
	. = ..()
	name = "[rounds ? null : "空的"][initial(name)]"

/obj/item/mecha_ammo/update_desc()
	. = ..()
	desc = rounds ? initial(desc) : "一个已被清空的机甲弹药箱。可以安全折叠以便回收。"

/obj/item/mecha_ammo/update_icon_state()
	icon_state = rounds ? initial(icon_state) : "[initial(icon_state)]_e"
	return ..()

/obj/item/mecha_ammo/attack_self(mob/user)
	..()
	if(rounds)
		to_chat(user, span_warning("弹药箱没空之前不能压平！"))
		return

	to_chat(user, span_notice("你把 [src] 压平了。"))
	var/trash = new /obj/item/stack/sheet/iron(user.loc)
	qdel(src)
	user.put_in_hands(trash)

/obj/item/mecha_ammo/examine(mob/user)
	. = ..()
	if(rounds)
		. += "还剩 [rounds] [ammo_type]。"
	else
		. += span_notice("在手上使用可将其折叠成一张铁板。")

/obj/item/mecha_ammo/incendiary
	name = "燃烧弹药箱"
	desc = "一箱供机甲武器使用的燃烧弹药。"
	icon_state = "incendiary"
	custom_materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT*3)
	rounds = 24
	ammo_type = MECHA_AMMO_INCENDIARY

/obj/item/mecha_ammo/scattershot
	name = "散射弹弹药箱"
	desc = "一箱放大的霰弹，供机甲霰弹枪使用。"
	icon_state = "scattershot"
	custom_materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT*3)
	rounds = 40
	ammo_type = MECHA_AMMO_BUCKSHOT

/obj/item/mecha_ammo/lmg
	name = "机枪弹药箱"
	desc = "一箱弹链供弹，专为 Ultra AC 2 机甲武器设计。"
	icon_state = "lmg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2)
	rounds = 300
	ammo_type = MECHA_AMMO_LMG

/// Missile Ammo
/// SRM-8 Missile type - Used by Nuclear Operatives
/obj/item/mecha_ammo/missiles_srm
	name = "短程导弹"
	desc = "一箱大型导弹，可装入 SRM-8 机甲导弹发射架。"
	icon_state = "missile_he"
	rounds = 8
	direct_load = TRUE
	load_audio = 'sound/items/weapons/gun/general/mag_bullet_insert.ogg'
	ammo_type = MECHA_AMMO_MISSILE_SRM

/// PEP-6 Missile type - Used by Robotics
/obj/item/mecha_ammo/missiles_pep
	name = "精确爆破导弹"
	desc = "一箱大型导弹，可装入 PEP-6 机甲导弹发射架。"
	icon_state = "missile_br"
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*4,/datum/material/gold=SMALL_MATERIAL_AMOUNT*5)
	rounds = 6
	direct_load = TRUE
	load_audio = 'sound/items/weapons/gun/general/mag_bullet_insert.ogg'
	ammo_type = MECHA_AMMO_MISSILE_PEP

/obj/item/mecha_ammo/flashbang
	name = "可发射闪光弹"
	desc = "一箱光滑的闪光弹，供大型机甲发射器使用。无法用手直接引爆。"
	icon_state = "flashbang"
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*2,/datum/material/gold=SMALL_MATERIAL_AMOUNT*5)
	rounds = 6
	ammo_type = MECHA_AMMO_FLASHBANG

/obj/item/mecha_ammo/clusterbang
	name = "可发射集束闪光弹"
	desc = "一箱集束闪光弹，供专用机甲集束发射器使用。无法用手直接引爆。"
	icon_state = "clusterbang"
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*3,/datum/material/gold=HALF_SHEET_MATERIAL_AMOUNT * 1.5,/datum/material/uranium=HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	rounds = 3
	direct_load = TRUE
	ammo_type = MECHA_AMMO_CLUSTERBANG
