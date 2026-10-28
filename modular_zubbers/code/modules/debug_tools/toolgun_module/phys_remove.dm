/datum/phystool_mode/remove_mode
	name = "移除工具"
	desc = "使用左键将物体从世界中删除。"

/datum/phystool_mode/remove_mode/main_act(atom/target, mob/user)
	. = ..()
	if(isliving(target))
		var/mob/living/living_target = target
		if(living_target.client)
			user.balloon_alert(user, "里面有玩家！")
			return FALSE
	//Is there is somthing inside target.
	if(target.contents.len)
		for(var/atom/movable/important_thing in target.contents)
			if(!istype(important_thing))
				continue
			important_thing.forceMove(get_turf(target))
	qdel(target)
	return TRUE
