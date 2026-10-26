/obj/item/mod/construction
	desc = "用于建造 MOD 外骨骼的部件。"
	icon = 'icons/obj/clothing/modsuit/mod_construction.dmi'
	inhand_icon_state = "rack_parts"

/obj/item/mod/construction/helmet
	name = "MOD 头盔"
	icon_state = "helmet"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/item/mod/construction/helmet/examine(mob/user)
	. = ..()
	. += span_notice("你可以把它插入<b>MOD 外壳</b>……")

/obj/item/mod/construction/chestplate
	name = "MOD 胸甲"
	icon_state = "chestplate"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/item/mod/construction/chestplate/examine(mob/user)
	. = ..()
	. += span_notice("你可以把它插入<b>MOD 外壳</b>……")

/obj/item/mod/construction/gauntlets
	name = "MOD 护手"
	icon_state = "gauntlets"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/item/mod/construction/gauntlets/examine(mob/user)
	. = ..()
	. += span_notice("你可以把这些插入<b>MOD 外壳</b>……")

/obj/item/mod/construction/boots
	name = "MOD 靴子"
	icon_state = "boots"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/item/mod/construction/boots/examine(mob/user)
	. = ..()
	. += span_notice("你可以把这些插入<b>MOD 外壳</b>……")

/obj/item/mod/construction/broken_core
	name = "损坏的 MOD 核心"
	icon_state = "mod-core"
	desc = "模块化外穿装置的内置电源。不过这个似乎已经无法供电了。"

/obj/item/mod/construction/broken_core/examine(mob/user)
	. = ..()
	. += span_notice("你可以用<b>螺丝刀</b>把它修好……")

/obj/item/mod/construction/broken_core/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	balloon_alert(user, "正在修理……")
	if(!tool.use_tool(src, user, 5 SECONDS, volume = 30))
		balloon_alert(user, "被打断！")
		return
	new /obj/item/mod/core/standard(drop_location())
	qdel(src)

/obj/item/mod/construction/lavalandcore
	name = "等离子花"
	icon_state = "plasma-flower"
	desc = "一株来自熔岩地带荒芜废土的奇异花朵。它散发着明亮的紫色光芒并不断脉动。  \
		它的形状与 MOD 核心惊人地相似。"
	light_system = OVERLAY_LIGHT
	light_color = "#cc00cc"
	light_range = 2.5
	light_power = 1.5

/obj/item/mod/construction/lavalandcore/examine(mob/user)
	. = ..()
	. += span_notice("你大概可以往上面接一些<b>线缆</b>……")

/obj/item/mod/construction/lavalandcore/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stack/cable_coil))
		return NONE

	if(!tool.tool_start_check(user, amount=2))
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "正在安装线缆……")
	if(!tool.use_tool(src, user, 5 SECONDS, amount = 2, volume = 30))
		balloon_alert(user, "被打断！")
		return ITEM_INTERACT_BLOCKING

	new /obj/item/mod/core/plasma/lavaland(drop_location())
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/mod/construction/plating
	name = "MOD 外部装甲板"
	desc = "用于完成 MOD 控制单元的外部装甲板。"
	icon_state = "standard-plating"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 5)
	var/datum/mod_theme/theme = /datum/mod_theme

/obj/item/mod/construction/plating/Initialize(mapload)
	. = ..()
	var/datum/mod_theme/used_theme = GLOB.mod_themes[theme]
	name = "MOD [chinese_batch_ten_theme_display(used_theme.name)] 外部装甲板"
	desc = "[desc] [used_theme.desc]"
	icon_state = "[used_theme.default_skin]-plating"

/obj/item/mod/construction/plating/civilian
	theme = /datum/mod_theme/civilian
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 5)

/obj/item/mod/construction/plating/portable_suit
	theme = /datum/mod_theme/portable_suit
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 5)

/obj/item/mod/construction/plating/engineering
	theme = /datum/mod_theme/engineering
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/gold = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 5)

/obj/item/mod/construction/plating/atmospheric
	theme = /datum/mod_theme/atmospheric
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/titanium = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 5)

/obj/item/mod/construction/plating/medical
	theme = /datum/mod_theme/medical
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/silver = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 5)

/obj/item/mod/construction/plating/security
	theme = /datum/mod_theme/security

/obj/item/mod/construction/plating/cosmohonk
	theme = /datum/mod_theme/cosmohonk
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/bananium = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 5)

