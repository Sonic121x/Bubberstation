/obj/effect/spawner/xeno_egg_delivery
	name = "xeno egg delivery"
	icon = 'icons/mob/nonhuman-player/alien.dmi'
	icon_state = "egg_growing"

/obj/effect/spawner/xeno_egg_delivery/Initialize(mapload)
	. = ..()
	var/turf/spawn_turf = get_turf(src)
	new /obj/structure/alien/egg/delivery(spawn_turf)
	new /obj/effect/temp_visual/gravpush(spawn_turf)
	playsound(spawn_turf, 'sound/items/party_horn.ogg', 50, TRUE, -1)
	if(SSticker.HasRoundStarted())
		return

	message_admins("一枚异形卵已送达[ADMIN_VERBOSEJMP(spawn_turf)]。")
	log_game("An alien egg has been delivered to [AREACOORD(spawn_turf)]")

	var/datum/command_footnote/footnote = new()
	footnote.message = "我们已将一份研究样本交由贵站船员保管，位于[get_area(src)]。\
		处理样本时请务必遵守所有安全防范措施。"
	footnote.signature = "中央指挥部"

	GLOB.communications_controller.command_report_footnotes += footnote

/obj/structure/alien/egg/delivery
	name = "异种生物卵样本"
	desc = "一枚巨大的斑驳卵，是上级异种生物研究计划送来的样本。请小心处理！"
	max_integrity = 300

/obj/structure/alien/egg/delivery/Initialize(mapload)
	. = ..()

	GLOB.communications_controller.xenomorph_egg_delivered = TRUE
	GLOB.communications_controller.captivity_area = get_area(src)
