/**
 * Weaponry
 */

/obj/item/gun/energy/alien/zeta
	name = "泽塔爆破枪"
	desc = "把它凑得太靠近脸时，你会开始尝到血的味道，这东西真的安全吗？"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/alienblaster.dmi'
	lefthand_file = 'modular_skyrat/modules/awaymissions_skyrat/icons/alienhand.dmi'
	righthand_file = 'modular_skyrat/modules/awaymissions_skyrat/icons/alienhand2.dmi'
	icon_state = "alienblaster"
	inhand_icon_state = "alienblaster"
	pin = /obj/item/firing_pin
	selfcharge = TRUE

/obj/item/gun/energy/alien/astrum
	name = "外星能量手枪"
	desc = "一把看上去结构复杂的枪，其实并没有那么复杂。"
	ammo_type = list(/obj/item/ammo_casing/energy/laser)
	pin = /obj/item/firing_pin
	icon_state = "alienpistol"
	inhand_icon_state = "alienpistol"
	cell_type = /obj/item/stock_parts/power_store/cell/pulse/pistol


/**
 * Armour
 */

/obj/item/clothing/suit/armor/abductor/astrum
	name = "特工背心"
	desc = "你觉得自己把这件套装穿错了，而且完全不知道该怎么操作它的系统。"
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "vest_combat"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/abductor_astrum
	resistance_flags = FIRE_PROOF | ACID_PROOF
	allowed = null // populated on init with armour vest defaults

/datum/armor/abductor_astrum
	melee = 40
	bullet = 50
	laser = 50
	energy = 50
	bomb = 20
	bio = 50
	fire = 90
	acid = 90

/obj/item/clothing/head/helmet/astrum
	name = "特工头盔"
	desc = "一顶格外坚固的头盔。以异星人的标准来说，确实如此。"
	icon_state = "alienhelmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	armor_type = /datum/armor/helmet_astrum
	resistance_flags = FIRE_PROOF | ACID_PROOF

/datum/armor/helmet_astrum
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 50
	bio = 90
	fire = 100
	acid = 100
	wound = 15
