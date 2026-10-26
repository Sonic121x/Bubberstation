#define AROUSAL_REGULAR_THRESHOLD 25

/*
*	NORMAL DILDO
*/

/obj/item/clothing/sextoy/dildo
	name = "假阳具"
	desc = "一根大型塑料阴茎，很像你妈妈床头柜里放的那根。"
	icon_state = "dildo_human"
	base_icon_state = "dildo"
	inhand_icon_state = "dildo_human"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	/// Current design of the toy, affects sprite and can change
	var/current_type = "human"
	/// If the design has been changed before
	var/color_changed = FALSE
	/// Assoc list of designs, used in the radial menu for picking one
	var/static/list/dildo_designs
	/// How large is the toy? ("small", "medium", "large") (only changed on `custom_dildo`)
	var/poly_size = "medium"
	/// If the size has been changed before (only changed on `custom_dildo`, left here for consistency with `poly_size`)
	var/size_changed = FALSE
	/// If it's part of a double-sided toy or not
	var/side_double = FALSE
	/// If the toy can have its sprite changed
	var/change_sprite = TRUE
	w_class = WEIGHT_CLASS_TINY
	lewd_slot_flags = LEWD_SLOT_ANUS | LEWD_SLOT_VAGINA
	clothing_flags = INEDIBLE_CLOTHING

/// Create an assoc list of designs for the radial color/design menu
/obj/item/clothing/sextoy/dildo/proc/populate_dildo_designs()
	dildo_designs = list(
		"avian" = image(icon = src.icon, icon_state = "[base_icon_state]_avian"),
		"canine" = image(icon = src.icon, icon_state = "[base_icon_state]_canine"),
		"equine" = image(icon = src.icon, icon_state = "[base_icon_state]_equine"),
		"dragon" = image(icon = src.icon, icon_state = "[base_icon_state]_dragon"),
		"human" = image(icon = src.icon, icon_state = "[base_icon_state]_human"),
		"tentacle" = image(icon = src.icon, icon_state = "[base_icon_state]_tentacle"))

/obj/item/clothing/sextoy/dildo/examine(mob/user)
	. = ..()
	if(!color_changed && change_sprite)
		. += span_notice("按住 Alt 点击可更换款式。")

/obj/item/clothing/sextoy/dildo/click_alt(mob/user)
	if(color_changed)
		return CLICK_ACTION_BLOCKING
	var/choice = chinese_skyrat_item_radial(user, src, dildo_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!choice)
		return CLICK_ACTION_BLOCKING
	current_type = choice
	update_icon()
	color_changed = TRUE
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/sextoy/dildo/Initialize(mapload)
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(dildo_designs))
		populate_dildo_designs()

/obj/item/clothing/sextoy/dildo/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][change_sprite ? "_[current_type]" : ""]"
	inhand_icon_state = "[base_icon_state][change_sprite ? "_[current_type]" : ""]"

/obj/item/clothing/sextoy/dildo/lewd_equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!istype(user))
		return
	if(is_inside_lewd_slot(user))
		START_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/dildo/dropped(mob/user, slot)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/dildo/process(seconds_per_tick)
	var/mob/living/carbon/human/user = loc
	if(!istype(user))
		return
	if(poly_size == "small" && user.arousal < (AROUSAL_REGULAR_THRESHOLD * 0.8))
		user.adjust_arousal(0.6 * seconds_per_tick)
		user.adjust_pleasure(0.6 * seconds_per_tick)
	else if(poly_size == "medium" && user.arousal < AROUSAL_REGULAR_THRESHOLD)
		user.adjust_arousal(0.8 * seconds_per_tick)
		user.adjust_pleasure(0.8 * seconds_per_tick)
	else if(poly_size == "big" && user.arousal < (AROUSAL_REGULAR_THRESHOLD * 1.2))
		user.adjust_arousal(1 * seconds_per_tick)
		user.adjust_pleasure(1 * seconds_per_tick)

