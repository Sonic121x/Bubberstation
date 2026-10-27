GLOBAL_LIST_EMPTY(ash_rituals)

/obj/effect/ash_rune
	name = "灰烬符文"
	desc = "一个文明的遗存，它曾强大到足以驾驭奇异能量进行转化。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ash_ritual.dmi'
	icon_state = "rune"
	anchored = TRUE

	/// the current chosen ritual
	var/datum/ash_ritual/current_ritual = null

	/// List of connected side runes
	var/list/side_runes = list()

	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/effect/ash_rune/examine(mob/user)
	. = ..()
	if(!current_ritual)
		. += span_notice("<br>此时没有已选定的仪式——使用中央符文来选择仪式。")
		return
	. += span_notice("<br>当前仪式为：[current_ritual.name]")
	. += span_notice(current_ritual.desc)
	. += span_warning("<br>所需材料如下：")
	for(var/the_components in current_ritual.required_components)
		var/atom/component_name = current_ritual.required_components[the_components]
		. += span_warning("[the_components] 方位的材料为 [initial(component_name.name)]")

/obj/effect/ash_rune/Initialize(mapload)
	. = ..()
	// this is just to spawn the "aesthetic" runes around
	for(var/direction in GLOB.cardinals)
		var/obj/effect/side_rune/spawning_rune = new (get_step(src, direction))
		side_runes += spawning_rune
		spawning_rune.icon_state = "[initial(icon_state)]_[direction]"
		spawning_rune.connected_rune = src
	if(!length(GLOB.ash_rituals))
		generate_rituals()

/obj/effect/ash_rune/Destroy(force)
	for(var/obj/side_rune as anything in side_runes)
		qdel(side_rune)
	current_ritual = null
	. = ..()

/obj/effect/ash_rune/proc/generate_rituals()
	for(var/type in subtypesof(/datum/ash_ritual))
		var/datum/ash_ritual/spawned_ritual = new type
		GLOB.ash_rituals[spawned_ritual.name] = spawned_ritual

/obj/effect/ash_rune/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(current_ritual && is_species(user, /datum/species/lizard/ashwalker))
		current_ritual.ritual_start(src)
		return
	current_ritual = tgui_input_list(user, "选择要开始的仪式……", "仪式选择", GLOB.ash_rituals)
	if(!current_ritual)
		return
	current_ritual = GLOB.ash_rituals[current_ritual]
	balloon_alert_to_viewers("仪式已选定——检查中央符文以获取更多信息。")

// this is solely for aesthetics... though the central rune will check the directions, of which this is on
/obj/effect/side_rune
	desc = "这枚符文似乎带着某种诡异的吸力。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ash_ritual.dmi'
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	anchored = TRUE
	/// the central rune that this is connected to
	var/obj/effect/ash_rune/connected_rune

// just so that if you attack this, you actually attack the main rune
/obj/effect/side_rune/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(connected_rune)
		connected_rune.attack_hand(user, modifiers)

/obj/effect/side_rune/Destroy(force)
	if(connected_rune)
		connected_rune = null
	. = ..()
