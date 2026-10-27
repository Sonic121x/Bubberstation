#define MODPAINT_MAX_COLOR_VALUE 1.25
#define MODPAINT_MIN_COLOR_VALUE 0
#define MODPAINT_MAX_SECTION_COLORS 2
#define MODPAINT_MIN_SECTION_COLORS 0.25
#define MODPAINT_MAX_OVERALL_COLORS 4
#define MODPAINT_MIN_OVERALL_COLORS 1.5

/obj/item/mod/paint
	name = "MOD 喷漆套件"
	desc = "这套工具能把你的 MOD 模块化外骨骼重新喷涂成独一无二的样子。"
	icon = 'icons/obj/clothing/modsuit/mod_construction.dmi'
	icon_state = "paintkit"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 5)
	var/obj/item/mod/control/editing_mod
	var/atom/movable/screen/map_view/proxy_view
	var/list/current_color

/obj/item/mod/paint/Initialize(mapload)
	. = ..()
	current_color = COLOR_MATRIX_IDENTITY

/obj/item/mod/paint/examine(mob/user)
	. = ..()
	. += span_notice("<b>左键点击</b> MOD 模块化外骨骼可更换外观。")
	. += span_notice("<b>右键点击</b> MOD 模块化外骨骼可重新着色。")

/obj/item/mod/paint/ui_interact(mob/user, datum/tgui/ui)
	if(!editing_mod)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MODpaint", name)
		ui.open()
		proxy_view.display_to(user, ui.window)

/obj/item/mod/paint/ui_host()
	return editing_mod

/obj/item/mod/paint/ui_close(mob/user)
	. = ..()
	editing_mod = null
	QDEL_NULL(proxy_view)
	current_color = COLOR_MATRIX_IDENTITY

/obj/item/mod/paint/ui_status(mob/user, datum/ui_state/state)
	if(check_menu(editing_mod, user))
		return ..()
	return UI_CLOSE

/obj/item/mod/paint/ui_static_data(mob/user)
	var/list/data = list()
	data["mapRef"] = proxy_view.assigned_map
	return data

/obj/item/mod/paint/ui_data(mob/user)
	var/list/data = list()
	data["currentColor"] = current_color
	return data

/obj/item/mod/paint/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("transition_color")
			current_color = params["color"]
			animate(proxy_view, time = 0.5 SECONDS, color = current_color)
		if("confirm")
			if(length(current_color) != 20) //20 is the length of a matrix identity list
				return
			for(var/color_value in current_color)
				if(isnum(color_value))
					continue
				return
			var/total_color_value = 0
			var/list/total_colors = current_color.Copy()
			total_colors.Cut(13, length(total_colors)) // 13 to 20 are just a and c, dont want to count them
			var/red_value = current_color[1] + current_color[5] + current_color[9] //rr + gr + br
			var/green_value = current_color[2] + current_color[6] + current_color[10] //rg + gg + bg
			var/blue_value = current_color[3] + current_color[7] + current_color[11] //rb + gb + bb
			if(red_value > MODPAINT_MAX_SECTION_COLORS)
				balloon_alert(usr, "红色总量过高！（[red_value*100]%/[MODPAINT_MAX_SECTION_COLORS*100]%）")
				return
			else if(red_value < MODPAINT_MIN_SECTION_COLORS)
				balloon_alert(usr, "红色总量过低！（[red_value*100]%/[MODPAINT_MIN_SECTION_COLORS*100]%）")
				return
			if(green_value > MODPAINT_MAX_SECTION_COLORS)
				balloon_alert(usr, "绿色总量过高！（[green_value*100]%/[MODPAINT_MAX_SECTION_COLORS*100]%）")
				return
			else if(green_value < MODPAINT_MIN_SECTION_COLORS)
				balloon_alert(usr, "绿色总量过低！（[green_value*100]%/[MODPAINT_MIN_SECTION_COLORS*100]%）")
				return
			if(blue_value > MODPAINT_MAX_SECTION_COLORS)
				balloon_alert(usr, "蓝色总量过高！（[blue_value*100]%/[MODPAINT_MAX_SECTION_COLORS*100]%）")
				return
			else if(blue_value < MODPAINT_MIN_SECTION_COLORS)
				balloon_alert(usr, "蓝色总量过低！（[blue_value*100]%/[MODPAINT_MIN_SECTION_COLORS*100]%）")
				return
			for(var/color_value in total_colors)
				total_color_value += color_value
				if(color_value > MODPAINT_MAX_COLOR_VALUE)
					balloon_alert(usr, "颜色分量过高！（[color_value*100]%/[MODPAINT_MAX_COLOR_VALUE*100]%")
					return
				else if(color_value < MODPAINT_MIN_COLOR_VALUE)
					balloon_alert(usr, "颜色分量过低！（[color_value*100]%/[MODPAINT_MIN_COLOR_VALUE*100]%")
					return
			if(total_color_value > MODPAINT_MAX_OVERALL_COLORS)
				balloon_alert(usr, "颜色总量过高！（[total_color_value*100]%/[MODPAINT_MAX_OVERALL_COLORS*100]%）")
				return
			else if(total_color_value < MODPAINT_MIN_OVERALL_COLORS)
				balloon_alert(usr, "颜色总量过低！（[total_color_value*100]%/[MODPAINT_MIN_OVERALL_COLORS*100]%）")
				return
			editing_mod.set_mod_color(current_color)
			SStgui.close_uis(src)

