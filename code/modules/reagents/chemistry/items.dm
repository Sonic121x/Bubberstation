///if the ph_meter gives a detailed output
#define DETAILED_CHEM_OUTPUT 1
///if the pH meter gives a shorter output
#define SHORTENED_CHEM_OUTPUT 0

/*
* a pH booklet that contains pH paper pages that will change color depending on the pH of the reagents datum it's attacked onto
*/
/obj/item/ph_booklet
	name = "pH 指示试纸册"
	desc = "一本装有浸过通用指示剂纸张的小册子。"
	icon_state = "pHbooklet"
	icon = 'icons/obj/medical/chemical.dmi'
	item_flags = NOBLUDGEON
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY
	interaction_flags_mouse_drop = NEED_HANDS
	custom_materials = list(/datum/material/paper = HALF_SHEET_MATERIAL_AMOUNT / 2)

	///How many pages the booklet holds
	var/number_of_pages = 50

//A little janky with pockets
/obj/item/ph_booklet/attack_hand(mob/user)
	if(user.get_held_index_of_item(src))//Does this check pockets too..?
		if(number_of_pages == 50)
			icon_state = "pHbooklet_open"
		if(!number_of_pages)
			to_chat(user, span_warning("[src] 是空的！"))
			add_fingerprint(user)
			return
		var/obj/item/ph_paper/page = new(get_turf(user))
		page.add_fingerprint(user)
		user.put_in_active_hand(page)
		to_chat(user, span_notice("你从 [src] 中取出一张 [page]。"))
		number_of_pages--
		playsound(user.loc, 'sound/items/poster/poster_ripped.ogg', 50, TRUE)
		add_fingerprint(user)
		if(!number_of_pages)
			icon_state = "pHbooklet_empty"
		return
	var/I = user.get_active_held_item()
	if(!I)
		user.put_in_active_hand(src)
	return ..()

/obj/item/ph_booklet/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	if(!isliving(user))
		return
	if(!number_of_pages)
		to_chat(user, span_warning("[src] 是空的！"))
		add_fingerprint(user)
		return
	if(number_of_pages == 50)
		icon_state = "pHbooklet_open"
	var/obj/item/ph_paper/P = new(get_turf(user))
	P.add_fingerprint(user)
	user.put_in_active_hand(P)
	to_chat(user, span_notice("你从 [src] 中取出一张 [P]。"))
	number_of_pages--
	playsound(user.loc, 'sound/items/poster/poster_ripped.ogg', 50, TRUE)
	add_fingerprint(user)
	if(!number_of_pages)
		icon_state = "pHbookletEmpty"

/*
* pH paper will change color depending on the pH of the reagents datum it's attacked onto
*/
/obj/item/ph_paper
	name = "pH 指示试纸条"
	desc = "一张会随溶液 pH 值改变颜色的纸片。"
	icon_state = "pHpaper"
	icon = 'icons/obj/medical/chemical.dmi'
	item_flags = NOBLUDGEON
	color = "#f5c352"
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY
	///If the paper was used, and therefore cannot change color again
	var/used = FALSE

/obj/item/ph_paper/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!is_reagent_container(interacting_with))
		return
	var/obj/item/reagent_containers/cont = interacting_with
	if(!LAZYLEN(cont.reagents.reagent_list))
		return NONE
	if(used)
		to_chat(user, span_warning("[src] 已经被使用过了！"))
		return ITEM_INTERACT_BLOCKING
	CONVERT_PH_TO_COLOR(round(cont.reagents.ph, 1), color)
	desc += " 这张纸的 pH 值大约是 [round(cont.reagents.ph, 1)]。"
	name = "用过的 [name]"
	used = TRUE
	return ITEM_INTERACT_SUCCESS