/obj/item/clothing/sextoy/dildo/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	. = ..()
	if(target.stat == DEAD)
		return
	if(!ishuman(target)) //Don't.
		return

	if(!target.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[target] 不愿意让你这么做。"))
		return

	var/message = ""
	var/arousal_adjustment = 4
	var/pleasure_adjustment = 5
	var/emote_probability = 20
	var/list/possible_emotes = list("moan")
	switch(user.zone_selected) //to let code know what part of body we gonna fuck
		if(BODY_ZONE_PRECISE_GROIN)
			var/obj/item/organ/genital/vagina = target.get_organ_slot(ORGAN_SLOT_VAGINA)
			if(!vagina?.is_exposed())
				to_chat(user, span_danger("[target] 的胯部似乎被遮住了！"))
				return FALSE

			message = (user == target) ? pick("用 [src] 摩擦自己的阴道",
					"将 [src] 轻轻插入自己的阴部",
					"用 [src] 抽插自己的阴道") \
				: pick("用 [src] 轻柔地摩擦 [target] 的阴道",
					"将 [src] 深深插入 [target] 的阴道",
					"将 [src] 塞入 [target] 的阴部",
					"用 [src] 挑逗 [target] 的阴部")

			switch(poly_size)
				if("medium")
					arousal_adjustment = 6
					pleasure_adjustment = 8
					emote_probability = 40
					possible_emotes = list("moan","twitch_s")
				if("big")
					arousal_adjustment = 8
					pleasure_adjustment = 10
					emote_probability = 60
					possible_emotes = list("moan","twitch_s", "gasp")
					target.adjust_pain(2)

			if(side_double)
				arousal_adjustment += 6
				pleasure_adjustment += 8

		if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES) //Mouth only. Sorry, perverts. No eye/ear penetration for you today.
			if(target.is_mouth_covered())
				to_chat(user, span_danger("[target] 的嘴似乎被遮住了！"))
				return FALSE

			message = (user == target) ? pick("诱人地舔舐 [src]",
					"含住 [src]，慢慢将其送入自己的喉咙") \
				: pick("用 [src] 抽插 [target] 的嘴",
					"将 [src] 塞进 [target] 的喉咙，使其喘不过气",
					"强迫 [target] 吮吸 [src]",
					"将 [src] 插入 [target] 的喉咙")
			arousal_adjustment = 4
			pleasure_adjustment = 1
			emote_probability = 70
			possible_emotes = list("gasp", "moan")

		else
			var/obj/item/organ/genital/anus = target.get_organ_slot(ORGAN_SLOT_ANUS)
			if(!anus?.is_exposed())
				to_chat(user, span_danger("[target] 的肛门似乎被遮住了！"))
				return FALSE

			message = (user == target) ? pick("将 [src] 插入自己的肛门",
					"慢慢将 [src] 送入自己的后穴") \
				: pick("用 [src] 抽插 [target] 的后穴",
					"用 [src] 抽插 [target] 的肛门",
					"将 [src] 塞进 [target] 的后穴",
					"用 [src] 抽插 [target] 的后穴，使其双眼上翻")
			arousal_adjustment = 5
			pleasure_adjustment = 5
			emote_probability = 60
			possible_emotes = list("twitch_s", "moan", "shiver")

	target.adjust_arousal(arousal_adjustment)
	target.adjust_pleasure(pleasure_adjustment)
	if(prob(emote_probability))
		target.try_lewd_autoemote(pick(possible_emotes))

	user.visible_message(span_purple("[user] [message]!"))
	conditional_pref_sound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 100, TRUE)

/*
*	COLOUR CHANGING
*/

GLOBAL_LIST_INIT(dildo_colors, list(//mostly neon colors
		"Cyan"		= "#00f9ff", //cyan
		"Green"		= "#49ff00", //green
		"Pink"		= "#ff4adc", //pink
		"Yellow"	= "#fdff00", //yellow
		"Blue"		= "#00d2ff", //blue
		"Lime"		= "#89ff00", //lime
		"Black"		= "#101010", //black
		"Red"		= "#ff0000", //red
		"Orange"	= "#ff9a00", //orange
		"Purple"	= "#e300ff", //purple
		"White"		= "#c0c0c0", //white
		))

/obj/item/clothing/sextoy/dildo/custom_dildo
	name = "定制假阳具"
	desc = "可以按你的要求调整的假阳具。"
	icon_state = "polydildo_small"
	base_icon_state = "polydildo"
	inhand_icon_state = "polydildo_small"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	current_type = null

	var/static/list/dildo_sizes = list()
	w_class = WEIGHT_CLASS_TINY
	lewd_slot_flags = LEWD_SLOT_ANUS | LEWD_SLOT_VAGINA

/obj/item/clothing/sextoy/dildo/custom_dildo/populate_dildo_designs()
	dildo_sizes = list(
		"small" = image (icon = src.icon, icon_state = "[base_icon_state]_small"),
		"medium" = image(icon = src.icon, icon_state = "[base_icon_state]_medium"),
		"big" = image(icon = src.icon, icon_state = "[base_icon_state]_big"))

/obj/item/clothing/sextoy/dildo/custom_dildo/examine(mob/user)
	. = ..()
	if(!size_changed && color_changed && change_sprite)
		. += span_notice("按住 Alt 点击可更改尺寸。")

