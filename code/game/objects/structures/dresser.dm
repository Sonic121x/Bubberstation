//THIS FILE HAS BEEN EDITED BY SKYRAT EDIT

/obj/structure/dresser//SKYRAT EDIT - ICON OVERRIDDEN BY AESTHETICS - SEE MODULE
	name = "梳妆台"
	desc = "做工精良的木制梳妆台，里面塞满了各式内衣。"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "dresser"
	resistance_flags = FLAMMABLE
	density = TRUE
	anchored = TRUE
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 10)

/obj/structure/dresser/wrench_act(mob/living/user, obj/item/tool)
	to_chat(user, span_notice("你开始[anchored ? "松开" : "拧紧"] [src]。"))
	if(!tool.use_tool(src, user, 20, volume=50))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你成功[anchored ? "松开" : "拧紧"]了 [src]。"))
	set_anchored(!anchored)
	return ITEM_INTERACT_SUCCESS

/obj/structure/dresser/atom_deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)

/obj/structure/dresser/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!Adjacent(user))//no tele-grooming
		return
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/dressing_human = user
	if(HAS_TRAIT(dressing_human, TRAIT_NO_UNDERWEAR))
		to_chat(dressing_human, span_warning("你无法穿戴内衣。"))
		return

	var/choice = tgui_input_list(user, "内裤、胸罩、汗衫还是袜子？", "更换衣物", list("Underwear", "Underwear Color", "Bra", "Bra Color", "Undershirt", "Undershirt Color", "Socks", "Socks Color")) //SKYRAT EDIT ADDITION - Colorable Undershirt/Socks/Bra
	if(isnull(choice))
		return

	if(!Adjacent(user))
		return
	switch(choice)
		if("Underwear")
			var/new_undies = tgui_input_list(user, "选择你的内裤", "更换衣物", SSaccessories.underwear_list)
			if(new_undies)
				dressing_human.underwear = new_undies
		if("Underwear Color")
			var/new_underwear_color = tgui_color_picker(dressing_human, "选择你的内裤颜色", "内裤颜色", dressing_human.underwear_color)
			if(new_underwear_color)
				dressing_human.underwear_color = sanitize_hexcolor(new_underwear_color)
		if("Undershirt")
			var/new_undershirt = tgui_input_list(user, "选择你的汗衫", "更换衣物", SSaccessories.undershirt_list)
			if(new_undershirt)
				dressing_human.undershirt = new_undershirt
		if("Socks")
			var/new_socks = tgui_input_list(user, "选择你的袜子", "更换衣物", SSaccessories.socks_list)
			if(new_socks)
				dressing_human.socks = new_socks
		//SKYRAT EDIT ADDITION BEGIN - Colorable Undershirt/Socks/Bras
		if("Undershirt Color")
			var/new_undershirt_color = tgui_color_picker(dressing_human, "选择你的汗衫颜色", "汗衫颜色", dressing_human.undershirt_color) // BUBBERSTATION EDIT: TGUI COLOR PICKER
			if(new_undershirt_color)
				dressing_human.undershirt_color = sanitize_hexcolor(new_undershirt_color)
		if("Socks Color")
			var/new_socks_color = tgui_color_picker(dressing_human, "选择你的袜子颜色", "袜子颜色", dressing_human.socks_color) // BUBBERSTATION EDIT: TGUI COLOR PICKER
			if(new_socks_color)
				dressing_human.socks_color = sanitize_hexcolor(new_socks_color)

		if("Bra")
			var/new_bra = tgui_input_list(user, "选择你的胸罩", "更换衣物", SSaccessories.bra_list)
			if(new_bra)
				dressing_human.bra = new_bra

		if("Bra Color")
			var/new_bra_color = tgui_color_picker(dressing_human, "选择你的胸罩颜色", "胸罩颜色", dressing_human.bra_color) // BUBBERSTATION EDIT: TGUI COLOR PICKER
			if(new_bra_color)
				dressing_human.bra_color = sanitize_hexcolor(new_bra_color)

		//SKYRAT EDIT ADDITION END - Colorable Undershirt/Socks/Bras

	add_fingerprint(dressing_human)
	dressing_human.update_body()
