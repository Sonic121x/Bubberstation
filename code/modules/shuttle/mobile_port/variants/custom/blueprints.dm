/obj/effect/client_image_holder/shuttle_construction_visualization
	image_icon = 'icons/effects/alphacolors.dmi'
	image_state = "transparent"
	image_layer = ABOVE_NORMAL_TURF_LAYER
	image_plane = ABOVE_GAME_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	persist_without_seers = TRUE

/datum/proximity_monitor/advanced/shuttle_construction_visualizer
	edge_is_a_field = TRUE
	var/mob/user
	var/list/image_holders = list()
	var/obj/item/shuttle_blueprints/parent

/datum/proximity_monitor/advanced/shuttle_construction_visualizer/New(atom/_host, range, _ignore_if_not_on_turf)
	. = ..()
	parent = _host

/datum/proximity_monitor/advanced/shuttle_construction_visualizer/Destroy()
	. = ..()
	parent = null
	QDEL_LIST_ASSOC_VAL(image_holders)

/datum/proximity_monitor/advanced/shuttle_construction_visualizer/proc/set_user(mob/new_user)
	if(user)
		for(var/turf in image_holders)
			var/obj/effect/client_image_holder/holder = image_holders[turf]
			holder.remove_seer(user)
		UnregisterSignal(user, list(COMSIG_MOB_LOGIN, COMSIG_MOB_LOGOUT))
		var/client/client = user.client
		if(client)
			UnregisterSignal(client, list(COMSIG_VIEW_SET, COMSIG_CLIENT_SET_EYE))
	if(new_user)
		user = new_user
		for(var/turf in image_holders)
			var/obj/effect/client_image_holder/holder = image_holders[turf]
			holder.add_seer(user)
		RegisterSignal(user, COMSIG_MOB_LOGIN, PROC_REF(on_user_login))
		RegisterSignal(user, COMSIG_MOB_LOGOUT, PROC_REF(unregister_client))
		var/client/client = user.client
		if(client)
			register_client(client)
	else
		unregister_client()

/datum/proximity_monitor/advanced/shuttle_construction_visualizer/proc/register_client(client/client)
	var/atom/eye = client.eye
	if(eye)
		set_host(client.eye)
	var/list/view_size = getviewsize(client.view)
	set_range(CEILING(max(view_size[1], view_size[2])/2, 1)+1)
	RegisterSignal(client, COMSIG_VIEW_SET, PROC_REF(on_view_set))
	RegisterSignal(client, COMSIG_CLIENT_SET_EYE, PROC_REF(on_set_eye))

/datum/proximity_monitor/advanced/shuttle_construction_visualizer/proc/unregister_client()
	SIGNAL_HANDLER
	set_host(parent)
	set_range(0)

/datum/proximity_monitor/advanced/shuttle_construction_visualizer/proc/on_user_login(mob/source)
	SIGNAL_HANDLER
	register_client(source.client)

/datum/proximity_monitor/advanced/shuttle_construction_visualizer/proc/on_view_set(datum/source, new_view)
	SIGNAL_HANDLER
	var/list/view_size = getviewsize(new_view)
	set_range(CEILING(max(view_size[1], view_size[2])/2, 1)+1)

/datum/proximity_monitor/advanced/shuttle_construction_visualizer/proc/on_set_eye(datum/source, atom/old_eye, atom/new_eye)
	SIGNAL_HANDLER
	set_host(new_eye)

/datum/proximity_monitor/advanced/shuttle_construction_visualizer/setup_field_turf(turf/target)
	var/obj/effect/client_image_holder/shuttle_construction_visualization/holder = new(target, list())
	image_holders[target] = holder
	evaluate_turf_overlay(holder, target)
	RegisterSignals(target, list(
		COMSIG_TURF_CHANGE,
		COMSIG_TURF_AREA_CHANGED,
		SIGNAL_ADDTRAIT(TRAIT_SHUTTLE_CONSTRUCTION_TURF),
		SIGNAL_REMOVETRAIT(TRAIT_SHUTTLE_CONSTRUCTION_TURF)
	), PROC_REF(on_turf_updated))
	if(user)
		holder.add_seer(user)

/datum/proximity_monitor/advanced/shuttle_construction_visualizer/cleanup_field_turf(turf/target)
	qdel(image_holders[target])
	image_holders -= target
	UnregisterSignal(target, list(
		COMSIG_TURF_CHANGE,
		COMSIG_TURF_AREA_CHANGED,
		SIGNAL_ADDTRAIT(TRAIT_SHUTTLE_CONSTRUCTION_TURF),
		SIGNAL_REMOVETRAIT(TRAIT_SHUTTLE_CONSTRUCTION_TURF)
	))

/datum/proximity_monitor/advanced/shuttle_construction_visualizer/proc/on_turf_updated(turf/source)
	SIGNAL_HANDLER
	evaluate_turf_overlay(image_holders[source], source)

