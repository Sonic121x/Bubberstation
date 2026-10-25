#define HUG_MODE_NICE 0
#define HUG_MODE_HUG 1
#define HUG_MODE_SHOCK 2
#define HUG_MODE_CRUSH 3

#define HUG_SHOCK_COOLDOWN (2 SECONDS)
#define HUG_CRUSH_COOLDOWN (1 SECONDS)

#define HARM_ALARM_NO_SAFETY_COOLDOWN (60 SECONDS)
#define HARM_ALARM_SAFETY_COOLDOWN (20 SECONDS)

/obj/item/borg
	icon = 'icons/mob/silicon/robot_items.dmi'
	abstract_type = /obj/item/borg

/// Cost to use the stun arm
#define CYBORG_STUN_CHARGE_COST (0.2 * STANDARD_CELL_CHARGE)

/obj/item/borg/stun
	name = "带电手臂"
	icon_state = "elecarm"
	var/stamina_damage = 60 //Same as normal batong
	var/cooldown_check = 0
	/// cooldown between attacks
	var/cooldown = 4 SECONDS // same as baton

/obj/item/borg/stun/attack(mob/living/attacked_mob, mob/living/user)
	if(cooldown_check > world.time)
		user.balloon_alert(user, "仍在充能！")
		return
	if(ishuman(attacked_mob))
		var/mob/living/carbon/human/human = attacked_mob
		if(human.check_block(src, 0, "[attacked_mob]的[name]", MELEE_ATTACK))
			playsound(attacked_mob, 'sound/items/weapons/genhit.ogg', 50, TRUE)
			return FALSE
	if(iscyborg(user))
		var/mob/living/silicon/robot/robot_user = user
		if(!robot_user.cell.use(CYBORG_STUN_CHARGE_COST))
			return

	user.do_attack_animation(attacked_mob)
	attacked_mob.adjust_stamina_loss(stamina_damage)
	attacked_mob.set_confusion_if_lower(5 SECONDS)
	attacked_mob.adjust_stutter(20 SECONDS)
	attacked_mob.set_jitter_if_lower(5 SECONDS)
	if(issilicon(attacked_mob))
		attacked_mob.emp_act(EMP_HEAVY)
		attacked_mob.visible_message(
			span_danger("[user]用[src]电击了[attacked_mob]！"),
			span_userdanger("[user]用[src]电击了你！"),
		)
	else
		attacked_mob.visible_message(
			span_danger("[user]用[src]戳了戳[attacked_mob]！"),
			span_userdanger("[user]用[src]戳了戳你！"),
		)

	playsound(loc, 'sound/items/weapons/egloves.ogg', 50, TRUE, -1)
	cooldown_check = world.time + cooldown
	log_combat(user, attacked_mob, "击晕", src, "（战斗模式：[user.combat_mode ? "开启" : "关闭"]）")

#undef CYBORG_STUN_CHARGE_COST

/obj/item/borg/cyborghug
	name = "拥抱模块"
	icon_state = "hugmodule"
	desc = "当某人真的需要一个拥抱时使用。"
	/// Hug mode
	var/mode = HUG_MODE_NICE
	/// Crush cooldown
	COOLDOWN_DECLARE(crush_cooldown)
	/// Shock cooldown
	COOLDOWN_DECLARE(shock_cooldown)
	/// Can it be a stunarm when emagged. Only PK borgs get this by default.
	var/shockallowed = FALSE
	var/boop = FALSE

/obj/item/borg/cyborghug/attack_self(mob/living/user)
	if(iscyborg(user))
		var/mob/living/silicon/robot/robot_user = user
		if(robot_user.emagged && shockallowed == 1)
			if(mode < HUG_MODE_CRUSH)
				mode++
			else
				mode = HUG_MODE_NICE
		else if(mode < HUG_MODE_HUG)
			mode++
		else
			mode = HUG_MODE_NICE
	switch(mode)
		if(HUG_MODE_NICE)
			to_chat(user, span_infoplain("能量重置。抱抱！"))
		if(HUG_MODE_HUG)
			to_chat(user, span_infoplain("功率提升！"))
		if(HUG_MODE_SHOCK)
			to_chat(user, "<span class='warningplain'>BZZT。手臂通电中……</span>")
		if(HUG_MODE_CRUSH)
			to_chat(user, "<span class='warningplain'>错误：手臂驱动器过载。</span>")

