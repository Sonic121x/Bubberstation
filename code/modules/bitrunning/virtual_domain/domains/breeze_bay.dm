/datum/lazy_template/virtual_domain/breeze_bay
	name = "微风湾"
	desc = "一座临海小镇，北面是一片广袤的森林。"
	help_text = "很简单！晒晒太阳，钓钓鱼，好好享受一番！不过别被螃蟹咬了。"
	key = "breeze_bay"
	map_name = "breeze_bay"
	reward_points = BITRUNNER_REWARD_LOW
	domain_flags = DOMAIN_NO_NOHIT_BONUS

/datum/lazy_template/virtual_domain/breeze_bay/setup_domain(list/created_atoms)
	. = ..()

	for(var/obj/item/fishing_rod/rod in created_atoms)
		RegisterSignal(rod, COMSIG_FISHING_ROD_CAUGHT_FISH, PROC_REF(on_fish_caught))

/// Eventually reveal the cache
/datum/lazy_template/virtual_domain/breeze_bay/proc/on_fish_caught(datum/source, reward)
	SIGNAL_HANDLER

	if(isnull(reward))
		return

	add_points(2)
