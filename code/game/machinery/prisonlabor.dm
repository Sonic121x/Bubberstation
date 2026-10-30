// License plate printing
/obj/machinery/plate_press
	name = "车牌压制机"
	desc = "你知道吗，我们正在为一个连汽车都没有的空间站制造大量车牌。"
	icon = 'icons/obj/machines/prison.dmi'
	icon_state = "offline"
	use_power = IDLE_POWER_USE
	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 0.02
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.05
	/// Reference to currently held license plate.
	var/obj/item/stack/license_plates/empty/current_plate
	/// Is the press currently pressing?
	var/pressing = FALSE

/obj/machinery/plate_press/update_icon_state()
	if(!is_operational)
		icon_state = "offline"
		return ..()
	if(pressing)
		icon_state = "loop"
		return ..()
	if(current_plate)
		icon_state = "online_loaded"
		return ..()
	icon_state = "online"
	return ..()

/obj/machinery/plate_press/Destroy()
	QDEL_NULL(current_plate)
	. = ..()

/obj/machinery/plate_press/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stack/license_plates/empty))
		return NONE
	if(!is_operational)
		to_chat(user, span_warning("必须先开启[src]才能装料！"))
		return ITEM_INTERACT_BLOCKING
	if(current_plate)
		to_chat(user, span_warning("[src]里已经有一块车牌了！"))
		return ITEM_INTERACT_BLOCKING

	var/obj/item/stack/license_plates/empty/plate = tool
	plate.use(1)
	current_plate = new plate.type(src, 1) //Spawn a new single sheet in the machine
	update_appearance()
	post_press(user)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/plate_press/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!pressing && current_plate)
		work_press(user)

///This proc attempts to create a plate. User cannot move during this process.
/obj/machinery/plate_press/proc/work_press(mob/living/user)

	pressing = TRUE
	update_appearance()
	to_chat(user, span_notice("你开始压制一块新车牌！"))
	playsound(src, 'sound/machines/kerchunk.ogg', 80)

	if(!do_after(user, 4 SECONDS, target = src))
		pressing = FALSE
		update_appearance()
		return FALSE

	use_energy(active_power_usage)
	to_chat(user, span_notice("你完成了一块新车牌的压制！"))

	pressing = FALSE
	QDEL_NULL(current_plate)
	update_appearance()

	new /obj/item/stack/license_plates/filled(drop_location())

/// Side effects after successfully pressing a license plate, including granting labor points.
/obj/machinery/plate_press/proc/post_press(mob/living/user)
	if(!user)
		return
	if(!istype(user.get_idcard(TRUE), /obj/item/card/id/advanced/prisoner))
		return // No bonus effects if we're not a prisoner or there's no ID.
	var/obj/item/card/id/advanced/prisoner/prison_id = user.get_idcard(TRUE)
	prison_id.points += PRISON_LABOR_PLATE
	to_chat(user, span_notice("增加了 [PRISON_LABOR_PLATE] 点积分！"))



//Grown crop recepticle.
/obj/machinery/produceporter
	name = "农产品传送机"
	desc = "一台破旧的固定式传送机，用来将农产品传送回服务部门。它早已不复当年的光彩。"
	icon = 'icons/obj/machines/prison.dmi'
	icon_state = "produceporter_off"
	density =  TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 0.01
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.1
	/// Maximum amount of produce the machine can hold before it has to be either emptied or sent.
	var/max_produce = 10
	/// Current count of held produce
	var/current_produce = 0

/obj/machinery/produceporter/Initialize(mapload)
	. = ..()
	register_context()
	update_appearance()

/obj/machinery/produceporter/update_icon_state()
	if(!is_operational)
		icon_state = "produceporter_off"
		return ..()
	icon_state = "produceporter"
	return ..()

/obj/machinery/produceporter/update_overlays()
	. = ..()
	if(is_operational)
		. += emissive_appearance(icon, "produceporter_emissive", src)

/obj/machinery/produceporter/examine(mob/user)
	. = ..()
	if(current_produce >= max_produce)
		. += span_notice("[src]的料斗已满，可以将农产品送回空间站以换取劳动积分。")
	else
		. += span_notice("[src]还能容纳更多农产品。")
	if(!length(GLOB.produce_locations))
		. += span_notice("脏兮兮的屏幕上显示着警告：没有可供传送作物的[span_boldnotice("农产品接收垫")]。")
	else
		. += span_notice("可以用[span_boldnotice("右键点击")]拉动拉杆，将农产品送回空间站。")

