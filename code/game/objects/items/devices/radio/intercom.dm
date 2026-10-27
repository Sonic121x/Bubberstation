/obj/item/radio/intercom //ICON OVERRIDDEN IN SKYRAT AESTHETICS - SEE MODULE
	name = "空间站对讲机"
	desc = "可靠的空间站对讲机，即使耳机全都沉默，也能随时派上用场。"
	icon = 'icons/obj/machines/wallmounts.dmi'
	icon_state = "intercom"
	anchored = TRUE
	w_class = WEIGHT_CLASS_BULKY
	canhear_range = 2
	dog_fashion = null
	unscrewed = FALSE
	item_flags = NO_BLOOD_ON_ITEM

	overlay_speaker_idle = "intercom_s"


	overlay_mic_idle = "intercom_m"
	overlay_mic_active = null

	///The icon of intercom while its turned off
	var/icon_off = "intercom-p"

/obj/item/radio/intercom/unscrewed
	unscrewed = TRUE

/obj/item/radio/intercom/prison
	name = "只收对讲机"
	desc = "空间站对讲机。看起来经过改装，无法发送广播。"
	icon_state = "intercom_prison"
	icon_off = "intercom_prison-p"

/obj/item/radio/intercom/prison/Initialize(mapload)
	. = ..()
	wires?.cut(WIRE_TX)

/obj/item/radio/intercom/Initialize(mapload)
	. = ..()
	var/area/current_area = get_area(src)
	if(!current_area)
		return
	RegisterSignal(current_area, COMSIG_AREA_POWER_CHANGE, PROC_REF(AreaPowerCheck))
	if(mapload)
		find_and_mount_on_atom()
	GLOB.intercoms_list += src

/obj/item/radio/intercom/Destroy()
	GLOB.intercoms_list -= src
	return ..()

/obj/item/radio/intercom/examine(mob/user)
	. = ..()
	. += span_notice("在附近使用[MODE_TOKEN_INTERCOM]即可通过它讲话。")
	if(!unscrewed)
		. += span_notice("它用<b>螺丝</b>固定在墙上。")
	else
		. += span_notice("固定在墙上的螺丝已经<i>松开</i>，可以将其<b>拆下</b>。")

	if(anonymize)
		. += span_notice("通过这台对讲机讲话会隐藏你的声音特征。")

	if(freqlock == RADIO_FREQENCY_UNLOCKED)
		if((obj_flags & EMAGGED) && initial(freqlock) == RADIO_FREQENCY_EMAGGABLE_LOCK)
			. += span_warning("它的频率锁已经短路……")
	else
		. += span_notice("其频率被锁定为[frequency/10]。")

	if(keylock == RADIO_KEYSLOT_UNLOCKED)
		if((obj_flags & EMAGGED) && initial(keylock) == RADIO_KEYSLOT_EMAGGABLE_LOCK)
			. += span_warning("其密钥槽的防拆螺丝已经被撬开……")
	else
		. += span_notice("密钥槽的螺丝[keylock == RADIO_KEYSLOT_LOCKED ? "已经滑丝" : "拧得很紧"]，\
			[keylock == RADIO_KEYSLOT_LOCKED ? "无法取出加密密钥" : "没有磁性工具就无法取出加密密钥"]。")

/obj/item/radio/intercom/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(held_item?.tool_behaviour == TOOL_SCREWDRIVER)
		context[SCREENTIP_CONTEXT_RMB] = unscrewed ? "固定到墙上" : "拧松墙上固定螺丝"
		context[SCREENTIP_CONTEXT_LMB] = isnull(keyslot) ? context[SCREENTIP_CONTEXT_RMB] : "移除加密密钥" // sometimes same behavior
		. = CONTEXTUAL_SCREENTIP_SET

	if(held_item?.tool_behaviour == TOOL_WRENCH && unscrewed)
		context[SCREENTIP_CONTEXT_RMB] = "从墙上拆下"
		context[SCREENTIP_CONTEXT_LMB] = context[SCREENTIP_CONTEXT_LMB] // same behavior
		. = CONTEXTUAL_SCREENTIP_SET

