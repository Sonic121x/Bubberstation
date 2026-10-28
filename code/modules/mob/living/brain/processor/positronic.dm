#define POSIBRAIN_NAG_COOLDOWN 60 SECONDS

/obj/item/brain_processor/positronic
	name = "正电子脑"
	desc = "一个闪亮的金属立方体，边长四英寸，表面布满浅浅的凹槽。"
	icon_state = "posibrain"
	base_icon_state = "posibrain"
	w_class = WEIGHT_CLASS_SMALL // BUBBER EDIT: Minimalizaton (This is so they can act as organs)
	req_access = list(ACCESS_ROBOTICS)
	braintype = "Android"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.85, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.67, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT)

	/// Holds the timer ID for pinging ghosts.
	VAR_PRIVATE/ghost_ping_timer
	/// Time before pinging ghosts will also play a sound.
	STATIC_COOLDOWN_DECLARE(ghost_nag_cooldown)

	///Role assigned to the newly created mind
	var/posibrain_job_path = /datum/job/positronic_brain
	///Can be set to tell ghosts what the brain will be used for
	VAR_FINAL/requested_personality
	///Hashset of all ckeys who has already entered this posibrain once before. Lazy.
	VAR_FINAL/list/ckeys_entered

/obj/item/brain_processor/positronic/Initialize(mapload, autoping = TRUE)
	. = ..()
	// THIS brainmob is the only brainmob that we should ever use for all of our existance
	// If the brainmob becomes null or gets replaced, this is invalid behaviour
	set_brainmob(new /mob/living/brain(src))
	brainmob.grant_language(/datum/language/machine, source = LANGUAGE_ATOM)

	var/new_name = pick(GLOB.posibrain_names)
	var/new_id = num2text(rand(1, 999), 3, 10)
	set_name("[new_name]-[new_id]")
	if(autoping)
		ping_ghosts("已被制造", TRUE)

/obj/item/brain_processor/positronic/Destroy(force)
	stop_requesting_ghost()
	return ..()

/obj/item/brain_processor/positronic/update_icon_state()
	. = ..()
	var/suffix
	if(is_searching())
		suffix = "searching"
	else if(brainmob.ckey)
		suffix = "occupied"

	icon_state = "[base_icon_state][suffix ? "-[suffix]" : null]"

/obj/item/brain_processor/positronic/examine(mob/user)
	. = ..()
	if(brainmob.key)
		if(brainmob.stat >= DEAD)
			. += span_deadsay("它似乎完全没有活动。")
		else if(!brainmob.client)
			. += "它似乎处于待机模式。" //afk
		return

	if(is_searching())
		. += span_info("它正有节奏地闪烁着光芒。")
	else
		. += span_deadsay("它似乎完全没有活动，重置指示灯正在闪烁。")

	if(requested_personality && (isobserver(user) || user.is_holding(src)))
		. += span_notice("当前意识种子：“[requested_personality]”")
	. += span_boldnotice("Alt 点击可设置意识种子，指定 [src] 的用途。这有助于生成对该职责感兴趣的人格。")

/obj/item/brain_processor/positronic/click_alt(mob/living/user)
	var/input_seed = tgui_input_text(user, "请输入人格种子：", "输入种子", html_decode(requested_personality), max_length = MAX_NAME_LEN)

	if(!user.can_perform_action(src) || isnull(input_seed))
		return CLICK_ACTION_BLOCKING

	if(!input_seed)
		to_chat(user, span_notice("你清除了人格种子。"))
		requested_personality = null
	else
		to_chat(user, span_notice("你将人格种子设为“[input_seed]”。"))
		requested_personality = input_seed

	return CLICK_ACTION_SUCCESS

