/atom
	/// If non-null, overrides a/an/some in all cases
	var/article
	/// Text that appears preceding the name in [/atom/proc/examine_title]
	var/examine_thats = "这是"

/**
 * Called when a mob examines this atom: [/mob/verb/examinate]
 *
 * Default behaviour is to get the name and icon of the object and its reagents where
 * the [TRANSPARENT] flag is set on the reagents holder
 *
 * Produces a signal [COMSIG_ATOM_EXAMINE], for modifying the list returned from this proc
 */
/atom/proc/examine(mob/user)
	. = list()
	. += get_name_chaser(user)
	if(desc)
		. += "<i>[desc]</i>"

	var/list/tags_list = examine_tags(user)
	var/list/post_descriptor = examine_post_descriptor(user)
	var/post_desc_string = length(post_descriptor) ? " [jointext(post_descriptor, " ")]" : ""
	if (length(tags_list))
		var/tag_string = list()
		for (var/atom_tag in tags_list)
			tag_string += (isnull(tags_list[atom_tag]) ? chinese_atom_tag_display(atom_tag) : span_tooltip(tags_list[atom_tag], chinese_atom_tag_display(atom_tag)))
		// some regex to ensure that we don't add another "and" if the final element's main text (not tooltip) has one
		tag_string = english_list(tag_string, and_text = (findtext(tag_string[length(tag_string)], regex(@">.*?and .*?<"))) ? " " : "和")
		. += "这是一件[tag_string]的[chinese_atom_tag_display(examine_descriptor(user))][post_desc_string]。"
	else if(post_desc_string)
		. += "这是一件[chinese_atom_tag_display(examine_descriptor(user))][post_desc_string]。"

	if(reagents)
		var/user_sees_reagents = user.can_see_reagents()
		var/reagent_sigreturn = SEND_SIGNAL(src, COMSIG_ATOM_REAGENT_EXAMINE, user, ., user_sees_reagents)
		if(!(reagent_sigreturn & STOP_GENERIC_REAGENT_EXAMINE))
			if(reagents.flags & TRANSPARENT)
				if(reagents.total_volume)
					. += "其中装有<b>[reagents.total_volume]</b>单位的各类试剂[user_sees_reagents ? "：" : "。"]"
					if(user_sees_reagents || (reagent_sigreturn & ALLOW_GENERIC_REAGENT_EXAMINE)) //Show each individual reagent for detailed examination
						for(var/datum/reagent/current_reagent as anything in reagents.reagent_list)
							. += "&bull; [round(current_reagent.volume, CHEMICAL_VOLUME_ROUNDING)]单位[current_reagent.name]"
						if(reagents.is_reacting)
							. += span_warning("其中正在发生反应！")
						. += span_notice("溶液的 pH 值为[round(reagents.ph, 0.01)]，温度为[reagents.chem_temp] K。")
				else
					. += "其中装有：<br>无。"
			else if(reagents.flags & AMOUNT_VISIBLE)
				if(reagents.total_volume)
					. += span_notice("其中还剩[reagents.total_volume]单位。")
				else
					. += span_danger("它是空的。")

		if(HAS_TRAIT(user, TRAIT_KEEN_NOSE))
			var/sniff_text = get_sniff_examine(user)
			if(sniff_text)
				. += sniff_text

	SEND_SIGNAL(src, COMSIG_ATOM_EXAMINE, user, .)

/// Returns an examine string describing what the contents of this atom smell like
/atom/proc/get_sniff_examine(mob/living/carbon/sniffer)
	if(!istype(sniffer) || HAS_TRAIT(sniffer, TRAIT_ANOSMIA))
		return
	if(!is_open_container() || !reagents?.total_volume)
		return
	if(!sniffer.is_holding(src))
		return
	if(!sniffer.get_bodypart(BODY_ZONE_HEAD)) // Need a nose to smell
		return
	if(sniffer.is_mouth_covered())
		return span_warning("脸被遮住时，你无法闻到[src]的气味。")

	var/smell_message = generate_reagents_taste_message(reagents.reagent_list, sniffer, 10)
	return span_notice("你闻了闻[src]，气味像[smell_message]。")

/**
 * A list of "tags" displayed after atom's description in examine.
 * This should return an assoc list of tags -> tooltips for them. If item is null, then no tooltip is assigned.
 *
 * * TGUI tooltips (not the main text) in chat cannot use HTML stuff at all, so
 * trying something like `<b><big>ffff</big></b>` will not work for tooltips.
 *
 * For example:
 * ```byond
 * . = list()
 * .["small"] = "It is a small item."
 * .["fireproof"] = "It is made of fire-retardant materials."
 * .["and conductive"] = "It's made of conductive materials and whatnot. Blah blah blah." // having "and " in the end tag's main text/key works too!
 * ```
 * will result in
 *
 * It is a *small*, *fireproof* *and conductive* item.
 *
 * where "item" is pulled from [/atom/proc/examine_descriptor]
 */
