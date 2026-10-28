//backpack item
#define HALFWAYCRITDEATH ((HEALTH_THRESHOLD_CRIT + HEALTH_THRESHOLD_DEAD) * 0.5)
#define DEFIB_CAN_HURT(source) (source.combat || (source.req_defib && !source.defib.safety))
#define DEFIB_RESET_TIMER 3 MINUTES

/obj/item/defibrillator
	name = "除颤器"
	desc = "一种向可拆卸电极板释放强力电击、使失去行动能力的病人复苏的设备。\
	后部配有支架，可安装到壁挂架和医疗半机械人上。"
	icon = 'icons/obj/medical/defib.dmi'
	icon_state = "defibunit"
	inhand_icon_state = "defibunit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	slot_flags = ITEM_SLOT_BACK
	force = 5
	throwforce = 6
	w_class = WEIGHT_CLASS_BULKY
	actions_types = list(/datum/action/item_action/toggle_paddles)
	armor_type = /datum/armor/item_defibrillator
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*4, /datum/material/glass = SHEET_MATERIAL_AMOUNT*2, /datum/material/silver =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5)
	var/obj/item/shockpaddles/paddle_type = /obj/item/shockpaddles
	/// If the paddles are equipped (1) or on the defib (0)
	var/on = FALSE
	/// If TRUE, will allow you to zap people while in combat mode.
	var/safety = TRUE
	/// If TRUE, will not attempt to retoggle safeties if emp'd again.
	var/recently_emped = FALSE
	/// If there's a cell in the defib with enough power for a revive, blocks paddles from reviving otherwise
	var/powered = FALSE
	/// If the cell can be removed via screwdriver
	var/cell_removable = TRUE
	var/obj/item/shockpaddles/paddles
	var/obj/item/stock_parts/power_store/cell/cell
	/// If true, revive through space suits, allow for combat shocking
	var/combat = FALSE
	/// How long does it take to recharge
	var/cooldown_duration = 5 SECONDS
	/// The icon state for the paddle overlay, not applied if null
	var/paddle_state = "defibunit-paddles"
	/// The icon state for the powered on overlay, not applied if null
	var/powered_state = "defibunit-powered"
	/// The icon state for the charge bar overlay, not applied if null
	var/charge_state = "defibunit-charge"
	/// The icon state for the missing cell overlay, not applied if null
	var/nocell_state = "defibunit-nocell"
	/// The icon state for the emagged overlay, not applied if null
	var/emagged_state = "defibunit-emagged"

/datum/armor/item_defibrillator
	fire = 50
	acid = 50

/obj/item/defibrillator/get_cell()
	return cell

/obj/item/defibrillator/Initialize(mapload) //starts without a cell for rnd
	. = ..()
	paddles = new paddle_type(src)
	update_power()
	RegisterSignal(paddles, COMSIG_DEFIBRILLATOR_SUCCESS, PROC_REF(on_defib_success))
	AddElement(/datum/element/drag_pickup)

/obj/item/defibrillator/loaded/Initialize(mapload) //starts with hicap
	. = ..()
	cell = new(src)
	update_power()

/obj/item/defibrillator/examine(mob/user)
	. = ..()
	if(!cell_removable)
		return
	if(cell)
		. += span_notice("用螺丝刀可以取出电池。")
	else
		. += span_warning("它没有电源电池！")

/obj/item/defibrillator/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	if(paddles?.loc == src)
		paddles.fire_act(exposed_temperature, exposed_volume)

/obj/item/defibrillator/extinguish()
	. = ..()
	if(paddles?.loc == src)
		paddles.extinguish()

/obj/item/defibrillator/proc/update_power()
	if(!QDELETED(cell))
		if(QDELETED(paddles) || cell.charge < paddles.revivecost)
			powered = FALSE
		else
			powered = TRUE
	else
		powered = FALSE
	update_appearance()
	if(istype(loc, /obj/machinery/defibrillator_mount))
		loc.update_appearance()

/obj/item/defibrillator/update_overlays()
	. = ..()

	if(!on && paddle_state)
		. += paddle_state
	if(powered && powered_state)
		. += powered_state
		if(!QDELETED(cell) && charge_state)
			var/ratio = cell.charge / cell.maxcharge
			ratio = ceil(ratio*4) * 25
			. += "[charge_state][ratio]"
	if(!cell && nocell_state)
		. += "[nocell_state]"
	if(!safety && emagged_state)
		. += emagged_state

