/**
 * Checks to see if the parent mob has `pref_to_check` enabled, returns `FALSE` if the pref cannot be found or is set to False, otherwise returns `TRUE`
 *
 * This proc should be used when checking direct one-time interactions where logging would be benefical.
 * If you don't need to use logging, please use the `read_preference` proc
 *
 * Arguments
 * * `pref_to_check` - The toggle preference that we want to check to make sure works.
 * * `mechanic_user` - The person using the erp mechanic on the parent mob?
 * * `used_item` - What item, if any, is being used on the parent mob?
 */
/mob/living/proc/check_erp_prefs(datum/preference/toggle/pref_to_check, mob/living/mechanic_user = null, obj/item/used_item = FALSE)
	if(!ispath(pref_to_check))
		return FALSE

	if(client?.prefs?.read_preference(pref_to_check))
		return TRUE // We are good to go!

	if(!client?.prefs || (mechanic_user == src))
		return FALSE // Clients are a fickle mistress, but also no need for any further checks if someone is doing it on themselves without the prefs to allow it.

	var/message_to_log = "[src] 在偏好设置禁用时被人尝试使用 ERP 机制"
	if(used_item)
		message_to_log = "在 [src] 的偏好设置禁用时，有人尝试对其使用 [used_item]"

	var/turf/parent_turf = get_turf(src)
	if(parent_turf)
		message_to_log += "，地点：[loc_name(parent_turf)]"

	if(mechanic_user)
		message_to_log += "，操作者：[mechanic_user]"

	log_message(message_to_log + ".", LOG_GAME)

	return FALSE


/// Checks the prefs of all mobs in `view()`. If there is a mob with the `pref_to_check` set to false, we return `FALSE` otherwise, we return `TRUE`
/mob/living/proc/check_prefs_in_view(datum/preference/toggle/pref_to_check)
	if(!ispath(pref_to_check))
		return FALSE

	var/no_viewer_with_false_prefs = TRUE
	for(var/mob/living/viewer in dview())
		if(!viewer?.client) // It doens't really matter if these people see it.
			continue

		if(!viewer.client.prefs) // Better safe than sorry
			no_viewer_with_false_prefs = FALSE
			continue

		if(viewer.client.prefs.read_preference(pref_to_check))
			continue

		no_viewer_with_false_prefs = FALSE

		viewer.log_message("[src] 使用了一个会检查视野内未开启 [pref_to_check] 者的机制，[viewer] 的该偏好处于禁用状态。", LOG_GAME)
		log_message("[src] 使用了一个会检查视野内未开启 [pref_to_check] 者的机制，[viewer] 的该偏好处于禁用状态。", LOG_GAME)

	return no_viewer_with_false_prefs
