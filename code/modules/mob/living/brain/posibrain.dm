GLOBAL_VAR(posibrain_notify_cooldown)

/obj/item/mmi/posibrain
	name = "正电子脑"
	desc = "一块四英寸见方的闪亮金属立方体，表面布满浅浅的沟槽。"
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "posibrain"
	base_icon_state = "posibrain"
	w_class = WEIGHT_CLASS_NORMAL
	req_access = list(ACCESS_ROBOTICS)
	braintype = "Android"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.85, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.67, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT)

	///Message sent to the user when polling ghosts
	var/begin_activation_message = span_notice("你小心地找到手动激活开关，启动了正电子脑的开机流程。")
	///Message sent as a visible message on success
	var/success_message = span_notice("正电子脑发出“叮”的一声，指示灯开始闪烁。成功了！")
	///Message sent as a visible message on failure
	var/fail_message = span_notice("正电子脑轻轻嗡鸣，金色灯光随之黯淡下去。也许你可以再试一次？")
	///Visible message sent when a player possesses the brain
	var/new_mob_message = span_notice("正电子脑悄然响起清脆的鸣音。")
	///Examine message when the posibrain has no mob
	var/dead_message = span_deadsay("它看起来完全没有活动。重置指示灯正在闪烁。")
	///Examine message when the posibrain cannot poll ghosts due to cooldown
	var/recharge_message = span_warning("正电子脑尚未准备好再次激活！给它一点时间充能吧。")

	///Can be set to tell ghosts what the brain will be used for
	var/ask_role = ""
	///Role assigned to the newly created mind
	var/posibrain_job_path = /datum/job/positronic_brain
	///World time tick when ghost polling will be available again
	var/next_ask
	///Delay after polling ghosts
	var/ask_delay = 60 SECONDS
	///One of these names is randomly picked as the posibrain's name on possession. If left blank, it will use the global posibrain names
	var/list/possible_names
	///Picked posibrain name
	var/picked_name
	///Whether this positronic brain is currently looking for a ghost to enter it.
	var/searching = FALSE
	///List of all ckeys who has already entered this posibrain once before.
	var/list/ckeys_entered = list()

///Notify ghosts that the posibrain is up for grabs
/obj/item/mmi/posibrain/proc/ping_ghosts(msg, newlymade)
	if(newlymade || GLOB.posibrain_notify_cooldown <= world.time)
		notify_ghosts(
			"[name] 在 [get_area(src)] 中[msg]！[ask_role ? "所需人格：\[[ask_role]\]" : ""]",
			source = src,
			header = "机器中的幽灵",
			click_interact = TRUE,
			ghost_sound = !newlymade ? 'sound/effects/ghost2.ogg':null,
			ignore_key = POLL_IGNORE_POSIBRAIN,
			notify_flags = (GHOST_NOTIFY_IGNORE_MAPLOAD),
			notify_volume = 75,
		)
		if(!newlymade)
			GLOB.posibrain_notify_cooldown = world.time + ask_delay

/obj/item/mmi/posibrain/attack_self(mob/user)
	if(!brainmob)
		set_brainmob(new /mob/living/brain(src))
	if(!(GLOB.ghost_role_flags & GHOSTROLE_SILICONS))
		to_chat(user, span_warning("中央指挥部已暂时在本星区禁止正电子脑获得意识……"))
	if(is_occupied())
		to_chat(user, span_warning("[name] 已经处于激活状态！"))
		return
	if(next_ask > world.time)
		to_chat(user, recharge_message)
		return
	//Start the process of requesting a new ghost.
	to_chat(user, begin_activation_message)
	ping_ghosts("发出请求", FALSE)
	next_ask = world.time + ask_delay
	searching = TRUE
	update_appearance()
	addtimer(CALLBACK(src, PROC_REF(check_success)), ask_delay)

/obj/item/mmi/posibrain/click_alt(mob/living/user)
	var/input_seed = tgui_input_text(user, "输入人格种子", "输入种子", ask_role, max_length = MAX_NAME_LEN)
	if(isnull(input_seed) || !user.can_perform_action(src))
		return CLICK_ACTION_BLOCKING
	to_chat(user, span_notice("你将人格种子设置为“[input_seed]”。"))
	ask_role = input_seed
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/mmi/posibrain/proc/check_success()
	searching = FALSE
	update_appearance()
	if(QDELETED(brainmob))
		return
	if(brainmob.client)
		visible_message(success_message)
		playsound(src, 'sound/machines/ping.ogg', 15, TRUE)
	else
		visible_message(fail_message)

