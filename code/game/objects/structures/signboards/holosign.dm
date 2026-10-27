/obj/structure/signboard/holosign
	name = "全息牌子"
	desc = "一块全息牌子，会在其上方投射文字。"
	icon_state = "holographic_sign"
	base_icon_state = "holographic_sign"
	layer = ABOVE_MOB_LAYER
	density = FALSE
	edit_by_hand = TRUE
	show_while_unanchored = TRUE
	light_range = MINIMUM_USEFUL_LIGHT_RANGE
	light_power = 0.3
	light_color = COLOR_CARP_TEAL
	light_on = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5.15, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	/// If set, only IDs with this name can (un)lock the sign.
	var/registered_owner
	/// The current color of the sign.
	/// The sign will be greyscale if this is set.
	var/current_color

/obj/structure/signboard/holosign/Initialize(mapload)
	. = ..()
	if(current_color)
		INVOKE_ASYNC(src, PROC_REF(set_color), current_color)
	AddComponent(/datum/component/usb_port, list(
		/obj/item/circuit_component/holo_signboard,
	))

/obj/structure/signboard/holosign/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	var/locked = is_locked(user)
	if(istype(held_item, /obj/item/card/emag))
		context[SCREENTIP_CONTEXT_LMB] = "烧毁锁定机构"
		. = CONTEXTUAL_SCREENTIP_SET
	else if(!locked && istype(held_item?.GetID(), /obj/item/usb_cable))
		context[SCREENTIP_CONTEXT_LMB] = "连接 USB 线缆"
	else if(!locked && istype(held_item?.GetID(), /obj/item/card/id))
		context[SCREENTIP_CONTEXT_LMB] = registered_owner ? "移除 ID 锁定" : "锁定至 ID"
		. = CONTEXTUAL_SCREENTIP_SET
	if(!locked)
		context[SCREENTIP_CONTEXT_RMB] = "设置牌子颜色"
		. = CONTEXTUAL_SCREENTIP_SET

/obj/structure/signboard/holosign/update_icon_state()
	base_icon_state = current_color ? "[initial(base_icon_state)]_greyscale" : initial(base_icon_state)
	. = ..()
	if(obj_flags & EMAGGED)
		icon_state += "_emag"

/obj/structure/signboard/holosign/examine(mob/user)
	. = ..()
	if(obj_flags & EMAGGED)
		. += span_warning("<br>它的锁定机构似乎已被烧毁！")
	else if(registered_owner)
		. += span_info("<br>它已锁定至 [span_name(registered_owner)] 的 ID。")

/obj/structure/signboard/holosign/update_overlays()
	. = ..()
	if(sign_text)
		. += emissive_appearance(icon, "holographic_sign_e", src)

/obj/structure/signboard/holosign/vv_edit_var(var_name, var_value)
	if(var_name == NAMEOF(src, color) || var_name == NAMEOF(src, current_color))
		INVOKE_ASYNC(src, PROC_REF(set_color), var_value)
		datum_flags |= DF_VAR_EDITED
		return TRUE
	return ..()

/obj/structure/signboard/holosign/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	var/obj/item/item = astype(tool, /obj/item)
	var/obj/item/card/id/id = item?.GetID()
	if(!istype(id) || !can_interact(user) || !user.can_perform_action(src, NEED_DEXTERITY))
		return NONE

	var/trimmed_id_name = trimtext(id.registered_name)
	if(!trimmed_id_name)
		balloon_alert(user, "ID 上没有姓名！")
		return ITEM_INTERACT_BLOCKING
	if(obj_flags & EMAGGED)
		balloon_alert(user, "锁定机构已烧毁！")
		return ITEM_INTERACT_BLOCKING
	if(registered_owner)
		if(!check_locked(user))
			registered_owner = null
			balloon_alert(user, "已移除 ID 锁定")
			investigate_log("([key_name(user)]) 移除了 ID 锁定", INVESTIGATE_SIGNBOARD)
	else
		registered_owner = trimmed_id_name
		balloon_alert(user, "已锁定至 ID")
		investigate_log("([key_name(user)]) 为 \"[registered_owner]\" 添加了 ID 锁定", INVESTIGATE_SIGNBOARD)
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/structure/signboard/holosign/is_locked(mob/living/user)
	. = ..()
	if(.)
		return
	if(registered_owner && isliving(user))
		var/obj/item/card/id/id = user.get_idcard()
		if(!istype(id) || QDELING(id))
			return TRUE
		return !cmptext(trimtext(id.registered_name), registered_owner)

/obj/structure/signboard/holosign/set_text(new_text, force)
	. = ..()
	set_light(l_on = !!sign_text)

/obj/structure/signboard/holosign/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(try_set_color(user))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/signboard/holosign/proc/try_set_color(mob/user)
	. = TRUE
	if(!can_interact(user) || !user.can_perform_action(src, NEED_DEXTERITY))
		return FALSE
	if(check_locked(user))
		return
	var/new_color = sanitize_color(tgui_color_picker(user, "设置牌子颜色", full_capitalize(name), current_color))
	if(new_color && is_color_dark_with_saturation(new_color, 25))
		balloon_alert(user, "颜色太暗！")
		return
	if(check_locked(user))
		return
	INVOKE_ASYNC(src, PROC_REF(set_color), new_color)
	if(new_color)
		balloon_alert(user, "已将颜色设为 [new_color]")
		investigate_log("([key_name(user)]) 将颜色设为 [new_color || "(无)"]", INVESTIGATE_SIGNBOARD)
	else
		balloon_alert(user, "已取消颜色")
		investigate_log("([key_name(user)]) 清除了颜色", INVESTIGATE_SIGNBOARD)

