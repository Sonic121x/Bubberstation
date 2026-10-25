///Defines for the pressure strength of the fist
#define LOW_PRESSURE 1
#define MID_PRESSURE 2
#define HIGH_PRESSURE 3
///Defines for the tank change action
#define TANK_INSERTING 0
#define TANK_REMOVING 1

/obj/item/melee/powerfist
	name = "动力拳套"
	desc = "一只金属护手，顶部装有气动活塞撞锤，让你的拳头多几分「劲道」。"
	icon = 'icons/obj/antags/syndicate_tools.dmi'
	icon_state = "powerfist"
	inhand_icon_state = "powerfist"
	icon_angle = 180
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	attack_verb_continuous = list("敲击", "出拳", "动力拳击")
	attack_verb_simple = list("敲击", "出拳", "动力拳击")
	force = 20
	throwforce = 10
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	armor_type = /datum/armor/melee_powerfist
	resistance_flags = FIRE_PROOF
	/// Delay between attacks
	var/click_delay = 0.15 SECONDS
	/// Pressure level on the fist
	var/fist_pressure_setting = LOW_PRESSURE
	/// Amount of moles per punch
	var/gas_per_fist = 3
	/// Tank used for the gauntlet's piston-ram.
	var/obj/item/tank/internals/tank

/datum/armor/melee_powerfist
	fire = 100
	acid = 40

/obj/item/melee/powerfist/proc/pressure_setting_to_text(fist_pressure_setting)
	switch(fist_pressure_setting)
		if(LOW_PRESSURE)
			return "低"
		if(MID_PRESSURE)
			return "中"
		if(HIGH_PRESSURE)
			return "高"
		else
			CRASH("Invalid pressure setting: [fist_pressure_setting]!")

/obj/item/melee/powerfist/examine(mob/user)
	. = ..()
	if(!in_range(user, src))
		. += span_notice("你得再靠近一些才能看到更多信息。")
		return
	if(tank)
		. += span_notice("[icon2html(tank, user)] 它上面安装着一个[tank]。")
		. += span_notice("可以用<b>螺丝刀</b>拆下。")

	. += span_notice("用<b>扳手</b>调节阀门强度。当前强度为<b>[pressure_setting_to_text(fist_pressure_setting)]</b>级。")

/obj/item/melee/powerfist/wrench_act(mob/living/user, obj/item/tool)
	fist_pressure_setting = fist_pressure_setting >= HIGH_PRESSURE ? LOW_PRESSURE : fist_pressure_setting + 1
	tool.play_tool_sound(src)
	balloon_alert(user, "活塞强度设为[pressure_setting_to_text(fist_pressure_setting)]")
	return TRUE

/obj/item/melee/powerfist/screwdriver_act(mob/living/user, obj/item/tool)
	if(!tank)
		balloon_alert(user, "没有安装气罐")
		return
	update_tank(tank, TANK_REMOVING, user)
	return TRUE

/obj/item/melee/powerfist/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/tank/internals))
		return NONE

	if(tank)
		to_chat(user, span_notice("已经装有气罐了，请先用螺丝刀拆下。"))
		return ITEM_INTERACT_BLOCKING

	if(astype(tool, /obj/item/tank/internals).volume <= 3)
		to_chat(user, span_warning("[tool]对于[src]来说太小了。"))
		return ITEM_INTERACT_BLOCKING

	update_tank(tool, TANK_INSERTING, user)
	return ITEM_INTERACT_SUCCESS

/obj/item/melee/powerfist/proc/update_tank(obj/item/tank/internals/the_tank, removing = TANK_INSERTING, mob/living/carbon/human/user)
	if(removing)
		if(!tank)
			to_chat(user, span_notice("[src]目前没有安装气罐。"))
			return
		to_chat(user, span_notice("你把[the_tank]从[src]上拆下。"))
		tank.forceMove(get_turf(user))
		user.put_in_hands(tank)
		tank = null
		return

	if(tank)
		to_chat(user, span_warning("[src]已经装有气罐了。"))
		return
	if(!user.transferItemToLoc(the_tank, src))
		return
	to_chat(user, span_notice("你把[the_tank]接到[src]上。"))
	tank = the_tank

/obj/item/melee/powerfist/attack(mob/living/target, mob/living/user)
	if(!tank)
		to_chat(user, span_warning("[src]没有气源就无法运作！"))
		return
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("你不想伤害其他活物！"))
		return
	var/turf/our_turf = get_turf(src)
	if(!our_turf)
		return

	var/datum/gas_mixture/gas_used = tank.remove_air(gas_per_fist * fist_pressure_setting)
	if(!gas_used)
		to_chat(user, span_warning("[src]的气罐是空的！"))
		target.apply_damage((force / 5), BRUTE)
		playsound(loc, 'sound/items/weapons/punch1.ogg', 50, TRUE)
		target.visible_message(span_danger("[user]的动力拳套发出一声沉闷的空响，一拳打在[target.name]上！"), \
			span_userdanger("[user]用动力拳打你！"))
		return

	if(!molar_cmp_equals(gas_used.total_moles(), gas_per_fist * fist_pressure_setting))
		our_turf.assume_air(gas_used)
		to_chat(user, span_warning("[src]的活塞撞锤发出微弱的嘶声，它需要更多气体！"))
		playsound(loc, 'sound/items/weapons/punch4.ogg', 50, TRUE)
		target.apply_damage((force / 2), BRUTE)
		target.visible_message(span_danger("[user]的动力拳套发出微弱的嘶声，一拳打在[target.name]上！"), \
			span_userdanger("[user]的一拳力道十足！"))
		return

	target.visible_message(span_danger("[user]的动力拳套发出响亮的嘶声，一拳打在[target.name]上！"), \
		span_userdanger("你痛得叫出声来，[user]的一拳把你打飞出去！"))
	new /obj/effect/temp_visual/kinetic_blast(target.loc)
	target.apply_damage(force * fist_pressure_setting, BRUTE, wound_bonus = CANT_WOUND)
	playsound(src, 'sound/items/weapons/resonator_blast.ogg', 50, TRUE)
	playsound(src, 'sound/items/weapons/genhit2.ogg', 50, TRUE)

	if(!QDELETED(target))
		var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))

		target.throw_at(throw_target, 5 * fist_pressure_setting, 0.5 + (fist_pressure_setting / 2))

	log_combat(user, target, "power fisted", src)

	user.changeNext_move(CLICK_CD_MELEE * click_delay)

	our_turf.assume_air(gas_used)

#undef LOW_PRESSURE
#undef MID_PRESSURE
#undef HIGH_PRESSURE
#undef TANK_INSERTING
#undef TANK_REMOVING
