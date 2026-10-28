
/obj/item/clothing/mask/bridle
	name = "马笼头"
	desc = "阳光马厩设计的皮革马笼头，配有眼罩与衔铁。它由数条皮带与金属配件制成。你可以收紧或放松皮带，让眼罩与衔铁保持在位。"
	icon_state = "bridle"
	inhand_icon_state = "sechailer"
	icon = 'modular_zubbers/icons/obj/clothing/mask/mask.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/mask/mask.dmi'
	worn_icon_state = "bridle"
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = NONE
	actions_types = list(
		/datum/action/item_action/bridle_toggle_blinders,
		/datum/action/item_action/bridle_toggle_gag,
	)
	action_slots = ITEM_SLOT_MASK
	var/blinders_enabled = FALSE
	var/gag_enabled = FALSE
	var/blinders_tint = 2
	var/last_blinders_enabled = FALSE
	var/last_gag_enabled = FALSE
	var/straps_locked = FALSE
	var/strip_adjust_delay = 4 SECONDS

/obj/item/clothing/mask/bridle/Initialize(mapload)
	. = ..()
	update_bridle_state()

/obj/item/clothing/mask/bridle/Destroy()
	var/mob/living/carbon/wearer = get_wearer()
	if(wearer)
		remove_gag(wearer)
		wearer.update_tint()
	return ..()

/obj/item/clothing/mask/bridle/equipped(mob/living/carbon/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_MASK))
		return
	playsound(user, 'sound/items/equip/toolbelt_equip.ogg', 50, TRUE)
	update_bridle_state(user)
	user.update_action_buttons()

/obj/item/clothing/mask/bridle/dropped(mob/living/carbon/user)
	. = ..()
	if(gag_enabled)
		remove_gag(user)
	if(blinders_enabled)
		user.update_tint()
	user.update_worn_mask()
	user.update_action_buttons()

/obj/item/clothing/mask/bridle/click_alt(mob/user)
	if(!istype(user) || user.incapacitated)
		return CLICK_ACTION_BLOCKING
	cycle_mode(user)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/bridle/attack_self(mob/user)
	. = ..()
	if(!istype(user) || user.incapacitated)
		return
	straps_locked = !straps_locked
	if(straps_locked)
		to_chat(user, span_notice("你扣紧了马笼头的皮带。"))
	else
		to_chat(user, span_notice("你放松了马笼头的皮带。"))

/obj/item/clothing/mask/bridle/proc/get_wearer()
	var/mob/living/carbon/wearer = istype(loc, /mob/living/carbon) ? loc : null
	if(wearer && wearer.get_item_by_slot(ITEM_SLOT_MASK) == src)
		return wearer
	return null

/obj/item/clothing/mask/bridle/proc/should_show_user_message(mob/user)
	if(!user)
		return FALSE
	return user.get_item_by_slot(ITEM_SLOT_MASK) != src

/obj/item/clothing/mask/bridle/proc/locked_message(mob/user)
	if(!user)
		return
	if(should_show_user_message(user))
		to_chat(user, span_notice("皮带扣得太紧，无法调节。"))
	else
		to_chat(user, span_warning("皮带扣得太紧了！"))

/obj/item/clothing/mask/bridle/examine(mob/user)
	. = ..()
	var/blinders_state_text = blinders_enabled ? "已放下" : "已抬起"
	var/gag_state_text = gag_enabled ? "已就位" : "未就位"
	. += span_notice("眼罩[blinders_state_text]，衔铁[gag_state_text]。")

