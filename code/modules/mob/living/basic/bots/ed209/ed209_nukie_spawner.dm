/obj/item/antag_spawner/nuke_ops/ed209_nukie
	name = "辛迪加 ED209 机器人"
	desc = "一座一次性信标，用于迅速将增援特工投送到战场上。"


/obj/item/antag_spawner/nuke_ops/ed209_nukie/attack_self(mob/user)
	if(!(check_usability(user)))
		return

	to_chat(user, span_notice("你激活了 [src]，等待确认。"))
	drop_bot()
	do_sparks(4, TRUE, src)
	qdel(src)

/obj/item/antag_spawner/nuke_ops/ed209_nukie/proc/drop_bot()
	var/mob/living/basic/bot/secbot/ed209/nukie/nuclear_bot = new()
	var/obj/structure/closet/supplypod/pod = setup_pod()
	nuclear_bot.forceMove(pod)
	new /obj/effect/pod_landingzone(spawn_location ? spawn_location : get_turf(src), pod)