/obj/item/clothing/sextoy/dildo/custom_dildo/click_alt(mob/living/user)
	if(!color_changed)
		if(!istype(user) || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
			return CLICK_ACTION_BLOCKING
		customize(user)
		color_changed = TRUE
	else if (!size_changed)
		var/choice = chinese_skyrat_item_radial(user, src, dildo_sizes, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
		if(!choice)
			return CLICK_ACTION_BLOCKING
		poly_size = choice
		update_icon()
		size_changed = TRUE
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/sextoy/dildo/custom_dildo/Initialize(mapload)
	. = ..()
	if(!length(dildo_sizes))
		populate_dildo_designs()

/// Choose a color and transparency level for the toy
/obj/item/clothing/sextoy/dildo/custom_dildo/proc/customize(mob/living/user)
	if(!src || !user || user.incapacitated || !in_range(user, src))
		return FALSE

	var/color_choice = chinese_skyrat_item_choice(user, "选择假阳具的颜色。", "假阳具颜色", GLOB.dildo_colors)
	if(color_choice)
		sanitize_inlist(color_choice, GLOB.dildo_colors, "Red")
		color = GLOB.dildo_colors[color_choice]

	update_icon_state()
	var/transparency_choice = tgui_input_number(user, "选择假阳具的透明度。数值越低越透明！（192–255）", "假阳具透明度", 255, 255, 192)
	if(transparency_choice)
		sanitize_integer(transparency_choice, 191, 255, 192)
		alpha = transparency_choice

	update_icon_state()
	return TRUE

/obj/item/clothing/sextoy/dildo/custom_dildo/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[poly_size]"
	inhand_icon_state = "[base_icon_state]_[poly_size]"

/*
*	DOUBLE DILDO
*/

/obj/item/clothing/sextoy/dildo/double_dildo
	name = "双头假阳具"
	desc = "只有真正的香肠角斗士才能驾驭它。"
	icon_state = "dildo_double"
	inhand_icon_state = "dildo_double"
	worn_icon_state = "dildo_side"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY
	lewd_slot_flags = LEWD_SLOT_ANUS | LEWD_SLOT_VAGINA
	actions_types = list(/datum/action/item_action/take_dildo)
	change_sprite = FALSE
	/// If one end of the toy is in your hand
	var/end_in_hand = FALSE
	/// Reference to the end of the toy that you can hold when the other end is inserted in you
	var/obj/item/clothing/sextoy/dildo/double_dildo_end/other_end
	/// Whether or not the current location is front or behind
	var/in_back = FALSE

/obj/item/clothing/sextoy/dildo/double_dildo/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/sextoy/dildo/double_dildo/item_action_slot_check(slot, mob/user, datum/action/action)
	return is_inside_lewd_slot(user)

/obj/item/clothing/sextoy/dildo/double_dildo/populate_dildo_designs()
	return

/obj/item/clothing/sextoy/dildo/double_dildo/click_alt(mob/user)
	return NONE

/obj/item/clothing/sextoy/dildo/double_dildo/lewd_equipped(mob/living/carbon/human/user, slot, initial)
	. = ..()
	in_back = (src == user.anus)
	update_icon_state()

/obj/item/clothing/sextoy/dildo/double_dildo/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]"
	worn_icon_state = "[initial(worn_icon_state)][(in_back ? "_back" : "")]"

//button stuff
/datum/action/item_action/take_dildo
	name = "握住双头假阳具的另一端"
	desc = "你能感觉到一端在自己体内，是时候与别人分享这种感觉了……"

/datum/action/item_action/take_dildo/Trigger(trigger_flags)
	if(!..())
		return FALSE
	var/obj/item/clothing/sextoy/dildo/double_dildo/dildo = target
	if(istype(dildo))
		dildo.can_take_in_hand()

/// A check to make sure the user can actually take one end in their hand
/obj/item/clothing/sextoy/dildo/double_dildo/proc/can_take_in_hand()
	var/mob/living/carbon/human/user = usr
	if(src == user.vagina)
		toggle(user)
	else if(src == user.anus)
		to_chat(user, span_warning("这个角度无法使用 [src]！"))
	else
		to_chat(user, span_warning("需要先装备 [src] 才能使用！"))

//dumb way to fix organs overlapping with toys, but WHY NOT. Find a better way if you're not lazy as me.
/obj/item/clothing/sextoy/dildo/double_dildo/lewd_equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!istype(user))
		return
	var/obj/item/organ/genital/vagina/vagina = user.get_organ_slot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/womb/womb = user.get_organ_slot(ORGAN_SLOT_WOMB)
	var/obj/item/organ/genital/penis/penis = user.get_organ_slot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/testicles = user.get_organ_slot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/genital/anus/anus = user.get_organ_slot(ORGAN_SLOT_ANUS)

	if(src == user.vagina)
		vagina?.visibility_preference = GENITAL_NEVER_SHOW
		womb?.visibility_preference = GENITAL_NEVER_SHOW
		penis?.visibility_preference = GENITAL_NEVER_SHOW
		testicles?.visibility_preference = GENITAL_NEVER_SHOW
		user.update_body()

	else if(src == user.anus)
		anus?.visibility_preference = GENITAL_NEVER_SHOW
		user.update_body()