/obj/item/defibrillator/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	cell = locate(/obj/item/stock_parts/power_store) in contents
	update_power()

/obj/item/defibrillator/ui_action_click(mob/user, actiontype)
	INVOKE_ASYNC(src, PROC_REF(toggle_paddles), user)

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/defibrillator/attack_hand(mob/user, list/modifiers)
	if(loc == user)
		if(user.get_slot_by_item(src) & slot_flags)
			ui_action_click(user, modifiers)
		else
			balloon_alert(user, "请先装备该设备！")
		return
	else if(istype(loc, /obj/machinery/defibrillator_mount))
		ui_action_click(user, modifiers) //checks for this are handled in defibrillator.mount.dm
	return ..()

/obj/item/defibrillator/screwdriver_act(mob/living/user, obj/item/tool)
	if(!cell || !cell_removable)
		return FALSE

	cell.forceMove(get_turf(src))
	balloon_alert(user, "已取出 [cell]")
	cell = null
	tool.play_tool_sound(src, 50)
	update_power()
	return TRUE

/obj/item/defibrillator/item_interaction(mob/living/user, obj/item/item, list/modifiers)
	if(item == paddles)
		toggle_paddles(user)
		return NONE
	if(!istype(item, /obj/item/stock_parts/power_store/cell))
		return NONE

	var/obj/item/stock_parts/power_store/cell/new_cell = item
	if(!isnull(cell))
		to_chat(user, span_warning("[src] 已经有电池了！"))
		return ITEM_INTERACT_BLOCKING

	if(new_cell.maxcharge < paddles.revivecost)
		to_chat(user, span_notice("[src] 需要容量更高的电池。"))
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(new_cell, src))
		return NONE
	cell = new_cell
	to_chat(user, span_notice("你在 [src] 中装入了一块电池。"))
	update_power()
	return ITEM_INTERACT_SUCCESS

/obj/item/defibrillator/emag_act(mob/user, obj/item/card/emag/emag_card)
	obj_flags |= EMAGGED
	toggle_safety(user)

	return TRUE

/obj/item/defibrillator/emp_act(severity)
	. = ..()
	if(cell && !(. & EMP_PROTECT_CONTENTS))
		deductcharge(STANDARD_CELL_CHARGE / severity)
	if (. & EMP_PROTECT_SELF)
		return
	update_power()
	if((obj_flags & EMAGGED) || recently_emped)
		return
	toggle_safety()
	recently_emped = TRUE

/obj/item/defibrillator/proc/toggle_safety(mob/living/user, force_safety = FALSE)
	if(force_safety && !(obj_flags & EMAGGED))
		safety = TRUE
	else
		safety = FALSE

	var/enabled_or_disabled = (safety ? "已启用" : "已禁用")
	if(user)
		balloon_alert(user, "安全协议[enabled_or_disabled]")

	if(obj_flags & EMAGGED)
		return

	addtimer(CALLBACK(src, PROC_REF(force_safety_on)), DEFIB_RESET_TIMER)

/obj/item/defibrillator/proc/force_safety_on()
	recently_emped = FALSE
	if(obj_flags & EMAGGED)
		return

	toggle_safety(null, TRUE)

/obj/item/defibrillator/proc/toggle_paddles(mob/living/user)
	on = !on
	if(on)
		//Detach the paddles into the user's hands
		if(!user.put_in_hands(paddles))
			on = FALSE
			to_chat(user, span_warning("你需要空出一只手来握住电极板！"))
			update_power()
			return
	else
		//Remove from their hands and back onto the defib unit
		remove_paddles(user)

	update_power()
	update_item_action_buttons()


/obj/item/defibrillator/equipped(mob/user, slot)
	..()
	if(!(slot_flags & slot))
		remove_paddles(user)
		update_power()

/obj/item/defibrillator/proc/remove_paddles(mob/user) //this fox the bug with the paddles when other player stole you the defib when you have the paddles equiped
	if(ismob(paddles.loc))
		var/mob/M = paddles.loc
		M.dropItemToGround(paddles, TRUE)
	return

/obj/item/defibrillator/Destroy()
	if(on)
		var/M = get(paddles, /mob)
		remove_paddles(M)
	QDEL_NULL(paddles)
	QDEL_NULL(cell)
	return ..()