/*
* pH meter that will give a detailed or truncated analysis of all the reagents in of an object with a reagents datum attached to it. Only way of detecting purity for now.
*/
/obj/item/ph_meter
	name = "化学分析仪"
	desc = "一根接在小电路盒上的电极，可显示溶液的详细资料。可切换是否提供每种试剂的描述。屏幕目前什么也没显示。"
	icon_state = "pHmeter"
	icon = 'icons/obj/medical/chemical.dmi'
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT)
	///level of detail for output for the meter
	var/scanmode = DETAILED_CHEM_OUTPUT

/obj/item/ph_meter/attack_self(mob/user)
	if(scanmode == SHORTENED_CHEM_OUTPUT)
		to_chat(user, span_notice("你把化学分析仪切换为提供每种试剂详细描述的模式。"))
		scanmode = DETAILED_CHEM_OUTPUT
	else
		to_chat(user, span_notice("你把化学分析仪切换为报告中不包含试剂描述的模式。"))
		scanmode = SHORTENED_CHEM_OUTPUT

/obj/item/ph_meter/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!is_reagent_container(interacting_with))
		return NONE
	var/obj/item/reagent_containers/cont = interacting_with
	if(!LAZYLEN(cont.reagents.reagent_list))
		return NONE
	SEND_SIGNAL(interacting_with, COMSIG_ON_REAGENT_SCAN, user)
	var/list/out_message = list()
	to_chat(user, "<i>化学检测仪哔哔作响，显示出：</i>")
	out_message += "<b>总体积：[round(cont.volume, 0.01)] 当前温度：[round(cont.reagents.chem_temp, 0.1)]K 总 pH：[round(cont.reagents.ph, 0.01)]\n"
	out_message += "在 [interacting_with.name] 中检测到的化学物质：</b>\n"
	if(cont.reagents.is_reacting)
		out_message += "[span_warning("当前似乎正在发生反应。")]<span class='notice'>\n"
	for(var/datum/reagent/reagent as anything in cont.reagents.reagent_list) // bloodtyping if blood present in container
		var/blood_info = null
		if(reagent.data)
			var/blood = reagent.data[BLOOD_DATA_TYPE]
			if(istype(blood, /datum/blood_type))
				var/datum/blood_type/blood_type = blood
				var/type = blood_type.get_type()
				blood_info = "[blood_type.get_blood_name()] [type ? "（血型：[type]）" : ""]"
			else if(blood)
				blood_info = "[reagent.name]（血型：[blood]）"
		if(reagent.purity < reagent.inverse_chem_val && reagent.inverse_chem) //If the reagent is impure
			var/datum/reagent/inverse_reagent = GLOB.chemical_reagents_list[reagent.inverse_chem]
			out_message += "[span_warning("检测到反转试剂：")]<span class='notice'><b>[round(reagent.volume, 0.01)]u 的 [inverse_reagent.name]</b>，<b>纯度：</b>[round(1 - reagent.purity, 0.000001)*100]%，[(scanmode?"[(inverse_reagent.overdose_threshold?"<b>过量：</b>[inverse_reagent.overdose_threshold]u，":"")]<b>基础 pH：</b>[initial(inverse_reagent.ph)]，<b>当前 pH：</b>[reagent.ph]。":"<b>当前 pH：</b>[reagent.ph]。")]\n"
		else
			out_message += "<b>[round(reagent.volume, CHEMICAL_VOLUME_ROUNDING)]u 的 [blood_info || reagent.name]</b>，<b>纯度：</b>[round(reagent.purity, 0.000001)*100]%，[(scanmode?"[(reagent.overdose_threshold?"<b>过量：</b>[reagent.overdose_threshold]u，":"")]<b>基础 pH：</b>[initial(reagent.ph)]，<b>当前 pH：</b>[reagent.ph]。":"<b>当前 pH：</b>[reagent.ph]。")]\n"
		if(scanmode)
			out_message += "<b>分析：</b>[reagent.description]\n"
	to_chat(user, boxed_message(span_notice("[out_message.Join()]")))
	desc = "一根接在小电路盒上的电极，可显示溶液的详细资料。可切换是否提供每种试剂的描述。屏幕目前显示检测体积：[round(cont.volume, 0.01)]，检测 pH：[round(cont.reagents.ph, 0.1)]。"
	return ITEM_INTERACT_SUCCESS