/datum/proximity_monitor/advanced/shuttle_construction_visualizer/proc/evaluate_turf_overlay(obj/effect/client_image_holder/holder, turf/target)
	var/area/turf_area = target.loc
	if(HAS_TRAIT(target, TRAIT_SHUTTLE_CONSTRUCTION_TURF))
		holder.image_state = "green"
		if(turf_area.allow_shuttle_docking)
			if(!GLOB.custom_areas[turf_area] && turf_area.apc)
				var/obj/machinery/power/apc/apc = turf_area.apc
				var/turf/apc_turf = get_turf(apc)
				if(target == apc_turf)
					holder.image_state = "red"
		else
			holder.image_state = "red"
	else
		holder.image_state = "transparent"
		if(GLOB.custom_areas[turf_area] && HAS_TRAIT(turf_area, TRAIT_HAS_SHUTTLE_CONSTRUCTION_TURF))
			if(turf_area.apc)
				var/obj/machinery/power/apc/apc = turf_area.apc
				var/turf/apc_turf = get_turf(apc)
				if(HAS_TRAIT(apc_turf, TRAIT_SHUTTLE_CONSTRUCTION_TURF))
					holder.image_state = "red"
	holder.regenerate_image()

/obj/item/shuttle_blueprints
	name = "\improper 穿梭机蓝图"
	desc = "一张空白的合成工程级纸张。"
	icon = 'icons/obj/scrolls.dmi'
	icon_state = "shuttle_blueprints0"
	base_icon_state = "shuttle_blueprints"
	inhand_icon_state = "blueprints"
	attack_verb_continuous = list("攻击", "拍打", "敲击")
	attack_verb_simple = list("攻击", "拍", "敲")
	interaction_flags_atom = parent_type::interaction_flags_atom | INTERACT_ATOM_ALLOW_USER_LOCATION | INTERACT_ATOM_IGNORE_MOBILITY
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

	var/base_desc = "一张空白的合成工程级纸张。"
	var/linked_desc = "一张印有穿梭机设计图的合成工程级纸张。"

	//A weakref to the mobile docking port of the shuttle these blueprints are linked to, if any.
	var/datum/weakref/shuttle_ref

	//Whether the holder can visualize shuttle frames (and any turfs preventing them from becoming complete shuttles)
	var/visualize_frame_turfs = FALSE

	var/offset_x = 0
	var/offset_y = 0

	var/datum/proximity_monitor/advanced/shuttle_construction_visualizer/prox_monitor

/obj/item/shuttle_blueprints/Initialize(mapload)
	. = ..()
	prox_monitor = new(src, 0, FALSE)
	update_appearance()

/obj/item/shuttle_blueprints/Destroy(force)
	QDEL_NULL(prox_monitor)
	return ..()

/obj/item/shuttle_blueprints/equipped(mob/user, slot, initial)
	. = ..()
	var/static/list/connections = list(COMSIG_ITEM_PRE_ATTACK = PROC_REF(christen_check))
	if(slot == ITEM_SLOT_HANDS)
		AddComponent(/datum/component/connect_inventory, user, connections, allowed_slots = ITEM_SLOT_HANDS)

/obj/item/shuttle_blueprints/dropped(mob/user, silent)
	. = ..()
	stop_visualizing(user)
	qdel(GetComponent(/datum/component/connect_inventory))

/obj/item/shuttle_blueprints/proc/christen_check(obj/item/reagent_containers/cup/glass/bottle/source, atom/attacked, mob/living/user)
	SIGNAL_HANDLER
	var/obj/docking_port/mobile/custom/shuttle = shuttle_ref?.resolve()
	if(!istype(shuttle))
		return
	if(!iswallturf(attacked))
		return
	if(!istype(source))
		return
	if(SSshuttle.get_containing_shuttle(attacked) != shuttle)
		return
	if(HAS_TRAIT_FROM(user, TRAIT_ATTEMPTING_CHRISTENING, REF(shuttle)))
		return
	. = COMPONENT_CANCEL_ATTACK_CHAIN
	if(shuttle.master_blueprint?.resolve() != src)
		to_chat(user, span_warning("只有 \the [shuttle] 的母版蓝图才赋予你为 [shuttle.p_them()] 重新命名的权利！"))
		return
	var/turf/user_turf = get_turf(user)
	if(user_turf && isshuttleturf(user_turf))
		to_chat(user, span_warning("你不能在 [shuttle.p_them()] 内部为 \the [shuttle] 重新命名！"))
		return
	if(!source.isGlass)
		to_chat(user, span_warning("你不能拿 [source] 去砸 [attacked]！"))
		return
	if(source.reagents.total_volume < CHEMICAL_QUANTISATION_LEVEL)
		to_chat(user, span_warning("你应该往 [source] 里装些命名用的液体！"))
		return
	INVOKE_ASYNC(src, PROC_REF(christen), user, shuttle, attacked, user.active_hand_index)

