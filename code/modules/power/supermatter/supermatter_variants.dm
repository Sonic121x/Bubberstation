/// Normal SM with it's processing disabled.
/obj/machinery/power/supermatter_crystal/hugbox
	disable_damage = TRUE
	disable_gas =  TRUE
	disable_power_change = TRUE
	disable_process = SM_PROCESS_DISABLED

/// Normal SM designated as main engine.
/obj/machinery/power/supermatter_crystal/engine
	is_main_engine = TRUE

/// Shard SM.
/obj/machinery/power/supermatter_crystal/shard
	name = "超物质碎片"
	desc = "一块奇异地半透明、泛着虹彩的晶体，看起来原本是某个更大结构的一部分。"
	base_icon_state = "sm_shard"
	icon_state = "sm_shard"
	anchored = FALSE
	absorption_ratio = 0.125
	explosion_power = 12
	layer = ABOVE_MOB_LAYER
	moveable = TRUE


/obj/machinery/power/supermatter_crystal/shard/Initialize(mapload)
	. = ..()

	register_context()


/obj/machinery/power/supermatter_crystal/shard/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(held_item?.tool_behaviour == TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_LMB] = anchored ? "解除固定" : "固定"
		return CONTEXTUAL_SCREENTIP_SET


/// Shard SM with it's processing disabled.
/obj/machinery/power/supermatter_crystal/shard/hugbox
	name = "已固定的超物质碎片"
	disable_damage = TRUE
	disable_gas =  TRUE
	disable_power_change = TRUE
	disable_process = SM_PROCESS_DISABLED
	moveable = FALSE
	anchored = TRUE

/// Shard SM designated as the main engine.
/obj/machinery/power/supermatter_crystal/shard/engine
	name = "已固定的超物质碎片"
	is_main_engine = TRUE
	anchored = TRUE
	moveable = FALSE

/// Normal sm but small (sm sword recipe element) (wiz only) and adamantine pedestal for it
/obj/machinery/power/supermatter_crystal/small
	name = "小得出奇的超物质晶体"
	desc = "一块安放在精金基座上的、奇异地半透明并泛着虹彩的晶体。它看起来本该再大一点……"
	base_icon_state = "sm_small"
	icon_state = "sm_small"
	moveable = TRUE
	anchored = FALSE
	custom_materials = list(/datum/material/adamantine = SHEET_MATERIAL_AMOUNT * 20, /datum/material/iron = SHEET_MATERIAL_AMOUNT)

/obj/machinery/power/supermatter_crystal/small/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps, "精金信号")
	priority_announce("舰上检测到异常晶体。位置已标注在每台 GPS 设备上。", "纳米传讯异常部公告")

/obj/item/adamantine_pedestal
	name = "精金基座"
	desc = "一个精金基座。它上面似乎应该放点什么小巧却很沉重的东西。"
	icon = 'icons/obj/machines/engine/supermatter.dmi'
	icon_state = "pedestal"
	w_class = WEIGHT_CLASS_HUGE
	throw_speed = 1
	throw_range = 1
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	custom_materials = list(/datum/material/adamantine = SHEET_MATERIAL_AMOUNT * 20)