/obj/item/clothing/mask/bridle/proc/update_bridle_state(mob/user, notify_wearer = TRUE)
	var/mob/living/carbon/wearer = get_wearer()
	worn_icon_state = blinders_enabled ? "bridle_blinders" : "bridle"
	tint = blinders_enabled ? blinders_tint : 0
	flags_cover = gag_enabled ? MASKCOVERSMOUTH : NONE
	if(wearer)
		if(blinders_enabled != last_blinders_enabled)
			if(notify_wearer)
				var/blinders_action
				var/blinders_action_self
				var/blinders_effect
				var/blinders_self
				if(blinders_enabled)
					blinders_action = "放下"
					blinders_action_self = "放下"
					blinders_effect = "遮住了你的视线"
					blinders_self = "放了下来，遮住了你的视线"
				else
					blinders_action = "抬起"
					blinders_action_self = "抬起"
					blinders_effect = "恢复了你的视力"
					blinders_self = "抬了起来，恢复了你的视力"
				if(user && user != wearer)
					to_chat(wearer, span_userdanger("[user] [blinders_action]了马笼头的眼罩，[blinders_effect]。"))
				else if(user)
					to_chat(wearer, span_notice("你[blinders_action_self]了马笼头的眼罩，[blinders_effect]。"))
				else
					to_chat(wearer, span_notice("马笼头的眼罩[blinders_self]。"))
			last_blinders_enabled = blinders_enabled
		if(gag_enabled != last_gag_enabled)
			if(notify_wearer)
				var/gag_action
				var/gag_action_self
				var/gag_effect
				var/gag_self
				if(gag_enabled)
					gag_action = "塞紧"
					gag_action_self = "塞紧"
					gag_effect = "让你的话语含混不清"
					gag_self = "塞紧了，让你的话语含混不清"
				else
					gag_action = "松开"
					gag_action_self = "松开"
					gag_effect = "让你能自由说话"
					gag_self = "松开了，让你能自由说话"
				if(user && user != wearer)
					to_chat(wearer, span_userdanger("[user] [gag_action]了马笼头的衔铁，[gag_effect]。"))
				else if(user)
					to_chat(wearer, span_notice("你[gag_action_self]了马笼头的衔铁，[gag_effect]。"))
				else
					to_chat(wearer, span_notice("马笼头的衔铁[gag_self]。"))
			last_gag_enabled = gag_enabled
		wearer.update_tint()
		wearer.update_worn_mask()
		if(gag_enabled)
			apply_gag(wearer)
		else
			remove_gag(wearer)

/obj/item/clothing/mask/bridle/proc/toggle_blinders(mob/user)
	if(straps_locked)
		locked_message(user)
		return
	blinders_enabled = !blinders_enabled
	if(should_show_user_message(user))
		var/blinders_action
		if(blinders_enabled)
			blinders_action = "放下"
		else
			blinders_action = "抬起"
		to_chat(user, span_notice("你[blinders_action]了马笼头的眼罩。"))
	update_bridle_state(user)

/obj/item/clothing/mask/bridle/proc/toggle_gag(mob/user)
	if(straps_locked)
		locked_message(user)
		return
	gag_enabled = !gag_enabled
	if(should_show_user_message(user))
		var/gag_action
		if(gag_enabled)
			gag_action = "塞紧"
		else
			gag_action = "松开"
		to_chat(user, span_notice("你[gag_action]了马笼头的衔铁。"))
	update_bridle_state(user)

/obj/item/clothing/mask/bridle/proc/cycle_mode(mob/user)
	if(straps_locked)
		locked_message(user)
		return
	if(!blinders_enabled && !gag_enabled)
		set_mode(TRUE, FALSE, user)
		return
	if(blinders_enabled && !gag_enabled)
		set_mode(FALSE, TRUE, user)
		return
	if(!blinders_enabled && gag_enabled)
		set_mode(TRUE, TRUE, user)
		return
	set_mode(FALSE, FALSE, user)

/obj/item/clothing/mask/bridle/proc/set_mode(new_blinders, new_gag, mob/user, notify_wearer = TRUE)
	if(straps_locked)
		locked_message(user)
		return
	blinders_enabled = new_blinders
	gag_enabled = new_gag
	if(user)
		var/balloon_state
		if(blinders_enabled && gag_enabled)
			balloon_state = "眼罩 + 衔铁"
		else if(blinders_enabled)
			balloon_state = "眼罩"
		else if(gag_enabled)
			balloon_state = "衔铁"
		else
			balloon_state = "无"
		if(should_show_user_message(user))
			balloon_alert(user, "模式：[balloon_state]")
	if(should_show_user_message(user))
		var/state_text
		if(blinders_enabled && gag_enabled)
			state_text = "眼罩与衔铁"
		else if(blinders_enabled)
			state_text = "眼罩"
		else if(gag_enabled)
			state_text = "衔铁"
		else
			state_text = "无"
		to_chat(user, span_notice("马笼头已设为：[state_text]。"))
	update_bridle_state(user, notify_wearer)

