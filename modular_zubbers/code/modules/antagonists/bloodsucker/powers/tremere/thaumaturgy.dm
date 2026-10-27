/**
 *	# Thaumaturgy
 *
 *	Level 1 - One shot bloodbeam spell
 *	Level 2 - Bloodbeam spell - Gives them a Blood shield until they use Bloodbeam
 *	Level 3 - Bloodbeam spell that breaks open lockers/doors - Gives them a Blood shield until they use Bloodbeam
 *	Level 4 - Bloodbeam spell that breaks open lockers/doors + double damage to victims - Gives them a Blood shield until they use Bloodbeam
 *	Level 5 - Bloodbeam spell that breaks open lockers/doors + double damage & steals blood - Gives them a Blood shield until they use Bloodbeam
 */

#define BLOOD_SHIELD_BLOCK_CHANCE 75
#define BLOOD_SHIELD_BLOOD_COST 15
#define THAUMATURGY_BLOOD_COST_PER_CHARGE 5
#define THAUMATURGY_COOLDOWN_PER_CHARGE 5 SECONDS

#define THAUMATURGY_SHIELD_LEVEL 2
#define THAUMATURGY_DOOR_BREAK_LEVEL 3
#define THAUMATURGY_EXTRA_DAMAGE_LEVEL 4
#define THAUMATURGY_BLOOD_STEAL_LEVEL 5
/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy
	name = "血之奇术"
	level_current = 1
	button_icon_state = "power_thaumaturgy"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED
	purchase_flags = TREMERE_CAN_BUY
	// custom cooldown handling based on charges
	power_flags = BP_AM_STATIC_COOLDOWN
	bloodcost = 5
	constant_bloodcost = 0
	// 5 seconds per charge
	cooldown_time = 10 SECONDS
	prefire_message = "右键点击你想射击的位置。"
	click_to_activate = TRUE // you pay to replenish charges
	power_activates_immediately = FALSE
	unset_after_click = FALSE // Lets us cast multiple times
	/// How many times you can shoot before you need to recast
	var/charges = 0
	/// How long it takes before you can shoot again
	var/shot_cooldown = 0
	var/datum/weakref/blood_shield
	var/obj/projectile/magic/arcane_barrage/bloodsucker/magic_9ball

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/Grant()
	charges = get_max_charges()
	. = ..()

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/Remove()
	. = ..()
	var/shield = blood_shield?.resolve()
	if(shield)
		QDEL_NULL(shield)

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/on_power_upgrade()
	cooldown_time = get_max_charges() * THAUMATURGY_COOLDOWN_PER_CHARGE
	bloodcost = get_max_charges() * THAUMATURGY_BLOOD_COST_PER_CHARGE
	// just in case you somehow level up while the power is active
	charges = get_max_charges()
	. = ..()

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/get_power_desc_extended()
	. = "<br>弹体可追踪[get_shot_range()]格。<br>"
	. += "向敌人发射缓慢追踪的血箭。<br>"
	if(level_current >= THAUMATURGY_SHIELD_LEVEL)
		. += "点击按钮生成鲜血护盾。<br>"
	if(level_current >= THAUMATURGY_DOOR_BREAK_LEVEL)
		. += "弹体会打开门和柜子"
	if(level_current >= THAUMATURGY_BLOOD_STEAL_LEVEL)
		. += "，并从目标身上窃取血液。"

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/get_power_explanation_extended()
	. = list()
	. += "血之奇术让你能够施法并发射缓慢追踪目标的血液弹体。"
	. += "瞄准地面时，弹体会自动锁定附近的生物。"
	. += "血箭命中人时会造成[get_blood_bolt_damage()]点[chinese_bloodsucker_damage_display(initial(magic_9ball.damage_type))]伤害，受[chinese_bloodsucker_damage_display(initial(magic_9ball.armor_flag))]护甲抵挡。"
	. += "每次施放血之奇术后可发射[get_max_charges()]次血箭，之后需要重新施法。每次射击后需要等待[DisplayTimeText(get_shot_cooldown())]。"
	. += "达到[THAUMATURGY_SHIELD_LEVEL]级后会给予护盾，抵挡[BLOOD_SHIELD_BLOCK_CHANCE]%的来袭伤害，每次消耗[THAUMATURGY_BLOOD_COST_PER_CHARGE]血量。"
	. += "点击动作按钮即可启用护盾，之后可用右键发射弹体。"
	. += "达到[THAUMATURGY_DOOR_BREAK_LEVEL]级后，还能击破柜子和门。"
	. += "达到[THAUMATURGY_BLOOD_STEAL_LEVEL]级后，还会窃取血液供你吸食，数量与每次发射的消耗相同。"
	. += "每消耗一次充能，冷却时间增加[DisplayTimeText(THAUMATURGY_COOLDOWN_PER_CHARGE)]，每发血箭消耗[THAUMATURGY_BLOOD_COST_PER_CHARGE]血量。"

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/ActivatePower(mob/target)
	. = ..()
	charges = get_max_charges()
	toggle_blood_shield(TRUE)
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/proc/toggle_blood_shield(toggle)
	if(level_current < THAUMATURGY_SHIELD_LEVEL)
		return
	// don't toggle if we're already in the state we want to be in
	if(toggle == !!blood_shield)
		return

	if(blood_shield)
		var/shield = blood_shield?.resolve()
		owner.visible_message(
			span_warning("[owner]的[blood_shield]失去形状，融入手中。"),
			span_warning("我们解除了鲜血护盾！"),
			span_hear("你听到液体晃动的声音。"),
		)
		owner.balloon_alert(owner, "你解除了[shield]")
		qdel(shield)
		blood_shield = null
	else
		var/obj/item/shield/bloodsucker/new_shield = new
		blood_shield = WEAKREF(new_shield)
		if(!owner.put_in_inactive_hand(new_shield))
			QDEL_NULL(new_shield)
			owner.balloon_alert(owner, "副手被占用！")
			to_chat(owner, span_notice("副手被占用，无法启用[capitalize(src)]。"))
			return FALSE
		owner.balloon_alert(owner, "你凝聚了[src]")
		owner.visible_message(
			span_warning("[owner]的双手开始流血，鲜血凝聚成[src]！"),
			span_warning("我们凝聚了[src]！"),
			span_hear("你听到液体聚合的声音。"),
		)

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return
	var/used_charges = get_max_charges() - charges
	toggle_blood_shield(FALSE)
	if(used_charges > 0)
		StartCooldown()

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/StartCooldown(override_cooldown_time, override_melee_cooldown_time)
	var/used_charges = get_max_charges() - charges
	// no cooldown if we didn't use any charges
	if(used_charges <= 0)
		return
	charges = get_max_charges()
	return ..(used_charges * THAUMATURGY_COOLDOWN_PER_CHARGE, override_melee_cooldown_time)

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/proc/get_blood_bolt_damage()
	if(level_current >= THAUMATURGY_EXTRA_DAMAGE_LEVEL)
		return 40
	return 20

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/proc/get_max_charges()
	return level_current * 2

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/proc/get_shot_cooldown()
	return max(1.5 - (level_current * 0.1), 0) SECONDS

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/proc/get_shot_range()
	return initial(magic_9ball.range) + level_current * 10

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/update_button_status(atom/movable/screen/movable/action_button/button, force)
	. = ..()
	if(next_use_time - world.time <= 0)
		button.maptext = MAPTEXT_TINY_UNICODE(span_center("[charges]/[get_max_charges()]"))

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/FireSecondaryTargetedPower(atom/target, params)
	if(shot_cooldown > world.time)
		return
	if(!can_pay_blood(THAUMATURGY_BLOOD_COST_PER_CHARGE))
		owner.balloon_alert(owner, "血量不足！")
		DeactivatePower()
		return
	shot_cooldown = world.time + get_shot_cooldown()
	var/mob/living/user = owner
	owner.balloon_alert(owner, "你发射了一支血箭！")
	owner.visible_message(
		span_warning("[owner]向[target]发射了一支血箭！"),
		span_warning("你向[target]发射了一支血箭！"),
		span_hear("你听到响亮的噼啪声。"),
	)
	user.changeNext_move(CLICK_CD_RANGE)
	user.newtonian_move(get_dir(target, user))
	user.face_atom(target)
	handle_shot(user, target)

	pay_cost(THAUMATURGY_BLOOD_COST_PER_CHARGE)
	playsound(user, 'sound/effects/magic/wand_teleport.ogg', 60, TRUE)
	charges -= 1
	build_all_button_icons(UPDATE_BUTTON_STATUS)
	if(charges <= 0)
		// delay the message so it doesn't overlap with the cooldown message
		addtimer(CALLBACK(owner, TYPE_PROC_REF(/atom, balloon_alert), owner, "充能已用尽！"), 0.5 SECONDS)
		PowerActivatedSuccesfully(cost_override = 0)

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/proc/handle_shot(mob/user, atom/target)
	magic_9ball = new(get_turf(user))
	magic_9ball.firer = user
	magic_9ball.power_ref = WEAKREF(src)
	magic_9ball.damage = get_blood_bolt_damage()
	magic_9ball.def_zone = ran_zone(user.zone_selected, min(level_current * 10, 90))
	magic_9ball.aim_projectile(target, user)
	// autotarget if we aim at a turf
	if(isturf(target))
		var/list/targets = list()
		for(var/mob/living/possible_target in orange(1, target))
			if(!ismob(possible_target))
				continue
			var/datum/antagonist/ghoul/ghoul = IS_GHOUL(possible_target)
			if(length(bloodsuckerdatum_power?.ghouls) && ghoul && (ghoul in bloodsuckerdatum_power?.ghouls))
				continue
			targets += possible_target
		if(length(targets))
			magic_9ball.set_homing_target(pick(targets))
	else if(ismob(target))
		magic_9ball.homing_target = target
	magic_9ball.homing_turn_speed = min(10 * level_current, 90)
	magic_9ball.range = initial(magic_9ball.range) + level_current * 10
	INVOKE_ASYNC(magic_9ball, TYPE_PROC_REF(/obj/projectile, fire))
	// ditch the pointer to reduce harddels
	magic_9ball = null