/obj/item/defibrillator/proc/deductcharge(chrgdeductamt)
	if(QDELETED(cell))
		return

	if(cell.charge < (paddles.revivecost + chrgdeductamt))
		powered = FALSE
	if(!cell.use(chrgdeductamt))
		powered = FALSE

	update_power()

/obj/item/defibrillator/proc/cooldowncheck()
	addtimer(CALLBACK(src, PROC_REF(finish_charging)), cooldown_duration)

/obj/item/defibrillator/proc/finish_charging()
	if(cell)
		if(cell.charge >= paddles.revivecost)
			visible_message(span_notice("[src] 发出提示音：设备就绪。"))
			playsound(src, 'sound/machines/defib/defib_ready.ogg', 50, FALSE)
		else
			visible_message(span_notice("[src] 发出提示音：电量耗尽。"))
			playsound(src, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)
	paddles.cooldown = FALSE
	paddles.update_appearance()
	update_power()

/obj/item/defibrillator/proc/on_defib_success(obj/item/shockpaddles/source)
	deductcharge(source.revivecost)
	source.cooldown = TRUE
	cooldowncheck()
	return COMPONENT_DEFIB_STOP

/obj/item/defibrillator/compact
	name = "便携除颤器"
	desc = "一种可挂在腰带上的除颤器，能够快速展开。"
	icon_state = "defibcompact"
	inhand_icon_state = null
	slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_SUITSTORE|ITEM_SLOT_DEX_STORAGE
	worn_icon = 'icons/mob/clothing/belt.dmi'
	worn_icon_state = "defibcompact"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*6, /datum/material/glass = SHEET_MATERIAL_AMOUNT*4, /datum/material/silver = SHEET_MATERIAL_AMOUNT*3, /datum/material/gold =SHEET_MATERIAL_AMOUNT * 1.5)
	w_class = WEIGHT_CLASS_NORMAL
	paddle_state = "defibcompact-paddles"
	powered_state = "defibcompact-powered"
	charge_state = "defibcompact-charge"
	nocell_state = "defibcompact-nocell"
	emagged_state = "defibcompact-emagged"

/obj/item/defibrillator/compact/loaded/Initialize(mapload)
	. = ..()
	cell = new(src)
	update_power()

/obj/item/defibrillator/compact/loaded/cmo // special version for the CMO, is a theft objective.
	name = "实验型紧凑除颤器"
	desc = "一种可挂在腰带上的除颤器，能够快速展开。这台设备经过改装，配备了各种实验性\
		组件，大幅提高了充电速度。真不错。"
	icon_state = "defibcmo"
	cooldown_duration = 2.5 SECONDS
	resistance_flags = INDESTRUCTIBLE // So no cheesy getting rid of like other steal/head items

/obj/item/defibrillator/compact/combat
	name = "战斗除颤器"
	desc = "一种可挂在腰带上的血红色除颤器。可隔着厚重衣物进行复苏，配有实验性自充电电池，还可在战斗姿态下使用电极板作为武器。"
	icon_state = "defibcombat" //needs defib inhand sprites
	inhand_icon_state = null
	worn_icon_state = "defibcombat"
	combat = TRUE
	safety = FALSE
	cooldown_duration = 2.5 SECONDS
	paddle_type = /obj/item/shockpaddles/syndicate
	paddle_state = "defibcombat-paddles"
	powered_state = null
	emagged_state = null

/obj/item/defibrillator/compact/combat/loaded
	cell_removable = FALSE // Don't let people just have an infinite power cell

/obj/item/defibrillator/compact/combat/loaded/Initialize(mapload)
	. = ..()
	cell = new /obj/item/stock_parts/power_store/cell/infinite(src)
	update_power()

/obj/item/defibrillator/compact/combat/loaded/nanotrasen
	name = "纳米传讯精英除颤器"
	desc = "一种可挂在腰带上的尖端除颤器。可隔着厚重衣物进行复苏，配有实验性自充电电池，还可在战斗姿态下使用电极板作为武器。"
	icon_state = "defibnt" //needs defib inhand sprites
	inhand_icon_state = null
	worn_icon_state = "defibnt"
	paddle_type = /obj/item/shockpaddles/syndicate/nanotrasen
	paddle_state = "defibnt-paddles"

//paddles