#define START_STEP "start"
#define CORE_STEP "core"
#define SCREWED_CORE_STEP "screwed_core"
#define HELMET_STEP "helmet"
#define CHESTPLATE_STEP "chestplate"
#define GAUNTLETS_STEP "gauntlets"
#define BOOTS_STEP "boots"
#define WRENCHED_ASSEMBLY_STEP "wrenched_assembly"
#define SCREWED_ASSEMBLY_STEP "screwed_assembly"

/obj/item/mod/construction/shell
	name = "MOD 外壳"
	icon_state = "mod-construction_start"
	desc = "一个 MOD 外壳。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2.5)
	var/obj/item/core
	var/obj/item/helmet
	var/obj/item/chestplate
	var/obj/item/gauntlets
	var/obj/item/boots
	var/step = START_STEP

/obj/item/mod/construction/shell/examine(mob/user)
	. = ..()
	var/display_text
	switch(step)
		if(START_STEP)
			display_text = "看起来缺少一块<b>MOD 核心</b>……"
		if(CORE_STEP)
			display_text = "核心似乎<b>松动了</b>……"
		if(SCREWED_CORE_STEP)
			display_text = "看起来缺少一顶<b>头盔</b>……"
		if(HELMET_STEP)
			display_text = "看起来缺少一件<b>胸甲</b>……"
		if(CHESTPLATE_STEP)
			display_text = "看起来缺少<b>护手</b>……"
		if(GAUNTLETS_STEP)
			display_text = "看起来缺少<b>靴子</b>……"
		if(BOOTS_STEP)
			display_text = "组件似乎<b>未固定</b>……"
		if(WRENCHED_ASSEMBLY_STEP)
			display_text = "组件似乎<b>松动</b>……"
		if(SCREWED_ASSEMBLY_STEP)
			display_text = "只差<b>外部装甲板</b>了……"
	. += span_notice(display_text)

