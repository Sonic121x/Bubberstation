/obj/structure/chalkboard
	name = "黑板"
	icon = 'modular_zubbers/icons/obj/structures/chalkboard.dmi'
	icon_state = "chalkboard"
	maptext_width = 64
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 20)
	//The text that is written on the chalkboard. Cleared when erased.
	var/written_text = ""
	//This is a Chalkboard.

/obj/structure/chalkboard/examine(mob/user)
	. = ..()
	. += "教授和老人用来讲课的板子。"
	if(written_text)
		. += "上面写着：\n"
		. += "[written_text]\n"
		. += "空手右键点击即可擦除。"

//We want people to be able to write on it, so a left click interaction.
/obj/structure/chalkboard/attackby(obj/item/attacking_item, mob/user)
	. = ..()
	//We begin by allowing our player to write on the chalkboard using the white crayon.
	if(istype(attacking_item, /obj/item/toy/crayon/white))
		if(length_char(written_text) < MAX_MESSAGE_LEN) //Check to see if the written text is too long before continuing
			var/input_message = tgui_input_text(user, "你想在黑板上写什么？", "上课时间！", max_length = CHAT_MESSAGE_MAX_LENGTH, multiline = TRUE)
			if(do_after(user, 5 SECONDS, target = src))
				written_text += "[input_message]\n"
				say(input_message, sanitize = FALSE)
				if(length_char(written_text))
					icon_state = "chalkboard_filled"
					update_appearance()
		else
			to_chat(user, span_warning("黑板上似乎没有空位了……"))
	else if(istype(attacking_item, /obj/item/toy/crayon/green)) //What are you, stupid?
		tgui_input_text(user, "你想在黑板上写什么？", "上课时间！", max_length = CHAT_MESSAGE_MAX_LENGTH, multiline = TRUE) //Fake them out.
		if(do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_warning("用绿色粉笔在绿色板子上写字可不是什么好主意。看来你需要白色蜡笔。笨蛋。"))
			if(ishuman(user))
				var/mob/living/carbon/human/idiot = user
				idiot.add_mood_event("chalkboard", /datum/mood_event/green_idiot)
	else to_chat(user, span_warning("看来你需要用白色蜡笔在上面写字。"))

/obj/structure/chalkboard/attack_hand_secondary(mob/user)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	to_chat(user, span_warning("你拿起板擦，开始擦黑板。"))
	if(!written_text)
		to_chat(user, span_warning("你拿起板擦，在黑板上拍了几下，但上面没有任何东西可擦。"))
		if(ishuman(user))
			var/mob/living/carbon/human/papper = user
			papper.add_mood_event("chalkboard", /datum/mood_event/cathartic_eraser)
	else if(do_after(user, 5 SECONDS, target = src))
		written_text = ""
		icon_state = "chalkboard"
		update_appearance()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/chalkboard/wrench_act_secondary(mob/living/user, obj/item/tool)
	if(obj_flags & NO_DEBRIS_AFTER_DECONSTRUCTION)
		return FALSE
	to_chat(user, span_notice("你开始拆解[src]……"))
	if(tool.use_tool(src, user, 4 SECONDS, volume=50))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		deconstruct()
	return ITEM_INTERACT_SUCCESS

/obj/structure/chalkboard/handle_deconstruct(disassembled = TRUE)
	. = ..()
	if(!(obj_flags & NO_DEBRIS_AFTER_DECONSTRUCTION))
		new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	qdel(src)

/datum/mood_event/cathartic_eraser
	description = "用板擦拍了几下黑板，感觉好了一点。"
	mood_change = 1
	timeout = 1 MINUTES

/datum/mood_event/green_idiot
	description = "我居然想用绿色蜡笔在绿色黑板上写字。感觉自己好蠢。"
	mood_change = -1
	timeout = 1 MINUTES
