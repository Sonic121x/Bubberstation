#define AI_CORE_BRAIN(X) X.braintype == "Android" ? "大脑" : "人机接口"

/obj/structure/ai_core
	name = "\improper AI 核心"
	desc = "人工智能核心的框架。"
	icon = 'icons/mob/silicon/ai.dmi'
	icon_state = "build_0"
	base_icon_state = "build_"
	density = TRUE
	anchored = FALSE
	max_integrity = 500
	custom_materials = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 4)
	var/state = CORE_STATE_EMPTY
	var/obj/item/circuitboard/aicore/circuit
	var/obj/item/brain_processor/core_mmi
	/// Weakref to an ai module rack, if present we will try to link new AI to it instead of the station core
	var/datum/weakref/default_link_ref

/obj/structure/ai_core/Initialize(mapload, state = src.state, obj/item/brain_processor/core_mmi = null)
	. = ..()
	if(core_mmi && state < CORE_STATE_CABLED)
		stack_trace("supplied a core_mmi as constructor argument, but core state wouldn't have accepted it!")
		state = CORE_STATE_FINISHED // just in case...
	src.state = state
	if(state >= CORE_STATE_CIRCUIT)
		circuit = new(src)
	if(state >= CORE_STATE_CABLED)
		core_mmi ||= new /obj/item/brain_processor/organic(src, new /obj/item/organ/brain())
		core_mmi.forceMove(src)
		src.core_mmi = core_mmi
		set_anchored(TRUE)

	update_appearance(UPDATE_ICON_STATE)

/obj/structure/ai_core/update_icon_state()
	cut_overlays()

	if(state != CORE_STATE_FINISHED)
		icon_state = "[base_icon_state][state]"
		if(state == CORE_STATE_CABLED && core_mmi)
			icon_state += "b"
	else

		icon_state = "ai-core"

		var/mutable_appearance/screen = mutable_appearance(icon, "ai-empty")
		screen.layer = FLOAT_LAYER
		screen.appearance_flags = RESET_COLOR | KEEP_APART

		add_overlay(screen)

		add_overlay(emissive_appearance(icon, "ai-empty", src, alpha = 255))

		set_light(0.2, 0.2, LIGHT_COLOR_FAINT_CYAN)

	return ..()

/obj/structure/ai_core/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == circuit)
		circuit = null
		if((state != CORE_STATE_GLASSED) && (state != CORE_STATE_FINISHED))
			state = CORE_STATE_EMPTY
			update_appearance()
	if(gone == core_mmi)
		core_mmi = null
		update_appearance()

/obj/structure/ai_core/atom_deconstruct(disassembled = TRUE)
	if(state >= CORE_STATE_GLASSED)
		new /obj/item/stack/sheet/rglass(drop_location(), 2)
	if(state >= CORE_STATE_CABLED)
		new /obj/item/stack/cable_coil(drop_location(), 5)
	core_mmi?.forceMove(drop_location())
	circuit?.forceMove(drop_location())
	new /obj/item/stack/sheet/plasteel(drop_location(), 4)

/obj/structure/ai_core/Destroy()
	QDEL_NULL(circuit)
	QDEL_NULL(core_mmi)
	return ..()

/obj/structure/ai_core/examine(mob/user)
	. = ..()
	. += span_notice("它的<b>螺栓</b>看起来已[anchored ? "拧紧" : "松开"]。")
	. += span_notice("将此核心保存到多功能工具的缓冲区，再上传到模块架，即可在首次启动时自动连接。\
		否则，它会连接到[is_station_level(z) ? "空间站的核心模块架，或" : ""]找到的第一个模块架。")

	switch(state)
		if(CORE_STATE_EMPTY)
			. += span_notice("这里有一个电路板<b>插槽</b>，框架可以<b>熔解</b>。")
		if(CORE_STATE_CIRCUIT)
			. += span_notice("电路板可以用<b>螺丝固定</b>，也可以<b>撬出</b>。")
		if(CORE_STATE_SCREWED)
			. += span_notice("框架可以<b>布线</b>，电路板可以<b>松开</b>。")
		if(CORE_STATE_CABLED)
			if(core_mmi)
				. += span_notice("这里有一个强化玻璃面板<b>插槽</b>，[AI_CORE_BRAIN(core_mmi)]可以<b>撬出</b>。")
			else
				. += span_notice("这里的导线可以连接<b>人机接口或正电子脑</b>，也可以<b>剪断</b>。")
		if(CORE_STATE_GLASSED)
			. += span_notice("显示器[(core_mmi?.brainmob?.mind && !suicide_check()) ? "和神经接口" : ""]可以用<b>螺丝固定</b>，面板可以<b>撬出</b>。")
		if(CORE_STATE_FINISHED)
			. += span_notice("显示器的连接可以<b>剪断</b>[(core_mmi?.brainmob?.mind && !suicide_check()) ? "，神经接口可以用<b>螺丝固定</b>。" : "。"]")

/obj/structure/ai_core/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(state < CORE_STATE_FINISHED)
		return construction_item_interaction(user, tool, modifiers)

	return NONE

/// Exists to be used for callbacks.
/obj/structure/ai_core/proc/check_state(state_to_check)
	return (state == state_to_check)

/obj/structure/ai_core/latejoin_inactive
	name = "联网 AI 核心"
	desc = "此 AI 核心通过蓝空间发射器连接至 NTNet，可在班次中随时下载 AI 人格。"
	anchored = TRUE
	state = CORE_STATE_FINISHED
	var/available = TRUE
	var/safety_checks = TRUE
	var/active = TRUE

/obj/structure/ai_core/latejoin_inactive/Initialize(mapload, state, posibrain)
	. = ..()
	GLOB.latejoin_ai_cores += src