///ATTACK GHOST IGNORING PARENT RETURN VALUE
/obj/item/mmi/posibrain/attack_ghost(mob/user)
	activate(user)

/obj/item/mmi/posibrain/proc/is_occupied()
	if(brainmob.key)
		return TRUE
	if(iscyborg(loc))
		var/mob/living/silicon/robot/R = loc
		if(R.mmi == src)
			return TRUE
	return FALSE

///Two ways to activate a positronic brain. A clickable link in the ghost notif, or simply clicking the object itself.
/obj/item/mmi/posibrain/proc/activate(mob/user)
	if(QDELETED(brainmob))
		return
	if(user.ckey in ckeys_entered)
		to_chat(user, span_warning("你不能第二次进入 [src]！"))
		return
	if(is_occupied() || is_banned_from(user.ckey, ROLE_POSIBRAIN) || QDELETED(src) || QDELETED(user))
		return
	//BUBBER EDIT BEGIN: SILICON FLAVOR TEXT
	if(CONFIG_GET(flag/min_flavor_text))
		if((length_char(user.client?.prefs.read_preference(/datum/preference/text/silicon_flavor_text))) <= CONFIG_GET(number/silicon_flavor_text_character_requirement))
			to_chat(user, span_warning("要扮演该角色，你的硅基角色风味文本至少需要 [CONFIG_GET(number/silicon_flavor_text_character_requirement)] 个字符。请前往角色创建器补充内容！"))
			return
	//BUBBER EDIT END: SILICON FLAVOR TEXT
	var/posi_ask = tgui_alert(user, "成为 [name] 吗？（警告：你将无法再被复活，所有前世都会被遗忘！）", "确认", list("Yes","No"))
	if(posi_ask != "Yes" || QDELETED(src))
		return
	if(HAS_TRAIT(brainmob, TRAIT_SUICIDED)) //clear suicide status if the old occupant suicided.
		brainmob.set_suicide(FALSE)
	transfer_personality(user)

/obj/item/mmi/posibrain/transfer_identity(mob/living/carbon/transferred_user)
	name = "[initial(name)] ([transferred_user])"
	brainmob.name = transferred_user.real_name
	brainmob.real_name = transferred_user.real_name
	if(transferred_user.has_dna())
		if(!brainmob.stored_dna)
			brainmob.stored_dna = new /datum/dna/stored(brainmob)
		transferred_user.dna.copy_dna(brainmob.stored_dna)
	brainmob.timeofdeath = transferred_user.timeofdeath
	brainmob.set_stat(STABLE)
	if(brainmob.mind)
		brainmob.mind.set_assigned_role(SSjob.get_job_type(posibrain_job_path))
	if(transferred_user.mind)
		transferred_user.mind.transfer_to(brainmob)

	brainmob.mind.remove_all_antag_datums()
	brainmob.mind.wipe_memory()
	update_appearance()

///Moves the candidate from the ghost to the posibrain
/obj/item/mmi/posibrain/proc/transfer_personality(mob/candidate)
	if(QDELETED(brainmob))
		return
	if(is_occupied()) //Prevents hostile takeover if two ghosts get the prompt or link for the same brain.
		to_chat(candidate, span_warning("[name] 在你来得及操作之前就已被接管了！也许稍后还会有机会？"))
		return FALSE
	if(candidate.mind && !isobserver(candidate))
		candidate.mind.transfer_to(brainmob)
	else
		brainmob.PossessByPlayer(candidate.ckey)
	name = "[initial(name)] ([brainmob.name])"
	var/policy = get_policy(ROLE_POSIBRAIN)
	if(policy)
		to_chat(brainmob, policy)
	brainmob.mind.set_assigned_role(SSjob.get_job_type(posibrain_job_path))
	brainmob.set_stat(STABLE)
	brainmob.grant_language(/datum/language/machine, source = LANGUAGE_ATOM)

	visible_message(new_mob_message)
	check_success()
	ckeys_entered |= brainmob.ckey
	return TRUE


