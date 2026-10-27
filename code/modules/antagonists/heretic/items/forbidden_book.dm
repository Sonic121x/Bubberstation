// Ye old forbidden book, the Codex Cicatrix.
/obj/item/codex_cicatrix
	name = "疤痕法典"
	desc = "这本厚重的典籍满是晦涩的涂写与不可能存在的图解。\
		据传说，若能解读它，便可揭开世界之间帷幕的秘密。"
	icon = 'icons/obj/antags/eldritch.dmi'
	base_icon_state = "book"
	icon_state = "book"
	worn_icon_state = "book"
	w_class = WEIGHT_CLASS_SMALL
	/// Helps determine the icon state of this item when it's used on self.
	var/book_open = FALSE
	/// How fast we can drain influences
	var/drain_speed = 7.5 SECONDS
	/// How fast we can draw runes
	var/draw_speed = 15 SECONDS


/obj/item/codex_cicatrix/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/effect_remover, \
		success_feedback = "你移除了%THEEFFECT。", \
		tip_text = "清除符文", \
		on_clear_callback = CALLBACK(src, PROC_REF(after_clear_rune)), \
		effects_we_clear = list(/obj/effect/heretic_rune))

/// Callback for effect_remover component after a rune is deleted
/obj/item/codex_cicatrix/proc/after_clear_rune(obj/effect/target, mob/living/user)
	new /obj/effect/temp_visual/drawing_heretic_rune/fail(target.loc, target.greyscale_colors)

/obj/item/codex_cicatrix/examine(mob/user)
	. = ..()
	if(!IS_HERETIC(user))
		return

	. += span_notice("可用于轻触影响点，以获取额外的知识点数。")
	. += span_notice("也可用于轻松绘制或移除转化符文。")

/obj/item/codex_cicatrix/attack_self(mob/user, modifiers)
	. = ..()
	if(.)
		return

	if(book_open)
		return

	open_animation()
	update_weight_class(WEIGHT_CLASS_NORMAL)
	addtimer(CALLBACK(src, PROC_REF(close_book)), 30 SECONDS)

	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	var/datum/heretic_knowledge/spell/basic/grasp_knowledge = heretic_datum.get_knowledge(__IMPLIED_TYPE__)
	grasp_knowledge?.add_charges(ceil(grasp_knowledge.max_charges * 0.5))

/obj/item/codex_cicatrix/proc/close_book()
	close_animation()
	update_weight_class(WEIGHT_CLASS_SMALL)

/obj/item/codex_cicatrix/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	if(!heretic_datum)
		return NONE
	if(isopenturf(interacting_with))
		var/obj/effect/heretic_influence/influence = locate(/obj/effect/heretic_influence) in interacting_with
		if(!influence?.drain_influence_with_codex(user, src))
			heretic_datum.try_draw_rune(user, interacting_with, drawing_time = draw_speed)
		return ITEM_INTERACT_BLOCKING
	return NONE

/// Plays a little animation that shows the book opening and closing.
/obj/item/codex_cicatrix/proc/open_animation()
	icon_state = "[base_icon_state]_open"
	flick("[base_icon_state]_opening", src)
	book_open = TRUE

/// Plays a closing animation and resets the icon state.
/obj/item/codex_cicatrix/proc/close_animation()
	icon_state = base_icon_state
	flick("[base_icon_state]_closing", src)
	book_open = FALSE

// Upgraded version of the codex cicatrix that allows us to cast curses
/obj/item/codex_cicatrix/morbus // I'm morbing all over
	name = "疫病法典"
	desc = "一本丑陋破烂的书，封面布满各自独立眨动的眼睛，全都盯着你。你完全不知道怎么拿这东西，说实话你也不确定自己是否想拿。"
	base_icon_state = "book_morbus"
	icon_state = "book_morbus"
	drain_speed = 5 SECONDS
	draw_speed = 10 SECONDS
	/// List of mobs we've cursed with transmutation. When the codex is destroyed all those curses become undone
	var/list/transmuted_victims = list()

/obj/item/codex_cicatrix/morbus/examine(mob/user)
	. = ..()
	if(IS_HERETIC(user))
		. += span_info("副手拿着血液并右键点击符文，即可施放诅咒。")
		return
	. += span_danger("那些眼睛停止了眨动。它们盯着你。它们的目光灼烧着……")
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	to_chat(human_user, span_userdanger("当你凝视这些书页时，你的心智在燃烧！"))
	human_user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 10, 190)
	human_user.add_mood_event("gates_of_mansus", /datum/mood_event/gates_of_mansus)

/obj/item/codex_cicatrix/morbus/examine_more(mob/user)
	. = ..() // XANTODO - Add a summary of each curse to the description so that the curser knows what will happen the cursee

/obj/item/codex_cicatrix/morbus/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /obj/effect/heretic_rune/big))
		return NONE

	var/list/curse_list = list()
	for(var/datum/heretic_knowledge/curse/curses as anything in subtypesof(/datum/heretic_knowledge/curse))
		curse_list[curses.name] = curses
	// BUBBER EDIT ADDITION BEGIN - blacklist certain ones
	curse_list -= "Curse of Transmutation" // can just kill ppl with certain species :(
	// BUBBER EDIT ADDITION END
	var/selected_curse = tgui_input_list(user, "施放任意诅咒", "选择一种诅咒！", curse_list, timeout = 0)
	if(!selected_curse)
		return NONE

	if(!user.Adjacent(interacting_with))
		return NONE

	var/atom/held_offhand = user.get_inactive_held_item()
	if(!held_offhand)
		user.balloon_alert(user, "没有催化剂！")
		return
	var/blood_samples = list()
	for(var/blood in GET_ATOM_BLOOD_DNA(held_offhand))
		blood_samples[blood] = 1
	for(var/datum/reagent/blood/usable_reagent as anything in held_offhand.reagents?.reagent_list)
		if(!istype(usable_reagent, /datum/reagent/blood))
			continue
		blood_samples += usable_reagent.data[BLOOD_DATA_DNA]
	if(isnull(blood_samples))
		user.balloon_alert(user, "没有血液！")
		return ITEM_INTERACT_BLOCKING

	var/curse_type = curse_list[selected_curse]
	var/datum/heretic_knowledge/curse/to_cast = new curse_type
	to_cast.recipe_snowflake_check(user, list(held_offhand), loc = get_turf(user))
	to_cast.on_finished_recipe(user, list(src, held_offhand), loc = get_turf(user))
	return ITEM_INTERACT_SUCCESS

/obj/item/codex_cicatrix/morbus/atom_destruction(damage_flag)
	for(var/datum/weakref/to_uncurse_ref as anything in transmuted_victims)
		var/mob/to_uncurse = to_uncurse_ref.resolve()
		if(!to_uncurse || !ismob(to_uncurse))
			continue
		var/datum/heretic_knowledge/curse/transmutation/to_undo = new()
		to_undo.uncurse(to_uncurse)
		transmuted_victims -= to_uncurse_ref
	return ..()