/obj/structure/signboard/holosign/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	playsound(src, SFX_SPARKS, vol = 100, vary = TRUE, extrarange = SHORT_RANGE_SOUND_EXTRARANGE)
	do_sparks(3, cardinal_only = FALSE, source = src)
	balloon_alert(user, "锁定已破坏")
	investigate_log("被 [key_name(user)] 电磁卡破坏（原主人： [registered_owner || "(无)"]）", INVESTIGATE_SIGNBOARD)
	registered_owner = null
	obj_flags |= EMAGGED
	update_appearance()

/obj/structure/signboard/holosign/proc/sanitize_color(color)
	. = sanitize_hexcolor(color)
	if(!. || . == COLOR_BLACK)
		return null

/obj/structure/signboard/holosign/proc/set_color(new_color)
	new_color = sanitize_color(new_color)
	if(!new_color)
		current_color = null
		remove_atom_colour(FIXED_COLOUR_PRIORITY)
	else
		current_color = new_color
		add_atom_colour(new_color, FIXED_COLOUR_PRIORITY)
	set_light(l_color = current_color || src::light_color)
	update_appearance()

/obj/item/circuit_component/holo_signboard
	display_name = "全息牌子"
	desc = "向一块牌子输出文字，在消息字段中插入 <br> 即可换行。将颜色设为 0, 0, 0 可恢复默认。"
	circuit_flags = CIRCUIT_FLAG_INPUT_SIGNAL|CIRCUIT_FLAG_OUTPUT_SIGNAL

	var/datum/port/input/message
	var/datum/port/input/clear

	var/datum/port/output/fail_reason
	var/datum/port/output/on_fail

	var/datum/port/input/red
	var/datum/port/input/green
	var/datum/port/input/blue
	var/datum/port/input/set_color

	var/obj/structure/signboard/holosign/connected_display

/obj/item/circuit_component/holo_signboard/populate_ports()
	message = add_input_port("消息", PORT_TYPE_STRING)
	clear = add_input_port("清空", PORT_TYPE_SIGNAL, trigger = PROC_REF(clear_received))

	fail_reason = add_output_port("失败原因", PORT_TYPE_STRING)
	on_fail = add_output_port("失败", PORT_TYPE_SIGNAL)

	red = add_input_port("红", PORT_TYPE_NUMBER)
	green = add_input_port("绿", PORT_TYPE_NUMBER)
	blue = add_input_port("蓝", PORT_TYPE_NUMBER)
	set_color = add_input_port("设置颜色", PORT_TYPE_SIGNAL, trigger = PROC_REF(color_received))

/obj/item/circuit_component/holo_signboard/register_usb_parent(atom/movable/shell)
	. = ..()
	if(istype(shell, /obj/structure/signboard/holosign))
		connected_display = shell

/obj/item/circuit_component/holo_signboard/input_received(datum/port/input/port)
	if(!connected_display)
		return
	if(length(message.value) > connected_display.max_length) //5000 is a hell of a lot longer than 144.
		fail_reason.set_output("过长（[length(message.value)]/[connected_display.max_length]）。")
		on_fail.set_output(COMPONENT_SIGNAL)
		return
	if(is_ic_filtered(message.value))
		fail_reason.set_output("包含禁止的内容。")
		on_fail.set_output(COMPONENT_SIGNAL)
		return

	var/edited_message = replacetextEx_char(message.value, "<br>", "\n")
	if(connected_display.set_text(edited_message))
		investigate_log("电路 USB（[parent.get_creator()]）将文字设为 \"[connected_display.sign_text || "(无)"]\"", INVESTIGATE_SIGNBOARD)
		if(is_soft_ic_filtered(message.value))
			message_admins("一个电路组件（由 [parent.get_creator_admin()] 创建）向牌子添加了软性屏蔽词信息。[ADMIN_COORDJMP(src)]")
	else
		fail_reason.set_output("连接被外部端点拒绝。")
		on_fail.set_output(COMPONENT_SIGNAL)

/obj/item/circuit_component/holo_signboard/proc/clear_received(datum/port/input/port)
	if(!connected_display.set_text(null))
		fail_reason.set_output("连接被外部端点拒绝。")
		on_fail.set_output(COMPONENT_SIGNAL)

/obj/item/circuit_component/holo_signboard/proc/color_received(datum/port/input/port)
	red.set_value(clamp(red.value, 0, 255))
	blue.set_value(clamp(blue.value, 0, 255))
	green.set_value(clamp(green.value, 0, 255))
	var/signboard_color = rgb(red.value, green.value, blue.value)
	if(signboard_color && signboard_color != rgb(0, 0, 0) && is_color_dark_with_saturation(signboard_color, 25))
		fail_reason.set_output("颜色太暗，无法显示。")
		on_fail.set_output(COMPONENT_SIGNAL)
		return
	connected_display.set_color(signboard_color) //doesnt have a return so no need to check and error
	investigate_log("电路 USB（[parent.get_creator()]）将颜色设为 [signboard_color || "(无)"]", INVESTIGATE_SIGNBOARD)

/// Given a color in the format of "#RRGGBB", will return if the color
/// is dark. Value is mixed with Saturation and Brightness from HSV.
/proc/is_color_dark_with_saturation(color, threshold = 25)
	var/hsl = rgb2num(color, COLORSPACE_HSL)
	return hsl[3] < threshold