/obj/item/burner
	name = "燃烧炉"
	desc = "一个小巧的桌面燃烧炉，用于加热烧杯。"
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "burner"
	custom_materials = list(/datum/material/paper = HALF_SHEET_MATERIAL_AMOUNT / 2)
	item_flags = NOBLUDGEON
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY
	heat = 2000
	///If the flame is lit - i.e. if we're processing and burning
	var/lit = FALSE
	///total reagent volume
	var/max_volume = 50
	///What the creation reagent is
	var/reagent_type = /datum/reagent/consumable/ethanol

/obj/item/burner/Initialize(mapload)
	. = ..()
	create_reagents(max_volume, TRANSPARENT)//We have our own refillable - since we want to heat and pour
	if(reagent_type)
		reagents.add_reagent(reagent_type, 15)

/obj/item/burner/grind_results()
	return list(/datum/reagent/consumable/ethanol = 5, /datum/reagent/silicon = 10)

/obj/item/burner/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!is_reagent_container(tool))
		if(tool.heat >= 1000)
			set_lit(TRUE)
			user.visible_message(span_notice("[user] 点燃了 [src]。"))
			return ITEM_INTERACT_SUCCESS
		return NONE

	if(lit)
		tool.reagents.expose_temperature(get_temperature())
		to_chat(user, span_notice("你用 [src] 加热了 [tool]。"))
		playsound(user.loc, 'sound/effects/chemistry/heatdam.ogg', 50, TRUE)
		return ITEM_INTERACT_SUCCESS

	if(tool.is_drainable()) //Transfer FROM it TO us. Special code so it only happens when flame is off.
		var/obj/item/reagent_containers/container = tool
		if(!container.reagents.total_volume)
			to_chat(user, span_warning("[container] 是空的，无法倾倒！"))
			return ITEM_INTERACT_BLOCKING

		if(reagents.holder_full())
			to_chat(user, span_warning("[src] 已装满。"))
			return ITEM_INTERACT_BLOCKING

		var/trans = container.reagents.trans_to(src, container.amount_per_transfer_from_this, transferred_by = user)
		to_chat(user, span_notice("你把 [container] 中的 [trans] 单位内容物倒入了 [src]。"))
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/burner/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!lit)
		return NONE

	if(is_reagent_container(interacting_with))
		var/obj/item/reagent_containers/container = interacting_with
		container.reagents.expose_temperature(get_temperature())
		user.visible_message(span_notice("[user] 加热了 [src]。"), span_notice("你加热了 [src]。"))
		playsound(user, 'sound/effects/chemistry/heatdam.ogg', 50, TRUE)
		return ITEM_INTERACT_SUCCESS

	else if(isitem(interacting_with))
		var/obj/item/item = interacting_with
		if(item.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
			set_lit(TRUE)
			user.visible_message(span_notice("[user] 点燃了 [src]。"), span_notice("你点燃了 [src]。"))
			return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_BLOCKING

/obj/item/burner/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][lit ? "-on" : ""]"

/obj/item/burner/proc/set_lit(new_lit)
	if(lit == new_lit)
		return
	lit = new_lit
	if(lit)
		force = 5
		damtype = BURN
		hitsound = 'sound/items/tools/welder.ogg'
		attack_verb_continuous = string_list(list("烫伤", "灼烧"))
		attack_verb_simple = string_list(list("烫伤", "灼烧"))
		START_PROCESSING(SSobj, src)
	else
		hitsound = SFX_SWING_HIT
		force = 0
		attack_verb_continuous = null //human_defense.dm takes care of it
		attack_verb_simple = null
		STOP_PROCESSING(SSobj, src)
	set_light_on(lit)
	update_icon()

/obj/item/burner/extinguish()
	. = ..()
	set_lit(FALSE)

