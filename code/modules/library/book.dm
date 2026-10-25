/obj/item/book
	name = "书"
	desc = "翻开它，深吸书页的陈年墨香，学点新东西吧。"
	icon = 'icons/obj/service/library.dmi'
	icon_state ="book"
	worn_icon_state = "book"
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL  //upped to three because books are, y'know, pretty big. (and you could hide them inside eachother recursively forever)
	attack_verb_continuous = list("猛砸", "重击", "教育")
	attack_verb_simple = list("砸", "敲", "教导")
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/items/handling/book_drop.ogg'
	pickup_sound = 'sound/items/handling/book_pickup.ogg'
	/// Maximum icon state number
	var/maximum_book_state = 8
	/// Game time in 1/10th seconds
	var/due_date = 0
	/// false - Normal book, true - Should not be treated as normal book, unable to be copied, unable to be modified
	var/unique = FALSE
	/// Whether or not we have been carved out.
	var/carved = FALSE
	/// The typepath for the storage datum we use when carved out.
	var/carved_storage_type = /datum/storage/carved_book

	/// The initial title, for use in var editing and such
	var/starting_title
	/// The initial author, for use in var editing and such
	var/starting_author
	/// The initial bit of content, for use in var editing and such
	var/starting_content
	/// The packet of information that describes this book
	var/datum/book_info/book_data

/obj/item/book/Initialize(mapload)
	. = ..()
	book_data = new(starting_title, starting_author, starting_content)

	AddElement(/datum/element/falling_hazard, damage = 5, wound_bonus = 0, hardhat_safety = TRUE, crushes = FALSE, impact_sound = drop_sound)
	AddElement(/datum/element/burn_on_item_ignition)
	register_context()

/obj/item/book/examine(mob/user)
	. = ..()
	if(carved)
		. += span_notice("[src] 已被掏空。")

