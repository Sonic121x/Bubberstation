/// A datum holding a set of flags or minimum/maximum properties to decide which materials can be used in a design
/datum/material_requirement
	abstract_type = /datum/material_requirement
	/// Flags which materials need to have to pass
	var/required_flags = NONE
	/// Flags which materials need to not have in order to pass
	var/blacklisted_flags = NONE
	/// Minimum property values that materials need to have to pass
	var/list/property_minimums = null
	/// Maximum property values that materials need to have to pass
	var/list/property_maximums = null

/// Returns a string description of materials that'd fit this requirement
/datum/material_requirement/proc/get_description()
	var/list/flag_strings = list()
	for (var/flag in bitfield_to_list(required_flags))
		flag_strings += GLOB.material_flags_to_string[flag]
	for (var/flag in bitfield_to_list(blacklisted_flags))
		flag_strings += "非[GLOB.material_flags_to_string[flag]]"
	if (!length(property_minimums) && !length(property_maximums))
		return "[capitalize(english_list(flag_strings, and_text = "或"))]"

	var/list/prop_reqs = list()
	for (var/prop_id in (property_minimums || list()) | (property_maximums || list()))
		var/datum/material_property/property = SSmaterials.properties[prop_id]
		if (property_minimums && property_maximums && !isnull(property_minimums[prop_id]) && !isnull(property_maximums[prop_id]))
			prop_reqs += "[LOWER_TEXT(property.name)]介于[property_minimums[prop_id]]至[property_maximums[prop_id]]之间"
		else if (property_minimums && !isnull(property_minimums[prop_id]))
			prop_reqs += "[LOWER_TEXT(property.name)]不低于[property_minimums[prop_id]]"
		else
			prop_reqs += "[LOWER_TEXT(property.name)]不高于[property_maximums[prop_id]]"

	return "[capitalize(english_list(flag_strings, and_text = "或"))]，且[english_list(prop_reqs)]"

/datum/material_requirement/proc/valid_material(datum/material/material)
	if (required_flags && !(material.mat_flags & required_flags))
		return FALSE

	if (blacklisted_flags && (material.mat_flags & blacklisted_flags))
		return FALSE

	for (var/prop_id, min_val in property_minimums)
		if (material.get_property(prop_id) < min_val)
			return FALSE

	for (var/prop_id, max_val in property_maximums)
		if (material.get_property(prop_id) > max_val)
			return FALSE

	return TRUE

// Actual requirement datums
/datum/material_requirement/armor_material
	required_flags = ITEM_MATERIAL_CLASSES

/datum/material_requirement/solid_material
	blacklisted_flags = MATERIAL_CLASS_AMORPHOUS

/datum/material_requirement/rigid_material
	required_flags = MATERIAL_CLASS_RIGID