/obj/item/burner/attack_self(mob/living/user)
	. = ..()
	if(.)
		return
	if(lit)
		set_lit(FALSE)
		user.visible_message(span_notice("[user] 掐灭了 [src] 的火焰。"))

/obj/item/burner/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(lit && M.ignite_mob())
		message_admins("[ADMIN_LOOKUPFLW(user)] 在 [AREACOORD(user)] 用 [src] 点燃了 [key_name_admin(M)]")
		user.log_message("用 [src] 点燃了 [key_name(M)]", LOG_GAME)
		M.log_message("被 [key_name(user)] 用 [src] 点燃了", LOG_VICTIM, log_globally = FALSE)
	return ..()

/obj/item/burner/process()
	var/current_heat = 0
	var/number_of_burning_reagents = 0
	for(var/datum/reagent/reagent as anything in reagents.reagent_list)
		reagent.burn(reagents) //burn can set temperatures of reagents
		if(!isnull(reagent.burning_temperature))
			current_heat += reagent.burning_temperature
			number_of_burning_reagents += 1
			reagents.remove_reagent(reagent.type, reagent.burning_volume)
			continue

	if(!number_of_burning_reagents)
		set_lit(FALSE)
		heat = 0
		return
	open_flame()
	current_heat /= number_of_burning_reagents
	heat = current_heat

/obj/item/burner/get_temperature()
	return lit * heat

/obj/item/burner/oil
	reagent_type = /datum/reagent/fuel/oil

/obj/item/burner/oil/grind_results()
	return list(/datum/reagent/fuel/oil = 5, /datum/reagent/silicon = 10)

/obj/item/burner/fuel
	reagent_type = /datum/reagent/fuel

/obj/item/burner/fuel/grind_results()
	return list(/datum/reagent/fuel = 5, /datum/reagent/silicon = 10)

/obj/item/thermometer
	name = "温度计"
	desc = "一支用于测量某物温度的温度计。"
	icon_state = "thermometer"
	icon = 'icons/obj/medical/chemical.dmi'
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT)
	///The reagents datum that this object is attached to, so we know where we are when it's added to something.
	var/datum/reagents/attached_to_reagents

/obj/item/thermometer/Destroy()
	attached_to_reagents = null
	return ..()

/obj/item/thermometer/grind_results()
	return list(/datum/reagent/mercury = 5)

/obj/item/thermometer/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(isnull(interacting_with.reagents))
		return NONE
	if(!user.transferItemToLoc(src, interacting_with))
		return ITEM_INTERACT_BLOCKING
	attached_to_reagents = interacting_with.reagents
	to_chat(user, span_notice("你把 [src] 装到了 [interacting_with] 上。"))
	ui_interact(user)
	return ITEM_INTERACT_SUCCESS

/obj/item/thermometer/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Thermometer", name)
		ui.open()

/obj/item/thermometer/ui_close(mob/user)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(remove_thermometer), user)

/obj/item/thermometer/ui_status(mob/user, datum/ui_state/state)
	if(!in_range(src, user))
		return UI_CLOSE
	return UI_INTERACTIVE

/obj/item/thermometer/ui_state(mob/user)
	return GLOB.physical_state

/obj/item/thermometer/ui_data(mob/user)
	if(!attached_to_reagents)
		ui_close(user)
		return

	var/list/data = list()
	data["Temperature"] = round(attached_to_reagents.chem_temp)
	return data

/obj/item/thermometer/proc/remove_thermometer(mob/target)
	try_put_in_hand(src, target)
	attached_to_reagents = null

/obj/item/thermometer/proc/try_put_in_hand(obj/object, mob/living/user)
	to_chat(user, span_notice("你把 [src] 从 [attached_to_reagents.my_atom] 上取了下来。"))
	if(!issilicon(user) && in_range(loc, user))
		user.put_in_hands(object)
	else
		object.forceMove(drop_location())

/obj/item/thermometer/pen
	color = "#888888"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.1)

#undef DETAILED_CHEM_OUTPUT
#undef SHORTENED_CHEM_OUTPUT