/obj/item/clothing/mask/bridle/proc/strip_adjust(mob/living/carbon/wearer, mob/living/stripper)
	if(!wearer || !stripper)
		return
	if(straps_locked)
		locked_message(stripper)
		return
	if(wearer.get_item_by_slot(ITEM_SLOT_MASK) != src)
		return
	if(!stripper.Adjacent(wearer))
		wearer.balloon_alert(stripper, "够不着！")
		return
	if(!do_after(stripper, strip_adjust_delay, wearer))
		return
	var/old_blinders = blinders_enabled
	var/old_gag = gag_enabled
	var/new_blinders
	var/new_gag
	if(!blinders_enabled && !gag_enabled)
		new_blinders = TRUE
		new_gag = FALSE
	else if(blinders_enabled && !gag_enabled)
		new_blinders = FALSE
		new_gag = TRUE
	else if(!blinders_enabled && gag_enabled)
		new_blinders = TRUE
		new_gag = TRUE
	else
		new_blinders = FALSE
		new_gag = FALSE
	var/list/parts = list()
	if(old_blinders != new_blinders)
		parts += (new_blinders ? "放下马笼头的眼罩" : "抬起马笼头的眼罩")
	if(old_gag != new_gag)
		parts += (new_gag ? "塞紧马笼头的衔铁" : "松开马笼头的衔铁")
	var/action_text = parts.len ? jointext(parts, "，并") : "调整马笼头"
	to_chat(stripper, span_notice("你[action_text]。"))
	set_mode(new_blinders, new_gag, stripper, TRUE)

/datum/strippable_item/mob_item_slot/mask/get_alternate_actions(atom/source, mob/user, obj/item/item)
	. = ..()
	var/obj/item/clothing/mask/bridle/bridle = item
	if(!istype(bridle))
		return
	. += "adjust_bridle"

/datum/strippable_item/mob_item_slot/mask/perform_alternate_action(atom/source, mob/user, action_key, obj/item/item)
	if(!..())
		return
	var/obj/item/clothing/mask/bridle/bridle = item
	if(!istype(bridle))
		return
	if(action_key == "adjust_bridle")
		bridle.strip_adjust(source, user)

/obj/item/clothing/mask/bridle/proc/apply_gag(mob/living/carbon/wearer)
	if(!wearer || wearer.get_item_by_slot(ITEM_SLOT_MASK) != src)
		return
	UnregisterSignal(wearer, list(COMSIG_MOB_SAY, COMSIG_MOB_PRE_EMOTED))
	RegisterSignal(wearer, COMSIG_MOB_SAY, PROC_REF(muzzle_talk))
	RegisterSignal(wearer, COMSIG_MOB_PRE_EMOTED, PROC_REF(emote_override))

/obj/item/clothing/mask/bridle/proc/remove_gag(mob/living/carbon/wearer)
	if(!wearer)
		return
	UnregisterSignal(wearer, list(COMSIG_MOB_SAY, COMSIG_MOB_PRE_EMOTED))

/obj/item/clothing/mask/bridle/proc/emote_override(mob/living/source, key, params, type_override, intentional, datum/emote/emote)
	SIGNAL_HANDLER
	if(emote.muzzle_ignore)
		return NONE
	if(emote.key in list("snort", "neigh", "neigh2")) //Can still do horse emotes because DUH
		return NONE
	if(!emote.hands_use_check && (emote.emote_type & EMOTE_AUDIBLE))
		source.audible_message("发出一阵[pick("响亮", "细弱", "")]噪音。", audible_message_flags = EMOTE_MESSAGE|ALWAYS_SHOW_SELF_MESSAGE)
		return COMPONENT_CANT_EMOTE
	return NONE

/obj/item/clothing/mask/bridle/proc/muzzle_talk(datum/source, list/speech_args)
	SIGNAL_HANDLER
	if(HAS_TRAIT(source, TRAIT_SIGN_LANG))
		return
	var/spoken_message = speech_args[SPEECH_MESSAGE]
	if(spoken_message)
		var/list/words = splittext(spoken_message, " ")
		var/yell_suffix = copytext(spoken_message, findtext(spoken_message, "!"))
		spoken_message = ""

		for(var/ind = 1 to length(words))
			var/new_word = ""
			for(var/i = 1 to length(words[ind]) + rand(-1,1))
				new_word += "m"
			new_word += "f"
			words[ind] = yell_suffix ? uppertext(new_word) : new_word
		spoken_message = "[jointext(words, " ")][yell_suffix]"
	speech_args[SPEECH_MESSAGE] = spoken_message

/datum/action/item_action/bridle_toggle_blinders
	name = "切换眼罩"
	desc = "调节马笼头的眼罩。"

/datum/action/item_action/bridle_toggle_blinders/Trigger(trigger_flags)
	if(!..())
		return FALSE
	var/obj/item/clothing/mask/bridle/bridle = target
	if(istype(bridle))
		bridle.toggle_blinders(owner)

/datum/action/item_action/bridle_toggle_gag
	name = "切换衔铁"
	desc = "调节马笼头的衔铁。"

/datum/action/item_action/bridle_toggle_gag/Trigger(trigger_flags)
	if(!..())
		return FALSE
	var/obj/item/clothing/mask/bridle/bridle = target
	if(istype(bridle))
		bridle.toggle_gag(owner)
