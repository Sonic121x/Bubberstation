/// Previously, body types could only be used on non-binary characters.
/// PR #62733 changed this to allow all characters to use body type.
/// This migration moves binary-gendered characters over to the "use gender" body type
/// so that old characters are preserved.
/datum/preferences/proc/migrate_body_types(list/save_data)
	var/current_gender = save_data["gender"]
	if (current_gender == MALE || current_gender == FEMALE)
		save_data["body_type"] = "Use gender"

/// Previously, physiques only supported binary characters, so "Use gender" on a non-binary character played havoc due to all checks being binary (some checked for females others for males)
/// This caused inconsistencies when it was in play (male laughs and female screams)
/// Force non-binary characters to have a female physique
// TODO: Remove this entire migration if we ever add non-binary physiques
/datum/preferences/proc/migrate_gendered_nonbinary_physique(list/save_data)
	var/current_gender = save_data["gender"]
	if(current_gender == MALE || current_gender == FEMALE)
		return

	if(save_data["body_type"] != "Use gender")
		return

	save_data["body_type"] = FEMALE

	// spawn b/c we need this to run during init but can't immediately because parent may still be initializing
	spawn(1)
		tgui_alert(parent, "此前 [save_data["real_name"]] 的体格被设为 \"Use gender\"，但该角色为非二元性别。目前尚不存在非二元体格，因此该角色的体格已默认设为女性。", "体格迁移：[save_data["real_name"]]")