/obj/item/shockpaddles
	name = "除颤器电极板"
	desc = "一对带塑料握柄、表面为扁平金属的电极板，用于释放强力电击。"
	icon = 'icons/obj/medical/defib.dmi'
	icon_state = "defibpaddles0"
	inhand_icon_state = "defibpaddles0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	spawn_blacklisted = TRUE

	force = 0
	throwforce = 6
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = INDESTRUCTIBLE
	base_icon_state = "defibpaddles"

	var/revivecost = STANDARD_CELL_CHARGE * 0.1
	var/cooldown = FALSE
	var/busy = FALSE
	var/obj/item/defibrillator/defib
	var/req_defib = TRUE // Whether or not the paddles require a defibrilator object
	var/recharge_time = 6 SECONDS // Only applies to defibs that do not require a defibrilator. See: do_success()
	var/combat = FALSE //If it penetrates armor and gives additional functionality

/obj/item/shockpaddles/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob, ITEM_SLOT_BACK)
	AddComponent(/datum/component/two_handed, force_unwielded=8, force_wielded=12)
	RegisterSignal(src, COMSIG_HUMAN_NON_STORAGE_HOTKEY, PROC_REF(on_non_storage_hotkey))

/obj/item/shockpaddles/Destroy()
	defib = null
	return ..()

/obj/item/shockpaddles/equipped(mob/user, slot)
	. = ..()
	if(!req_defib)
		return
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(check_range))
	RegisterSignal(defib, COMSIG_MOVABLE_MOVED, PROC_REF(check_range))

/obj/item/shockpaddles/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	check_range()

/obj/item/shockpaddles/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	if((req_defib && defib) && loc != defib)
		defib.fire_act(exposed_temperature, exposed_volume)

/obj/item/shockpaddles/proc/check_range()
	SIGNAL_HANDLER

	if(!req_defib || !defib)
		return
	if(!in_range(src,defib))
		if(isliving(loc))
			var/mob/living/user = loc
			to_chat(user, span_warning("[defib] 的电极板拉得过长，从你手中脱出！"))
		else
			visible_message(span_notice("[src] 弹回 [defib]。"))
		snap_back()

/obj/item/shockpaddles/proc/recharge(time = 0)
	if(req_defib)
		return
	cooldown = TRUE
	update_appearance()
	addtimer(CALLBACK(src, PROC_REF(finish_recharge)), time)

/obj/item/shockpaddles/proc/finish_recharge()
	var/turf/current_turf = get_turf(src)
	current_turf.audible_message(span_notice("[src] 发出提示音：设备已重新充电。"))
	playsound(src, 'sound/machines/defib/defib_ready.ogg', 50, FALSE)
	cooldown = FALSE
	update_appearance()

/obj/item/shockpaddles/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_STORAGE_INSERT, TRAIT_GENERIC) //stops shockpaddles from being inserted in BoH
	if(!req_defib)
		return //If it doesn't need a defib, just say it exists
	if (!loc || !istype(loc, /obj/item/defibrillator)) //To avoid weird issues from admin spawns
		return INITIALIZE_HINT_QDEL
	defib = loc
	busy = FALSE
	update_appearance()

/obj/item/shockpaddles/suicide_act(mob/living/user)
	user.visible_message(span_danger("[user]正把通电的电极板按在自己的胸口！看起来是想自杀！"))
	if(req_defib)
		defib.deductcharge(revivecost)
	playsound(src, 'sound/machines/defib/defib_zap.ogg', 50, TRUE, -1)
	return OXYLOSS

/obj/item/shockpaddles/update_icon_state()
	icon_state = "[base_icon_state][HAS_TRAIT(src, TRAIT_WIELDED)]"
	inhand_icon_state = icon_state
	if(cooldown)
		icon_state = "[base_icon_state][HAS_TRAIT(src, TRAIT_WIELDED)]_cooldown"
	return ..()

/obj/item/shockpaddles/dropped(mob/user)
	if(!req_defib)
		return ..()
	UnregisterSignal(defib, COMSIG_MOVABLE_MOVED)
	if(user)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		to_chat(user, span_notice("电极板弹回了主机。"))
	snap_back()
	return ..()

/obj/item/shockpaddles/proc/snap_back()
	if(!defib)
		return
	defib.on = FALSE
	forceMove(defib)
	defib.update_power()

