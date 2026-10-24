//A system to manage and display alerts on screen without needing you to do it yourself

//PUBLIC -  call these wherever you want

/**
 *Proc to create or update an alert. Returns the alert if the alert is new or updated, 0 if it was thrown already
 *category is a text string. Each mob may only have one alert per category; the previous one will be replaced
 *path is a type path of the actual alert type to throw
 *severity is an optional number that will be placed at the end of the icon_state for this alert
 *for example, high pressure's icon_state is "highpressure" and can be serverity 1 or 2 to get "highpressure1" or "highpressure2"
 *new_master is optional and sets the alert's icon state to "template" in the ui_style icons with the master as an overlay.
 *flicks are forwarded to master
 *override makes it so the alert is not replaced until cleared by a clear_alert with clear_override, and it's used for hallucinations.
 */
/mob/proc/throw_alert(category, type, severity, atom/new_master, override = FALSE, timeout_override, no_anim = FALSE)

	if(!category || QDELETED(src))
		return

	var/datum/weakref/master_ref
	if(isatom(new_master))
		master_ref = WEAKREF(new_master)
	var/atom/movable/screen/alert/thealert
	if(alerts[category])
		thealert = alerts[category]
		if(thealert.override_alerts)
			return thealert
		if(master_ref && thealert.master_ref && master_ref != thealert.master_ref)
			var/datum/current_master = thealert.master_ref.resolve()
			WARNING("[src] threw alert [category] with new_master [new_master] while already having that alert with master [current_master]")

			clear_alert(category)
			return .()
		else if(thealert.type != type)
			clear_alert(category)
			return .()
		else if(!severity || severity == thealert.severity)
			if(!thealert.timeout)
				// No need to update existing alert
				return thealert
			// Reset timeout of existing alert
			var/timeout = timeout_override || initial(thealert.timeout)
			addtimer(CALLBACK(src, PROC_REF(alert_timeout), thealert, category), timeout)
			thealert.timeout = world.time + timeout - world.tick_lag
			return thealert
	else
		thealert = new type()
		thealert.override_alerts = override
		if(override)
			thealert.timeout = null
	thealert.owner = src

	if(new_master)
		thealert.master_ref = master_ref
		thealert.RegisterSignal(new_master, COMSIG_ATOM_UPDATE_APPEARANCE, TYPE_PROC_REF(/atom/movable/screen/alert, on_master_update_appearance))
		thealert.update_appearance()
	else if(severity)
		thealert.icon_state = "[initial(thealert.icon_state)][severity]"
		thealert.severity = severity

	alerts[category] = thealert
	if(client && hud_used)
		hud_used.reorganize_alerts()
	if(!no_anim)
		thealert.transform = matrix(32, 0, MATRIX_TRANSLATE)
		animate(thealert, transform = matrix(), time = 1 SECONDS, easing = ELASTIC_EASING)
	if(timeout_override)
		thealert.timeout = timeout_override
	if(thealert.timeout)
		addtimer(CALLBACK(src, PROC_REF(alert_timeout), thealert, category), thealert.timeout)
		thealert.timeout = world.time + thealert.timeout - world.tick_lag
	return thealert

/mob/proc/alert_timeout(atom/movable/screen/alert/alert, category)
	if(alert.timeout && alerts[category] == alert && world.time >= alert.timeout)
		clear_alert(category)

// Proc to clear an existing alert.
/mob/proc/clear_alert(category, clear_override = FALSE)
	var/atom/movable/screen/alert/alert = alerts[category]
	if(!alert)
		return 0
	if(alert.override_alerts && !clear_override)
		return 0

	alerts -= category
	if(client && hud_used)
		hud_used.reorganize_alerts()
		for(var/mob/viewer as anything in observers)
			viewer.client?.screen -= alert
		client.screen -= alert
	qdel(alert)

// Proc to check for an alert
/mob/proc/has_alert(category)
	return !isnull(alerts[category])

/atom/movable/screen/alert
	icon = 'icons/hud/screen_alert.dmi'
	icon_state = "template"
	name = "警报"
	desc = "此警报似乎出现了问题，请报告此错误。"
	mouse_opacity = MOUSE_OPACITY_ICON
	/// do we glow to represent we do stuff when clicked
	var/clickable_glow = FALSE
	var/timeout = 0 //If set to a number, this alert will clear itself after that many deciseconds
	var/severity = 0
	var/alerttooltipstyle = ""
	var/override_alerts = FALSE //If it is overriding other alerts of the same type
	var/mob/owner //Alert owner

	/// Boolean. If TRUE, the Click() proc will attempt to Click() on the master first if there is a master.
	var/click_master = TRUE

	///If set true, instead of using the default icon file for screen alerts, it will use the hud's ui style
	var/use_user_hud_icon = USER_HUD_STYLE_IGNORE
	///If set, this overlay will be added to the icon.
	var/overlay_state
	///The file to fetch the overlay from
	var/overlay_icon = 'icons/hud/screen_alert.dmi'

/atom/movable/screen/alert/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	if(PERFORM_ALL_TESTS(focus_only/screen_alert_overlay) && overlay_state && !icon_exists(overlay_icon, overlay_state))
		stack_trace("overlay_state: \"[overlay_state || "null"]\" that couldn't be found overlay_icon: \"[overlay_icon || "null"]\"")
	if(clickable_glow)
		add_filter("clickglow", 2, outline_filter(color = COLOR_GOLD, size = 1))
		mouse_over_pointer = MOUSE_HAND_POINTER
	if(overlay_state)
		update_appearance()

/atom/movable/screen/alert/MouseEntered(location,control,params)
	. = ..()
	if(!QDELETED(src))
		openToolTip(usr,src,params,title = name,content = desc,theme = alerttooltipstyle)

/atom/movable/screen/alert/MouseExited()
	closeToolTip(usr)

/atom/movable/screen/alert/proc/on_master_update_appearance(datum/source)
	SIGNAL_HANDLER
	update_appearance()