/atom/proc/examine_tags(mob/user)
	. = list()
	if(abstract_type == type)
		.[span_hypnophrase("abstract")] = "这是一个抽象概念，你应该向名叫 GITHUB 的神秘存在报告此事！"

	if(resistance_flags & INDESTRUCTIBLE)
		.["indestructible"] = "它极其坚固！大概能承受任何打击！"
	else
		if(resistance_flags & LAVA_PROOF)
			.["lava-proof"] = "它由极其耐热的材料制成，大概能抵御熔岩！"
		if(resistance_flags & (ACID_PROOF | UNACIDABLE))
			.["acid-proof"] = "它看起来相当坚固！大概能抵御酸液！"
		if(resistance_flags & FREEZE_PROOF)
			.["freeze-proof"] = "它由耐寒材料制成。"
		if(resistance_flags & FIRE_PROOF)
			.["fire-proof"] = "它由阻燃材料制成。"
		if(resistance_flags & SHUTTLE_CRUSH_PROOF)
			.["crush-proof"] = "它极其结实，应该能承受穿梭机的碾压！"
		if(resistance_flags & BOMB_PROOF)
			.["bomb-proof"] = "它看起来能经受住爆炸！"
		if(resistance_flags & FLAMMABLE)
			.["flammable"] = "它看起来很容易着火。"

	if(flags_1 & HOLOGRAM_1)
		.["holographic"] = "它看起来是个全息影像。"

	SEND_SIGNAL(src, COMSIG_ATOM_EXAMINE_TAGS, user, .)

/// What this atom should be called in examine tags
/atom/proc/examine_descriptor(mob/user)
	return "物体"

/// Returns a list of strings to be displayed after the descriptor
/atom/proc/examine_post_descriptor(mob/user)
	. = list()
	if(!custom_materials)
		return
	var/mats_list = list()
	for(var/custom_material in custom_materials)
		var/datum/material/current_material = SSmaterials.get_material(custom_material)
		mats_list += span_tooltip("它由[chinese_material_display(current_material.name)]制成。", chinese_material_display(current_material.name))
	. += "，由[english_list(mats_list)]制成"

/**
 * Called when a mob examines (shift click or verb) this atom twice (or more) within EXAMINE_MORE_WINDOW (default 1 second)
 *
 * This is where you can put extra information on something that may be superfluous or not important in critical gameplay
 * moments, while allowing people to manually double-examine to take a closer look
 *
 * Produces a signal [COMSIG_ATOM_EXAMINE_MORE]
 */
/atom/proc/examine_more(mob/user)
	SHOULD_CALL_PARENT(TRUE)
	RETURN_TYPE(/list)

	. = list()
	SEND_SIGNAL(src, COMSIG_ATOM_EXAMINE_MORE, user, .)
	SEND_SIGNAL(user, COMSIG_MOB_EXAMINING_MORE, src, .)

	if (!length(custom_materials) || (material_flags & MATERIAL_NO_DESCRIPTORS) || !HAS_TRAIT(user, TRAIT_RESEARCH_SCANNER))
		return

	for (var/datum/material/material as anything in custom_materials)
		var/list/material_string = list()
		for (var/prop_id in material.mat_properties)
			var/datum/material_property/property = SSmaterials.properties[prop_id]
			var/prop_value = material.get_property(prop_id)
			if (isnull(prop_value)) // Error?
				continue
			var/descriptor = property?.get_descriptor(prop_value)
			var/tooltip_hint = property?.get_tooltip(prop_value)
			if (descriptor) // Overriden derivative property?
				material_string += span_tooltip("[property]: [tooltip_hint]", descriptor)

		if (length(material_string))
			. += span_info("[chinese_material_display(material.name)]具有以下特性：[english_list(material_string)]。")

/**
 * Get the name of this object for examine
 *
 * You can override what is returned from this proc by registering to listen for the
 * [COMSIG_ATOM_GET_EXAMINE_NAME] signal
 */
/atom/proc/get_examine_name(mob/user)
	var/list/override = list(article, null, "<em>[get_visible_name()]</em>")
	SEND_SIGNAL(src, COMSIG_ATOM_GET_EXAMINE_NAME, user, override)

	if(!isnull(override[EXAMINE_POSITION_ARTICLE]))
		override -= null // IF there is no "before", don't try to join it
		return jointext(override, " ")
	if(!isnull(override[EXAMINE_POSITION_BEFORE]))
		override -= null // There is no article, don't try to join it
		return "\a [jointext(override, " ")]"
	return "\a [src]"

/mob/living/get_examine_name(mob/user)
	var/visible_name = get_visible_name()
	var/list/name_override = list(visible_name)
	if(SEND_SIGNAL(user, COMSIG_LIVING_PERCEIVE_EXAMINE_NAME, src, visible_name, name_override) & COMPONENT_EXAMINE_NAME_OVERRIDEN)
		return name_override[1]
	return visible_name

/// Icon displayed in examine
/atom/proc/get_examine_icon(mob/user)
	return icon2html(src, user)

/**
 * Formats the atom's name into a string for use in examine (as the "title" of the atom)
 *
 * * user - the mob examining the atom
 * * thats - whether to include "That's", or similar (mobs use "This is") before the name
 */
/atom/proc/examine_title(mob/user, thats = FALSE)
	var/examine_icon = get_examine_icon(user)
	return "[examine_icon ? "[examine_icon] " : ""][thats ? "[examine_thats] ":""]<em>[get_examine_name(user)]</em>"

/**
 * Returns an extended list of examine strings for any contained ID cards.
 *
 * Arguments:
 * * user - The user who is doing the examining.
 */
/atom/proc/get_id_examine_strings(mob/user)
	. = list()

///Used to insert text after the name but before the description in examine()
/atom/proc/get_name_chaser(mob/user, list/name_chaser = list())
	return name_chaser

/**
 * Used by mobs to determine the name for someone wearing a mask, or with a disfigured or missing face.
 * By default just returns the atom's name.
 *
 * * add_id_name - If TRUE, ID information such as honorifics or name (if mismatched) are appended
 * * force_real_name - If TRUE, will always return real_name and add (as face_name/id_name) if it doesn't match their appearance
 */
/atom/proc/get_visible_name(add_id_name = TRUE, force_real_name = FALSE)
	return name