/obj/item/shockpaddles/attack(mob/M, mob/living/user, list/modifiers, list/attack_modifiers)
	if(busy)
		return
	defib?.update_power()
	if(req_defib && !defib.powered)
		user.visible_message(span_warning("[defib] 发出提示音：电量不足！"))
		playsound(src, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)
		return
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		if(iscyborg(user))
			to_chat(user, span_warning("你必须先激活当前模块中的电极板，才能对他人使用！"))
		else
			to_chat(user, span_warning("你需要双手握持电极板，才能对他人使用！"))
		return
	if(cooldown)
		if(req_defib)
			to_chat(user, span_warning("[defib] 正在充电！"))
		else
			to_chat(user, span_warning("[src] 正在充电！"))
		return

	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		do_disarm(M, user)
		return

	if(!iscarbon(M))
		if(req_defib)
			to_chat(user, span_warning("[defib] 的说明书没有提到如何复苏这种目标……"))
		else
			to_chat(user, span_warning("你不确定该如何复苏这个目标……"))
		return
	var/mob/living/carbon/H = M

	if(user.zone_selected != BODY_ZONE_CHEST)
		to_chat(user, span_warning("你需要用 [src] 对准病人的胸部！"))
		return

	if(user.combat_mode)
		do_harm(H, user)
		return

	if(H.can_defib() == DEFIB_POSSIBLE)
		H.notify_revival("你的心脏正在接受除颤！")
		H.grab_ghost() // Shove them back in their body.

	do_help(H, user)

/// Called whenever the paddles successfully shock something
/obj/item/shockpaddles/proc/do_success()
	if(busy)
		busy = FALSE

	update_appearance()
	if(SEND_SIGNAL(src, COMSIG_DEFIBRILLATOR_SUCCESS) & COMPONENT_DEFIB_STOP)
		return
	recharge(recharge_time)

/// Called whenever the paddles fail to shock something after a do_x proc
/obj/item/shockpaddles/proc/do_cancel()
	if(busy)
		busy = FALSE

	update_appearance()

/obj/item/shockpaddles/proc/shock_pulling(dmg, mob/H)
	if(isliving(H.pulledby)) //CLEAR!
		var/mob/living/M = H.pulledby
		if(M.electrocute_act(dmg, H))
			M.visible_message(span_danger("[M] 因与 [H] 接触而触电！"))
			M.emote("scream")

/obj/item/shockpaddles/proc/do_disarm(mob/living/M, mob/living/user)
	if(!DEFIB_CAN_HURT(src))
		return
	busy = TRUE
	M.visible_message(span_danger("[user] 用 [src] 碰触了 [M]！"), \
			span_userdanger("[user] 用 [src] 碰触了 [M]！"))
	M.adjust_stamina_loss(60)
	M.Knockdown(75)
	M.set_jitter_if_lower(100 SECONDS)
	M.apply_status_effect(/datum/status_effect/convulsing)
	playsound(src,  'sound/machines/defib/defib_zap.ogg', 50, TRUE, -1)
	if(HAS_TRAIT(M,MOB_ORGANIC))
		M.emote("gasp")
	log_combat(user, M, "zapped", src)
	do_success()