/**
 * 	# Blood Bolt
 *
 *	This is the projectile this Power will fire.
 */
/obj/projectile/magic/arcane_barrage/bloodsucker
	name = "血箭"
	icon_state = "mini_leaper"
	damage = 1
	wound_bonus = 20
	armour_penetration = 30
	speed = 0.6
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	range = 30
	armor_flag = LASER
	var/datum/weakref/power_ref

/obj/projectile/magic/arcane_barrage/bloodsucker/on_hit(target, blocked = 0, pierce_hit)
	var/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/bloodsucker_power = power_ref?.resolve()
	if(!bloodsucker_power)
		return ..()
	if(istype(target, /obj/structure/closet) && bloodsucker_power.level_current >= THAUMATURGY_DOOR_BREAK_LEVEL)
		var/obj/structure/closet/hit_closet = target
		if(hit_closet)
			hit_closet.welded = FALSE
			hit_closet.locked = FALSE
			hit_closet.broken = TRUE
			hit_closet.update_appearance()
			return ..()
	if(istype(target, /obj/machinery/door) && bloodsucker_power.level_current >= THAUMATURGY_DOOR_BREAK_LEVEL)
		var/obj/machinery/door/hit_airlock = target
		hit_airlock.open(2)
		qdel(src)
		return ..()
	if(ismob(target))
		if(bloodsucker_power.level_current >= THAUMATURGY_BLOOD_STEAL_LEVEL)
			var/mob/living/person_hit = target
			person_hit.blood_volume -= THAUMATURGY_BLOOD_COST_PER_CHARGE
			bloodsucker_power.bloodsuckerdatum_power.AdjustBloodVolume(THAUMATURGY_BLOOD_COST_PER_CHARGE)
		return ..()
	. = ..()

