//	This DMI holds our radial icons for the 'hide mutant parts' verb
#define HIDING_RADIAL_DMI 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/MOD_sprite_accessories/icons/radial.dmi'

/mob/living/carbon/human/Topic(href, href_list)
	. = ..()

	if(href_list["lookup_info"])
		switch(href_list["lookup_info"])
			if("genitals")
				var/list/line = list()
				for(var/genital in GLOB.possible_genitals)
					if(!dna.species.mutant_bodyparts[genital])
						continue
					var/datum/sprite_accessory/genital/G = SSaccessories.sprite_accessories[genital][dna.species.mutant_bodyparts[genital][MUTANT_INDEX_NAME]]
					if(!G)
						continue
					if(G.is_hidden(src))
						continue
					var/obj/item/organ/genital/ORG = get_organ_slot(G.associated_organ_slot)
					if(!ORG)
						continue
					line += ORG.get_description_string(G)
				if(length(line))
					to_chat(usr, span_notice("[jointext(line, "\n")]"))
			if("open_examine_panel")
				tgui.holder = src
				tgui.ui_interact(usr) //datum has a tgui component, here we open the window

/mob/living/carbon/human/species/vox
	race = /datum/species/vox

/mob/living/carbon/human/species/vox_primalis
	race = /datum/species/vox_primalis

/mob/living/carbon/human/species/synth
	race = /datum/species/synthetic

/mob/living/carbon/human/species/mammal
	race = /datum/species/mammal

/mob/living/carbon/human/species/vulpkanin
	race = /datum/species/vulpkanin

/mob/living/carbon/human/species/tajaran
	race = /datum/species/tajaran

/mob/living/carbon/human/species/unathi
	race = /datum/species/unathi

/mob/living/carbon/human/species/podweak
	race = /datum/species/pod/podweak

/mob/living/carbon/human/species/xeno
	race = /datum/species/xeno

/mob/living/carbon/human/species/dwarf
	race = /datum/species/dwarf

/mob/living/carbon/human/species/ghoul
	race = /datum/species/ghoul

/mob/living/carbon/human/species/roundstartslime
	race = /datum/species/jelly/roundstartslime

/mob/living/carbon/human/species/teshari
	race = /datum/species/teshari

/mob/living/carbon/human/species/akula
	race = /datum/species/akula

/mob/living/carbon/human/species/skrell
	race = /datum/species/skrell

/mob/living/carbon/human/species/serpentid
	race = /datum/species/gas

GAME_VERB_DESC(/mob/living/carbon/human, toggle_undies, "切换内衣可见性", "允许你切换哪些内衣应当显示或隐藏。内衣会遮挡生殖器。", "IC")
	if(IS_UNCONSCIOUS_OR_CRIT(src))
		to_chat(usr, span_warning("你现在无法切换内衣可见性……"))
		return

	var/underwear_button = underwear_visibility & UNDERWEAR_HIDE_UNDIES ? "显示内衣" : "隐藏内衣"
	var/undershirt_button = underwear_visibility & UNDERWEAR_HIDE_SHIRT ? "显示上衣" : "隐藏上衣"
	var/socks_button = underwear_visibility & UNDERWEAR_HIDE_SOCKS ? "显示袜子" : "隐藏袜子"
	var/bra_button = underwear_visibility & UNDERWEAR_HIDE_BRA ? "显示胸罩" : "隐藏胸罩"
	var/list/choice_list = list("[underwear_button]" = "underwear", "[bra_button]" = "bra", "[undershirt_button]" = "shirt", "[socks_button]" = "socks","全部显示" = "show", "全部隐藏" = "hide")
	var/picked_visibility = input(src, "选择可见性设置", "显示/隐藏内衣") as null|anything in choice_list
	if(picked_visibility)
		var/picked_choice = choice_list[picked_visibility]
		switch(picked_choice)
			if("underwear")
				underwear_visibility ^= UNDERWEAR_HIDE_UNDIES
			if("bra")
				underwear_visibility ^= UNDERWEAR_HIDE_BRA
			if("shirt")
				underwear_visibility ^= UNDERWEAR_HIDE_SHIRT
			if("socks")
				underwear_visibility ^= UNDERWEAR_HIDE_SOCKS
			if("show")
				underwear_visibility = NONE
			if("hide")
				underwear_visibility = UNDERWEAR_HIDE_UNDIES | UNDERWEAR_HIDE_SHIRT | UNDERWEAR_HIDE_SOCKS | UNDERWEAR_HIDE_BRA
		update_body()
		SEND_SIGNAL(src, COMSIG_HUMAN_TOGGLE_UNDERWEAR, picked_choice)
	return

/mob/living/carbon/human/revive(full_heal_flags = NONE, excess_healing = 0, force_grab_ghost = FALSE)
	. = ..()
	if(.)
		if(dna && dna.species)
			dna.species.spec_revival(src)

GAME_VERB_DESC(/mob/living/carbon/human, toggle_mutant_part_visibility, "显示/隐藏变异部位", "允许你选择尝试用衣物遮盖你的变异身体部位。", "IC")
	mutant_part_visibility()