/obj/item/brain_processor/positronic/attack_self(mob/user)
	. = ..()
	if(.)
		return
	. = TRUE

	if(is_occupied())
		balloon_alert(user, "已经激活！")
		return
	if(is_searching())
		balloon_alert(user, "已经在搜索了！")
		return
	if(!(GLOB.ghost_role_flags & GHOSTROLE_SILICONS))
		to_chat(user, span_warning("中央指挥部已禁止本星区的正电子脑获得意识。"))
		return

	to_chat(user, span_notice("你按下手动激活按钮，启动了 [src] 的开机流程。"))
	start_requesting_ghost()

/obj/item/brain_processor/positronic/attack_ghost(mob/user)
	if(is_occupied())
		return
	if(LAZYACCESS(ckeys_entered, user.ckey))
		to_chat(user, span_warning("你无法再次进入 [src]！"))
		return

	if(is_banned_from(user.ckey, ROLE_POSIBRAIN))
		to_chat(user, span_warning("你目前[span_bold("已被禁止")]扮演[chinese_job_display(ROLE_POSIBRAIN)]！"))
		return
	if(QDELETED(src) || QDELETED(user)) // is_banned_from is a sleeping proc
		return

	var/posi_ask = tgui_alert(user, "要成为[initial(name)]吗？\n你将无法再被复活，并会忘记之前所有生命的记忆！", "确认", list("Yes","No"))
	if(posi_ask != "Yes" || QDELETED(src) || QDELETED(user))
		return
	if(is_occupied()) // check one more time...
		INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(tgui_alert), user, "在你确认之前，[src] 已被别人占据。", "太晚了", list(pick("可恶", "哎呀", "唉", ":(")))
		return

	// now insert the ghost
	insert_ghost(user)
	var/policy = get_policy(ROLE_POSIBRAIN)
	if(policy)
		to_chat(brainmob, policy)

	stop_requesting_ghost()
	visible_message(span_notice("[src] 发出“叮”的一声，指示灯开始闪烁！"), null, span_hear("你听到某个东西发出“叮”的一声。"))
	playsound(src, 'sound/machines/ping.ogg', 15, TRUE)

/// Notify ghosts that the posibrain is up for grabs.
/obj/item/brain_processor/positronic/proc/ping_ghosts(msg, forced)
	SHOULD_NOT_OVERRIDE(TRUE)
	PRIVATE_PROC(TRUE)

	var/should_nag = !forced && COOLDOWN_FINISHED(src, ghost_nag_cooldown)

	notify_ghosts(
		"[name]在[get_area(src)][msg]！[requested_personality ? "人格需求：\[[requested_personality]\]" : ""]",
		source = src,
		header = "机器中的幽灵",
		click_interact = TRUE,
		ghost_sound = should_nag ? 'sound/effects/ghost2.ogg' : null,
		ignore_key = POLL_IGNORE_POSIBRAIN,
		notify_flags = (GHOST_NOTIFY_IGNORE_MAPLOAD),
		notify_volume = 75,
	)

	if(should_nag)
		COOLDOWN_START(src, ghost_nag_cooldown, POSIBRAIN_NAG_COOLDOWN)

/// Sends out a request for a ghost to possess this posibrain.
/obj/item/brain_processor/positronic/proc/start_requesting_ghost()
	SHOULD_NOT_OVERRIDE(TRUE)
	PROTECTED_PROC(TRUE)

	ghost_ping_timer = addtimer(CALLBACK(src, PROC_REF(stop_requesting_ghost)), POSIBRAIN_NAG_COOLDOWN, TIMER_STOPPABLE)
	update_appearance(UPDATE_ICON)

	ping_ghosts("发出请求", FALSE)

/obj/item/brain_processor/positronic/proc/stop_requesting_ghost()
	SHOULD_NOT_OVERRIDE(TRUE)
	PRIVATE_PROC(TRUE)

	deltimer(ghost_ping_timer)
	ghost_ping_timer = null
	update_appearance(UPDATE_ICON)

	if(!brainmob.ckey) // not an ideal spot for this but it works...
		visible_message(span_notice("[src] 的灯光逐渐黯淡，缓缓进入休眠……"))