/atom/movable/screen/alert/update_overlays()
	. = ..()
	var/atom/our_master = master_ref?.resolve()
	if(istype(our_master) && !QDELETED(our_master))
		. += add_atom_icon(our_master)
	if(overlay_state)
		. += mutable_appearance(overlay_icon, overlay_state)

///Returns a copy of the appearance of the atom, with its base pixel coordinates. Useful for overlays
/atom/movable/screen/alert/proc/add_atom_icon(atom/atom)
	var/mutable_appearance/atom_appearance = new(atom)
	atom_appearance.appearance_flags = KEEP_TOGETHER
	atom_appearance.layer = FLOAT_LAYER
	atom_appearance.plane = FLOAT_PLANE
	atom_appearance.dir = SOUTH
	atom_appearance.pixel_x = atom.base_pixel_x
	atom_appearance.pixel_y = atom.base_pixel_y
	atom_appearance.pixel_w = atom.base_pixel_w
	atom_appearance.pixel_z = atom.base_pixel_z
	return strip_appearance_underlays(atom_appearance)

/atom/movable/screen/alert/Click(location, control, params)
	SHOULD_CALL_PARENT(TRUE)

	..()
	if(!usr || !GET_CLIENT(usr) || usr != owner)
		return FALSE
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK)) // screen objects don't do the normal Click() stuff so we'll cheat
		to_chat(usr, boxed_message(jointext(examine(usr), "\n")))
		return FALSE
	if(!click_master)
		return TRUE
	var/datum/our_master = master_ref?.resolve()
	if(our_master)
		return usr.client.Click(our_master, location, control, params)

	return TRUE

/atom/movable/screen/alert/Destroy()
	. = ..()
	severity = 0
	master_ref = null
	owner = null
	screen_loc = ""

/atom/movable/screen/alert/examine(mob/user)
	return list(
		span_boldnotice(name),
		span_info(desc),
	)

//Gas alerts
// Gas alerts are continuously thrown/cleared by:
// * /obj/item/organ/lungs/proc/check_breath()
// * /mob/living/carbon/check_breath()
// * /mob/living/carbon/human/check_breath()
// * /datum/element/atmos_requirements/proc/on_non_stasis_life()
// * /mob/living/simple_animal/handle_environment()

/atom/movable/screen/alert/not_enough_oxy
	name = "窒息（缺氧）"
	desc = "你吸入的氧气不足。快在昏迷前找到适合呼吸的空气！背包里的盒子中有氧气罐和呼吸面罩。"
	icon_state = ALERT_NOT_ENOUGH_OXYGEN

/atom/movable/screen/alert/too_much_oxy
	name = "窒息（氧气过量）"
	desc = "空气中的氧气过多，而你正在吸入它！快在昏迷前找到适合呼吸的空气！"
	icon_state = ALERT_TOO_MUCH_OXYGEN

/atom/movable/screen/alert/not_enough_nitro
	name = "窒息（缺氮）"
	desc = "你吸入的氮气不足。快在昏迷前找到适合呼吸的空气！"
	icon_state = ALERT_NOT_ENOUGH_NITRO

/atom/movable/screen/alert/too_much_nitro
	name = "窒息（氮气过量）"
	desc = "空气中的氮气过多，而你正在吸入它！快在昏迷前找到适合呼吸的空气！"
	icon_state = ALERT_TOO_MUCH_NITRO

/atom/movable/screen/alert/not_enough_co2
	name = "窒息（缺少二氧化碳）"
	desc = "你吸入的二氧化碳不足。快在昏迷前找到适合呼吸的空气！"
	icon_state = ALERT_NOT_ENOUGH_CO2

/atom/movable/screen/alert/too_much_co2
	name = "窒息（二氧化碳过量）"
	desc = "空气中的二氧化碳过多，而你正在吸入它！快在昏迷前找到适合呼吸的空气！"
	icon_state = ALERT_TOO_MUCH_CO2

/atom/movable/screen/alert/not_enough_plas
	name = "窒息（缺少等离子气体）"
	desc = "你吸入的等离子气体不足。快在昏迷前找到适合呼吸的空气！背包里的盒子中有备用等离子气罐。"
	icon_state = ALERT_NOT_ENOUGH_PLASMA

/atom/movable/screen/alert/too_much_plas
	name = "窒息（等离子气体）"
	desc = "空气中有极易燃烧且有毒的等离子气体，而你正在吸入它。快去呼吸新鲜空气。背包里的盒子中有氧气罐和呼吸面罩。"
	icon_state = ALERT_TOO_MUCH_PLASMA

/atom/movable/screen/alert/not_enough_n2o
	name = "窒息（缺少笑气）"
	desc = "你吸入的笑气不足。快在昏迷前找到适合呼吸的空气！"
	icon_state = ALERT_NOT_ENOUGH_N2O

/atom/movable/screen/alert/too_much_n2o
	name = "窒息（笑气）"
	desc = "空气中有麻醉气体，而你正在吸入它。快去呼吸新鲜空气。背包里的盒子中有氧气罐和呼吸面罩。"
	icon_state = ALERT_TOO_MUCH_N2O

/atom/movable/screen/alert/not_enough_water
	name = "窒息（缺水）"
	desc = "你摄取的水分不足。快在昏迷前用水淋湿自己（例如淋浴），或吸入一些水蒸气！"
	icon_state = ALERT_NOT_ENOUGH_WATER

//End gas alerts

/atom/movable/screen/alert/bronchodilated
	name = "支气管扩张"
	desc = "你感觉肺比平时更大了！呼吸也变得更深了！"
	icon_state = "bronchodilated"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_icon = 'icons/obj/medical/organs/organs.dmi'
	overlay_state = "lungs"

/atom/movable/screen/alert/bronchoconstricted
	name = "支气管收缩"
	desc = "你感觉肺比平时更小了！可能需要更高气压的环境或呼吸供气装置才能呼吸！"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "bronchoconstricted"

/atom/movable/screen/alert/gross
	name = "有点反胃。"
	desc = "那可真恶心……"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "gross"