/obj/item/shockpaddles/proc/do_harm(mob/living/carbon/H, mob/living/user)
	if(!DEFIB_CAN_HURT(src))
		return
	user.visible_message(span_warning("[user] 开始把 [src] 放到 [H] 的胸口。"),
		span_warning("你让电极板过载，并开始把它们放到 [H] 的胸口……"))
	busy = TRUE
	update_appearance()
	if(do_after(user, 1.5 SECONDS, H, extra_checks = CALLBACK(src, PROC_REF(is_wielded))))
		user.visible_message(span_notice("[user] 把 [src] 放到了 [H] 的胸口。"),
			span_warning("你把 [src] 放到 [H] 的胸口并开始充电。"))
		var/turf/T = get_turf(defib)
		playsound(src, 'sound/machines/defib/defib_charge.ogg', 50, FALSE)
		if(req_defib)
			T.audible_message(span_warning("[defib] 发出一声急促的提示音，随后响起逐渐升高的嗡鸣……"))
		else
			user.audible_message(span_warning("[src] 发出一声急促的提示音。"))
		if(do_after(user, 1.5 SECONDS, H, extra_checks = CALLBACK(src, PROC_REF(is_wielded)))) //Takes longer due to overcharging
			if(!H)
				do_cancel()
				return
			if(H && H.stat == DEAD)
				to_chat(user, span_warning("[H] 已经死亡。"))
				playsound(src, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)
				do_cancel()
				return
			user.visible_message(span_bolddanger("<i>[user] 用 [src] 电击了 [H]！"), span_warning("你用 [src] 电击了 [H]！"))
			playsound(src, 'sound/machines/defib/defib_zap.ogg', 100, TRUE, -1)
			playsound(src, 'sound/items/weapons/egloves.ogg', 100, TRUE, -1)
			H.emote("scream")
			shock_pulling(45, H)
			if(H.can_heartattack() && !H.undergoing_cardiac_arrest())
				if(!IS_UNCONSCIOUS_OR_CRIT(H))
					H.visible_message(span_warning("[H] 剧烈挣扎，双手抓着自己的胸口！"),
						span_userdanger("你感到胸口传来一阵可怕的剧痛！"))
				H.set_heartattack(TRUE)
			H.apply_damage(50, BURN, BODY_ZONE_CHEST)
			log_combat(user, H, "overloaded the heart of", defib)
			H.Paralyze(100)
			H.set_jitter_if_lower(200 SECONDS)
			do_success()
			return
	do_cancel()