/**
 *	# Blood Shield
 *
 *	The shield spawned when using Thaumaturgy when strong enough.
 *	Copied mostly from '/obj/item/shield/changeling'
 */

/obj/item/shield/bloodsucker
	name = "鲜血护盾"
	desc = "由鲜血构成的护盾，承受攻击时需要消耗血液。"
	item_flags = ABSTRACT | DROPDEL
	icon = 'modular_zubbers/icons/obj/structures/vamp_obj.dmi'
	icon_state = "blood_shield"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/bloodsucker_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/bloodsucker_righthand.dmi'
	block_chance = BLOOD_SHIELD_BLOCK_CHANCE

/obj/item/shield/bloodsucker/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, BLOODSUCKER_TRAIT)

/obj/item/shield/bloodsucker/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner)
	if(bloodsuckerdatum)
		bloodsuckerdatum.AdjustBloodVolume(-BLOOD_SHIELD_BLOOD_COST)
	return ..()

#undef BLOOD_SHIELD_BLOCK_CHANCE
#undef BLOOD_SHIELD_BLOOD_COST
#undef THAUMATURGY_BLOOD_COST_PER_CHARGE
#undef THAUMATURGY_COOLDOWN_PER_CHARGE

#undef THAUMATURGY_SHIELD_LEVEL
#undef THAUMATURGY_DOOR_BREAK_LEVEL
#undef THAUMATURGY_BLOOD_STEAL_LEVEL
#undef THAUMATURGY_EXTRA_DAMAGE_LEVEL
