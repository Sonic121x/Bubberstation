/obj/vehicle/sealed/mecha/durand
	desc = "纳米传讯公司使用的一种老旧战斗机甲。最初为对抗敌意外星生命体而研发。"
	name = "\improper 杜兰德"
	icon_state = "durand"
	base_icon_state = "durand"
	movedelay = 4
	max_integrity = 400
	accesses = list(ACCESS_MECH_SCIENCE, ACCESS_MECH_SECURITY)
	armor_type = /datum/armor/mecha_durand
	max_temperature = 30000
	force = 40
	destruction_sleep_duration = 40
	exit_delay = 40
	wreckage = /obj/structure/mecha_wreckage/durand
	mech_type = EXOSUIT_MODULE_DURAND
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 3,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)

	/// Bool for energy shield on/off
	var/defense_mode = FALSE
	/// Fake shield object we use as a way to redirect attacks off ourselves
	var/obj/durand_shield/shield = null
	/// Is the shield currently switching modes?
	var/switching = FALSE

/datum/armor/mecha_durand
	melee = 40
	bullet = 35
	laser = 15
	energy = 10
	bomb = 20
	fire = 100
	acid = 100

/obj/vehicle/sealed/mecha/durand/Initialize(mapload)
	. = ..()
	shield = new(src, src)
	vis_contents += shield

/obj/vehicle/sealed/mecha/durand/Destroy()
	if(shield)
		QDEL_NULL(shield)
	return ..()

/obj/vehicle/sealed/mecha/durand/generate_actions()
	. = ..()
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mech_defense_mode)

/obj/vehicle/sealed/mecha/durand/process()
	. = ..()
	// Defence mode can only be on with a occupant so we check if one of them can toggle it and toggle
	if(defense_mode && !use_energy(0.01 * STANDARD_CELL_CHARGE))
		toggle_defense()

/obj/vehicle/sealed/mecha/durand/mob_exit(mob/M, silent = FALSE, randomstep = FALSE, forced = FALSE)
	if(defense_mode)
		toggle_defense()
	return ..()

//Redirects projectiles to the shield if defense_check decides they should be blocked and returns true.
/obj/vehicle/sealed/mecha/durand/projectile_hit(obj/projectile/hitting_projectile, def_zone, piercing_hit, blocked)
	if(defense_check(hitting_projectile.loc) && shield)
		return shield.projectile_hit(hitting_projectile, def_zone, piercing_hit, blocked)
	return ..()

/**
 * Checks if defense mode is enabled, and if the attacker is standing in an area covered by the shield.
 * Expects a turf. Returns true if the attack should be blocked, false if not.
 **/
/obj/vehicle/sealed/mecha/durand/proc/defense_check(turf/aloc)
	if (!defense_mode || !shield || switching)
		return FALSE

	switch(dir)
		if (NORTH)
			return abs(x - aloc.x) <= (y - aloc.y) * -2
		if (SOUTH)
			return abs(x - aloc.x) <= (y - aloc.y) * 2
		if (EAST)
			return abs(y - aloc.y) <= (x - aloc.x) * -2
		if (WEST)
			return abs(y - aloc.y) <= (x - aloc.x) * 2

/obj/vehicle/sealed/mecha/durand/proc/toggle_defense(mob/living/user)
	if(!LAZYLEN(occupants))
		return

	if(switching && (user || !defense_mode)) // Allow force shutdowns during animation
		return

	if(!defense_mode && cell?.charge < 100) // If it's off, and we have less than 100 units of power
		if (user)
			balloon_alert(user, "电力不足")
		return

	switching = TRUE
	defense_mode = !defense_mode

	if(user)
		balloon_alert(user, "护盾[defense_mode ? "已启用" : "已停用"]")
		log_message("用户切换了防御模式——现为[defense_mode ? "已启用" : "已停用"]。", LOG_MECHA)
	else
		log_message("防御模式状态已改变——现为[defense_mode ? "已启用" : "已停用"]。", LOG_MECHA)

	for(var/mob/living/occupant as anything in occupants)
		var/datum/action/button = occupant_actions[occupant][/datum/action/vehicle/sealed/mecha/mech_defense_mode]
		button.button_icon_state = "mech_defense_mode_[defense_mode ? "on" : "off"]"
		button.build_all_button_icons()

	shield.set_light_on(defense_mode)

	if(defense_mode)
		shield.icon_state = "shield"
		flick("shield_raise", shield)
		playsound(src, 'sound/vehicles/mecha/mech_shield_raise.ogg', 50, FALSE)
	else
		shield.icon_state = "shield_null"
		flick("shield_drop", shield)
		playsound(src, 'sound/vehicles/mecha/mech_shield_drop.ogg', 50, FALSE)

	addtimer(VARSET_CALLBACK(src, switching, FALSE), 0.7 SECONDS) // Shield animation length