/obj/item/shuttle_blueprints/proc/christen(mob/living/user, obj/docking_port/mobile/custom/shuttle, atom/attacked, hand)
	var/trait_source = REF(shuttle)
	ADD_TRAIT(user, TRAIT_ATTEMPTING_CHRISTENING, trait_source)
	var/new_name = reject_bad_name(tgui_input_text(user, "你想把 \the [shuttle] 重新命名为什么？", "穿梭机重新命名", max_length = 128), allow_numbers = TRUE, strict = TRUE, cap_after_symbols = FALSE)
	if(QDELETED(user))
		return
	REMOVE_TRAIT(user, TRAIT_ATTEMPTING_CHRISTENING, trait_source)
	if(!new_name)
		user.balloon_alert(user, "已取消")
		return
	new_name = apply_text_macros(new_name)
	var/obj/item/hitting_implement = (locate(/obj/item/reagent_containers/cup/glass/bottle) in user.held_items) || user.get_item_for_held_index(hand)
	if(!attacked.IsReachableBy(user, hitting_implement.reach))
		user.balloon_alert(user, "超出范围！")
		return
	var/obj/item/reagent_containers/cup/glass/bottle/bottle = hitting_implement
	bottle = istype(bottle) && bottle.isGlass && bottle
	var/shuttle_exists = !QDELETED(shuttle)
	if(!shuttle_exists)
		to_chat(user, span_warning("这里原本不是应该有一艘穿梭机吗？"))
	var/has_blueprints = !QDELETED(src) && (src in user.gather_belongings())
	var/turf/attacked_turf = attacked
	var/is_closed_turf = isclosedturf(attacked_turf)
	var/is_shuttle_turf = isshuttleturf(attacked_turf)
	var/off_shuttle = SSshuttle.get_containing_shuttle(get_turf(user)) != shuttle
	var/has_bottle = istype(bottle)
	var/bottle_empty = bottle && bottle.reagents.total_volume < CHEMICAL_QUANTISATION_LEVEL
	var/is_clumsy = HAS_TRAIT(user, TRAIT_CLUMSY)
	var/clumsy_check = is_clumsy && prob(25)
	if(!(has_blueprints && is_closed_turf && is_shuttle_turf && off_shuttle && has_bottle && !clumsy_check && !bottle_empty))
		var/msg = "[user] 想用 [hitting_implement ? "[hitting_implement.get_examine_name()]" : "[user.p_their()]空拳"] 为穿梭机命名"
		var/self_msg = "你想用 [hitting_implement ? "[hitting_implement.get_examine_name()]" : "你的空拳"] 为穿梭机命名"
		if(!is_closed_turf || clumsy_check)
			msg += "，却失了准头，反倒砸在了[user.p_themselves()]身上"
			self_msg += "，却失了准头，反倒砸在了自己身上"
			msg += "！"
			self_msg += "！"
			if(is_clumsy)
				msg += " 真是个笨手笨脚的家伙！"
			var/old_combat_mode = user.combat_mode
			user.set_combat_mode(TRUE)
			// Stupid code to bypass pacifism checks, since unintentional hits like this one shouldn't be blocked by pacifism
			var/list/pacifism_sources = GET_TRAIT_SOURCES(user, TRAIT_PACIFISM)
			REMOVE_TRAIT(user, TRAIT_PACIFISM, pacifism_sources)
			if(hitting_implement)
				hitting_implement.attack(user, user)
				bottle?.smash(user, user) // Because smashing a bottle isn't part of its main melee attack chain
			else
				user.resolve_unarmed_attack(user)
			if(length(pacifism_sources))
				ADD_TRAIT(user, TRAIT_PACIFISM, pacifism_sources)
			user.set_combat_mode(old_combat_mode)
		else
			if(!shuttle_exists)
				msg += "，可惜这里根本没有穿梭机可供命名！"
				self_msg += "，可惜这里根本没有穿梭机可供命名！"
			else if(!off_shuttle)
				msg += "，不过这种事得在 [shuttle.p_them()] 的<i>外面</i>做！"
				self_msg += "，不过这种事得在 [shuttle.p_them()] 的<i>外面</i>做！"
			else if(!is_shuttle_turf)
				msg += "，却失了准头，反倒打在了 [attacked] 上！"
				self_msg += "，却失了准头，反倒打在了 [attacked] 上！"
			else if(!has_bottle)
				if(hitting_implement)
					msg += "——可这东西根本不是玻璃瓶！"
					self_msg += "——可这东西根本不是玻璃瓶！"
				else
					msg += "！这可不是该有的做法！"
					self_msg += "！不是该用玻璃瓶的吗？"
			else if(bottle_empty)
				msg += "，可是 [bottle] 里没有命名用的液体！"
				self_msg += "，可是 [bottle] 里没有命名用的液体！"
			else if(!has_blueprints)
				msg += "，但[user]并没有这个权利！"
				self_msg += "，但你并没有这个权利！"
			user.do_attack_animation(attacked, used_item = hitting_implement)
			if(hitting_implement && !bottle)
				if(hitting_implement.force)
					playsound(hitting_implement, 'sound/items/weapons/smash.ogg', hitting_implement.get_clamped_volume(), TRUE, hitting_implement.stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)
				else
					playsound(hitting_implement, 'sound/items/weapons/tap.ogg', hitting_implement.get_clamped_volume(), TRUE, -1)
			else if(bottle)
				bottle.smash(attacked, user)
			else
				playsound(user, 'sound/effects/bang.ogg', 50, TRUE)
		user.visible_message(span_warning(msg), span_warning(self_msg))
	else
		user.visible_message(
			span_notice("[user] 用 [hitting_implement.get_examine_name()] 把穿梭机命名为 <b>\the [new_name]</b>\
			[(bottle.reagents.total_volume < 30) ? "" : "，只是命名液体实在太少，场面算不上气派"]。"),
			span_notice("你用 [hitting_implement.get_examine_name()] 把穿梭机命名为 <b>\the [new_name]</b>。")
		)
		user.do_attack_animation(attacked, used_item = bottle)
		bottle.smash(attacked, user)
		shuttle.name = new_name
		rename_area(shuttle.default_area, new_name)