/// Forces a ghost into the posibrain.
/obj/item/brain_processor/positronic/proc/insert_ghost(mob/dead/observer/user)
	set_suicide(FALSE) // the old occupant may have suicided
	brainmob.set_stat(STABLE)

	// Note that if we are currently possessed you will send the old ghost back to the lobby (and kick them if still logged in)
	brainmob.PossessByPlayer(user.ckey) // inits our mind if relevant
	brainmob.mind.set_assigned_role(SSjob.get_job_type(posibrain_job_path))

	LAZYSET(ckeys_entered, brainmob.ckey, TRUE)

/obj/item/brain_processor/positronic/proc/is_occupied()
	if(brainmob.key)
		return TRUE
	if(astype(loc, /mob/living/silicon/robot)?.mmi == src)
		return TRUE
	return FALSE

/obj/item/brain_processor/positronic/proc/is_searching()
	return !!ghost_ping_timer // lol

/obj/item/brain_processor/positronic/transfer_identity(mob/living/transferred_user)
	. = ..()
	// this is a little awkward...
	transferred_user.mind.set_assigned_role(SSjob.get_job_type(posibrain_job_path))
	transferred_user.mind.remove_all_antag_datums()
	transferred_user.mind.wipe_memory()
	update_appearance(UPDATE_ICON)

/obj/item/brain_processor/positronic/display
	name = "展示用正电子脑"
	desc = "一具小型正电子脑，不允许下载人格。"

/obj/item/brain_processor/positronic/display/is_occupied()
	return TRUE

/// Posibrains but spherical. They can roll around and you can kick them
/obj/item/brain_processor/positronic/sphere
	name = "正电子球"
	desc = "近来的降本措施让我们能把正电子脑方块切成成本减半的球体。\
	不幸的是，这也让它们能够靠滚动在实验室里四处移动。"
	icon_state = "spheribrain"
	base_icon_state = "spheribrain"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4.2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3.2, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 2.5)
	/// Delay between movements
	VAR_PROTECTED/move_delay = 0.5 SECONDS
	/// when can we move again?
	COOLDOWN_DECLARE(move_cooldown)

/obj/item/brain_processor/positronic/sphere/Initialize(mapload, autoping)
	. = ..()

	var/matrix/matrix = matrix()
	transform = matrix.Scale(0.8, 0.8)

/obj/item/brain_processor/positronic/sphere/relaymove(mob/living/user, direction)
	. = ..()
	if(isspaceturf(loc) || !direction)
		return

	if(!COOLDOWN_FINISHED(src, move_cooldown))
		return
	COOLDOWN_START(src, move_cooldown, move_delay)

	// MOVE US
	if(isturf(loc))
		try_step_multiz(direction)
		SpinAnimation(move_delay, 1, direction == NORTH || direction == EAST)
	// ESCAPE PRISON
	else if(istype(loc, /obj/item/storage))
		if(prob(25))
			var/obj/item/item = pick(loc.contents) // toss something out (which could be us!)
			item.forceMove(loc.drop_location())
			playsound(src, SFX_RUSTLE, 30, TRUE)

/obj/item/brain_processor/positronic/sphere/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	if(brainmob && isturf(loc))
		anchored = TRUE //anchor so we dont broom ourselves.
		do_sweep(src, brainmob, loc, get_dir(old_loc, loc)) //movement dir doesnt work on objects
		anchored = FALSE

/obj/item/brain_processor/positronic/sphere/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return .

	visible_message(\
		span_danger("[user] 用力一脚把 [src] 踢飞了！"), \
		span_userdanger("[user] 把你当足球踢飞了！"), \
		span_danger("你听到某个东西被击中了！"))
	user.do_attack_animation(src)
	playsound(src, SFX_PUNCH, 40, TRUE)

	throw_at(get_edge_target_turf(src, get_dir(user, src)), 7, 1, user, TRUE)
	COOLDOWN_START(src, move_cooldown, move_delay) //pweeze stawp
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

#undef POSIBRAIN_NAG_COOLDOWN