/obj/item/borg/cyborghug/attack(mob/living/attacked_mob, mob/living/silicon/robot/user, list/modifiers, list/attack_modifiers)
	if(attacked_mob == user)
		return
	if(attacked_mob.health < 0)
		return
	switch(mode)
		if(HUG_MODE_NICE)
			if(isanimal_or_basicmob(attacked_mob))
				if (!user.combat_mode && !LAZYACCESS(modifiers, RIGHT_CLICK))
					attacked_mob.attack_hand(user, modifiers) //This enables borgs to get the floating heart icon and mob emote from simple_animal's that have petbonus == true.
				return
			if(user.zone_selected == BODY_ZONE_HEAD)
				user.visible_message(
					span_notice("[user]调皮地戳了戳[attacked_mob]的头！"),
					span_notice("你调皮地戳了戳[attacked_mob]的头！"),
				)
				user.do_attack_animation(attacked_mob, ATTACK_EFFECT_BOOP)
				playsound(loc, 'sound/items/weapons/tap.ogg', 50, TRUE, -1)
			else if(ishuman(attacked_mob))
				if(user.body_position == LYING_DOWN)
					user.visible_message(
						span_notice("[user]摇晃[attacked_mob]，想扶对方起来！"),
						span_notice("你摇晃[attacked_mob]，想扶对方起来！"),
					)
				else
					user.visible_message(
						span_notice("[user]拥抱[attacked_mob]，想让对方好受一些！"),
						span_notice("你拥抱[attacked_mob]，想让对方好受一些！"),
					)
				if(attacked_mob.resting)
					attacked_mob.set_resting(FALSE, TRUE)
			else
				user.visible_message(
					span_notice("[user]抚摸了[attacked_mob]！"),
					span_notice("你抚摸了[attacked_mob]！"),
				)
			playsound(loc, 'sound/items/weapons/thudswoosh.ogg', 50, TRUE, -1)
		if(HUG_MODE_HUG)
			if(ishuman(attacked_mob))
				attacked_mob.adjust_status_effects_on_shake_up()
				if(attacked_mob.body_position == LYING_DOWN)
					user.visible_message(
						span_notice("[user]摇晃[attacked_mob]，想扶对方起来！"),
						span_notice("你摇晃[attacked_mob]，想扶对方起来！"),
					)
				else if(user.zone_selected == BODY_ZONE_HEAD)
					user.visible_message(span_warning("[user]敲了敲[attacked_mob]的头！"),
						span_warning("你敲了敲[attacked_mob]的头！"),
					)
					user.do_attack_animation(attacked_mob, ATTACK_EFFECT_PUNCH)
				else
					if(!(SEND_SIGNAL(attacked_mob, COMSIG_BORG_HUG_MOB, user) & COMSIG_BORG_HUG_HANDLED))
						user.visible_message(
							span_warning("[user]紧紧抱住[attacked_mob]，来了个熊抱！[attacked_mob]看起来不太舒服……"),
							span_warning("你紧紧拥抱[attacked_mob]，想让对方好受一些！[attacked_mob]看起来不太舒服……"),
						)
				if(attacked_mob.resting)
					attacked_mob.set_resting(FALSE, TRUE)
			else
				user.visible_message(
					span_warning("[user]敲了敲[attacked_mob]的头！"),
					span_warning("你敲了敲[attacked_mob]的头！"),
				)
			playsound(loc, 'sound/items/weapons/tap.ogg', 50, TRUE, -1)
		if(HUG_MODE_SHOCK)
			if (!COOLDOWN_FINISHED(src, shock_cooldown))
				return
			if(ishuman(attacked_mob))
				attacked_mob.electrocute_act(5, "[user]", flags = SHOCK_NOGLOVES | SHOCK_NOSTUN)
				attacked_mob.dropItemToGround(attacked_mob.get_active_held_item())
				attacked_mob.dropItemToGround(attacked_mob.get_inactive_held_item())
				user.visible_message(
					span_userdanger("[user]通过触碰电击了[attacked_mob]！"),
					span_danger("你以触碰电击了[attacked_mob]！"),
				)
			else
				if(!iscyborg(attacked_mob))
					attacked_mob.adjust_fire_loss(10)
					user.visible_message(
						span_userdanger("[user]电击了[attacked_mob]！"),
						span_danger("你电击了[attacked_mob]！"),
					)
				else
					user.visible_message(
						span_userdanger("[user]电击了[attacked_mob]，但似乎没有效果。"),
						span_danger("你电击了[attacked_mob]，但毫无效果。"),
					)
			playsound(loc, 'sound/effects/sparks/sparks2.ogg', 50, TRUE, -1)
			user.cell.use(0.5 * STANDARD_CELL_CHARGE, force = TRUE)
			COOLDOWN_START(src, shock_cooldown, HUG_SHOCK_COOLDOWN)
		if(HUG_MODE_CRUSH)
			if (!COOLDOWN_FINISHED(src, crush_cooldown))
				return
			if(ishuman(attacked_mob))
				user.visible_message(
					span_userdanger("[user]用握力碾压[attacked_mob]！"),
					span_danger("你用握力碾压[attacked_mob]！"),
				)
			else
				user.visible_message(
					span_userdanger("[user]碾碎了[attacked_mob]！"),
						span_danger("你碾碎了[attacked_mob]！"),
				)
			playsound(loc, 'sound/items/weapons/smash.ogg', 50, TRUE, -1)
			attacked_mob.adjust_brute_loss(15)
			user.cell.use(0.3 * STANDARD_CELL_CHARGE, force = TRUE)
			COOLDOWN_START(src, crush_cooldown, HUG_CRUSH_COOLDOWN)

