/obj/item/clothing/mask/gas
	flags_inv = HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/mask/gas/welding
	flags_inv = HIDEEYES|HIDEFACE|HIDESNOUT

/obj/item/clothing/mask/gas/modulator
	name = "改装防毒面具"
	desc = "一款旧型号防毒面具，配发给站内人员以抵御空气传播的危险。这一副似乎经过 \
		大幅改装，滤毒组件已被替换为变声器，让佩戴者听起来更像机器人。"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	max_filters = 0
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.55, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	///Our SPEAKING name while our voice is cloaked. Defaults to "Unknown", but can be set by var editing.
	var/modulated_name = "未知"
	///Used to store a special name if they wearer has one before equipping the mask.
	var/previous_special_name = null
	///If we are actually using the voice changer or not
	var/modulate_voice = TRUE

/obj/item/clothing/mask/gas/modulator/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/clothing/mask/gas/modulator/examine(mob/user)
	. = ..()
	. += span_notice("它的变声器目前处于[modulate_voice ? "启用" : "停用"]状态。<b>Alt-点击</b>可切换。")

/obj/item/clothing/mask/gas/modulator/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你凑近端详[src]，注意到语音分析模块侧面有一张警告标签…… \
		“请清晰、准确地咬字发音，设备才能正常工作。”</i>")

/obj/item/clothing/mask/gas/modulator/click_alt(mob/user)
	modulate_voice = !modulate_voice
	balloon_alert(user, "变声器已[modulate_voice ? "启用":"停用"]")
	update_voice(user)

	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/gas/modulator/equipped(mob/user, slot)
	. = ..()
	if ((slot & ITEM_SLOT_MASK))
		RegisterSignal(user, COMSIG_MOB_SAY, PROC_REF(handle_speech))
		RegisterSignal(user, SIGNAL_ADDTRAIT(TRAIT_SIGN_LANG), PROC_REF(update_voice))
		RegisterSignal(user, SIGNAL_REMOVETRAIT(TRAIT_SIGN_LANG), PROC_REF(update_voice))
	else
		UnregisterSignal(user, list(COMSIG_MOB_SAY, SIGNAL_ADDTRAIT(TRAIT_SIGN_LANG), SIGNAL_REMOVETRAIT(TRAIT_SIGN_LANG)))

	update_voice(user)

/obj/item/clothing/mask/gas/modulator/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, list(COMSIG_MOB_SAY, SIGNAL_ADDTRAIT(TRAIT_SIGN_LANG), SIGNAL_REMOVETRAIT(TRAIT_SIGN_LANG)))
	update_voice(user)

/obj/item/clothing/mask/gas/modulator/doStrip(mob/stripper, mob/user)
	. = ..()
	UnregisterSignal(user, list(COMSIG_MOB_SAY, SIGNAL_ADDTRAIT(TRAIT_SIGN_LANG), SIGNAL_REMOVETRAIT(TRAIT_SIGN_LANG)))
	update_voice(user)

/obj/item/clothing/mask/gas/modulator/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_LMB] = "[modulate_voice ? "停用":"启用"]变声器"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/clothing/mask/gas/modulator/proc/update_voice(mob/user)
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/human_user = user
	var/obj/item/organ/tongue/user_tongue = human_user.get_organ_slot(ORGAN_SLOT_TONGUE)

	if(!user_tongue)
		return

	if(HAS_TRAIT(human_user, TRAIT_SIGN_LANG))
		user_tongue.temp_say_mod = "打手语"
		human_user.override_voice = previous_special_name
		previous_special_name = null
		return

	if(human_user.override_voice != modulated_name)
		previous_special_name = human_user.override_voice

	if(human_user.wear_mask == src && modulate_voice)
		human_user.override_voice = modulated_name
		user_tongue.temp_say_mod = "说道"
		return

	human_user.override_voice = previous_special_name
	user_tongue.temp_say_mod = initial(user_tongue.temp_say_mod)
	previous_special_name = null

/obj/item/clothing/mask/gas/modulator/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	if (!modulate_voice || HAS_TRAIT(source, TRAIT_SIGN_LANG))
		return

	speech_args[SPEECH_SPANS] |= SPAN_ROBOT

/obj/item/clothing/mask/gas/sechailer
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/mask/mask_teshari.dmi'
