/datum/keybinding/movement/army_crawl
	hotkey_keys = list("K")
	name = "prone"
	full_name = "匍匐前进"
	description = "在短暂延迟后尽可能贴近地面趴下"
	keybind_signal = COMSIG_KB_MOVEMENT_ARMY_CRAWL_DOWN

/datum/keybinding/movement/army_crawl/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/crawler = user.mob
	if(istype(crawler, /mob/living/carbon))
		crawler.army_crawl()
