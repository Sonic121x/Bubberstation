/obj/effect/mob_spawn/ghost_role/drone/name_mob(mob/living/spawned_mob, forced_name)
	if(!forced_name)
		var/designation = pick(GLOB.posibrain_names)
		forced_name = "无人机（[designation]-[rand(100, 999)]）"

	return ..()