/obj/item/shockpaddles/proc/do_help(mob/living/carbon/H, mob/living/user)
	var/target_synthetic = (H.mob_biotypes & MOB_ROBOTIC) // SKYRAT EDIT ADDITION BEGIN - SYNTH REVIVAL
	if (target_synthetic)
		to_chat(user, span_boldwarning("[H]是合成生命体！这台除颤器很可能没有针对合成生命体复苏进行校准，可能会造成严重后果！\
		[span_warning("你也许应该[span_blue("对其进行外科复苏")]……")]"))
		balloon_alert(user, "目标是合成体！") // immediately grabs their attention even if they dont see chat
	// SKYRAT EDIT ADDITION END - SYNTH REVIVAL
	user.visible_message(span_warning("[user] 开始把 [src] 放到 [H] 的胸口。"), span_warning("你开始把 [src] 放到 [H] 的胸口……"))
	busy = TRUE
	update_appearance()
	if(do_after(user, 3 SECONDS, H, extra_checks = CALLBACK(src, PROC_REF(is_wielded)))) //beginning to place the paddles on patient's chest to allow some time for people to move away to stop the process
		user.visible_message(span_notice("[user] 把 [src] 放到了 [H] 的胸口。"), span_warning("你把 [src] 放到了 [H] 的胸口。"))
		playsound(src, 'sound/machines/defib/defib_charge.ogg', 75, FALSE)
		var/obj/item/organ/heart = H.get_organ_by_type(/obj/item/organ/heart)
		if(do_after(user, 2 SECONDS, H, extra_checks = CALLBACK(src, PROC_REF(is_wielded)))) //placed on chest and short delay to shock for dramatic effect, revive time is 5sec total
			if((!combat && !req_defib) || (req_defib && !defib.combat))
				for(var/obj/item/clothing/C in H.get_equipped_items())
					if((C.body_parts_covered & CHEST) && (C.clothing_flags & THICKMATERIAL)) //check to see if something is obscuring their chest.
						user.audible_message(span_warning("[req_defib ? "[defib]" : "[src]"] 发出蜂鸣：病人胸部被遮挡，操作中止。"))
						playsound(src, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)
						do_cancel()
						return
			if(SEND_SIGNAL(H, COMSIG_DEFIBRILLATOR_PRE_HELP_ZAP, user, src) & COMPONENT_DEFIB_STOP)
				do_cancel()
				return
			if(H.stat == DEAD)
				H.visible_message(span_warning("[H] 的身体抽搐了一下。"))
				playsound(src, SFX_BODYFALL, 50, TRUE)
				playsound(src, 'sound/machines/defib/defib_zap.ogg', 75, TRUE, -1)
				shock_pulling(30, H)

				var/defib_result = H.can_defib()
				var/fail_reason

				switch (defib_result)
					if (DEFIB_FAIL_SUICIDE)
						fail_reason = "无法挽救病人，再次尝试也无济于事。"
					if (DEFIB_FAIL_NO_HEART)
						fail_reason = "病人的心脏不见了。"
					if (DEFIB_FAIL_FAILING_HEART)
						fail_reason = "病人的心脏损伤过重，请更换或修复后再试。"
					if (DEFIB_FAIL_TISSUE_DAMAGE)
						fail_reason = "组织损伤过于严重，请修复后再试。"
					if (DEFIB_FAIL_HUSK)
						fail_reason = "病人的身体已成一具躯壳，请修复后再试。"
					if (DEFIB_FAIL_FAILING_BRAIN)
						fail_reason = "病人的大脑损伤过重，请修复后再试。"
					if (DEFIB_FAIL_NO_INTELLIGENCE)
						fail_reason = "无法在病人的大脑中检测到智能模式，再次尝试也无济于事。"
					if (DEFIB_FAIL_NO_BRAIN)
						fail_reason = "病人的大脑不见了，再次尝试也无济于事。"
					if (DEFIB_FAIL_BLACKLISTED)
						fail_reason = "病人已被列入禁止复苏名单，再次尝试也无济于事。"
					if (DEFIB_FAIL_GOLEM)
						fail_reason = "病人由无机材料构成，再次尝试也无济于事，但可以进行手动重建。"

				if(fail_reason)
					user.visible_message(span_warning("[req_defib ? "[defib]" : "[src]"] 发出蜂鸣：复苏失败——[fail_reason]"))
					playsound(src, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)
				else
					var/total_brute = H.get_brute_loss()
					var/total_burn = H.get_fire_loss()

					var/need_mob_update = FALSE
					//If the body has been fixed so that they would not be in crit when defibbed, give them oxyloss to put them back into crit
					if (H.health > HALFWAYCRITDEATH)
						need_mob_update += H.adjust_oxy_loss(H.health - HALFWAYCRITDEATH, updating_health = FALSE)
					else
						var/overall_damage = total_brute + total_burn + H.get_tox_loss() + H.get_oxy_loss()
						var/mobhealth = H.health
						need_mob_update += H.adjust_oxy_loss((mobhealth - HALFWAYCRITDEATH) * (H.get_oxy_loss() / overall_damage), updating_health = FALSE)
						need_mob_update += H.adjust_tox_loss((mobhealth - HALFWAYCRITDEATH) * (H.get_tox_loss() / overall_damage), updating_health = FALSE, forced = TRUE) // force tox heal for toxin lovers too
						need_mob_update += H.adjust_fire_loss((mobhealth - HALFWAYCRITDEATH) * (total_burn / overall_damage), updating_health = FALSE)
						need_mob_update += H.adjust_brute_loss((mobhealth - HALFWAYCRITDEATH) * (total_brute / overall_damage), updating_health = FALSE)
					if(need_mob_update)
						H.updatehealth() // Previous "adjust" procs don't update health, so we do it manually.
					user.visible_message(span_notice("[req_defib ? "[defib]" : "[src]"] 发出提示音：复苏成功。"))
					playsound(src, 'sound/machines/defib/defib_success.ogg', 50, FALSE)
					H.set_heartattack(FALSE)
					if(defib_result == DEFIB_POSSIBLE)
						H.grab_ghost()
					H.revive()
					H.emote("gasp")
					H.set_jitter_if_lower(200 SECONDS)

					to_chat(H, "<span class='userdanger'>[CONFIG_GET(string/blackoutpolicy)]</span>") //SKYRAT EDIT ADDITION

					SEND_SIGNAL(H, COMSIG_LIVING_MINOR_SHOCK)
					if(HAS_MIND_TRAIT(user, TRAIT_MORBID))
						user.add_mood_event("morbid_saved_life", /datum/mood_event/morbid_saved_life)
					else
						user.add_mood_event("saved_life", /datum/mood_event/saved_life)
					log_combat(user, H, "revived", defib)

					// SKYRAT EDIT ADDITION BEGIN - SYNTH REVIVAL
					if (target_synthetic)
						user.visible_message(span_boldwarning("[src] 向 [H] 脆弱的电路注入了一股强力电流！"))
						to_chat(H, span_userdanger("[user] 的除颤器向你的脆弱电路注入了一股强力电流，使其过载！"))
						// You may ask, why not just call H.emp_act()?
						// well my dear reader, that EMPs contents. I only want to EMP bodyparts and organs specifically
						for (var/obj/item/bodypart/iterated_part as anything in H.bodyparts)
							iterated_part.emp_act(EMP_LIGHT)
						for (var/obj/item/organ/iterated_organ as anything in H.organs)
							iterated_organ.emp_act(EMP_LIGHT)
						var/obj/item/organ/brain/brain_organ = H.get_organ_slot(ORGAN_SLOT_BRAIN)
						if (istype(brain_organ))
							var/datum/brain_trauma/trauma = brain_organ.gain_trauma_type(SYNTH_DEFIBBED_TRAUMA_SEVERITY, TRAUMA_LIMIT_BASIC)
							if (!QDELETED(trauma))
								addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(remove_synth_defib_trauma), brain_organ, trauma), SYNTH_DEFIBBED_TRAUMA_DURATION)
					// SKYRAT EDIT ADDITION END - SYNTH REVIVAL


				do_success()
				return
			else if (!H.get_organ_by_type(/obj/item/organ/heart))
				user.visible_message(span_warning("[req_defib ? "[defib]" : "[src]"] 发出蜂鸣：病人的心脏不见了，操作中止。"))
				playsound(src, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)
			else if(H.undergoing_cardiac_arrest())
				playsound(src, 'sound/machines/defib/defib_zap.ogg', 50, TRUE, -1)
				if(!(heart.organ_flags & ORGAN_FAILING))
					H.set_heartattack(FALSE)
					do_success()
					user.visible_message(span_notice("[req_defib ? "[defib]" : "[src]"] 发出提示音：病人的心脏重新开始跳动了。"))
				else
					user.visible_message(span_warning("[req_defib ? "[defib]" : "[src]"] 发出蜂鸣：复苏失败，检测到心脏损伤。"))
			else if(H.has_status_effect(/datum/status_effect/heart_attack))
				user.visible_message(span_notice("[req_defib ? "[defib]" : "[src]"] 发出提示音：病人的心脏已稳定，可能还需要再次使用。"))
				SEND_SIGNAL(H, COMSIG_HEARTATTACK_DEFIB)
				playsound(src, 'sound/machines/defib/defib_zap.ogg', 50, TRUE, -1)
				do_success()
			else
				user.visible_message(span_warning("[req_defib ? "[defib]" : "[src]"] 发出蜂鸣：病人不在有效状态，操作中止。"))
				playsound(src, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)
	do_cancel()