/obj/item/borg/cyborghug/peacekeeper
	shockallowed = TRUE

/obj/item/borg/cyborghug/medical
	boop = TRUE

/obj/item/borg/charger
	name = "电源连接器"
	icon_state = "charger_draw"
	item_flags = NOBLUDGEON
	/// Charging mode
	var/mode = "draw"
	/// Whitelist of charging machines
	var/static/list/charge_machines = typecacheof(list(/obj/machinery/cell_charger, /obj/machinery/recharger, /obj/machinery/recharge_station, /obj/machinery/mech_bay_recharge_port))
	/// Whitelist of chargable items
	var/static/list/charge_items = typecacheof(list(/obj/item/stock_parts/power_store, /obj/item/gun/energy))

/obj/item/borg/charger/update_icon_state()
	icon_state = "charger_[mode]"
	return ..()

/obj/item/borg/charger/attack_self(mob/user)
	if(mode == "draw")
		mode = "charge"
	else
		mode = "draw"
	to_chat(user, span_notice("你将[src]切换至“[mode]”模式。"))
	update_appearance()

/obj/item/borg/charger/interact_with_atom(atom/target, mob/living/silicon/robot/user, list/modifiers)
	if(!iscyborg(user))
		return NONE

	. = ITEM_INTERACT_BLOCKING
	if(mode == "draw")
		if(is_type_in_list(target, charge_machines))
			var/obj/machinery/target_machine = target
			if((target_machine.machine_stat & (NOPOWER|BROKEN)) || !target_machine.anchored)
				to_chat(user, span_warning("[target_machine]没有通电！"))
				return

			to_chat(user, span_notice("你接入了[target_machine]的电源线……"))
			while(do_after(user, 1.5 SECONDS, target = target_machine, show_progress = FALSE))
				if(!user || !user.cell || mode != "draw")
					return

				if((target_machine.machine_stat & (NOPOWER|BROKEN)) || !target_machine.anchored)
					break

				target_machine.charge_cell(0.15 * STANDARD_CELL_CHARGE, user.cell)

			to_chat(user, span_notice("你停止为自己充电。"))

		else if(is_type_in_list(target, charge_items))
			var/obj/item/stock_parts/power_store/cell = target
			if(!istype(cell))
				cell = locate(/obj/item/stock_parts/power_store) in target
			if(!cell)
				to_chat(user, span_warning("[target]没有电池！"))
				return

			if(istype(target, /obj/item/gun/energy))
				var/obj/item/gun/energy/energy_gun = target
				if(!energy_gun.can_charge)
					to_chat(user, span_warning("[target]没有充电接口！"))
					return

			if(!cell.charge)
				to_chat(user, span_warning("[target]没有电了！"))


			to_chat(user, span_notice("你接入了[target]的充电接口……"))

			while(do_after(user, 1.5 SECONDS, target = target, show_progress = FALSE))
				if(!user || !user.cell || mode != "draw")
					return

				if(!cell || !target)
					return

				if(cell != target && cell.loc != target)
					return

				var/draw = min(cell.charge, cell.chargerate*0.5, user.cell.maxcharge - user.cell.charge)
				if(!cell.use(draw))
					break
				if(!user.cell.give(draw))
					break
				target.update_appearance()

			to_chat(user, span_notice("你停止为自己充电。"))

	else if(is_type_in_list(target, charge_items))
		var/obj/item/stock_parts/power_store/cell = target
		if(!istype(cell))
			cell = locate(/obj/item/stock_parts/power_store) in target
		if(!cell)
			to_chat(user, span_warning("[target]没有电池！"))
			return

		if(istype(target, /obj/item/gun/energy))
			var/obj/item/gun/energy/energy_gun = target
			if(!energy_gun.can_charge)
				to_chat(user, span_warning("[target]没有充电接口！"))
				return

		if(cell.charge >= cell.maxcharge)
			to_chat(user, span_warning("[target]已经充满电了！"))

		to_chat(user, span_notice("你接入了[target]的充电接口……"))

		while(do_after(user, 1.5 SECONDS, target = target, show_progress = FALSE))
			if(!user || !user.cell || mode != "charge")
				return

			if(!cell || !target)
				return

			if(cell != target && cell.loc != target)
				return

			var/draw = min(user.cell.charge, cell.chargerate * 0.5, cell.maxcharge - cell.charge)
			if(!user.cell.use(draw))
				break
			if(!cell.give(draw))
				break
			target.update_appearance()

		to_chat(user, span_notice("你停止为[target]充电。"))