/obj/item/radio/intercom/screwdriver_act_secondary(mob/living/user, obj/item/tool)
	if(unscrewed)
		user.visible_message(span_notice("[user]开始拧紧[src]的螺丝……"), span_notice("你开始拧紧[src]的螺丝……"))
		if(tool.use_tool(src, user, 30, volume=50))
			user.visible_message(span_notice("[user]拧紧了[src]的螺丝！"), span_notice("你拧紧了[src]的螺丝。"))
			unscrewed = FALSE
			update_appearance(UPDATE_OVERLAYS)
	else
		user.visible_message(span_notice("[user]开始拧松[src]的螺丝……"), span_notice("你开始拧松[src]的螺丝……"))
		if(tool.use_tool(src, user, 40, volume=50))
			user.visible_message(span_notice("[user]拧松了[src]的螺丝！"), span_notice("你拧松[src]的螺丝，使它与墙面松脱。"))
			unscrewed = TRUE
			update_appearance(UPDATE_OVERLAYS)
	return ITEM_INTERACT_SUCCESS

/obj/item/radio/intercom/screwdriver_act(mob/living/user, obj/item/tool)
	if(isnull(keyslot))
		return screwdriver_act_secondary(user, tool)
	return ..()

/obj/item/radio/intercom/wrench_act(mob/living/user, obj/item/tool)
	if(!unscrewed)
		to_chat(user, span_warning("你需要先拧松[src]与墙面连接的螺丝！"))
		return ITEM_INTERACT_BLOCKING
	user.visible_message(span_notice("[user]开始拆卸[src]……"), span_notice("你开始拆卸[src]……"))
	tool.play_tool_sound(src)
	if(tool.use_tool(src, user, 80))
		user.visible_message(span_notice("[user]拆下了[src]！"), span_notice("你从墙上拆下了[src]。"))
		playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
		deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/radio/intercom/wrench_act_secondary(mob/living/user, obj/item/tool)
	return wrench_act(user, tool)

/**
 * Override attack_tk_grab instead of attack_tk because we actually want attack_tk's
 * functionality. What we DON'T want is attack_tk_grab attempting to pick up the
 * intercom as if it was an ordinary item.
 */
/obj/item/radio/intercom/attack_tk_grab(mob/user)
	interact(user)
	return COMPONENT_CANCEL_ATTACK_CHAIN


/obj/item/radio/intercom/attack_ai(mob/user)
	interact(user)

/obj/item/radio/intercom/attack_robot(mob/user)
	interact(user)

/obj/item/radio/intercom/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	interact(user)

/obj/item/radio/intercom/ui_state(mob/user)
	return GLOB.default_state

/obj/item/radio/intercom/can_receive(freq, list/levels)
	if(levels != RADIO_NO_Z_LEVEL_RESTRICTION)
		var/turf/position = get_turf(src)
		if(isnull(position) || !(position.z in levels))
			return FALSE

	if(freq == FREQ_SYNDICATE)
		if(!(special_channels &= RADIO_SPECIAL_SYNDIE))
			return FALSE//Prevents broadcast of messages over devices lacking the encryption

	return TRUE

/obj/item/radio/intercom/Hear(atom/movable/speaker, message_langs, raw_message, radio_freq, radio_freq_name, radio_freq_color, list/spans, list/message_mods = list(), message_range)
	if(message_mods[RADIO_EXTENSION] == MODE_INTERCOM)
		return  // Avoid hearing the same thing twice
	return ..()

/obj/item/radio/intercom/emp_act(severity)
	. = ..() // Parent call here will set `on` to FALSE.
	update_appearance()

/obj/item/radio/intercom/end_emp_effect(curremp)
	. = ..()
	AreaPowerCheck() // Make sure the area/local APC is powered first before we actually turn back on.