/mob/living/carbon/human/proc/mutant_part_visibility(quick_toggle, re_do)
	// The parts our particular user can choose
	var/list/available_selection
	// The total list of parts choosable
	var/static/list/total_selection = list(
		ORGAN_SLOT_EXTERNAL_HORNS = "horns",
		ORGAN_SLOT_EARS = "ears",
		ORGAN_SLOT_EXTERNAL_WINGS = "wings",
		ORGAN_SLOT_EXTERNAL_TAIL = "tail",
		ORGAN_SLOT_EXTERNAL_SYNTH_ANTENNA = "ipc_antenna",
		ORGAN_SLOT_EXTERNAL_ANTENNAE = "moth_antennae",
		ORGAN_SLOT_EXTERNAL_XENODORSAL = "xenodorsal",
		ORGAN_SLOT_EXTERNAL_SPINES = "spines",
	)

	// Stat check
	if(IS_UNCONSCIOUS_OR_CRIT(usr))
		to_chat(usr, span_warning("你现在无法这样做……"))
		return

	// Only show the 'reveal all' button if we are already hiding something
	if(try_hide_mutant_parts)
		LAZYOR(available_selection, "reveal all")
	// Lets build our parts list
	for(var/organ_slot in total_selection)
		if(get_organ_slot(organ_slot))
			LAZYOR(available_selection, total_selection[organ_slot])

	// If this proc is called with the 'quick_toggle' flag, we skip the rest
	if(quick_toggle)
		if("reveal all" in available_selection)
			LAZYNULL(try_hide_mutant_parts)
		else
			for(var/part in available_selection)
				LAZYOR(try_hide_mutant_parts, part)
		update_body_parts()
		return

	// Dont open the radial automatically just for one button
	if(re_do && (length(available_selection) == 1))
		return
	// If 'reveal all' is our only option just do it
	if(!re_do && (("reveal all" in available_selection) && (length(available_selection) == 1)))
		LAZYNULL(try_hide_mutant_parts)
		update_body_parts()
		return

	// Radial rendering
	var/list/choices = list()
	for(var/choice in available_selection)
		var/datum/radial_menu_choice/option = new
		var/image/part_image = image(icon = HIDING_RADIAL_DMI, icon_state = choice)

		option.image = part_image
		if(choice in try_hide_mutant_parts)
			part_image.underlays += image(icon = HIDING_RADIAL_DMI, icon_state = "module_unable")
		choices[choice] = option
	// Radial choices
	sort_list(choices)
	var/pick = show_radial_menu(usr, src, choices, custom_check = FALSE, tooltips = TRUE)
	if(!pick)
		return

	// Choice to action
	if(pick == "reveal all")
		to_chat(usr, span_notice("你不再试图隐藏你的变异部位。"))
		LAZYNULL(try_hide_mutant_parts)
		update_body_parts()
		return

	else if(pick in try_hide_mutant_parts)
		to_chat(usr, span_notice("你不再试图隐藏你的 [pick]。"))
		LAZYREMOVE(try_hide_mutant_parts, pick)
	else
		to_chat(usr, span_notice("你现在试图隐藏你的 [pick]。"))
		LAZYOR(try_hide_mutant_parts, pick)
	update_body_parts()
	// automatically re-do the menu after making a selection
	mutant_part_visibility(re_do = TRUE)

// Feign impairment verb
#define DEFAULT_TIME 30
#define MAX_TIME 36000 // 10 hours

GAME_VERB_DESC(/mob/living/carbon/human, acting, "假装失能", "假装失能一段时间。", "IC")
	if(IS_UNCONSCIOUS_OR_CRIT(usr))
		to_chat(usr, span_warning("你现在无法这样做……"))
		return

	var/static/list/choices = list("醉酒", "口吃", "抽搐")
	var/impairment = tgui_input_list(src, "选择要表演的失能状态：", "失能状态", choices)
	if(!impairment)
		return

	var/duration = tgui_input_number(src, "你想假装 [impairment] 多久？", "持续时间（秒）", DEFAULT_TIME, MAX_TIME)
	switch(impairment)
		if("醉酒")
			var/mob/living/living_user = usr
			if(istype(living_user))
				living_user.add_mood_event("drunk", /datum/mood_event/drunk)
			set_slurring_if_lower(duration SECONDS)
		if("口吃")
			set_stutter_if_lower(duration SECONDS)
		if("抽搐")
			set_jitter_if_lower(duration SECONDS)

	if(duration)
		addtimer(CALLBACK(src, PROC_REF(acting_expiry), impairment), duration SECONDS)
		to_chat(src, "你现在正在假装 [impairment]。")

/mob/living/carbon/human/proc/acting_expiry(impairment)
	if(impairment)
		// Procs when fake impairment duration ends, useful for calling extra events to wrap up too
		if(impairment == "醉酒")
			var/mob/living/living_user = usr
			if(istype(living_user))
				living_user.clear_mood_event("drunk")
		// Notify the user
		to_chat(src, "你不再假装 [impairment] 了。")

#undef DEFAULT_TIME
#undef MAX_TIME
#undef HIDING_RADIAL_DMI