/obj/vehicle/sealed/mecha/durand/attack_generic(mob/user, damage_amount = 0, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, armor_penetration = 0)
	if(defense_check(get_turf(user)))
		log_message("攻击被防御场吸收。攻击者——[user]。", LOG_MECHA, color="orange")
		return shield.attack_generic(user, damage_amount, damage_type, damage_flag, sound_effect, armor_penetration)
	return ..()

/obj/vehicle/sealed/mecha/durand/blob_act(obj/structure/blob/blob)
	if(!defense_check(get_turf(blob)))
		return ..()
	log_message("受到变形菌攻击。攻击者——[blob]。", LOG_MECHA, color="red")
	log_message("攻击被防御场吸收。", LOG_MECHA, color="orange")
	return shield.blob_act(blob)

/obj/vehicle/sealed/mecha/durand/attackby(obj/item/weapon, mob/user as mob, list/modifiers, list/attack_modifiers)
	if(defense_check(get_turf(user)))
		log_message("攻击被防御场吸收。攻击者——[user]，持有 [weapon]。", LOG_MECHA, color="orange")
		return shield.attackby(weapon, user, modifiers)
	return ..()

/obj/vehicle/sealed/mecha/durand/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	if(defense_check(get_turf(AM)))
		log_message("[AM] 的撞击被防御场吸收。", LOG_MECHA, color="orange")
		return shield.hitby(AM, skipcatch, hitpush, blocked, throwingdatum)
	return ..()

/datum/action/vehicle/sealed/mecha/mech_defense_mode
	name = "切换护盾"
	desc = "切换一面能量护盾，可格挡来自面朝方向的所有攻击，但耗电巨大。"
	button_icon_state = "mech_defense_mode_off"

/datum/action/vehicle/sealed/mecha/mech_defense_mode/Trigger(mob/clicker, trigger_flags, forced_state = FALSE)
	. = ..()
	if(!.)
		return
	if(chassis && (owner in chassis.occupants))
		var/obj/vehicle/sealed/mecha/durand/durand = chassis
		durand.toggle_defense(owner)

// Shield processing

/**
 * An object to take the hit for us when using the Durand's defense mode.
 * It is spawned in during the durand's initilization.
 * Normally invisible, until defense mode is actvated. When the durand detects an attack that should be blocked, the
 * attack is passed to the shield. The shield takes the damage, uses it to calculate charge cost, and then sets its
 * own integrity back to max. Shield is automatically dropped if we run out of power or the user gets out.
 **/

/obj/durand_shield //projectiles get passed to this when defense mode is enabled
	name = "防御网格"
	icon = 'icons/mob/effects/durand_shield.dmi'
	icon_state = "shield_null"
	pixel_z = 4
	max_integrity = 10000
	anchored = TRUE
	light_system = OVERLAY_LIGHT
	light_range = 2.8
	light_power = 1
	light_color = LIGHT_COLOR_FAINT_CYAN
	light_on = FALSE
	light_flags = LIGHT_ATTACHED
	vis_flags = VIS_INHERIT_DIR | VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_INHERIT_ID
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF // The shield should not take damage from fire, lava, or acid; that's the mech's job.
	/// Our link back to the durand
	var/obj/vehicle/sealed/mecha/durand/chassis

/obj/durand_shield/Initialize(mapload, obj/vehicle/sealed/mecha/durand/chassis)
	. = ..()
	src.chassis = chassis

/obj/durand_shield/Destroy()
	if(chassis)
		chassis.shield = null
		chassis = null
	return ..()

/obj/durand_shield/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	if(!chassis)
		qdel(src)
		return
	if(!chassis.defense_mode) //if defense mode is disabled, we're taking damage that we shouldn't be taking
		return
	. = ..()
	flick("shield_impact", src)
	if(!.)
		return
	if(!chassis.use_energy(. * (STANDARD_CELL_CHARGE / 150)))
		chassis.cell?.charge = 0
		chassis.toggle_defense()
	atom_integrity = 10000

/obj/durand_shield/play_attack_sound()
	playsound(src, 'sound/vehicles/mecha/mech_shield_deflect.ogg', 100, TRUE)

/obj/durand_shield/bullet_act()
	play_attack_sound()
	. = ..()