/obj/item/radio/intercom/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()

	if(obj_flags & EMAGGED)
		return .

	if(!freqlock && !keylock)
		balloon_alert(user, "没有可以破坏的锁！")
		return .

	var/message = ""
	if(freqlock == RADIO_FREQENCY_EMAGGABLE_LOCK && keylock == RADIO_KEYSLOT_EMAGGABLE_LOCK)
		message = "频率锁和密钥锁"
	else if(freqlock == RADIO_FREQENCY_EMAGGABLE_LOCK)
		message = "频率锁"
	else if(keylock == RADIO_KEYSLOT_EMAGGABLE_LOCK)
		message = "密钥锁"

	if(!message)
		balloon_alert(user, "无法破坏锁！")
		playsound(src, 'sound/machines/buzz/buzz-two.ogg', 50, FALSE, SILENCED_SOUND_EXTRARANGE)
		return .

	balloon_alert(user, "[message]已破坏")
	playsound(src, SFX_SPARKS, 75, TRUE, SILENCED_SOUND_EXTRARANGE)
	if(freqlock == RADIO_FREQENCY_EMAGGABLE_LOCK)
		freqlock = RADIO_FREQENCY_UNLOCKED
	if(keylock == RADIO_KEYSLOT_EMAGGABLE_LOCK)
		keylock = RADIO_KEYSLOT_UNLOCKED
	obj_flags |= EMAGGED
	return TRUE

/obj/item/radio/intercom/update_icon_state()
	icon_state = on ? initial(icon_state) : icon_off
	return ..()

/**
 * Proc called whenever the intercom's area loses or gains power. Responsible for setting the `on` variable and calling `update_icon()`.
 *
 * Normally called after the intercom's area receives the `COMSIG_AREA_POWER_CHANGE` signal, but it can also be called directly.
 * Arguments:
 * * source - the area that just had a power change.
 */
/obj/item/radio/intercom/proc/AreaPowerCheck(datum/source)
	SIGNAL_HANDLER
	var/area/current_area = get_area(src)
	if(!current_area)
		set_on(FALSE)
	else
		set_on(current_area.powered(AREA_USAGE_EQUIP)) // set "on" to the equipment power status of our area.
	update_appearance()

/**
 * Called by the wall mount component and reused during the tool deconstruction proc.
 */
/obj/item/radio/intercom/atom_deconstruct(disassembled)
	new/obj/item/wallframe/intercom(get_turf(src))

//Created through the autolathe or through deconstructing intercoms. Can be applied to wall to make a new intercom on it!
/obj/item/wallframe/intercom
	name = "对讲机框架"
	desc = "准备就绪的对讲机。贴到墙上拧紧螺丝就能用！"
	icon = 'icons/obj/machines/wallmounts.dmi'
	icon_state = "intercom"
	result_path = /obj/item/radio/intercom/unscrewed
	pixel_shift = 26
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

// Used in the confessional booth in the chapel, locked to the confessional frequency and hides voices
/obj/item/radio/intercom/chapel
	name = "忏悔室对讲机"
	desc = "对着它诉说……忏悔你犯下的诸多罪过。它会隐藏你的声音，替你保密。"
	anonymize = TRUE
	freqlock = RADIO_FREQENCY_EMAGGABLE_LOCK

/obj/item/radio/intercom/chapel/Initialize(mapload)
	. = ..()
	set_frequency(FREQ_CONFESSIONAL)
	set_broadcasting(TRUE)

// Special type of intercom for use in the bridge that can tune into any frequency and has loudmic (NOT FOR PUBLIC AREAS)
/obj/item/radio/intercom/command
	name = "指挥对讲机"
	desc = "指挥部专用的自由调频对讲机。可调至任意频率，让你接入原本无权使用的频道。内置语音放大器，让通讯清晰响亮。"
	icon_state = "intercom_command"
	freerange = TRUE
	command = TRUE
	icon_off = "intercom_command-p"