/obj/item/clothing/sextoy/dildo/double_dildo/process(seconds_per_tick)
	var/mob/living/carbon/human/user = loc
	if(!istype(user))
		return FALSE
	if(user.arousal < AROUSAL_REGULAR_THRESHOLD)
		user.adjust_arousal(0.8 * seconds_per_tick)
		user.adjust_pleasure(0.8 * seconds_per_tick)

/obj/item/clothing/sextoy/dildo/double_dildo/dropped(mob/living/carbon/human/user)
	. = ..()
	if(!istype(user))
		return FALSE

	if(other_end)
		QDEL_NULL(other_end)

	var/obj/item/organ/genital/vagina/vagina = user.get_organ_slot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/womb/womb = user.get_organ_slot(ORGAN_SLOT_WOMB)
	var/obj/item/organ/genital/penis/penis = user.get_organ_slot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/testicles = user.get_organ_slot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/genital/anus/anus = user.get_organ_slot(ORGAN_SLOT_ANUS)

	if(!(src == user.vagina))
		anus?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		user.update_body()
		return

	vagina?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	womb?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	penis?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	testicles?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES

	user.update_body()

/obj/item/clothing/sextoy/dildo/double_dildo/Destroy()
	moveToNullspace() // This will ensure it gets removed from the world, and from any slots in mobs
	if(!QDELETED(other_end))
		QDEL_NULL(other_end)
	return ..()

/// Code for taking out/putting away the other end of the toy when one end is in you
/obj/item/clothing/sextoy/dildo/double_dildo/proc/toggle(mob/living/carbon/human/user)
	conditional_pref_sound(user, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 40, TRUE)

	if(!end_in_hand)
		take_in_hand(user)
		return

	var/obj/item/clothing/sextoy/dildo/double_dildo_end/end_piece = user.is_holding_item_of_type(/obj/item/clothing/sextoy/dildo/double_dildo_end)
	if(end_piece)
		end_piece.moveToNullspace()
		QDEL_NULL(other_end)
		user.visible_message(span_notice("[user] 松开了 [src] 的一端。"))
		end_in_hand = FALSE
		return

/// For holding the other end while the thing is inserted, returns FALSE if unsuccessful
/obj/item/clothing/sextoy/dildo/double_dildo/proc/take_in_hand(mob/living/carbon/human/user)
	other_end = new /obj/item/clothing/sextoy/dildo/double_dildo_end

	if(!user.put_in_hands(other_end))
		user.visible_message(span_notice("[user] 试图握住 [src] 的一端，但手里已经拿着东西了！"))
		return FALSE

	other_end.parent_end = WEAKREF(src)
	user.visible_message(span_notice("[user] 握住了 [src] 的一端。"))
	end_in_hand = TRUE
	return TRUE

/obj/item/clothing/sextoy/dildo/double_dildo_end
	name = "假阳具另一端"
	desc = "你看起来真性感！"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
	icon_state = "dildo_side"
	inhand_icon_state = null
	worn_icon_state = ""
	item_flags = ABSTRACT | HAND_ITEM
	side_double = TRUE
	/// ref to the parent end
	var/datum/weakref/parent_end

/obj/item/clothing/sextoy/dildo/double_dildo_end/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_STRAPON)

/obj/item/clothing/sextoy/dildo/double_dildo_end/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]"
	inhand_icon_state = null
	worn_icon_state = null

/obj/item/clothing/sextoy/dildo/double_dildo_end/dropped()
	. = ..()

	if(ismob(loc)) // if it's in a mob we don't want to be qdeleting it just yet
		return

	if(!QDELETED(src))
		QDEL_NULL(src)

/obj/item/clothing/sextoy/dildo/double_dildo_end/Destroy()
	var/obj/item/clothing/sextoy/dildo/double_dildo/our_parent = parent_end?.resolve()
	if(!our_parent)
		parent_end = null
		moveToNullspace()
		return ..()

	moveToNullspace()
	our_parent.end_in_hand = FALSE
	our_parent.other_end = null
	parent_end = null

	return ..()

#undef AROUSAL_REGULAR_THRESHOLD