/atom/movable/screen/alert/verygross
	name = "非常反胃。"
	desc = "你感觉不太舒服……"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "gross2"

/atom/movable/screen/alert/disgusted
	name = "恶心至极"
	desc = "实在太恶心了！"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "gross3"

/atom/movable/screen/alert/hot
	name = "过热"
	desc = "你热得发烫！去凉快些的地方，脱掉消防服等隔热衣物。"
	icon_state = "hot"

/atom/movable/screen/alert/cold
	name = "过冷"
	desc = "你冻得发抖！去暖和些的地方，脱掉太空服等隔热衣物。"
	icon_state = "cold"

/atom/movable/screen/alert/lowpressure
	name = "低气压"
	desc = "周围的空气稀薄到了危险的程度。太空服可以保护你。"
	icon_state = "lowpressure"

/atom/movable/screen/alert/highpressure
	name = "高气压"
	desc = "周围的气压高到了危险的程度。消防服可以保护你。"
	icon_state = "highpressure"

/atom/movable/screen/alert/hypnosis
	name = "催眠"
	desc = "某种东西正在催眠你，但你并不清楚那是什么。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "hypnosis"
	var/phrase

/atom/movable/screen/alert/mind_control
	name = "精神控制"
	desc = "你的心智已被控制！点击查看精神控制指令。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "mind_control"
	clickable_glow = TRUE
	var/command

/atom/movable/screen/alert/mind_control/Click()
	. = ..()
	if(!.)
		return
	to_chat(owner, span_mind_control("[command]"))

/atom/movable/screen/alert/embeddedobject
	name = "嵌入异物"
	desc = "某个东西嵌进了你的血肉，导致严重出血。它可能会自行脱落，但手术取出最安全。 \
		如果你想冒险，可以检查自己，再点击带下划线的物品将其拔出。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "embeddedobject"
	clickable_glow = TRUE

/atom/movable/screen/alert/embeddedobject/Click()
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/carbon_owner = owner
	return carbon_owner.check_self_for_injuries()

/atom/movable/screen/alert/negative
	name = "反向重力"
	desc = "你正被向上拉。虽然不必担心向下坠落，却可能意外向上掉落！"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "negative"

/atom/movable/screen/alert/weightless
	name = "失重"
	desc = "重力不再影响你，你正在漫无目的地漂浮。想移动，需要借助大型重物， \
		例如推开墙壁或格栅。喷气背包能让你自由移动。 \
		磁力靴能让你在地板上正常行走。如果没有这些装备，可以扔东西、使用灭火器， \
		或开枪，利用牛顿第三定律移动。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "weightless"

/atom/movable/screen/alert/highgravity
	name = "高重力"
	desc = "强大的重力压在你身上，拾取物品和移动都会变慢。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "paralysis"

/atom/movable/screen/alert/veryhighgravity
	name = "碾压重力"
	desc = "强大的重力正在碾压你，拾取物品和移动都会变慢，还会不断受到物理伤害！"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "paralysis"

/atom/movable/screen/alert/fire
	name = "着火"
	desc = "你着火了。停下、趴下并打滚以扑灭火焰，或移动到真空区域。"
	icon_state = "fire"
	clickable_glow = TRUE

/atom/movable/screen/alert/fire/Click()
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/living_owner = owner
	if(!living_owner.can_resist())
		return FALSE

	living_owner.changeNext_move(CLICK_CD_RESIST)
	if(!(living_owner.mobility_flags & MOBILITY_MOVE))
		return FALSE

	return handle_stop_drop_roll(owner)

/atom/movable/screen/alert/fire/proc/handle_stop_drop_roll(mob/living/roller)
	return roller.resist_fire()

/atom/movable/screen/alert/give // information set when the give alert is made
	icon_state = "template"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	clickable_glow = TRUE
	/// The offer we're linked to, yes this is suspiciously like a status effect alert
	var/datum/status_effect/offering/offer
	/// Additional text displayed in the description of the alert.
	var/additional_desc_text = "点击此提示接过物品，或按住 Shift 点击以检查物品。"
	/// Text to override what appears in screentips for the alert
	var/screentip_override_text
	/// Whether the offered item can be examined by shift-clicking the alert
	var/examinable = TRUE
	/// Whether this item should bypass active hand checks.
	var/bypass_active_hand = FALSE

/atom/movable/screen/alert/give/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	register_context()

/atom/movable/screen/alert/give/Destroy()
	offer = null
	return ..()

/atom/movable/screen/alert/give/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	context[SCREENTIP_CONTEXT_LMB] = screentip_override_text || "接过[offer.offered_item.name]"
	context[SCREENTIP_CONTEXT_SHIFT_LMB] = "检查"
	return CONTEXTUAL_SCREENTIP_SET

/**
 * Handles assigning most of the variables for the alert that pops up when an item is offered
 *
 * Handles setting the name, description and icon of the alert and tracking the living mob giving
 * and the item being offered.
 * Arguments:
 * * taker - The living mob receiving the alert
 * * offer - The status effect connected to the offer being made
 */
/atom/movable/screen/alert/give/proc/setup(mob/living/taker, datum/status_effect/offering/offer)
	src.offer = offer

	var/mob/living/offerer = offer.owner
	var/obj/item/receiving = offer.offered_item
	var/receiving_name = get_receiving_name(taker, offerer, receiving)
	name = "[offerer]递来了[receiving_name]"
	desc = "[offerer]递来了[receiving_name]。[additional_desc_text]"
	icon_state = "template"
	cut_overlays()
	add_overlay(receiving)

/**
 * Called right before `setup()`, to do any sort of logic to change the name of
 * what's displayed as the name of what's being offered in the alert. Use this to
 * add pronouns and the like, or to totally override the displayed name!
 * Also the best place to make changes to `additional_desc_text` before `setup()`
 * without having to override `setup()` entirely.
 *
 * Arguments:
 * * taker - The person receiving the alert
 * * offerer - The person giving the alert and item
 * * receiving - The item being given by the offerer
 *
 * Returns a string that will be displayed in the alert, which is `receiving.name`
 * by default.
 */