/obj/item/shuttle_blueprints/proc/start_visualizing(mob/user)
	visualize_frame_turfs = TRUE
	RegisterSignal(user, SIGNAL_ADDTRAIT(TRAIT_USER_SCOPED), PROC_REF(stop_visualizing))
	prox_monitor.set_user(user)
	prox_monitor.recalculate_field()

/obj/item/shuttle_blueprints/proc/stop_visualizing(mob/user)
	SIGNAL_HANDLER
	visualize_frame_turfs = FALSE
	UnregisterSignal(user, SIGNAL_ADDTRAIT(TRAIT_USER_SCOPED))
	prox_monitor.set_user(null)

/obj/item/shuttle_blueprints/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ShuttleBlueprints", name)
		ui.open()
		RegisterSignal(user, COMSIG_ENTER_AREA, PROC_REF(on_user_enter_area))

/obj/item/shuttle_blueprints/ui_close(mob/user)
	. = ..()
	UnregisterSignal(user, COMSIG_ENTER_AREA)

/obj/item/shuttle_blueprints/proc/on_user_enter_area(mob/source, area/new_area)
	var/obj/docking_port/mobile/custom/shuttle = shuttle_ref?.resolve()
	if(shuttle && shuttle.default_area == new_area)
		update_static_data(source)

/obj/item/shuttle_blueprints/ui_state(mob/user)
	return GLOB.hands_state

/obj/item/shuttle_blueprints/ui_static_data(mob/user)
	var/list/data = list()
	var/obj/docking_port/mobile/custom/shuttle = shuttle_ref?.resolve()
	if(get_area(user) == shuttle?.default_area && length(shuttle?.shuttle_areas) > 1)
		var/list/neighboring_areas = list()
		var/room_turfs = detect_room(get_turf(user), max_size = CONFIG_GET(number/max_shuttle_size), extra_check = CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(custom_shuttle_room_check), shuttle, neighboring_areas))
		if(room_turfs)
			data["apcInMergeRegion"] = shuttle.default_area.apc && room_turfs[get_turf(shuttle.default_area.apc)]
			var/list/area_refs = list()
			for(var/area/neighboring_area in neighboring_areas)
				area_refs[REF(neighboring_area)] = neighboring_area.name
			data["neighboringAreas"] = area_refs
	return data

/obj/item/shuttle_blueprints/ui_data(mob/user)
	var/data = list()
	var/turf/current_turf = get_turf(user)
	var/obj/docking_port/mobile/custom/linked_shuttle = shuttle_ref?.resolve()
	var/linked_to_shuttle = istype(linked_shuttle)
	var/on_shuttle_frame = HAS_TRAIT(current_turf, TRAIT_SHUTTLE_CONSTRUCTION_TURF)
	var/datum/shuttle_frame/frame = GLOB.shuttle_frames_by_turf[current_turf]
	data["linkedShuttle"] = linked_to_shuttle && shuttle_ref.reference
	data["visualizing"] = visualize_frame_turfs
	data["onShuttleFrame"] = on_shuttle_frame
	if(on_shuttle_frame)
		data["maxShuttleSize"] = CONFIG_GET(number/max_shuttle_size)
	if(!linked_to_shuttle)
		var/obj/docking_port/mobile/custom/loc_shuttle = SSshuttle.get_containing_shuttle(current_turf)
		data["tooManyShuttles"] = length(SSshuttle.custom_shuttles) >= CONFIG_GET(number/max_shuttle_count)
		var/on_custom_shuttle = istype(loc_shuttle)
		data["onCustomShuttle"] = on_custom_shuttle
		if(on_custom_shuttle)
			data["masterExists"] = loc_shuttle?.master_blueprint?.resolve()
		else if(on_shuttle_frame)
			data["size"] = length(frame.turfs) - length(frame.shuttle_covered_turfs)
			data["problems"] = shuttle_build_check(current_turf)
	else
		var/obj/item/shuttle_blueprints/master = linked_shuttle.master_blueprint?.resolve()
		data["masterExists"] = master
		data["isMaster"] = master == src
		var/area/current_area = get_area(current_turf)
		var/area/default_area = linked_shuttle.default_area
		data["onShuttle"] = linked_shuttle.shuttle_areas[current_area]
		data["inDefaultArea"] = default_area == current_area
		data["currentArea"] = list(name = current_area.name, ref = REF(current_area))
		data["defaultApc"] = !!default_area.apc
		var/list/apcs = list()
		for(var/area/area as anything in linked_shuttle.shuttle_areas - default_area)
			apcs[REF(area)] = !!area.apc
		data["apcs"] = apcs
		data["idle"] = linked_shuttle.mode == SHUTTLE_IDLE
		if(on_shuttle_frame)
			data["size"] = length(frame.turfs) - length(frame.shuttle_covered_turfs) + linked_shuttle.turf_count
			data["problems"] = shuttle_expand_check(current_turf, linked_shuttle)
	return data

