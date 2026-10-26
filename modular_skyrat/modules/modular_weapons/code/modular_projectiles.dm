/obj/item/ammo_casing
	/// Can this bullet casing be printed at an ammunition workbench?
	var/can_be_printed = TRUE
	/// If it can be printed, does this casing require an advanced ammunition datadisk? Mainly for specialized ammo.
	/// Rubbers aren't advanced. Standard ammo (or FMJ if you're particularly pedantic) isn't advanced.
	/// Think more specialized or weird, niche ammo, like armor-piercing, incendiary, hollowpoint, or God forbid, phasic.
	var/advanced_print_req = FALSE
	/// Optional hex color (e.g. "#d85a30") shown as a tip-dot beside this round in the ammo workbench UI. Null shows a neutral dot.
	var/workbench_tip_color = null

// whatever goblin decided to spread out bullets over like 3 files and god knows however many overrides i wish you a very stubbed toe

/*
*	.45 bullets
*/

/obj/item/ammo_casing/c45/hp
	desc = "一发.45空尖弹。对无甲目标十分致命，但对护甲效果不佳。"
	projectile_type = /obj/projectile/bullet/c45/hp
	advanced_print_req = TRUE

/obj/projectile/bullet/c45/hp
	damage = 40
	weak_against_armour = TRUE

/*
*	.223 bullets
*/

/obj/item/ammo_casing/a223/ap
	name = ".223穿甲弹"
	desc = "一发.223穿甲弹。\
	<br><br>\
	<i>穿甲：提高护甲穿透能力。不然你还想要什么？"
	projectile_type = /obj/projectile/bullet/a223/ap
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_AP

/obj/projectile/bullet/a223/ap
	armour_penetration = 60

/*
*	.34 ACP
*/

// Why? Blame CFA, they want their bullets to be *proprietary*
/obj/item/ammo_casing/c34
	name = ".34子弹"
	desc = "一发.34子弹。"
	caliber = "c34acp"
	projectile_type = /obj/projectile/bullet/c34

/obj/projectile/bullet/c34
	name = ".34子弹"
	damage = 15
	wound_bonus = 0

/obj/item/ammo_casing/c34/ap
	name = ".34穿甲弹"
	desc = "一发.34穿甲弹。"
	caliber = "c34acp"
	projectile_type = /obj/projectile/bullet/c34/ap
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/projectile/bullet/c34/ap
	name = ".34穿甲子弹"
	damage = 15
	armour_penetration = 40
	wound_bonus = -75

/obj/item/ammo_casing/c34_incendiary
	name = ".34燃烧弹"
	desc = "一发.34燃烧弹。"
	caliber = "c34acp"
	projectile_type = /obj/projectile/bullet/incendiary/c34_incendiary
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

/obj/projectile/bullet/incendiary/c34_incendiary
	name = ".34燃烧子弹"
	damage = 8
	fire_stacks = 1
	wound_bonus = -90
