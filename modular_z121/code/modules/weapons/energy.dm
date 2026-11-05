#define GRENADE_SMOKE_RANGE 1

/obj/item/gun/energy/bolt_acr
	name = "核裂变反应堆步枪"
	desc = "这他妈是什么鬼东西？"
	icon = 'modular_z121/icons/weapons/guns.dmi'
	lefthand_file = 'modular_z121/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_z121/icons/weapons/righthand.dmi'
	worn_icon = 'modular_z121/icons/weapons/worn.dmi'
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	inhand_icon_state = "boltacr"
	icon_state = "boltacr"
	worn_icon_state = "boltacr"
	base_icon_state = "boltacr"
	fire_sound = 'modular_z121/sound/weapons/bolt.wav'
	cell_type = /obj/item/stock_parts/power_store/cell
	charge_delay = 5
	ammo_type = list(/obj/item/ammo_casing/energy/bolt_acr)
	custom_materials = list(/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 10, \
						/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 7.5, \
						/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5)
	modifystate = FALSE
	automatic_charge_overlays = FALSE
	single_shot_type_overlay = FALSE
	display_empty = FALSE
	can_select = FALSE
	fire_delay = 3 SECONDS
	force = 17
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	selfcharge = TRUE
	fire_sound_volume = 50

/obj/item/gun/energy/bolt_acr/update_icon_state(mob/user, burst_fire)
	flick("boltacr_firing", src)
	return ..()

/obj/item/ammo_casing/energy/bolt_acr
	fire_sound = 'modular_z121/sound/weapons/bolt.wav'
	select_name = "大开杀戒"
	e_cost = 1000
	projectile_type = /obj/projectile/beam/bolt_acr

/obj/projectile/beam/bolt_acr
	icon = 'modular_z121/icons/weapons/effects.dmi'
	icon_state = "u_laser"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE | PASSBLOB | PASSCLOSEDTURF | PASSMACHINE | PASSSTRUCTURE | PASSDOORS
	pass_flags_self = PASSTABLE | PASSGLASS | PASSGRILLE | PASSBLOB | PASSCLOSEDTURF | PASSMACHINE | PASSSTRUCTURE | PASSDOORS
	light_range = 2
	light_power = 3
	light_color = LIGHT_COLOR_LIGHT_CYAN
	//should never happen
	ricochets_max = 1
	ricochet_chance = 100
	range = 3
	damage = 15
	damage_type = TOX
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	muzzle_type = /obj/effect/projectile/muzzle/disabler
	tracer_type = null
	impact_type = null

/obj/projectile/beam/bolt_acr/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(. && isliving(target))
		var/mob/living/living_target = target
		living_target.add_client_colour(/datum/client_colour/glass_colour/blue)
		addtimer(CALLBACK(living_target, /mob/proc/remove_client_colour, /datum/client_colour/glass_colour/blue), 0.5 SECONDS)

/obj/projectile/beam/bolt_acr/on_hit(atom/target, blocked = 0, pierce_hit)
	..()
	fuse_activation(target)
	return BULLET_ACT_HIT

/obj/projectile/beam/bolt_acr/on_range()
	fuse_activation(get_turf(src))
	return ..()

/// Generic proc that is called when the projectile should 'detonate', being either on impact or when the range runs out
/obj/projectile/beam/bolt_acr/proc/fuse_activation(atom/target)
	do_chem_smoke(GRENADE_SMOKE_RANGE, src, src, /datum/reagent/toxin/polonium/bolt, 30, smoke_type = /datum/effect_system/fluid_spread/smoke/chem/bolt)
	return

/obj/effect/particle_effect/fluid/smoke/chem/bolt
	name = "放射性烟雾"
	color = LIGHT_COLOR_LIGHT_CYAN
	lifetime = 4 SECONDS
	opacity = FALSE

/datum/effect_system/fluid_spread/smoke/chem/bolt
	effect_type = /obj/effect/particle_effect/fluid/smoke/chem/bolt

/datum/reagent/toxin/polonium/bolt
	color = LIGHT_COLOR_LIGHT_CYAN