/obj/item/harmalarm
	name = "\improper 声波伤害预防工具"
	desc = "释放一道无害的冲击波，使大多数有机体陷入混乱。适用于伤害实在太过分的时候。"
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "megaphone"
	/// Harm alarm cooldown
	COOLDOWN_DECLARE(alarm_cooldown)

/obj/item/harmalarm/emag_act(mob/user, obj/item/card/emag/emag_card)
	obj_flags ^= EMAGGED
	if(obj_flags & EMAGGED)
		balloon_alert(user, "保险装置已短路")
	else
		balloon_alert(user, "保险装置已重置")
	return TRUE

/obj/item/harmalarm/attack_self(mob/user)
	var/safety = !(obj_flags & EMAGGED)
	if (!COOLDOWN_FINISHED(src, alarm_cooldown))
		to_chat(user, "<font color='red'>设备仍在充能！</font>")
		return

	if(iscyborg(user))
		var/mob/living/silicon/robot/robot_user = user
		if(!robot_user.cell || robot_user.cell.charge < 1200)
			to_chat(user, span_warning("你的电量不足以执行此操作！"))
			return
		robot_user.cell.charge -= 1000
		if(robot_user.emagged)
			safety = FALSE

	if(safety == TRUE)
		user.visible_message(
			"<font color='red' size='2'>[user]的扬声器爆发出几乎震聋人的警报声！</font>",
			span_userdanger("你的警笛在你四周鸣响[iscyborg(user) ? "！" : "，并让你陷入混乱！"]"),
			span_danger("警笛声刺穿你的耳膜！"),
		)
		for(var/mob/living/carbon/carbon in get_hearers_in_view(9, user))
			if(carbon.get_ear_protection() > 0)
				continue
			carbon.adjust_confusion(6 SECONDS)

		audible_message("<font color='red' size='7'>人类伤害</font>")
		playsound(get_turf(src), 'sound/mobs/non-humanoids/cyborg/harmalarm.ogg', 70, 3)
		COOLDOWN_START(src, alarm_cooldown, HARM_ALARM_SAFETY_COOLDOWN)
		user.log_message("使用了半机械人伤害警报", LOG_ATTACK)
		if(iscyborg(user))
			var/mob/living/silicon/robot/robot_user = user
			to_chat(robot_user.connected_ai, "<br>[span_notice("通告——维和“伤害警报”使用人：[user]")]<br>")
	else
		user.audible_message("<font color='red' size='7'>BZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZT</font>")
		for(var/mob/living/living in get_hearers_in_view(9, user))
			var/bang_effect = living.soundbang_act(SOUNDBANG_STRONG, 0, 0, 5)
			switch(bang_effect)
				if(0)
					continue
				if(1)
					living.adjust_confusion(5 SECONDS)
					living.adjust_stutter(20 SECONDS)
					living.adjust_jitter(20 SECONDS)
				else
					living.Paralyze(4 SECONDS)
					living.adjust_confusion(10 SECONDS)
					living.adjust_stutter(30 SECONDS)
					living.adjust_jitter(50 SECONDS)
		playsound(get_turf(src), 'sound/machines/warning-buzzer.ogg', 130, 3)
		COOLDOWN_START(src, alarm_cooldown, HARM_ALARM_NO_SAFETY_COOLDOWN)
		user.log_message("使用了遭 EMAG 破解的半机械人伤害警报", LOG_ATTACK)

