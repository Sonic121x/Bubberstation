/*
*	.310 Strilka
*/

/obj/item/ammo_casing/strilka310/ap
	name = ".310飞箭穿甲弹"
	desc = "一发.310穿甲弹。注意，它实际上没有弹壳。\
	<br><br>\
	<i>穿甲：以降低直接伤害为代价，提高护甲穿透能力。</i>"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/xhihao_light_arms/ammo.dmi'
	icon_state = "310-casing-ap"

	projectile_type = /obj/projectile/bullet/strilka310/ap
	custom_materials = AMMO_MATS_AP
	can_be_printed = FALSE

/obj/projectile/bullet/strilka310/ap
	name = ".310穿甲子弹"
	damage = 50
	armour_penetration = 60