// Set of intercoms for use in interrogation. Interior one starts broadcasting, exterior one hides voices.
/obj/item/radio/intercom/interrogation
	name = "审讯对讲机"
	abstract_type = /obj/item/radio/intercom/interrogation
	freqlock = RADIO_FREQENCY_LOCKED

/obj/item/radio/intercom/interrogation/Initialize(mapload)
	. = ..()
	set_frequency(FREQ_INTERROGATION)

/obj/item/radio/intercom/interrogation/inside
	desc = "将正在进行的审讯广播给某个大概正在做笔录之人的对讲机。"

/obj/item/radio/intercom/interrogation/inside/Initialize(mapload)
	. = ..()
	set_broadcasting(TRUE)
	set_listening(FALSE)

/obj/item/radio/intercom/interrogation/outside
	desc = "可与审讯室内通话的对讲机，会扰乱声音来保护‘隐私’。"
	anonymize = TRUE

// Subtype that simply has freerange enabled
/obj/item/radio/intercom/freerange
	name = "全频对讲机"
	desc = "可绕过加密，调至任意频率的特殊对讲机。"
	freerange = TRUE

// For use in the AI core to allow the AI to tune into any encrypted frequency if comms are down
/obj/item/radio/intercom/freerange/ai_core
	name = "\improper AI全频对讲机"

/obj/item/radio/intercom/freerange/ai_core/Initialize(mapload)
	. = ..()
	set_listening(FALSE)

// Intercom with loudmic and innate syndicate channel access
/obj/item/radio/intercom/syndicate
	name = "辛迪加对讲机"
	desc = "用它放狠话。"
	icon_state = "intercom_syndicate"
	command = TRUE
	icon_off = "intercom_syndicate-p"
	special_channels = RADIO_SPECIAL_SYNDIE

// Syndicate intercom that also has freefrange on top of syndicate channel
/obj/item/radio/intercom/syndicate/freerange
	name = "辛迪加宽频对讲机"
	desc = "辛迪加配发的定制对讲机，可在所有纳米传讯频率上发送通讯。价格极其昂贵。"
	freerange = TRUE

/obj/item/radio/intercom/mi13
	name = "对讲机"
	desc = "通过它与同处这座设施的人交谈。"
	freerange = TRUE

/obj/item/radio/intercom/ai_private
	name = "\improper AI专线对讲机"
	desc = "主要用于通过专线直接联系空间站AI的对讲机。"

/obj/item/radio/intercom/ai_private/Initialize(mapload)
	. = ..()
	set_frequency(FREQ_AI_PRIVATE)

// For use in AI uploads: Tuned to AI private, actively broadcasting and relaying
/obj/item/radio/intercom/ai_private/broadcasting

/obj/item/radio/intercom/ai_private/broadcasting/Initialize(mapload)
	. = ..()
	set_broadcasting(TRUE)

// For use in AI chambers: Tuned to AI private, free-range allowed, otherwise doesn't broadcast or relay
/obj/item/radio/intercom/ai_private/freerange
	desc = parent_type::desc + "此款可绕过加密，调至任意频率。"
	freerange = TRUE

/obj/item/radio/intercom/ai_private/freerange/Initialize(mapload)
	. = ..()
	set_listening(FALSE)

// For use in AI antechambers: Tuned to AI private, actively broadcasting, but not relaying
/obj/item/radio/intercom/ai_private/quiet

/obj/item/radio/intercom/ai_private/quiet/Initialize(mapload)
	. = ..()
	set_listening(FALSE)

// Subtype that spawns with an encryption key and has a key lock
/obj/item/radio/intercom/departmental
	desc = "主要用于与部门成员通话的空间站对讲机。"
	keylock = RADIO_KEYSLOT_EMAGGABLE_LOCK
	abstract_type = /obj/item/radio/intercom/departmental
	var/stripe_color = null