/obj/item/shuttle_blueprints/proc/link_to_shuttle(obj/docking_port/mobile/custom/shuttle, is_master = FALSE)
	shuttle_ref = WEAKREF(shuttle)
	if(is_master)
		shuttle.master_blueprint = WEAKREF(src)
	RegisterSignal(shuttle, COMSIG_QDELETING, PROC_REF(on_shuttle_deleted))
	update_appearance()

/obj/item/shuttle_blueprints/proc/on_shuttle_deleted()
	SIGNAL_HANDLER
	unlink(removing = TRUE)

/obj/item/shuttle_blueprints/proc/unlink(removing = FALSE)
	var/obj/docking_port/mobile/custom/shuttle = shuttle_ref.resolve()
	if(!QDELETED(shuttle))
		UnregisterSignal(shuttle, COMSIG_QDELETING)
	shuttle_ref = null
	update_appearance()

/obj/item/shuttle_blueprints/update_name(updates)
	. = ..()
	var/obj/docking_port/mobile/shuttle = shuttle_ref?.resolve()
	if(shuttle)
		name = get_linked_name(shuttle)
	else
		name = initial(name)

/obj/item/shuttle_blueprints/proc/get_linked_name(obj/docking_port/mobile/shuttle)
	return "\improper [shuttle.name]蓝图"

/obj/item/shuttle_blueprints/update_desc(updates)
	. = ..()
	desc = shuttle_ref?.resolve() ? linked_desc : base_desc

/obj/item/shuttle_blueprints/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][!!shuttle_ref]"

/obj/item/shuttle_blueprints/vv_edit_var(vname, vval)
	. = ..()
	if(!.)
		return
	if(vname == NAMEOF(src, desc))
		if(shuttle_ref?.resolve())
			linked_desc = vval
		else
			base_desc = vval
		update_desc()

/obj/item/shuttle_blueprints/examine(mob/user)
	. = ..()
	. += get_shuttle_tip()

/obj/item/shuttle_blueprints/proc/get_shuttle_tip()
	. = list()
	if(!shuttle_ref)
		. += span_notice("可用于建造自定义穿梭机。")
		return
	var/obj/docking_port/mobile/custom/shuttle = shuttle_ref.resolve()
	if(!shuttle)
		. += span_notice("上面留有某艘已不存在穿梭机的设计图，可再次用于建造新的穿梭机。")
	else
		. += span_notice("上面绘有 \the [shuttle] 的设计图，可用于扩建 [shuttle.p_them()] 或改造 [shuttle.p_their()] 的区域。")
		if(shuttle.master_blueprint.resolve() == src)
			. += span_notice("这是 \the [shuttle] 的母版蓝图。你可以把它复制到空白蓝图上，或复制给安装了穿梭机数据库模块的工程半机械人。")

/obj/item/shuttle_blueprints/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	var/obj/docking_port/mobile/custom/shuttle = shuttle_ref?.resolve()
	if(!istype(shuttle))
		return
	if(shuttle.master_blueprint?.resolve() != src)
		return
	if(istype(interacting_with, /obj/item/shuttle_blueprints))
		var/obj/item/shuttle_blueprints/other_blueprints = interacting_with
		var/obj/docking_port/mobile/other_shuttle = other_blueprints.shuttle_ref?.resolve()
		if(istype(other_shuttle))
			return
		balloon_alert(user, "正在复制蓝图……")
		if(!do_after(user, 5 SECONDS, other_blueprints))
			balloon_alert(user, "已中断！")
			return ITEM_INTERACT_FAILURE
		other_blueprints.link_to_shuttle(shuttle)
		balloon_alert(user, "已复制")
		return ITEM_INTERACT_SUCCESS
	if(istype(interacting_with, /mob/living/silicon/robot))
		var/mob/living/silicon/robot/borg = interacting_with
		var/obj/item/shuttle_blueprints/borg/other_blueprints = (locate() in borg.model.modules) || (locate() in borg.held_items)
		if(!other_blueprints)
			return
		if(other_blueprints.shuttles.Find(shuttle_ref))
			balloon_alert(user, "已经拥有这些蓝图！")
		balloon_alert(user, "正在复制蓝图……")
		if(!do_after(user, 5 SECONDS, borg))
			balloon_alert(user, "已中断")
			return ITEM_INTERACT_FAILURE
		if(QDELETED(other_blueprints))
			return ITEM_INTERACT_FAILURE
		other_blueprints.shuttles |= shuttle_ref
		balloon_alert(user, "已复制")
		return ITEM_INTERACT_SUCCESS