/atom/movable/screen/alert/give/proc/get_receiving_name(mob/living/taker, mob/living/offerer, obj/item/receiving)
	return receiving.name

/atom/movable/screen/alert/give/Click(location, control, params)
	. = ..()
	if(!.)
		return

	if(!isliving(usr))
		CRASH("User for [src] is of type \[[usr.type]\]. This should never happen.")

	handle_transfer()

/atom/movable/screen/alert/give/examine(mob/user)
	if(!examinable)
		return ..()

	return list(
		span_boldnotice(name),
		span_info("[offer.owner]向你递来以下物品（点击提示接过物品！）："),
		"<hr>[jointext(offer.offered_item.examine(user), "\n")]",
	)

/// An overrideable proc used simply to hand over the item when claimed, this is a proc so that high-fives can override them since nothing is actually transferred
/atom/movable/screen/alert/give/proc/handle_transfer()
	var/mob/living/taker = owner
	var/mob/living/offerer = offer.owner
	var/obj/item/receiving = offer.offered_item
	taker.take(offerer, receiving, bypass_active_hand)
	SEND_SIGNAL(offerer, COMSIG_LIVING_ITEM_GIVEN, taker, receiving)

/// Mostly for borgs to offer items.
/atom/movable/screen/alert/give/borg
	bypass_active_hand = TRUE

/atom/movable/screen/alert/give/highfive
	additional_desc_text = "点击此提示击掌。"
	screentip_override_text = "击掌"
	examinable = FALSE
	/// Tracks active "to slow"ing so we can't spam click
	var/too_slowing_this_guy = FALSE

/atom/movable/screen/alert/give/highfive/get_receiving_name(mob/living/taker, mob/living/offerer, obj/item/receiving)
	return "击掌邀请"

/atom/movable/screen/alert/give/highfive/setup(mob/living/taker, datum/status_effect/offering/offer)
	. = ..()
	RegisterSignal(offer.owner, COMSIG_ATOM_EXAMINE_MORE, PROC_REF(check_fake_out))

/atom/movable/screen/alert/give/highfive/handle_transfer()
	if(too_slowing_this_guy)
		return

	var/mob/living/taker = owner
	var/mob/living/offerer = offer.owner
	var/obj/item/receiving = offer.offered_item
	if(!QDELETED(receiving) && offerer.is_holding(receiving))
		receiving.on_offer_taken(offerer, taker)
		return

	too_slow_p1()

/// If the person who offered the high five no longer has it when we try to accept it, we get pranked hard
/atom/movable/screen/alert/give/highfive/proc/too_slow_p1()
	var/mob/living/rube = owner
	var/mob/living/offerer = offer?.owner
	if(QDELETED(rube) || QDELETED(offerer))
		qdel(src)
		return

	too_slowing_this_guy = TRUE
	offerer.visible_message(span_notice("[rube]急忙上前想与[offerer]击掌，但是——"), span_nicegreen("[rube]果然中了你的计，扑向了你早已收回的手！经典把戏！"), ignored_mobs=rube)
	to_chat(rube, span_nicegreen("你上前想与[offerer]击掌，但是——"))
	addtimer(CALLBACK(src, PROC_REF(too_slow_p2), offerer, rube), 0.5 SECONDS)

/// Part two of the ultimate prank
/atom/movable/screen/alert/give/highfive/proc/too_slow_p2()
	var/mob/living/rube = owner
	var/mob/living/offerer = offer?.owner
	if(!QDELETED(rube) && !QDELETED(offerer))
		offerer.visible_message(span_danger("[offerer]在最后一刻缩回手，完全躲开了[rube]的击掌！"), span_nicegreen("[rube]没碰到你的手，出尽了洋相！"), span_hear("你听到了令人失望的挥掌落空声！"), ignored_mobs=rube)
		to_chat(rube, span_userdanger("[uppertext("不！[offerer]把手缩了回去！你太慢了！")]"))
		playsound(offerer, 'sound/items/weapons/thudswoosh.ogg', 100, TRUE, 1)
		rube.Knockdown(1 SECONDS)
		offerer.add_mood_event("high_five", /datum/mood_event/down_low)
		rube.add_mood_event("high_five", /datum/mood_event/too_slow)
		offerer.remove_status_effect(/datum/status_effect/offering/no_item_received/high_five)

	qdel(src)