/obj/item/mmi/posibrain/examine(mob/user)
	. = ..()
	if(brainmob?.key)
		switch(brainmob.stat)
			if(STABLE)
				if(!brainmob.client)
					. += "它似乎处于待机模式。" //afk
			if(DEAD)
				. += span_deadsay("它看起来完全没有活动。")
	else
		. += "[dead_message]"
		if(ask_role)
			. += span_notice("当前意识种子：“[ask_role]”")
		. += span_boldnotice("按住 Alt 点击可设置意识种子，说明 [src] 将用于何种用途。这有助于生成对此角色感兴趣的人格。")

/obj/item/mmi/posibrain/Initialize(mapload, autoping = TRUE)
	. = ..()
	set_brainmob(new /mob/living/brain(src))
	var/new_name
	if(!LAZYLEN(possible_names))
		new_name = pick(GLOB.posibrain_names)
	else
		new_name = pick(possible_names)
	brainmob.name = "[new_name]-[rand(100, 999)]"
	brainmob.real_name = brainmob.name
	brainmob.forceMove(src)
	brainmob.container = src
	if(autoping)
		ping_ghosts("刚刚成型", TRUE)

/obj/item/mmi/posibrain/update_icon_state()
	. = ..()
	if(searching)
		icon_state = "[base_icon_state]-searching"
		return
	if(brainmob?.key)
		icon_state = "[base_icon_state]-occupied"
		return
	icon_state = "[base_icon_state]"
	return

/obj/item/mmi/posibrain/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	return ITEM_INTERACT_BLOCKING

/obj/item/mmi/posibrain/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	return

/obj/item/mmi/posibrain/add_mmi_overlay()
	return

/obj/item/mmi/posibrain/display
	name = "展示用正电子脑"
	desc = "一具小型正电子脑，不允许下载人格。"

/obj/item/mmi/posibrain/display/is_occupied()
	return TRUE

/// Posibrains but spherical. They can roll around and you can kick them
/obj/item/mmi/posibrain/sphere
	name = "正电子球"
	desc = "近来的降本措施让我们能把正电子脑方块切成成本减半的球体。\
	不幸的是，这也让它们能在实验室里靠滚动四处移动。"
	icon_state = "spheribrain"
	base_icon_state = "spheribrain"
	immobilize = FALSE
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4.2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3.2, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 2.5)
	/// Delay between movements
	var/move_delay = 0.5 SECONDS
	/// when can we move again?
	var/can_move

/obj/item/mmi/posibrain/sphere/Initialize(mapload, autoping)
	. = ..()

	var/matrix/matrix = matrix()
	transform = matrix.Scale(0.8, 0.8)

	brainmob.remove_traits(list(TRAIT_IMMOBILIZED, TRAIT_HANDS_BLOCKED), BRAIN_UNAIDED)

/obj/item/mmi/posibrain/sphere/relaymove(mob/living/user, direction)
	if(isspaceturf(loc) || !direction || mecha)
		return

	if(can_move >= world.time)
		return
	can_move = world.time + move_delay

	// ESCAPE PRISON
	if(ismovable(loc) && prob(25))
		var/obj/item/item = pick(loc.contents)
		if(istype(loc, /obj/item/storage))
			item.forceMove(loc.drop_location()) //throw stuff out of the inventory till we free ourselves!
			playsound(src, SFX_RUSTLE, 30, TRUE)
		return

	// MOVE US
	if(isturf(loc))
		can_move = world.time + move_delay
		try_step_multiz(direction)
		SpinAnimation(move_delay, 1, direction == NORTH || direction == EAST)

/obj/item/mmi/posibrain/sphere/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	if(brainmob && isturf(loc))
		anchored = TRUE //anchor so we dont broom ourselves.
		do_sweep(src, brainmob, loc, get_dir(old_loc, loc)) //movement dir doesnt work on objects
		anchored = FALSE

/// Punt the shit across the room
/obj/item/mmi/posibrain/sphere/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return .
	throw_at(get_edge_target_turf(src, get_dir(user, src)), 7, 1, user)
	user.do_attack_animation(src)
	can_move = world.time + move_delay //pweeze stawp
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