/obj/item/mod/construction/shell/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	switch(step)
		if(START_STEP)
			if(!istype(tool, /obj/item/mod/core))
				return NONE

			if(!user.transferItemToLoc(tool, src))
				balloon_alert(user, "卡住了！")
				return ITEM_INTERACT_BLOCKING

			playsound(src, 'sound/machines/click.ogg', 30, TRUE)
			balloon_alert(user, "核心已插入")
			core = tool
			step = CORE_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

		if(SCREWED_CORE_STEP)
			if(!istype(tool, /obj/item/mod/construction/helmet)) //Construct
				return NONE

			if(!user.transferItemToLoc(tool, src))
				balloon_alert(user, "卡住了！")
				return ITEM_INTERACT_BLOCKING

			playsound(src, 'sound/machines/click.ogg', 30, TRUE)
			balloon_alert(user, "头盔已安装")
			helmet = tool
			step = HELMET_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

		if(HELMET_STEP)
			if(!istype(tool, /obj/item/mod/construction/chestplate)) //Construct
				return NONE

			if(!user.transferItemToLoc(tool, src))
				balloon_alert(user, "卡住了！")
				return ITEM_INTERACT_BLOCKING

			playsound(src, 'sound/machines/click.ogg', 30, TRUE)
			balloon_alert(user, "胸甲已安装")
			chestplate = tool
			step = CHESTPLATE_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

		if(CHESTPLATE_STEP)
			if(!istype(tool, /obj/item/mod/construction/gauntlets)) //Construct
				return NONE

			if(!user.transferItemToLoc(tool, src))
				balloon_alert(user, "卡住了！")
				return ITEM_INTERACT_BLOCKING

			playsound(src, 'sound/machines/click.ogg', 30, TRUE)
			balloon_alert(user, "护手已安装")
			gauntlets = tool
			step = GAUNTLETS_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

		if(GAUNTLETS_STEP)
			if(!istype(tool, /obj/item/mod/construction/boots)) //Construct
				return NONE

			if(!user.transferItemToLoc(tool, src))
				balloon_alert(user, "卡住了！")
				return ITEM_INTERACT_BLOCKING

			playsound(src, 'sound/machines/click.ogg', 30, TRUE)
			balloon_alert(user, "靴子已安装")
			boots = tool
			step = BOOTS_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

		if(SCREWED_ASSEMBLY_STEP)
			if(!istype(tool, /obj/item/mod/construction/plating)) //Construct
				return NONE

			var/obj/item/mod/construction/plating/external_plating = tool
			if(!user.transferItemToLoc(tool, src))
				balloon_alert(user, "卡住了！")
				return ITEM_INTERACT_BLOCKING

			playsound(src, 'sound/machines/click.ogg', 30, TRUE)
			var/obj/item/mod = new /obj/item/mod/control(drop_location(), external_plating.theme, null, core)
			core = null
			qdel(src)
			user.put_in_hands(mod)
			mod.balloon_alert(user, "单元已完成")
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/mod/construction/shell/screwdriver_act(mob/living/user, obj/item/tool)
	switch(step)

		if(CORE_STEP)
			if(!tool.use_tool(src, user, 0, volume = 30))
				return ITEM_INTERACT_BLOCKING

			balloon_alert(user, "核心已拧紧")
			step = SCREWED_CORE_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

		if(SCREWED_CORE_STEP)
			if(!tool.use_tool(src, user, 0, volume = 30))
				return ITEM_INTERACT_BLOCKING

			balloon_alert(user, "核心已拧松")
			step = CORE_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

		if(WRENCHED_ASSEMBLY_STEP)
			if(!tool.use_tool(src, user, 0, volume = 30))
				return ITEM_INTERACT_BLOCKING

			balloon_alert(user, "组件已拧紧")
			step = SCREWED_ASSEMBLY_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

		if(SCREWED_ASSEMBLY_STEP)
			if(!tool.use_tool(src, user, 0, volume = 30))
				return ITEM_INTERACT_BLOCKING

			balloon_alert(user, "组件已拧松")
			step = WRENCHED_ASSEMBLY_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/mod/construction/shell/crowbar_act(mob/living/user, obj/item/tool)
	switch(step)
		if(CORE_STEP)
			if(!tool.use_tool(src, user, 0, volume = 30))
				return ITEM_INTERACT_SUCCESS

			core.forceMove(drop_location())
			balloon_alert(user, "核心已取出")
			step = START_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

		if(HELMET_STEP)
			if(!tool.use_tool(src, user, 0, volume = 30))
				return ITEM_INTERACT_BLOCKING

			helmet.forceMove(drop_location())
			balloon_alert(user, "头盔已拆下")
			helmet = null
			step = SCREWED_CORE_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

		if(CHESTPLATE_STEP)
			if(!tool.use_tool(src, user, 0, volume = 30))
				return ITEM_INTERACT_BLOCKING

			chestplate.forceMove(drop_location())
			balloon_alert(user, "胸甲已拆下")
			chestplate = null
			step = HELMET_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

		if(GAUNTLETS_STEP)
			if(!tool.use_tool(src, user, 0, volume = 30))
				return ITEM_INTERACT_BLOCKING

			gauntlets.forceMove(drop_location())
			balloon_alert(user, "护手已拆下")
			gauntlets = null
			step = CHESTPLATE_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

		if(BOOTS_STEP)
			if(!tool.use_tool(src, user, 0, volume = 30))
				return ITEM_INTERACT_BLOCKING

			boots.forceMove(drop_location())
			balloon_alert(user, "靴子已拆下")
			boots = null
			step = GAUNTLETS_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/mod/construction/shell/wrench_act(mob/living/user, obj/item/tool)
	switch(step)
		if(BOOTS_STEP)
			if(!tool.use_tool(src, user, 0, volume = 30))
				return ITEM_INTERACT_BLOCKING

			balloon_alert(user, "组件已固定")
			step = WRENCHED_ASSEMBLY_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

		if(WRENCHED_ASSEMBLY_STEP)
			if(!tool.use_tool(src, user, 0, volume = 30))
				return ITEM_INTERACT_BLOCKING

			balloon_alert(user, "组件已解除固定")
			step = BOOTS_STEP
			update_icon_state()
			return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/mod/construction/shell/update_icon_state()
	. = ..()
	icon_state = "mod-construction_[step]"

/obj/item/mod/construction/shell/Destroy()
	QDEL_NULL(core)
	QDEL_NULL(helmet)
	QDEL_NULL(chestplate)
	QDEL_NULL(gauntlets)
	QDEL_NULL(boots)
	return ..()

/obj/item/mod/construction/shell/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == core)
		core = null
	if(gone == helmet)
		helmet = null
	if(gone == chestplate)
		chestplate = null
	if(gone == gauntlets)
		gauntlets = null
	if(gone == boots)
		boots = null

#undef START_STEP
#undef CORE_STEP
#undef SCREWED_CORE_STEP
#undef HELMET_STEP
#undef CHESTPLATE_STEP
#undef GAUNTLETS_STEP
#undef BOOTS_STEP
#undef WRENCHED_ASSEMBLY_STEP
#undef SCREWED_ASSEMBLY_STEP