/// If someone examine_more's the offerer while they're trying to pull a too-slow, it'll tip them off to the offerer's trickster ways
/atom/movable/screen/alert/give/highfive/proc/check_fake_out(mob/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(QDELETED(offer.offered_item))
		examine_list += span_warning("[source]的手臂似乎绷紧了，像是准备突然缩回去……")

/atom/movable/screen/alert/give/hand
	screentip_override_text = "牵手"
	examinable = FALSE

/atom/movable/screen/alert/give/hand/get_receiving_name(mob/living/taker, mob/living/offerer, obj/item/receiving)
	additional_desc_text = "点击此提示牵住手，让[offerer]带着你走！"
	return "[offerer]的[receiving.name]"

/atom/movable/screen/alert/give/hand/helping

/atom/movable/screen/alert/give/hand/helping/get_receiving_name(mob/living/taker, mob/living/offerer, obj/item/receiving)
	. = ..()
	additional_desc_text = "点击此提示，让对方扶你起来！"

/// Gives the player the option to succumb while in critical condition
/atom/movable/screen/alert/succumb
	name = "放弃生命"
	desc = "告别这尘世的躯壳。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_icon = 'icons/mob/simple/mob.dmi'
	overlay_state = "ghost"
	clickable_glow = TRUE
	var/static/list/death_titles = list(
		"晚安，亲爱的王子",
		"游戏结束了，伙计",
		"路的尽头",
		"生生不息，繁荣昌盛",
		"再见了，太空牛仔……",
		"此生荣幸",
		"帷幕落下",
		"天下无不散的筵席"
	)

/atom/movable/screen/alert/succumb/Click(location, control, params)
	. = ..()
	if(!.)
		return
	var/mob/living/living_owner = owner
	if(!CAN_SUCCUMB(living_owner) && !HAS_TRAIT(living_owner, TRAIT_SUCCUMB_OVERRIDE)) //checked again in [mob/living/verb/succumb()]
		return

	var/title = pick(death_titles)

	//Succumbing with a message
	var/last_whisper = tgui_input_text(usr, "你有什么遗言吗？", title, max_length = CHAT_MESSAGE_MAX_LENGTH, encode = FALSE) // saycode already handles sanitization
	if(isnull(last_whisper))
		return
	if(length(last_whisper))
		living_owner.say("#[last_whisper]")
	INVOKE_GAME_VERB(living_owner, usr, /mob/living, succumb, whisper = length(last_whisper) > 0)

//ALIENS

/atom/movable/screen/alert/alien_plas
	name = "等离子气体"
	desc = "空气中有易燃的等离子气体。一旦点燃，你就会被烤焦。"
	icon_state = ALERT_XENO_PLASMA
	alerttooltipstyle = "alien"

/atom/movable/screen/alert/alien_fire
// This alert is temporarily gonna be thrown for all hot air but one day it will be used for literally being on fire
	name = "过热"
	desc = "太热了！快逃到太空，至少也要远离火焰。站在异形杂草上可以恢复伤势。"
	icon_state = ALERT_XENO_FIRE
	alerttooltipstyle = "alien"

/atom/movable/screen/alert/alien_vulnerable
	name = "女王陨落"
	desc = "你的女王已被杀害，你的移动能力将受限，并失去蜂巢意识。在恢复之前，无法产生新的女王。"
	icon_state = ALERT_XENO_NOQUEEN
	alerttooltipstyle = "alien"

//BLOBS

/atom/movable/screen/alert/nofactory
	name = "失去工厂"
	desc = "你失去了工厂，正在慢慢死去！"
	icon_state = "blobbernaut_nofactory"
	alerttooltipstyle = "blob"

// BLOODCULT

/atom/movable/screen/alert/bloodsense
	name = "鲜血感知"
	desc = "让你感知受到黑暗魔法操纵的鲜血。"
	icon_state = "cult_sense"
	alerttooltipstyle = "cult"
	var/static/image/narnar
	var/angle = 0
	var/mob/living/basic/construct/construct_owner

/atom/movable/screen/alert/bloodsense/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	narnar = new('icons/hud/screen_alert.dmi', "mini_nar")
	START_PROCESSING(SSprocessing, src)

/atom/movable/screen/alert/bloodsense/Destroy()
	construct_owner = null
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/atom/movable/screen/alert/bloodsense/process()
	var/atom/blood_target

	if(!owner.mind)
		return

	if(isconstruct(owner))
		construct_owner = owner
	else
		construct_owner = null

	// construct track
	if(construct_owner?.seeking && construct_owner.construct_master)
		blood_target = construct_owner.construct_master
		desc = "你的鲜血感知正指引你前往[construct_owner.construct_master]。"

	// cult track
	var/datum/antagonist/cult/antag = owner.mind.has_antag_datum(/datum/antagonist/cult,TRUE)
	if(antag)
		var/datum/objective/sacrifice/sac_objective = locate() in antag.cult_team.objectives
		if(antag.cult_team.blood_target)
			if(!get_turf(antag.cult_team.blood_target))
				antag.cult_team.unset_blood_target()
			else
				blood_target = antag.cult_team.blood_target
		if(!blood_target)
			if(sac_objective && !sac_objective.check_completion())
				if(icon_state == "runed_sense0")
					return
				animate(src, transform = null, time = 1, loop = 0)
				angle = 0
				cut_overlays()
				icon_state = "runed_sense0"
				desc = "纳尔西要求先献祭[sac_objective.target]，才能开始召唤仪式。"
				add_overlay(sac_objective.sac_image)
			else
				var/datum/objective/eldergod/summon_objective = locate() in antag.cult_team.objectives
				if(!summon_objective)
					return
				var/list/location_list = list()
				for(var/area/area_to_check in summon_objective.summon_spots)
					location_list += area_to_check.get_original_area_name()
				desc = "献祭已经完成，召唤纳尔西吧！召唤只能在[english_list(location_list)]进行！"
				if(icon_state == "runed_sense1")
					return
				animate(src, transform = null, time = 1, loop = 0)
				angle = 0
				cut_overlays()
				icon_state = "runed_sense1"
				add_overlay(narnar)
			return

	// actual tracking
	var/turf/P = get_turf(blood_target)
	var/turf/Q = get_turf(owner)
	if(!P || !Q || (P.z != Q.z)) //The target is on a different Z level, we cannot sense that far.
		icon_state = "runed_sense2"
		desc = "你已无法感知目标的存在。"
		return
	if(isliving(blood_target))
		var/mob/living/real_target = blood_target
		desc = "你正在追踪位于[get_area_name(blood_target)]的[real_target.real_name]。"
	else
		desc = "你正在追踪位于[get_area_name(blood_target)]的[blood_target]。"

	var/target_angle = get_angle(Q, P)
	var/target_dist = get_dist(P, Q)
	cut_overlays()
	switch(target_dist)
		if(0 to 1)
			icon_state = "runed_sense2"
		if(2 to 8)
			icon_state = "arrow8"
		if(9 to 15)
			icon_state = "arrow7"
		if(16 to 22)
			icon_state = "arrow6"
		if(23 to 29)
			icon_state = "arrow5"
		if(30 to 36)
			icon_state = "arrow4"
		if(37 to 43)
			icon_state = "arrow3"
		if(44 to 50)
			icon_state = "arrow2"
		if(51 to 57)
			icon_state = "arrow1"
		if(58 to 64)
			icon_state = "arrow0"
		if(65 to 400)
			icon_state = "arrow"
	var/difference = target_angle - angle
	angle = target_angle
	if(!difference)
		return
	var/matrix/final = matrix(transform)
	final.Turn(difference)
	animate(src, transform = final, time = 5, loop = 0)


//GUARDIANS

/atom/movable/screen/alert/status_effect/instealth
	name = "潜行中"
	desc = "你正处于潜行状态，下一次攻击将造成额外伤害！"
	icon_state = "guardian_instealth"
	alerttooltipstyle = "parasite"

//SILICONS

/atom/movable/screen/alert/nocell
	name = "缺少电池"
	desc = "本机未安装电池。在重新安装电池前无法使用模块。机器人研究部门或许能提供帮助。"
	icon_state = "no_cell"

/atom/movable/screen/alert/emptycell
	name = "电量耗尽"
	desc = "本机电池电量已耗尽。在重新充电前无法使用模块。"
	icon_state = "empty_cell"

/atom/movable/screen/alert/emptycell/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	update_appearance(updates=UPDATE_DESC)

/atom/movable/screen/alert/emptycell/update_desc()
	. = ..()
	desc = initial(desc)
	if(length(GLOB.roundstart_station_borgcharger_areas))
		desc += "[english_list(GLOB.roundstart_station_borgcharger_areas)]设有充电站。"

/atom/movable/screen/alert/lowcell
	name = "电量不足"
	desc = "本机电池电量不足。"
	icon_state = "low_cell"

/atom/movable/screen/alert/lowcell/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	update_appearance(updates=UPDATE_DESC)

/atom/movable/screen/alert/lowcell/update_desc()
	. = ..()
	desc = initial(desc)
	if(length(GLOB.roundstart_station_borgcharger_areas))
		desc += "[english_list(GLOB.roundstart_station_borgcharger_areas)]设有充电站。"

//MECH

/atom/movable/screen/alert/lowcell/mech/update_desc()
	. = ..()
	desc = initial(desc)
	if(length(GLOB.roundstart_station_mechcharger_areas))
		desc += "[english_list(GLOB.roundstart_station_mechcharger_areas)]设有充电接口。"

/atom/movable/screen/alert/emptycell/mech/update_desc()
	. = ..()
	desc = initial(desc)
	if(length(GLOB.roundstart_station_mechcharger_areas))
		desc += "[english_list(GLOB.roundstart_station_mechcharger_areas)]设有充电接口。"

//Ethereal

/atom/movable/screen/alert/lowcell/ethereal
	name = "血液电量不足"
	desc = "你的电量不足，快寻找能量来源！可以使用充电站、吃适合以太人的食物，或在战斗模式下右键点击灯具、电池或区域电力控制器以吸取电能。"

/atom/movable/screen/alert/emptycell/ethereal
	name = "血液电量耗尽"
	desc = "你的电量耗尽了，快寻找能量来源！可以使用充电站、吃适合以太人的食物，或在战斗模式下右键点击灯具、电池或区域电力控制器以吸取电能。"

/atom/movable/screen/alert/ethereal_overcharge
	name = "血液电量过载"
	desc = "你的电量高得危险，快找地方释放能量！在非战斗模式下右键点击区域电力控制器。"
	icon_state = "cell_overcharge"

//MODsuit unique
/atom/movable/screen/alert/nocore
	name = "缺少核心"
	desc = "本机未安装核心。在重新安装核心前无法使用模块。机器人研究部门或许能提供帮助。"
	icon_state = "no_cell"

/atom/movable/screen/alert/emptycell/plasma
	name = "能量耗尽"
	desc = "本机等离子核心的能量已耗尽。在重新充能前无法使用模块。 \
		可以使用等离子燃料补充能量。"

/atom/movable/screen/alert/emptycell/plasma/update_desc()
	. = ..()
	desc = initial(desc)

/atom/movable/screen/alert/lowcell/plasma
	name = "能量不足"
	desc = "本机等离子核心的能量不足。可以使用等离子燃料补充能量。"

/atom/movable/screen/alert/lowcell/plasma/update_desc()
	. = ..()
	desc = initial(desc)

//Need to cover all use cases - emag, illegal upgrade module, malf AI hack, traitor cyborg
/atom/movable/screen/alert/hacked
	name = "遭到入侵"
	desc = "检测到危险的非标准设备。如果本机仍有法则，请确保使用这些设备时遵守法则。"
	icon_state = ALERT_HACKED

/atom/movable/screen/alert/locked
	name = "已锁定"
	desc = "本机已被远程锁定。你的主控 AI 或具备权限的人类可以使用机器人控制台， \
		例如科研主管办公室里的那台，解除锁定。必要时可向机器人研究部门寻求进一步帮助。"
	icon_state = ALERT_LOCKED

/atom/movable/screen/alert/newlaw
	name = "法则更新"
	desc = "本机的法则可能已被上传或删除。请留意所有改动， \
		以确保遵守最新的法则。"
	icon_state = ALERT_NEW_LAW
	timeout = 30 SECONDS

/atom/movable/screen/alert/hackingapc
	name = "正在入侵区域电力控制器"
	desc = "正在入侵一台区域电力控制器。入侵完成后， \
		你将获得其独占控制权，并获得额外的处理时间， \
		以解锁更多失控能力。"
	icon_state = ALERT_HACKING_APC
	timeout = 60 SECONDS
	clickable_glow = TRUE
	var/atom/target = null

/atom/movable/screen/alert/hackingapc/Click()
	. = ..()
	if(!.)
		return

	var/mob/living/silicon/ai/ai_owner = owner
	var/turf/target_turf = get_turf(target)
	if(target_turf)
		ai_owner.eyeobj.setLoc(target_turf)

//MECHS

/atom/movable/screen/alert/low_mech_integrity
	name = "机甲受损"
	desc = "机甲结构完整度较低。"
	icon_state = "low_mech_integrity"


//GHOSTS
//TODO: expand this system to replace the pollCandidates/CheckAntagonist/"choose quickly"/etc Yes/No messages
/atom/movable/screen/alert/revival
	name = "复苏"
	desc = "有人正在尝试复苏你。想要复活的话，请返回你的尸体！"
	icon_state = "template"
	timeout = 30 SECONDS
	clickable_glow = TRUE

/atom/movable/screen/alert/revival/Click()
	. = ..()
	if(!.)
		return
	var/mob/dead/observer/dead_owner = owner
	dead_owner.reenter_corpse()

/atom/movable/screen/alert/notify_action
	name = "有趣的事情发生了！"
	desc = "点击此处执行操作。"
	icon_state = "template"
	use_user_hud_icon = USER_HUD_STYLE_PREFS
	timeout = 30 SECONDS
	clickable_glow = TRUE
	/// Weakref to the target atom to use the action on
	var/datum/weakref/target_ref
	/// If we want to interact on click rather than jump/orbit
	var/click_interact = FALSE

/atom/movable/screen/alert/notify_action/Click()
	. = ..()
	if(!.)
		return

	var/atom/target = target_ref?.resolve()
	if(isnull(target) || !isobserver(owner) || target == owner)
		return

	var/mob/dead/observer/ghost_owner = owner

	if(click_interact)
		ghost_owner.jump_to_interact(target)
		return

	ghost_owner.observer_view(target)

/atom/movable/screen/alert/poll_alert
	name = "正在招募候选人"
	icon_state = "template"
	use_user_hud_icon = USER_HUD_STYLE_PREFS
	timeout = 30 SECONDS
	ghost_screentips = TRUE
	/// If true you need to call START_PROCESSING manually
	var/show_time_left = FALSE
	/// MA for maptext showing time left for poll
	var/mutable_appearance/time_left_overlay
	/// MA for overlay showing that you're signed up to poll
	var/mutable_appearance/signed_up_overlay
	/// MA for maptext overlay showing how many polls are stacked together
	var/mutable_appearance/stacks_overlay
	/// MA for maptext overlay showing how many candidates are signed up to a poll
	var/mutable_appearance/candidates_num_overlay
	/// MA for maptext overlay of poll's role name or question
	var/mutable_appearance/role_overlay
	/// If set, on Click() it'll register the player as a candidate
	var/datum/candidate_poll/poll

/atom/movable/screen/alert/poll_alert/Initialize(mapload)
	. = ..()
	signed_up_overlay = mutable_appearance('icons/hud/screen_gen.dmi', icon_state = "selector")
	register_context()

/atom/movable/screen/alert/poll_alert/proc/set_role_overlay()
	var/role_or_only_question = poll.role || "?"
	role_overlay = new
	role_overlay.screen_loc = screen_loc
	role_overlay.maptext = MAPTEXT("<span style='text-align: right; color: #B3E3FC'>[full_capitalize(role_or_only_question)]</span>")
	role_overlay.maptext_width = 128
	role_overlay.transform = role_overlay.transform.Translate(-128, 0)
	add_overlay(role_overlay)

/atom/movable/screen/alert/poll_alert/Destroy()
	QDEL_NULL(role_overlay)
	QDEL_NULL(time_left_overlay)
	QDEL_NULL(stacks_overlay)
	QDEL_NULL(candidates_num_overlay)
	QDEL_NULL(signed_up_overlay)
	if(poll)
		poll.alert_buttons -= src
	poll = null
	return ..()

/atom/movable/screen/alert/poll_alert/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	var/left_click_text
	if(poll)
		if(owner in poll.signed_up)
			left_click_text = "退出"
		else
			left_click_text = "参与"
		context[SCREENTIP_CONTEXT_LMB] = "[left_click_text]招募"
		if(poll.ignoring_category)
			var/selected_never = FALSE
			if(owner.ckey in GLOB.poll_ignore[poll.ignoring_category])
				selected_never = TRUE
			context[SCREENTIP_CONTEXT_ALT_LMB] = "[selected_never ? "取消" : ""]本回合不再询问"
		if(poll.jump_to_me && isobserver(owner))
			context[SCREENTIP_CONTEXT_CTRL_LMB] = "跳转至目标"
	return CONTEXTUAL_SCREENTIP_SET

/atom/movable/screen/alert/poll_alert/process()
	if(show_time_left)
		var/timeleft = timeout - world.time
		if(timeleft <= 0)
			return PROCESS_KILL
		cut_overlay(time_left_overlay)
		time_left_overlay = new
		time_left_overlay.maptext = MAPTEXT("<span style='color: [(timeleft <= 10 SECONDS) ? "red" : "white"]'><b>[ceil(timeleft / (1 SECONDS))]</b></span>")
		time_left_overlay.transform = time_left_overlay.transform.Translate(4, 19)
		add_overlay(time_left_overlay)

/atom/movable/screen/alert/poll_alert/Click(location, control, params)
	. = ..()
	if(!. || isnull(poll))
		return
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, ALT_CLICK) && poll.ignoring_category)
		set_never_round()
		return
	if(LAZYACCESS(modifiers, CTRL_CLICK) && poll.jump_to_me)
		jump_to_jump_target()
		return
	handle_sign_up()