/obj/item/shuttle_blueprints/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("toggleVisualization")
			if(visualize_frame_turfs)
				stop_visualizing(usr)
			else
				start_visualizing(usr)
			return TRUE
		if("tryBuildShuttle")
			var/shuttle_dir = params["dir"]
			if(!(shuttle_dir in GLOB.cardinals))
				return TRUE
			var/list/shuttle_turfs = list()
			var/list/shuttle_areas = list()
			var/turf/shuttle_origin = get_turf(usr)
			var/check_status = shuttle_build_check(shuttle_origin, shuttle_turfs, shuttle_areas)
			if(check_status & ORIGIN_NOT_ON_SHUTTLE)
				balloon_alert(usr, "不在穿梭机框架上！")
				return TRUE
			if(check_status & TOO_MANY_SHUTTLES)
				balloon_alert(usr, "穿梭机数量已达上限！")
				return TRUE
			if(check_status & ABOVE_MAX_SHUTTLE_SIZE)
				balloon_alert(usr, "框架过大！")
				return TRUE
			if(check_status & CUSTOM_AREA_NOT_COMPLETELY_CONTAINED)
				balloon_alert(usr, "框架必须完全包围自定义区域！")
				return TRUE
			if(check_status & INTERSECTS_NON_WHITELISTED_AREA)
				balloon_alert(usr, "框架与不允许的区域重叠！")
				return TRUE
			if(check_status & CONTAINS_APC_OF_NON_CUSTOM_AREA)
				balloon_alert(usr, "框架内含有非自定义区域的 APC！")
				return TRUE
			var/obj/docking_port/mobile/custom/shuttle = create_shuttle(
				usr,
				shuttle_origin,
				shuttle_turfs,
				shuttle_areas,
				shuttle_dir,
				name = "\improper 未命名穿梭机",
				id = "custom_[length(SSshuttle.custom_shuttles)+1]"
			)
			link_to_shuttle(shuttle, TRUE)
			return TRUE
		if("tryLinkShuttle")
			if(shuttle_ref?.resolve())
				balloon_alert(usr, "已链接！")
				return TRUE
			var/obj/docking_port/mobile/custom/shuttle = SSshuttle.get_containing_shuttle(usr)
			if(!shuttle)
				balloon_alert(usr, "不在穿梭机上！")
				return TRUE
			if(!istype(shuttle))
				balloon_alert(usr, "穿梭机类型不兼容！")
				return TRUE
			var/obj/item/shuttle_blueprints/master = shuttle.master_blueprint?.resolve()
			if(master && (master != src))
				balloon_alert(usr, "母版蓝图已存在！")
				return TRUE
			link_to_shuttle(shuttle, TRUE)
			return TRUE
		if("promoteToMaster")
			var/obj/docking_port/mobile/custom/shuttle = shuttle_ref?.resolve()
			if(!shuttle)
				balloon_alert(usr, "未链接！")
				return TRUE
			var/obj/item/shuttle_blueprints/master = shuttle.master_blueprint?.resolve()
			if(master)
				balloon_alert(usr, "母版蓝图已存在！")
				return TRUE
			shuttle.master_blueprint = WEAKREF(src)
			return TRUE
		if("createNewArea")
			var/obj/docking_port/mobile/custom/shuttle = shuttle_ref?.resolve()
			if(!shuttle)
				balloon_alert(usr, "未链接！")
				return TRUE
			var/area_name = params["name"]
			if(!area_name)
				balloon_alert(usr, "未提供名称！")
				return TRUE
			var/area/current_area = get_area(usr)
			var/area/default_area = shuttle.default_area
			if(current_area != default_area)
				balloon_alert(usr, "必须位于默认区域内！")
				return TRUE
			var/list/turfs = detect_room(get_turf(usr), max_size = CONFIG_GET(number/max_shuttle_size), extra_check = CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(custom_shuttle_room_check), shuttle, null))
			if(!length(turfs))
				balloon_alert(usr, "无效房间！")
				return TRUE
			var/area/shuttle/custom/new_area = new()
			new_area.name = area_name
			shuttle.shuttle_areas[new_area] = TRUE
			set_turfs_to_area(turfs, new_area)
			new_area.reg_in_areas_in_z()
			new_area.create_area_lighting_objects()
			for(var/obj/machinery/door/firedoor/firelock as anything in default_area.firedoors)
				firelock.CalculateAffectingAreas()
			new_area.power_change()
			return TRUE
		if("releaseArea")
			var/obj/docking_port/mobile/custom/shuttle = shuttle_ref?.resolve()
			if(!shuttle)
				balloon_alert(usr, "未链接！")
				return TRUE
			var/area/current_area = get_area(usr)
			if(!shuttle.shuttle_areas[current_area])
				balloon_alert(usr, "不在穿梭机上！")
				return TRUE
			var/area/default_area = shuttle.default_area
			if(current_area == default_area)
				balloon_alert(usr, "无法释放默认区域！")
				return TRUE
			var/obj/machinery/power/apc/current_area_apc = current_area.apc
			var/obj/machinery/power/apc/default_area_apc = default_area.apc
			if(current_area_apc && default_area_apc)
				balloon_alert(usr, "请先移除 APC！")
				return TRUE
			var/list/turfs = current_area.get_turfs_by_zlevel(shuttle.z)
			set_turfs_to_area(turfs, default_area)
			for(var/obj/machinery/door/firedoor/firelock as anything in default_area.firedoors)
				firelock.CalculateAffectingAreas()
			shuttle.shuttle_areas -= current_area
			qdel(current_area)
			return TRUE
		if("mergeIntoArea")
			var/obj/docking_port/mobile/custom/shuttle = shuttle_ref?.resolve()
			if(!shuttle)
				balloon_alert(usr, "未链接！")
				return TRUE
			var/area/current_area = get_area(usr)
			var/area/default_area = shuttle.default_area
			if(current_area != default_area)
				balloon_alert(usr, "必须位于默认区域内！")
				return TRUE
			var/area/merge_area = locate(params["area"])
			if(!istype(merge_area))
				return TRUE
			if(!shuttle.shuttle_areas[merge_area])
				return TRUE
			if(merge_area == default_area)
				return TRUE
			var/list/actual_adjacent_areas = list()
			var/list/turfs = detect_room(get_turf(usr), max_size = CONFIG_GET(number/max_shuttle_size), extra_check = CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(custom_shuttle_room_check), shuttle, actual_adjacent_areas))
			if(!length(turfs))
				balloon_alert(usr, "无效房间！")
				return TRUE
			if(!actual_adjacent_areas[merge_area])
				balloon_alert(usr, "所选区域未与房间相连！")
				return TRUE
			if(merge_area.apc && default_area.apc && turfs[get_turf(default_area.apc)])
				balloon_alert(usr, "请先移除 APC！")
				return TRUE
			set_turfs_to_area(turfs, merge_area)
			for(var/obj/machinery/door/firedoor/firelock as anything in merge_area.firedoors + default_area.firedoors)
				firelock.CalculateAffectingAreas()
			return TRUE
		if("renameArea")
			var/obj/docking_port/mobile/custom/shuttle = shuttle_ref?.resolve()
			if(!shuttle)
				balloon_alert(usr, "未链接！")
				return TRUE
			var/area/current_area = get_area(usr)
			if(!shuttle.shuttle_areas[current_area])
				balloon_alert(usr, "不在穿梭机上！")
				return TRUE
			var/area/default_area = shuttle.default_area
			if(current_area == default_area)
				balloon_alert(usr, "无法重命名默认区域！")
				return TRUE
			var/new_name = params["name"]
			if(!new_name)
				balloon_alert(usr, "未提供名称！")
				return TRUE
			rename_area(current_area, new_name)
			return TRUE
		if("expandWithFrame")
			var/obj/docking_port/mobile/custom/shuttle = shuttle_ref?.resolve()
			if(!shuttle)
				balloon_alert(usr, "未链接！")
				return TRUE
			var/list/turfs = list()
			var/list/areas = list()
			var/turf/origin = get_turf(usr)
			var/check_status = shuttle_expand_check(origin, shuttle, turfs, areas)
			if(check_status & ORIGIN_NOT_ON_SHUTTLE)
				balloon_alert(usr, "不在穿梭机框架上！")
				return TRUE
			if(check_status & FRAME_NOT_ADJACENT_TO_LINKED_SHUTTLE)
				balloon_alert(usr, "未与已链接的穿梭机相连！")
				return TRUE
			if(check_status & ABOVE_MAX_SHUTTLE_SIZE)
				balloon_alert(usr, "框架过大！")
				return TRUE
			if(check_status & CUSTOM_AREA_NOT_COMPLETELY_CONTAINED)
				balloon_alert(usr, "框架必须完全包围自定义区域！")
				return TRUE
			if(check_status & INTERSECTS_NON_WHITELISTED_AREA)
				balloon_alert(usr, "框架与不允许的区域重叠！")
				return TRUE
			if(check_status & CONTAINS_APC_OF_NON_CUSTOM_AREA)
				balloon_alert(usr, "框架内含有非自定义区域的 APC！")
				return TRUE
			expand_shuttle(usr, shuttle, turfs, areas)
			return TRUE
		if("cleanupEmptyTurfs")
			var/obj/docking_port/mobile/custom/shuttle = shuttle_ref?.resolve()
			if(!shuttle)
				balloon_alert(usr, "未链接！")
				return TRUE
			var/obj/item/shuttle_blueprints/master = shuttle.master_blueprint?.resolve()
			if(master && master != src)
				balloon_alert(usr, "不是母版蓝图！")
			clear_empty_shuttle_turfs(shuttle)

