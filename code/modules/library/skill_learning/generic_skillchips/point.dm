/**
 * A skillchip that gives the user bigger arrows when pointing at things (like some id trims do).
 * As a bonus, they can costumize the color of the arrow/pointer too.
 */
/obj/item/skillchip/big_pointer
	name = "指挥官技能芯片"
	desc = "一枚生物芯片，详述历代领袖用来像真正的大佬一样指点万物的各种技巧。"
	skill_name = "强化指点"
	skill_description = "学会以更引人注目的方式指点事物。"
	skill_icon = FA_ICON_ARROW_DOWN
	activate_message = span_notice("摘自《有志领袖必备肢体语言大全》第 164 页第 3 段……")
	deactivate_message = span_notice("那么，呃，对，我该怎么指东西来着？")

	actions_types = list(/datum/action/change_pointer_color)

/obj/item/skillchip/big_pointer/on_activate(mob/living/carbon/user, silent=FALSE)
	. = ..()
	RegisterSignal(user, COMSIG_MOVABLE_POINTED, PROC_REF(fancier_pointer))

/obj/item/skillchip/big_pointer/on_deactivate(mob/living/carbon/user, silent=FALSE)
	UnregisterSignal(user, COMSIG_MOVABLE_POINTED)
	var/datum/action/change_pointer_color/action = locate() in actions
	action?.arrow_color = null
	action?.arrow_overlay = null
	return ..()

/obj/item/skillchip/big_pointer/proc/fancier_pointer(mob/living/user, atom/pointed, obj/effect/temp_visual/point/point)
	SIGNAL_HANDLER
	if(HAS_TRAIT(user, TRAIT_UNKNOWN_APPEARANCE))
		return
	point.cut_overlays()
	var/datum/action/change_pointer_color/action = locate() in actions
	if(!action.arrow_color)
		point.icon_state = "arrow_large"
		return
	point.icon_state = "arrow_large_white"
	point.color = action.arrow_color
	var/mutable_appearance/highlight = mutable_appearance(point.icon, "arrow_large_white_highlights", appearance_flags = RESET_COLOR)
	point.add_overlay(highlight)

/datum/action/change_pointer_color
	name = "更改指针颜色"
	desc = "设置你的自定义指针颜色，或将其重置为默认。"
	button_icon = /obj/effect/temp_visual/point::icon
	button_icon_state = "arrow_large_still"
	check_flags = AB_CHECK_CONSCIOUS
	///the color of our arrow
	var/arrow_color
	///the arrow overlay shown on the button
	var/mutable_appearance/arrow_overlay

/datum/action/change_pointer_color/Destroy()
	. = ..()
	arrow_overlay = null

/datum/action/change_pointer_color/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	var/mob/user = owner
	if(!arrow_color)
		pick_color(user)
		return
	var/choice = tgui_alert(owner, "要重置还是更新指针颜色？","指针颜色", list("重置","更新"))
	if(user != owner || !choice || !IsAvailable(feedback = TRUE))
		return
	if(choice == "更新")
		pick_color(user)
	else
		arrow_color = null
		owner.balloon_alert(owner, "指针已重置")
		build_all_button_icons(update_flags = UPDATE_BUTTON_ICON, force = TRUE)

/datum/action/change_pointer_color/proc/pick_color(mob/user)
	var/ncolor = tgui_color_picker(owner, "选择新颜色", "指针颜色", arrow_color)
	if(user != owner || !IsAvailable(feedback = TRUE))
		return
	arrow_color = ncolor
	owner.balloon_alert(owner, "指针已更新")
	build_all_button_icons(update_flags = UPDATE_BUTTON_ICON, force = TRUE)

/datum/action/change_pointer_color/apply_button_icon(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	var/initial_icon = /obj/effect/temp_visual/point::icon
	current_button.cut_overlay(arrow_overlay)
	if(!arrow_color)
		current_button.icon = initial_icon
		current_button.icon_state = /obj/effect/temp_visual/point::icon_state
		return ..()

	current_button.icon = current_button.icon_state = null
	arrow_overlay = mutable_appearance(icon = initial_icon, icon_state = "arrow_large_white_still")
	arrow_overlay.color = arrow_color
	arrow_overlay.overlays += mutable_appearance(icon = initial_icon, icon_state = "arrow_large_white_still_highlights", appearance_flags = RESET_COLOR)
	current_button.add_overlay(arrow_overlay)