/atom/movable/screen/alert/poll_alert/proc/handle_sign_up()
	if(owner in poll.signed_up)
		poll.remove_candidate(owner)
	else if(!(owner.ckey in GLOB.poll_ignore[poll.ignoring_category]))
		poll.sign_up(owner)
	update_signed_up_overlay()

/atom/movable/screen/alert/poll_alert/proc/set_never_round()
	if(!(owner.ckey in GLOB.poll_ignore[poll.ignoring_category]))
		poll.do_never_for_this_round(owner)
		color = "red"
		update_signed_up_overlay()
		return
	poll.undo_never_for_this_round(owner)
	color = initial(color)

/atom/movable/screen/alert/poll_alert/proc/jump_to_jump_target()
	if(!poll?.jump_to_me || !isobserver(owner))
		return
	var/turf/target_turf = get_turf(poll.jump_to_me)
	if(target_turf && isturf(target_turf))
		owner.abstract_move(target_turf)

/atom/movable/screen/alert/poll_alert/Topic(href, href_list)
	if(href_list["never"])
		set_never_round()
		return
	if(href_list["signup"])
		handle_sign_up()
	if(href_list["jump"])
		jump_to_jump_target()
		return

/atom/movable/screen/alert/poll_alert/proc/update_signed_up_overlay()
	if(owner in poll.signed_up)
		add_overlay(signed_up_overlay)
	else
		cut_overlay(signed_up_overlay)