/obj/item/book/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	if(isnull(held_item))
		return NONE

	if(held_item == src)
		var/attack_self_context = get_attack_self_context(user)
		if(!attack_self_context)
			return NONE
		context[SCREENTIP_CONTEXT_LMB] = attack_self_context
		return CONTEXTUAL_SCREENTIP_SET

	if(IS_WRITING_UTENSIL(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "涂改"
		if(is_carving_tool(held_item))
			context[SCREENTIP_CONTEXT_RMB] = "掏空"
		return CONTEXTUAL_SCREENTIP_SET

	if(is_carving_tool(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "掏空"
		return CONTEXTUAL_SCREENTIP_SET
	return NONE

/// Gets the context to add for clicking the book inhand. Returns null if none.
/obj/item/book/proc/get_attack_self_context(mob/living/user)
	return "阅读"

/obj/item/book/ui_static_data(mob/user)
	var/list/data = list()
	data["author"] = book_data.get_author()
	data["title"] = book_data.get_title()
	data["content"] = book_data.get_content()
	return data

/obj/item/book/ui_interact(mob/living/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MarkdownViewer", name)
		ui.open()

/// Proc that handles sending the book information to the user, as well as some housekeeping stuff.
/obj/item/book/proc/display_content(mob/living/user)
	ui_interact(user)

/// Proc that checks if the user is capable of reading the book, for UI interactions and otherwise. Returns TRUE if they can, FALSE if they can't.
/obj/item/book/proc/can_read_book(mob/living/user)
	if(user.is_blind())
		to_chat(user, span_warning("你双目失明，什么都读不了！"))
		return FALSE

	if(!user.can_read(src))
		return FALSE

	if(carved)
		balloon_alert(user, "书已被掏空！")
		return FALSE

	if(!length(book_data.get_content()))
		balloon_alert(user, "书是空白的！")
		return FALSE

	return TRUE

/// Proc that adds the book to a list on the user's mind so we know what works of art they've been catching up on.
/obj/item/book/proc/credit_book_to_reader(mob/living/user)
	if(!isliving(user) || isnull(user.mind))
		return

	LAZYINITLIST(user.mind.book_titles_read)
	if(starting_title in user.mind.book_titles_read)
		return

	user.add_mood_event("book_nerd", /datum/mood_event/book_nerd)
	user.mind.book_titles_read[starting_title] = TRUE

/obj/item/book/attack_self(mob/user)
	if(!can_read_book(user))
		return

	playsound(user, 'sound/items/handling/paper_pickup.ogg', 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	user.visible_message(span_notice("[user] 翻开一本名为“[book_data.title]”的书，开始专心阅读。"))
	credit_book_to_reader(user)
	display_content(user)

/obj/item/book/proc/is_carving_tool(obj/item/tool)
	PRIVATE_PROC(TRUE)
	if(tool.get_sharpness() & SHARP_EDGED)
		return TRUE
	if(tool.tool_behaviour == TOOL_WIRECUTTER)
		return TRUE
	return FALSE

/// Checks for whether we can vandalize this book, to ensure we still can after each input.
/// Uses to_chat over balloon alerts to give more detailed information as to why.
/obj/item/book/proc/can_vandalize(mob/living/user, obj/item/tool)
	if(!user.can_perform_action(src) || !user.can_write(tool, TRUE))
		return FALSE
	if(user.is_blind())
		to_chat(user, span_warning("正当你试着在书上写字时，你突然觉得自己蠢透了！"))
		return FALSE
	if(unique)
		to_chat(user, span_warning("这些书页似乎不太吃墨！看来你没法修改它。"))
		return FALSE
	if(carved)
		to_chat(user, span_warning("这本书已被掏空！没有什么可涂改的了。"))
		return FALSE
	return TRUE

/obj/item/book/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	// Items can both be carving tools and writing utensils.
	// Because of this, we flip interaction priority on secondary.
	// This means pure writing utensils have writing as their primary action,
	// pure carving tools have carving as their primary action,
	// but items with both have primary write secondary carve.
	if(IS_WRITING_UTENSIL(tool))
		return writing_utensil_act(user, tool)
	if(is_carving_tool(tool))
		return carving_act(user, tool)
	return NONE

/obj/item/book/item_interaction_secondary(mob/living/user, obj/item/tool, list/modifiers)
	if(is_carving_tool(tool))
		return carving_act(user, tool)
	if(IS_WRITING_UTENSIL(tool))
		return writing_utensil_act(user, tool)
	return NONE

/// Called when user clicks on the book with a writing utensil. Attempts to vandalize the book.
/obj/item/book/proc/writing_utensil_act(mob/living/user, obj/item/tool)
	if(!can_vandalize(user, tool))
		return ITEM_INTERACT_BLOCKING

	var/choice = tgui_input_list(usr, "你想修改什么？", "书籍修改", list("标题", "内容", "作者", "取消"))
	if(isnull(choice))
		return ITEM_INTERACT_BLOCKING
	if(!can_vandalize(user, tool))
		return ITEM_INTERACT_BLOCKING

	switch(choice)
		if("标题")
			return vandalize_title(user, tool)
		if("内容")
			return vandalize_contents(user, tool)
		if("作者")
			return vandalize_author(user, tool)

	return NONE

/obj/item/book/proc/vandalize_title(mob/living/user, obj/item/tool)
	var/newtitle = reject_bad_text(tgui_input_text(user, "写入新的标题", "书籍标题", max_length = 30))
	if(!newtitle)
		balloon_alert(user, "输入无效！")
		return ITEM_INTERACT_BLOCKING
	if(length_char(newtitle) > 30)
		balloon_alert(user, "太长了！")
		return ITEM_INTERACT_BLOCKING
	if(!can_vandalize(user, tool))
		return ITEM_INTERACT_BLOCKING

	name = newtitle
	book_data.set_title(html_decode(newtitle)) //Don't want to double encode here
	playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
	return ITEM_INTERACT_SUCCESS

/obj/item/book/proc/vandalize_contents(mob/living/user, obj/item/tool)
	var/content = tgui_input_text(user, "写入书籍的内容（不允许使用 HTML）", "书籍内容", max_length = MAX_PAPER_LENGTH, multiline = TRUE)
	if(!content)
		balloon_alert(user, "输入无效！")
		return ITEM_INTERACT_BLOCKING
	if(!can_vandalize(user, tool))
		return ITEM_INTERACT_BLOCKING

	book_data.set_content(html_decode(content))
	playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
	return ITEM_INTERACT_SUCCESS

/obj/item/book/proc/vandalize_author(mob/living/user, obj/item/tool)
	var/author = tgui_input_text(user, "写入作者的姓名", "作者姓名", max_length = MAX_NAME_LEN)
	if(!author)
		balloon_alert(user, "输入无效！")
		return ITEM_INTERACT_BLOCKING
	if(!can_vandalize(user, tool))
		return ITEM_INTERACT_BLOCKING

	book_data.set_author(html_decode(author)) //Setting this encodes, don't want to double up
	playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
	return ITEM_INTERACT_SUCCESS

/// Called when user clicks on the book with a carving utensil. Attempts to carve the book.
/obj/item/book/proc/carving_act(mob/living/user, obj/item/tool)
	if(carved)
		balloon_alert(user, "已经掏空了！")
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "正在掏空……")
	if(!do_after(user, 3 SECONDS, target = src))
		balloon_alert(user, "被打断了！")
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "已掏空")
	playsound(src, 'sound/effects/cloth_rip.ogg', vol = 75, vary = TRUE)
	carve_out()
	return ITEM_INTERACT_SUCCESS

/// Handles setting everything a carved book needs.
/obj/item/book/proc/carve_out()
	carved = TRUE
	create_storage(storage_type = carved_storage_type)

/// Generates a random icon state for the book
/obj/item/book/proc/gen_random_icon_state()
	icon_state = "book[rand(1, maximum_book_state)]"

/// Base type for a book that opens a bespoke TUGI
/// Does not inherit from /obj/item/book because the only similarities between the two are the concept of "being a book"
/// When designing a UI book you can send a "play_flip_sound" act to play the page turn sound
/obj/item/tgui_book
	name = "书"
	desc = "想必就是那种新潮的电子书吧。"
	icon = 'icons/obj/service/library.dmi'
	icon_state ="book"
	worn_icon_state = "book"
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL  //upped to three because books are, y'know, pretty big. (and you could hide them inside eachother recursively forever)
	attack_verb_continuous = list("猛砸", "重击", "教育")
	attack_verb_simple = list("砸", "敲", "教导")
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/items/handling/book_drop.ogg'
	pickup_sound = 'sound/items/handling/book_pickup.ogg'
	/// The name of the UI to open
	var/ui_name

/obj/item/tgui_book/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, ui_name)
		ui.open()
		playsound(src, SFX_PAGE_TURN, 30, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/obj/item/tgui_book/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(action == "play_flip_sound")
		playsound(src, SFX_PAGE_TURN, 30, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/obj/item/tgui_book/manual/ui_state(mob/user)
	return GLOB.book_state

// For guides
/obj/item/tgui_book/manual
	abstract_type = /obj/item/tgui_book/manual

/// Asserts a field is present in a list, stack traces if not
#define ASSERT_DATA(data_list, data_field) \
	if(!data_list[data_field]) { stack_trace("[type] - [data_list["id"]] lacks [data_field] information!"); }

/obj/item/tgui_book/manual/dsm
	name = "\improper SDSM-35" // 35 was picked based on the current edition plus the average years between edition divided by 500
	desc = "太空精神障碍诊断与统计手册， \
		一本全面介绍所有已知精神障碍的著作。 \
		现已出到第 35 版——不过也早该更新了……"
	icon_state = "book8"
	ui_name = "DSMBook"

/obj/item/tgui_book/manual/dsm/ui_static_data(mob/user)
	var/list/data = list()

	var/static/list/trauma_info
	if(!trauma_info)
		trauma_info = list()

		var/list/blacklist = list()
		// phobias need some special handing thanks to all their funky types
		blacklist += typesof(/datum/brain_trauma/mild/phobia)

		for(var/datum/brain_trauma/trauma_type as anything in valid_subtypesof(/datum/brain_trauma) - blacklist)
			if(!trauma_type::known_trauma)
				continue

			var/list/trauma_data = list()
			trauma_data["full_name"] = trauma_type::name
			trauma_data["scan_name"] = trauma_type::scan_desc
			trauma_data["desc"] = trauma_type::desc
			trauma_data["symptoms"] = trauma_type::symptoms
			trauma_data["id"] = trauma_type
			trauma_info += list(trauma_data)

		for(var/datum/quirk/quirk_type as anything in valid_subtypesof(/datum/quirk))
			if(!(quirk_type::quirk_flags & QUIRK_TRAUMALIKE))
				continue

			var/list/trauma_data = list()
			trauma_data["full_name"] = quirk_type::name
			trauma_data["scan_name"] = LOWER_TEXT(quirk_type::name)
			trauma_data["desc"] = quirk_type::medical_record_text
			trauma_data["symptoms"] = quirk_type::medical_symptom_text
			trauma_data["id"] = quirk_type
			trauma_info += list(trauma_data)

		for(var/datum/addiction/addiction_type as anything in GLOB.addictions)
			var/list/trauma_data = list()
			trauma_data["full_name"] = "[capitalize(addiction_type::name)] 成瘾"
			trauma_data["scan_name"] = "[addiction_type::name]成瘾"
			trauma_data["desc"] = addiction_type::description
			trauma_data["symptoms"] = addiction_type::symptoms
			trauma_data["id"] = addiction_type
			trauma_info += list(trauma_data)

		for(var/phobia_type, phobia_name in GLOB.phobia_types)
			var/list/trauma_data = list()
			trauma_data["full_name"] = phobia_name
			trauma_data["scan_name"] = "[/datum/brain_trauma/mild/phobia::scan_desc]，涉及[phobia_type]"
			trauma_data["desc"] = "患者对[phobia_type]有不理性的恐惧。"
			trauma_data["symptoms"] = /datum/brain_trauma/mild/phobia::symptoms
			trauma_data["id"] = "[/datum/brain_trauma/mild/phobia]/[phobia_type]"
			trauma_info += list(trauma_data)

		// validate
		for(var/list/trauma_data as anything in trauma_info)
			// these are asserted to be present, no matter what
			ASSERT_DATA(trauma_data, "full_name")
			ASSERT_DATA(trauma_data, "scan_name")
			ASSERT_DATA(trauma_data, "id")
			// these start as null, so there is a chance they are missing
			if(!trauma_data["desc"])
				trauma_data["desc"] = "未记录描述——这是一个错误。请报告这项研究的缺失。"
				stack_trace("[type] - [trauma_data["id"]] lacks a description!")
			if(!trauma_data["symptoms"])
				trauma_data["symptoms"] = "未记录症状——这是一个错误。请报告这项研究的缺失。"
				stack_trace("[type] - [trauma_data["id"]] lacks symptom information!")

	data["traumas"] = trauma_info
	return data

/obj/item/tgui_book/manual/idc
	name = "\improper IDC-27" // 27 was picked based on the current edition plus the average years between edition divided by 500
	desc = "行星际疾病分类， \
		一本全面介绍所有已知疾病与病症的著作。 \
		现已出到第 27 版——不过也早该更新了……"
	icon_state = "book7"
	ui_name = "IDCBook"

/obj/item/tgui_book/manual/idc/ui_static_data(mob/user)
	var/list/data = list()

	var/static/list/disease_info
	if(!disease_info)
		disease_info = list()

		for(var/datum/disease/disease_type as anything in valid_subtypesof(/datum/disease))
			if(disease_type::visibility_flags & HIDDEN_BOOK)
				continue

			var/list/disease_data = list()
			disease_data["form"] = disease_type::form
			disease_data["agent"] = disease_type::agent
			disease_data["name"] = disease_type::name
			disease_data["desc"] = disease_type::desc
			disease_data["illness"] = "无"
			disease_data["spread_by"] = disease_type::spread_text || get_disease_spread_text(disease_type::spread_flags)
			disease_data["cured_by"] = disease_type::cure_text
			disease_data["id"] = disease_type
			disease_data["level"] = "无"
			disease_info += list(disease_data)

		for(var/datum/symptom/symptom_type as anything in valid_subtypesof(/datum/symptom))
			var/list/symptom_data = list()
			symptom_data["form"] = "症状"
			symptom_data["agent"] = "无"
			symptom_data["name"] = symptom_type::name
			symptom_data["desc"] = symptom_type::desc
			symptom_data["illness"] = symptom_type::illness
			symptom_data["spread_by"] = "无"
			symptom_data["cured_by"] = symptom_type::symptom_cure::name
			symptom_data["id"] = symptom_type
			symptom_data["level"] = "[symptom_type::level]"
			disease_info += list(symptom_data)

		var/list/advanced_virus_info = list(
			"form" = "病毒",
			"agent" = "微生物",
			"name" = "高级疾病",
			"desc" = "一个统称类别，用于收录那些过于复杂、无法完整记录的疾病。 \
				病毒学部门以对这些疾病进行生物工程改造而闻名，因此它们的危险性差异极大。 \
				这类疾病通常是多种症状的组合，每一种症状都在本书中单独收录。",
			"illness" = "无",
			"spread_by" = "因症状组合而异",
			"cured_by" = "因症状组合而异",
			"id" = /datum/disease/advance,
		)
		disease_info += list(advanced_virus_info)

		// validate
		for(var/list/disease_data as anything in disease_info)
			// these are asserted to be present, no matter what
			ASSERT_DATA(disease_data, "form")
			ASSERT_DATA(disease_data, "agent")
			ASSERT_DATA(disease_data, "name")
			ASSERT_DATA(disease_data, "spread_by")
			ASSERT_DATA(disease_data, "illness")
			ASSERT_DATA(disease_data, "id")
			// these start as null, so there is a chance they are missing
			if(!disease_data["desc"])
				disease_data["desc"] = "未记录描述——这是一个错误。请报告这项研究的缺失。"
				stack_trace("[type] - [disease_data["id"]] lacks a description!")
			if(!disease_data["cured_by"] && !ispath(disease_data["id"], /datum/symptom))
				disease_data["cured_by"] = "未知"
				stack_trace("[type] - [disease_data["id"]] lacks cure information!")

	data["diseases"] = disease_info
	return data

#undef ASSERT_DATA