/obj/machinery/produceporter/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/food/grown))
		return NONE
	if(current_produce >= max_produce)
		balloon_alert(user, "料斗已满！")
		return ITEM_INTERACT_FAILURE
	tool.forceMove(src)
	playsound(src, 'sound/items/handling/component_drop.ogg', 30)
	update_produce()
	balloon_alert(user, "已装入 [current_produce] / [max_produce]")
	return ITEM_INTERACT_SUCCESS

/obj/machinery/produceporter/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(!is_operational)
		balloon_alert(user, "没有反应")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!current_produce)
		balloon_alert(user, "料斗是空的！")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!length(GLOB.produce_locations))
		balloon_alert(user, "没有接收点！")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	flick("produceporter_active", src)
	use_energy(active_power_usage)
	playsound(src, 'sound/items/weapons/emitter2.ogg', 50)
	var/points = 0
	var/produce_count = 0
	for(var/obj/item/food/grown/produce in contents)
		var/atom/dropoff = pick(GLOB.produce_locations)
		do_teleport(produce, dropoff.drop_location(), 0, asoundout = 'sound/machines/woosh.ogg')
		points += (produce.seed?.potency > 50 ? (PRISON_LABOR_CROPS * 2) : PRISON_LABOR_CROPS)
		produce_count ++
	balloon_alert_to_viewers("咔哐！")
	post_delivery(user, points, produce_count)
	update_produce()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/produceporter/ShiftClick(mob/user)
	. = ..()
	for(var/obj/item/food/grown/crops in contents)
		crops.forceMove(drop_location())
	visible_message("[src]料斗里的东西倾倒在地板上。")

/obj/machinery/produceporter/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(is_operational && current_produce > 0)
		context[SCREENTIP_CONTEXT_RMB] = "传送农产品"
	if(istype(held_item, /obj/item/food/grown))
		context[SCREENTIP_CONTEXT_LMB] = "放入农产品"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/produceporter/wrench_act(mob/living/user, obj/item/tool)
	. = ITEM_INTERACT_BLOCKING
	if(default_unfasten_wrench(user, tool, time = 1.5 SECONDS) == SUCCESSFUL_UNFASTEN)
		update_appearance(UPDATE_ICON_STATE)
		return ITEM_INTERACT_SUCCESS

/obj/machinery/produceporter/proc/update_produce()
	current_produce = 0
	for(var/obj/item/food/grown/crops in contents)
		if(current_produce > max_produce)
			return
		current_produce++
	return current_produce

/obj/machinery/produceporter/proc/post_delivery(mob/living/user, labor_points, produce_count)
	if(!user || !labor_points || !produce_count)
		return
	var/obj/item/card/id/id_card = user.get_idcard(TRUE)
	if(!istype(id_card, /obj/item/card/id/advanced/prisoner))
		return // No bonus effects if we're not a prisoner or there's no ID.
	var/obj/item/card/id/advanced/prisoner/prison_id = id_card
	prison_id.points += labor_points
	to_chat(user, span_notice("增加了 [labor_points] 点劳动积分！"))

	aas_config_announce(/datum/aas_config_entry/gulag_produce, list(
		"LOCATION" = get_area_name(src),
		"COUNT" = produce_count
	), src, list(RADIO_CHANNEL_SUPPLY))

/datum/aas_config_entry/gulag_produce
	name = "服务通知：劳改营农产品已发出！"
	announcement_lines_map = list(
		"Message" = "一批农产品（%COUNT 件）已从劳改营发往 %LOCATION。")
	vars_and_tooltips_map = list(
		"LOCATION" = "将替换为农产品的送达地点。",
		"COUNT" = "将替换为收到的农产品数量。"
	)

GLOBAL_LIST_EMPTY(produce_locations)

/obj/item/producepad
	name = "农产品接收垫"
	desc = "这个轻巧的装置充当农产品传送机的信标，将新鲜种植的食物传送到此处。"
	icon = 'icons/obj/machines/prison.dmi'
	icon_state = "producepad"
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3)

/obj/item/producepad/Initialize(mapload)
	. = ..()
	GLOB.produce_locations += src

/obj/item/producepad/Destroy(force)
	GLOB.produce_locations -= src
	return ..()