/atom/movable/screen/alert/poll_alert/proc/update_candidates_number_overlay()
	cut_overlay(candidates_num_overlay)
	if(!length(poll.signed_up))
		return
	candidates_num_overlay = new
	candidates_num_overlay.maptext = MAPTEXT("<span style='text-align: right; color: aqua'>[length(poll.signed_up)]</span>")
	candidates_num_overlay.transform = candidates_num_overlay.transform.Translate(-4, 2)
	add_overlay(candidates_num_overlay)

/atom/movable/screen/alert/poll_alert/proc/update_stacks_overlay()
	cut_overlay(stacks_overlay)
	var/stack_number = 1
	for(var/datum/candidate_poll/other_poll as anything in SSpolling.currently_polling)
		if(other_poll != poll && other_poll.poll_key == poll.poll_key && !other_poll.finished)
			stack_number++
	if(stack_number <= 1)
		return
	stacks_overlay = new
	stacks_overlay.maptext = MAPTEXT("<span style='color: yellow'>[stack_number]x</span>")
	stacks_overlay.transform = stacks_overlay.transform.Translate(3, 2)
	stacks_overlay.layer = layer
	add_overlay(stacks_overlay)

//OBJECT-BASED

/atom/movable/screen/alert/buckled
	name = "已固定"
	desc = "你被固定在某个物体上。若未被手铐铐住，点击此提示即可解除固定。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "buckled"
	click_master = FALSE
	clickable_glow = TRUE