/obj/structure/ai_core/latejoin_inactive/Destroy()
	GLOB.latejoin_ai_cores -= src
	return ..()

/obj/structure/ai_core/latejoin_inactive/examine(mob/user)
	. = ..()
	. += span_info("它的发射器似乎已<b>[active? "开启" : "关闭"]</b>。")
	. += span_notice("你可以拿着多功能工具[EXAMINE_HINT("右键点击")]来[active ? "停用" : "启用"]它。")

/obj/structure/ai_core/latejoin_inactive/proc/is_available() //If people still manage to use this feature to spawn-kill AI latejoins ahelp them.
	if(!available)
		return FALSE
	if(!safety_checks)
		return TRUE
	if(!active)
		return FALSE
	var/turf/ai_turf = get_turf(src)
	var/area/ai_area = get_area(src)
	if(!(ai_area.area_flags & BLOBS_ALLOWED))
		return FALSE
	if(!ai_area.power_equip)
		return FALSE
	if(!SSmapping.level_trait(ai_turf.z, ZTRAIT_STATION))
		return FALSE
	if(!isfloorturf(ai_turf))
		if(locate(/obj/structure/transport/linear) in ai_turf.contents) // carveout for maps that have the AI core on a lift platform.
			return TRUE
		return FALSE
	return TRUE

/obj/structure/ai_core/latejoin_inactive/multitool_act_secondary(mob/living/user, obj/item/tool)
	if(!tool.use_tool(src, user, 0 SECONDS, 0, 50))
		return ITEM_INTERACT_BLOCKING

	active = !active
	balloon_alert(user, "已[active ? "启用" : "停用"]发射器")
	return ITEM_INTERACT_SUCCESS

/obj/structure/ai_core/multitool_act(mob/living/user, obj/item/multitool/tool)
	tool.play_tool_sound(src, 50)
	tool.set_buffer(src)
	balloon_alert(user, "核心已保存至缓冲区")
	return ITEM_INTERACT_SUCCESS

/obj/structure/ai_core/proc/ai_structure_to_mob()
	var/mob/living/brain/the_brainmob = core_mmi.brainmob
	if(!the_brainmob.mind || suicide_check())
		return FALSE
	the_brainmob.mind.remove_antags_for_borging()
	if(!the_brainmob.mind.has_ever_been_ai)
		SSblackbox.record_feedback("amount", "ais_created", 1)

	var/mob/living/silicon/ai/ai_mob = new(loc, the_brainmob, core_mmi.laws, default_link_ref?.resolve())

	ai_mob.posibrain_inside = core_mmi.braintype == "Android"
	deadchat_broadcast("已在<b>[chinese_area_display(get_area_name(ai_mob, format_text = TRUE))]</b>上线。", span_name("[ai_mob]"), follow_target = ai_mob, message_type = DEADCHAT_ANNOUNCEMENT)
	qdel(src)
	return ai_mob

/// Quick proc to call to see if the brainmob inside of us has suicided. Returns TRUE if we have, FALSE in any other scenario.
/obj/structure/ai_core/proc/suicide_check()
	if(isnull(core_mmi) || isnull(core_mmi.brainmob))
		return FALSE
	return HAS_TRAIT(core_mmi.brainmob, TRAIT_SUICIDED)

/*
This is a good place for AI-related object verbs so I'm sticking it here.
If adding stuff to this, don't forget that an AI need to cancel_camera() whenever it physically moves to a different location.
That prevents a few funky behaviors.
*/
//The type of interaction, the player performing the operation, the AI itself, and the card object, if any.


/atom/proc/transfer_ai(interaction, mob/user, mob/living/silicon/ai/AI, obj/item/aicard/card)
	SHOULD_CALL_PARENT(TRUE)
	if(istype(card))
		if(card.flush)
			to_chat(user, span_alert("错误：AI 清除正在进行，无法执行传输协议。"))
			return FALSE
	return TRUE

/obj/structure/ai_core/transfer_ai(interaction, mob/user, mob/living/silicon/ai/AI, obj/item/aicard/card)
	if(state != CORE_STATE_FINISHED || !..())
		return
	if(core_mmi && core_mmi.brainmob)
		if(core_mmi.brainmob.mind)
			to_chat(user, span_warning("[src]内已有活跃心智！"))
			return
		else if(suicide_check())
			to_chat(user, span_warning("[src]中安装的[AI_CORE_BRAIN(core_mmi)]完全无法使用！"))
			return
	//Transferring a carded AI to a core.
	if(interaction == AI_TRANS_FROM_CARD)
		AI.set_control_disabled(FALSE)
		AI.radio_enabled = TRUE
		AI.forceMove(loc) // to replace the terminal.
		to_chat(AI, span_notice("你已上传至固定终端。远程设备连接已恢复。"))
		to_chat(user, "[span_boldnotice("传输成功")]：[AI.name]（[rand(1000,9999)].exe）已成功安装并运行。本地副本已删除。")
		card.AI = null
		AI.battery = circuit.battery
		AI.posibrain_inside = isnull(core_mmi) || core_mmi.braintype == "Android"
		qdel(src)
	else //If for some reason you use an empty card on an empty AI terminal.
		to_chat(user, span_alert("此终端没有加载 AI。"))

/obj/item/circuitboard/aicore
	name = "AI 核心"
	name_extension = "（AI 核心电路板）" //Well, duh, but best to be consistent
	var/battery = 200 //backup battery for when the AI loses power. Copied to/from AI mobs when carding, and placed here to avoid recharge via deconning the core

/obj/item/circuitboard/aicore/Initialize(mapload)
	. = ..()
	if(mapload && HAS_TRAIT(SSstation, STATION_TRAIT_HUMAN_AI))
		return INITIALIZE_HINT_QDEL

#undef AI_CORE_BRAIN
