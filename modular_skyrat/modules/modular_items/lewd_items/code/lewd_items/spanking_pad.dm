/obj/item/spanking_pad
	name = "拍打板"
	desc = "一块带手柄的皮革拍板。"
	icon_state = "spankpad_pink"
	base_icon_state = "spankpad"
	inhand_icon_state = "spankpad_pink"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_SMALL
	/// Current color, can be changed and affects sprite
	var/current_color = "pink"
	/// If the color has been changed before
	var/color_changed = FALSE
	/// A list of all designs for the color choice radial menu
	var/static/list/spankpad_designs

/// Create the designs for the radial menu
/obj/item/spanking_pad/proc/populate_spankpad_designs()
	spankpad_designs = list(
		"pink" = image(icon = src.icon, icon_state = "spankpad_pink"),
		"teal" = image(icon = src.icon, icon_state = "spankpad_teal"),
	)

/// A check to ensure the user can use the radial menu
/obj/item/spanking_pad/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/obj/item/spanking_pad/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	update_icon()
	update_icon_state()
	if(!length(spankpad_designs))
		populate_spankpad_designs()

/obj/item/spanking_pad/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_color]"
	inhand_icon_state = "[base_icon_state]_[current_color]"

/obj/item/spanking_pad/examine(mob/user)
	. = ..()
	if(!color_changed)
		. += span_notice("按住 Alt 点击可更换颜色。")

/obj/item/spanking_pad/click_alt(mob/user)
	if(color_changed)
		return CLICK_ACTION_BLOCKING
	var/choice = chinese_skyrat_item_radial(user, src, spankpad_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!choice)
		return CLICK_ACTION_BLOCKING
	current_color = choice
	update_icon_state()
	update_icon()
	color_changed = TRUE
	return CLICK_ACTION_SUCCESS

/obj/item/spanking_pad/attack(mob/living/target, mob/living/user)
	. = ..()
	if(target.stat == DEAD)
		return

	var/mob/living/carbon/human/carbon_target
	if(ishuman(target))
		carbon_target = target
	else if(!iscyborg(target))
		return

	if(!target.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[target] 不愿意让你这么做。"))
		return

	if(carbon_target && !carbon_target.is_bottomless())
		to_chat(user, span_danger("[target] 的臀部被遮住了！"))
		return

	var/message = (user == target) ? pick("用 [src] 拍打自己的屁股",
			"用 [src] 拍打自己的臀部") \
		: pick("用 [src] 拍打 [target] 的臀部",
			"用 [src] 拍打 [target] 的屁股",
			"用 [src] 拍打 [target] 的屁股，发出响亮的啪声",
			"用 [src] 拍打 [target] 的大腿")
	user.visible_message(span_purple("[user] [message]!"))
	conditional_pref_sound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/slap.ogg', 100, 1, -1)
	if(prob(40))
		target.try_lewd_autoemote(pick("twitch_s", "moan", "blush", "gasp"))
	if(prob(10))
		target.apply_status_effect(/datum/status_effect/subspace)
	if(HAS_TRAIT(target, TRAIT_MASOCHISM) || HAS_TRAIT(target, TRAIT_BIMBO))
		target.add_mood_event("pervert spanked", /datum/mood_event/perv_spanked)
	carbon_target?.adjust_arousal(2)
	target.adjust_pain(4)
	target.apply_status_effect(/datum/status_effect/spanked)
