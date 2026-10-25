/obj/item/gun/energy/event_horizon
	name = "\improper 事件视界反存在光束步枪"
	desc = "纳米传讯那些疯狂的头脑，怀着极大的傲慢与恶意，孕育出了军备竞赛的最终答案——武器化的黑洞，以及将黑洞投射出去的平台。\
		注视这亵渎存在的恶行，你就会明白：对利润的追逐已将一切生命推向了这个可悲的结局——现实本身的毁灭。"
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "esniper"
	inhand_icon_state = null
	worn_icon_state = null
	fire_sound = 'sound/items/weapons/beam_sniper.ogg'
	slot_flags = ITEM_SLOT_BACK
	force = 20 //This is maybe the sanest part of this weapon.
	custom_materials = null
	recoil = 2
	ammo_x_offset = 3
	ammo_y_offset = 3
	modifystate = FALSE
	charge_sections = 1
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = list(/obj/item/ammo_casing/energy/event_horizon)
	selfcharge = TRUE
	light_color = COLOR_STRONG_BLUE
	self_charge_amount = STANDARD_ENERGY_GUN_SELF_CHARGE_RATE * 10
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2.25,
	)

/obj/item/gun/energy/event_horizon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 4)

/obj/item/gun/energy/event_horizon/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)

	if(!HAS_TRAIT(user, TRAIT_USER_SCOPED))
		balloon_alert(user, "必须先开镜！")
		return

	. = ..()
	message_admins("[ADMIN_LOOKUPFLW(user)] 在 [ADMIN_VERBOSEJMP(user)] 发射了一束反存在光束。")

/obj/item/ammo_casing/energy/event_horizon
	projectile_type = /obj/projectile/beam/event_horizon
	select_name = "末日"
	e_cost = LASER_SHOTS(1, STANDARD_CELL_CHARGE)
	fire_sound = 'sound/items/weapons/beam_sniper.ogg'

/obj/projectile/beam/event_horizon
	name = "反存在光束"
	icon_state = null
	hitsound = 'sound/effects/explosion/explosion3.ogg'
	damage = 100 // Does it matter?
	damage_type = BURN
	armor_flag = ENERGY
	range = 150
	jitter = 20 SECONDS
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/tracer/beam_rifle

/* SKYRAT EDIT REMOVE - God
/obj/projectile/beam/event_horizon/on_hit(atom/target, blocked, pierce_hit)
	. = ..()

	// Where we droppin' boys?
	var/turf/rift_loc = get_turf(target)

	// Spawn our temporary rift, then activate it.
	var/obj/reality_tear/temporary/tear = new(rift_loc)
	tear.start_disaster()
	message_admins("[ADMIN_LOOKUPFLW(target)] has been hit by an anti-existential beam at [ADMIN_VERBOSEJMP(rift_loc)], creating a singularity.")
*/