/obj/item/radio/intercom/departmental/Initialize(mapload)
	. = ..()
	if(length(keyslot?.channels) >= 1)
		set_frequency(GLOB.default_radio_channels[keyslot.channels[1]])

/obj/item/radio/intercom/departmental/update_overlays()
	. = ..()
	if(!stripe_color)
		return
	var/mutable_appearance/stripe = mutable_appearance(icon, "intercom_stripe")
	stripe.color = stripe_color
	. += stripe

/obj/item/radio/intercom/departmental/cargo
	name = "货运对讲机"
	keyslot = /obj/item/encryptionkey/headset_cargo
	stripe_color = "#956929"

/obj/item/radio/intercom/departmental/command
	name = "指挥对讲机"
	keyslot = /obj/item/encryptionkey/headset_com
	stripe_color = "#486091"

/obj/item/radio/intercom/departmental/engineering
	name = "工程对讲机"
	keyslot = /obj/item/encryptionkey/headset_eng
	stripe_color = "#EFB341"

/obj/item/radio/intercom/departmental/medical
	name = "医疗对讲机"
	keyslot = /obj/item/encryptionkey/headset_med
	stripe_color = "#52B4E9"

/obj/item/radio/intercom/departmental/science
	name = "科研对讲机"
	keyslot = /obj/item/encryptionkey/headset_sci
	stripe_color = "#D381C9"

/obj/item/radio/intercom/departmental/security
	name = "安保对讲机"
	keyslot = /obj/item/encryptionkey/headset_sec
	stripe_color = "#DE3A3A"

/obj/item/radio/intercom/departmental/service
	name = "服务对讲机"
	keyslot = /obj/item/encryptionkey/headset_service
	stripe_color = "#83ca41"

// Heads of staff variants
/obj/item/radio/intercom/departmental/head
	icon_state = "intercom_command"
	command = TRUE

/obj/item/radio/intercom/departmental/head/ce
	name = "\proper 总工程师对讲机"
	keyslot = /obj/item/encryptionkey/heads/ce
	stripe_color = "#EFB341"

/obj/item/radio/intercom/departmental/head/cmo
	name = "\proper 首席医疗官对讲机"
	keyslot = /obj/item/encryptionkey/heads/cmo
	stripe_color = "#52B4E9"

/obj/item/radio/intercom/departmental/head/hop
	name = "\proper 人事主管对讲机"
	keyslot = /obj/item/encryptionkey/heads/hop
	stripe_color = "#83ca41"

/obj/item/radio/intercom/departmental/head/hos
	name = "\proper 安保主管对讲机"
	keyslot = /obj/item/encryptionkey/heads/hos
	stripe_color = "#DE3A3A"

/obj/item/radio/intercom/departmental/head/qm
	name = "\proper 货运主管对讲机"
	keyslot = /obj/item/encryptionkey/heads/qm
	stripe_color = "#956929"

/obj/item/radio/intercom/departmental/head/rd
	name = "\proper 科研主管对讲机"
	keyslot = /obj/item/encryptionkey/heads/rd
	stripe_color = "#D381C9"

#define INTERCOM_OFFSET 27

MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/prison, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/chapel, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/ai_private, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/ai_private/broadcasting, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/ai_private/freerange, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/ai_private/quiet, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/command, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/interrogation/inside, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/interrogation/outside, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/freerange, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/freerange/ai_core, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/syndicate, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/syndicate/freerange, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/mi13, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/departmental/cargo, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/departmental/command, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/departmental/engineering, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/departmental/medical, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/departmental/science, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/departmental/security, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/departmental/service, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/departmental/head/ce, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/departmental/head/cmo, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/departmental/head/hop, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/departmental/head/hos, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/departmental/head/qm, INTERCOM_OFFSET)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/departmental/head/rd, INTERCOM_OFFSET)

#undef INTERCOM_OFFSET
