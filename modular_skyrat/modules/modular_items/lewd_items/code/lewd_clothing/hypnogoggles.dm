/obj/item/clothing/glasses/hypno
	name = "催眠护目镜"
	desc = "哇——哦……这可真够淫靡的。"
	icon_state = "hypnogoggles_pink"
	base_icon_state = "hypnogoggles"
	inhand_icon_state = "hypnogoggles_pink"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_eyes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_eyes.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	/// If the color of the goggles have been changed before.
	var/color_changed = FALSE
	/// Current color of the goggles, can change and affects sprite
	var/current_hypnogoggles_color = "pink"
	/// Static list of all goggle designs, used in the color picker radial selection menu
	var/static/list/hypnogoggles_designs
	/// The person wearing the goggles
	var/mob/living/carbon/human/victim
	/// The hypnotic codephrase. Default always required otherwise things break.
	var/codephrase = "服从。"

/obj/item/clothing/glasses/hypno/equipped(mob/user, slot)//Adding hypnosis on equip
	. = ..()
	victim = user
	if(!(slot & ITEM_SLOT_EYES))
		return
	if(!(iscarbon(victim) && victim.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy) && victim.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis)))
		return
	if(codephrase != "")
		victim.gain_trauma(new /datum/brain_trauma/very_special/induced_hypnosis(codephrase), TRAUMA_RESILIENCE_MAGIC)
	else
		codephrase = "服从。"
		victim.gain_trauma(new /datum/brain_trauma/very_special/induced_hypnosis(codephrase), TRAUMA_RESILIENCE_MAGIC)

/obj/item/clothing/glasses/hypno/dropped(mob/user)//Removing hypnosis on unequip
	. = ..()
	if(!victim) //prevents a runtime where it tries to unequip from a nonexistent victim
		return
	if(!(victim.glasses == src))
		return
	victim.cure_trauma_type(/datum/brain_trauma/very_special/induced_hypnosis, TRAUMA_RESILIENCE_MAGIC)
	victim = null

/obj/item/clothing/glasses/hypno/Destroy()
	if(!victim)
		return ..()
	if(!(victim.glasses == src))
		return ..()
	victim.cure_trauma_type(/datum/brain_trauma/very_special/induced_hypnosis, TRAUMA_RESILIENCE_MAGIC)
	. = ..()

/obj/item/clothing/glasses/hypno/attack_self(mob/user)//Setting up hypnotising phrase
	. = ..()
	codephrase = tgui_input_text(user, "修改催眠语句", max_length = MAX_MESSAGE_LEN)

/// Populates the list of hypnogoggle designs to pick from, called on init
/obj/item/clothing/glasses/hypno/proc/populate_hypnogoggles_designs()
	hypnogoggles_designs = list(
		"pink" = image (icon = src.icon, icon_state = "hypnogoggles_pink"),
		"teal" = image(icon = src.icon, icon_state = "hypnogoggles_teal"))

//to change model
/obj/item/clothing/glasses/hypno/click_alt(mob/user)
	if(color_changed)
		return CLICK_ACTION_BLOCKING
	var/choice = show_radial_menu(user, src, hypnogoggles_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!choice)
		return CLICK_ACTION_BLOCKING
	current_hypnogoggles_color = choice
	update_icon()
	color_changed = TRUE
	return CLICK_ACTION_SUCCESS

//to check if we can change kinkphones's model
/obj/item/clothing/glasses/hypno/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/obj/item/clothing/glasses/hypno/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	update_icon_state()
	update_icon()
	if(!length(hypnogoggles_designs))
		populate_hypnogoggles_designs()

/obj/item/clothing/glasses/hypno/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_hypnogoggles_color]"
	inhand_icon_state = "[base_icon_state]_[current_hypnogoggles_color]"

/datum/brain_trauma/very_special/induced_hypnosis
	name = "催眠"
	desc = "患者的潜意识被某个词或句子完全俘获。似乎是由其佩戴的某件物品所诱发。"
	scan_desc = "癫痫诱发的循环思维模式"
	gain_text = ""
	lose_text = ""
	resilience = TRAUMA_RESILIENCE_BASIC

	var/hypnotic_phrase = ""
	var/regex/target_phrase

/datum/brain_trauma/very_special/induced_hypnosis/New(phrase)
	if(!phrase)
		qdel(src)
		return
	hypnotic_phrase = phrase
	try
		target_phrase = new("(\\b[REGEX_QUOTE(hypnotic_phrase)]\\b)", "ig")
	catch(var/exception/caught_exception)
		stack_trace("[caught_exception] on [caught_exception.file]:[caught_exception.line]")
		qdel(src)
	return ..()

/datum/brain_trauma/very_special/induced_hypnosis/on_gain()
	log_game("[key_name(owner)] 被催眠护目镜催眠了。")
	to_chat(owner, "<span class = 'reallybig hypnophrase'>[hypnotic_phrase]</span>")
	to_chat(owner, span_notice(pick("你感觉自己的思绪正集中在这句话上……你似乎没法把它从脑子里赶出去。",
									"你的头很痛，但你能想到的全是这句话。它一定极其重要。",
									"你感觉自己脑海的一部分在反复重复这句话。你必须遵从这些话语。",
									"不知为何，这句话听起来……很正确。你觉得自己应该遵从这些话语。",
									"这些话语在你脑中不断回响。你发现自己被它们彻底迷住了。")))
	to_chat(owner, span_boldwarning("你被这句话催眠了。你必须遵从这些话语。如果它并非明确的命令，你可以自由地理解该如何执行，只要你把这句话当作最高优先级来行动即可。"))
	var/atom/movable/screen/alert/hypnosis/hypno_alert = owner.throw_alert("hypnosis", /atom/movable/screen/alert/hypnosis)
	hypno_alert.desc = "“[hypnotic_phrase]”……你的思绪似乎被这个概念牢牢占据了。"
	return ..()

/datum/brain_trauma/very_special/induced_hypnosis/on_lose()
	log_game("[key_name(owner)] 不再处于催眠护目镜的影响下。")
	to_chat(owner, span_userdanger("你突然从催眠中清醒过来。那句“[hypnotic_phrase]”对你来说不再重要了。"))
	owner.clear_alert("hypnosis")
	..()

/datum/brain_trauma/very_special/induced_hypnosis/on_life(seconds_per_tick, times_fired)
	..()
	if(!(SPT_PROB(1, seconds_per_tick)))
		return
	switch(rand(1, 2))
		if(1)
			to_chat(owner, span_hypnophrase("<i>...[LOWER_TEXT(hypnotic_phrase)]...</i>"))
		if(2)
			new /datum/hallucination/chat(owner, TRUE, FALSE, span_hypnophrase("[hypnotic_phrase]"))

/datum/brain_trauma/very_special/induced_hypnosis/handle_hearing(datum/source, list/hearing_args)
	if((HAS_TRAIT(owner, TRAIT_DEAF)) || owner == hearing_args[HEARING_SPEAKER])
		return

	hearing_args[HEARING_RAW_MESSAGE] = target_phrase.Replace(hearing_args[HEARING_RAW_MESSAGE], span_hypnophrase("$1"))
