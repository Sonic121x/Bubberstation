#define BASE_DISCONNECT_DAMAGE 40
#define SCANNING_TOGGLE_COOLDOWN 5

/obj/machinery/netpod
	name = "网络舱"

	base_icon_state = "netpod"
	circuit = /obj/item/circuitboard/machine/netpod
	desc = "通往网络宇宙的链接。它配有一整套线缆，可将你自己接入一个虚拟领域。"
	icon = 'icons/obj/machines/bitrunning.dmi'
	icon_state = "netpod"
	max_integrity = 300
	obj_flags = BLOCKS_CONSTRUCTION
	state_open = TRUE
	interaction_flags_mouse_drop = NEED_HANDS | NEED_DEXTERITY

	/// Whether we have an ongoing connection
	var/connected = FALSE
	/// A player selected outfit by clicking the netpod
	var/datum/outfit/netsuit = /datum/outfit/job/bitrunner
	/// Holds this to see if it needs to generate a new one
	var/datum/weakref/avatar_ref
	/// The linked quantum server
	var/datum/weakref/server_ref
	/// The amount of brain damage done from force disconnects
	var/disconnect_damage
	/// Static list of outfits to select from
	var/list/cached_outfits = list()
	/// Whether bit avatars become visually similar to their bitrunner on first creation
	var/copy_body = FALSE
	/// The next time copy_body can be toggled
	var/scanning_can_toggle = 0


/obj/machinery/netpod/post_machine_initialize()
	. = ..()

	disconnect_damage = BASE_DISCONNECT_DAMAGE
	find_server()

	RegisterSignal(src, COMSIG_ATOM_TAKE_DAMAGE, PROC_REF(on_damage_taken))
	RegisterSignal(src, COMSIG_MACHINERY_POWER_LOST, PROC_REF(on_power_loss))
	RegisterSignals(src, list(COMSIG_QDELETING,	COMSIG_MACHINERY_BROKEN),PROC_REF(on_broken))

	register_context()
	update_appearance()


/obj/machinery/netpod/Destroy()
	. = ..()

	QDEL_LIST(cached_outfits)


/obj/machinery/netpod/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "选择服装"
	else
		if(held_item.tool_behaviour == TOOL_SCREWDRIVER && !occupant && !state_open)
			context[SCREENTIP_CONTEXT_LMB] = "[panel_open ? "关闭" : "打开"]面板"

		if(held_item.tool_behaviour == TOOL_CROWBAR)
			if(isnull(occupant))
				if(panel_open)
					context[SCREENTIP_CONTEXT_LMB] = "拆解"
				else
					context[SCREENTIP_CONTEXT_LMB] = "[state_open ? "关闭" : "打开"]盖板"
			else
				context[SCREENTIP_CONTEXT_LMB] = "挣脱"

	context[SCREENTIP_CONTEXT_ALT_LMB] = "[copy_body ? "禁用" : "启用"]扫描"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/netpod/examine(mob/user)
	. = ..()

	. += span_notice("它的维护面板可以[EXAMINE_HINT("用螺丝刀")][panel_open ? "关闭" : "打开"]。")
	if(isnull(occupant))
		if(panel_open)
			. += span_notice("它可以用[EXAMINE_HINT("撬棍")]撬开。")
		else
			. += span_notice("它的舱盖可以[EXAMINE_HINT("用撬棍")][state_open ? "关闭" : "打开"]。")

	if(isnull(server_ref?.resolve()))
		. += span_infoplain("它没有连接到任何东西。")
		. += span_infoplain("网络舱必须建在服务器 4 格范围内。")
		return

	if(!isobserver(user))
		. += span_infoplain("把自己拖入舱内即可建立链接。")
		. += span_infoplain("它具有有限的复苏能力。待在舱内可以治愈部分伤势。")
		. += span_infoplain("它配有安全系统，一旦被动手脚就会警告舱内的人员。")
		if(copy_body)
			. += span_infoplain("乘员扫描当前已启用，这会让比特化身在首次创建时长得像乘员。")
		. += span_infoplain("按住 Alt 点击以[copy_body ? "禁用" : "启用"]乘员扫描。")

	if(isnull(occupant))
		. += span_infoplain("它当前无人使用。")
		return

	. += span_infoplain("它当前由 [occupant] 使用。")

	if(isobserver(user))
		. += span_notice("作为观察者，你可以点击这个网络舱，跳转到它的化身处。")
		return

	. += span_notice("它可以用撬棍撬开，但它的安全机制会警告舱内的人员。")


/obj/machinery/netpod/update_icon_state()
	if(!is_operational)
		icon_state = base_icon_state
		return ..()

	if(state_open)
		icon_state = base_icon_state + "_open_active"
		return ..()

	if(panel_open)
		icon_state = base_icon_state + "_panel"
		return ..()

	icon_state = base_icon_state + "_closed"
	if(occupant)
		icon_state += "_active"

	return ..()


/obj/machinery/netpod/mouse_drop_receive(mob/target, mob/user, params)
	var/mob/living/carbon/player = user

	if(!iscarbon(player) || !is_operational || !state_open || player.buckled)
		return

	close_machine(target)


/obj/machinery/netpod/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!state_open && user == occupant)
		container_resist_act(user)


/obj/machinery/netpod/attack_ghost(mob/dead/observer/our_observer)
	var/our_target = avatar_ref?.resolve()
	if(isnull(our_target) || !our_observer.orbit(our_target))
		return ..()


/// When the server is upgraded, drops brain damage a little
/obj/machinery/netpod/proc/on_server_upgraded(obj/machinery/quantum_server/source)
	SIGNAL_HANDLER

	disconnect_damage = BASE_DISCONNECT_DAMAGE * (1 - source.servo_bonus)

/obj/machinery/netpod/click_alt(mob/user)
	if(world.time < scanning_can_toggle)
		return CLICK_ACTION_BLOCKING
	copy_body = !copy_body
	scanning_can_toggle = world.time + SCANNING_TOGGLE_COOLDOWN
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	user.balloon_alert_to_viewers(user, "扫描已[copy_body ? "启用" : "禁用"]")
	return CLICK_ACTION_SUCCESS

#undef BASE_DISCONNECT_DAMAGE
#undef SCANNING_TOGGLE_COOLDOWN
