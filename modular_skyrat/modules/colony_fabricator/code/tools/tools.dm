// Like the power drill, except no speed buff but has wirecutters as well? Just trust me on this one.

/obj/item/screwdriver/omni_drill
	name = "电动螺丝刀"
	desc = "终极多用途建造工具。配有剪线、拧螺栓和拧螺丝的批头，还有什么可挑剔的？\
		好吧，就是速度慢。与其他电钻相比，这类工具\
		<b>并不比无动力工具快多少</b>。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "drill"
	post_init_icon_state = null
	inside_belt_icon_state = null
	inhand_icon_state = "drill"
	worn_icon_state = "drill"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	force = 10
	throwforce = 8
	throw_speed = 2
	throw_range = 3
	attack_verb_continuous = list("drills", "screws", "jabs", "whacks")
	attack_verb_simple = list("drill", "screw", "jab", "whack")
	hitsound = 'sound/items/tools/drill_hit.ogg'
	usesound = 'sound/items/tools/drill_use.ogg'
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 1
	random_color = FALSE
	greyscale_config = null
	greyscale_config_belt = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = null
	/// Used on Initialize, how much time to cut cable restraints and zipties.
	var/snap_time_weak_handcuffs = 0 SECONDS
	/// Used on Initialize, how much time to cut real handcuffs. Null means it can't.
	var/snap_time_strong_handcuffs = null

/obj/item/screwdriver/omni_drill/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/item/screwdriver/omni_drill/get_all_tool_behaviours()
	return list(TOOL_WIRECUTTER, TOOL_SCREWDRIVER, TOOL_WRENCH)

/obj/item/screwdriver/omni_drill/examine(mob/user)
	. = ..()
	. += span_notice("在<b>手中</b>使用以切换配置。\n")
	. += span_notice("它可作为 <b>[tool_behaviour]</b> 工具使用。")

/obj/item/screwdriver/omni_drill/update_icon_state()
	. = ..()
	switch(tool_behaviour)
		if(TOOL_SCREWDRIVER)
			icon_state = initial(icon_state)
		if(TOOL_WRENCH)
			icon_state = "[initial(icon_state)]_bolt"
		if(TOOL_WIRECUTTER)
			icon_state = "[initial(icon_state)]_cut"

/obj/item/screwdriver/omni_drill/attack_self(mob/user, modifiers)
	. = ..()
	if(!user)
		return
	var/list/tool_list = list(
		"Screwdriver" = image(icon = icon, icon_state = "drill"),
		"Wrench" = image(icon = icon, icon_state = "drill_bolt"),
		"Wirecutters" = image(icon = icon, icon_state = "drill_cut"),
	)
	var/tool_result = show_radial_menu(user, src, tool_list, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE, tooltips = TRUE)
	if(!check_menu(user) || !tool_result)
		return
	RemoveElement(/datum/element/cuffsnapping, snap_time_weak_handcuffs, snap_time_strong_handcuffs)
	switch(tool_result)
		if("Wrench")
			tool_behaviour = TOOL_WRENCH
			sharpness = NONE
		if("Wirecutters")
			tool_behaviour = TOOL_WIRECUTTER
			sharpness = NONE
			AddElement(/datum/element/cuffsnapping, snap_time_weak_handcuffs, snap_time_strong_handcuffs)
		if("Screwdriver")
			tool_behaviour = TOOL_SCREWDRIVER
			sharpness = SHARP_POINTY
	playsound(src, 'sound/items/tools/change_drill.ogg', 50, vary = TRUE)
	update_appearance(UPDATE_ICON)

/obj/item/screwdriver/omni_drill/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated || !user.Adjacent(src))
		return FALSE
	return TRUE

// Just a completely normal crowbar except its normal sized

/obj/item/crowbar/large/doorforcer
	name = "撬棍"
	desc = "一把涂成橙色的大型坚固撬棍。没什么特别或独特之处。说实话，纯属浪费钱。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "prybar"
	toolspeed = 1.3
	force_opens = TRUE
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/crowbar/large/doorforcer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

// Backpackable mining drill

/obj/item/pickaxe/drill/compact
	name = "紧凑型采矿钻机"
	desc = "一台电动采矿钻机，到哪儿都能钻上一通。体积足够紧凑，希望能塞进背包里。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "drilla"
	worn_icon_state = "drill"
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.6
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/pickaxe/drill/compact/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

// Electric welder but not quite as strong

/obj/item/weldingtool/electric/arc_welder
	name = "电弧焊接工具"
	desc = "一种专用焊接工具，利用高压电弧把东西焊在一起。\
		与其他电动焊接器相比，这款型号速度慢、电能效率极低，\
		但它照样能完成任务，而且这东西很可能是你免费打印出来的。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "arc_welder"
	usesound = 'modular_skyrat/modules/colony_fabricator/sound/arc_welder/arc_welder.ogg'
	light_range = 2
	light_power = 0.75
	toolspeed = 1
	power_use_amount = POWER_CELL_USE_INSANE
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)

/obj/item/weldingtool/electric/arc_welder/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