/obj/item/shield_module
	name = "护盾激活器"
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "module_miner"
	var/active = FALSE
	var/mutable_appearance/shield_overlay

/obj/item/shield_module/Initialize(mapload)
	. = ..()
	shield_overlay = mutable_appearance('icons/mob/effects/durand_shield.dmi', "borg_shield")

/obj/item/shield_module/attack_self(mob/living/silicon/borg)
	active = !active
	if(active)
		playsound(src, 'sound/vehicles/mecha/mech_shield_raise.ogg', 50, FALSE)
		RegisterSignal(borg, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_shield_overlay_update), override = TRUE)
	else
		playsound(src, 'sound/vehicles/mecha/mech_shield_drop.ogg', 50, FALSE)
		UnregisterSignal(borg, COMSIG_ATOM_UPDATE_OVERLAYS)
	borg.update_appearance()

/obj/item/shield_module/cyborg_unequip(mob/living/silicon/robot/borg)
	active = FALSE
	playsound(src, 'sound/vehicles/mecha/mech_shield_drop.ogg', 50, FALSE)
	borg.cut_overlay(shield_overlay)

/obj/item/shield_module/proc/on_shield_overlay_update(atom/source, list/overlays)
	SIGNAL_HANDLER
	if(active)
		overlays += shield_overlay

#undef HUG_MODE_NICE
#undef HUG_MODE_HUG
#undef HUG_MODE_SHOCK
#undef HUG_MODE_CRUSH

#undef HUG_SHOCK_COOLDOWN
#undef HUG_CRUSH_COOLDOWN

#undef HARM_ALARM_NO_SAFETY_COOLDOWN
#undef HARM_ALARM_SAFETY_COOLDOWN