/obj/item/shuttle_blueprints/crude
	name = "\improper 粗糙的穿梭机蓝图"
	desc = "这只是一张纸，上面涂满了说不清是蜡笔还是喷漆的东西。"
	icon_state = "shuttle_blueprints_crude0"
	base_icon_state = "shuttle_blueprints_crude"
	base_desc = "这只是一张纸，上面涂满了说不清是蜡笔还是喷漆的东西。"
	linked_desc = "这只是一张在说不清是蜡笔还是喷漆的涂鸦背景上画出的粗糙穿梭机简笔画。"
	custom_materials = list(/datum/material/paper = HALF_SHEET_MATERIAL_AMOUNT / 2)

/obj/item/shuttle_blueprints/borg
	name = "\improper 穿梭机蓝图数据库"
	desc = "一种用于存储一艘或多艘穿梭机设计图的模块。"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "shuttle_database0"
	base_icon_state = "shuttle_database"
	damtype = BURN // In case fantasy affixes or adminbus end up making this actually capable of hurting someone.
	attack_verb_continuous = list("攻击", "扫描", "分析")
	attack_verb_simple = list("攻击", "扫描", "分析")
	base_desc = "一种用于存储一艘或多艘穿梭机设计图的模块。"
	linked_desc = "一种用于存储一艘或多艘穿梭机设计图的模块。"
	var/list/shuttles = list()