/obj/item/mod/paint/proc/paint_skin(obj/item/mod/control/mod, mob/user)
	if(length(mod.theme.variants) <= 1)
		balloon_alert(user, "没有可替换的外观！")
		return
	var/list/skins = list()
	for(var/mod_skin_name in mod.theme.variants)
		var/list/mod_skin = mod.theme.variants[mod_skin_name]
		skins[mod_skin_name] = image(icon = mod_skin[MOD_ICON_OVERRIDE] || mod.icon, icon_state = "[mod_skin_name]-control")
	var/pick = show_radial_menu(user, mod, skins, custom_check = CALLBACK(src, PROC_REF(check_menu), mod, user), require_near = TRUE)
	if(!pick)
		balloon_alert(user, "未选择外观！")
		return
	mod.theme.set_skin(mod, pick)

/obj/item/mod/paint/proc/check_menu(obj/item/mod/control/mod, mob/user)
	if(user.incapacitated || !user.is_holding(src) || !mod || mod.active || mod.activating)
		return FALSE
	return TRUE

#undef MODPAINT_MAX_COLOR_VALUE
#undef MODPAINT_MIN_COLOR_VALUE
#undef MODPAINT_MAX_SECTION_COLORS
#undef MODPAINT_MIN_SECTION_COLORS
#undef MODPAINT_MAX_OVERALL_COLORS
#undef MODPAINT_MIN_OVERALL_COLORS

/obj/item/mod/skin_applier
	name = "MOD 外观涂装器"
	desc = "这种一次性外观涂装器可为特定类型的 MOD 模块化外骨骼添加一款外观。必须用于未启动的控制单元。"
	icon = 'icons/obj/clothing/modsuit/mod_construction.dmi'
	icon_state = "skinapplier"
	var/skin = "civilian"

/obj/item/mod/skin_applier/Initialize(mapload)
	. = ..()
	name = "MOD [skin] 外观涂装器"

/obj/item/mod/skin_applier/interact_with_atom(atom/attacked_atom, mob/living/user, params)
	if(!istype(attacked_atom, /obj/item/mod/control))
		return NONE
	var/obj/item/mod/control/mod = attacked_atom
	if(mod.active || mod.activating)
		balloon_alert(user, "单元运行中！")
		return ITEM_INTERACT_BLOCKING
	if(!(skin in mod.theme.variants))
		balloon_alert(user, "外观与主题不符！")
		return ITEM_INTERACT_BLOCKING
	mod.theme.set_skin(mod, skin)
	balloon_alert(user, "外观已应用")
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/mod/skin_applier/honkerative
	desc = /obj/item/mod/skin_applier::desc + " 此外，这套工具还会尝试安装一个摇摆模块。洪克！"
	skin = "honkerative"

/obj/item/mod/skin_applier/honkerative/interact_with_atom(obj/item/mod/control/controlunit, mob/living/user, params)
	. = ..()
	if(!(. & ITEM_INTERACT_SUCCESS))
		return
	controlunit.install(new /obj/item/mod/module/waddle(get_turf(user)), user)