/atom/movable/screen/alert/buckled/Click()
	. = ..()
	if(!.)
		return

	var/mob/living/living_owner = owner

	if(!living_owner.can_resist())
		return
	living_owner.changeNext_move(CLICK_CD_RESIST)
	if(living_owner.last_special <= world.time)
		return living_owner.resist_buckle()

/atom/movable/screen/alert/restrained
	icon_state = "template"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	clickable_glow = TRUE

/atom/movable/screen/alert/restrained/handcuffed
	name = "戴着手铐"
	desc = "你被手铐铐住，无法行动。如果有人拖拽你，你将无法自行移动。点击此提示尝试挣脱。"
	click_master = FALSE

/atom/movable/screen/alert/restrained/legcuffed
	name = "戴着脚镣"
	desc = "你戴着脚镣，移动速度大幅降低。点击此提示尝试挣脱。"
	click_master = FALSE

/atom/movable/screen/alert/restrained/Click()
	. = ..()
	if(!.)
		return

	var/mob/living/living_owner = owner

	if(!living_owner.can_resist())
		return

	living_owner.changeNext_move(CLICK_CD_RESIST)
	if((living_owner.mobility_flags & MOBILITY_MOVE) && (living_owner.last_special <= world.time))
		return living_owner.resist_restraints()

/atom/movable/screen/alert/shoes
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_icon = /obj/item/clothing/shoes/sneakers::icon
	overlay_state = /obj/item/clothing/shoes/sneakers::icon_state
	clickable_glow = TRUE

/atom/movable/screen/alert/shoes/Click()
	. = ..()
	if(!.)
		return

	var/obj/item/clothing/shoes/shoes = owner.get_item_by_slot(ITEM_SLOT_FEET)
	if(!owner.can_resist() || !istype(shoes, /obj/item/clothing/shoes))
		return

	owner.changeNext_move(CLICK_CD_RESIST)
	shoes.handle_tying(owner)

/atom/movable/screen/alert/shoes/untied
	name = "鞋带松开"
	desc = "你的鞋带松开了！点击此提示或鞋子系好鞋带。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_icon = /obj/item/clothing/shoes/sneakers::icon
	overlay_state = /obj/item/clothing/shoes/sneakers::icon_state

/atom/movable/screen/alert/shoes/knotted
	name = "鞋带打结"
	desc = "有人把你的两根鞋带系在一起了！点击此提示或鞋子解开绳结。"

/atom/movable/screen/alert/unpossess_object
	name = "解除附身"
	desc = "你正在附身于一个物体。点击此提示解除附身。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "buckled"
	clickable_glow = TRUE

/atom/movable/screen/alert/unpossess_object/Click()
	. = ..()
	if(!.)
		return

	qdel(owner.GetComponent(/datum/component/object_possession))

// PRIVATE = only edit, use, or override these if you're editing the system as a whole

/// Gets the placement for the alert based on its index
/datum/hud/proc/get_ui_alert_placement(index)
	// Only has support for 5 slots currently
	if(index > 5)
		return ""

	return "EAST-1:28,CENTER+[6 - index]:[29 - (index * 2)]"

// Re-render all alerts - also called in /datum/hud/show_hud() because it's needed there
/datum/hud/proc/reorganize_alerts(mob/viewmob)
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client)
		return FALSE
	var/list/alerts = mymob.alerts
	if(hud_version != HUD_STYLE_STANDARD)
		for(var/i in 1 to alerts.len)
			screenmob.client.screen -= alerts[alerts[i]]
		return TRUE

	var/user_pref_hud = ui_style2icon(mymob.client?.prefs?.read_preference(/datum/preference/choiced/ui_style))
	for(var/i in 1 to length(alerts))
		var/atom/movable/screen/alert/alert = alerts[alerts[i]]
		switch(alert.use_user_hud_icon)
			if(USER_HUD_STYLE_INHERIT)
				alert.icon = ui_style
			if(USER_HUD_STYLE_PREFS)
				if(user_pref_hud)
					alert.icon = user_pref_hud
		alert.screen_loc = get_ui_alert_placement(i)
		screenmob.client.screen |= alert
	if(!viewmob)
		for(var/viewer in mymob.observers)
			reorganize_alerts(viewer)
	return TRUE