/obj/item/shuttle_blueprints/borg/get_shuttle_tip()
	. = list()
	if(!shuttle_ref)
		if(!length(shuttles))
			. += span_notice("其中未存储任何穿梭机设计图。")
		else
			. += span_notice("当前未载入任何穿梭机设计图。")
		. += span_notice("在此模式下，可用于建造自定义穿梭机。")
		return
	var/obj/docking_port/mobile/custom/shuttle = shuttle_ref.resolve()
	if(!shuttle)
		. += span_notice("当前载入的设计图属于一艘已不存在的穿梭机，将默认进入穿梭机建造模式。")
	else
		. += span_notice("当前载入的是 \the [shuttle] 的设计图，可用于扩建 [shuttle.p_them()] 或改造 [shuttle.p_their()] 的区域。")
		if(shuttle.master_blueprint.resolve() == src)
			. += span_notice("这是 \the [shuttle] 的母版蓝图。你可以把它复制到空白蓝图上，或复制给另一台安装了穿梭机数据库模块的工程半机械人。")

/obj/item/shuttle_blueprints/borg/unlink(removing)
	if(removing)
		shuttles -= shuttle_ref
	..()

/obj/item/shuttle_blueprints/borg/ui_data(mob/user)
	var/list/data = ..()
	var/list/shuttle_data = list()
	var/list/shuttle_name_count = list()
	for(var/datum/weakref/shuttle_weakref as anything in shuttles)
		var/obj/docking_port/mobile/shuttle = shuttle_weakref.resolve()
		if(!shuttle)
			continue
		var/shuttle_name = shuttle.name
		if(!shuttle_name_count[shuttle_name])
			shuttle_name_count[shuttle_name] = 0
		var/ref = shuttle_weakref.reference
		shuttle_data[ref] = shuttle_name
		if(shuttle_name_count[shuttle_name]++ > 1)
			shuttle_data[ref] += " ([shuttle_name_count[shuttle_name]])"
	if(length(shuttle_data))
		data["shuttles"] = shuttle_data
	return data

/obj/item/shuttle_blueprints/borg/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("switchShuttle")
			var/ref = params["ref"]
			var/obj/docking_port/mobile/shuttle = locate(ref)
			if(!shuttle)
				return TRUE
			if(shuttles.Find(WEAKREF(shuttle)))
				link_to_shuttle(shuttle)
			return TRUE
		if("unsetShuttle")
			unlink()
			return TRUE

/obj/item/shuttle_blueprints/borg/link_to_shuttle(obj/docking_port/mobile/custom/shuttle, is_master)
	. = ..()
	shuttles |= WEAKREF(shuttle)

/obj/item/shuttle_blueprints/borg/get_linked_name(obj/docking_port/mobile/shuttle)
	name = "穿梭机蓝图数据库（[shuttle.name]）"