/obj/item/shockpaddles/proc/is_wielded()
	return HAS_TRAIT(src, TRAIT_WIELDED)

/obj/item/shockpaddles/proc/on_non_storage_hotkey(datum/source,  mob/living/carbon/human/user, obj/item/possible_storage)
	SIGNAL_HANDLER
	if(possible_storage == defib)
		user.dropItemToGround(src)
		return COMPONENT_STORAGE_HOTKEY_HANDLED
	return NONE

/obj/item/shockpaddles/cyborg
	name = "半机械人除颤器电极板"
	icon = 'icons/obj/medical/defib.dmi'
	icon_state = "defibpaddles0"
	inhand_icon_state = "defibpaddles0"
	req_defib = FALSE

/obj/item/shockpaddles/cyborg/attack(mob/M, mob/user)
	if(iscyborg(user))
		var/mob/living/silicon/robot/R = user
		if(R.emagged)
			combat = TRUE
		else
			combat = FALSE
	else
		combat = FALSE

	. = ..()

/obj/item/shockpaddles/syndicate
	name = "辛迪加除颤器电极板"
	desc = "一对用于复苏已故特工的电极板。既能穿透护甲，也能以进攻方式释放强力或致瘫的电击。"
	combat = TRUE
	icon = 'icons/obj/medical/defib.dmi'
	icon_state = "syndiepaddles0"
	inhand_icon_state = "syndiepaddles0"
	base_icon_state = "syndiepaddles"

/obj/item/shockpaddles/syndicate/nanotrasen
	name = "纳米传讯精英除颤器电极板"
	desc = "一对用于复苏已故紧急响应小队成员的电极板。既能穿透护甲，也能以进攻方式释放强力或致瘫的电击。"
	icon_state = "ntpaddles0"
	inhand_icon_state = "ntpaddles0"
	base_icon_state = "ntpaddles"

/obj/item/shockpaddles/syndicate/cyborg
	req_defib = FALSE

#undef HALFWAYCRITDEATH
#undef DEFIB_CAN_HURT
#undef DEFIB_RESET_TIMER
